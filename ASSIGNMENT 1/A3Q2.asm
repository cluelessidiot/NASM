section .data
ms1: db '      MATRIX 1    ',0Ah
ms1l: equ $-ms1

ms2: db '      MATRIX 2    ',0Ah
ms2l: equ $-ms2

msg1: db 'Enter the number of rows in the matrix : '
msg_size1: equ $-msg1
msg2: db 'Enter the elements one by one(row by row) : ',0Ah
msg_size2: equ $-msg2
msg3: db 'Enter the number of columns in the matrix : '
msg_size3: equ $-msg3
mfinal: db '    PRODUCT MATRIX is  ',0Ah
mfinall: equ $-mfinal
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
 matrix: resw 200
 matrix1: resw 200
 matrix2: resw 200
 flag: resw 1
 numt: resw 1
 temp: resw 1
 temp1: resw 1
 temp2: resw 1
 m: resw 1
 n: resw 1
 m1: resw 1
 n1: resw 1
 m2: resw 1
 n2: resw 1
 i: resw 1
 j: resw 1
 k: resw 1
 nod: resb 1
 
section .text
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
global _start:

_start:
 
;;;;Reading 1st matrix
 mov eax,4
 mov ebx,1
 mov ecx,ms1
 mov edx,ms1l
 int 80h

mov esi,matrix1
;movzx matrix,ebx

call read_matrix

mov bx,word[n]
mov word[n1],bx
mov bx,word[m]
mov word[m1],bx
;

;
 mov eax,4
 mov ebx,1
 mov ecx,new_line
 mov edx,1
 int 80h
;
;;;;Reading 2nd matrix
 mov eax,4
 mov ebx,1
 mov ecx,ms2
 mov edx,ms2l
 int 80h

mov esi,matrix2
;movzx matrix,ebx

call read_matrix

mov bx,word[n]
mov word[n2],bx
mov bx,word[m]
mov word[m2],bx


;;;;;;;;;;;;;;;;;;;;;;;;;;;MATRIX MULTIPLICATION;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov esi,matrix

mov word[i], 0
mov word[j], 0
mov word[k], 0

i_loopm:
mov word[j], 0

j_loopm:
mov word[k], 0

k_loopm:

;Getting matrix1[i][k]
pusha
mov ax, word[i]
mov cx, word[n1]
mul cl
add ax, word[k]
mov bx, word[matrix1 + 2 * eax]
mov word[temp1], bx
popa

;Getting matrix2[k][j]
pusha
mov ax, word[k]
mov cx, word[n2]
mul cl
add ax, word[j]
mov bx, word[matrix2 + 2 * eax]
mov word[temp2], bx
popa

;Multiplying a[i][k] * b[k][j]
mov ax, word[temp1]
mov cx, word[temp2]
mul cl
mov word[temp], ax

;Getting matrix[i][j]
mov ax, word[i]
mov cx, word[n2]
mul cl
add ax, word[j]
mov cx, word[temp]
add word[esi + 2 * eax], cx
inc word[k]
mov cx, word[k]
cmp word[n1], cx
jne k_loopm

inc word[j]
mov dx, word[j]
cmp word[n2], dx
jne j_loopm

inc word[i]
mov ax, word[i]
cmp word[m1], ax
jne i_loopm


;;;;;;;END;;;;;OF;;;;;;;MULTIPLICATION;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Printing each element of the matrix
 
mov esi,matrix

 mov eax,4
 mov ebx,1
 mov ecx,new_line
 mov edx,1
 int 80h

 mov eax,4
 mov ebx,1
 mov ecx,mfinal
 mov edx,mfinall
 int 80h

 mov eax, 0
 mov ebx, matrix
 mov word[i], 0
 mov word[j], 0
 
 i_loop2:

  mov word[j], 0
 j_loop2:

 mov dx, word[ebx + 2 * eax]
 mov word[num] , dx
 call printnum

;;;;;;;;;;;space

 pusha
 mov eax, 4
 mov ebx, 1
 mov ecx, tab
 mov edx, 1
 int 80h
 popa

 inc eax
 inc word[j]
 mov cx, word[j]
 cmp cx, word[n]
 jb j_loop2

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

;Exit
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
;
;
read_matrix:
 pusha
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

;Reading each element of the matrix........
 mov eax, 0
  ;mov ebx, matrix
mov ebx,esi
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

 popa
 ret












