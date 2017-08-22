#!/bin/bash
if yum list installed chef >/dev/null 2>&1; then 
 exit 0
else  
	sudo rpm -ivh /tmp/chef-pkgs/chef-13.3.42-1.el7.x86_64.rpm
fi