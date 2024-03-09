; Q3 Write a program that copies the data of one file to another file the source file name and the destination file name are retrieve from the user
.model small
.stack 100h
.data
	fh dw 0
	fh1 dw 0
	msg1 db "Enter the source file name:","$"
	msg2 db "Enter the destination file name:","$"
	msg3 db "Data Successfully copied ...","$"
	fmsg db  1000 Dup("$")
	sfile db 20 Dup(0)
    dfile db  20 Dup(0)
.code
  main proc
	mov ax,@data
	mov ds,ax

	mov ah,09h
	mov dx,offset msg1
	int 21h
	
	mov cx,20
	mov si,offset sfile

	;take source file name from user
	SFileName:
		mov ah,01h
		int 21h
		cmp al,13
		je OpenFile
		mov ah,0h
		mov [si],ax
		inc si
		loop SFileName

	;open source file	
	OpenFile:
		mov ah,03dh
		mov dx,offset sfile
		mov al,2
		int 21h
		mov fh,ax
		
	;read from source file
	ReadFile:
		mov ah,03fh
		mov bx,fh
		mov cx,999
		mov dx,offset fmsg
		int 21h
		
	;close source file
	mov ah,03eh
	mov bx,fh
	int 21h
	
	
	mov ah,09h 
	mov dx,offset msg2
	int 21h
		
	mov cx,20
	mov si,offset dfile

	;take destination file name from user
	DFileName:
		mov ah,01h
		int 21h
		cmp al,13
		je CreateFile
		mov ah,0h
		mov [si],ax
		inc si
		loop DFileName
		
	;create destination file
	CreateFile:
		mov ah,03ch
		mov dx,offset dfile
		mov cx,0h
		int 21h
		mov fh1,ax
		
	;write on destination file
	mov ah,40h
	mov bx,fh1
	mov cx,999
	mov dx,offset fmsg
	int 21h
	
	;close destination file
	mov ah,03eh
	mov bx,fh1
	int 21h
	
	mov ah,09h
	mov dx,offset msg3
	int 21h
		
	mov ah,04ch
	int 21h
  main endp
end