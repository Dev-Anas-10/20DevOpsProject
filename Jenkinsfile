pipeline {
    agent any

    tools {
        maven 'MAVEN3.9' 
    }

    environment {
        NEXUS_CREDENTIALS_ID = 'nexuslogin'
        SNAP_REPO = 'vprofile-snapshot'
        RELEASE_REPO = 'vprofile-release'
        CENTRAL_REPO = 'vpro-maven-central'
        NEXUS_GRP_REPO = 'vpro-maven-group'
        NEXUS_USER = 'admin'
        NEXUS_PASS = 'admin'
        NEXUSIP = '192.168.100.22'
        NEXUSPORT = '8081'
    }

    stages {

        stage('Build') {
            steps {
                sh 'mvn -s settings.xml -DskipTests install'
            }
        }

    }
}