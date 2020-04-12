##Jeremy Persing
##Silly Sentences

.data
   FirstPrompt:
    .ascii "Player A, enter a noun: \0"

   NounOne: 
    .space 50

   SecondPrompt:
    .ascii "Player B, enter a verb: \0"
  
   Verb: 
    .space 50

   ThirdPrompt:
    .ascii "Player A, enter a preposition: \0"

   Preposition:
    .space 50

   FourthPrompt:
    .ascii "Player B, enter a noun: \0"

   NounTwo:
    .space 50 

   Sentence: 
    .ascii "Your sentence is: "

   Space: 
    .ascii " "
.text
.global _start
_start:
 
  mov $FirstPrompt, %rdx
  call PrintCString
  mov $50, %rcx
  mov $NounOne, %rdx 
  call ScanCString
  call ClearScreen

  mov $SecondPrompt, %rdx
  call PrintCString
  mov $50, %rcx
  mov $Verb, %rdx
  call ScanCString
  call ClearScreen
  

  mov $ThirdPrompt, %rdx
  call PrintCString
  mov $50, %rcx
  mov $Preposition, %rdx
  call ScanCString
  call ClearScreen

  mov $FourthPrompt, %rdx
  call PrintCString
  mov $50, %rcx
  mov $NounTwo, %rdx
  call ScanCString
  call ClearScreen

  mov $Sentence, %rdx
  call PrintCString
  mov $NounOne, %rdx
  call PrintCString
  mov $Space, %rdx
  call PrintCString
  mov $Verb, %rdx
  call PrintCString
  mov $Space, %rdx
  call PrintCString
  mov $Preposition, %rdx
  call PrintCString
  mov $Space, %rdx
  call PrintCString
  mov $NounTwo, %rdx
  call PrintCString
 

  call EndProgram
