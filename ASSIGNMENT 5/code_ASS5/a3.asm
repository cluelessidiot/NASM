section .bss

ar_ct:resb 2
ar_i:resb 2
ar_j:resb 2
ar_k:resb 2
ar_x:resb 2
ar_tp:resb 2
ar_lar:resb 2
ar_ct1:resb 2
ar_sma:resb 2
prt_i:resb 2
print_digit:resb 2
dig:resb 2
num: resb 2
out_read: resb 2

large:resb 2
small:resb 2

array:resb 300
sub_s:resb 300
sub_l:resb 300

section .data 

msg1:db 'enter the string ',0ah
lmsg1:equ $-msg1
key_enter:db ' ',0ah
lenter:equ $-key_enter 
space:db ' '
lspace:equ $-space

section .text
global _start:
_start:

    mov eax,4
    mov ebx,1
    mov ecx,msg1
    mov edx,lmsg1
    int 80h
call ar_read
call ar_traverse

       mov eax,1
	mov ebx,0
        int 80h




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ar_read:
pusha
   mov word[ar_j],0
   mov word[ar_ct],0   

 loop_array:
         mov ebx,array
 	 movzx eax,word[ar_j]
	 
            call read
            cmp word[dig],10
            je end_ar
          mov cx,word[dig]
           inc word[ar_ct]
  	   mov word[ebx+2*eax],cx  
           inc word[ar_j]

           
       jmp loop_array

end_ar:
popa
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ar_traverse:
pusha
   
   mov ax,word[ar_ct]   
   mov word[ar_j],ax
    mov word[ar_tp],0
 loop_ar_traverse:
         mov ebx,array
 	 movzx eax,word[ar_j]
	   
  	   mov cx,word[ebx+2*eax] 
           cmp cx,' '
           je  ar_prt
           inc word[ar_tp]
         
          mov ax,word[ar_j]
          cmp ax,0
          je ar_prtfirst                           
           
     
 rem:
            
           dec word[ar_j]
           
       jmp loop_ar_traverse
;;;;;;;;;;
ar_prtfirst:
   cmp word[ar_tp],0
   je rem
   mov word[ar_x],0
lar_prtfirst:
  movzx eax,word[ar_j]
  


   movzx edx,word[ar_x]
   add edx,eax
   mov cx,word[ebx+2*edx]
   mov word[num],cx
   call print_strng
   inc word[ar_x]
   dec word[ar_tp]
   cmp word[ar_tp],0
   jne lar_prtfirst
   call enter_space
          mov ax,word[ar_j]
          cmp ax,0
          je end_ar_tra
          
 
   jmp rem



ar_prt:
   cmp word[ar_tp],0
   je rem
   mov word[ar_x],0
lar_prt:
  movzx eax,word[ar_j]
  inc eax


   movzx edx,word[ar_x]
   add edx,eax
   mov cx,word[ebx+2*edx]
   mov word[num],cx
   call print_strng
   inc word[ar_x]
   dec word[ar_tp]
   cmp word[ar_tp],0
   jne lar_prt
   call enter_space
       
          
 
   jmp rem
;;;;;;;;;;;

 

end_ar_tra:
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


































read:

pusha
        mov eax,3
	mov ebx,0
	mov ecx,dig
	mov edx,1
	int 80h
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

print_strng:
    
pusha

     

       	mov eax,4
	mov ebx,1
	mov ecx,num
	mov edx,1
        int 80h
       
  
 popa
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enter:
pusha
        mov eax,4
	mov ebx,1
	mov ecx,key_enter
	mov edx,lenter
	int 80h
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enter_space:
pusha
            mov eax,4
	mov ebx,1
	mov ecx,space
	mov edx,lspace
	int 80h
popa 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

