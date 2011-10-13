#!/bin/bash

mitre="https://cve.mitre.org/cgi-bin/cvename.cgi?name="
wget -q -O cve.html $1

for cve in `egrep 'CVE-[0-9]{4}-[0-9]{4}' cve.html | sed -r 's/.*(CVE-[0-9]{4}-[0-9]{4}).*/\1/g'`
do
    wget -q -O $cve.html "$mitre$cve"
    if grep -q "RESERVED" $cve.html
    then
        rm $cve.html
    else
        echo $cve
    fi        
done

rm cve.html
