node {
    tools {"org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform-0.12.17"}

    environment {
        TF_HOME = tool('terraform-0.12.17')
        TF_IN_AUTOMATION = "true"
        PATH = "$TF_HOME:$PATH"
        ACCESS_KEY = credentials('jenkins-aws-secret-key-id')
        SECRET_KEY = credentials('jenkins-aws-secret-access-key')
    }

    echo "workspace directory is ${workspace}"

    stage('checkout') {
        checkout scm
    }



    stage('terraform init') {
        dir('.'){
            sh "echo 'Initializing Terraform'"
            sh "terraform init -input=false"
        }
    }

    stage('terraform plan'){
        dir('.'){
            sh "echo 'Planning Terraform Build'"
            sh "terraform plan -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY'"
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
                    dir('./terraform/prod'){
                        sh "echo 'Applying Terraform'"
                        IP = sh (
                            script: 'terraform apply --auto-approve',
                            returnStdout: true
                        ).trim() 
                        echo "Server IP is $IP"
                    }
                }
            }
        }
    }
}