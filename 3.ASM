
display macro arg
        lea dx,arg
        mov ah,09h
        int 21h
endm

data segment
        len dw 0
        msg1 db 0ah,0dh,"Enter the string : $"
        msg2 db 0ah,0dh,"Enter the sub string : $"
        msg3 db 0ah,0dh,"The string : $"
        msg4 db 0ah,0dh,"The substring is : $"
        msg5 db 0ah,0dh,"Substring is not present $"
        msg6 db 0ah,0dh,"The Substring is present $"

        str db 30 dup("$")
        substr db 15 dup("$")
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
                lea dx,str
                add dx,02
                mov ah,09h
                int 21h

                display msg4
                lea dx,substr
                add dx,02
                mov ah,09h
                int 21h

                lea si,str
                mov ch,00
                inc si
                mov cl,[si]
                l1 :
                        lea di,substr
                        mov bh,00
                        inc di
                        mov bl,[di]
                        inc di
                        l2 :
                                inc si
                                mov ax,[si]
                                cmp ax,[di]
                                jne l3
                                inc di
                                dec bx
                                cmp bx,00
                                jne l2
                                jmp found
                        l3:
                                dec cx
                                cmp cx,00
                                jne l1

                display msg5
                jmp last

                found :
                        display msg6

                last :
                        mov ah,4ch
                        int 21h
code ends
end start

       
