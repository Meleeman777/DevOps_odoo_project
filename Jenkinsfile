pipeline {
    agent { node { label 'Rebrain' } }
    stages {
        stage('Build') {
            steps {
                sh 'chown -R app:app /opt/odoo-project'
                }
            }
        }
    }


