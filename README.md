# CI-Using-Jenkins-Nexus-Sonarqube-Slack

This project demonstrates the use of Jenkins CI to automate the build, testing, and deployment processes for a GitHub repository. The pipeline uses Maven to build and test the code, SonarQube for code quality analysis, Nexus for artifact repository management, and Slack for notifications. 

![Project Flow](project-flow.png)  <!-- Image reference -->

## Pipeline Overview

The pipeline automates the following steps:
1. **Clone the GitHub repository**: The pipeline fetches the source code from a specified GitHub repository.
2. **Build with Maven**: The code is built using Maven, skipping the tests to speed up the build process.
3. **Run tests**: The code is tested using Maven, and the results are reported back.
4. **Code Quality Analysis with SonarQube**: The code is analyzed for quality using SonarQube.
5. **Upload Artifact to Nexus**: After a successful build, the artifact (WAR file) is uploaded to Nexus Repository Manager for storage.
6. **Send Slack Notification**: A notification is sent to a Slack channel to inform the team about the build status.

## Prerequisites

Before running the pipeline, ensure you have the following setup:

- **Jenkins**: A running Jenkins instance configured with the necessary plugins.
  - **Slack Notification Plugin**: For sending notifications to Slack.
  - **SonarQube Scanner Plugin**: For integrating SonarQube into the Jenkins pipeline.
  - **Nexus Artifact Uploader Plugin**: For uploading artifacts to Nexus.
- **GitHub Repository**: A public or private repository containing your Java source code.
- **SonarQube Server**: Set up and configured SonarQube server for code quality analysis.
- **Nexus Repository**: A Nexus instance to store the generated WAR artifacts.
- **Slack Workspace**: A Slack channel where notifications will be sent.
