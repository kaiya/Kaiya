#!bin/sh

siteurl="https://kaiyai.com"
echo '' > urls.txt
for file in ./public/post/*
do
    if test -d $file
    then
        echo ${siteurl}${file:8} >> urls.txt
    fi
done
