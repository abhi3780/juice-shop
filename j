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
      sh 'sshpass -p Stellantis01 ssh devuser@10.109.137.30 " sudo docker run --rm -p 3001:3000 bkimminich/juice-shop" '
      sh 'echo -----'
       }
    }
   }
 }
