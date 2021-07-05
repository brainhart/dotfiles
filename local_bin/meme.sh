#!/bin/bash

block_letters () {
	echo "$@" | sed 's/[a-zA-Z]/:alphabet-white-&:/g; s/ /    /g; s/#/:alphabet-white-hash:/g; s/@/:alphabet-white-at:/g; s/?/:alphabet-white-question:/g; s/!/:alphabet-white-exclamation:/g;'
}
