display macro arg
        lea dx,arg
        mov ah,09h
        int 21h
endm


        
data segment
a db ?
str1 db 0ah,0dh,"Enter the number : $"
str2 db 0ah,0dh,"The decimal is : $"
data ends

code segment
assume cs:code,ds:data
start:
        mov ax,data
        mov ds,ax
        display str1
        call read

read proc
        mov cx,0008h
        mov bx,0000h
        l :
                mov ah,01h
                int 21h
                sub al,30h
                shl bl,01h
                or bl,al
                dec cx
                cmp cx,0000h
                jnz l
                
       mov a,bl
read endp
        display str2
        call rdisp
rdisp proc
        mov cx,0000h
        mov bh,00h
        mov ax,bx
        mov bx,0ah
        l2:
                mov dx,0000h
                div bx
                push  dx
                inc cx
                cmp ax,0000h
                jnz l2
        l3 :
                pop dx
                add dx,30h
                mov ah,02h
                int 21h
                loop l3
rdisp endp
        mov ah,4ch
        int 21h
code ends
end start



