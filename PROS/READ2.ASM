display macro var
        lea dx,var
        mov ah,09h
        int 21h
endm

data segment
a dw ?
b dw ?
menu db 0ah,0dh,"Menu $ 1 . Add $"
str1 db 0ah,0dh,"Enter the number : $"
data ends

code segment
assume cs:code,ds:data
start:
        mov ax,data
        mov ds,ax
        display menu
        display str1
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

        mov ax,bx
        mov bx,0ah
        mov cx,0000h
        l1 :
                mov dx,0000h
                div bx
                push dx
                inc cx
                cmp ax,0000h
                jnz l1
       l2  :
                pop dx
                add dx,30h
                mov ah,02h
                int 21h
                loop l2

        mov ah,4ch
        int 21h
code ends
end start
