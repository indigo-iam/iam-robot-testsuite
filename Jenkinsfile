pipeline {
  agent { label 'docker' }

  options {
    timeout(time: 2, unit: 'HOURS')
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  
  parameters {
  	string(name: 'USER_UID', defaultValue: '10000', description: 'User UID')
  }
  
  environment {
  	USER_UID="${params.USER_UID}"
  	DOCKER_REGISTRY_HOST = "${env.DOCKER_REGISTRY_HOST}"
  }

  stages {
    stage('build image'){
      steps {
        container('docker-runner'){
          dir('docker'){
            sh 'sh build-image.sh'
          }
        }
      }
    }
    
    stage('push image'){
      when{
        anyOf { branch 'master'; branch 'develop' }
        environment name: 'CHANGE_URL', value: ''
      }
      steps {
        container('docker-runner'){
          dir('docker'){
            sh 'sh push-image.sh'
          }
        }
      }
    }
    
    stage('result'){
   	  steps {
   	    script { currentBuild.result = 'SUCCESS' }
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
