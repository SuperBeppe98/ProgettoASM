gestioneVettore:
	gcc -m32 -g -o gestioneVettore gestioneVettore.s
	as --32 -o gestioneVettore.o gestioneVettore.s

