pipeline {
    agent any

    tools {
        maven "MAVEN3.9"
        jdk "JDK17"
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
        SONAR_SERVER = "sonarserver"      // SonarQube server name configured in Jenkins
        SONAR_SCANNER = "sonarscanner"    // SonarQube scanner tool name configured in Jenkins
    }

    stages {
        stage('Build') {
            steps {
                // Run Maven build with custom settings.xml and skipping tests
                sh 'mvn -s settings.xml -DskipTests install'
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
                // Run Maven tests
                sh 'mvn -s settings.xml test'
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
                // Run Maven Checkstyle
                sh 'mvn -s settings.xml checkstyle:checkstyle'
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

        stage('CODE ANALYSIS with SONARQUBE') {
            environment {
                scannerHome = tool "${SONAR_SCANNER}"
            }
            steps {
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
    }
}
