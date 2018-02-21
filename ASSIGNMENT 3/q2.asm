section .data
m1a: db "Enter number of rows in the matrix A: "
size_m1a: equ $-m1a
m2a: db "Enter number of columns in the matrix A: "
size_m2a: equ $-m2a
m1b: db "Enter number of rows in the matrix B: "
size_m1b: equ $-m1b
m2b: db "Enter the number of columns in the matrix B: "
size_m2b: equ $-m2b
read_array: db "Enter the elements with an enter after each element(row by row):", 0Ah
size_read_array: equ $-read_array
reslt_array: db 0Ah, "The matrix that you entered is:", 0Ah
size_reslt_array: equ $-reslt_array
result: db 0Ah, "After multiplication, your matrix is:", 0Ah
size_result: equ $-result
error: db 0Ah, " matrices cant be multiplied."
size_error: equ $-error
newline: db 0Ah
space: db 32
zero: db "0"
lzero:equ $-zero
section .bss
num: resw 1
nod: resb 1
temp: resb 1
temp1: resw 1
A_matrx: resw 200
B_matrx: resw 200
C_matrx: resw 200
m1: resw 1
n1: resw 1
m2: resw 1
n2: resw 1
i: resw 1
j: resw 1
k: resw 1
i1: resw 1
j1: resw 1
t1: resw 1
t2: resw 1
t: resw 1

section .text
global _start

_start:

; Mat A

;Printing the text for asking rows of matA

mov eax, 4
mov ebx, 1
mov ecx, m1a
mov edx, size_m1a
int 80h

call input
mov ax, word[num]
mov word[m1], ax

;Priniting the text for asking columns of matA

mov eax, 4
mov ebx, 1
mov ecx, m2a
mov edx, size_m2a
int 80h

call input
mov ax, word[num]
mov word[n1], ax

; text for getting the elements of matrix A

mov eax, 4
mov ebx, 1
mov ecx, read_array
mov edx, size_read_array
int 80h

mov edx, 0
mov ebx, A_matrx
mov ax, word[m1]
mov word[i1], ax

mov ax, word[n1]
mov word[j1], ax

repeat:
call input
mov ax, word[num]
mov word[ebx + 2 * edx], ax
inc edx
dec word[j1]
cmp word[j1], 0
je dec_i
back:
cmp word[i1], 0
jne repeat
jmp next

;Decrementing the value of i
dec_i:

dec word[i1];
mov ax, word[n1]
mov word[j1], ax
jmp back

;Printing the matrix A
next:
mov edx, 0
mov ebx, A_matrx
mov ax, word[m1]
mov word[i], ax

mov ax, word[n1]
mov word[j], ax
mov word[temp1], ax
call input_print

;For Matrix B

;Printing the text for asking rows of matrix B

mov eax, 4
mov ebx, 1
mov ecx, m1b
mov edx, size_m1b
int 80h

call input
mov ax, word[num]
mov word[m2], ax

;Priniting the text for  columns of matrix B

mov eax, 4
mov ebx, 1
mov ecx, m2b
mov edx, size_m2b
int 80h

call input
mov ax, word[num]
mov word[n2], ax

;Printing the text for  elements of matrix B

mov eax, 4
mov ebx, 1
mov ecx, read_array
mov edx, size_read_array
int 80h

mov edx, 0
mov ebx, B_matrx
mov ax, word[m2]
mov word[i1], ax

mov ax, word[n2]
mov word[j1], ax

repeatB:
call input
mov ax, word[num]
mov word[ebx + 2 * edx], ax
inc edx
dec word[j1]
cmp word[j1], 0
je dec_i_b
backB:
cmp word[i1], 0
jne repeatB
jmp nextB

;Decrementing the value of i
dec_i_b:

dec word[i1];
mov ax, word[n2]
mov word[j1], ax
jmp backB

;Printing the matrix B
nextB:
mov edx, 0
mov ebx, B_matrx
mov ax, word[m2]
mov word[i], ax

mov ax, word[n2]
mov word[j], ax
mov word[temp1], ax
call input_print

; checking compatibility
mov ax, word[m2]
cmp word[n1], ax
je ok

mov eax, 4
mov ebx, 1
mov ecx, error
mov edx, size_error
int 80h
jmp exit

ok:

;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!;Multiplying two matrices

mov word[i], 0
mov word[j], 0
mov word[k], 0

i_loop:
mov word[j], 0

j_loop:
mov word[k], 0

k_loop:

;Getting a[i][k]
pusha
mov ax, word[i]
mov cx, word[n1]
mul cl
add ax, word[k]
mov bx, word[A_matrx + 2 * eax]
mov word[t1], bx
popa

;Getting b[k][j]
pusha
mov ax, word[k]
mov cx, word[n2]
mul cl
add ax, word[j]
mov bx, word[B_matrx + 2 * eax]
mov word[t2], bx
popa

;Multiplying a[i][k] * b[k][j]
mov ax, word[t1]
mov cx, word[t2]
mul cl
mov word[t], ax

;Getting c[i][j]
mov ax, word[i]
mov cx, word[n2]
mul cl
add ax, word[j]
mov cx, word[t]
add word[C_matrx + 2 * eax], cx
inc word[k]
mov cx, word[k]
cmp word[n1], cx
jne k_loop

inc word[j]
mov dx, word[j]
cmp word[n2], dx
jne j_loop

inc word[i]
mov ax, word[i]
cmp word[m1], ax
jne i_loop

;Printing the matrix C
mov edx, 0
mov ebx, C_matrx
mov ax, word[m1]
mov word[i], ax

mov ax, word[n2]
mov word[j], ax
mov word[temp1], ax

;Printing the text for result
pusha
mov eax, 4
mov ebx, 1
mov ecx, result
mov edx, size_result
int 80h
popa


repeat2:
mov ax, word[ebx + 2 * edx]
mov word[num], ax
call print

pusha
mov eax, 4
mov ebx, 1
mov ecx, space
mov edx, 1
int 80h
popa

inc edx
dec word[j]
cmp word[j], 0
je dec_i_again2
back3:
cmp word[i], 0
jne repeat2
jmp exit

dec_i_again2:

dec word[i];
mov ax, word[temp1]
mov word[j], ax

pusha
mov eax, 4
mov ebx, 1
mov ecx, newline
mov edx, 1
int 80h
popa

jmp back3

;System Exit
exit:
mov eax, 1
mov ebx, 0
int 80h

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Function to print the inputted array
dec_i_again:

dec word[i];
mov ax, word[temp1]
mov word[j], ax

pusha
mov eax, 4
mov ebx, 1
mov ecx, newline
mov edx, 1
int 80h
popa

jmp back2

input_print:

;Printing the text for saying the input array is:
pusha
mov eax, 4
mov ebx, 1
mov ecx, reslt_array
mov edx, size_reslt_array
int 80h
popa


repeat1:
mov ax, word[ebx + 2 * edx]
mov word[num], ax
call print

pusha
mov eax, 4
mov ebx, 1
mov ecx, space
mov edx, 1
int 80h
popa

inc edx
dec word[j]
cmp word[j], 0
je dec_i_again
back2:
cmp word[i], 0
jne repeat1

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Function to take the input
input:

pusha

mov word[num], 0

loopadd:
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

cmp byte[temp], 10
je end_read

mov ax, word[num]
mov bx, 10
mul bx
sub byte[temp], 30h
mov bl, byte[temp]
mov bh, 0
add ax, bx
mov word[num], ax
jmp loopadd

end_read:
popa

ret

;;;;;;;Function to print a number
print:


pusha
cmp word[num],0
je print_zero
extract:
cmp word[num], 0
je print_no
inc byte[nod]
mov dx, 0
mov ax, word[num]
mov bx, 10
div bx
push dx
mov word[num], ax
jmp extract

print_no:
cmp byte[nod], 0
je end_print
dec byte[nod]
pop dx
mov byte[temp], dl
add byte[temp], 30h

mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h

jmp print_no

print_zero:
pusha
mov eax, 4
mov ebx, 1
mov ecx, zero
mov edx, lzero
int 80h
popa
end_print:

popa

ret
