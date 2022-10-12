#!/bin/bash

case "$1" in
	*.tar*) tar tf "$1";;
	*.txt) batcat --terminal-width "$4" "$1";;
	*.sh) batcat --terminal-width "$4" "$1";;
	*.py) batcat --terminal-width "$4" "$1";;
	*.json) cat "$1";;
	*.v) cat "$1";;
	*.vsh) cat "$1";;
	*.jpg) viu -w "$2" "$1";;
	*.png) viu -w "$2" "$1";;
esac
