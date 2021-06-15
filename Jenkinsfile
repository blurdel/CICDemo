def gv // For groovy scripts

pipeline {
	agent any
	options {
		timestamps() // Add timestamps to logging
		// Abort this pipleine if it runs longer than the timeout
        timeout(time: 2, unit: 'HOURS') 
    }

	environment {
		SOME_STATIC_VERSION = "0.0.1"
		USER_CREDS = credentials('juser-creds')
		//JAVA_TOOL_OPTIONS = "-Duser.home=/var/maven"
	}
	parameters {
		// These will show up in Jenkins: Build with parameters
		// These are also available in groovy scripts
		string(name: 'param1', defaultValue: '', description: 'Enter any value for param1')
		choice(name: 'version', choices: ['1.1.0', '1.2.0', '1.3.0'], description: 'Select the version for this build')
		booleanParam(name: 'unitTests', defaultValue: true, description: 'Do you want to run Unit Tests?')
	}
	
	tools {
		maven 'mvn'
		//jdk
	}
	
	
	stages {
		stage ('Init') {
			steps {
				echo 'Stage: Init'
				echo "branch=${env.BRANCH_NAME}, param1=${params.param1}, version=${params.version}, unitTests=${params.unitTests}"
				sh "ssh -V"
				sh 'java -version'
				sh 'mvn --version'
				script {
					gv = load "myscript.groovy"
					gv.someFunc()
				}
			}
		}
		stage ('Timeout Test') {
			options { timeout(time: 5, unit: 'SECONDS') }
			steps {
				echo 'Stage: Timeout Test'
				sleep 3
				echo 'Awake'
			}
		}
		stage ('Build') {
			when {
				expression {
					env.BRANCH_NAME == 'master' || env.BRANCH_NAME == 'main' // && CODE_CHANGES == true
				}
			}
			options { timeout(time: 3, unit: 'MINUTES') }
			steps {
				echo 'Stage: Build'
				echo "Using some static version ${SOME_STATIC_VERSION}"
				echo "Using param1 = ${params.param1}"
				//sh 'make'
				//sh 'npm install'
				sh 'mvn clean verify -DskipTests'
				archiveArtifacts(artifacts: '**/target/*.jar', fingerprint: true)
			}
		}
		stage ('Test') {
			when {
				expression {
					// env.BRANCH_NAME == 'dev' || env.BRANCH_NAME == 'master' || || env.BRANCH_NAME == 'main'
					params.unitTests == true
				}
			}
			options { timeout(time: 4, unit: 'MINUTES') }
			steps {
				echo 'Stage: Test'
				// Use OR 'true' to allow the pipeline to continue on failure
				// sh 'mvn clean test || true'
				sh 'mvn clean test'
				junit(allowEmptyResults: false, testResults: '**/target/*.xml')
			}
		}
		stage ('Deploy') {
			steps {
				echo 'Stage: Deploy'
				echo "Deploying version: ${params.version}"
			}
		}
		stage ('Cleanup') {
			steps {
				echo 'Stage: Cleanup'
				script {
					gv.otherFunc()
				}
				deleteDir()
			}
		}
	}
	post {
		// Execute after all stages executed
		always {
			echo 'post/always'
			//mail to: "user@gmail.com", subject: "Jenkins Test build", body: "Test Build of Jenkins job: ${env.JOB_NAME}"
		}
		success {
			echo 'post/success'
		}
		failure {
			echo 'post/failure'
			script {
				if (env.BRANCH_NAME == 'master') {
					//mail bcc: '', body: "<br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br>URL: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: 'Jenkins', mimeType: 'text/html', replyTo: '', subject: "Build Failure: Project ${env.JOB_NAME}", to: "user@gmail.com";
				}
			}
		}
	}
}
