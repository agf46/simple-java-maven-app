pipeline {
        environment {
            registry = "docker.io/agf46/demo"
            registryCredential = 'Docker Hub account'
            dockerImage = ' '
        }
        agent any
        stages {
            stage('Cloning Git') {
                steps {
                    git 'https://github.com/agf46/docker-dvwa.git'
                }
            }
            stage('Building Image') {
                steps{
                    script {
                        dockerImage = docker.build registry + ":$BUILD_NUMBER"
                    }
                }
          
           }
           stage('Container Security Scan') {
               steps{
                   sh 'echo "docker.io/agf46/demo `pwd` /Dockerfile" > anchore_images'
                   anchore name: 'anchore_images'
               }
           }
            stage('Deploy Image'){
                steps{
                    script{
                        docker.withRegistry('',registryCredential){
                            dockerImage.push()
                        }
                    }
                }
            }
           stage('Cleanup') {
               steps{
                   sh'''
                    for i in `cat anchore_images | awk '{print $1}'`;do docker rmi $i'
                    done '''
               }
           } 
        }
}