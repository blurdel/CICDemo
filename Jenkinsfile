def gv

pipeline {
	agent any

	environment {
		// env vars
		NEW_VERSION = "1.2.0"
		//SERVER_CREDS = credentials('dso-creds')
	}
	parameters {
		// These will show up in Jenkins: Build with parameters
		// These are also available in groovy scripts
		string(name: 'VERSION', defaultValue: '1.0.0', description: 'version to deploy to prod')
		choice(name: 'STUFF', choices: ['a', 'b', 'c'], description: 'some choice you might want to make')
		booleanParam(name: 'runTests', defaultValue: true, description: 'do you want to run tests?')
	}
	/*
	tools {
		maven 'Maven'
		//jdk
	}
	*/
	
	stages {
		stage ('Init') {
			steps {
				echo 'Initing ...'
				bat 'java -version'
				bat 'mvn --version'
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
			steps {
				echo 'Building ...'
				echo "Building version ${NEW_VERSION}"
				//sh 'make'
				//sh 'npm install'
				sh 'mvn clean verify'
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
			steps {
				echo 'Testing ...'
				// 'make check' returns non-zero on test failures,
				// using 'true' to allow the pipeline to continue nonetheless
				sh 'make check || true'
				junit '**/target/*.xml'
			}
		}
		stage ('Deploy') {
			steps {
				echo 'Deploying ...'
				/*
				when {
					expression {
						currentBuild.result == null || currentBuild.result == 'SUCCESS'
					}
				}
				// Plugins: credentials, credentials binding
				withCredentials ([
					usernamePassword(credentials: 'dso-creds', usernameVariable: USER, passwordVariable: PWD)
				]) {
					sh "myscript ${USER} ${PWD}"
					echo "deploying version ${params.VERSION}"
				}
				*/
			}
		}
		stage ('Cleanup') {
			steps {
				echo 'Cleaning up ...'
				script {
					gv.otherFunc()
				}
			}
		}
	}
	post {
		always {
			echo 'echo ALWAYS'
		}
		success {
			echo 'echo SUCCESS'
		}
		failure {
			echo 'echo FAILURE'
		}
	}
}
