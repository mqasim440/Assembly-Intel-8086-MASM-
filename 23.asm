; Q23 Write a program that encrypt the given data and  stores Encrpted data in a file
.model small
.stack 100h
.data
	fnm db 10 dup(0)
	fh dw 0
	msg db 100 dup("$")
	msg1 db "Enter the file name:","$"
	msg2 db "Enter the file content(Press Esc key to end input):","$"
	len dw 0
	msg3 db 10,13," Data Encrpted and  written Successfully...","$"
	
.code
  main proc
	mov ax,@data
	mov ds,ax

	mov ah,09h
	mov dx,offset msg1
	int 21h
	
	mov cx,10
	mov si,offset fnm

	;take file name from user
	FileName:
		mov ah,01h
		int 21h
		cmp al,13
		je Text
		mov ah,0h
		mov [si],ax
		inc si
		loop FileName

	;Take Content from user
	Text:
		mov ah,09h
		mov dx,offset msg2
		int 21h

	mov cx,100
	mov si,offset msg
	Content:
		mov ah,01h
		int 21h
		cmp al,27
		je CreateFile
        add al,23      ;add 23 in each character to encrypt
		mov [si],al
		inc si
		inc len
		loop Content

		
	;create file
	CreateFile:
		mov ah,03ch
		mov dx,offset fnm
		mov cx,0h
		int 21h
		mov fh,ax

	;write in file
	mov ah,40h
	mov bx,fh
	mov cx,len
	mov dx,offset msg
	int 21h

	;file close
	mov ah,03eh
	mov bx,fh
	int 21h
	
	mov ah,09h
	mov dx,offset msg3
	int 21h
	
	mov ah,04ch
	int 21h
  main endp
end