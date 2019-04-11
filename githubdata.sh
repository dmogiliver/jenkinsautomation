#!/bin/sh
# This job runs every minute to fetch new repos on https://github.com/dmogiliver/ account.
# the admin must edit the file to reflect the user name registered with GitHub


curl -s https://api.github.com/users/dmogiliver/repos|grep clone_url|sed 's/^.\{17\}//'|sed 's/"//g'|sed 's/,//g'>/var/lib/jenkins/remoterepos/gitrepourl.txt

# directory is hardcoded to insure consistency if was executed by a different user.

lasturl=$(tail -1 gitrepourl.txt) #declaring $lasturl variable based on the last repo GitHub created

# echo "$lasturl" | sed 's/.\{4\}$//' #stripping last 4 characters ".git" from the URL

jenkins_new_jobname=$(echo $lasturl|sed 's/.\{4\}$//') #setting the new job's name based on the GitHub job name

jenkins_new_jobname="${jenkins_new_jobname##*/}" #declaring a new variable to be used in the Jenkins job name

#echo "$jenkins_new_jobname"


#Runtime constructing the new template by substituting $jenkins_new_jobname with the actual job name and the $lasturl fetched from the github

cat <<EOF
$<?xml version='1.1' encoding='UTF-8'?>
<project>
  <actions/>
  <description>"$jenkins_new_jobname"</description>
  <keepDependencies>false</keepDependencies>
  <properties/>
  <scm class="hudson.plugins.git.GitSCM" plugin="git@3.9.3">
    <configVersion>2</configVersion>
    <userRemoteConfigs>
      <hudson.plugins.git.UserRemoteConfig>
        <url>"$lasturl"</url>
      </hudson.plugins.git.UserRemoteConfig>
    </userRemoteConfigs>
    <branches>
      <hudson.plugins.git.BranchSpec>
        <name>*/master</name>
      </hudson.plugins.git.BranchSpec>
    </branches>
    <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
    <submoduleCfg class="list"/>
    <extensions/>
  </scm>
  <canRoam>true</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers>
    <com.cloudbees.jenkins.GitHubPushTrigger plugin="github@1.29.4">
      <spec></spec>
    </com.cloudbees.jenkins.GitHubPushTrigger>
  </triggers>
  <concurrentBuild>false</concurrentBuild>
  <builders>
    <hudson.tasks.Shell>
      <command>npm install
./script/test
./script/deploy</command>
    </hudson.tasks.Shell>
  </builders>
  <publishers/>
  <buildWrappers/>
</project>
EOF

rm gitrepourl.txt



