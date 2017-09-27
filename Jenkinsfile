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
        dependencyCheckAnalyzer datadir: 'dependency-check-data', isFailOnErrorDisabled: true, hintsFile: '', includeCsvReports: false, includeHtmlReports: false, includeJsonReports: false, isAutoupdateDisabled: false, outdir: '', scanpath: '', skipOnScmChange: false, skipOnUpstreamChange: false, suppressionFile: '', zipExtensions: '', jarAnalyzerEnabled: false, pythonDistributionAnalyzerEnabled: false, pythonPackageAnalyzerEnabled: false, rubyBundlerAuditAnalyzerEnabled: false, rubyGemAnalyzerEnabled: false, cocoaPodsAnalyzerEnabled: false, swiftPackageManagerAnalyzerEnabled: false, cmakeAnalyzerEnabled: false
        dependencyCheckPublisher canComputeNew: false, defaultEncoding: '', healthy: '', pattern: '', unHealthy: ''        
        archiveArtifacts allowEmptyArchive: true, artifacts: '**/dependency-check-report.xml', onlyIfSuccessful: true
        
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
