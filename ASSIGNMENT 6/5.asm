section .data
msg1: db 'Enetr the numbers',0ah
lmsg1: equ $-msg1
msg2: db 'the sum is...',0ah
lmsg2: equ $-lmsg1


section .bss
num:resb 2
prt_i:resb 2
print_digit:resb 2


out_read:resb 2
in_digit:resb 2
i:resb 2
j:resb 2
ct:resb 2
sum_fib:resb 2
section .text

global _start:
_start:


        mov eax,4
        mov ebx,1
        mov ecx,msg1
        mov edx,lmsg1
        int 80h
        mov word[sum_fib],0
    
         call read
        call fib_sums
      mov ax,word[sum_fib]  
     mov word[num],ax 
      call print 

    mov eax, 1
    mov ebx,0
    int 80h










fib_sums:
pusha
   cmp word[out_read],1
   jne not1
   mov ax,word[sum_fib]
   add ax,1
   mov word[sum_fib],ax
   jmp end
not1:
   cmp word[out_read],0
    jne not0
       mov ax,word[sum_fib]
   add ax,0
   mov word[sum_fib],ax
   jmp end
not0:
       dec word[out_read]
       mov ax,word[out_read]
       push ax 
    call fib_sums
       pop ax
       mov word[out_read] ,ax  
       dec word[out_read]
     call fib_sums
 end:
 popa
 ret




read:
pusha 
  mov word[out_read],0
 loop_read:
        
	mov eax,3
	mov ebx,0
        mov ecx,in_digit
        mov edx,1
        int 80h

	cmp word[in_digit],10
        je end_read_loop


        mov ax,word[out_read]
        mov bx,10
        mov dx,0
	mul bx
        mov word[out_read],ax
       
        mov bx,word[in_digit]
        sub bx,030h
        mov ax,word[out_read]
        add ax,bx
        mov word[out_read],ax
        jmp loop_read

  end_read_loop:

popa 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print:
pusha
	mov word[prt_i],0
 loop_print:
	mov ax,word[num]
        mov bx,10
	mov dx,0
	div bx
	push dx
        mov word[num],ax


        inc word[prt_i]
	cmp ax,0
        jne loop_print
 print_num:      
        pop dx
        add dx,030h
        mov word[print_digit],dx
        
 
        mov eax,4
	mov ebx,1
	mov ecx,print_digit
	mov edx,1
	int 80h
        
        dec word[prt_i]
        cmp word[prt_i],0
        jne print_num
        
popa 
ret

