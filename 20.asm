; Q20 Write a program that display ACII characters from 0 to 255
.model small
.stack 100h
.data
	msg db  "Enter Data from 0 to 255 : ","$"
     msg1 db " ","$"
    ASCII db 0
.code
  main proc
	mov ax,@data
	mov ds,ax
	
	mov ah,09h
	mov dx,offset msg
	int 21h
	 
     PrintASCII:
     cmp ASCII,13
     je skip
     mov ah,02h
     mov dl,ASCII
     int 21h
     cmp dl,255
     je Exit

     mov ah,09h
     mov dx ,offset msg1
     int 21h

     inc ASCII
     jmp PrintASCII
     Skip:
     inc ASCII
     jmp PrintASCII

      Exit:
		mov ah,04ch
		int 21h
		
  main endp
end