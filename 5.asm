; Q5 Write a program that displays the length of given string
.model small
.stack 100h
.data
	msg db "Enter string : ","$"
    msg1 db "Length of given string is : ","$"
    str1 db  100 Dup("$")
    strlen dw 0
	pno dw 0
	cno dw 0
	ten dw 10
	
.code
  main proc
	mov ax,@data
	mov ds,ax
	
	mov ah,09h
	mov dx,offset msg
	int 21h
	
	;take input from user
	mov cx,0
	mov si,offset str1
	
	InputString:
		mov ah,01h
		int 21h
		cmp al,13
		je LengthStr
		mov [si],al
		inc cx
		inc si
		jmp InputString
	
	LengthStr:
		mov strlen,cx
		
		mov ah,09h
		mov dx,offset msg1
		int 21h
		
		mov ax,strlen
		mov pno,ax
		call shownum
	
	mov ah,04ch
	int 21h
  main endp
  include io.lib
end