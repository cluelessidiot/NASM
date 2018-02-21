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
pal:db 'palindrome',0ah
lpal:equ $-pal
npal: db 'not palindrome',0ah
lnpal:equ $-npal
section .text
global _start:
_start:


        mov eax,4
	mov ebx,1
	mov ecx,ms1
	mov edx,l1
        int 80h 
  




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


 	mov ebx,array
 	movzx ecx,word[a_i]
         inc word[dig]
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
       je end_pal

    cmp word[a_i],1
       je ypal


   mov ebx,vow
   mov word[a_k],0
   mov  ax, word[a_i]
   mov word[a_j],ax
   dec word[a_j]

  loop_chk:
      mov ebx,array
      movzx ecx,word[a_k]
      mov dx,word[ebx+2*ecx]

      mov ebx,array
      movzx ecx,word[a_j]
      mov ax,word[ebx+2*ecx]
        inc word[a_k]
        dec word[a_j]
        
        cmp ax,dx
         je chklen
         cmp ax,dx
         jne not_pal
 chklen:
      mov ax,word[a_j]
       cmp ax,word[a_k]
           jna ypal
       jmp loop_chk

ypal:
    	mov eax,4
	mov ebx,1
	mov ecx,pal
	mov edx,lpal
        int 80h
jmp end_pal
not_pal:
    	mov eax,4
	mov ebx,1
	mov ecx,npal
	mov edx,lnpal
        int 80h
     
 end_pal:         
popa 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 





