; Q12 Write a program that moves the data from one string to another string
.model small
.stack 100h
.data
	msg db "Enter string : ","$"
	msg1 db "String moved from str1 to str2 : ","$"
    str1 db  100 Dup("$")
    str2 db  100 Dup("$")
	lenstr1 dw 0
	
.code
  main proc
	mov ax,@data
	mov ds,ax
	
	mov ah,09h
	mov dx,offset msg
	int 21h
	
	;take input from user
	mov si,offset str1
	
	InputString:
		mov ah,01h
		int 21h
		cmp al,13
		je EndString
		mov [si],al
		inc lenstr1
		inc si
		jmp InputString
	
	EndString:
		mov si,offset str1
		mov di, offset str2
		
	mov cx,lenstr1
	Copying:
		mov al,[si]
		mov [di],al
		xor al,al  ; Set al to 0 (null character)
		mov [si],al
		inc si
		inc di
		loop Copying
		
	mov ah,09h
	mov dx,offset msg1
	int 21h
	
	mov ah,09h
	mov dx,offset str2
	int 21h
	
	mov ah,04ch
	int 21h
  main endp
end