pipeline{
    agent any
    stages{
        stage('Git Checkout'){
            steps{
                 git branch: 'main', url: 'https://github.com/kelvinduan2020/2022-Java-Maven-Application.git'
            }
        }          
        stage('Maven Build'){
            steps {
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }        
        stage("Nexus Upload"){
            steps {
                script{
                    pom = readMavenPom file: "pom.xml";
                    filesByGlob = findFiles(glob: "target/*.${pom.packaging}");
                    //echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
                    artifactPath = filesByGlob[0].path;
                    artifactExists = fileExists artifactPath;

                    if(artifactExists){
                        echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}, aftifact：${pom.artifactId}";
                        nexusArtifactUploader(
                            nexusVersion: 'nexus3',                            
                            protocol: 'http',
                            nexusUrl: '192.168.0.102:8081/',
                            groupId: "${pom.groupId}",
                            version: "${pom.version}",
                            repository: 'maven-hosted',
                            credentialsId: 'nexus-credential',
                            artifacts: [
                                [artifactId: "${pom.artifactId}",
                                classifier: '',
                                file: artifactPath,
                                type: "${pom.packaging}"],
                                [artifactId: "${pom.artifactId}",
                                classifier: '',
                                file: "pom.xml",
                                type: "pom"]
                            ]
                        );
                    }else{
                          error "*** File: ${artifactPath}, could not be found";
                    }
                }
            }
        }
    }
}
