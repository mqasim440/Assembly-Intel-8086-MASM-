.model small
.stack 100h

.data
    fnm db 'Pharma.txt', 0
    fh dw 0
    drugData db 50 dup(' '); Array to store drug data (name and price)
    ReadData db 51 dup("$") ;Array to read data from file
    PName db 10, 13, 'PHARMACY MANAGEMENT SYSTEM$'
    menu1 db 10,13,'1. ADD DRUG RECORD$'
    menu2 db 10, 13,'2. VEIW ALL DRUGS RECORDS$'
    menu3 db 10, 13,'3. EXIT$'

    Msg1 db 10, 13, 'ENTER YOUR CHOICE: $'
    Msg4 db 10, 13, 'ENTER DRUG ID: $'
    Msg5 db 10, 13, 'ENTER DRUG NAME: $'
    Msg6 db 10, 13, 'ENTER DRUG PRICE: $'
    Msg7 db 10, 13, 'RECORD ADDED SUCCESSFULLY... $'
    Msg11 db 10,13,'DID   |      NAME            |          PRICE$'
    Msg12 db 10, 13, 'RECORDS VIEWED SUCCESSFULLY... $'
    Msg13 db 10, 13, 'INVALID CHOICE. PLEASE ENTER A VALID OPTION!!$'
    newline db 10, 13, '$'

.code
main proc
    mov ax, @data
    mov ds, ax
    Push AX
    Push bx
    Push cx
    push Dx


    Menu:
         mov dx, offset PName
        call Coutstr
        mov dx, offset menu1
        call Coutstr
        mov dx, offset menu2
        call Coutstr
        mov dx, offset menu3
        call Coutstr
        call choiceInput

        jmp Menu

addDrug:
    mov dx,offset newline
    call Coutstr
    mov dx, offset Msg4
    call Coutstr
    mov SI, offset drugData
    mov cx,10     
     DID:
    mov ah, 01h
    int 21h
    cmp al,13
    je NameLabel
    mov [SI], al
    inc SI
    Loop DID

    NameLabel:
    mov SI,offset drugData+10
    mov dx, offset Msg5
    call Coutstr
    mov cx,30
    Name1:
    mov ah,01h
    int 21h
    cmp al,13
    je PriceLabel
    mov [SI], al
    inc SI
    Loop Name1

    PriceLabel:
    mov dx, offset Msg6
    call Coutstr
    mov SI,offset drugData+40
    mov cx,10
    Price:
    mov ah,01h
    int 21h
    cmp al,13
    je  Write
    mov [SI], al
    inc SI
    loop Price
Write:
    mov ah, 03Dh
    mov al, 2    
    mov dx, offset fnm
    int 21h
    mov fh, ax

    mov ah, 42h      
    mov al, 2
    mov cx,0
    mov dx,0 
    mov bx, fh
    int 21h

    mov ah, 040h
    mov bx, fh
    mov cx,50
    mov dx, offset drugData
    int 21h
    
    mov SI,offset drugData
    mov cx,50
    Empty:
    mov al,' '
    mov [SI],al
    inc SI
    loop Empty

    mov ah, 3Eh
    mov bx, fh
    int 21h
    mov dx, offset Msg7
    call Coutstr
    mov dx, offset newline
    call Coutstr
    jmp Menu

ShowData:
    mov dx, offset newline
    call Coutstr
    mov dx, offset Msg11
    call Coutstr
    mov dx, offset newline
    call Coutstr

    mov ah, 03dh
    mov al, 0
    mov dx, offset fnm
    int 21h
    mov fh, ax

	ReadFile:
		mov ah,03fh
		mov bx,fh
		mov cx,50
		mov dx,offset ReadData
		int 21h
		cmp ax,0
		je FileClose
		mov dx,offset ReadData
        call Coutstr
        mov dx,offset newline
        call Coutstr

		jmp ReadFile


    
    FileClose:
    
       mov dx, offset Msg12
      call Coutstr   
       mov dx, offset newline
      call Coutstr
        ; Close the file
        mov ah, 3Eh
        mov bx, fh
        int 21h
        jmp Menu

Exit:
    Pop Dx
    Pop cx
    pop bx
    pop AX

    mov ah, 04Ch
    int 21h
main endp
include pharma.lib
end