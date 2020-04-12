.data
  Prompt:
    .ascii "You are on the road and become hungry, so you will answer these questions to find out where to eat.\n\0"
 
  BudgetPrompt: 
    .ascii "Is it going to be an cheap (1) or expensive (2) meal?\n\0"

  DineInPrompt:
    .ascii "Do you wish to have the meal quickly (1) or be waited upon (2)?\n\0"

  AmericanFoodPrompt:
    .ascii "Do you want to eat Mexican food (1) or American food (2)?\n\0"

  Chipotle:
    .ascii "You should have Chipotle\n\0"

  RedLobster:
    .ascii "Enjoy your time at Red Lobster\n\0"

  TacoBell: 
    .ascii "Eat some tacos at Taco Bell\n\0"

  McDonalds:
    .ascii "Go to the American classic, McDonald's\n\0" 

 InvalidPrompt:
   .ascii "Invalid input: Keep driving"

.text

.global _start
_start:
  mov $Prompt, %rdx
  call PrintCString
  mov $BudgetPrompt, %rdx
  call PrintCString
  call ScanInt
#First conditional

  cmp $1, %rdx
  je CheapMeals
  jl Invalid
  cmp $2, %rdx
  jg Invalid

#True Case
  mov $DineInPrompt, %rdx
  call PrintCString
  call ScanInt  

  cmp $1, %rdx
  je ChipotlePrompt
  jl Invalid
  cmp $2, %rdx
  jg Invalid

  mov $RedLobster, %rdx
  call PrintCString
  jmp End

#Else for not on a budget
  ChipotlePrompt:
    mov $Chipotle, %rdx
    call PrintCString
    jmp End

#CheapMeals Else
  CheapMeals:
    mov $AmericanFoodPrompt, %rdx
    call PrintCString
    call ScanInt
    
    cmp $1, %rdx
    je Tacos
    jl Invalid
    cmp $2, %rdx
    jg Invalid    
    
    mov $McDonalds, %rdx
    call PrintCString
    jmp End

#Tacos Else
  Tacos:
    mov $TacoBell, %rdx
    call PrintCString
    jmp End

#InvalidInput
  Invalid:
   mov $InvalidPrompt, %rdx
   call PrintCString
   jmp End

  End: 
    call EndProgram

