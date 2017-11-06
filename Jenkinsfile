pipeline {
  agent { label 'docker' }

  options {
    timeout(time: 1, unit: 'HOURS')
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }

  triggers { cron('@daily') }

  stages {
    stage('prepare'){
      steps {
        cleanWs notFailBuild: true
        checkout scm
      }
    }

    stage('build image'){
      steps {
        dir('docker'){
          sh './build-image.sh'
        }
      }
    }
    
    stage('push image'){
      when{
        anyOf { branch 'master'; branch 'develop' }
        environment name: 'CHANGE_URL', value: ''
      }
      steps {
        dir('docker'){
          sh './push-image.sh'
        }
      }
    }
    
    stage('result'){
   	  steps {
   	    script {
   	      currentBuild.result = 'SUCCESS'
   	    }
   	  }
    }
  }

  post {
    failure {
      slackSend color: 'danger', message: "${env.JOB_NAME} - #${env.BUILD_NUMBER} Failure (<${env.BUILD_URL}|Open>)"
    }

    changed {
      script{
        if('SUCCESS'.equals(currentBuild.result)) {
          slackSend color: 'good', message: "${env.JOB_NAME} - #${env.BUILD_NUMBER} Back to normal (<${env.BUILD_URL}|Open>)"
        }
      }
    }
  }
}
