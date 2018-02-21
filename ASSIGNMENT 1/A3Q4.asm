section .data
msg1: db 'Enter the number of rows in the matrix : '
msg_size1: equ $-msg1
msg2: db 'Enter the elements one by one(row by row) : ',0Ah
msg_size2: equ $-msg2
msg3: db 'Enter the number of columns in the matrix : '
msg_size3: equ $-msg3
tab: db 9 ;ASCII for vertical tab
new_line: db 10 ;ASCII for new line
numzero: db '0'


section .bss
 digit1: resw 1
 digit0: resw 1
 count: resw 1
 num: resw 1
 num1: resw 1
 num2: resw 1
 matrix1: resw 200
 flag: resb 1
 numt: resw 1
 temp: resw 2
 temp1: resw 1
 temp2: resw 1
 m: resw 1
 n: resw 1
 i: resw 1
 j: resw 1
 nod: resb 1
 
section .text
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
global _start:

_start:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,msg_size1
int 80h

mov ecx, 0
call readnum
mov cx, word[num]
mov word[m], cx

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,msg_size3
int 80h

mov ecx, 0
call readnum
mov cx, word[num]
mov word[n], cx

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,msg_size2
int 80h

;Reading elements
mov eax, 0
mov ebx, matrix1
mov word[i], 0
mov word[j], 0



 i_loop:

 mov word[j], 0

 j_loop:

  call readnum
  mov dx , word[num]

;eax will contain the array index

  mov word[ebx + 2 * eax], dx
  inc eax

 inc word[j]
 mov cx, word[j]
 cmp cx, word[n]
 jb j_loop

 inc word[i]
 mov cx, word[i]
 cmp cx, word[m]
 jb i_loop
;;;;
;Q4;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Q4;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;Printing output elements 
 
 mov eax,4
 mov ebx,1
 mov ecx,new_line
 mov edx,1
 int 80h

 mov ax,word[n];
 mov bx ,2
 mov dx,0
 mul bx
 mov word[temp],ax
 mov eax,0       
 mov word[i],0	
 mov word[j],0

 mov byte[flag],1 

 mov ax,word[n];
 mov bx ,2
 mov dx,0
 mul bx
 mov word[temp1],ax

  i_loop2:

 ;odd even checker for row
 cmp word[i],0
 je f1
 
 mov dx,0
 mov ax,word[i]
 mov bx,2
 div bx
 cmp dx,0
 je f1

 mov byte[flag],0

jmp j_loopbf
f1:
 mov byte[flag],1 
 
;
 j_loopbf:
 
 cmp word[flag],0
 je bop

 call forwardprint
 jmp contp


bop:
 call backwardprint



contp:

 pusha
 mov eax,4
 mov ebx,1
 mov ecx,new_line
 mov edx,1
 int 80h

 popa

 inc word[i]
 mov cx, word[i]
 cmp cx, word[m]
 jb i_loop2

;Exit;;;ALL;;;;;
exit:

 mov eax, 1
 mov ebx, 0
 int 80h

;
;

;
;
readnum:

 pusha

 mov word[num], 0
 
loop_read:
 mov eax, 3
 mov ebx, 0
 mov ecx, temp
 mov edx, 1
 int 80h
 cmp byte[temp], 10
 je end_read
 
 cmp byte[temp], 9
 je end_read

 mov ax, word[num]
 mov bx, 10
 mul bx
 mov bl, byte[temp]
 sub bl, 30h
 mov bh, 0
 add ax, bx
 mov word[num], ax
 jmp loop_read

 end_read:
 popa
 ret
;
;
                               printnum:

 pusha
 cmp word[num], 0
 jne extract_no
 
 mov eax,4
 mov ebx,1
 mov ecx,numzero
 mov edx,1
 int 80h
  
 popa
 ret

 extract_no: 
 
 cmp word[num], 0
 je print_no

 inc byte[nod]
 mov dx, 0
 mov ax, word[num]
 mov bx, 10
 div bx
 
 push dx

 mov word[num], ax
 jmp extract_no
 print_no:
 cmp byte[nod], 0
 je end_print

 dec byte[nod]
 pop dx
 mov byte[temp], dl
 add byte[temp], 30h

 mov eax,4
 mov ebx,1
 mov ecx,temp
 mov edx,1
 int 80h

 jmp print_no

 end_print:

popa
ret

forwardprint:
 
 mov word[j],0

  j_loop2:

 mov ax,word[i]
 mov bx, word[temp1]
 mov dx,0
 mul bx
 add ax,word[j]
 add ax,word[j]
 mov word[temp2],ax

 mov ebx,matrix1
 movzx eax,word[temp2]
 add ebx,eax
 mov dx,word[ebx]
 mov word[num],dx
 call printnum

;;;;;;;;;;;space

 pusha
 mov eax, 4
 mov ebx, 1
 mov ecx, tab
 mov edx, 1
 int 80h
 popa


 inc word[j]
 mov cx, word[j]
 cmp cx, word[n]
 jb j_loop2

 ret

backwardprint:
mov ax,word[n]
mov word[j],ax

  j_loop3:
 dec word[j]
 mov ax,word[i]
 mov bx, word[temp1]
 mov dx,0
 mul bx
 add ax,word[j]
 add ax,word[j]
 mov word[temp2],ax

 mov ebx,matrix1
 movzx eax,word[temp2]
 add ebx,eax
 mov dx,word[ebx]
 mov word[num],dx
 call printnum

;;;;;;;;;;;space

 pusha
 mov eax, 4
 mov ebx, 1
 mov ecx, tab
 mov edx, 1
 int 80h
 popa


 mov cx, word[j]
 cmp cx,0
 jne j_loop3

 ret












