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
    stage ('Build') {
      steps {
      sh 'sshpass -p Stellantis01 ssh devuser@10.109.137.30 " sudo docker run --rm -d  -p 3001:3000/tcp bkimminich/juice-shop:latest" '
      sh 'echo -----'
      sh 'echo -- BROWSE -- http://10.109.137.30:3001/#/'
       }
    }
    stage ('DAST Scan') {
      steps {
         sh 'sshpass -p Stellantis01 ssh devuser@10.109.137.30 "sudo docker exec c2406913789c52e3dc69b680b93f60dc97d64b825f0948f2afbe2a9c95a61678 bash /arachni/bin/./arachni --checks=xss,sqli,path_traversal http://10.109.137.30:3001/#/" '
         sh 'echo REPORTS SAVED in /arachni Folder'
        }
    }
  }
}
