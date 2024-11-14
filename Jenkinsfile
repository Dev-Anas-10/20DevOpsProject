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
        SONAR_SERVER = 'sonarserver'      // SonarQube server name configured in Jenkins
        SONAR_SCANNER = 'sonarscanner'    // SonarQube scanner tool name configured in Jenkins
        NEXUS_CREDENTIALS_ID = 'nexuslogin'   // Jenkins credential ID for Nexus
        NEXUS_URL = 'http://192.168.100.22:8081' // Nexus server URL
        RELEASE_REPO = 'vprofile-release'       // Nexus repository for releases
        GROUP_ID = 'QA'
        ARTIFACT_ID = 'vproapp'
        PACKAGING = 'war'
        VERSION = "1.0.${env.BUILD_ID}-${env.BUILD_TIMESTAMP}" // Version with timestamp using Jenkins build ID
    }

    stages {
        stage('Build') {
            steps {
                script {
                    // Run Maven build with custom settings.xml, skipping tests
                    sh 'mvn -s settings.xml -DskipTests install'
                }
            }
            post {
                success {
                    echo "Build successful. Archiving artifacts..."
                    // Archive all WAR files generated during the build
                    archiveArtifacts '**/*.war'
                }
                failure {
                    echo "Build failed. No artifacts will be archived."
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run Maven tests
                    sh 'mvn -s settings.xml test'
                }
            }
            post {
                success {
                    echo "Tests passed successfully."
                }
                failure {
                    echo "Tests failed."
                }
            }
        }

        stage('Checkstyle') {
            steps {
                script {
                    // Run Maven Checkstyle
                    sh 'mvn -s settings.xml checkstyle:checkstyle'
                }
            }
            post {
                success {
                    echo "Checkstyle completed successfully."
                }
                failure {
                    echo "Checkstyle failed."
                }
            }
        }

        stage('Code Analysis with SonarQube') {
            environment {
                scannerHome = tool "${SONAR_SCANNER}"
            }
            steps {
                script {
                    withSonarQubeEnv("${SONAR_SERVER}") {
                        sh '''${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=vprofile \
                   -Dsonar.projectName=vprofile-repo \
                   -Dsonar.projectVersion=1.0 \
                   -Dsonar.sources=src/ \
                   -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest/ \
                   -Dsonar.junit.reportsPath=target/surefire-reports/ \
                   -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                   -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml'''
                    }
                }  
            }
            post {
                success {
                    echo "SonarQube analysis completed successfully."
                }
                failure {
                    echo "SonarQube analysis failed."
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

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
                            file: 'target/vprofile-v2.war', // Path to the WAR file
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
        }
        success {
            echo "All stages completed successfully."
        }
        failure {
            echo "Pipeline failed."
        }
    }
}
