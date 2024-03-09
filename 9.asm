; Q9 Write a program which takes a character from the user and finds its location in the given string
.model small
.stack 100h
.data
	msg db  "The given string is : ","$"
	msg1 db 10,13,"Enter character to find its location :","$"
    msg2 db 10,13,"Character is at location :","$"
	msg3 db 10,13,"Character not found!","$"
	str db  "abcdeABCDE","$"
	charloc  dw 0
    char db ?
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
	
	mov ah,09h
	mov dx,offset str
	int 21h
	
	mov ah,09h
	mov dx,offset msg1
	int 21h
	
	mov ah,01h
	int 21h
	mov char,al
	
	mov cx,10
	mov si,offset str
	FindLoc:
		mov al,[si]
		inc charloc
		cmp al,char
		je DispLoc
		inc si
		loop FindLoc
		
	NotFound:
		mov ah,09h
		mov dx,offset msg3
		int 21h
		jmp Exit
		
	DispLoc:		
		mov ah,09h
		mov dx,offset msg2
		int 21h
		
		mov ax,charloc
		mov pno,ax
		call shownum
	Exit:
		mov ah,04ch
		int 21h
  main endp
  include io.lib
end