# lab2.s
# Jeremy Persing


.data
IncomePrompt:
   .ascii "How much money do you make each month? \n\0"

CreditPrompt:
   .ascii "How much is your credit card payment each month? \n\0"

HomePrompt:
   .ascii "How much is your home payment? \n\0"

CarPrompt:
   .ascii "How much is your car payment each month? \n\0"

OutgoPrompt:
   .ascii "Your outgo is \n\0"

TotalPrompt:
   .ascii "\nAfter your expenses, you make: \n\0"

.text
.global _start

_start:
   mov $IncomePrompt, %rdx
   call PrintCString
   call ScanInt
   mov %rdx, %r8

   mov $CreditPrompt, %rdx
   call PrintCString
   call ScanInt
   mov %rdx, %r9

   mov $HomePrompt, %rdx
   call PrintCString
   call ScanInt
   mov %rdx, %r10

   mov $CarPrompt, %rdx
   call PrintCString
   call ScanInt
   mov %rdx, %r11

   mov $OutgoPrompt, %rdx
   call PrintCString
   add %r10, %r9
   add %r11, %r9
   mov %r9, %rdx
   call PrintInt 

   mov $TotalPrompt, %rdx
   call PrintCString
   sub %r9, %r8
   mov %r8, %rdx
   call PrintInt

  call EndProgram
