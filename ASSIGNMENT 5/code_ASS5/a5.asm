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
mov al,' '
stosb
mov al,0
stosb

mov edi,string1
cld
read_string1:
mov byte[l1],0
read1:
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h
cmp byte[temp],10
je end_read1
mov al,byte[temp]
stosb
inc byte[l1]
jmp read1
end_read1:
mov al,0
stosb

mov edi,string2
cld
read_string2:
mov byte[l2],0
read2:
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h
cmp byte[temp],10
je end_read2
mov al,byte[temp]
stosb
inc byte[l2]
jmp read2
end_read2:
mov al,0
stosb



program:
mov byte[len],0
mov byte[j],0
r:
mov esi,string
mov eax,0
mov al,byte[j]
add esi,eax
mov al,byte[esi]
mov byte[temp],al
cmp byte[temp],0
je exit
cmp byte[temp],' '
je check
mov edx,string3
mov eax,0
mov al,byte[len]
add edx,eax
mov cl,byte[temp]
mov byte[edx],cl
p:
inc byte[len]
inc byte[j]
jmp r

check:
mov edx,string3
mov eax,0
mov al,byte[len]
add edx,eax
mov byte[edx],0

mov esi,string1
mov edi,string3
mov ecx,0
mov cl,byte[len]
top:
cmpsb
jne print1
loop top
jmp print2


print1:
mov esi,string3

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
mov eax,4
mov ebx,1
mov ecx,space
mov edx,1
int 80h
mov byte[len],0
inc byte[j]
jmp r

print2:
mov esi,string2

printr:
cld
lodsb
mov byte[temp],al
cmp byte[temp],0
je end_print1
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
jmp printr
end_print1:
mov eax,4
mov ebx,1
mov ecx,space
mov edx,1
int 80h
mov byte[len],0
inc byte[j]
jmp r



exit:
mov eax,1
mov ebx,0
int 80h

section .bss
string:resb 100
l:resb 1
l1:resb 1
l2:resb 1
temp:resb 1
string1:resb 100
i:resb 1
len:resb 1
string2:resb 100
string3:resb 100
j:resb 1
section .data
space:db ' '
