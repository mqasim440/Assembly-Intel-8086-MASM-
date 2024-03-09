; Q21 Write a program that display ACII character of given code
.model small
.stack 100h
.data
	msg db  "Enter code : ","$"
     msg1 db 10,13,"ASCII character of given code : ","$"
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

    call getnum

    mov ah,09h
	mov dx,offset msg1
	int 21h

     mov ah,02h
     mov dh,0
     mov dx,pno
     int 21h

		mov ah,04ch
		int 21h
		
  main endp
  include io.lib
end