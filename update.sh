#!/bin/bash
# generate items
hugo --minify
# generte index
bash crawelurls.sh
# add changed files to commit auto
git add .
# commit the chages
git commit -m "commit automatically by shell script"
# Attention!! pull before push!!
git pull origin master
# push the local master branch to remote repo
git push origin master 
# push the local master branch to coding pages repo
# git push mirror master:master
# deploy to firebase
# firebase deploy
# push index to Baidu Spider
curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?site=https://kaiyai.com&token=swIICtyYi3ptMPHm"

