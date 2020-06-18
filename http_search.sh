#!/bin/bash

both=0
only=0
good=0

for fileName in `ls -d */`; do
    uses_http=$(grep -r -n -i "http://" $fileName/smali/com)
    found_http=$?
    uses_https=$(grep -r -n -i "https://" $fileName/smali/com)
    found_https=$?

    if [ $found_http -eq 0 ] && [ $found_https -eq 0 ]
    then
        echo "$fileName: 'HTTP://' and 'HTTPS://'"
        both=$((both+1))
        #echo $uses_http | grep -o -E '\b(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]' \
        #| sort -u
        #echo $uses_https | grep -o -E '\b(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]' \
        #| sort -u

    elif [ $found_http -eq 0 ]
    then
        echo "$fileName: ONLY 'HTTP://'"
        only=$((only+1))
        #echo $uses_http | grep -o -E '\b(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]' \
        #| sort -u
    else
        echo "$fileName: GOOD"
        good=$((good+1))
    fi
done

echo "Use of both"
echo $both
echo "Use of only HTTP"
echo $only
echo "GOOD"
echo $good