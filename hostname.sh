#!/bin/bash

hostname=(allow_all_hostname allowallhostname)

finishCount=0
finish=0
appNum=0
count=1
check=0

for fileName in `ls -d */`; do
    #echo "$count/53"
    for i in ${hostname[@]}; do
        if [ $(grep -ir -m 1 ${i} $fileName/smali/com | wc -l) -eq "1" ]; then
	    	appNum=$((appNum+1))
            echo $fileName
	    fi
    done
    count=$((count+1))
done
echo "Total number of apps with SSL vulnerabilities"
echo $appNum