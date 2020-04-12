.data
   Donuts:
   .ascii "Donuts: 10 grams of sugar\n\0"

   Cupcakes:
   .ascii "Cupcakes: 5 grams of sugar\n\0"

   Cookies:
   .ascii "Cookies : 2 grams of sugar\n\0"

   DonutsAte:
   .ascii "How many donuts did you eat?\n\0"

   CupcakesAte:
   .ascii "How many cupcakes were consumed?\n\0"

   CookiesAte:
   .ascii "How many cookies did you eat?\n\0"

   TotalSugarOne:
   .ascii "That is "

   TotalSugarTwo:
   .ascii " total grams of sugar.\n\0"

   SugarPrompt:
   .ascii "How many grams of sugar can Weenie have?\n\0"

   TotalItemsOne:
   .ascii "The Weenie can only eat this \n\0"
 
   TotalItemsTwo:
   .ascii " times.\n\0"
.text

.global _start
_start: 

   mov $Donuts, %rdx
   call PrintCString

   mov $Cupcakes, %rdx
   call PrintCString

   mov $Cookies, %rdx
   call PrintCString

   mov $DonutsAte, %rdx
   call PrintCString
   call ScanInt
   mov %rdx, %r11
   mov $10, %rax
   imul %rax, %r11

   mov $CupcakesAte, %rdx;
   call PrintCString
   call ScanInt
   mov %rdx, %r13
   mov $5, %rbx
   imul %rbx, %r13

   mov $CookiesAte, %rdx
   call PrintCString
   call ScanInt
   mov %rdx, %r15
   mov $2, %rcx
   imul %rcx, %r15 
   
   add %r15, %r9
   add %r13, %r9

   mov $TotalSugarOne, %rdx
   call PrintCString
   mov %r9, %rdx
   call PrintInt
   mov $TotalSugarTwo, %rdx
   call PrintCString

   mov $SugarPrompt, %rdx
   call PrintCString
   call ScanInt
   mov %rdx, %rcx

   mov %r9, %rbx
   mov %rcx, %rax
   cqo
   idiv %rbx

   mov $TotalItemsOne, %rdx
   call PrintCString
   mov %rax, %rdx
   call PrintInt
   mov $TotalItemsTwo, %rdx
   call PrintCString
  

   call EndProgram
