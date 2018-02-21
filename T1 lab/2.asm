section .bss

in_digit:resb 2
out_read:resb 2
print_digit:resb 2

prt_i:resb 2
num:resb 2

fact_num:resb 2
fact_sum:resb 2

mat_i:resb 2
mat_j:resb 2
mat_k:resb 2
mat_q:resb 2
matrix:resb 200
mat_r:resb 2
mat_c:resb 2



section .data

msg1:db 'Enter the number of rows and column ',0ah
lmsg1:equ $-msg1
newline:db  ' ',0ah
lnewline:equ $-newline
tabs:db '	'
ltabs:equ $-tabs


section .text
global _start:
_start:


	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,lmsg1
	int 80h


   call read 
	mov ax,word[out_read]
        mov word[mat_r],ax       


   call read 
	mov ax,word[out_read]
        mov word[mat_c],ax       



   call matrix_read
   call matrix_print
 
        mov eax,1
	mov ebx,0
	int 80h

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fact:
pusha
 cmp word[fact_num],1
  je exit_fact
  mov ax,word[fact_num]
  mov bx,word[fact_sum]
  mov dx,0
  mul bx
  mov word[fact_sum],ax
  dec word[fact_num]
  call fact        	

 exit_fact:
       
popa
ret        
	 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

         
matrix_read:

pusha


  mov word[mat_i],0
  mov word[mat_j],0
  mov word[mat_k],0
  mov ax,word[mat_c]
  shl ax, 1
  mov word[mat_k],ax

  i_loop:
     mov word[mat_j],0
     
  j_loop:

     movzx eax,word[mat_j]     
     mov ax, word[mat_k]
     mov bx,word[mat_i]
     mov dx,0
     mul bx
     mov word[mat_q],ax
     movzx edx,word[mat_q]
          




 call read
     mov ebx,matrix

     mov cx,word[out_read]
     mov word[ebx+2*eax+edx],cx
    
     inc word[mat_j]
     mov ax,word[mat_c]
     cmp word[mat_j],ax
     jne j_loop
      
      inc word[mat_i]
      mov ax,word[mat_r]
      cmp ax,word[mat_i]
      jne i_loop
     



popa 
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enter:
pusha


	mov eax,4
	mov ebx,1
	mov ecx,newline
	mov edx,lnewline
	int 80h

popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tab:
pusha	
	
	mov eax,4
	mov ebx,1
	mov ecx,tabs
	mov edx,ltabs
	int 80h

popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


         
matrix_print:

pusha


  mov word[mat_i],0
  mov word[mat_j],0
  mov word[mat_k],0
  mov ax,word[mat_c]
  shl ax, 1
  mov word[mat_k],ax
  mov word[num],ax
 ; call print 
  
  i_loop_print:
     mov word[mat_j],0
     
  j_loop_print:

     movzx ecx,word[mat_j] 
     
     ;mov word[mat_q],ax
     mov ax, word[mat_k]
     mov bx,word[mat_i]
     mov dx,0
     mul bx
     add word[mat_q],ax
     movzx eax,word[mat_q]





     mov ebx,matrix
     
    ; add ebx,eax
     mov ax,word[ebx+eax+2*ecx]
     mov word[num],ax
call print
call tab
     
    
     inc word[mat_j]
     mov ax,word[mat_c]
     cmp word[mat_j],ax
     jne j_loop_print
 call enter     
      inc word[mat_i]
      mov ax,word[mat_r]
      cmp ax,word[mat_i]
      jne i_loop_print
     



popa 
ret



 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;











    
