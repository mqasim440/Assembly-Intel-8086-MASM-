; Q16 Write a program that convert the letter into small at input time
.model small
.stack 100h
.data
	msg db "Enter the string(capital letters will be converted to small remaining as it is)(Press Enter to end input): ","$"
    str1 db  100 Dup("$")
	
.code
  main proc
	mov ax,@data
	mov ds,ax
	
	mov ah,09h
	mov dx,offset msg
	int 21h
	
	;take string from user
	mov si,offset str1
	
	InputString1:
		mov ah,07h
		int 21h
		cmp al,13
		je Exit
		mov [si],al
		cmp al,'A'
		jl skip
		cmp al,'Z'
		jg skip
		add al,32
		mov ah,02h
		mov dl,al
		int 21h
		inc si
		jmp InputString1
		skip:
			mov ah,02h
			mov dl,al
			int 21h
			inc si
			jmp InputString1
	
	Exit:
		mov ah,04ch
		int 21h
  main endp
end