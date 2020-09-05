pipeline {
	agent any
	stages {
		stage('Lint Dockerfile') {
			steps {
				script {
					docker.image('hadolint/hadolint:latest-debian').inside() {
						sh 'hadolint ./Dockerfile | tee -a hadolint_lint.txt'
						sh '''
							lintErrors=$(stat --printf="%s"  hadolint_lint.txt)
							if [ "$lintErrors" -gt "0" ]; then
								echo "Errors have been found, please see below"
								cat hadolint_lint.txt
								exit 1
							else
								echo "There are no erros found on Dockerfile!!"
							fi
						'''
					}
				}
			}
		}
		stage('Security Scan') {
			steps { 
				aquaMicroscanner imageName: 'alpine:latest', notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html'
			}
	    } 
		stage('Build Docker Image') {
			steps {
				sh 'docker build -t capstone-app-pflash .'
			}
		}
		stage('Push Docker Image') {
			steps {
				withDockerRegistry([url: "", credentialsId: "docker-capstone-id"]) {
					sh "docker tag capstone-app-pflash pflash30/capstone-app-pflash"
					sh 'docker push pflash30/capstone-app-pflash'
				}
			}
		}
		stage('Deploying') {
			steps{
				echo 'Deploying to AWS...'
				withAWS(credentials: 'capstone', region: 'us-west-2') {
					sh "aws eks --region us-west-2 update-kubeconfig --name capstoneclusterpflash"
					sh "kubectl config use-context arn:aws:eks:us-west-2:466659414290:cluster/capstoneclusterpflash"
					sh "kubectl apply -f capstone-k8s.yaml"
					sh "kubectl get nodes"
					sh "kubectl get deployments"
					sh "kubectl get pod -o wide"
					sh "kubectl get service/capstone-app-pflash"
				}
			}
		}
		stage('Checking rollout') {
			steps{
				echo 'Checking rollout...'
				withAWS(credentials: 'capstone', region: 'us-west-2') {
					 sh "kubectl rollout status deployments/capstone-app-pflash"
				}
			}
		}
		stage("Cleaning up") {
			steps{
				echo 'Cleaning up...'
				sh "docker system prune"
			}
		}
  }
}