pipeline {
    agent any

    tools {
        maven 'MAVEN3.9' 
    }

    environment {
        GITHUB_REPO = 'https://github.com/Dev-Anas-10/20DevOpsProject.git' 
        GITHUB_BRANCH = '5.CI-Using-Jenkins-Nexus-Sonarqube-Slack'
        SLACK_WEBHOOK_URL = 'https://hooks.slack.com/services/your/webhook/url' 
        SONARQUBE_SERVER = 'SonarQube_Server' 
        NEXUS_REPOSITORY_URL = 'http://nexus-server-url/repository/maven-releases/' // رابط الـ Nexus repo
        NEXUS_CREDENTIALS_ID = 'nexuslogin'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git url: "${GITHUB_REPO}", branch: "${GITHUB_BRANCH}"
            }
        }

        stage('Build') {
            steps {
                script {
                    try {
                        sh 'mvn clean package'
                    } catch (Exception e) {
                        error("Build failed!")
                    }
                }
            }
        }

        stage('Checkstyle') {
            steps {
                sh 'mvn checkstyle:check'
            }
        }

        stage('Notify Slack') {
            when {
                success()
            }
            steps {
                slackSend channel: '#builds', message: 'Build succeeded! 🎉'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv("${SONARQUBE_SERVER}") {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage('Upload to Nexus') {
            steps {
                script {
                    nexusPublisher nexusInstanceId: 'nexus-instance', nexusRepositoryId: 'maven-releases',
                        packages: [
                            [
                                $class: 'MavenPackage',
                                mavenAssetList: [
                                    [classifier: '', extension: 'war', filePath: 'target/*.war']
                                ],
                                mavenCoordinate: [
                                    artifactId: 'your-artifact-id',
                                    groupId: 'your.group.id',
                                    version: '1.0.0'
                                ]
                            ]
                        ]
                }
            }
        }
    }

    post {
        failure {
            slackSend channel: '#builds', message: 'Build failed ❌'
        }
    }
}
