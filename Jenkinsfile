pipeline {
     environment {
            registry = "docker.io/agf46/demo"
            registryCredential = 'Docker Hub account'
            dockerImage = ' '
        }
    agent any
    stages {
        stage('build') {
            steps {
                sh'''
                    echo 'FROM alpine:latest’ > Dockerfile
                    echo ‘CMD ["/bin/echo", "HELLO WORLD...."]' >> Dockerfile
                '''
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'agf46') {
                        def image = docker.build('agf46/demo')
                        image.push()
                    }
                }
            }
        }
        stage('analyze') {
            steps {
                sh 'echo "docker.io/agf46/demo `pwd`/Dockerfile" > anchore_images'
                anchore name: 'anchore_images'
            }
        }
        stage('teardown') {
            steps {
                sh'''
                    for i in `cat anchore_images | awk '{print $1}'`;do docker rmi $i; done
                '''
            }
        }
    }
}