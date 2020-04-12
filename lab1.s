# lab1.s
# Jeremy Persing

# 1. Assemble : as -o lab1.o lab1.s
# 2. Link     : ld -o a.out lab1.o csc35.o
# 3. Execute  : a.out

.data
Greeting:
	.ascii "Hello, world!\n\0"

Name: 
	.ascii "My name is Jeremy Persing.\n\0"

Quote: 
	.ascii "\"I used to think I was indecisive, but now I'm not too sure\" - Anonymous \n\0"

GraduationOne:
	.ascii "I will graduate in \0 "

GraduationTwo:
	.ascii " from Sacramento State! \n\0 "


.text
.global _start

_start:
	mov $Greeting, %rdx
	call PrintCString
	mov $Name, %rdx
	call PrintCString
	mov $Quote, %rdx
	call PrintCString
	mov $GraduationOne, %rdx
	call PrintCString 
	mov $2021, %rdx
	call PrintInt
	mov $GraduationTwo, %rdx
	call PrintCString

	call EndProgram
