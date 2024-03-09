; Q8 Write a program which compares to strings and displays the string are equal or not
.model small
.stack 100h
.data
	msg db "Enter first string : ","$"
	msg1 db "Enter second string : ","$"
    msg2 db "Both strings are equal","$"
	msg3 db "Both strings are not equal","$"
    str1 db  100 Dup("$")
    str2 db  100 Dup("$")
	lenstr1 dw 0
	lenstr2 dw 0
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
	
	;take first string from user
	mov si,offset str1
	
	InputString1:
		mov ah,01h
		int 21h
		cmp al,13
		je Next
		mov [si],al
		inc lenstr1
		inc si
		jmp InputString1
	

	Next:
		mov ah,09h
		mov dx,offset msg1
		int 21h
		
	;take seoncd string from user
	mov si,offset str2
	
	InputString2:
		mov ah,01h
		int 21h
		cmp al,13
		je Compare
		mov [si],al
		inc lenstr2
		inc si
		jmp InputString2
		
	Compare:
		mov ax,lenstr1
		cmp ax,lenstr2
		je Equal
		
		mov ah,09h
		mov dx,offset msg3
		int 21h
		jmp Exit
		
	Equal:
		mov ah,09h
		mov dx,offset msg2
		int 21h
		
	Exit:
		mov ah,04ch
		int 21h
	
  main endp
  include io.lib
end