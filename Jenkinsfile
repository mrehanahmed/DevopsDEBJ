#!groovy
import groovy.json.JsonSlurperClassic
node {

    def BUILD_NUMBER=env.BUILD_NUMBER
    def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
    def SFDC_USERNAME

    def HUB_ORG=env.HUB_ORG_DH
    def SFDC_HOST = env.SFDC_HOST_DH
    def JWT_KEY_CRED_ID = env.JWT_CRED_ID_DH
    def CONNECTED_APP_CONSUMER_KEY=env.CONNECTED_APP_CONSUMER_KEY_DH

    println 'KEY IS' 
    println JWT_KEY_CRED_ID
    println HUB_ORG
    println SFDC_HOST
    println CONNECTED_APP_CONSUMER_KEY
    def toolbelt2 = tool 'toolbelt2'    
	

    stage('checkout source') {
        // when running in multi-branch job, one must issue this command
        checkout scm
    }

    withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')]) {
        stage('Deploy Code') {
            def rc
			if (isUnix()) {
                rc = sh returnStatus: true, script: "${toolbelt2} auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
            }else{
		    //bat "${toolbelt2} plugins:install salesforcedx@49.5.0"
		    //bat "${toolbelt2} update"
		    //bat "${toolbelt2} auth:logout -u ${HUB_ORG} -p" 
                 rc = bat returnStatus: true, script: "${toolbelt2} auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --loglevel DEBUG --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
            }
		
            if (rc != 0) { 
		    println 'inside rc 0'
		    error 'hub org authorization failed' 
	    }
		else{
			println 'rc not 0'
		}

			println rc
			
			// need to pull out assigned username
			def rmsg
			if (isUnix()) {
				//rmsg = sh returnStdout: true, script: "${toolbelt2} force:mdapi:deploy -d manifest/. --target-org ${HUB_ORG}"
				//rmsg = sh returnStdout: true, script: "${toolbelt2}  project deploy start -x manifest/package.xml -o ${HUB_ORG} --test-level RunLocalTests"
				rmsg = sh returnStdout: true, script: "${toolbelt2}  project deploy start -d force-app -o ${HUB_ORG} --test-level RunLocalTests"
			}else{
				println 'project deploy start -d force-app -o HUB_ORG --test-level RunLocalTests'
				rmsg = bat returnStdout: true, script: "${toolbelt2}  project deploy start -d force-app -o ${HUB_ORG} --test-level RunLocalTests"
			   //rmsg = bat returnStdout: true, script: "${toolbelt2}  project deploy start -x manifest/package.xml -o ${HUB_ORG} --test-level RunLocalTests"
			   //rmsg = bat returnStdout: true, script: "${toolbelt2}  force:mdapi:deploy -d manifest/. --target-org ${HUB_ORG}"
			}
			  
            //printf rmsg
            println('Hello from a Job DSL script!')
            println(rmsg)
        }
    }
}
