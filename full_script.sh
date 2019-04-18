#!/bin/sh
#formatted output from GitHub 
 curl -s https://api.github.com/users/dmogiliver/repos|grep clone_url|sed 's/^.\{17\}//'|sed 's/"//g'|sed 's/,//g'|sed 's/.\{4\}$//'| sed 's/^.//'|sed 's@.*/@@' > githubrepos.tmp 

# Getting list of jobs already in Jenkins
java -jar ./jenkins-cli.jar -s http://ec2-35-166-235-228.us-west-2.compute.amazonaws.com:8080 -auth @jenkins_secret list-jobs > jenkinsjobs.tmp

# Calculating the delta between the jobs in Jenkins and remote repo
diff --line-format=%L  jenkinsjobs.tmp githubrepos.tmp > difftotal.tmp

# Creating a temp result file
./transform_all.sh difftotal.tmp

# Loop. Loading the delta into Jenkins
for xml in *.xml; do
    java -jar ./jenkins-cli.jar -s http://ec2-35-166-235-228.us-west-2.compute.amazonaws.com:8080 -auth @jenkins_secret create-job ${xml%.xml} < ${xml}
done

# Removing temp files 
rm *.tmp
rm *.xml

    
