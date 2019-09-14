#!/usr/bin/env bash

(( loopInSecs = 2000 )) # 55 mins
(( loopUntil=$(date -u +%s)+${loopInSecs%.*} ))
echo $loopUntil
while [ $(date -u +%s) -lt $loopUntil ]; do
    t=$(date -u +%s)
    echo "hello world" $t 
    if [ $(($t % 10)) = 2 ]; then
    break
    fi
    sleep 3
done

echo "done"