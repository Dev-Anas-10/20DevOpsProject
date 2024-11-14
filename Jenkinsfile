pipeline {
    agent any

    tools {
        maven "MAVEN3.9"
        jdk "JDK8"
    }

    environment {
        SNAP_REPO = 'vprofile-snapshot'
        CENTRAL_REPO = 'vpro-maven-central'
        NEXUS_GRP_REPO = 'vpro-maven-group'
        NEXUS_USER = 'admin'
        NEXUS_PASS = 'admin'
        SONAR_SERVER = 'sonarserver'
        SONAR_SCANNER = 'sonarscanner'
        NEXUS_CREDENTIALS_ID = 'nexuslogin'
        NEXUS_URL = '192.168.100.22:8081'
        RELEASE_REPO = 'vprofile-release'
        GROUP_ID = 'QA'
        ARTIFACT_ID = 'vproapp'
        PACKAGING = 'war'
        VERSION = "1.0.${env.BUILD_ID}-${env.BUILD_TIMESTAMP}"
    }

    stages {
        stage('Build') {
            steps {
                script {
                    sh 'mvn -s settings.xml -DskipTests install'
                }
            }
            post {
                success {
                    echo "Build successful. Archiving artifacts..."
                    archiveArtifacts '**/*.war'
                    slackSend channel: '#devops', 
                               color: 'good', 
                               message: "Build succeeded: <${env.BUILD_URL}|${env.JOB_NAME} - ${env.BUILD_NUMBER}>"
                }
                failure {
                    echo "Build failed. No artifacts will be archived."
                    slackSend channel: '#devops', 
                               color: 'danger', 
                               message: "Build failed: <${env.BUILD_URL}|${env.JOB_NAME} - ${env.BUILD_NUMBER}>"
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    sh 'mvn -s settings.xml test'
                }
            }
            post {
                success {
                    echo "Tests passed successfully."
                    slackSend channel: '#devops', 
                               color: 'good', 
                               message: "Tests passed: <${env.BUILD_URL}|${env.JOB_NAME} - ${env.BUILD_NUMBER}>"
                }
                failure {
                    echo "Tests failed."
                    slackSend channel: '#devops', 
                               color: 'danger', 
                               message: "Tests failed: <${env.BUILD_URL}|${env.JOB_NAME} - ${env.BUILD_NUMBER}>"
                }
            }
        }

        // Additional stages...

        stage('Upload Artifact to Nexus') {
            steps {
                nexusArtifactUploader(
                    nexusVersion: 'nexus3',
                    protocol: 'http',
                    nexusUrl: "${NEXUS_URL}",
                    groupId: "${GROUP_ID}",
                    version: "${VERSION}",
                    repository: "${RELEASE_REPO}",
                    credentialsId: "${NEXUS_CREDENTIALS_ID}",
                    artifacts: [
                        [
                            artifactId: "${ARTIFACT_ID}",
                            classifier: '',
                            file: 'target/vprofile-v2.war',
                            type: "${PACKAGING}"
                        ]
                    ]
                )
            }
        }
    }

    post {
        always {
            echo "Pipeline completed."
            slackSend channel: '#devops', 
                       color: '#439FE0', 
                       message: "Pipeline completed: <${env.BUILD_URL}|${env.JOB_NAME} - ${env.BUILD_NUMBER}>"
        }
        success {
            echo "All stages completed successfully."
            slackSend channel: '#devops', 
                       color: 'good', 
                       message: "Pipeline succeeded: <${env.BUILD_URL}|${env.JOB_NAME} - ${env.BUILD_NUMBER}>"
        }
        failure {
            echo "Pipeline failed."
            slackSend channel: '#devops', 
                       color: 'danger', 
                       message: "Pipeline failed: <${env.BUILD_URL}|${env.JOB_NAME} - ${env.BUILD_NUMBER}>"
        }
    }
}
