display macro arg
        lea dx,arg
        mov ah,09h
        int 21h
endm

ndisp macro arg 
        local l1,l2
        mov ax,arg
        mov cx,00h
        mov bx,0ah
        l1:
                mov dx,0000h
                div bx
                push dx
                inc cx
                cmp ax,00h
                jnz l1
        l2:
                pop dx
                add dx,30h
                mov ah,02h
                int 21h
                loop l2
endm

data segment
        msg1 db 0ah,0dh,"The Time is $"
        str1 db " : $"
        msg2 db 0ah,0dh,"The Date is $"
        str2 db " - $"
        hrs db ?
        min db ?
        sec db ?
        yr dw ?
        mnth db ?
        dat db ?
data ends

code segment
        assume cs:code,ds:data
        start :
                mov ax,data
                mov ds,ax
                mov ah,2ch
                int 21h
                mov hrs,ch
                mov min,cl
                mov sec,dh
                display msg1
                mov ah,00h
                mov al,hrs
                ndisp ax

                display str1
                mov ah,00h
                mov al,min
                ndisp ax
                display str1
                mov ah,00h
                mov al,sec
                ndisp ax

                mov ah,2ah
                int 21h
                mov yr,cx
                mov mnth,dh
                mov dat,dl

                display msg1
                mov ah,00h
                mov al,dat
                ndisp ax
                display str2
                mov ah,00h
                mov al,mnth
                ndisp ax
                display str2
                mov ax,yr
                ndisp ax

                mov ah,4ch
                int 21h

code ends
end start
