section .data
msg1: db 'Enter the number',0ah
lmsg1: equ $-msg1
msg2: db 'the factorial is...',0ah
lmsg2: equ $-lmsg1


section .bss
num:resb 4
prt_i:resb 4
print_digit:resb 4


out_read:resb 4
in_digit:resb 4
i:resb 4
j:resb 4
ct:resb 4
sum_fact:resb 4
section .text

global _start:
_start:


        mov eax,4
        mov ebx,1
        mov ecx,msg1
        mov edx,lmsg1
        int 80h
         mov dword[sum_fact],1
        call read
        call factorial
        
         mov ebx,dword[sum_fact]
         mov dword[num],ebx 
          call print
    
     









    mov eax, 1
    mov ebx,0
    int 80h

factorial:
pusha
     cmp dword[out_read],1
     je end 
      
     mov ebx,dword[sum_fact]

     mov eax,dword[out_read]
     mul ebx
      
      mov dword[sum_fact],eax
      dec dword[out_read]
      call factorial
 end:
 popa
 ret


















read:
pusha 
  mov dword[out_read],0
 loop_read:
        
	mov eax,3
	mov ebx,0
        mov ecx,in_digit
        mov edx,1
        int 80h

	cmp dword[in_digit],10
        je end_read_loop


        mov eax,dword[out_read]
        mov ebx,10
        mov edx,0
	mul ebx
        mov dword[out_read],eax
       
        mov ebx,dword[in_digit]
        sub ebx,030h
        mov eax,dword[out_read]
        add eax,ebx
        mov dword[out_read],eax
        jmp loop_read

  end_read_loop:

popa 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print:
pusha
	mov dword[prt_i],0
 loop_print:
	mov eax,dword[num]
        mov ebx,10
	mov edx,0
	div ebx
	push edx
        mov dword[num],eax


        inc dword[prt_i]
	cmp eax,0
        jne loop_print
 print_num:      
        pop edx
        add edx,030h
        mov dword[print_digit],edx
        
 
        mov eax,4
	mov ebx,1
	mov ecx,print_digit
	mov edx,1
	int 80h
        
        dec dword[prt_i]
        cmp dword[prt_i],0
        jne print_num
        
popa 
ret
