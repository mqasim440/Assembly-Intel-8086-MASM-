; Q22 Write a program that display ACII code of given character
.model small
.stack 100h
.data
	msg db  "Enter Character : ","$"
     msg1 db 10,13," ASCII Code of given character : ","$"
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
	 mov ah,01h
     int 21h
     mov ah,0
    mov pno,ax
     
	mov ah,09h
	mov dx,offset msg1
	int 21h

       call showNum
		mov ah,04ch
		int 21h
		
  main endp
  include io.lib
end