display macro arg
        lea dx,arg
        mov ah,09h
        int 21h
endm

read macro
        display str2
        mov ah,01h
        int 21h
        sub al,30h
        mov bl,0ah
        mul bl
        push ax
        mov ah,01h
        int 21h
        sub al,30h
        mov ah,00h
        pop bx
        add bx,ax
        mov a,bx
endm


data segment
a dw ?
res dw ?
str1 db 0ah,0dh," 1.ADD 2.SUBTRACT 3.MULTIPLICATION 4.DIVISION $"
str2 db 0ah,0dh,"Enter the number : $"
str3 db 0ah,0dh,"Result is : $"
str4 db 0ah,0dh,"Enter your choice : $"
data ends

code segment
assume cs:code,ds:data

start:
        mov ax,data
        mov ds,ax
        display str1
        display str4
        mov ah,01h
        int 21h
        cmp al,31h
        jnz subt
        read
        mov cx,a
        read
        mov ax,a
        add cx,ax
        mov res,cx                      
        display str3
        call ndisp

ndisp proc
        mov ax,res
        mov bx,0ah
        mov cx,0000h
        l1 :
                mov dx,0000h
                div bx
                push dx
                inc cx
                cmp ax,0000h
                jnz l1
        l2 :
                pop dx
                add dx,30h
                mov ah,02h
                int 21h
                loop l2
ndisp endp

        jmp last
        subt :
                cmp al,32h
                jnz mult
                read
                mov cx,a
                read
                mov ax,a
                sub cx,ax
                mov res,cx                      
                display str3
                call ndisp
                jmp last
        mult :
                cmp al,33h
                jnz divi
                read
                mov cx,a
                read
                mov ax,a
                mul cx
                mov res,ax                      
                display str3
                call ndisp
                jmp last


        divi :
                cmp al,34h
                jnz last
                read
                mov cx,a
                read
                mov ax,a
                mov bx,ax
                mov ax,cx
                mov dx,0000h
                div bx
                mov res,ax                      
                display str3
                call ndisp
                jmp last
                



        last :
                mov ah,4ch
                int 21h
code ends
end start
