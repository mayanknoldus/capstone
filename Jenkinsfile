pipeline {

    agent any 
    environment{
    	dockerImage = ''
    	registry = 'mayanknoldus/capstone:${GIT_COMMIT}-${BUILD_NUMBER}'
    	registryCredentials = 'dockerhub_cred'
    }
    tools{
    	nodejs 'npm'
    }

    stages {
        
        stage('Cleanup Workspace') {
            steps {
                
            }
        }
        
        stage('Compile code') {
            steps {
                sh 'npm install'
            }	
        }

        stage('Testing') {
            when {
                branch 'test'
            } 
            steps {
                sh "npm test"
            }
        }
        
        stage('Packaging') {
            when {
                branch 'main'
            } 
            steps {
                
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
            		kubernetesDeploy configs: '**/k8s-deployment.yml', kubeConfig: [path: ''], kubeconfigId: 'kubeconfig', secretName: '', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']
            	}
            }
        }

    }   
}

