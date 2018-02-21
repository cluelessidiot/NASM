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

program:
mov byte[i],0
r:
mov al,byte[i]
cmp al,byte[l]
jnb exit
mov edx,string
mov eax,0
mov al,byte[i]
add edx,eax
mov al,byte[edx]
mov byte[temp],al
cmp byte[temp],'Z'
jna gotn1
inc byte[i]
jmp r

gotn1:
inc byte[i]
mov al,byte[i]
mov byte[n1],al
program2:
mov al,byte[l]
dec al
mov byte[i],al
r1:
cmp byte[i],0
jb exit
mov edx,string
mov eax,0
mov al,byte[i]
add edx,eax
mov al,byte[edx]
mov byte[temp],al
cmp byte[temp],'Z'
jna gotn2
dec byte[i]
jmp r1

gotn2:
mov al,byte[i]
mov byte[n2],al

program3:
mov byte[count],0
mov al,byte[n1]
mov byte[i],al
for1:
mov al,byte[i]
cmp al,byte[n2]
jnb print_count
mov edx,string
mov eax,0
mov al,byte[i]
add edx,eax
mov al,byte[edx]
mov byte[temp],al
cmp byte[temp], 'Z'
jna inci
mov al,byte[i]
add al,1
mov byte[j],al
for2:
mov al,byte[j]
cmp al,byte[n2]
ja inci_counter
mov edx,string
mov eax,0
mov al,byte[j]
add edx,eax
mov al,byte[edx]
cmp al,byte[temp]
je inci
inc byte[j]
jmp for2

inci:
inc byte[i]
jmp for1

inci_counter:
inc byte[i]
inc byte[count]
jmp for1



print_count:
add byte[count],0
je print1
extract:
cmp byte[count],0
je print
mov al,byte[count]
mov bl,10
mov ah,0
div bl
mov dx,0
movzx dx,ah
push dx
mov byte[count],al
inc  byte[nod]
jmp extract
print:
cmp byte[nod],0
je exit
pop dx
mov byte[temp],dl
add byte[temp],30h
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
dec byte[nod]
jmp print

print1:
add byte[count],30h
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h


exit:
mov eax,1
mov ebx,0
int 80h

section .bss
string:resb 100
l:resb 1
temp:resb 1
string1:resb 100
i:resb 1
len:resb 1
string2:resb 100
string3:resb 100
j:resb 1
n1:resb 1
n2:resb 1
count:resb 1
nod:resb 1
section .data
space:db ' '
