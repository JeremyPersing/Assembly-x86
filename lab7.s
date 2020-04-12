.data
  Title:
    .ascii "Welcome to the Word Bender program\n\0"

  Prompt:
    .ascii "Enter a word to bend: \n\0"

  WordBuffer:
    .space 50
  
  NewLine:
    .ascii "\n\0"

  Space:
    .ascii " \0"
.text
.global _start

_start:
  mov $Title, %rdx
  call PrintCString
  mov $Prompt, %rdx
  call PrintCString
  mov $50, %rcx
  mov $WordBuffer, %rdx
  call ScanCString
  call LengthCString
  mov %rdx, %r10
  mov %r10, %rax
  mov $2, %rbx
  cqo
  IDIV %rbx   

  mov $0, %r9
  Vertical:
    mov WordBuffer(, %r9, 1), %dl
    call PrintChar
    mov $NewLine, %rdx
    call PrintCString
    add $1, %r9
    cmp %r9, %rax
    je Horizontal
    jmp Vertical

   Horizontal:
     mov WordBuffer(, %r9, 1), %dl
     call PrintChar
     mov $Space, %rdx
     call PrintCString
     add $1, %r9
     cmp %r9, %r10
     je End
     jmp Horizontal
     

  End: 
    call EndProgram

