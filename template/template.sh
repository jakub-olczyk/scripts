#!/bin/bash
TEMPLATES_DIR=`xdg-user-dir TEMPLATES`

# double parentheses required for the regex to work
if [[ $LANG =~ "pl_PL." ]]; then
	TITLE="template"
	DESCRIPTION="służy do tworzenia plików z szablonów, które znajdują się w katalogu domowym użytkownika"
	OPTIONS="opcje: "
	SPECIFY_FILENAME="Podaj nazwę nowego pliku!"
	NO_OPTIONS="Brak"
else
	TITLE="template"
	DESCRIPTION="a script for creating files from templates in the users home directory"
	OPTIONS="options: "
	SPECIFY_FILENAME="Please specify a filename!"
	NO_OPTIONS="None"
fi

if [ -z $1 ] ; then
	echo $TITLE
	echo $DESCRIPTION
	echo $OPTIONS
	echo
	SEARCH_RESULTS=`find -P $TEMPLATES_DIR \
	   	-maxdepth 1 -type l -print | cut -d '/' -f 5`
	if [ -z $SEARCH_RESULTS ]; then
		echo $NO_OPTIONS
	else
		echo $SEARCH_RESULTS
	fi
	exit 1
fi
if [ -z $2 ] ; then
	echo $SPECIFY_FILENAME
	exit
fi
cp $TEMPLATES_DIR/$1 ./$2
