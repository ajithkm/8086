display macro arg
        lea dx,arg
        mov ah,09h
        int 21h
endm
data segment
a dw ?
str1 db 0ah,0dh,"Enter the hexadecimal number : $"
str2 db 0ah,0dh,"The decimal number is $"
data ends

code segment
assume cs:code,ds:data

start :
        mov ax,data
        mov ds,ax
        display str1
        mov bx,0000h
        mov cx,04h
        l1 :
                mov ah,01h
                int 21h
                sub al,30h
                cmp al,09h
                
		jg l10
                mov ah,00h
                call shft
shft proc
        push cx
	mov cl,04h
	shl bx,cl
	pop cx
 shft endp       
                or bx,ax
                jmp last
                l10 :	add al,30h
			cmp al,'a'
                        jg l11
                        mov ah,00h
                        mov al,0ah
                        call shft
                        or bx,ax
                        jmp last

                l11 :	cmp al,'b'
                        jg l12
                        mov ah,00h
                        mov al,0bh
                        call shft
                        or bx,ax
                        jmp last

                l12 :	cmp al,'c'
                        jg l13
                        mov ah,00h
                        mov al,0ch
                        call shft
                        or bx,ax
                        jmp last

                l13 :	cmp al,'d'
                        jg l14
                        mov ah,00h
                        mov al,0dh
                        call shft
                        or bx,ax
                	jmp last

                l14 :	cmp al,'e'
                        jg l15
                        mov ah,00h
                        mov al,0eh
                        call shft
                        or bx,ax
                        jmp last

                l15 :	cmp al,'f'
                        mov ah,00h
                        mov al,0fh
                        call shft
                        or bx,ax
        
	last: dec cx
	      cmp cx,0000h
	      jnz l1
              display str2
              call rdisp
	
rdisp proc
        mov cx,0000h
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
 
