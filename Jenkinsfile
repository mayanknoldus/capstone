pipeline {

    agent any 
    environment{
    	dockerImage = ''
    	registry = 'mayanknoldus/capstone:${GIT_COMMIT}-${BUILD_NUMBER}'
    	registryCredentials = 'dockerhub_cred'
    }
    tools{
    	maven 'maven'
    }

    stages {
        
        stage('Cleanup Workspace') {
            steps {
                sh "mvn clean"
            }
        }
        
        stage('Compile code') {
            steps {
                sh 'mvn compile'
            }	
        }

        stage('Testing') {
            when {
                branch 'test'
            } 
            steps {
                sh "mvn test"
            }
        }
        
        stage('Packaging') {
            when {
                branch 'main'
            } 
            steps {
                sh "mvn package"
            }
        }
        
        stage('Build and Push') {
            when {
                branch 'main'
            } 
            stages {
                stage('Building Docker Image') {
                	steps {
                		script {
                			dockerImage=docker.build registry
                		}
                	}
                }
                
                stage('Pushing image to Docker Hub') {
                	steps {
                		script {
                			docker.withRegistry( '', registryCredentials) {
                				dockerImage.push()	
                			}
                		}
                	}
                }
            }
        }

        stage(' Deploy to K8s') {
            when {
                branch 'main'
            }
            steps {
            	script {
            		
            	}
            }
        }

    }   
}
