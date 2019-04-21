STACK SEGMENT STACK
   DB 64 DUP(?)
STACK ENDS
;-----------------------------------------------------
DATA SEGMENT
cadena db '          $'
ENTER DB 13,10, '$' 
contador db 0
txt1 db '  Suma de vocales: $'
DATA ENDS
;-----------------------------------------------------
CODE SEGMENT
Assume DS:DATA, CS:CODE, SS:STACK
BEGIN:mov ax,data
       mov ds,ax
	 ;-----------------------------------
       mov ah,00h  ;modo 80x25 a color
       mov al,03h
       int 10h
	;------ MODO DE PANTALLA-------------	
       mov cx,10   ; el contador vale 10
       mov si,0  ;puntero de pila en 0   
leer:  mov ah,07h ; esperar recibir un caracter y lo coloca en al
       int 21h 	   
	  
	   mov dl,al  ; se mueve a dl porque el 02 exhibe el caracter en dl
       mov ah,02h
       int 21h
       mov cadena[si],al
       inc si	   
       loop leer ; decrementa el contador     hasta que el contador sea 0 se detiene	   
	;--------------va a llenar el "arreglo"--------------------------------------	 	
	   mov cx,10
	   mov si,0
compara:cmp cadena[si], 97   ;-------la a -----------;
        JE CONTARAUX
	    cmp cadena[si], 65  ;-------la A -----------;
        JE CONTARAUX
        cmp cadena[si],101 ;-----------e-------------
		JE CONTARAUX
		cmp cadena[si],69    ; la E
		JE CONTARAUX
		cmp cadena [si],105;-------i----
		JE CONTARAUX
		cmp cadena [si], 73 ; LA I
		JE CONTARAUX
		cmp cadena[si],111;-----o-------
		JE CONTARAUX
		cmp cadena [si], 79 ; la O
		JE CONTARAUX
		cmp cadena[si],117;-----u-------
		JE CONTARAUX
		cmp cadena [si],85 ; la u
		JE CONTARAUX  
		inc si
AUX:    loop compara
	 ;--------Validar Vocales-----------------------------------
     ; cmp contador, 10
	  mov al,contador
	  aam
	  mov bx,ax
	  lea dx,ENTER
	  mov ah, 09h         
	  int 21h
	 
	 lea dx,txt1
	 mov ah, 09h        
	 int 21h
	 

	mov ah,02h
    mov dl,bh  	;Imprime la parte alta del registro BX, si el número es mayor de 9 imprime las decenas
    add dl,30h 	;Suma 30 para imprimir el número real.
    int 21h
	
	MOV AH,02H
	mov dl,bl 	;imprime la parte baja de BX o las unidades.
    add dl,30h
    int 21h
	jmp FIN
	
CONTARAUX: jmp CONTAR		 
	
	mov ah,2
    mov dl,contador    
	add dl, 48
	int 21h
FIN: MOV AX,4C00H
     INT 21H
     RET	 

CONTAR:
    inc contador
	inc si	
    JMP AUX
 
CODE ENDS
     END BEGIN
