pipeline {
    agent { node { label 'Rebrain' } }
    stages {
        stage('Prepare') {
            steps {
                sh 'rm -rf .infra/ docker/ down.sh up.sh Jenkinsfile .gitignore .git/'
                sh 'cp -r /opt/workspace/odoo-project /opt/odoo-project'
                sh 'sudo chown -R app:app /opt/odoo-project'
                }
            }
        stage ('Build') {
            steps {
                sh './opt/odoo-project/script.sh'
            }
        }
        stage ('Start') {
            steps {
                sh 'sudo systemctl start odoo.service'
            }
        }
        
        }
    }
