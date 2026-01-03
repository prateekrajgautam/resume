pipeline {
    agent { label 'nixos' }
    
    stages {
        stage('Setup') {
            steps {
                echo 'Setting up build environment...'
                // nix-shell automatically loads shell.nix
                sh 'nix-shell --run "echo Environment loaded successfully"'
            }
        }
        
        stage('Build') {
            steps {
                echo 'Building resume...'
                sh '''
                    nix-shell --run "
                        cd work_folder
                        chmod +x compileAll.sh CleanUpAux.sh pdftopng.sh
                        bash compileAll.sh
                        bash CleanUpAux.sh 
                        bash pdftopng.sh
                        
                        echo 'Build complete!'
                    "
                '''
            }
        }
        
        stage('Test') {
            steps {
                echo 'Running tests...'
                sh '''
                    nix-shell --run "
                        cd work_folder
                        test -f ./PDF/Dr.PrateekRajGautam_Resume_2026_V01.pdf && echo 'PDF generated'                      
                    "
                '''
            }
        }
        
        stage('Push to prateekrajgautam.github.io') {
            steps {
                echo 'Deploying...'
                sh '''
                    nix-shell --run "
			echo 'cloning prateekrajgautam.github.io'
                        git config --global user.name prateekrajgautam
                        git config --global user.email prateekrajgautam@gmail.com
                        
                        git clone git@github.com:prateekrajgautam/prateekrajgautam.github.io.git
                        echo "pushed to github/resume"
    			
    			echo 'copying compiled files to new repo and commit changes'
    			cp -r ./work_folder/PDF ./prateekrajgautam.github.io/PDF
    			rm -rf ./prateekrajgautam.github.io/V01
    			mv ./prateekrajgautam.github.io/PDF ./prateekrajgautam.github.io/V01
    			
    			echo 'commiting and pushing changes'
			cd prateekrajgautam.github.io
			git status
			git add .
			git commit -m "Update from resume-jenkins_ data and jenkins buildno"
			git push # may require some ssh key, idont know if jenkins credential will be available here


                    "
                '''
            }
        }
    }
    
    post {
        always {
            echo 'Cleaning up...'
            sh 'nix-shell --run "echo Build artifacts preserved in output/"'
        }
        success {
            echo 'Pipeline succeeded! 🎉'
        }
        failure {
            echo 'Pipeline failed! ❌'
        }
    }
}


