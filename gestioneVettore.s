.section .bss
    elemento:   .byte 0
    #Elemento per inserimento valori

.section .data
    vettore:    .fill 10,1,0
    #Vettore composto da 10 elementi da 1 byte ciascuno con valore 0
    
    vettoreLength:  .byte 10
    #Lunghezza del vettore

    formato: .string "%i" 
    #Formato input usato per la scanf

    stampaInvito: .string "Inserimento dei %i interi che compongono il vettore...\n" 
    #Invito per inserimento elemento

    invito: .string "Inserire l'intero in posizione %i: " 
    #Invito per inserimento elemento

    stampaOpzioni1: .string "\nOPERAZIONI DISPONIBILI\n"
    stampaOpzioni2: .string "----------------------\n"
    stampaOpzioni3: .string "1) stampa a video del vettore inserito\n"
    stampaOpzioni4: .string "2) stampa a video del vettore inserito in ordine inverso\n"
    stampaOpzioni5: .string "3) stampa il numero di valori pari e dispari inseriti\n"
    stampaOpzioni6: .string "4) stampa la posizione di un elemento inserito dall'utente\n"
    stampaOpzioni7: .string "5) stampa il massimo elemento inserito\n"
    stampaOpzioni8: .string "6) stampa la posizione del massimo elemento inserito\n"
    stampaOpzioni9: .string "7) stampa il minimo elemento inserito\n"
    stampaOpzioni10: .string "8) stampa la posizione del minimo elemento inserito\n"
    stampaOpzioni11: .string "9) stampa elemento inserito con maggior frequenza\n"
    stampaOpzioni12: .string "10) stampa la media intera dei valori inseriti\n"
    #Stampa opzioni disponbili
    
    stampaOperazione: .string "\nInserire elemento operazione (0 uscita, -1 ristampa menu'): " 
    #Operazione da effettuare

    msgError:   .string "Opzione non supportata dall'applicazione!\n"
    #Messaggio di errore per input non supportati

    stampaValoriInseriti: .string "Valori inseriti: \n"
    #Stampa dei valori inseriti

    valoriInseritiInversi: .string "Valori inseriti (ordine di inserimento invertito):\n"
    #Stampa dei valori inseriti inversi

    stampaElemento: .string "Valore %i: %i\n"
    #Stampa elemento 

    stampaElementiPari: .string "Numero di valori pari inseriti: %i\n"
    #Stampa il numero di elementi pari
    
    stampaElementiDispari: .string "Numero di valori dispari inseriti: %i\n"
    #Stampa il numero di elementi dispari

    stampaElementoMax: .string "Massimo valore inserito: %i\n"
    #Stampa l'elemento massimo
    
    stampaPosizioneMax: .string "Posizione del massimo valore inserito: %i\n"
    #Stampa la posizione dell'elemento massimo
        
    invitoPosizione: .string "Inserire l'intero da cercare: " 
    #Invito per inserimento elemento 

    posizioneNo: .string "Valore %i non trovato\n"
    #Stampa posizione non trovata

    posizioneSi: .string "Posizione del valore %i: %i\n"
    #Stampa posizione trovata

    stampaElementoMin: .string "Minimo valore inserito: %i\n"
    #Stampa l'elemento minimo

    stampaPosizioneMin: .string "Posizione del minimo valore inserito: %i\n"
    #Stampa la posizione dell'elemento minimo
    
    valore: .string "Inserire il valore da ricercare: " 
    #Valore da ricercare

    valoreFrequenza: .string "Valore inserito con maggior frequenza: %i\n"
    #stampa valore inserito con maggiore frequenza

    stampaMedia: .string "Media valori: %i\n"
    #Stampa la media

    msgOut: .string "Uscita dall'applicazione...\n"
    #Messaggio di fine programma

.section .text
    .global main
main:
    xorl %eax, %eax                 #Azzero il registro eax
    xorl %ebx, %ebx                 #Azzero il registro ebx
    xorl %ecx, %ecx                 #Azzero il registro ecx
    xorl %esi, %esi                 #Azzero il registro esi
    movb vettoreLength, %bl         #Lunghezza del vettore

    pushl %ebx                      #Inserimento parametro per la stampa
    pushl $stampaInvito             #Inserimento parametro per la stampa
    call printf                     #Chiamata printf
    addl $8, %esp                   #Sommo 8 byte ad esp per riportare indietro lo stack di una pushl

    decl vettoreLength              #Decremento di 1 la lunghezza del vettore per l'elemento in posizione 0
ciclo:
    movl %esi, %ecx                 #Sposto il contenuto di esi nel registro ecx
    incb %cl                        #Incremento il registro ecx
    
    pushl %ecx                      #Inserimento parametro per la stampa
    pushl $invito                   #Inserimento parametro per la stampa
    call printf                     #Chiamata printf
    addl $8, %esp                   #Sommo 8 byte ad esp per riportare indietro lo stack di una pushl
    
    pushl $elemento                 #Inserimento parametro per la scansione
    pushl $formato                  #Inserimento parametro per la scansione
    call scanf                      #Chiamata scanf
    addl $8, %esp                   #Sommo 8 byte ad esp per riportare indietro lo stack di due pushl

    movb elemento, %al              #Sposto l'elemento nel registro eax
    movb %al, vettore(%esi)         #Sposto l'elemento dal registro eax al vettore in posizione esi
    incl %esi                       #Incremento il registro esi
    cmpl %esi, %ebx                 #Comparo il registro esi col registro ebx
    jg ciclo                        #Salto verso l'etichetta ciclo se il registro ebx è maggiore di esi

operazione:
    call stampaOpzioni              #Chiamata funzione stampaOpzioni

    pushl $stampaOperazione         #Inserimento parametro per la stampa
    call printf                     #Chiamata printf
    addl $4, %esp                   #Sommo 4 byte ad esp per riportare indietro lo stack di una pushl

    pushl $elemento                 #Inserimento parametro per la scansione
    pushl $formato                  #Inserimento parametro per la scansione
    call scanf                      #Chiamata scanf
    addl $8, %esp                   #Sommo 8 byte ad esp per riportare indietro lo stack di due pushl

    movb elemento, %bl              #Sposto l'elemento nel registro eax

eseguiOpzione:
    cmpb $0, %bl                    #Comparo 0 con il registro ebx
    je fine                         #Se 0 e il registro ebx sono uguali salto all'etichetta fine

pre_eseguiStampaOpzioni:
    cmpb $255, %bl                  #Comparo 255 con il registro ebx
    je eseguiStampaOpzioni          #Se 255 e il registro ebx sono uguali salto all'etichetta eseguiStampaOpzioni
    jne pre_eseguiStampa            #Se 255 e il registro ebx non sono uguali salto all'etichetta pre_eseguiStampa

eseguiStampaOpzioni:
    jmp operazione                  #Salto incondizionato all'etichetta operazione

pre_eseguiStampa:
    cmpb $1, %bl                    #Comparo 1 con il registro ebx
    je eseguiStampa                 #Se 1 e il registro ebx sono uguali salto all'etichetta eseguiStampa
    jne pre_eseguiStampaInversa     #Se 1 e il registro ebx non sono uguali salto all'etichetta pre_eseguiStampaInversa

eseguiStampa:
    xorl %edx, %edx                 #Azzero il registro edx
    movb $0, %dl                    #Sposto 0 nel registro edx
    call stampa                     #Chiamata funzione stampa
    jmp operazione                  #Salto incondizionato all'etichetta operazione

pre_eseguiStampaInversa:
    cmpb $2, %bl                    #Comparo 2 con il registro ebx
    je eseguiStampaInversa          #Se 2 e il registro ebx sono uguali salto all'etichetta eseguiStampaInversa
    jne pre_eseguiNumeriPari        #Se 2 e il registro ebx non sono uguali salto all'etichetta pre_eseguiNumeriPari

eseguiStampaInversa:
    xorl %edx, %edx                 #Azzero il registro edx
    movb $1, %dl                    #Sposto 1 nel registro edx
    call stampa                     #Chiamata funzione stampa
    jmp operazione                  #Salto incondizionato all'etichetta operazione

pre_eseguiNumeriPari:
    cmpb $3, %bl                    #Comparo 3 con il registro ebx
    je eseguiNumeriPari             #Se 3 e il registro ebx sono uguali salto all'etichetta eseguiNumeriPari
    jne pre_eseguiPosizioneValore   #Se 3 e il registro ebx non sono uguali salto all'etichetta pre_eseguiPosizioneValore

eseguiNumeriPari:
    call numeroPari                 #Chiamata funzione numeroPari
    jmp operazione                  #Salto incondizionato all'etichetta operazione

pre_eseguiPosizioneValore:
    cmpb $4, %bl                    #Comparo 4 con il registro ebx
    je eseguiPosizioneValore        #Se 4 e il registro ebx sono uguali salto all'etichetta eseguiPosizioneValore
    jne pre_eseguiCalcoloMax        #Se 4 e il registro ebx non sono uguali salto all'etichetta pre_eseguiCalcoloMax

eseguiPosizioneValore:
    call cercaValore                #Chiamata funzione cercaValore
    jmp operazione                  #Salto incondizionato all'etichetta operazione

pre_eseguiCalcoloMax:
    cmpb $5, %bl                    #Comparo 5 con il registro ebx
    je eseguiCalcoloMax             #Se 5 e il registro ebx sono uguali salto all'etichetta eseguiCalcoloMax
    jne pre_eseguiPosizioneMax      #Se 5 e il registro ebx non sono uguali salto all'etichetta pre_eseguiPosizioneMax

eseguiCalcoloMax:
    xorl %edx, %edx                 #Azzero il registro edx
    movb $0, %dl                    #Sposto 0 nel registro edx
    call calcolaMax                 #Chiamata funzione calcolaMax
    jmp operazione                  #Salto incondizionato all'etichetta operazione

pre_eseguiPosizioneMax:
    cmpb $6, %bl                    #Comparo 6 con il registro ebx
    je eseguiPosizioneMax           #Se 6 e il registro ebx sono uguali salto all'etichetta eseguiCalcoloMax
    jne pre_eseguiCalcoloMin        #Se 6 e il registro ebx non sono uguali salto all'etichetta eseguiCalcoloMax

eseguiPosizioneMax:
    call posizioneMax               #Chiamata funzione posizioneMax
    jmp operazione                  #Salto incondizionato all'etichetta operazione

pre_eseguiCalcoloMin:
    xorl %edx, %edx                 #Azzero il registro edx
    movb $0, %dl                    #Sposto 0 nel registro edx
    cmpb $7, %bl                    #Comparo 7 con il registro ebx
    je eseguiCalcoloMin             #Se 7 e il registro ebx sono uguali salto all'etichetta eseguiCalcoloMin
    jne pre_eseguiPosizioneMin      #Se 7 e il registro ebx non sono uguali salto all'etichetta pre_eseguiPosizioneMin

eseguiCalcoloMin:
    call calcolaMin                 #Chiamata funzione calcolaMin
    jmp operazione                  #Salto incondizionato all'etichetta operazione

pre_eseguiPosizioneMin:
    cmpb $8, %bl                    #Comparo 8 con il registro ebx
    je eseguiPosizioneMin           #Se 8 e il registro ebx sono uguali salto all'etichetta eseguiPosizioneMin
    jne pre_eseguiFrequenza         #Se 8 e il registro ebx non sono uguali salto all'etichetta pre_eseguiFrequenza

eseguiPosizioneMin:
    call posizioneMin               #Chiamata funzione posizioneMin
    jmp operazione                  #Salto incondizionato all'etichetta operazione

pre_eseguiFrequenza:
    cmpb $9, %bl                    #Comparo 9 con il registro ebx
    je eseguiFrequenza              #Se 9 e il registro ebx sono uguali salto all'etichetta eseguiFrequenza
    jne pre_eseguiCalcoloMedia      #Se 9 e il registro ebx non sono uguali salto all'etichetta pre_eseguiCalcoloMedia

eseguiFrequenza:
    call valoreFrequente            #Chiamata funzione valoreFrequente
    jmp operazione                  #Salto incondizionato all'etichetta operazione

pre_eseguiCalcoloMedia:
    cmpb $10, %bl                   #Comparo 10 con il registro ebx
    je eseguiCalcoloMedia           #Se 10 e il registro ebx sono uguali salto all'etichetta eseguiCalcoloMedia
    jne default                     #Se 10 e il registro ebx non sono uguali salto all'etichetta default

eseguiCalcoloMedia:
    call calcoloMediaIntera         #Chiamata funzione calcoloMediaIntera
    jmp operazione                  #Salto incondizionato all'etichetta operazione

default:
    pushl $msgError                 #Inserimento parametro per la stampa
    call printf                     #Chiamata printf
    addl $4, %esp                   #Sommo 4 byte ad esp per riportare indietro lo stack di una pushl
    jmp operazione                  #Salto incondizionato all'etichetta operazione

//Stampa opzioni
.type stampaOpzioni, @function
stampaOpzioni:
    pushl $stampaOpzioni1       	#Inserimento parametro per la stampa
    call printf                 	#Chiamata printf
    addl $4, %esp               	#Sommo 4 byte ad esp per riportare indietro lo stack di una pushl
    pushl $stampaOpzioni2       	#Inserimento parametro per la stampa
    call printf                 	#Chiamata printf printf
    addl $4, %esp               	#Sommo 4 byte ad esp per riportare indietro lo stack di una pushl
    pushl $stampaOpzioni3       	#Inserimento parametro per la stampa
    call printf                 	#Chiamata printf printf
    addl $4, %esp               	#Sommo 4 byte ad esp per riportare indietro lo stack di una pushl
    pushl $stampaOpzioni4       	#Inserimento parametro per la stampa
    call printf                 	#Chiamata printf printf
    addl $4, %esp               	#Sommo 4 byte ad esp per riportare indietro lo stack di una pushl
    pushl $stampaOpzioni5       	#Inserimento parametro per la stampa
    call printf                 	#Chiamata printf printf
    addl $4, %esp               	#Sommo 4 byte ad esp per riportare indietro lo stack di una pushl
    pushl $stampaOpzioni6       	#Inserimento parametro per la stampa
    call printf                 	#Chiamata printf printf
    addl $4, %esp               	#Sommo 4 byte ad esp per riportare indietro lo stack di una pushl
    pushl $stampaOpzioni7       	#Inserimento parametro per la stampa
    call printf                 	#Chiamata printf printf
    addl $4, %esp               	#Sommo 4 byte ad esp per riportare indietro lo stack di una pushl
    pushl $stampaOpzioni8       	#Inserimento parametro per la stampa
    call printf                 	#Chiamata printf printf
    addl $4, %esp               	#Sommo 4 byte ad esp per riportare indietro lo stack di una pushl
    pushl $stampaOpzioni9       	#Inserimento parametro per la stampa
    call printf                 	#Chiamata printf printf
    addl $4, %esp               	#Sommo 4 byte ad esp per riportare indietro lo stack di una pushl
    pushl $stampaOpzioni10      	#Inserimento parametro per la stampa
    call printf                 	#Chiamata printf printf
    addl $4, %esp               	#Sommo 4 byte ad esp per riportare indietro lo stack di una pushl
    pushl $stampaOpzioni11      	#Inserimento parametro per la stampa
    call printf                 	#Chiamata printf printf
    addl $4, %esp               	#Sommo 4 byte ad esp per riportare indietro lo stack di una pushl
    pushl $stampaOpzioni12      	#Inserimento parametro per la stampa
    call printf                 	#Chiamata printf printf
    addl $4, %esp               	#Sommo 4 byte ad esp per riportare indietro lo stack di una pushl
    ret                         	#Return della funzione

//Funzione stampa del vettore
.type stampa, @function
stampa:
    xorl %esi, %esi                 #Azzero il registro Esi
    movb vettoreLength, %bl         #Inserisco la lunghezza del vettore nel registro Ebx
    cmpb $0 , %dl                   #Comparo 0 col registro edx
    jne stampaInversa               #Se 0 e il registro edx non sono uguali salto all'etichetta stampaInversa
    pushl $stampaValoriInseriti     #Inserimento parametro per la stampa
    call printf                     #Chiamata printf
    addl $4, %esp                   #Sommo 4 byte ad esp per riportare indietro lo stack di una pushl
    jmp stampaLoop                  #Salto incondizionato all'etichetta stampaLoop

stampaInversa:
    pushl $valoriInseritiInversi    #Inserimento parametro per la stampa
    call printf                     #Chiamata printf
    addl $4, %esp                   #Sommo 4 byte ad esp per riportare indietro lo stack di una pushl
    jmp stampaLoopInversa           #Salto incondizionato all'etichetta stampaLoopInversa

stampaLoop:
    movb vettore(%esi), %al         #Sposto il contenuto del vettore in posizione del registro Esi nel registro Al
    pushl %eax                      #Inserimento parametro per la stampa
    incl %esi                       #Incremento il registro Esi
    pushl %esi
    pushl $stampaElemento           #Inserimento parametro per la stampa
    call printf                     #Chiamata printf
    addl $12, %esp                  #Sommo 12 byte alregistro Esp per riportare indietro lo stack di due pushl
    cmpl %esi, %ebx                 #Comparo il registro esi col registro edx
    jge stampaLoop                  #Se il registro esi e il registro edx non sono uguali salto all'etichetta stampaLoop
    ret                             #Return della funzione

stampaLoopInversa:
    addl %ebx, %esi                 #Sposto il contenuto del registro ebx nel registro esi
    movb vettore(%esi), %al         #Sposto il contenuto del vettore in posizione del registro Esi nel registro Al
    incb %bl                        #Incremento il registro ebx
    pushl %eax                      #Inserimento parametro per la stampa
    pushl %ebx                      #Inserimento parametro per la stampa
    pushl $stampaElemento           #Inserimento parametro per la stampa
    call printf                     #Chiamata printf
    addl $12, %esp                  #Sommo 12 byte alregistro Esp per riportare indietro lo stack di due pushl
    decb %bl                        #Decremento il registro ebx
    subl %ebx, %esi					#Sottraggo dal contenuto del registro esi il registro ebx
    decb %bl						#Decremento il registro ebx
    cmpb $255, %bl					#Comparo 10 con il registro ebx
    jne stampaLoopInversa			#Se 255 e il registro ebx non sono uguali salto all'etichetta stampaLoopInversa
    ret								#Return della funzione

//Funzione contatore numeri pari e dispari
.type numeroPari, @function
numeroPari:
    xorl %ebx, %ebx                 #Azzero il registro ebx
    xorl %edx, %edx                 #Azzero il registro edx
    xorl %esi, %esi                 #Azzero il registro esi
    addb vettoreLength, %bl			#Sommo al registro ebx il valore di vettoreLength
    incb %bl                        #Incremento il registro ebx

numeriPariLoop:
    movb $2, %cl					#Sposto 2 nel registro ecx
    movb vettore(%esi), %al			#Sposto il contenuto del vettore in posizione esi nel registro eax
    divb %cl						#Divido il registro eax per il registro ecx
    cmpl $256, %eax					#Comparo 256 e il registro eax
    jge numeriPariLoopNo			#Se il registro eax è maggiore o uguale di 256 salto all'etichetta numeriPariLoopNo

numeriPariLoopSi:
    incl %edx                       #Incremento il registro edx

numeriPariLoopNo:
    incl %esi                       #Incremento il registro esi
    cmpl %esi, %ebx					#Comparo il registro esi con il registro ebx
    jne numeriPariLoop				#Se il registro esi e il registro ebx non sono uguali salto all'etichetta numeriPariLoop
    movl %edx, %esi					#Sposto il contenuto del registro edx nel registro esi
    movl %edx, %eax					#Sposto il contenuto del registro edx nel registro eax

    pushl %eax                      #Inserimento parametro per la stampa
    pushl $stampaElementiPari       #Inserimento parametro per la stampa
    call printf                     #Chiamata printf
    addl $8, %esp                   #Sommo 8 byte alregistro Esp per riportare indietro lo stack di due pushl

    movl %ebx, %eax					#Sposto il contenuto del registro ebx nel registro eax
    subl %esi, %eax					#Sottraggo al registro eax il registro esi
    pushl %eax                      #Inserimento parametro per la stampa
    pushl $stampaElementiDispari    #Inserimento parametro per la stampa
    call printf                     #Chiamata printf
    addl $8, %esp                   #Sommo 8 byte alregistro Esp per riportare indietro lo stack di due pushl
    ret								#Return della funzione

//Funzione calcolo posizione valore
.type cercaValore, @function
cercaValore:						
    pushl $invitoPosizione          #Inserimento parametro per la stampa
    call printf                     #Chiamata printf
    addl $4, %esp                   #Sommo 4 byte alregistro Esp per riportare indietro lo stack di due pushl

    pushl $elemento                 #Inserimento parametro per la scansione
    pushl $formato                  #Inserimento parametro per la scansione
    call scanf                      #Chiamata scanf
    addl $8, %esp                   #Sommo 8 byte alregistro Esp per riportare indietro lo stack di due pushl

    xorl %esi, %esi                 #Azzero il registro esi
    movl elemento, %eax				#Sposto l'elemento nel registro eax
    movb vettoreLength, %bl			#Sposto l'elemento vettoreLength nel registro ebx
    incb %bl                        #Incremento il registro ebx

posizioneValoreLoop:
    cmpb %al, vettore(%esi)			#Comparo il registro eax con il contenuto del vettore alla posizione esi
    jne posizioneValoreNo			#Se il registro eax e il contenuto del vettore alla posizione esi non sono uguali salto all'etichetta posizioneValoreNo

posizioneValoreSi:
    incl %esi                       #Incremento il registro esi
    pushl %esi                      #Inserimento parametro per la stampa
    pushl %eax                      #Inserimento parametro per la stampa
    pushl $posizioneSi              #Inserimento parametro per la stampa
    call printf                     #Chiamata printf
    addl $12, %esp                  #Sommo 12 byte alregistro Esp per riportare indietro lo stack di due pushl
    ret								#Return della funzione

posizioneValoreNo:
    incl  %esi                      #Incremento il registro esi
    cmpl %esi, %ebx					#Comparo il registro esi con il registro ebx
    jg posizioneValoreLoop			#Se il registro ebx è maggiore del registro esi salto all'etichetta posizioneValoreLoop
    pushl %eax                      #Inserimento parametro per la stampa
    pushl $posizioneNo              #Inserimento parametro per la stampa
    call printf                     #Chiamata printf
    addl $8, %esp                   #Sommo 8 byte alregistro Esp per riportare indietro lo stack di due pushl
    ret								#Return della funzione

//Funzione calcolo elemento massimo
.type calcolaMax, @function
calcolaMax:
    xorl %esi, %esi					#Azzero il registro esi
    movb vettoreLength, %bl         #Sposto l'elemento vettoreLength nel registro ebx 
    movb vettore(%esi), %al         #Sposto il contenuto del vettore in posizione esi nel registro eax
    incl %esi                       #Incremento il registro esi

maxLoop:
    cmpb %al, vettore(%esi)         #Comparo il registro eax con il contenuto del vettore in posizione esi
    jle maxLoopNo                   #Se il contenuto del vettore in posizione esi è minore o uguale al contenuto del registro eax salto all'etichetta maxLoopNo

maxLoopSi:
    movb vettore(%esi), %al         #Sposto il contenuto del vettore in posizione esi nel registro eax

maxLoopNo:
    incl %esi                      	#Incremento il registro esi
    cmpl %esi, %ebx                 #Comparo il registro esi con il registro ebx
    jge maxLoop                     #Se il registro ebx è maggiore o uguale al contenuto del registro esi salto all'etichetta maxLoop
    cmpb $0, %dl                    #Comparo 0 con il registro edx
    jne maxPosizione                #Se 0 e il registro edx non sono uguali salto all'etichetta maxPosizione

maxStampa:
    pushl %eax                      #Inserimento parametro per la stampa
    pushl $stampaElementoMax        #Inserimento parametro per la stampa
    call printf                     #Chiamata printf
    addl $8, %esp                   #Sommo 8 byte alregistro Esp per riportare indietro lo stack di due pushl
    ret                             #Return della funzione

maxPosizione:
    movl %eax, %edx            		#Sposto il contenuto del registro eax nel registro edx           
    ret                             #Return della funzione

//Funzione Posizione max
.type posizioneMax, @function
posizioneMax:
    xorl %edx, %edx                 #Azzero il registro edx
    movb $1, %dl                    #Sposto 1 nel registro edx
    call calcolaMax                 #Chiamata funzione calcolaMax
    xorl %esi, %esi                 #Azzero il registro esi
    movb %dl, %al                   #Sposto il contenuto del registro edx nel registro eax
    movb vettoreLength, %bl         #Sposto l'elemento vettoreLength nel registro ebx
    incb %bl                        #Incremento il registro ebx

posizioneMaxLoop:
    cmpb %al, vettore(%esi)         #Comparo il registro eax con il contenuto del vettore in posizione esi
    jne posizioneMaxNo              #Se il registro eax e il contenuto del vettore in posizione esi non sono uguali salto all'etichetta posizioneMaxNo

posizioneMaxSi:
    incl %esi                       #Azzero il registro esi
    pushl %esi                      #Inserimento parametro per la stampa
    pushl $stampaPosizioneMax       #Inserimento parametro per la stampa
    call printf                     #Chimata printf
    addl $8, %esp                   #Sommo 12 byte alregistro Esp per riportare indietro lo stack di due pushl
    ret                             #Return della funzione

posizioneMaxNo:
    incl  %esi                      #Incremento il registro esi
    cmpl %esi, %ebx                 #Comparo il contenuto del registro esi con il registro ebx
    jg posizioneMaxLoop             #Se il registro ebx è maggiore del registro esi salto all'etichetta posizioneMaxLoop

//Funzione calcolo elemento minimo
.type calcolaMin, @function
calcolaMin:
    xorl %esi, %esi                 #Azzero il registro esi
    movb vettoreLength, %bl         #Sposto l'elemento vettoreLength nel registro ebx
    movb vettore(%esi), %al         #Sposto il contenuto del vettore in posizione esi nel registro eax
    incl %esi                       #Incremento il registro esi

calcoloMinLoop:
    cmpb %al, vettore(%esi)         #Comparo il registro eax con il contenuto del vettore in posizione esi
    jge calcoloMinLoopNo            #Se il contenuto del vettore in posizione esi è maggiore o uguale al registro eax salto all'etichetta calcoloMinLoopNo

calcoloMinLoopSi:
    movb vettore(%esi), %al         #Sposto il contenuto del vettore in posizione esi nel registro eax

calcoloMinLoopNo:
    incl %esi                       #Incremento il registro esi
    cmpl %esi, %ebx                 #Comparo il registro esi con il registro ebx
    jge calcoloMinLoop              #Se il registro ebx è maggiore o uguale del registro esi salto all'etichetta calcoloMinLoop
    cmpb $0, %dl                    #Comparo 0 con il registro edx
    jne minPosizione                #Se 0 e il registro edx non sono uguali salto all'etichetta minPosizione

minStampa:
    pushl %eax                      #Inserimento parametro per la stampa
    pushl $stampaElementoMin        #Inserimento parametro per la stampa
    call printf                     #Chiamata printf
    addl $8, %esp                   #Sommo 8 byte alregistro Esp per riportare indietro lo stack di due pushl
    ret                             #Return della funzione

minPosizione:
    movl %eax, %edx                 #Sposto il contenuto del registro eax nel registro edx
    ret                             #Return della funzione

//Funzione Posizione min
.type posizioneMin, @function
posizioneMin:
    xorl %edx, %edx                 #Azzero il registro edx
    movb $1, %dl                    #Sposto 1 nel registro edx
    call calcolaMin                 #Chiamata funzione calcolaMin
    xorl %esi, %esi                 #Azzero il registro esi
    movb %dl, %al                   #Sposto il contenuto del registro edx nel registro eax
    movb vettoreLength, %bl         #Sposto l'elemento vettoreLength nel registro ebx
    incb %bl                        #Incremento il registro ebx

posizioneMinLoop:
    cmpb %al, vettore(%esi)         #Comparo il registro eax con il contenuto del vettore in posizione esi
    jne posizioneMinNo              #Se il registro eax e il contenuto del vettore in posizione esi non sono uguali salto all'etichetta posizioneMinNo

posizioneMinSi:
    incl %esi                       #Incremento il registro esi
    pushl %esi                      #Inserimento parametro per la stampa
   pushl $stampaPosizioneMin        #Inserimento parametro per la stampa
    call printf                     #Chiamata printf
    addl $8, %esp                   #Sommo 12 byte alregistro Esp per riportare indietro lo stack di due pushl
    ret                             #Return della funzione

posizioneMinNo:
    incl  %esi                      #Incremento il registro ebx
    cmpl %esi, %ebx                 #Comparo il registro esi con il registro ebx
    jg posizioneMinLoop             #Se il registro ebx è maggiore del registro esi salto all'etichetta posizioneMinLoop

//Funzione valoreFrequente
.type valoreFrequente @function
valoreFrequente:
    xorl %eax, %eax                 #Azzero il registro eax
    movb vettoreLength, %bl         #Sposto l'elemento vettoreLength nel registro ebx
    decb %bl                        #Decremento il registro ebx
    xorl %ecx, %ecx                 #Azzero il registro ecx
    xorl %edx, %edx                 #Azzero il registro edx
    xorl %esi, %esi                 #Azzero il registro esi
    xorl %edi, %edi                 #Azzero il registro edi
    addb vettore(%esi),%al          #Sommo al registro eax il contenuto del vettore in posizione esi

valoreFrequenteLoop:
    cmpb vettore(%edi), %al         #Comparo il contenuto del vettore in posizione edi con il registro eax
    jne controlloFrequenza          #Se il contenuto del vettore in posizione edi e il registro eax non sono uguali salto all'etichetta controlloFrequenza

incremento:
    incb %cl                        #Incremento il registro ecx

controllo1:
    incl %edi                       #Incremento il registro edx
    cmpl %ebx, %edi                 #Comparo il registro ebx con il registro edi
    je cambiociclo                  #Se il registro ebx con il registro edi sono uguali salto all'etichetta cambiociclo

controllo2:
    cmpl %ebx, %esi                 #Comparo il registro ebx con il registro esi
    je frequenzaStampa              #Se il registro ebx con il registro esi sono uguali salto all'etichetta frequenzaStampa
    jne valoreFrequenteLoop         #Se il registro ebx con il registro esi non sono uguali salto all'etichetta valoreFrequenteLoop

cambiociclo:
    xorl %edi, %edi                 #Azzero il registro edi
    incl %esi                       #Incremento il registro esi
    xorl %ecx, %ecx                 #Azzero il registro ecx
    movb vettore(%esi), %al         #Sposto al registro eax il contenuto del vettore in posizione esi
    jmp valoreFrequenteLoop         #Salto all'etichetta valoreFrequenteLoop

controlloFrequenza:
    cmpb %cl, %dl                   #Comparo il registro ecx con il registro edx
    jge controllo1                  #Se il registro edx è maggiore o uguale al registro ecx salto all'etichetta controllo1

invertiFrequenza:
    xorl %edx, %edx                 #Azzero il registro edx
    movb %cl, %dl                   #Sposto il contenuto del registro ecx nel registro edx
    movb %al, elemento              #Sposto il contenuto del registro eax nell'elemento
    jmp controllo1                  #Salto all'etichetta controllo1

frequenzaStampa:
    xorl %eax, %eax                 #Azzero il registro eax
    movb elemento, %al              #Sposto l'elemento nel registro eax
    pushl %eax                      #Inserimento parametro per la stampa
    pushl $valoreFrequenza          #Inserimento parametro per la stampa
    call printf                     #Chiamata printf
    addl $8, %esp                   #Sommo 8 byte alregistro Esp per riportare indietro lo stack di due pushl
    ret                             #Return della funzione

//Funzione calcolo media intera
.type calcoloMediaIntera, @function
calcoloMediaIntera:
    xorl %esi, %esi                 #Azzero il registro esi
    movb vettoreLength, %bl         #Sposto l'elemento vettoreLength nel registro ebx

calcoloMediaLoop:
    addb vettore(%esi), %al
    incl %esi                       #Incremento il registro esi
    cmpl %esi, %ebx                 #Comparo il registro esi con il registro ebx
    jge calcoloMediaLoop            #Se il registro ebx è maggiore o uguale del registro esi salto all'etichetta calcoloMediaLoop
    incb %bl                        #Incremento il registro ebx
    divb %bl                        #Divido il registro eax per il registro ebx
    movb $0, %ah
    
    pushl %eax                      #Inserimento parametro per la stampa
    pushl $stampaMedia              #Inserimento parametro per la stampa
    call printf                     #Chiamata printf
    addl $8, %esp                   #Sommo 8 byte alregistro Esp per riportare indietro lo stack di due pushl
    ret                           	#Return della funzione
											
//Fine programma
fine:
    pushl $msgOut                   #Inserimento parametro per la stampa
    call printf                     #Chiamata printf
    addl $4, %esp                   #Sommo 4 byte alregistro Esp per riportare indietro lo stack di due pushl
    xorl %ebx, %ebx                 #Azzero il registro ebx
    movl $1, %eax                   #Sposto 1 nel registro eax
    int $0x80                       #Chiamata funzione exit
