section .text
global _start:
_start:
mov edi,string
cld
read_string:
mov byte[l],0
read:
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h
cmp byte[temp],10
je end_read
mov al,byte[temp]
stosb
inc byte[l]
jmp read
end_read:
mov al,0
stosb

changetocaps:

mov byte[i],0
for:
mov edx,string
mov eax,0
mov al,byte[i]
add edx,eax
mov al,byte[edx]
mov byte[temp],al
cmp byte[temp],0
je program1
cmp byte[temp],'a'
jnb caps
o:
inc byte[i]
jmp for

caps:
sub byte[temp],32
mov edx,string
mov eax,0
mov al,byte[i]
add edx,eax
mov cl,byte[temp]
mov byte[edx],cl
jmp o
 




program1:
mov byte[i],0
for1:
 mov edx,string
 mov eax,0
 mov al,byte[i]
 add edx,eax
 mov al,byte[edx]
 mov byte[temp],al
 cmp byte[temp],0
 je printno
 mov al,byte[l]
 mov byte[j],al
 dec byte[j] 
for2:
 mov cl,byte[i]
 cmp byte[j],cl
 jna inc1
 mov edx,string
 mov eax,0
 mov al,byte[j]
 add edx,eax
 mov cl,byte[edx]
 mov byte[temp1],cl
 cmp cl,byte[temp]
 je store
r:
 dec byte[j]
 jmp for2

inc1:
 inc byte[i]
 jmp for1

store:
mov edx,string
 mov eax,0
 mov al,byte[i]
 add edx,eax
mov esi,edx

mov byte[length],0
mov edi,string1
mov ecx,0
mov cl,byte[j]
sub cl,byte[i]
add cl,1
copy:
    inc byte[length]
    movsb    
    loop copy

mov byte[edi],0
dec byte[length]
mov esi,string1
mov edi,string1
mov eax,0
mov al,byte[length]
add edi,eax
p:
 cmp byte[esi],0
 je printyes
 cmpsb
 jne r
 sub edi,2
 jmp p

printyes:
mov eax,4
mov ebx,1
mov ecx,yes
mov edx,l1
int 80h
jmp print1
 
printno:
mov eax,4
mov ebx,1
mov ecx,no
mov edx,l2
int 80h
jmp exit


print1:
mov eax,4
mov ebx,1
mov ecx,line
mov edx,1
int 80h
mov esi,string1

print:
cld
lodsb
mov byte[temp],al
cmp byte[temp],0
je end_print
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
jmp print
end_print:
exit:
mov eax,1
mov ebx,0
int 80h

section .bss
temp1:resb 1
string:resb 100
l:resb 1
temp:resb 1
string1:resb 100
i:resb 1
len:resb 1
string2:resb 100
string3:resb 100
j:resb 1
length:resb 1
section .data
line:db 0Ah
yes:db 'yes'
l1:equ $-yes
no:db 'no'
l2:equ $-no
