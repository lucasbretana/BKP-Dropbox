#!/bin/bash

##############################################################
# @author Lucas E. Bretana
#
#	move the bashrc file to $HOME/.bashrc
#
# this files set many usefull stuff that are load per terminal
#
##############################################################

FILE="bashrc"
export $FILE;

COMM="cp ./$FILE $HOME/.$FILE"

echo "--- Putting the file $FILE on $HOME folder as .$FILE ---";
if [ -f "$HOME/.$FILE" ]; then
	while true; do
		echo -e "\nThe file exists, override? (It will be saved as $HOME/.$FILE.old)";
		echo -e "\ny/N";
		read -n 1 OP;
		echo -e "\n";
		if [ "$OP" = "y" ] || [ "$OP" = "Y" ]; then
			COMM="cp $HOME/.$FILE $HOME/.$FILE.old && "$COMM;
			echo -e "\n$COMM\n";
			$COMM && echo -e "\nDone";
			if [ $? -ne 0 ]; then
				echo -e "\nSomething went wrong!";
			fi
			break;
		elif [ "$OP" = "n" ] || [ "$OP" = "N" ]; then
			echo -e "\nAborting!";
			break;
		fi
	done;
else
	$COMM && echo -e "\nDone";
fi

## Manual execute after creating a new of this kind
# cat install_bashrc.sh | sed -e s/HERE/$FILE/g  > new_file && mv new_file install_bashrc.sh
