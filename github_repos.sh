#extracting jobs from github and stripping everything to output githubjobs.tmp

curl -s https://api.github.com/users/dmogiliver/repos|grep clone_url|sed 's/^.\{17\}//'|sed 's/"//g'|sed 's/,//g'| sed 's/.\{4\}$//'|sed 's@.*/@@'>githubjobs.tmp

