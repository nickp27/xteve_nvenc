#!/bin/bash

crond -l 2

XTEVE_FILE=/config/xteve.txt

if [ -f "$XTEVE_FILE" ]; then
	. $XTEVE_FILE
else
	cp /example_xteve.txt /config/example_xteve.txt
	xteve -port=34400 -config=/root/.xteve/
fi

exit
