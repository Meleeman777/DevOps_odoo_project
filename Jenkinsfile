pipeline {
    agent { node { label 'Rebrain' } }
    stages {
        stage('Prepare') {
            steps {
                sh 'sudo rm -rf .infra/ docker/ down.sh up.sh Jenkinsfile .gitignore .git/'
                sh 'yes | cp -rf /home/cicd/workspace/odoo-project /opt'
                sh 'sudo chown -R app:app /opt/odoo-project'
                }
            }
        stage ('Build') {
            steps {
                sh '/opt/odoo-project/script.sh'
            }
        }
        stage ('Test') {
            steps {
                sh 'pylint --exit-zero /opt/odoo-project/odoo/__init__.py'
                sh 'pylint --exit-zero /opt/odoo-project/odoo/__main__.py'
            }
        }      
        stage ('Start') {
            steps {
                sh 'sudo systemctl start odoo.service'
            }
        }

        }
    }

