#-------------------------------
#-- prog.asm
#--
#--
#----------------------------------
.ORIG h0200                 #-- Load Address

LIM DR7 h15E                #-- 0200:
ALU SR7 SR7 DR1 ADD         #-- 0201: 
ALU SR0 SR1 DR2 SUB         #-- 0202: 
LEA DR3                     #-- 0203: 
LIM DR4 h006                #-- 0204: 
LDR DR5 AR3                 #-- 0205: 
STR SR0 AR3                 #-- 0206: 
ALU SR3 SR4 DR6 ADD         #-- 0207: 
BRR CR0 AR6                 #-- 0208: 
.FILL h0011                 #-- 0209: (ALU SR2 SR3 DR7 ADD)
SYS CALL                    #-- 020a: 
BRR CR1 AR6                 #-- 020b: 

.ORIG h1000                 #-- Load Address

SYS RET                     #-- 1000: 
