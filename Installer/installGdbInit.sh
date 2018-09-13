#!/bin/bash

##############################################################
# @author Lucas E. Bretana
#
# Install the gdbinit file
#
##############################################################

main () 
{
  echo "The files that gonna be installed are:";
  for i in $@;do
    echo "-> $i";
  done
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
  
  for i in $@;do
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
    echo " ";
    if [ "$ANS" = "y" ] || [ "$ANS" = "Y" ];then
      FILES=`ls -I install.sh`;
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
