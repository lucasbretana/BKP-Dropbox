#!/bin/bash

##############################################################
# @author Lucas E. Bretana
#
# Sets all the bash files
#
##############################################################

main () 
{
  echo "The files that gonn be installed are: $@";
  echo "They gonna be located at the \"$HOME \" folder";
  echo "Use that folder? (y/n)";
  read -n 1 ANS;
  FOLDER="$HOME";
  while [[ "$ANS" != "Y" && "$ANS" != "y" ]];do
    echo -e "\nSo, set it";
    read FOLDER;
    echo -e "\nUse \"$FOLDER\" ? (y/n)";
    read -n 1 ANS;
  done
  echo -e "\nOK";
  
  for i in "$@";do
    ln -si "$(pwd -P)"/"$i" "$FOLDER"/'.'"$i";
  done
}

check () 
{
  FILES="$@";
  if [ -z "$FILES" ];then
    echo "You did not specify the files";
    echo "So, should I install all those in this folder? (y/n)";
    echo "PS: I will not do this recursively";
    read -n 1 ANS
    if [ "$ANS" = "y" ] || [ "$ANS" = "Y" ];then
      FILES="ls";
      echo -e "NOTE: in this case, there will be a small bug, this shell will also be linked :(";
    else
      echo -e "\nWell, aborting"
      return 1;
    fi
  fi
}
check "$@";
if [ "$?" = "0" ];then
  main "$FILES";
else
  exit 1;
fi
