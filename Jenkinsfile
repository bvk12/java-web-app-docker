node{
    def buildNumber = BUILD_NUMBER  
    stage("Git Clone") {
        git url: 'https://github.com/bvk12/java-web-app-docker.git',branch: 'master'
    }
    stage("Maven Clean Package") {
        def mavenHome= tool name: "maven",type: "maven"
         sh "${mavenHome}/bin/mvn clean package"
    }
    stage("Build Docker Image"){
        sh "docker image build -t bvkk/docker:${buildNumber} ."
    }
    stage("Docker Login and push"){
        withCredentials([string(credentialsId: 'Docker_hub_Pwd', variable: 'Docker_hub_Pwd')]) {
            sh "docker login -u bvkk -p ${Docker_hub_Pwd}"
        }
        sh "docker image push bvkk/docker:${buildNumber}"
    }
    stage("Deploye Application As Docker Container In Docker Deployment Server"){
        sshagent(['DockerHub']) {
          sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.83.109 docker rm -f javawebappcontainer || true"
          sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.83.109 docker container run -d --name javawebappcontainer -p 8081:8080 bvkk/docker:${buildNumber}"
        }
    }
}
