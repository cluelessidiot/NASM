section .bss
d1:resb 2
d2:resb 2
n:resb 2
num:resb 2
num1:resb 2
index_post:resb 2
temp:resb 2
temp1:resb 2
numcount:resb 2
count:resb 2
arraynum:resb 2
arrayct:resb 2
array:resb 100
a:resb 2
b:resb 2
i:resb 2
increm:resb 2
j:resb 2
k:resb 2
value:resb 2
value1:resb 2
rowct:resb 2
colct:resb 2
section .data
m1: db 'enter the number of rows ',0ah
l1:equ $-m1
m2:db 'enter the number of columns',0ah
l2:equ $-m2
m3:db 'enter elemnts in row wise',0ah
l3:equ $-m3
tab:db '	'
ltab: equ $-tab
space: db ' '
lspace:equ $-space
newline:db '',0ah
lnewline:equ $-newline
nl:db ' ',0ah
l4:equ $-nl
zero: db '0'
l5:equ $-zero
section .text
global _start:
_start:

	mov eax, 4
	mov ebx, 1
	mov ecx,m1
	mov edx,l1
	int 80h
     
     call input
	mov ax,word[num]
     mov word[arraynum],ax
     mov word[arrayct],ax
     mov word[rowct],ax
     

	mov eax, 4
	mov ebx, 1
	mov ecx,m2
	mov edx,l2
	int 80h

        call input
	mov ax,word[num]
        mov word[colct],ax
        mov bx,word[arraynum]
        mov dx ,0
        mul bx
        mov word[arraynum],ax
        mov word[arrayct],ax



	mov eax, 4
	mov ebx, 1
	mov ecx,m3
	mov edx,l3
	int 80h     


 ;reading elements to matrix     
      mov ebx,array
      push ebx

array_read:
       push ebx
        
        call input
	mov ax,word[num]
	pop ebx
	mov word[ebx],ax	
	inc ebx
	inc ebx
	push ebx
	dec word[arrayct]
	cmp word[arrayct],0
        jg array_read


    call print_matrix    
 ;call positive_traverse   
;call print_matrix    
 ;call negative_traverse
   mov word[i],0
   mov word[temp1],0
traversing:
     mov ax,word[rowct]
     cmp ax,word[i]
     je exit
    mov dx,word[temp1]
    cmp dx,0
    je positive
    jmp negative
   incrementer:
    inc word[i]
    jmp traversing 

positive:
mov word[temp1],1
mov ax,word[i]
mov word[index_post],ax
call positive_traverse
jmp incrementer
negative:
mov word[temp1],0
mov ax,word[i]
mov word[index_post],ax
call negative_traverse
jmp incrementer


exit:
        mov eax,1
	mov ebx,0
        int 80h












negative_traverse:

pusha

 mov ax,word[colct];
 mov bx ,2
 mov dx,0
 mul bx
 mov word[increm],ax
 mov ax,word[colct];
mov word[j],ax
dec word[j]
mov ax,word[index_post]
mov word[i],ax
i_nloop:
mov ax,word[i]
;addi ax,1
mov bx, word[increm]
mov dx,0
mul bx
mov word[value],ax
mov ax,word[j]
mov dx,0
mov bx,2
mul bx
add word[value],ax


mov ebx,array
movzx eax,word[value]
add ebx,eax
mov dx,word[ebx]
mov word[num],dx
call print
pusha
	mov eax, 4
	mov ebx, 1
	mov ecx,space
	mov edx,lspace
	int 80h
popa

dec word[j]
mov ax,word[j]
cmp ax,0
jnl i_nloop

popa
ret

positive_traverse:
pusha
 mov ax,word[colct];
 mov bx ,2
 mov dx,0
 mul bx
 mov word[increm],ax
mov word[j],0
mov ax,word[index_post]
mov word[i],ax
i_dloop:
mov ax,word[i]
mov bx,word[increm]
mov dx,0
mul bx
mov word[value],ax
mov ax,word[j]
mov dx,0
mov bx,2
mul bx
add word[value],ax


mov ebx,array
movzx eax,word[value]
add ebx,eax
mov dx,word[ebx]
mov word[num],dx
call print

pusha
	mov eax, 4
	mov ebx, 1
	mov ecx,space
	mov edx,lspace
	int 80h
popa
inc word[j]
mov ax,word[j]
cmp ax,word[colct]
jne i_dloop





 
;inc word[i]
;inc word[j]
;mov ax,word[i]
;cmp ax,word[rowct]


popa
ret




print_matrix:

pusha

 mov ax,word[colct];
 mov bx ,2
 mov dx,0
 mul bx
 mov word[increm],ax
 mov eax,0       
 mov word[i],0	
 mov word[j],0
 
i_loop:
mov word[j],0
j_loop:
mov ax,word[i]
mov bx, word[increm]
mov dx,0
mul bx
add ax,word[j]
add ax,word[j]
mov word[value],ax

mov ebx,array
movzx eax,word[value]
add ebx,eax
mov dx,word[ebx]
mov word[num],dx


call print
pusha

	mov eax, 4
	mov ebx, 1
	mov ecx,tab
	mov edx,ltab
	int 80h     
popa
inc word[j]
mov ax,word[j]
cmp ax,word[colct]
jne j_loop
pusha
	mov eax, 4
	mov ebx, 1
	mov ecx,newline
	mov edx,lnewline
	int 80h     

popa
inc word[i]
mov ax,word[i]
cmp ax,word[rowct]
jne i_loop

popa
ret


input: 
 mov word[num],0
pusha
nextnum:
	mov eax,3
	mov ebx,1
	mov ecx,d1
	mov edx,1
	int 80h
	
	       
	mov ax,word[d1]
	cmp ax,10
        je exit_input

         mov ax,word[num]
	mov bx,10
	mul bx
	mov bx,word[d1]
	sub bx,030h
	add ax,bx
	mov word[num],ax
         jmp nextnum
exit_input:
        popa
ret

print:
pusha
 cmp word[num], 0
 je  print_zero

mov word[numcount],0
remnumb:
	mov ax,word[num]
	cmp ax,0
	je print_numb
         mov dx,0
	 mov bx,10
	 div bx
         push dx                ;entering elements to the stack ..i neeeed that elements....rev order...
       mov word[num],ax
	inc word[count]
	jmp  remnumb
          
       
print_numb:
         cmp word[count],0
         je printover_newline
         dec word[count]
	
        pop dx
	add dx,030h
        mov word[temp],dx
        mov eax, 4
	mov ebx, 1
	mov ecx,temp
	mov edx,1
	int 80h
       
      jmp print_numb

print_zero:
        mov eax, 4
	mov ebx, 1
	mov ecx,zero
	mov edx,l5
	int 80h 

printover_newline:
;       mov eax, 4
;	mov ebx, 1
;	mov ecx,nl
;	mov edx,l4
;	int 80h

popa


ret



