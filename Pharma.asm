.model small
.stack 100h

.data
    fnm db 'Pharma.txt', 0
    fh dw 0
    drugData db 60 dup(' '); Array to store drug data (name and price)
    ReadData db 61 dup("$") ;Array to read data from file
    SNAME db 30 dup(' ') ;Array to read data from file
    Design1 db 10,13,'           *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*$'
    Wel db 10, 13,   '           *                 WELCOME TO                  *$'
    PName db 10, 13, '           *        PHARMACY MANAGEMENT SYSTEM           *$'
    Design2 db 10,13,'           *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*$'
    menu1 db 10, 13, '           *          1. ADD DRUG RECORD                 *$'
    menu2 db 10, 13, '           *          2. VEIW ALL DRUGS RECORDS          *$'
    menu3 db 10, 13, '           *          3. SEARCH DRUG RECORD BY NAME      *$'
    menu4 db 10, 13, '           *          4. EXIT                            *$'
    Design3 db 10,13,'           *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*$'

    Msg1 db 10, 13, '                         ENTER YOUR CHOICE: $'
    Msg2 db 10, 13, '                        *=*=*=*=*=*=*=*=*=* $'
    Msg3 db 10, 13, '                         * ADDING RECORD * $'
    Msg4 db 10, 13, '                          ENTER DRUG ID: $'
    Msg5 db 10, 13, '                          ENTER DRUG NAME: $'
    Msg6 db 10, 13, '                          ENTER DRUG PRICE: $'
    Msg7 db 10, 13, '                          ENTER DRUG Qty: $'
    Msg8 db 10, 13, '                     RECORD ADDED SUCCESSFULLY... $'
    Msg9 db 10, 13, '                         * RECORDS VIEW * $'
    Msg10 db 10, 13, '                       ***** ALL DRUGS RECORDS *****     $'
    Msg11 db 10, 13, '       $'
    Msg12 db 10,13,  '       *DID*   |   *NAME*         |        *PRICE*    | *Qty*$'
    Msg13 db 10, 13, '                    RECORDS VIEWED SUCCESSFULLY... $'
    Msg14 db 10, 13, '             INVALID CHOICE. PLEASE ENTER A VALID OPTION!!$'
    Msg15 db 10, 13, '                         * SEARCH RECORD * $'
    Msg16 db 10, 13, '                         ENTER DRUG NAME TO SEARCH: $'
    Msg17 db 10, 13, '                       ***** SEARCHED DRUG RECORD*****     $'
    Msg18 db 10, 13, '                     RECORD SEARCHED SUCCESSFULLY... $'
    Msg19 db 10, 13, '                        NO SUCH RECORD EXISTS!!$'
    Msg20 db 10, 13, '                        DO YOU WANT TO EXIT [y\n]:$'
    newline db 10, 13, '$'

.code
main proc
    mov ax, @data
    mov ds, ax
    Push AX
    Push bx
    Push cx
    push Dx

    ;Check if the file exist 
    mov ah,043h
    mov al,00
    mov dx,offset fnm
    Int 21h

    jnc Menu ;jump if no carry(file exist)

    ;if carry is generated(file not exist) then create file 
    mov ah,03ch
    mov cx,0
    mov dx,offset fnm
    Int 21h
    mov fh,ax 

    Menu:
         mov dx, offset Design1
        call Coutstr
        mov dx, offset Wel
        call Coutstr
         mov dx, offset PName
        call Coutstr
        mov dx, offset Design2
        call Coutstr
        mov dx, offset menu1
        call Coutstr
        mov dx, offset menu2
        call Coutstr
        mov dx, offset menu3
        call Coutstr
        mov dx, offset menu4
        call Coutstr
        mov dx, offset Design3
        call Coutstr
        call choiceInput
        jmp Menu

addDrug:
    mov dx, offset Msg2
    call Coutstr
    mov dx, offset Msg3
    call Coutstr
     mov dx, offset Msg2
    call Coutstr
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
    je  QtyLabel
    mov [SI], al
    inc SI
    loop Price
   
   QtyLabel:
    mov dx, offset Msg7
    call Coutstr
     mov SI, offset drugData+50
    mov cx,10     
     Qty:
    mov ah, 01h
    int 21h
    cmp al,13
    je Write
    mov [SI], al
    inc SI
    Loop Qty

Write:
    ; Open the file for writing in appending mode 
    mov ah, 03Dh
    mov al, 2    ;passed 2 to open file in read/write mode
    mov dx, offset fnm
    int 21h
    mov fh, ax
     ; 42h  service is used to move the file pointer to the end of the file
    mov ah, 42h      
    mov al, 2
    mov cx,0
    mov dx,0 
    mov bx, fh
    int 21h
    ; Write to the file
    mov ah, 040h
    mov bx, fh
    mov cx,60
    mov dx, offset drugData
    int 21h
    ;empty string(initailizing with space)
    call EmptydrugData
    ; Close the file
    mov ah, 3Eh
    mov bx, fh
    int 21h
    mov dx, offset Msg8
    call Coutstr
    mov dx, offset Design1
    call Coutstr
    mov dx, offset newline
    call Coutstr
    jmp Menu

ShowData:
    mov dx, offset Msg2
    call Coutstr
    mov dx,offset Msg8
    call Coutstr
    mov dx, offset Msg2
    call Coutstr
    mov dx,offset newline
    call Coutstr
    mov dx, offset Msg10
    call Coutstr
    mov dx, offset newline
    call Coutstr
    mov dx, offset Msg12
    call Coutstr
    mov dx, offset newline
    call Coutstr
    mov dx, offset newline
    call Coutstr

    ;open file to read data
    mov ah, 03dh
    mov al, 0
    mov dx, offset fnm
    int 21h
    mov fh, ax

    ;read from file
	ReadFile:
		mov ah,03fh
		mov bx,fh
		mov cx,60
		mov dx,offset ReadData
		int 21h
		cmp ax,0
		je FileClose
        mov dx, offset Msg11
        call Coutstr
		mov dx,offset ReadData
        call Coutstr
        mov dx,offset newline
        call Coutstr

		jmp ReadFile


    
    FileClose:
    
       mov dx, offset Msg13
      call Coutstr
      mov dx, offset Design1
      call Coutstr    
       mov dx, offset newline
      call Coutstr
        ; Close the file
        mov ah, 3Eh
        mov bx, fh
        int 21h
        jmp Menu

SearchData:
mov dx,offset Msg2
call Coutstr
mov dx,offset Msg15
call Coutstr
mov dx, offset Msg2
call Coutstr
mov dx,offset newline
call Coutstr
mov dx,offset Msg16
call Coutstr
mov SI,offset SNAME
mov cx,30
GiveSNAME:
    mov ah, 01h
    int 21h
    cmp al,13
    je Search
    mov [SI], al
    inc SI
    loop GiveSNAME

Search:
;open file to read data
    mov ah, 03dh
    mov al, 0
    mov dx, offset fnm
    int 21h
    mov fh, ax

    ;read from file
	ReadFile1:
		mov ah,03fh
		mov bx,fh
		mov cx,60
		mov dx,offset ReadData
		int 21h
		cmp ax,0
		je FileClose1
        mov SI,offset SNAME
        mov DI,offset ReadData+10
        mov cx,30
         check:
         mov al,[SI]
         mov bl,[DI]
         cmp al,bl
         jne ReadAgain
         inc SI
         inc DI
         loop check

    mov dx, offset Msg2
    call Coutstr
    mov dx, offset newline
    call Coutstr
    mov dx, offset Msg17
    call Coutstr
    mov dx, offset newline
    call Coutstr
    mov dx, offset Msg12
    call Coutstr
    mov dx, offset newline
    call Coutstr
    mov dx, offset newline
    call Coutstr
        mov dx, offset Msg11
        call Coutstr
		mov dx,offset ReadData
        call Coutstr
        mov dx,offset newline
        call Coutstr
        mov dx, offset Msg18
        call Coutstr
        mov dx,offset newline
        call Coutstr

        ;empty string(initailizing with space)
        call EmptySNAME

        jmp Menu
   ReadAgain:
             jmp ReadFile1
    
    FileClose1:
      ;empty string(initailizing with space)
       call EmptySNAME
       mov dx, offset Msg12
       call Coutstr
       mov dx, offset newline
       call Coutstr
       mov dx, offset Msg19
      call Coutstr
      mov dx, offset Design1
      call Coutstr    
       mov dx, offset newline
      call Coutstr

        ; Close the file
        mov ah, 3Eh
        mov bx, fh
        int 21h
        jmp Menu



ConfirmExit:
    mov dx,offset Msg2
    call Coutstr
    mov dx,offset Msg20
    call Coutstr
    mov ah,01h
    int 21h
    cmp al,'y'
    je Exit
    mov dx,offset newline
    call Coutstr
    mov dx,offset newline
    call Coutstr
    ret
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