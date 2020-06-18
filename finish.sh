#!/bin/bash

broadcastAPI=(abortBroadcast clearAbortBroadcast getAbortBroadcast getDebugUnregister 
getResultCode getResultData getResultExtras goAsync isInitialStickyBroadcast isOrderedBroadcast
onReceive peekService setDebugUnregister setOrderedHint setResult setResultCode setResultData
setResultExtras)

finishCount=0
finish=0
appNum=0

for fileName in `ls $1`; do
    echo $fileName
    if [ $(grep -ir -m 1 "finish()" $fileName/smali/com | wc -l) -eq "1" ]; then
		appNum=$((appNum+1))
	fi
    finish=$(grep -ir "finish()" $fileName/smali/com | wc -l)
    finishCount=$((finishCount+finish))
done
echo $finishCount
echo $appNum
