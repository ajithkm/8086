
display macro arg
        lea dx,arg
        mov ah,09h
        int 21h
endm

data segment
        msg1 db 0ah,0dh,"Enter the string : $"
        msg2 db 0ah,0dh,"Enter the sub string : $"
        msg3 db 0ah,0dh,"The string : $"
        msg4 db 0ah,0dh,"The substring is : $"
        str db 0ah,0dh, 15 dup("$")
        substr db 0ah,0dh, 15 dup("$")
data ends  

code segment
        assume cs:code,ds:data
        start :
                mov ax,data
                mov ds,ax
                display msg1
                lea dx,str
                mov ah,0ah
                int 21h

                display msg2
                lea dx,substr
                mov ah,0ah
                int 21h

                display msg3
                lea si,str
                inc si
                mov ah,00
                mov al,[si]

                display msg3
                lea si,substr
                mov ah,00
                mov al,[si]


                lea dx,str
                add dx,02
                mov ah,09h
                int 21h

                display msg4
                lea dx,substr
                add dx,02
                mov ah,09h
                int 21h

                mov ah,4ch
                int 21h
code ends
end start

       
