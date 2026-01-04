pipeline {
    agent { label 'nixos' }
    
    environment {
        BUILD_INFO = "Build #${env.BUILD_NUMBER}"
        GITHUB_REPO = 'prateekrajgautam.github.io'
    }
    
    stages {
        stage('Setup') {
            steps {
                echo 'Setting up build environment...'
                sh 'nix-shell --run "echo Environment loaded successfully"'
            }
        }
        
        stage('Build Resume') {
            steps {
                echo 'Compiling LaTeX documents...'
                sh '''
                    nix-shell --run "
                        cd work_folder
                        chmod +x compileAll.sh
                        bash compileAll.sh
                        echo 'Build complete!'
                    "
                '''
            }
        }
        
        stage('Verify Output') {
            steps {
                echo 'Verifying generated PDFs...'
                sh '''
                    nix-shell --run "
                        cd work_folder/PDF
                        
                        if [ -f Dr.PrateekRajGautam_Resume_2026_V01.pdf ]; then
                            echo '✓ Main resume PDF generated'
                            ls -lh *.pdf
                        else
                            echo '✗ Main resume PDF NOT found!'
                            exit 1
                        fi
                    "
                '''
            }
        }
        
        stage('Clone GitHub Pages Repo') {
            steps {
                echo 'Cloning prateekrajgautam.github.io...'
                sh '''
                    nix-shell --run "
                        # Clean up any existing clone
                        rm -rf ${GITHUB_REPO}
                        
                        # Clone the repository
                        echo 'Cloning ${GITHUB_REPO}...'
                        git clone git@github.com:prateekrajgautam/${GITHUB_REPO}.git
                        
                        # Configure git
                        cd ${GITHUB_REPO}
                        git config user.name 'Prateek Raj Gautam'
                        git config user.email 'prateekrajgautam@gmail.com'
                        
                        echo '✓ Repository cloned and configured'
                    "
                '''
            }
        }
        
        stage('Copy PDFs to Repo') {
            steps {
                echo 'Copying compiled PDFs...'
                sh '''
                    nix-shell --run "
                        echo 'Copying PDF files to repository...'
                        
                        # Remove old V01 directory
                        rm -rf ${GITHUB_REPO}/V01
                        
                        # Copy new PDFs
                        cp -r work_folder/PDF ${GITHUB_REPO}/V01
                        
                        echo '✓ Files copied to V01 directory'
                        ls -lh ${GITHUB_REPO}/V01/
                    "
                '''
            }
        }
        
        stage('Commit and Push') {
            steps {
                echo 'Committing and pushing changes...'
                sh '''
                    nix-shell --run "
                        cd ${GITHUB_REPO}
                        
                        # Check git status
                        git status
                        
                        # Stage all changes
                        git add .
                        
                        # Check if there are changes to commit
                        if git diff --staged --quiet; then
                            echo 'No changes to commit'
                        else
                            # Commit with build info
                            git commit -m 'Update resume - Jenkins ${BUILD_INFO}'
                            
                            # Push to GitHub
                            git push origin main
                            
                            echo '✓ Successfully pushed to GitHub Pages!'
                        fi
                    "
                '''
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline execution complete'
            sh '''
                nix-shell --run "
                    echo 'Build artifacts:'
                    ls -lh work_folder/PDF/*.pdf 2>/dev/null || echo 'No PDFs found'
                "
            '''
        }
        success {
            echo '✅ Pipeline succeeded!'
            echo 'Resume updated at: https://prateekrajgautam.github.io/V01/'
        }
        failure {
            echo '❌ Pipeline failed!'
            echo 'Check the logs above for details'
        }
        cleanup {
            echo 'Cleaning up workspace...'
            sh 'rm -rf ${GITHUB_REPO} || true'
        }
    }
}
