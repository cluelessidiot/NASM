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
space:db ' 	'
lspace:equ $-space

section .text
global _start:
_start:

    mov eax,4
    mov ebx,1
    mov ecx,msg1
    mov edx,lmsg1
    int 80h

mov word[ar_sma],0
mov word[small],300
call ar_read
mov ax,word[large]
mov word[num],ax
call print 	
call enter_space
mov ax,word[small]
mov word[num],ax
call print 	
call enter
call ar_traversesma
call ar_traverselar
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
 		call sma_ct
		call lar_ct
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lar_ct:
pusha
      cmp word[dig],' '
      je lar
      cmp word[dig],10
      je lar
       inc word[ar_lar]
       jmp end_lar
 lar:
      
      mov ax,word[ar_lar]
      cmp word[large],ax
           ja end_l
     mov word[large],ax
    end_l:	
       mov word[ar_lar],0
       
    end_lar:
      
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sma_ct:
pusha
      cmp word[dig],' '
      je sma
      cmp word[dig],10
      je sma
       inc word[ar_sma]
       

     
       jmp end_sma
 sma:     
        cmp word[ar_sma],0
         je end_sma
	mov ax,word[ar_sma]
	mov word[ar_sma],0
         cmp word[small],ax
            jna end_sma

 	mov word[small],ax

        

             ;mov word[num],ax
            ;call print
                       
	     ;call enter_space
         
    end_sma:
             ;mov ax,word[ar_sma]
             ;mov word[num],ax
            ;call print
            ;call enter
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
ar_traversesma:
pusha
   mov word[ar_j],0
    

 loop_arrayt:
         mov ebx,array
 	 movzx eax,word[ar_j]
	 
        
        
  	   mov cx,word[ebx+2*eax]
           mov word[dig],cx
          mov word[num],cx
           ; call print_strng
	    ; call enter  
           inc word[ar_j]
 		call smachk_ct
		
           cmp word[dig],10
            je end_art
                   
           
           jmp loop_arrayt

end_art:
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
smachk_ct:
pusha
      cmp word[dig],' '
      je smachk
      cmp word[dig],10
      je smachk
      inc word[ar_sma]
       jmp end_smachk

 smachk:
	mov ax,word[ar_sma]
	mov word[ar_sma],0
         cmp ax,word[small]
            je  call_prt 
            jmp end_smachk
    call_prt:
           call prt 

         
 end_smachk:
    
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
prt:
pusha
     call enter
     mov ax,word[ar_j]
     mov word[ar_i],ax
     mov word[ar_k],0	
     mov ax,word[ar_i]
     sub ax,word[small]
     sub ax,1
     mov word[ar_i],ax 
loop_prt:
     movzx eax,word[ar_i]
     movzx edx,word[ar_k]
     mov ebx,array
     add edx,eax
     mov cx,word[ebx+2*edx]
     mov word[num],cx
     call print_strng

     inc word[ar_k]
     mov ax,word[small]
     cmp ax,word[ar_k]
     je end_prt
      jmp loop_prt



end_prt:



popa
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
larchk_ct:
pusha
      cmp word[dig],' '
      je larchk
      cmp word[dig],10
      je larchk
      inc word[ar_lar]
       jmp end_larchk

 larchk:
	mov ax,word[ar_lar]
	mov word[ar_lar],0
         cmp ax,word[large]
            je  call_lprt 
            jmp end_larchk
    call_lprt:
           call lprt 

         
 end_larchk:
    
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ar_traverselar:
pusha
   mov word[ar_j],0
   mov word[ar_lar],0 

 loop_arraylar:
         mov ebx,array
 	 movzx eax,word[ar_j]
	 
        
        
  	   mov cx,word[ebx+2*eax]
           mov word[dig],cx
          mov word[num],cx
           ; call print_strng
	    ; call enter  
           inc word[ar_j]
 		call larchk_ct
		
           cmp word[dig],10
            je end_arlar
                   
           
           jmp loop_arraylar

end_arlar:
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lprt:
pusha
     call enter
     mov ax,word[ar_j]
     mov word[ar_i],ax
     mov word[ar_k],0	
     mov ax,word[ar_i]
     sub ax,word[large]
     sub ax,1
     mov word[ar_i],ax 
loop_lprt:
     movzx eax,word[ar_i]
     movzx edx,word[ar_k]
     mov ebx,array
     add edx,eax
     mov cx,word[ebx+2*edx]
     mov word[num],cx
     call print_strng

     inc word[ar_k]
     mov ax,word[large]
     cmp ax,word[ar_k]
     je end_lprt
      jmp loop_lprt



end_lprt:



popa
ret



