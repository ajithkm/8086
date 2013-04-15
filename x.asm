macro primedisplay
local l1		;corrected    
mov ax,2000h
    lea si,ax
    inc si
    mov cl,[si] 
    inc si
    mov dx,0000h
    l1:mov dx,[si]
    add dx,30h
    mov ah,02h
    int 21h
    mov dx,20h
    mov ah,02h
    int 21h
    inc si
    loop l1
endm

macro prime

local l1,last,l5,last1,sfeed
mov dx,2000h
lea si,dx
inc si
inc si
mov cx,bx
push bx
mov ax,0002h
l5:mov dx,0000h
mov flag,dx
mov bx,0002h
l1:mov dx,0000h
cmp ax,cx
je last1
cmp bx,ax
je last
push ax
div bx 
pop ax
cmp dx,0000h
je last2
inc bx
jmp l1
last:push bx
mov bx,flag
cmp bx,0000h
pop bx
je sfeed
inc ax
jmp l5
sfeed:mov [si],ax
push ax
mov ax,ctr
inc ax
mov ctr,ax
pop ax
inc si
inc ax
jmp l5
last2:
push ax
mov ax,0001h
mov flag,ax
pop ax
inc ax 
jmp l5
last1:  
mov ax,2000h
lea si,ax
inc si 
mov ax,ctr
mov [si],al
endm

ndisp macro
local l1,l2
mov cx,0000h
mov ax,bx
push bx
mov bx,000ah
l1:mov dx,0000h
div bx
inc cx
push dx
cmp al,00h
jne l1
l2:
pop dx
add dx,30h
mov ah,02h
int 21h
loop l2
pop bx
endm

display macro arg
lea dx,arg
mov ah,09h
int 21h
endm

read macro
local l1,last
mov bx,0000h
l1:
mov ah,01h
int 21h
sub al,30h
mov ah,00h
cmp al,0ddh
je last
push ax
mov ax,000ah
mul bx
mov bx,ax
pop ax
add bx,ax
jmp l1
last:
endm

data segment
msg1 db 0ah,0dh,"enter the limit: $"
msg2 db 0ah,0dh,"the prime numbers are: $"
flag dw 0
ctr dw 0
data ends


code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax                             
display msg1
read
prime
display msg2
primedisplay
mov ah,4ch
int 21h
code ends
end start