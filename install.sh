#!/bin/bash
if [ -d $1/system ]; then
	cp -r releases/* $1/
	echo "Installed Coolreader to $1"
else
	echo "The path is an invalid Pocketbook root directory"
	exit
fi
