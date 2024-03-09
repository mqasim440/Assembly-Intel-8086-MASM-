.model small
.stack 100h
.data
msg db "Enter string :","$"
string db 20 dup(0)
Binstring db 255 dup("$")
two db 2
.code
     main proc 
     mov ax,@data
     mov ds,ax

     mov ah,09h
     mov dx,offset msg 
     INT 21H

     mov si offset string
     mov cx,0
     string1:
     mov ah,01h
     int 21H
     cmp al,13
     je Next
     mov ah,0h
     mov [si],ax
     inc si
     inc cx
     jmp string1

Next:
mov si,offset string
mov di offset of Binstring

convertloop:
mov ax,[si]
cmp ax,0
je DipBinary

mov cx,8

convertBitloop:
mov Dx,0
Div two
Add dx,48
push Dx
loop convertBitloop

mov cx,8
popBitLoop:
pop AX
mov [DI],ax
inc DI
 loop popBitLoop

 inc si
 jmp convertloop

 DispBinary:
 mov ah,09h
 mov dx,offset Binstring
 int 21H

mov ah,04ch
int 21H
main endp 
end

