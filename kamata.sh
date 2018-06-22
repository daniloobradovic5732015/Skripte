#!/bin/bash
PROGNAME=$(basename $0)
usage () {
	cat <<- EOF
	Usage: $PROGNAME PRINCIPAL INTEREST MONTHS
	
	Where: 
	
	PRINCIPAL is the amount of loan.
	INTEREST is the APR as a number (7%=0.07).
	MONTHS is the lenght of the loan's term.

	EOF
}

# Ako pri unosu nismo uneli 3 argumenta, onda prikazi upustvo i izadji
if (($# != 3));then
	usage
	exit 1
fi

principal=$1
interest=$2
months=$3
bc <<- EOF
	scale=10
	i=$interest / 12
	p=$principal
	n=$months
	a=p * ((i * ((1+i) ^ n)) / (((1+i) ^ n) - 1))
	print a, "\n"
EOF

