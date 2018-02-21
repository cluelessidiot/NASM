section .data
msg1:db 'enter your name',0ah
l1:equ $-msg1
msg2: db 'enter the number of elements in list',0ah
l2:equ $-msg2
newline:db '',0ah
lnewline:equ $-newline
section .bss

out_read:resb 2
in_digit:resb 2

sum:resb 2
digit:resb 2
count:resb 2
num:resb 2

array:resb 200
array_count:resb 2
array_i:resb 2
array_j:resb 2
array_inc:resb 2
section .text
global _start:
_start:




	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,l1
	int 80h

call  input
mov ax,word[out_read]
mov word[num],ax
call print_num
       
       mov eax,4
       mov ebx,1
       mov ecx,msg2 
       mov edx,l2
       int 80h
    call input
       
      mov ax,word[out_read]

      mov word[array_count],ax

      call array_read
      call array_print







	mov eax,1
	mov ebx,0
        int 80h


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
input:
mov ax,0
mov word[out_read],ax

pusha
     dig_loop:
	mov eax,3
	mov ebx,0
	mov ecx,in_digit
	mov edx,1
	int 80h

        cmp word[in_digit],0ah
        je in_end
        
         mov bx,10
         mov ax,word[out_read]
         mov dx,0
         mul bx
         mov word[out_read],ax
         mov ax,word[in_digit]
         sub ax,030h
         add word[out_read],ax 
         mov ax,word[out_read]
         jmp dig_loop
 
   in_end:
popa
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_num:
pusha
	mov bx,0
	mov word[count],bx
ext_loop:
   mov ax,word[num]
   mov bx,10
   mov dx,0
   div bx
   push dx
   inc word[count]
   mov word[num],ax
   cmp ax,0
   jne ext_loop

print_loop:
   pop dx
   add dx,030h 
   mov word[digit],dx


    mov eax,4
    mov ebx,1
    mov ecx,digit
    mov edx,1
    int 80h

     dec word[count]
     mov bx,word[count]
    
     cmp bx,0
     jne print_loop

popa
ret   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

array_read:
pusha
  mov word[array_i],0
  mov ax,word[array_count]
  mov word[array_j],ax
 
read_loop:
  call input
  mov ax,word[array_i]
  mov word[array_inc],ax
  shl word[array_inc],1

  mov ebx,array
  movzx ecx,word[array_inc]
  add ebx,ecx
  mov ax,word[out_read]
  mov word[ebx],ax
   

  inc word[array_i]
  mov ax,word[array_i]
 ; mov word[num],ax
 ; call print_num  
  cmp word[array_j],ax
  jne read_loop
 
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
array_print:
pusha

        mov ax,word[array_count]
        mov word[array_j],ax
        mov word[array_i],0
        
        
  loop_print_array:
        mov ax, word[array_i]
        
        mov word[array_inc],ax
        shl word[array_inc],1
        mov  ax,word[array_inc]
        mov word[num],ax
        
         
        
         movzx eax,word[array_inc]
         mov ebx,array 
         add ebx,eax
      
        
        
         
        mov ax,word[ebx]

        mov word[num],ax
        call print_num
        call print_newline
         
        inc word[array_i]
        mov ax,word[array_j]
        cmp word[array_i],ax
        jne loop_print_array
         
        
popa
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_newline:
pusha
    mov eax,4
    mov ebx,1
    mov ecx,newline
    mov edx,lnewline
    int 80h
popa
ret





