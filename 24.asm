; Q24 Write a program which decrypt the data from file and  displays it
.model small
.stack 100h
.data
	fnm db 10 dup(0)
	fh dw 0
	msg db 100 dup("$")
	msg1 db "Enter the file name:","$"
	msg2 db "File content is given below:",10,13,"$"
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
		je OpenFile
		mov ah,0h
		mov [si],ax
		inc si
		loop FileName
	
	OpenFile:
		mov ah,09h
		mov dx,offset msg2
		int 21h
		;open file
		mov ah,03dh
		mov dx,offset fnm
		mov al,2
		int 21h
		mov fh,ax

	;read from file
	ReadFile:
		mov ah,03fh
		mov bx,fh
		mov cx,99
		mov dx,offset msg
		int 21h
		cmp ax,0
		je EndRead
		
		; decrypt and display content

        mov SI,offset msg
    DispContent:
        mov al,[SI];
        cmp al,"$"
        je EndRead
        sub al,23     ;decrypt charater by character
        mov ah,02h
        mov dl,al
        int 21h
        inc SI
        jmp DispContent

		jmp ReadFile

	;file close
	EndRead:
		mov ah,03eh
		mov bx,fh
		int 21h

	mov ah,04ch
	int 21h
  main endp
end