def gv

pipeline {
	agent any

	environment {
		NEW_VERSION = "1.2.0"
		//JAVA_TOOL_OPTIONS = "-Duser.home=/var/maven"
	}
	parameters {
		// These will show up in Jenkins: Build with parameters
		// These are also available in groovy scripts
		string(name: 'VERSION', defaultValue: '1.0.0', description: 'version to deploy to prod')
		choice(name: 'STUFF', choices: ['a', 'b', 'c'], description: 'some choice you might want to make')
		booleanParam(name: 'runTests', defaultValue: true, description: 'do you want to run tests?')
	}
	
	tools {
		maven 'mvn'
		//jdk
	}
	
	
	stages {
		stage ('Init') {
			steps {
				echo 'Initing ...'
				sh 'java -version'
				sh 'mvn --version'
				script {
					gv = load "myscript.groovy"
					gv.someFunc()
				}
			}
		}
		stage ('Build') {
			when {
				expression {
					BRANCH_NAME == 'master' // && CODE_CHANGES == true
				}
			}
			options {
				timeout(time: 2, unit: 'MINUTES')
			}
			steps {
				echo 'Building ...'
				echo "Building version ${NEW_VERSION}"
				//sh 'make'
				//sh 'npm install'
				sh 'mvn clean verify -DskipTests'
				archiveArtifacts(artifacts: '**/target/*.jar', fingerprint: true)
			}
		}
		stage ('Test') {
			when {
				expression {
					//BRANCH_NAME == 'dev' || BRANCH_NAME == 'master'
					params.runTests == true
				}
			}
			options {
				timeout(time: 2, unit: 'MINUTES')
			}
			steps {
				echo 'Testing ...'
				// 'make check' returns non-zero on test failures,
				// using 'true' to allow the pipeline to continue nonetheless
				// sh 'mvn test || true'
				junit(allowEmptyResults: false, testResults: '**/target/surefire-reports/*.xml')
			}
		}
		stage ('Deploy') {
			steps {
				echo 'Deploying ...'
			}
		}
		stage ('Cleanup') {
			steps {
				echo 'Cleaning up ...'
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
			echo 'ALWAYS'
			//mail to: "user@gmail.com", subject: "Jenkins Test build", body: "Test Build of Jenkins job: ${env.JOB_NAME}"
		}
		success {
			echo 'SUCCESS'
		}
		failure {
			echo 'FAILURE'
			script {
				if (env.BRANCH_NAME == 'master') {
					//mail bcc: '', body: "<br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br>URL: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: 'Jenkins', mimeType: 'text/html', replyTo: '', subject: "Build Failure: Project ${env.JOB_NAME}", to: "user@gmail.com";
				}
			}
		}
	}
}
