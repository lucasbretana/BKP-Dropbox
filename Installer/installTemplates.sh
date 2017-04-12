#!/bin/bash

##############################################################
# @author Lucas E. Bretana
#
# Sets all the templates links
#
##############################################################

main () 
{
  if [ "$(basename $(pwd))" != "Templates" ];then
    echo -e "\nThis should be run from inside the Templates forlder, you want to continue? (y/n) "
    read -n 1 ANS
    echo " "
    if [ "$ANS" = "y" ] || [ "$ANS" = "Y" ]; then
      echo "OK";
    else
      echo "Aborting"
      return 1;
    fi
  fi

  echo -e "\nForce links creation? (y/n)";
  echo "Note: the old files will be saved";
  echo "Note2: if not to force, gonna ask for each";
  read -n 1 ANS
  if [ "$ANS" = "y" ] || [ "$ANS" = "Y" ]; then
    echo -e "\nOK";
    export LN_FLAG="-f -b";
  else
    echo -e "\nAin't gonna force nothing"
    LN_FLAG="-i";
  fi

  check;
  file_install "." "."

  echo "All done"
}

check(){
  if [ -z "$XDG_TEMPLATES" ]; then
    echo -e "\nXDG_TEMPLES not set!" 1>&2
    echo "Use: $HOME/Templates ? (y/n)"
    read -n 1 ANS
    if [ "$ANS" = "y" ] || [ "$ANS" = "Y" ]; then
      XDG_TEMPLATES="$HOME"/Templates;
    else
      read XDG_TEMPLATES
    fi
  fi
  ANS=n;
  while [[ "$ANS" != "y" && "$ANS" != "Y" ]]; do
    echo -e "\nThe template directorie is set to $XDG_TEMPLATES"
    echo "Use it? (y/n)"
    read -n 1 ANS
    if [ "$ANS" != "y" ] && [ "$ANS" != "Y" ]; then
      echo -e "\nSo, set it: "
      read XDG_TEMPLATES
    else
      export XDG_TEMPLATES
    fi
  done

}

file_install () 
{
  cd "$2";
  LIST=`ls`;

  for file in $LIST; {
    if [ -d "$file" ];then
      mkdir "$XDG_TEMPLATES"/"$1"/"$2"/"$file" 2> /dev/null || true;
      file_install "$1" "$file";
    else
      ln -s $LN_FLAG $(pwd -P)/"$file" "$XDG_TEMPLATES"/"$1"/"$2"/"$file";
    fi
  }
  cd ..
}

main
