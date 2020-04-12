.data
  VendingMachine: 
    .ascii "Japanese Vending Machine\n\0"
  
  Noodles:
    .ascii "1. Noodles (50 cents)\n\0"

  Pizza:
    .ascii "2. Pizza (100 cents)\n\0"
  
  Burger:
    .ascii "3. Burger (60 cents)\n\0"

  AmountPrompt: 
    .ascii "How many cents were entered?\n\0"

  SelectionPrompt:
    .ascii "Which item are you going to select?\n\0"
  
  ChangePromptOne:
    .ascii "Your change is \0"

  ChangePromptTwo: 
    .ascii " cents\n\0"

  Inventory:
    .quad Noodles
    .quad Pizza
    .quad Burger

  Costs:
    .quad 50
    .quad 100
    .quad 60

  ReturnOnePrompt: 
    .ascii "Your return is \0"

  ReturnTwoPrompt:
    .ascii " quarters and \0"

  ReturnThreePrompt:
    .ascii " pennies.\n\0"
.text
.global _start
_start:
  mov $VendingMachine, %rdx
  call PrintCString

  mov $Noodles, %rdx
  call PrintCString

  mov $Pizza, %rdx
  call PrintCString

  mov $Burger, %rdx
  call PrintCString

  mov $AmountPrompt, %rdx
  call PrintCString
  call ScanInt
  mov %rdx, %r8

  mov $SelectionPrompt, %rdx
  call PrintCString
  call ScanInt
  mov %rdx, %rsi
  sub $1, %rsi

  mov Inventory(,%rsi,8), %rdx
  call PrintCString  

  sub Costs(,%rsi,8), %r8

  mov $ChangePromptOne, %rdx
  call PrintCString
  mov %r8, %rdx
  call PrintInt
  mov $ChangePromptTwo, %rdx
  call PrintCString

  mov %r8, %rax
  mov $25, %rbx
  cqo
  idiv %rbx
  mov %rdx, %rcx

  mov $ReturnOnePrompt, %rdx
  call PrintCString
  mov %rax, %rdx
  call PrintInt
  mov $ReturnTwoPrompt, %rdx
  call PrintCString
  mov %rcx, %rdx
  call PrintInt
  mov $ReturnThreePrompt, %rdx
  call PrintCString

  call EndProgram
