display macro arg
        lea dx,arg
        mov ah,09h
        int 21h
endm

read macro arg
        local  l1,l2
        lea bx,arg
        add bx,2
        l1:
                mov ah,01h
                int 21h
                cmp al,13
                je l2
                mov [bx],al
                inc bx
                jmp l1
        l2:
                mov al,0
                mov [bx],al
endm
               
data segment
        msg1 db 0ah,0dh," Enter the name : $"
        msg2 db 0ah,0dh," Directory Created !!$"
        msg3 db 0ah,0dh," Directory Deleted !!$"
        msg4 db 0ah,0dh," Directory Changed !!$"
        msg5 db 0ah,0dh," Present Working Directory : $"
        msg6 db 0ah,0dh," File Created !!$"
        msg7 db 0ah,0dh," File Deleted !!$"
        msg8 db 0ah,0dh," Error Encountered !!$"
        msg9 db 0ah,0dh," Enter Choice : $"
        men1 db 0ah,09h," 1 . Create Directory $"
        men2 db 09h,09h," 2 . Delete Directory $"
        men3 db 0ah,09h," 3 . Change Directory $"
        men4 db 0ah,09h," 4 . Display Current Directory $"
        men5 db 0ah,09h," 5 . Create File $"
        men6 db 0ah,09h," 6 . Delete File $"
        men7 db 0ah,09h," 7 . Exit $"
        str1 db 40 dup("$")
        str2 db 40 dup("$")
        choice db 0
data ends

code segment
        assume cs:code,ds:data
        start :
                mov ax,data
                mov ds,ax
                display men1
                display men2
                display men3
                display men4
                display men5
                display men6
                display men7
                main :
                        display msg9
                        mov ah,01h
                        int 21h
                        sub al,30h
                        cmp al,1
                        jnz rmdir

              ;cdir
                        display msg1
                        read str1
                        lea dx,str1
                        add dx,2
                        mov ah,39h
                        int 21h
                        jnc l1
                        display msg8
                        jmp main
                        l1 :
                                display msg2
                                jmp main

                rmdir :
                         cmp al,2
                         jnz chdir
                         display msg1
                         read str1
                         lea dx,str1
                         add dx,02
                         mov ah,3ah
                         int 21h
                         jnc l2
                         display msg8
                         jmp main
                         l2 :
                                display msg3
                                jmp main

                chdir :
                         cmp al,3
                         jnz pwd
                         display msg1
                         read str1
                         lea dx,str1
                         add dx,02
                         mov ah,3bh
                         int 21h
                         jnc l3
                         display msg8
                         jmp main
                         l3 :
                                display msg4
                                jmp main

                pwd :
                         cmp al,4
                         jnz cfile
                         lea si,str2
                         mov dl,0
                         mov ah,47h
                         int 21h
                         jnc l4
                         display msg8
                         jmp main
                         l4 :
                                display msg5
                                display str2
                                jmp main

                 cfile :
                         cmp al,5
                         jnz dfile 
                         display msg1
                         read str1
                         lea dx,str1
                         add dx,02
                         mov cx,0
                         mov ah,3ch
                         int 21h
                         jnc l5
                         display msg8
                         jmp main
                         l5 :
                                display msg6
                                jmp main
                dfile :
                         cmp al,6
                         jnz exit 
                         display msg1
                         read str1
                         lea dx,str1
                         add dx,02
                         mov ah,41h
                         int 21h
                         jnc l6
                         display msg8
                         jmp main
                         l6 :
                                display msg7
                                jmp main

                exit :
                        mov ah,4ch
                        int 21h
        code ends
        end start
