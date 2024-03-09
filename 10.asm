; Q10 Write a program which converts the small letters to capital letters in a given string
.model small
.stack 100h
.data
	msg db "Enter the string: ","$"
	msg1 db "The resultant string will be : ","$"
    str1 db  100 Dup("$")
    str2 db  100 Dup("$")
	
.code
  main proc
	mov ax,@data
	mov ds,ax
	
	mov ah,09h
	mov dx,offset msg
	int 21h
	
	;take string from user
	mov si,offset str1
	mov di,offset str2
	
	InputString1:
		mov ah,01h
		int 21h
		cmp al,13
		je Next
		mov [si],al
		cmp al,'a'
		jl skip
		cmp al,'z'
		jg skip
		sub al,32
		mov [di],al
		skip:
			mov [di],al
			inc si
			inc di
			jmp InputString1
	

	Next:
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