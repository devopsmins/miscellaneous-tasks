pipeline {
   agent {
     node { label 'workstation' }
   }

  options {
    ansiColor('xterm')
  }



  stages {

    stage( 'Apply' ) {
      steps {
        sh 'cd jenkins-ip-update'
        sh 'terraform init'
        sh 'terraform apply -auto-approve'

      }
    }
  }
}
