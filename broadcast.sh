#!/bin/bash

broadcastAPI=(abortBroadcast clearAbortBroadcast getAbortBroadcast getDebugUnregister 
getResultCode getResultData getResultExtras goAsync isInitialStickyBroadcast isOrderedBroadcast
onReceive peekService setDebugUnregister setOrderedHint setResult setResultCode setResultData
setResultExtras)

broadApps=()

finishCount=0
finish=0
appNum=0
count=1
check=0

for fileName in `ls $1`; do
    check=0
    echo "$count/53"
    for i in ${broadcastAPI[@]}; do
        if [ $(grep -ir -m 1 ${i} $fileName/smali/com | wc -l) -eq "1" ]; then
            echo $fileName
            check=1
		fi
    done
    if [ "$check" -eq 1 ]; then
        appNum=$((appNum+1))
        broadApps+=($fileName)
    fi
    count=$((count+1))
done
echo $appNum
for i in ${broadApps[@]}; do
    echo ${i}
done
