pipeline {
    agent any 
    // tools {"org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform-0.12.17"}

    environment {
        // TF_HOME = tool('terraform-0.12.17')
        // TF_IN_AUTOMATION = "true"
        // PATH = "$TF_HOME:$PATH"
        ACCESS_KEY = credentials('jenkins-aws-secret-key-id')
        SECRET_KEY = credentials('jenkins-aws-secret-access-key')
    }

    stages {
        stage('checkout') {
            checkout scm
        }


        stage('terraform install') {
            steps {
                sh "wget https://releases.hashicorp.com/terraform/0.12.10/terraform_0.12.10_linux_amd64.zip"
                sh "unzip -o terraform_0.12.10_linux_amd64.zip"

            }
        }
        stage('terraform init') {
            steps {
                sh "echo 'Initializing Terraform'"
                sh "./terraform init -input=false"
            }
        }

        stage('terraform plan'){
            steps {
                sh "echo 'Planning Terraform Build'"
                sh "./terraform plan "//-var 'access_key=${env.ACCESS_KEY}' -var 'secret_key=${env.SECRET_KEY}'"
            }
        }

        stage('terraform apply'){
            steps {
                script{
                    def apply = false
                    try {
                        input message: 'Can you please confirm the apply', ok: 'Ready to Apply the Config'
                        apply = true
                    } catch (err) {
                        apply = false
                            currentBuild.result = 'UNSTABLE'
                    }
                    if(apply){
                        steps {
                            sh "echo 'Applying Terraform'"
                            IP = sh (
                                script: './terraform apply --auto-approve',
                                returnStdout: true
                            ).trim() 
                            echo "Server IP is $IP"
                        }
                    }
                }
            }
        }
    }
}