#!/bin/bash

isExist=true
i=1
while "${isExist}"; do
	if [[ $i -lt 10 ]]; then
		if	wget -O "omc00$i.html" "https://onlinemathcontest.com/contests/omc00$i/tasks/"; then
			i=$i
		else
			isExist=false
		fi
	elif [[ $i -lt 100 ]]; then
		if	wget -O "omc0$i.html" "https://onlinemathcontest.com/contests/omc0$i/tasks/"; then
			i=$i
		else
			isExist=false
		fi
	else
		if	wget -O "omc$i.html" "https://onlinemathcontest.com/contests/omc$i/tasks/"; then
			i=$i
		else
			isExist=false
		fi
	fi	
	i=$((i+1))
done
