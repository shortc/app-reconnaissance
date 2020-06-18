#!/bin/bash

traverseDirectory(){
	declare -a BadTrustM_Arr=(AcceptAllTrustM AllTrustM DummyTrustM EasyX509TrustM FakeTrustM
	FakeX509TrustM FullX509TrustM NaiveTrustM NonValidatingTrustM NullTrustM OpenTrustM
	PermissiveX509TrustM SimpleTrustM SimpleX509TrustM TrivialTrustM TrustAllManager TrustAllTrustM 
	TrustAnyCertTrustM Unsafex509TrustM VoidTrustM)
	
	declare -a BadSslSocFac_Arr=(AccpetAllSSLSocketF AllTrustingSSLSocketF AllTrustingSSLSocketF
	AllSSLSocketF DummySSLSocketF EasySSLSocketF FakeSSLSocketF InsecureSSLSocketF
	NonValidatingSSLSocketF NaiveSslSocketF SimpleSSLSocketF SSLSocketFUntrustedCert
	SSLUntrustedSocketF TrustAllSSLSocketF TrustEveryoneSocketF NaiveTrustManagerF
	LazySSLSocketF UnsecureTrustManagerF)

	for fileName in `ls $1 --sort=extension --group-directories-first`; do

		if [ -f "$1/$fileName" ]; then

			for i in ${!BadTrustM_Arr[*]}; do


				if [ $(grep -ic '${BadTrustM_Arr[i]}' $1/$fileName) -ne "0" ]; then
					echo ""
					echo "TRUST MANAGER ISSUE: $1/$fileName :"
					grep -in '${BadTrustM_Arr[i]}' $1/$fileName
					echo ""
					echo STILL SEARCHING...
					echo ""
				fi

				if [ $(grep -ic '${BadSslSocFac_Arr[i]}' $1/$fileName) -ne "0" ]; then
					echo ""
					echo "SSL SOCKET FACTORY ISSUE: $1/$fileName :"
					grep -in '${BadSslSocFac_Arr[i]}' $1/$fileName
					echo ""
					echo STILL SEARCHING...
					echo ""
				fi

			done 

			if [ $(grep -ic "allow_all_hostname" $1/$fileName) -ne "0" ]; then
				echo ""
				echo "All HOSTNAMES ALLOWED: $1/$fileName :"
				grep -in "allow_all_hostname" "$1/$fileName"
				echo ""
				echo STILL SEARCHING...
				echo ""
			fi

			if [ $(grep -ic "allowallhostname" $1/$fileName) -ne "0" ]; then
				echo ""
				echo "All HOSTNAMES ALLOWED: $1/$fileName :"
				grep -in "allowallhostname" "$1/$fileName"
				echo ""
				echo STILL SEARCHING...
				echo ""
			fi

		fi
		
    	if [ -d "$1/$fileName" ]; then
       	    #echo "$1/$fileName"
        	traverseDirectory "$1/$fileName"
	 	fi
    
    done
}

echo SEARCHING DIRECTORIES...
traverseDirectory 'smali/com'
echo ALL USES OF HTTP:
grep -inr "http//" smali/com/
echo DONE