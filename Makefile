CC=gcc
CFLAGS=-m32 -O1 -W -Wall -pedantic -std=c99
LDFLAGS = -m32

gestioneVettore:
	gcc -m32 -g -o gestioneVettore gestioneVettore.s
