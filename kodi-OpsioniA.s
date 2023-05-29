.text #tregon qe kodi i shkruajtur me poshte (deri te .data) ruhet ne regjionin memorik text
.globl main #funksioni kryesor eshte main 

#main eshte etikete e cila ruan adresen e memories ku ka me fillu egzekutimi i programit
#E njejta ndodhe edhe me while etiketen dhe secilen etikete ne kodin e meposhtem
main:

addi $a1, $zero, 0  #i=0

#Me shfaq mesazhin e pare (kjo vlene per printimin e te gjithe vlerave string qe i kemi ne regjistrin data):
li $v0, 4 #komande e parapercaktuar per te treguar qe kemi me shtyp string
la $a0, message #vendose ne $a0 vleren qe gjindet ne adresen e label message ne memorie (.data) 
syscall #thirre sistemin 

#me marr n prej shfrytzuesit:
li $v0, 5 #komande e parapercaktuar per leximin e nje vlere int nga shfrytezuesi
syscall

move $t1, $v0  #n bartet ne regjistrin t1

#Me shfaq mesazhin e dyte
li $v0, 4
la $a0, message2
syscall 


#while loop-a
while:

bge $a1, $t1, exit #shko te label exit nese a1>=t1 , ne a1 eshte ruajtur i ndersa ne t1 n 

#Me printu hapsiren ne mes numrave 
li $v0, 4 
la $a0, hapsira 
syscall

jal fib # thirre fib(n)
move $s0, $v0 # ruje rezultatin ne regjistrin $s0

#me printu int i cili u rujt ne $s0
li $v0, 1 # printo integer (komande e parapercaktuar)
move $a0, $s0 # vendose ne regjistrin $a0 vleren qe gjindet ne regjistrin $s0
syscall


addi $a1, $a1, 1 #i=i+1

j while #shko te label while

exit:

#me nderpre loop-en - komande e MIPS me nderpre programin 
li $v0, 10
syscall

fib: sub $sp,$sp,12 # me rujt vendin per regjistrat qe do te ruhen ne stack
sw $a1, 0($sp) # ruje $a0 = n
sw $s0, 4($sp) # ruje $s0
sw $ra, 8($sp) # ruje $ra qe me na mundsu thirrjen rekurzive
bgt $a1,1, else # nese n>1 atehere shko te (goto) else
move $v0,$a1 # output = input nese n=0 ose n=1
j rregulloje # goto rregulloje qe me i rivendos regjistrat

else: sub $a1,$a1,1 # param = n-1
jal fib # llogarite fib(n-1)
move $s0,$v0 # ruje fib(n-1)
sub $a1,$a1,1 # param = n-2
jal fib # behet thirrja rekurzive te funksionit fib 
add $v0, $v0, $s0 # $v0 = fib(n-2)+fib(n-1)

rregulloje: lw $a1, 0($sp) # kthej regjistrat nga steku
lw $s0, 4($sp) #
lw $ra, 8($sp) #
add $sp, $sp, 12 # zvogloje hapsiren e stek-ut (vendet e zbrazta)
jr $ra #kthehu te adresa qe ke qene kur eshte thirre funksioni dhe vazhdo ekzekutimin

.data #tregon cilat variabla kemi me i vendos ne memorie
message: .asciiz "Enter the number of terms of series : " #message: eshte etikete qe e zevendson adresen e memories ku do te ruhet mesazhi i pare 
message2: .asciiz "\nFibonnaci Series : " #message2: eshte etikete qe e zevendson adresen e memories ku do te ruhet mesazhi i dyte
hapsira: .asciiz " " #hapsira: eshte etikete qe e zevendson adresen e memories ku do te ruhet hapsira
