def AWS_ACCESS_KEY_ID = credentials('jenkins-aws-secret-key-id')
def AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
pipeline {
    agent any 
    // tools {"org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform-0.12.17"}

    environment {
        // TF_HOME = tool('terraform-0.12.17')
        // TF_IN_AUTOMATION = "true"
        // PATH = "$TF_HOME:$PATH"

    }

    stages {
        stage('checkout') {
            steps {
                checkout scm
            }
        }
        // stage('aws credentials') {
        //     steps {
        //         sh'''
        //         temp_role=$(aws sts assume-role \
        //             --role-arn "arn:aws:iam::552752748819:role/jenkins_role" \
        //             --role-session-name "session")
        //         export AWS_ACCESS_KEY_ID=$(echo $temp_role | jq -r .Credentials.AccessKeyId)
        //         export AWS_SECRET_ACCESS_KEY=$(echo $temp_role | jq -r .Credentials.SecretAccessKey)
        //         export AWS_SESSION_TOKEN=$(echo $temp_role | jq -r .Credentials.SessionToken)
        //         '''
        //     }
        // }
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
                // sh'''
                // temp_role=$(aws sts assume-role \
                //     --role-arn "arn:aws:iam::552752748819:role/jenkins_role" \
                //     --role-session-name "session")
                // export AWS_ACCESS_KEY_ID=$(echo $temp_role | jq -r .Credentials.AccessKeyId)
                // export AWS_SECRET_ACCESS_KEY=$(echo $temp_role | jq -r .Credentials.SecretAccessKey)
                // export AWS_SESSION_TOKEN=$(echo $temp_role | jq -r .Credentials.SessionToken)
                // '''
                sh "echo 'Planning Terraform Build'"
                sh "./terraform plan -var 'access_key=${AWS_ACCESS_KEY_ID}' -var 'secret_key=${AWS_SECRET_ACCESS_KEY}'"
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
                        // withAWS(role: 'jenkins_role', roleAccount: '552752748819') {
                            sh "echo 'Applying Terraform'"
                            // sh'''
                            // temp_role=$(aws sts assume-role \
                            //     --role-arn "arn:aws:iam::552752748819:role/jenkins_role" \
                            //     --role-session-name "session")
                            // export AWS_ACCESS_KEY_ID=$(echo $temp_role | jq -r .Credentials.AccessKeyId)
                            // export AWS_SECRET_ACCESS_KEY=$(echo $temp_role | jq -r .Credentials.SecretAccessKey)
                            // export AWS_SESSION_TOKEN=$(echo $temp_role | jq -r .Credentials.SessionToken)
                            // '''
                            IP = sh (
                                script: "./terraform apply --auto-approve -var 'access_key=${AWS_ACCESS_KEY_ID}' -var 'secret_key=${AWS_SECRET_ACCESS_KEY}'",
                                returnStdout: true
                            ).trim() 
                            echo "Server IP is $IP"
                        // }
                    }
                }
            }
        }
    }
}
// def AWS_ACCESS_KEY_ID() {
//     temp_role=aws sts assume-role \
//         --role-arn "arn:aws:iam::552752748819:role/jenkins_role" \
//         --role-session-name "session"
//     def AWS_ACCESS_KEY_ID=echo $temp_role | jq -r .Credentials.AccessKeyId
//     AWS_ACCESS_KEY_ID
// }
// def AWS_SECRET_ACCESS_KEY() {
//     temp_role=$(aws sts assume-role \
//         --role-arn "arn:aws:iam::552752748819:role/jenkins_role" \
//         --role-session-name "session")
//     AWS_SECRET_ACCESS_KEY=$(echo $temp_role | jq -r .Credentials.SecretAccessKey)
//     AWS_SECRET_ACCESS_KEY
// }