#!/bin/bash


BadTrustM_Arr=(AcceptAllTrustM AllTrustM DummyTrustM EasyX509TrustM FakeTrustM
	FakeX509TrustM FullX509TrustM NaiveTrustM NonValidatingTrustM NullTrustM OpenTrustM
	PermissiveX509TrustM SimpleTrustM SimpleX509TrustM TrivialTrustM TrustAllManager TrustAllTrustM 
	TrustAnyCertTrustM Unsafex509TrustM VoidTrustM)
	
BadSslSocFac_Arr=(AccpetAllSSLSocketF AllTrustingSSLSocketF AllTrustingSSLSocketF
	AllSSLSocketF DummySSLSocketF EasySSLSocketF FakeSSLSocketF InsecureSSLSocketF
	NonValidatingSSLSocketF NaiveSslSocketF SimpleSSLSocketF SSLSocketFUntrustedCert
	SSLUntrustedSocketF TrustAllSSLSocketF TrustEveryoneSocketF NaiveTrustManagerF
	LazySSLSocketF UnsecureTrustManagerF)


finishCount=0
finish=0
appNum=0
count=1

for fileName in `ls -d */`; do
    #echo "$count/53"
    for i in ${BadSslSocFac_Arr[@]}; do
    	if [ $(grep -ir -m 1 ${i} $fileName/smali/com | wc -l) -eq "1" ]; then
			appNum=$((appNum+1))
    	    echo $fileName
		fi
    done
    count=$((count+1))
done
echo "Total number of apps with SSL vulnerabilities"
echo $appNum
