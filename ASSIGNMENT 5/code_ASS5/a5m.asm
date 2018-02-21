section .bss
dig:resw 1
str1:resw 100
str2:resw 400
str3:resw 400
vow:resw 1
digit: resw 1
sum: resw 1
ten: resw 1
temp: resw 1
n: resw 1
arr:resw 50
s:resw 1
e:resw 1
flag:resw 1
dtemp:resd 1
dtemp2:resd 1
i:resw 1
j:resw 1
count:resw 1
max:resw 1
min:resw 1
n1:resw 1
n2:resw 1
n3:resw 1
prev:resw 1


section .data
space:dw " "
slen: equ $-space
enter:dw "",0Ah
elen: equ $-enter
yes:dw "YES",0Ah
ylen: equ $-yes
no:dw "NO",0Ah
nlen: equ $-no




section .text
global _start:
_start:

mov edi,str1
call sread
mov ax,word[n]
mov word[n1],ax

mov edi,str2
call sread
mov ax,word[n]
mov word[n2],ax

mov edi,str3
call sread
mov ax,word[n]
mov word[n3],ax

mov word[prev],' '
mov ax,word[n1]
movzx ecx,ax
push ecx
CLD

mov esi,str1
mov word[count],0
pop ecx
for:
push ecx

LODSW

cmp ax,' '
je skip

cmp word[prev],' '
jne skip

mov ebx,esi
sub ebx,2

call checkequ

cmp word[flag],1
jne skip

mov esi,str3
call sprint

mov esi,dword[dtemp]
add esi,2
mov ax,word[esi]
mov word[prev],ax
jmp endloop



skip:

mov word[prev],ax
mov word[dig],ax
call print1


endloop:
pop ecx
loop for




exit:
mov eax,1
mov ebx,0
int 80h


checkequ:
pusha 

mov edx,str2
mov ax,word[n2]
movzx ecx,ax

forequ:
push ecx
mov ax,word[edx]
mov cx, word[ebx]

cmp cx,0
je endequ

cmp ax,cx
jne endequ


add ebx,2
add edx,2
pop ecx
loop forequ



mov ax,word[ebx]

cmp word[ebx],0
je equequ
jne ccc22

ccc22:

cmp word[ebx],' '
je equequ

push ecx
jmp endequ

equequ:
mov word[flag],1
sub ebx,2
mov dword[dtemp],ebx
jmp endedequ
endequ:
pop ecx
mov word[flag],0
endedequ:
popa
ret



read1:
pusha 
mov eax,3
mov ebx,0
mov ecx,dig
mov edx,1
int 80h 
popa
ret


print1:
pusha 
mov eax,4
mov ebx,1
mov ecx,dig
mov edx,1
int 80h 
popa
ret

sread:
pusha
CLD
mov word[n],0
sreadarray:

call read1
cmp word[dig],0Ah
je endsarrayread

mov ax,word[dig]
STOSW
inc word[n]
jmp sreadarray
endsarrayread:
mov ax,0
mov word[edi],ax
popa
ret



sprint:
pusha
CLD
sprintarray:
LODSW
mov word[dig],ax

cmp word[dig],0
je endsarrayprint

call print1

jmp sprintarray
endsarrayprint:
popa
ret


arrayread:
pusha
movzx ecx,word[n]
mov ebx,arr
 
enterarray:
push ecx 
push ebx
call read
mov ax,word[sum]

pop ebx
mov word[ebx],ax
add ebx,2
pop ecx
loop enterarray
popa
ret

arrayprint:
pusha
movzx ecx,word[n]
mov ebx,arr

printarray:
push ecx

mov ax,word[ebx]
mov word[sum],ax
push ebx

call print
mov eax,4
mov ebx,1
mov ecx,space
mov edx,slen
int 80h
pop ebx
add ebx,2
pop ecx
loop printarray
popa
ret

read:
pusha
mov word[sum],0
scanfirst:

mov eax,3
mov ebx,0
mov ecx,digit
mov edx,1
int 80h

cmp word[digit],0Ah
je readend
cmp word[digit],20h
je readend

sub word[digit],30h

mov ax,word[sum]
mov bx,10
mul bx
add ax,word[digit]
mov word[sum],ax

jmp scanfirst

readend:
popa
ret

print:
pusha
mov word[ten],1
mov dx,0
mov ax,word[sum]
mov cx,10
div cx
mov word[temp],ax

tens:
cmp word[temp],0
je printfirst

mov dx,0
mov ax,word[temp]
mov cx,10
div cx
mov word[temp],ax

mov ax,word[ten]
mov bx,10
mul bx
mov word[ten],ax

jmp tens

printfirst:

mov dx,0
mov ax,word[sum]
mov cx,word[ten]
div cx

mov word[digit],ax
mov word[sum],dx
add word[digit],30h

mov eax,4
mov ebx,1
mov ecx,digit
mov edx,1
int 80h

cmp word[ten],1
je printend

mov dx,0
mov ax,word[ten]
mov cx,10
div cx
mov word[ten],ax

jmp printfirst
printend:
popa 
ret


enterprint:
pusha 

mov eax,4
mov ebx,1
mov ecx,enter
mov edx,elen
int 80h

popa
ret

spaceprint:
pusha 

mov eax,4
mov ebx,1
mov ecx,space
mov edx,slen
int 80h

popa
ret

yesprint:
pusha

mov eax,4
mov ebx,1
mov ecx,yes
mov edx,ylen
int 80h

popa
ret

noprint:
pusha 

mov eax,4
mov ebx,1
mov ecx,no
mov edx,nlen
int 80h

popa
ret


