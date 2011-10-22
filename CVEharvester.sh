#!/bin/bash

mitre="https://cve.mitre.org/cgi-bin/cvename.cgi?name="
wget -q -O cve.html $1

for cve in `sed 's/>/>\n/g' cve.html | egrep 'CVE-[0-9]{4}-[0-9]{4}'  | sed -r 's/.*(CVE-[0-9]{4}-[0-9]{4}).*/\1/g'`
do
    wget -q -O $cve.html "$mitre$cve"
    if grep -q "RESERVED" $cve.html
    then
        echo "Skipped" $cve
        rm $cve.html
    else
        echo $cve
    fi        
done

rm cve.html
