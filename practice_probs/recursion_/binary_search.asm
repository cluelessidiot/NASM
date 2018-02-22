;;;;;;;;;;binary search;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;return index for umber searched;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
ar_ct:resb 2
b_f:resb 2
b_l:resb 2
b_m:resb 2
print_digit:resb 2
b_val:resb 2
num:resb 2
prt_i:resb 2
section .data
ms1: db 'Enter the number of elements',0ah
l1:equ $-ms1
ms3: db 'Enter the number to  search',0ah
l3:equ $-ms3
ms2: db 'Enter the number',0ah
l2:equ $-ms2
ms4: db 'number not found',0ah
l4:equ $-ms4
section .text
global _start:
_start:


        mov eax,4
	mov ebx,1
	mov ecx,ms1
	mov edx,l1
        int 80h 


call read
      mov eax,4
	mov ebx,1
	mov ecx,ms2
	mov edx,l2
        int 80h 

mov ax,word[out_read]
mov word[ar_ct],ax
call arr

         mov eax,4
	mov ebx,1
	mov ecx,ms3
	mov edx,l3
        int 80h 

call read
mov ax,word[out_read]
mov word[b_val],ax
mov word[b_f],0
mov ax,word[ar_ct]
dec ax
mov word[b_l],ax
call binary_search


        mov ax,word[a_i]
        mov word[ar_ct],ax


	mov eax,1
	mov ebx,0
	int 80h
;;;;;;;;;;;;;;;;;;;;;;;binary_search;;;;;;;;;;;;;;;;;;;;;;;;;;;;
binary_search :
pusha 
     
   
   ;;;;;;;if(f<=L);;;;;;;;;;;;;;;;;;;;;;;
mov ax,word[b_f]
cmp ax,word[b_l]
ja no_val

         
  mov ax,word[b_l]
  add ax,word[b_f]
  shr ax,1
  ;mov word[num],ax
 ; call print
  mov word[b_m],ax
  
   mov ebx,array
   movzx eax,word[b_m]
   mov dx,word[ebx+2*eax]
   
   cmp dx,word[b_val]
    je search_found
 
  cmp dx,word[b_val]
   jb search_high 

  cmp dx,word[b_val]
   ja search_low

search_found:
   mov ax,word[b_m]
   inc ax
   mov word[num],ax
    call print
    jmp end_bs


search_low:
     mov ax,word[b_m]
     dec ax
     mov word[b_l],ax
     call binary_search
    jmp end_bs


    search_high:
   mov ax,word[b_m]
   inc ax
    mov word[b_f],ax
    call binary_search
    jmp end_bs

no_val:
     mov eax,4
	mov ebx,1
	mov ecx,ms4
	mov edx,l4
        int 80h 

end_bs:
popa
ret


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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;      
arr:
pusha
      mov ebx,array
      mov word[a_i],0
      mov word[ct],0
   loop_arr:
        call read   
     	
 

        
 	mov ebx,array
 	movzx ecx,word[a_i]
        mov dx,word[out_read]
        mov word[2*ecx+ebx],dx
          inc word[a_i]
           mov ax,word[ar_ct]
         cmp word[a_i],ax
        je ar_end
     jmp loop_arr
  ar_end:
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


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



