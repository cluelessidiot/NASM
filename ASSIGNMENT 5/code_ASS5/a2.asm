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
ar_y:resb 2
pal_flag:resb 2

prt_i:resb 2
print_digit:resb 2
dig:resb 2
num: resb 2
out_read: resb 2
same resb 2
large:resb 2
small:resb 2
wstr:resb 2
warr:resb 2
array:resb 300
sub_s:resb 300
sub_l:resb 300

word1:resb 100
word2:resb 100
w1_j:resb 2
w2_j:resb 2
w1_ct:resb 2
w2_ct:resb 2
section .data 

msg1:db 'enter the string ',0ah
lmsg1:equ $-msg1
msg2:db 'enter the string to removed ',0ah
lmsg2:equ $-msg2
msg3:db 'enter the string to add ',0ah
lmsg3:equ $-msg3
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

mov word[ar_ct],0
call ar_read

call ar_traverse
;mov ax,word[ar_ct]
;dec ax
;mov word[ar_x],4
;mov word[ar_y],5
;call chk

  ;  mov ax,word[pal_flag]
 ;   mov word[num],ax 
  ; call print

       mov eax,1
	mov ebx,0
        int 80h




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ar_read:
pusha
      mov edi,array
      mov eax,0
  reading_array:
      call read
        cmp word[dig],10
         je end_ar
       mov ax,word[dig]
      STOSW
        inc word[ar_ct]
       jmp reading_array

end_ar:
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ar_traverse:
pusha
   mov word[ar_i],0
 

 loop_arrayi:
         
    mov ax,word[ar_ct]
    dec ax
    mov word[ar_j],ax
   ; mov dx,  word[ar_i]
   ;  inc  dx
    ;mov word[ar_k],dx	
   	 
    loop_arrayj:

        
           call chk                 
        
        cmp word[pal_flag],1
           je  j_prt_pal
           jmp end_prt_pal
j_prt_pal:
 call prt_pal
 end_prt_pal :
         ;mov ax,word[pal_flag]
         ;mov word[num],ax
         ;call print

        ; mov ax,word[ar_i]
        ; mov word[num],ax
        ; call print
        ; call enter_space
        ; mov ax,word[ar_j]
        ; mov word[num],ax
       ;  call print
      ;   call enter

          dec word[ar_j]
          
	mov ax,word[ar_i]	
         cmp word[ar_j],ax
            ja loop_arrayj


       
           inc word[ar_i]

           mov ax,word[ar_ct]
                dec ax
                
            cmp word[ar_i],ax
             jb loop_arrayi
         ; mov word[num],'n'
        ;   call print_strng



end_art:
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
chk:
 
pusha
    ;cmp word[ar_i],0
     ;  je end_pal

    ;cmp word[ar_i],1
     ;  je ypal


   mov ebx,array
   mov ax,word[ar_i]
   mov word[ar_x],ax

   mov  ax, word[ar_j]
    mov word[ar_y],ax
                                                    ; dec word[ar_j]

  loop_chk:
      mov ebx,array
      movzx ecx,word[ar_x]
      mov dx,word[ebx+2*ecx]

      mov ebx,array
      movzx ecx,word[ar_y]
      mov ax,word[ebx+2*ecx]

         
         cmp ax,dx
         je chklen
          add dx,32
         cmp ax,dx
          je chklen
          sub dx,32
          add ax,32
         cmp ax,dx
          sub ax,32
         je chklen
         cmp ax,dx
         je chklen

           inc word[ar_x]
        dec word[ar_y]
         cmp ax,dx
         jne not_pal
 chklen:
        
        ;lmov ax,word[ar_x]
        ;dec ax
       ; cmp ax,word[ar_y]
      ;   je ypal

      mov ax,word[ar_x]
       mov bx,word[ar_y]       
        inc word[ar_x]
        dec word[ar_y]
       cmp ax,bx
           jnb ypal
       jmp loop_chk

ypal:
  
      mov word[pal_flag],1

 
jmp end_pal
not_pal:
        ; messahge for no pal
	mov word[pal_flag],0
     
 end_pal:         
popa 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_ar:
 pusha
    mov esi,array
   loop_print_ar:
 
      LODSW
      mov word[num],ax
     call print_strng
      cmp word[num],10
      jne loop_print_ar
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
prt_pal:
pusha 

   mov ax,word[ar_i]
   mov word[ar_x],ax
   mov ax,word[ar_j]
   mov word[ar_y],ax
  
pal_loop:
   
   mov ebx,array
   movzx eax,word[ar_x]
   mov cx,word[ebx+2*eax]
   mov word[num],cx
   call print_strng
    inc word[ar_x]
    mov ax,word[ar_x]
     dec ax
    cmp ax,word[ar_y]
     je end_pal_loop
     jmp pal_loop
 


end_pal_loop:
call enter

popa
ret
