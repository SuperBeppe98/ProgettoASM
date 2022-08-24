gestioneVettore:
	gcc -m32 -g -o gestioneVettore gestioneVettore.s
	as --32 -o gestioneVettore.o gestioneVettore.s
	ld -m elf_i386 -s -o gestioneVettore gestioneVettore.o --entry main -lc