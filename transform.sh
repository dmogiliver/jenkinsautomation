#!/bin/bash

template_file='jenkinsjob.template'

job_name=$1
url="https\:\/\/github.com\/dmogiliver\/${job_name}\.git"

cat $template_file | sed -e "s/JOBNAME/${job_name}/g" | sed -e "s/URL/${url}/g" > ${job_name}.xml

