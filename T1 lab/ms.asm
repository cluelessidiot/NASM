section .data
msg1:db 'Enter the number of elements in the array',0ah
l1:equ $-msg1
msg2:db 'enter the array elements',0ah
l2:equ $-msg2
newline:db '',0ah
lnewline:equ $-newline
section .bss
num:resb 2
out_read:resb 2
in_digit:resb 2
i:resb 2
j:resb 2
array:resb 200
array_count:resb 2
array_i:resb 2
array_j:resb 2
array_inc:resb 2

section .text

global _start:
_start:


        mov eax,4
        mov ebx,1
        mov ecx,msg1
        mov edx,l1
        int 80h

  call read

        mov ax,word[out_read]
        mov word[array_count],ax
        mov word[num],ax
  call print_num
  call enter
  call array_read
  call array_print
   
        mov eax,1
        mov ebx,0
        int 80h









;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
read:
pusha
     mov word[out_read],0
    loop_read:
        mov eax,3
        mov ebx,0
        mov ecx,in_digit
        mov edx,1
        int 80h

        cmp word[in_digit],0ah
        je end_read

        mov bx,10
        mov ax,word[out_read]
        mov dx,0
        mul bx
        mov word[out_read],ax

        mov ax,word[in_digit]
        sub ax,030h
        add word[out_read],ax
  
        jmp loop_read

   end_read:
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_num:
pusha

  mov word[i],0

 loop_print:
        mov ax,word[num]
        mov bx,10
        mov dx,0
        div bx
        push dx
        inc word[i]
        mov word[num],ax
        cmp ax,0
        jne loop_print

  print_digit:
        pop dx
        add dx,030h
        mov word[j],dx


        mov eax,4
        mov ebx,1
        mov ecx,j
        mov edx,1
        int 80h

        dec word[i]
        cmp word[i],0
        jne print_digit

popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
array_read:
pusha



        mov ax,word[array_count]
        mov word[array_j],ax
        mov word[array_i],0

  loop_array:
     
 
        movzx eax,word[array_i]
	mov ebx,array
        call read        
        mov cx,word[out_read]
 
        
        mov word[ebx+2*eax],cx
        
         inc word[array_i]
         mov ax,word[array_j]
   
         cmp ax,word[array_i]
         jne loop_array


popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
array_print:
pusha

        mov ax,word[array_count]
        mov word[array_j],ax
        mov word[array_i],0
        
        
  loop_print_array:
       
                  
         movzx eax,word[array_i]
         mov ebx,array 
     
      
        
        mov cx,word[ebx+2*eax]

        mov word[num],cx
        call print_num
        call enter
         
        inc word[array_i]
        mov ax,word[array_j]
       
        cmp word[array_i],ax
        jne loop_print_array
         
        
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enter:
pusha
        mov eax,4
        mov ebx,1
        mov ecx,newline
        mov edx,lnewline
        int 80h
popa
ret


