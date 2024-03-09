; Q7 Write a program that takes to string from the user and diplay after concatinating them
.model small
.stack 100h
.data
	msg db "Enter first string : ","$"
	msg1 db "Enter second string : ","$"
    msg2 db "Concatinated String is : ","$"
    str1 db  100 Dup("$")
    str2 db  100 Dup("$")
	
.code
  main proc
	mov ax,@data
	mov ds,ax
	
	mov ah,09h
	mov dx,offset msg
	int 21h
	
	;take first string from user
	mov cx,0
	mov si,offset str1
	
	InputString1:
		mov ah,01h
		int 21h
		cmp al,13
		je Next
		mov [si],al
		inc cx
		inc si
		jmp InputString1
	

	Next:
		mov ah,09h
		mov dx,offset msg1
		int 21h
		
	;take seoncd string from user
	mov cx,0
	mov si,offset str2
	
	InputString2:
		mov ah,01h
		int 21h
		cmp al,13
		je Concatinate
		mov [si],al
		inc cx
		inc si
		jmp InputString2
		
	Concatinate:
		mov ah,09h
		mov dx,offset msg2
		int 21h
		
		mov ah,09h
		mov dx,offset str1
		int 21h
		
		mov ah,09h
		mov dx,offset str2
		int 21h
	
	
	mov ah,04ch
	int 21h
  main endp
end