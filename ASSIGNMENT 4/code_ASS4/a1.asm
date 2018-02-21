section .bss
array: resb 200
i:resb 2

out_read: resb 2
dig:resb 2
a_i:resb 2
a_j:resb 2
a_k:resb 2
val:resb 2
ct:resb 2

num:resb 2
prt_i:resb 2
section .data
ms1: db 'Enter the string',0ah
l1:equ $-ms1
vow: dw 'a','e','i','o','u','A','E','I','O','U'
lvow: equ $-vow
section .text
global _start:
_start:


        mov eax,4
	mov ebx,1
	mov ecx,ms1
	mov edx,l1
        int 80h 
  mov ebx,vow
  mov ax,word[ebx]
  inc ax
  mov word[i],ax
  




call arr
mov ax,word[ct]
mov word[num],ax
 call print

	mov eax,1
	mov ebx,0
	int 80h





read:
pusha
  mov word[out_read],0
 loop_read:
	
	mov eax,3
	mov ebx,0
	mov ecx,dig
	mov edx,1
        int 80h
         
  	cmp word[dig],10
        je end_read
                    
        
        mov ax,word[out_read]
  	mov bx,10
        mov dx,0
        mul bx
        mov dx,word[dig]
 	sub dx,030h
	add dx,ax


	mov word[out_read],dx
        jmp loop_read
 end_read:
popa
ret
print:
    mov word[prt_i],0
pusha
     loop_print:
 	mov ax,word[num]
        mov dx,0
	mov bx,10
        div bx
        inc word[prt_i] 
  	push dx
        mov word[num],ax
         cmp ax,0
          jne loop_print
     loop_ext:


         pop dx
         add dx,030h
	 mov word[dig],dx

       	mov eax,4
	mov ebx,1
	mov ecx,dig
	mov edx,1
        int 80h
       
        dec word[prt_i]
        cmp word[prt_i],0
         jne loop_ext
 popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;      
arr:
pusha
      mov ebx,array
      mov word[a_i],0
      mov word[ct],0
   loop_arr:
        

       mov eax,3
	mov ebx,0
	mov ecx,dig
	mov edx,1
        int 80h
         
       cmp word[dig],10
        je ar_end
         
 	mov ebx,array
 	movzx ecx,word[a_i]
        mov dx,word[dig]
        mov word[2*ecx+ebx],dx
          call chk
          inc word[a_i]
     jmp loop_arr
  ar_end:
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
chk:
pusha
   mov ebx,vow
   mov word[a_j],10
   mov word[a_k],0
   

  loop_chk:
      mov ebx,vow
      movzx ecx,word[a_k]
      mov dx,word[ebx+2*ecx]
      inc word[a_k]
      cmp  dx,word[dig]      
      je ct_inc
       jmp ck
ct_inc:
    inc word[ct]
     

    ck:
        mov ax,word[a_k]
        cmp ax,word[a_j]
         jne loop_chk           
popa 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 





