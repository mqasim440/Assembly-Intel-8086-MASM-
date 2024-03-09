; Q4 Write a program that displays the required information of given file 
        ;4.2 -Total number of digits 
.model small
.stack 100h
.data
	pno dw 0
	cno dw 0
	ten dw 10
	fnm db 20 dup(0)
	fh dw 0
	msg db "Enter the file name:","$"
	msg1 db "Number of digits in the given file is:","$"
	fmsg db  1000 Dup("$")
	digits dw 0
	
.code
  main proc
	mov ax,@data
	mov ds,ax
	
	mov ah,09h
	mov dx,offset msg
	int 21h
	
	mov cx,20
	mov si,offset fnm

	;take file name from user
	FileName:
		mov ah,01h
		int 21h
		cmp al,13
		je OpenFile
		mov ah,0h
		mov [si],ax
		inc si
		loop FileName
	
	;open file
	OpenFile:
		mov ah,03dh
		mov dx,offset fnm
		mov al,2
		int 21h
		mov fh,ax

	;read from file
	ReadFile:
		mov ah,03fh
		mov bx,fh
		mov cx,999
		mov dx,offset fmsg
		int 21h
		
	;count file size
	mov cx,999
	mov si,offset fmsg
	
	Count:
		mov al,[si]
		cmp al,'0'
		jl Skip
		cmp al,'9'
		jg Skip
		inc digits
	Skip:
		inc si
		loop Count
		
	mov ah,09h
	mov dx,offset msg1
	int 21h
		
	;display count
	mov ax,digits
	mov pno,ax
	call shownum

	mov ah,04ch
	int 21h
  main endp
  include io.lib
end