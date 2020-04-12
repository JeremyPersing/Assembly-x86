.data
  NamePrompt:
    .ascii "What is your name?\n"
 
  Username:
    .space 50
  
  ResponseOne:
    .ascii "Hello "

  ResponseTwo:
    .ascii "! Isn't it crazy this is the last lab." 
  
.text
.global _start
_start: 
  mov $1, %rax                #Prompt
  mov $1, %rdi
  mov $NamePrompt, %rsi
  mov $19, %rdx
  syscall
  
  mov $0, %rax                #Reads input from keyboard
  mov $0, %rdi
  mov $Username, %rsi
  mov $50, %rdx
  syscall 

  mov %rax, %r13              #Transferring number of successfully written bytes
  sub $1, %r13

  mov $1, %rax                #Start of response
  mov $1, %rdi
  mov $ResponseOne, %rsi
  mov $6, %rdx
  syscall
  
  mov $1, %rax                #Prints Username
  mov $1, %rdi
  mov $Username, %rsi
  mov %r13, %rdx
  syscall 

  mov $1, %rax                #End of Response
  mov $1, %rdi
  mov $ResponseTwo, %rsi
  mov $39, %rdx
  syscall

  mov $60, %rax
  syscall
