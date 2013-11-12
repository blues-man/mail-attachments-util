#!/bin/bash
# mail_util.sh: an utility for purging and backuping Attachments of Mail client (Mac OS X)
# author: Natale Vinto <ebballon at gmail dot com>

MAIL_FOLDER="/Users/$(whoami)/Library/Mail/V2/"
EXTERNAL_DRIVE="" # FILL ME!!!!

OPTION=$1
MODE=$2
VERSION="0.1"

help(){
	echo "Mail Attachments Util $VERSION"
	echo "Usage:"
	echo -e "./mail_util.sh\t\t\t\t# Backup all your attachments to $EXTERNAL_DRIVE"
	echo -e "./mail_util.sh [--delete] [--ask]\t# Delete all your attachments, when used with --ask it ask you for each file found, if you really want to delete it."
	exit 
}
 

if [ -n "$OPTION" -a "$OPTION" = "--help" ]; then
	help
fi 

if [ ! -d $EXTERNAL_DRIVE ]; then
	echo "Please ensure that your $EXTERNAL_DRIVE dir really exists and is full writable"
	exit
fi

chflags nohidden ~/Library

mkdir -p $EXTERNAL_DRIVE

cd $MAIL_FOLDER

IFS=$'\n'
folders=($(find . -type d -name Attachments))
for dir in "${folders[@]}"
do
	SUPER=$(echo $dir | egrep -oEi "/(.*)mbox")
	#FOLDER=$(echo $dir | cut -d '/' -f 3)
	if [ -n "$OPTION" -a "$OPTION" = "--delete" ]; then
		if [ -n "$MODE" -a "$MODE" = "--ask" ]; then
			while true; do
    			read -p "Do you really want to delete all attachments from $SUPER [y/N]?" yn
    				case $yn in
       					 [Yys]* ) rm -fr $dir/*; echo "Done"; break;;
        				 [Nn]* ) break;;
        		 	 	* ) break;;
    				esac
			done
		else
			echo "Deleting all attachments of $SUPER .."
			rm -fr $dir/*
			echo "Done"	
		fi
	else
		mkdir -p $EXTERNAL_DRIVE/$SUPER
		echo "find $dir"
		find $dir  -type f  -exec cp {} $EXTERNAL_DRIVE/$SUPER/ \;
		size=$(du -csh $EXTERNAL_DRIVE/$SUPER/  | awk {"print \$1;"})
		echo "Attachments for $dir: $size"
	fi
done


echo ""
if [ -n "$OPTION" -a "$OPTION" = "--delete" ]; then
	size2=$(du -csh $MAIL_FOLDER | awk {"print \$1;"})
	echo "New space for Mail dir: $size2"
else
	size2=$(du -csh $EXTERNAL_DRIVE/ | awk {"print \$1;"})
	echo "Total attachments saved size on $EXTERNAL_DRIVE : $size2"
fi
