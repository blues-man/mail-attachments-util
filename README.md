mail-attachments-util
=====================

An utility for purging and backuping Attachments of Mail client (Mac OS X)

This simple tool let you deal easily with your large attachments data of Mail Mac OS X client.
You can use it to backup your files to an external drive or to delete them definitely from your disk, saving space and efforts.

In order to do this, put your backup PATH in the EXTERNAL_DRIVE variabile into the script.
If your Mail is installed elsewhere than your $HOME, please update also it.

The script is configured to backup your attachments, so if you don't pass any option, it will save all your attachments file
in the external drive dir, organized by your account.

e.g. /Volumes/HD/Backupdir/IMAP-foo@foo.com/{INBOX,Sent Messages,any}.mbox/file1.jpg,doc.docx,file.odt

Simply launch it with no parameters to save your attachments to an external dir (this WON'T delete your attachments)

If you want to purge your Mail attachments' dir, use --delete option. You may want to use also --ask if doubtful about deleting process


Usage:

./mail_util.sh                    # Backup all your attachments to $EXTERNAL_DRIVE"

./mail_util.sh [--delete] [--ask] # Delete all your attachments, when used with --ask it ask you for each file found, if you really want to delete it."

