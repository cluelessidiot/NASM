;;;;;;;;;;decrypt
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
vow: dw 'A','I'
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
call chk

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
    
pusha

     

       	mov eax,4
	mov ebx,1
	mov ecx,num
	mov edx,1
        int 80h
       
  
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

        inc word[dig]
 	mov ebx,array
 	movzx ecx,word[a_i]
        mov dx,word[dig]
        mov word[2*ecx+ebx],dx
          inc word[a_i]
     jmp loop_arr
  ar_end:
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
chk:
pusha
   cmp word[a_i],0
    je endchk
   mov ebx,vow
   mov word[a_k],0
   

  loop_chk:
      mov ebx,array
      movzx ecx,word[a_k]
      mov dx,word[ebx+2*ecx]
       mov word[num],dx
        call print
        inc word[a_k]
        mov ax,word[a_k]
        cmp ax,word[a_i]
         jne loop_chk
endchk:           
popa 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 





