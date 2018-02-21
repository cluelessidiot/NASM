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
print_dig:resb 2
dig:resb 2
num: resb 2
out_read: resb 2

large:resb 2
small:resb 2
cap_flag:resb 2
sma_flag:resb 2
array:resb 300
sub:resb 300
sub_i:resb 2
sub_j:resb 2
sub_k:resb 2
sub_ct:resb 2
sub_x:resb 2
sub_y:resb 2
sub_dig:resb 2	
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

mov word[cap_flag],0
call ar_read
call ar_traverse

mov ax,word[small]
mov word[num],ax
call print


	mov eax,1
	mov ebx,0
        int 80h


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ar_read:
pusha
   mov word[ar_j],0
   mov word[ar_ct],0   

 loop_array:
         mov ebx,array
 	 movzx eax,word[ar_j]
	 
          call read
          mov cx,word[dig]
           inc word[ar_ct]
  	   mov word[ebx+2*eax],cx  
           inc word[ar_j]
 		;call sma_ct
		;call lar_ct
           cmp word[dig],10
            je end_ar
                   
           
           jmp loop_array
end_ar:
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
read:
pusha
        mov eax,3
	mov ebx,0
	mov ecx,dig
	mov edx,1
	int 80h
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
        mov word[print_dig],dx
        
 
        mov eax,4
	mov ebx,1
	mov ecx,print_dig
	mov edx,1
	int 80h
        
        dec word[prt_i]
        cmp word[prt_i],0
        jne print_num
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

print_strng:
    
pusha
       	mov eax,4
	mov ebx,1
	mov ecx,num
	mov edx,1
        int 80h
popa
ret
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cap_chk:
pusha

  cmp word[dig],'A'
  jb not_cap
  cmp word[dig],'Z'
  ja not_cap
  mov word[cap_flag],1
  jmp end_cap
not_cap:
  mov word[cap_flag],0
end_cap:

popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sma_chk:
pusha

  cmp word[dig],'a'
  jb not_sma
  cmp word[dig],'z'
  ja not_sma
  mov word[sma_flag],1
  jmp end_sma
not_sma:
  mov word[sma_flag],0
end_sma:

popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ar_traverse:
pusha
   mov word[ar_j],0
    

 loop_arraytraverse:
         mov ebx,array
 	 movzx eax,word[ar_j]
	 
        
        
  	   mov cx,word[ebx+2*eax]
           mov word[dig],cx
            inc word[ar_j]
           call cap_chk
           cmp word[cap_flag],1
           jne end_chk

loop_cap:
       mov ebx,array
       movzx eax,word[ar_j]
	      
      mov cx,word[ebx+2*eax]
      mov word[dig],cx
      cmp word[dig],10
       je end_artrav
      call sma_chk
      call cap_chk
      cmp word[sma_flag],1 
      je counter  

      cmp word[cap_flag],1 
      je reset

  cmp word[sma_flag],0 
      je repeater
counter:
      call subarray_counter
    ;  inc word[ar_sma]
      inc word[ar_j]
      jmp loop_cap
 


  
  reset:
   call small_num
   mov ax,word[small]
   cmp ax,word[large]
   ja end_reset
   mov ax,word[large]
   mov word[small],ax
   

end_reset:
   mov word[ar_sma],0
   mov word[sub_j],0
   jmp   loop_arraytraverse

 repeater:
      inc word[ar_j]
     jmp loop_cap
           
;mov ax,word[sma_flag]
;mov word[num],ax
;call print
;call enter_space           
           
end_chk:		
           cmp word[dig],10
            je end_artrav
                   
           
          jmp loop_arraytraverse

end_artrav:
popa
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 

subarray_counter:
pusha
   
       mov ebx,array
       movzx eax,word[ar_j]
	      
       mov cx,word[ebx+2*eax]
      
      


       mov ebx,sub
       movzx eax,word[sub_j]
	      
      mov word[ebx+2*eax],cx

      mov word[sub_i],0
      inc word[sub_j]
       mov ax,word[sub_j]
      mov word[sub_ct],ax
     
popa
ret




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
small_num:
pusha
   cmp word[sub_j],0
    je end_small
  mov word[sub_x],0
mov word[large],0
  mov ax,word[sub_j]
  inc ax
  mov word[sub_ct],ax
loop_small:
       mov ebx,sub
       movzx eax,word[sub_x]

      mov cx,word[ebx+2*eax]
      mov word[sub_dig],cx

      mov ax,word[sub_x]	                                       
      mov word[sub_y],ax
      inc word[sub_y]

        
 loop_y:
       mov ebx,sub
       movzx eax,word[sub_y]
                                             
       mov cx,word[ebx+2*eax]
 
       mov ebx,sub
       movzx eax,word[sub_x]
       mov dx,word[ebx+2*eax]           



      cmp cx,dx										   
      je inc_x  
                                         
   
  

inc_y:
       inc word[sub_y]
       mov ax,word[sub_y]
       cmp ax,word[sub_ct]
        jne loop_y
      inc word[large]
       
inc_x:
       inc word[sub_x]
       mov ax,word[sub_x]
       cmp ax,word[sub_j]
        jne loop_small

end_small:
      mov word[sub_x],0
mov word[sub_y],0
popa
ret
