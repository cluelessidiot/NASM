section .bss
prt_ct:resb 2
dig:resb 2
d1:resb 2
out:resb 2
num:resb 2
str:resb 2
pstr:resb 2

array:resb 200
ar_ct:resb 2
ar_i:resb 2
ar_j:resb 2
ar_x:resb 2
ar_y:resb 2
ar_c:resb 2
ar_k:resb 2
ar_p:resb 2
wflg:resb 2
sflg:resb 2

m_l:resb 2
m_m:resb 2
m_f:resb 2

an1:resb 100
an2:resb 100
n1:resb 2
n2:resb 2


sa_i:resb 2
sa_j:resb 2
sa:resb 200
sub :resb 200
sub_i:resb 2
sub_j:resb 2
sub1:resb 200

f:resb 2
l:resb 2
m:resb 2




section .data
m1:db 'enter the string',0ah
l1:equ $-m1
ent:db '',0ah
lent:equ $-ent
spc:db ' '
lspc:equ $-spc


section .text
global _start:
_start:

   mov eax,4
   mov ebx,1
   mov ecx,m1
   mov edx,l1
    int 80h
mov ebx,array
call ar_read



mov ax,word[ar_i]
dec ax
dec ax
mov word[ar_ct],ax


mov cx,word[ar_ct]
mov word[l],cx
mov word[m],0
call mergesort
call enter
call enter
call enter
mov ebx,array
call ar_prt

   mov eax,1
   mov ebx,0
   int 80h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

mergesort:

pusha
      


     mov ax,word[f]

cmp ax,word[l]
jnb ext_mergesort

     mov bx,word[l]
                    
     add bx,ax
     shr bx,1           
                   
     mov word[m],bx
     
     mov ax,word[f]
     mov bx,word[m]
     mov cx,word[l]
     push ax
     push bx
     push cx
     
     mov word[l],bx
      
      call mergesort

     pop cx
     mov word[l],cx
    
     pop bx
     inc bx
    mov word[f],bx
    
     push bx
     push cx
     
      
     call mergesort
     pop cx
                                     mov word[num],cx
                                     call print
                                     call space
     mov word[m_l],cx
     pop bx
     dec bx                        
                                     mov word[num],bx
                                     call print
                                     call space
     mov word[m_m],bx
     pop ax
                                     mov word[num], ax
                                      call print
                                      call enter
     mov word[m_f],ax
 
      call merge
ext_mergesort:

popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
merge:
pusha
     mov ax,word[m_f]
     mov bx,word[m_m]
     sub bx,ax
     inc bx
     mov word[n1],bx
                         
     mov word[ar_i],0
fn:  
     mov ax,word[ar_i]
     cmp ax,word[n1]
      jnb efn
      
      movzx eax,word[m_f]
      mov ebx,array
      movzx edx,word[ar_i]
      add eax,edx
      mov cx,word[ebx+2*eax]
      
       
      mov ebx,an1
      mov word[ebx+2*edx],cx
      
      inc word[ar_i]
      jmp fn
 efn:
      
      movzx edx,word[ar_i]
      mov word[ebx+2*edx],101

;mov ebx,an1
;call ar_prt
;call enter




     
     mov ax,word[m_m]
     mov bx,word[m_l]
     sub bx,ax
     mov word[n2],bx   

       
      mov word[ar_j],0
fnj:  
     mov ax,word[ar_j]
     cmp ax,word[n2]
      jnb efnj
      
      movzx eax,word[m_m]
       inc eax
      mov ebx,array
      movzx edx,word[ar_j]
      add eax,edx
      mov cx,word[ebx+2*eax]
      
       
      mov ebx,an2
      mov word[ebx+2*edx],cx
      
      inc word[ar_j]
      jmp fnj
 efnj:
      
      movzx edx,word[ar_j]
      mov word[ebx+2*edx],105

;mov ebx,an2
;call ar_prt
;call enter

mov word[ar_i],0
mov word[ar_j],0
mov ax,word[m_f]
mov word[ar_k],ax
  merging:
    
     movzx eax,word[ar_i]
     mov ebx,an1
     mov cx,word[ebx+2*eax]

    

     movzx eax,word[ar_j]
     mov ebx,an2
     mov dx,word[ebx+2*eax]

     cmp cx,dx
     jb iplus
     jmp jplus

  iplus:
      movzx eax,word[ar_k]
      mov ebx,array
      mov word[ebx+2*eax],cx
 


         inc word[ar_i]
         mov ax,word[ar_i]
         mov bx,word[ar_j]
         add ax,bx
         mov cx,word[n1]
         mov dx,word[n2]
         add cx,dx
         cmp ax,cx 
         jnb ext_merge


         inc word[ar_k]
         jmp merging
    jplus:
       movzx eax,word[ar_k]
      mov ebx,array
      mov word[ebx+2*eax],dx
 
         inc word[ar_j]
           mov ax,word[ar_i]
         mov bx,word[ar_j]
         add ax,bx
         mov cx,word[n1]
         mov dx,word[n2]
         add cx,dx
         cmp ax,cx 
         jnb ext_merge

         inc word[ar_k]

         jmp merging       
ext_merge:
popa
ret
ar_read:

	mov word[ar_c],0
	mov word[ar_i],0
	mov word[ar_j],0
ar_tra:
         
        movzx eax,word[ar_i]
        call str_read
        
        
        mov cx,word[str]
      	mov word[ebx+2*eax],cx
        
	inc word[ar_i]
        cmp word[str],10
        je ext_ar
        jmp ar_tra

ext_ar:

ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
str_read:
pusha
   	mov eax,3
	mov ebx,1
	mov ecx,str
	mov edx,1
	int 80h
popa
ret 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
str_prt:
pusha
 	mov eax,4
	mov ebx,1
	mov ecx,pstr
	mov edx,1
	int 80h
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
ar_prt:

	mov word[ar_i],0
	mov word[ar_j],0
ar_prt_trv:
    
        movzx eax,word[ar_i]
      
        mov cx,word[ebx+2*eax]
        cmp cx,10
        je ext_ar_prt
         
        mov word[pstr],cx
        call str_prt
    
        inc word[ar_i]
        jmp ar_prt_trv

ext_ar_prt:
call enter

ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 enter:
pusha
    mov eax,4
    mov ebx,1
    mov ecx,ent
    mov edx,lent
    int 80h
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print:
mov word[prt_ct],0
pusha

cmp word[num],0
jne rem_numb

   mov word[pstr],48
   call str_prt
  jmp ext_print

rem_numb:
    
    mov ax,word[num]
    mov dx,0 
    mov bx,10
    div bx
    push dx
    
    inc word[prt_ct]
    mov word[num],ax  
    cmp ax,0
    je prt_num
    jmp rem_numb

prt_num:
     
     pop dx
     add dx,030h
     mov word[pstr],dx
     call str_prt
     
     dec word[prt_ct]
     cmp word[prt_ct],0
     jne prt_num
ext_print:
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
space:
pusha
  mov eax,4
  mov ebx,1
  mov ecx,spc
  mov edx,lspc
  int 80h
popa
ret
