.model small
.stack 100h
.data
fh dw 0
fnm db 20 Dup('0')
fmsg db 1000 Dup('$')
Msg db "Enter File Name :","$"
Msg1 db 10,13,"File Size :","$"
Msg2 db 10,13,"Total Capital letter :","$"
Msg3 db "Total Integers :","$"
Size1 dw 0
Pno dw 0
Cno dw 0
Ten dw 10
capital1 dw 0
integer1 dw 0
.code
main proc
mov ax,@data
mov ds,ax

mov dx,offset Msg
call coutstr
mov SI,offset fnm
mov cx,20
FileName:
mov ah,01h
int 21h
cmp al,13
je OpenFile
mov [SI],al
Inc SI
Inc cx
Loop FileName

OpenFile:
mov ah,03dh
mov dx,offset fnm
mov al,0
int 21h
mov fh,ax

;Readfile
mov ah,03fh
mov bx,fh
mov cx,999
mov dx,offset Msg
int 21h

;File Size

mov SI,offset Msg
mov cx,0
FileSize:
mov ax,[SI]
cmp ax,'$'
je ShowSize
Inc Size1
Inc cx
jmp FileSize

ShowSize:
mov ax,Size1
mov Pno,ax
mov dx,offset Msg1
call coutstr
call shownum

;Capital letters
mov SI,offset Msg
mov cx,0
Capital:
mov ax,[SI]
cmp ax,'A'
jl Skip1
cmp ax,'Z'
jg Skip1
Inc capital1
Inc SI
jmp Capital
Skip1:
Inc SI
jmp Capital

ShowCapital:
mov ax,capital1
mov Pno,ax
mov dx,offset Msg2
call coutstr
call shownum

;total Integers
mov SI,offset Msg
mov cx,0
Integers:
mov ax,[SI]
cmp ax,'0'
jl Skip2
cmp ax,'9'
jg Skip2
Inc integer1
Inc SI
jmp Integers
Skip2:
Inc SI
jmp Integers

ShowIntegers:
mov ax,integer1
mov Pno,ax
mov dx,offset Msg2
call coutstr
call shownum
;close File
mov ah,03eh
mov bx,fh
int 21h
mov ah,04ch
int 21h
main endp
Include io.lib
end