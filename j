pipeline {
  agent any 
  tools {
    maven 'm3-2-5'
  }
  stages {
    stage ('Initialize') {
      steps {
        sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
            ''' 
      }
    }    
    stage ('Build & Deploy') {
      steps {
      sh 'sshpass -p Stellantis01 ssh devuser@10.109.137.30 " sudo docker run --rm -d  -p 8888:8080/tcp webgoat/webgoat-8.0:latest" '
      sh 'echo ################################'
      sh 'echo -- BROWSE -- http://10.109.137.30:8888/WebGoat'
      sh 'sshpass -p Stellantis01 ssh devuser@10.109.137.30 " docker run --rm -d  -p 3000:3000/tcp bkimminich/juice-shop:latest" '
      sh 'echo ################################'
      sh 'echo -- BROWSE -- http://10.109.137.30:3000/#/'
      } 
    }
    stage ('DAST Scan') {
      steps {
         sh 'sshpass -p Stellantis01 ssh devuser@10.109.137.30 "sudo docker exec c2406913789c52e3dc69b680b93f60dc97d64b825f0948f2afbe2a9c95a61678 bash /arachni/bin/./arachni http://10.109.137.30:8888/WebGoat/ --timeout 10" '
         sh 'sshpass -p Stellantis01 ssh devuser@10.109.137.30 "sudo docker exec c2406913789c52e3dc69b680b93f60dc97d64b825f0948f2afbe2a9c95a61678 bash /arachni/bin/./arachni http://10.109.137.30:3000/#/ --timeout 10" '
         sh 'echo REPORTS SAVED in /arachni Folder'
        }
    }
  }
}
