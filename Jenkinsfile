pipeline {
	agent any
	stages {
		stage('Build Docker Image') {
			steps {
				sh 'docker build -t capstone-app-pflash .'
			}
		}
		stage('Push Docker Image') {
			steps {
				withDockerRegistry([url: "", credentialsId: "capstone-docker-id"]) {
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