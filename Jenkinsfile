pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                url: 'https://github.com/lokeshmulani/terraform-demo.git'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('terraform') {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Get Public IP') {
            steps {
                script {
                    env.SERVER_IP = sh(
                        script: "cd terraform && terraform output -raw public_ip",
                        returnStdout: true
                    ).trim()

                    echo "Server IP: ${env.SERVER_IP}"
                }
            }
        }

        stage('Deploy Application') {
            steps {
                sh """
                scp -o StrictHostKeyChecking=no \
                app/index.html \
                ec2-user@${SERVER_IP}:/tmp/index.html

                ssh -o StrictHostKeyChecking=no \
                ec2-user@${SERVER_IP} \
                'sudo cp /tmp/index.html /var/www/html/index.html'
                """
            }
        }
    }
}
