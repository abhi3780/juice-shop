node {
    def app

    stage('Clone Repository') {
        checkout scm
    } 
/*
    stage('Unit Test App') {
         sh 'node -v'
         sh 'npm prune'
         sh 'npm install'
         sh 'npm test'
         sh 'echo "Unit test completed"'     
    }
    stage('E2E Test') {         
        wrap([$class: 'Xvfb', autoDisplayName: true, 'timeout': 15]) {
            sh 'npm run protractor'
            sh 'echo "e2e test completed"'
        }  
        sh 'echo "e2e test completed"'
    }
*/
    stage('Application security testing') {      
        sh 'echo "Trying to run depedency check"'
	sh 'ls -l /home/ubuntu/dependency-check/bin/dependency-check.sh'
/*	sh '/home/ubuntu/dependency-check/bin/dependency-check.sh --project "Juice Shop" --scan . --format HTML' */
        step([$class: 'DependencyCheckPublisher', unstableTotalAll: '0'])
    }
/*
    stage('Build Docker Image') {
        app = docker.build("helsinkiowasp/juice-shop")        
        sh 'echo "Docker Image completed"'
    }
    stage('Push Docker Image') {
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.BUILD_NUMBER}-application-security-testing")
            app.push("latest-application-security-testing")
        }
        sh 'echo "Docker push completed"'
    }
*/
         
}
