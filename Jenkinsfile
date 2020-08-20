#!groovy

node {

    def HUB_ORG=env.HUB_ORG_DH
    def SFDC_HOST = env.SFDC_HOST_DH
    def JWT_KEY_CRED_ID = env.JWT_CRED_ID_DH
    def CONNECTED_APP_CONSUMER_KEY=env.CONNECTED_APP_CONSUMER_KEY_DH
	//def TEST_LEVEL='RunLocalTests'
	def TEST_LEVEL= 'RunSpecifiedTests'
	def TEST_CLASSES = "AccountControllerTest,ContactControllerTest"

    println 'KEY IS' 
    println JWT_KEY_CRED_ID
    println HUB_ORG
    println SFDC_HOST
    println CONNECTED_APP_CONSUMER_KEY

    //def SF_INSTANCE_URL = env.SF_INSTANCE_URL ?: "https://test.salesforce.com"


    def toolbelt = tool 'toolbelt'


    // -------------------------------------------------------------------------
    // Check out code from source control.
    // -------------------------------------------------------------------------

    stage('checkout source') {
        checkout scm
    }


    // -------------------------------------------------------------------------
    // Run all the enclosed stages with access to the Salesforce
    // JWT key credentials.
    // -------------------------------------------------------------------------

 	withEnv(["HOME=${env.WORKSPACE}"]) {	
	
	    withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')]) {
		// -------------------------------------------------------------------------
		// Authenticate to Salesforce using the server key.
		// -------------------------------------------------------------------------

		stage('Authorize to Salesforce') {
			rc = command "\"${toolbelt}\" force:auth:logout --targetusername ${HUB_ORG} -p & \"${toolbelt}\" force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile \"${jwt_key_file}\" --setalias QA --instanceurl ${SFDC_HOST}"
                if (rc != 0) { error 'Salesforce org authorization failed.'}
                println rc
		}


		// -------------------------------------------------------------------------
		// Deploy metadata and execute unit tests.
		// -------------------------------------------------------------------------

		stage('Deploy and Run Tests') {
		    //rc = command "\"${toolbelt}\" force:source:deploy  -x manifest/package.xml -u ${HUB_ORG} -l ${TEST_LEVEL}"
		    rc=command "\"${toolbelt}\" force:source:deploy  -x manifest/package.xml -u ${HUB_ORG} -l ${TEST_LEVEL} -r ${TEST_CLASSES}"
		    //rc = command "\"${toolbelt}\" force:source:deploy  -p force-app/. -u ${HUB_ORG} -l ${TEST_LEVEL}"
		    if (rc != 0) {
			error 'Salesforce deploy and test run failed.'
		    }
		}


		// -------------------------------------------------------------------------
		// Example shows how to run a check-only deploy.
		// -------------------------------------------------------------------------

		//stage('Check Only Deploy') {
		//    rc = command "\"${toolbelt}\" force:source:deploy  -x manifest/package.xml -u ${HUB_ORG} --testlevel ${TEST_LEVEL}"
		//rmsg = bat returnStdout: true, script:"\"${toolbelt}\" force:source:deploy   -u ${HUB_ORG}"
		//    if (rc != 0) {
		//        error 'Salesforce deploy failed.'
		//    }
		//}
	    }
	}
}

def command(script) {
    if (isUnix()) {
        return sh(returnStatus: true, script: script);
    } else {
		return bat(returnStatus: true, script: script);
    }
}
