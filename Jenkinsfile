pipeline {

    agent {
        kubernetes {
            inheritFrom 'jenkins-nexus'
            defaultContainer 'jnlp'
        }
    }

    options {

        timestamps()

        ansiColor('xterm')

        disableConcurrentBuilds()

        buildDiscarder(
            logRotator(
                numToKeepStr: '20',
                artifactNumToKeepStr: '20'
            )
        )

    }

    environment {

        // =====================================================
        // Application
        // =====================================================

        APP_NAME = "abc-technologies"

        NAMESPACE = "abc-technologies"

        VERSION = "v${BUILD_NUMBER}"

        DOCKERHUB_IMAGE = "bharatdasa/abc-technologies"

        APP_VERSION = ""

        // =====================================================
        // GitHub
        // =====================================================

        GIT_REPOSITORY = "git@github.com:BharatDasa/ABC-Technologies.git"

        // =====================================================
        // Nexus Docker Registry
        // =====================================================

        REGISTRY = "192.168.56.11:8082"

        IMAGE = "${REGISTRY}/abc-technologies"

        // =====================================================
        // Monitoring
        // =====================================================

        PROM_URL = "http://monitoring-kube-prometheus-prometheus.monitoring.svc:9090"

        // =====================================================
        // Ansible
        // =====================================================

        ANSIBLE_HOST_KEY_CHECKING = "False"

    }

    stages {

        /******************************************************
         * Initialize Version
         ******************************************************/

        stage('Initialize Version') {

            steps {

                script {

                    env.APP_VERSION =
                        "1.0.${BUILD_NUMBER}-${System.currentTimeMillis()}"

                }

                echo "Application Version : ${env.APP_VERSION}"

            }

        }

        /******************************************************
         * Clone Repository
         ******************************************************/

        stage('Clone Repository') {

            steps {

                git(
                    url: "${GIT_REPOSITORY}",
                    credentialsId: "github-ssh"
                )

            }

        }

        /******************************************************
         * Build Application
         ******************************************************/

        stage('Build Application') {

            steps {

                container('maven') {

                    sh '''

                    echo "=============================================="

                    mvn clean deploy \
                        -U \
                        -DskipTests \
                        -Drevision=${APP_VERSION} \
                        -Dchangelist=""

                    echo "=============================================="

                    '''

                }

            }

        }

        /******************************************************
         * Build Docker Image
         ******************************************************/

        stage('Build & Push Docker Image') {

            steps {

                container('kaniko') {

                    sh '''

                    echo "=============================================="

                    /kaniko/executor \
                        --dockerfile=Dockerfile \
                        --context="$(pwd)" \
                        --destination=${IMAGE}:latest \
                        --destination=${IMAGE}:${VERSION} \
                        --destination=${DOCKERHUB_IMAGE}:latest \
                        --destination=${DOCKERHUB_IMAGE}:${VERSION} \
                        --insecure \
                        --skip-tls-verify


                    echo "=============================================="

                    '''

                }

            }

        }
                /******************************************************
         * Ansible Auto Fix
         ******************************************************/

        stage('Ansible Auto-Fix') {

            steps {

                container('ansible') {

                    withCredentials([
                        sshUserPrivateKey(
                            credentialsId: 'ansible-ssh-key',
                            keyFileVariable: 'SSH_KEY'
                        )
                    ]) {

                        sh '''

                        chmod 600 $SSH_KEY

                        ansible-playbook \
                            -i ansible/inventory.ini \
                            ansible/playbooks/auto-fix.yml \
                            --private-key=$SSH_KEY \
                            -u bharat

                        '''

                    }

                }

            }

        }

        /******************************************************
         * Validation & Security
         ******************************************************/

        stage('Validation & Security') {

            parallel {

                /**********************************************
                 * Ansible Precheck
                 **********************************************/

                stage('Ansible Precheck') {

                    steps {

                        container('ansible') {

                            withCredentials([
                                sshUserPrivateKey(
                                    credentialsId: 'ansible-ssh-key',
                                    keyFileVariable: 'SSH_KEY'
                                )
                            ]) {

                                sh '''

                                chmod 600 $SSH_KEY

                                ansible-playbook \
                                    -i ansible/inventory.ini \
                                    ansible/playbooks/precheck.yml \
                                    --private-key=$SSH_KEY \
                                    -u bharat

                                '''

                            }

                        }

                    }

                }

                /**********************************************
                 * Trivy HTML Report
                 **********************************************/

                stage('Trivy HTML Report') {

                    steps {

                        container('trivy') {

                            sh '''

                            rm -rf /tmp/trivy-html

                            mkdir -p /tmp/trivy-html

                            mkdir -p reports

                            wget -q \
                              https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/html.tpl \
                              -O html.tpl

                            trivy image \
                                --cache-dir /tmp/trivy-html \
                                --timeout 45m \
                                --scanners vuln \
                                --format template \
                                --template "@html.tpl" \
                                -o reports/trivy-report.html \
                                ${IMAGE}:${VERSION} || true

                            '''

                        }

                    }

                }

                /**********************************************
                 * Trivy Critical Gate
                 **********************************************/

                stage('Trivy Critical Scan') {

                    steps {

                        container('trivy') {

                            sh '''

                            rm -rf /tmp/trivy-gate

                            mkdir -p /tmp/trivy-gate

                            trivy image \
                                --cache-dir /tmp/trivy-gate \
                                --timeout 45m \
                                --scanners vuln \
                                --severity CRITICAL \
                                --ignore-unfixed \
                                --exit-code 1 \
                                ${IMAGE}:${VERSION}

                            '''

                        }

                    }

                }

            }

        }

        /******************************************************
         * Publish Trivy Report
         ******************************************************/

        stage('Publish Trivy Report') {

            steps {

                publishHTML([

                    reportDir: 'reports',

                    reportFiles: 'trivy-report.html',

                    reportName: 'Trivy Security Report',

                    keepAll: true,

                    alwaysLinkToLastBuild: true,

                    allowMissing: true

                ])

            }

        }
                /******************************************************
         * Deploy Application
         ******************************************************/

        stage('Deploy Application') {

            steps {

                container('ansible') {

                    withCredentials([
                        sshUserPrivateKey(
                            credentialsId: 'ansible-ssh-key',
                            keyFileVariable: 'SSH_KEY'
                        )
                    ]) {

                        sh '''

                        chmod 600 $SSH_KEY

                        ansible-playbook \
                            -i ansible/inventory.ini \
                            ansible/playbooks/deploy.yml \
                            --private-key=$SSH_KEY \
                            -u bharat \
                            -e image="${IMAGE}:${VERSION}" \
                            -e workspace="${WORKSPACE}"
                        '''

                    }

                }

            }

        }

        /******************************************************
         * Application Health Check
         ******************************************************/

        stage('Health Check') {

            steps {

                container('ansible') {

                    withCredentials([
                        sshUserPrivateKey(
                            credentialsId: 'ansible-ssh-key',
                            keyFileVariable: 'SSH_KEY'
                        )
                    ]) {

                        sh '''

                        chmod 600 $SSH_KEY

                        ansible-playbook \
                            -i ansible/inventory.ini \
                            ansible/playbooks/healthcheck.yml \
                            --private-key=$SSH_KEY \
                            -u bharat

                        '''

                    }

                }

            }

        }

        /******************************************************
         * Verify Prometheus
         ******************************************************/

        stage('Verify Monitoring') {

            steps {

                sh '''

                RESPONSE=$(curl -s ${PROM_URL}/api/v1/query?query=up)

                if echo "$RESPONSE" | grep -q '"status":"success"'
                then

                    echo "========================================"
                    echo "Prometheus is reachable"
                    echo "========================================"

                else

                    echo "========================================"
                    echo "Prometheus is NOT reachable"
                    echo "========================================"

                    exit 1

                fi

                '''

            }

        }

        /******************************************************
         * Cleanup
         ******************************************************/

        stage('Cleanup') {

            steps {

                container('ansible') {

                    withCredentials([
                        sshUserPrivateKey(
                            credentialsId: 'ansible-ssh-key',
                            keyFileVariable: 'SSH_KEY'
                        )
                    ]) {

                        sh '''

                        chmod 600 $SSH_KEY

                        ansible-playbook \
                            -i ansible/inventory.ini \
                            ansible/playbooks/cleanup.yml \
                            --private-key=$SSH_KEY \
                            -u bharat

                        '''

                    }

                }

            }

        }

    }

    /******************************************************
     * Post Actions
     ******************************************************/

    post {

        always {

            archiveArtifacts(
                artifacts: 'reports/*.html',
                allowEmptyArchive: true
            )

        }

        success {

            echo ""
            echo "========================================"
            echo "ABC-Technologies Deployment Successful"
            echo "========================================"
            echo "Application : ${APP_NAME}"
            echo "Image       : ${IMAGE}:${VERSION}"
            echo "Namespace   : ${NAMESPACE}"
            echo "Repository  : ${GIT_REPOSITORY}"
            echo ""
            echo "Application URL"
            echo "https://abc.192.168.56.100.nip.io"
            echo "========================================"

        }

        failure {

            script {

                container('ansible') {

                    withCredentials([
                        sshUserPrivateKey(
                            credentialsId: 'ansible-ssh-key',
                            keyFileVariable: 'SSH_KEY'
                        )
                    ]) {

                        sh '''

                        chmod 600 $SSH_KEY

                        ansible-playbook \
                            -i ansible/inventory.ini \
                            ansible/playbooks/rollback.yml \
                            --private-key=$SSH_KEY \
                            -u bharat || true

                        '''

                    }

                }

            }

            echo ""
            echo "========================================"
            echo "Deployment Failed"
            echo "Rollback Completed"
            echo "========================================"

        }

    }

}