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

main "$@";
