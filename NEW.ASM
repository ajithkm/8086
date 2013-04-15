data segment
a dw ?
b dw ?
disp db 0ah,0dh,"Hello world$"
data ends

code segment
assume ds:data,cs:code
start:
        mov ax,data
        mov ds,ax
        lea dx,disp
        mov ah,09h
        int 21h
        mov ah,4ch
        int 21h
code ends
end start


