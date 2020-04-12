.data
  Title:
    .ascii ":::=====  :::====  :::      :::====       :::====  :::  === :::===  :::  ===\n"
    .ascii ":::       :::  === :::      :::  ===      :::  === :::  === :::     :::  ===\n"
    .ascii "=== ===== ===  === ===      ===  ===      =======  ===  ===  =====  ========\n"
    .ascii "===   === ===  === ===      ===  ===      === ===  ===  ===     === ===  ===\n"
    .ascii " =======   ======  ======== =======       ===  ===  ======  ======  ===  ===\n\0"
  
  Rules:
    .ascii "\nRules: \n1. 20 weeks (5 months)\n2. Your endurance drops 10-25% each week. If it reaches 0%, the game ends.\n"
    .ascii "3. Panning for gold yields 0-100 dollars.\n4. A sluice yields 0-1000 dollars (durability drops 20-50% each week).\n"
    .ascii "5. Food costs 30-50 dollars.\n6. You have a percentage of luck and can only increase it by going to the Saloon. Pan findings double when luck is 90% and over.\n\0"

  Week:
    .ascii "\nWEEK \0"

  MoneyCount:
    .ascii "\nYou have $\0"

  Endurance:
    .ascii "\nYour endurance is at \0"
  
  Sluice:
    .ascii "\nYour sluice is at \0"
  
  Luck:
    .ascii "\nYour luck is at \0"

  Options:
    .ascii "\nIt's Sunday! Do you want to 1. Do nothing, 2. Repair Sluice (-$100), 3. Go to town. 4. Go to the Saloon 5. Go to the theater \n\0"
  
  SluiceRepaired:
    .ascii "\nYou repaired the sluice to 100%\n\0"

  TownReportOne:
    .ascii "\nGoing to town cost you $\0"
  
  TownReportTwo:
    .ascii "\nYou regained \0"

  TownReportThree:
    .ascii "% endurance.\n\0"

  SaloonReportOne:
    .ascii "Going to the Saloon cost you $\0"
  
  SaloonReportTwo:
    .ascii ". However the gambling gained you a luck boost of \0"
  
  TheaterReportOne:
    .ascii "Watching the play at the theater cost you $\0"

  TheaterReportTwo:
    .ascii ". You did gain an endurance boost of \0"

  GoldGain:
    .ascii "\nPanning for gold yielded $\0"

  SluiceGain:
    .ascii "\nThe sluice yielded $\0"
 
  FoodExpensesOne:
    .ascii "\nYou ate $\0"

  FoodExpensesTwo:
    .ascii " in food\n\0"

  PlayerDied:
    .ascii "You have run out of energy\n\0"

  EndingMoneyStats:
    .ascii "\nYou ended the game with $\0"

  EndingEnduranceStats:
    .ascii "\nYour ending endurance was \0"
  
  NewLine:
    .ascii "\n\0"

  Percentage:
    .ascii "%\0"
  
  BrokenSluice:
    .ascii "\nYour sluice is broken\0"

  BadLuck:
    .ascii "\nYou have bad luck, -10% luck, and were struck by bandits. You were robbed of $\0"
 
  GoodLuck:
    .ascii "\nYou have good luck, +5% luck, and found an additional piece of gold worth $\0"

  SluiceDestroyed:
    .ascii "\nA giant storm rolled through the area and destroyed your sluice (-5% luck)!\n\0"
 
  LuckyEnduranceGain:
    .ascii "\nYou managed to score bottle of whiskey through a bet. Like any good miner, you downed it the second you laid your eyes upon it and gained an endurance boost of \0"

  LuckyBoost:
    .ascii "\nYou got a lucky break and earned a luck boost of \0"

  TragicLuck:
    .ascii "\nYour luck is at or below 0%. You could not pan any gold this week\0"

  EndingLuck:
    .ascii "\nYour ending luck was \0" 

  GameOverSign:
    .ascii "\n:::=====  :::====  :::=======  :::=====   :::====  :::  === :::===== :::====\n"
    .ascii ":::       :::  === ::: === === :::        :::  === :::  === :::      :::  ===\n" 
    .ascii "=== ===== ======== === === === ======     ===  === ===  === ======   =======\n"
    .ascii "===   === ===  === ===     === ===        ===  ===  ======  ===      === ===\n"     
    .ascii " =======  ===  === ===     === ========    ======     ==    ======== ===  ===\n\0"

.text
.global _start
_start:
  mov $3, %rdx
  call SetForeColor
  mov $Title, %rdx                       #Printing Rules
  call PrintCString
  mov $6, %rdx
  call SetForeColor
  mov $Rules, %rdx
  call PrintCString

  mov $1, %rdi                           #Week Index
  mov $100, %r10                         #Money count initialization in r10
  mov $100, %r11                         #Endurance initialization in r11
  mov $100, %r12                         #Sluice initialization in r12
  mov $40, %rdx
  call Random
  mov %rdx, %rsi                           #Luck initialization   

  Loop:
    mov $7, %rdx
    call SetForeColor 
    mov $Week, %rdx                      #Start of loop
    call PrintCString
    mov %rdi, %rdx
    call PrintInt
    mov $NewLine, %rdx
    call PrintCString
    cmp $100, %r11
    jg MaxEndurance
    jmp Info
    MaxEndurance: 
      mov $100, %r11    

    Info:
      mov $MoneyCount, %rdx                #Basic player info  
      call PrintCString
      mov %r10, %rdx
      call PrintInt
      mov $Endurance, %rdx
      call PrintCString
      mov %r11, %rdx
      call PrintInt
      mov $Percentage, %rdx
      call PrintCString
      mov $Sluice, %rdx
      call PrintCString
      mov %r12, %rdx
      call PrintInt
      mov $Percentage, %rdx
      call PrintCString
      mov $Luck, %rdx
      call PrintCString
      mov %rsi, %rdx
      call PrintInt
      mov $Percentage, %rdx
      call PrintCString
    
    mov $Options, %rdx                   #User Input Prompt
    call PrintCString
    call ScanInt
    cmp $1, %rdx
    je GoldAcquired
    cmp $2, %rdx
    je SluiceRepair
    cmp $3, %rdx
    je Town
    cmp $4, %rdx
    je Saloon
    cmp $5, %rdx
    je Theater
    
    SluiceRepair:
      mov $2, %rdx
      call SetForeColor                  #Sluice Option
      mov $SluiceRepaired, %rdx
      call PrintCString
      mov $100, %r12
      sub $100, %r10                     #Subtracting $100 for sluice expense
      jmp GoldAcquired
    
    Town:
      mov $1, %rdx
      call SetForeColor
      mov $TownReportOne, %rdx
      call PrintCString
      mov $151, %rdx                     #Random town expenses   
      call Random
      add $50, %rdx
      call PrintInt
      sub %rdx, %r10                     #Subtracting Random town expenses from Total Money
      mov $5, %rdx
      call SetForeColor
      mov $TownReportTwo, %rdx
      call PrintCString
      mov $46, %rdx                      #Endurance Gain
      call Random
      add $5, %rdx
      add %rdx, %r11                     #Adding the town endurance increase to total endurance
      call PrintInt
      mov $TownReportThree, %rdx
      call PrintCString
      jmp GoldAcquired
  
    Saloon:
      mov $1, %rdx
      call SetForeColor
      mov $SaloonReportOne, %rdx
      call PrintCString
      mov $250, %rdx
      call Random
      add $75, %rdx
      call PrintInt
      sub %rdx, %r10
      mov $4, %rdx
      call SetForeColor
      mov $SaloonReportTwo, %rdx
      call PrintCString
      mov $8, %rdx
      call Random
      add $3, %rdx
      call PrintInt    
      add %rdx, %rsi
      mov $Percentage, %rdx
      call PrintCString
      jmp GoldAcquired

    Theater:
      mov $1, %rdx
      call SetForeColor
      mov $TheaterReportOne, %rdx
      call PrintCString
      mov $200, %rdx
      call Random
      add $100, %rdx
      call PrintInt
      sub %rdx, %r10
      mov $5, %rdx
      call SetForeColor
      mov $TheaterReportTwo, %rdx
      call PrintCString
      mov $20, %rdx
      call Random
      add $10, %rdx
      call PrintInt
      add %rdx, %r11
      mov $Percentage, %rdx
      call PrintCString

    GoldAcquired:
      cmp $90, %rsi
      jge DoubleFindings
      cmp $0, %rsi
      jle NoFindings
      mov $3, %rdx
      call SetForeColor
      mov $101, %rdx                       #Panning Amount r13   
      call Random 
      mov %rdx, %r13
      add %r13, %r10
      mov $GoldGain, %rdx
      call PrintCString
      mov %r13, %rdx
      call PrintInt
      jmp SluiceLogic

    DoubleFindings:
      mov $3, %rdx
      call SetForeColor
      mov $101, %rdx                       #Doubled Panning Amount   
      call Random 
      mov %rdx, %rax
      mov $2, %rbx
      imul %rbx
      mov %rax, %r13 
      add %r13, %r10
      mov $GoldGain, %rdx
      call PrintCString
      mov %r13, %rdx
      call PrintInt
      jmp SluiceLogic
    
    NoFindings:
      mov $4, %rdx
      call SetForeColor
      mov $TragicLuck, %rdx
      call PrintCString

    SluiceLogic:
      cmp $0, %r12
      jg SluiceProfit
      mov $0, %r12
      mov $1, %rdx
      call SetForeColor
      mov $BrokenSluice, %rdx
      call PrintCString                      #If sluice is 0 or below
      jmp FoodCosts 
   
    SluiceProfit:
      mov $1001, %rdx                      #Getting Sluice Amount r14
      call Random
      mov %rdx, %r14
      add %r14, %r10
      mov $3, %rdx
      call SetForeColor  
      mov $SluiceGain, %rdx
      call PrintCString
      mov %r14, %rdx
      call PrintInt
      jmp FoodCosts 

    FoodCosts:
      mov $21, %rdx                        #Getting Food Expenses r15   
      call Random
      add $30, %rdx 
      mov %rdx, %r15
      sub %r15, %r10
      mov $1, %rdx
      call SetForeColor
      mov $FoodExpensesOne, %rdx
      call PrintCString
      mov %r15, %rdx
      call PrintInt
      mov $FoodExpensesTwo, %rdx
      call PrintCString

    
    mov $101, %rdx                      #Random Events
    call Random
    cmp $12, %rdx
    jle GoodFortune
    cmp $84, %rdx
    jge BadFortune
    jmp RandomEventTwo
    
    GoodFortune:                         #Good Luck Random Event
      add $5, %rsi
      mov $3, %rdx
      call SetForeColor
      mov $GoodLuck, %rdx
      call PrintCString
      mov $1001, %rdx
      call Random
      call PrintInt
      add %rdx, %r10
      mov $NewLine, %rdx
      call PrintCString
      jmp RandomEventTwo

    BadFortune:                          #Bad Luck Random Event
      sub $10, %rsi
      mov $1, %rdx
      call SetForeColor
      mov $BadLuck, %rdx
      call PrintCString
      mov $100, %rdx
      call Random
      add $50, %rdx
      call PrintInt
      sub %rdx, %r10
      mov $NewLine, %rdx
      call PrintCString

    RandomEventTwo:
      mov $101, %rdx
      call Random
      cmp $15, %rdx
      jle Storm
      cmp $92, %rdx
      jge WhiskeyScore
      jmp EnduranceDecrease   
 
      Storm:
        mov $1, %rdx                               #Bad Storm Destroys Sluice
        call SetForeColor
        mov $0, %r12
        sub $5, %rsi
        mov $SluiceDestroyed, %rdx
        call PrintCString
        jmp RandomLuckEvent

      WhiskeyScore:                            #Whiskey Endurance Gain
        mov $5, %rdx
        call SetForeColor
        mov $LuckyEnduranceGain, %rdx
        call PrintCString
        mov $15, %rdx
        call Random
        add $5, %rdx
        call PrintInt
        add %rdx, %r11
        mov $Percentage, %rdx
        call PrintCString

    RandomLuckEvent:
      mov $1001, %rdx
      call Random
      cmp $95, %rdx
      jge LuckBoost
      jmp EnduranceDecrease
    
    LuckBoost:
      mov $4, %rdx
      call SetForeColor
      mov $LuckyBoost, %rdx
      call PrintCString
      mov $15, %rdx
      call Random
      call PrintInt
      add %rdx, %rsi
      mov $Percentage, %rdx
      call PrintCString
      
    EnduranceDecrease:
      mov $15, %rdx                       #Endurance Decrease
      call Random
      add $10, %rdx
      sub %rdx, %r11
      cmp $0, %r11
      jle EndingStats
    
    
    mov $30, %rdx                       #Sluice Decrease
    call Random
    add $20, %rdx
    mov %rdx, %rbx
    sub %rbx, %r12
    cmp $0, %r12
    jle ZeroSluice
    jmp Increment

    ZeroSluice:
      mov $0, %r12
   
    Increment: 
      add $1, %rdi
      cmp $20, %rdi
      jle Loop
    
    EndingStats:
      cmp $0, %r11
      jle ZeroEndurance

      mov $3, %rdx
      call SetForeColor
      mov $GameOverSign, %rdx
      call PrintCString
      mov $EndingMoneyStats, %rdx
      call PrintCString
      mov %r10, %rdx
      call PrintInt     
      mov $EndingEnduranceStats, %rdx
      call PrintCString
      mov %r11, %rdx 
      call PrintInt
      mov $Percentage, %rdx
      call PrintCString
      mov $EndingLuck, %rdx
      call PrintCString
      mov %rsi, %rdx
      call PrintInt
      mov $Percentage, %rdx
      call PrintCString
      jmp End

      ZeroEndurance:
        mov $1, %rdx
        call SetForeColor
        mov $0, %r11
        mov $GameOverSign, %rdx
        call PrintCString
        mov $EndingMoneyStats, %rdx
        call PrintCString
        mov %r10, %rdx
        call PrintInt     
        mov $EndingEnduranceStats, %rdx
        call PrintCString
        mov %r11, %rdx 
        call PrintInt
        mov $Percentage, %rdx
        call PrintCString  
        mov $EndingLuck, %rdx
        call PrintCString
        mov %rsi, %rdx
        call PrintInt
        mov $Percentage, %rdx
        call PrintCString
  End:  
    call EndProgram
