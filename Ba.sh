#!/bin/bash
echo "Hello!"
echo "Author is Grohotova Ekaterina"
echo "Name of programm is Ba.sh"
echo "This program displays the access rights of a specific user to a specific file"

cur_dir=$(pwd)
echo "Current directory is $cur_dir"
echo

touch file.txt
touch error
XUSER="kate"
PASSWD="password"

per1=y
while [ "$per1" = "y" ]
do
	
	/usr/sbin/useradd -G users,cdrom,floppy,audio,video,plugdev,users,lp -s /bin/shell -p $PASSWD -d /home/xuser $XUSER 2>> error
	per2=1
	while [ "$per2" = 1 ]
	do
		read -p "Please enter the name of file for which you want to know access rights - " file_name
		if [[ -f "$file_name" ]]
		then
		#нашел
			echo "find"
			break
		else
			echo "No file name found"
			echo "No file name found" >> error
		fi
	done
	
	per3=1
	while [ "$per3" = 1 ]
	do
		read -p "Please enter the user name - " user_name
		grep -q "$user_name" /etc/passwd
		if [ $? -eq 0 ]
		then
		#нашел
			echo "find"
			break
		else
			echo "No username found"
			echo "No username found" >> error
		fi
	done
	
	find / -type f -user "$user_name" -print 2>> error | grep -q "$file_name"
	if [ $? -eq 0 ]
	then 
		ls -l "$file_name" | head -c 4 2>> error
		echo
	else
		ls -l "$file_name" | cut -b 8-10 2>> error
		echo
	fi
	
	per4=y
	while [ "$per4" = y ]
	do
		echo "Do you wish to continue? y/n"
		read per4
		if [ "$per4" = y ]
		then
			break
		elif [ "$per4" = n ]
		then
			if [ -s error ]
			then 
				echo "error.txt:"
				cat error
				echo "Bye-Bye"
				exit 0
			else
				echo "Bye-Bye"
				exit 0
			fi
		else
			echo "You entered an invalid value"
			echo "You entered an invalid value" >> error
			per4=y
		fi
	done
done 