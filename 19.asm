; Q19 Write a program that display the total number of vowels in the given data
.model small
.stack 100h
.data
	msg db  "Enter Data (Press Enter to end input): ","$"
    msg1 db "Total Vowels :","$"
	str1 db  100 Dup("$")
    vowels dw 0
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
	
	;take data from user
	mov si,offset str1
	
	InputData:
		mov ah,01h
		int 21h
		cmp al,13
		je DispVowels
		       cmp al,'A'
		je  count
               cmp al,'a'
        je count
		       cmp al,'E'
		je count
                cmp al,'e'
		je count
        		cmp al,'I'
		je count
        		cmp al,'i'
		je count
        		cmp al,'O'
		je count
        		cmp al,'o'
		je count
        		cmp al,'U'
		je count
        		cmp al,'u'
		je count
		
		mov [si],al
		inc si
		jmp InputData
		
		
		
	count :
          INC vowels
          mov [si],al
	      inc si
		jmp InputData
     
     DispVowels:
               
               mov dx,offset msg1
               call coutstr
               mov ax,vowels
               mov pno,ax
               call showNum

		mov ah,04ch
		int 21h
		
  main endp
  include io.lib
end