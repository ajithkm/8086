display macro arg
        lea dx,arg
        mov ah,09h
        int 21h
endm

data segment
        msg1 db 0ah,0dh," Enter the String     : $"
        msg2 db 0ah,0dh," Number of Vowels     = $"
        msg3 db 0ah,0dh," Number of Consonants = $"
        str1 db 40 dup("$")
data ends

code segment
        assume cs:code,ds:data
        start :
                mov ax,data
                mov ds,ax
                display msg1
                lea dx,str1
                mov ah,0ah
                int 21h

                mov bx,00h
                mov ax,00h
                mov dx,00h
                mov ch,00h
                lea si,str1
                inc si
                mov cl,[si]
                l1 :
                        inc si
                        mov ah,[si]
                        cmp ah,'a'
                        je vow
                        cmp ah,'e'
                        je vow
                        cmp ah,'i'
                        je vow
                        cmp ah,'o'
                        je vow
                        cmp ah,'u'
                        je vow
                        inc bx
                        jmp l2
                        vow :
                                inc al 
                        l2 :
                                dec cx
                                cmp cx,00d
                                jnz l1
                display msg2
                mov ah,00h
                mov dx,ax
                add dx,30h
		mov ah,02h
                int 21h
                display msg3
                mov dx,bx
                add dx,30h
		mov ah,02h
                int 21h
                mov ah,4ch
                int 21h
        code ends
        end start
