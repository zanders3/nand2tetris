@256 //stacksetup
D=A
@SP
M=D
@17 //push constant 17
D=A
@SP
A=M
M=D
@SP
M=M+1
@17 //push constant 17
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP //eq
M=M-1
A=M
D=M
@SP
M=M-1
A=M
D=M-D
M=-1
@32
D;JEQ
@SP
A=M
M=0
@SP
M=M+1
@17 //push constant 17
D=A
@SP
A=M
M=D
@SP
M=M+1
@16 //push constant 16
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP //eq
M=M-1
A=M
D=M
@SP
M=M-1
A=M
D=M-D
M=-1
@62
D;JEQ
@SP
A=M
M=0
@SP
M=M+1
@16 //push constant 16
D=A
@SP
A=M
M=D
@SP
M=M+1
@17 //push constant 17
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP //eq
M=M-1
A=M
D=M
@SP
M=M-1
A=M
D=M-D
M=-1
@92
D;JEQ
@SP
A=M
M=0
@SP
M=M+1
@892 //push constant 892
D=A
@SP
A=M
M=D
@SP
M=M+1
@891 //push constant 891
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP //lt
M=M-1
A=M
D=M
@SP
M=M-1
A=M
D=M-D
M=-1
@122
D;JLT
@SP
A=M
M=0
@SP
M=M+1
@891 //push constant 891
D=A
@SP
A=M
M=D
@SP
M=M+1
@892 //push constant 892
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP //lt
M=M-1
A=M
D=M
@SP
M=M-1
A=M
D=M-D
M=-1
@152
D;JLT
@SP
A=M
M=0
@SP
M=M+1
@891 //push constant 891
D=A
@SP
A=M
M=D
@SP
M=M+1
@891 //push constant 891
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP //lt
M=M-1
A=M
D=M
@SP
M=M-1
A=M
D=M-D
M=-1
@182
D;JLT
@SP
A=M
M=0
@SP
M=M+1
@32767 //push constant 32767
D=A
@SP
A=M
M=D
@SP
M=M+1
@32766 //push constant 32766
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP //gt
M=M-1
A=M
D=M
@SP
M=M-1
A=M
D=M-D
M=-1
@212
D;JGT
@SP
A=M
M=0
@SP
M=M+1
@32766 //push constant 32766
D=A
@SP
A=M
M=D
@SP
M=M+1
@32767 //push constant 32767
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP //gt
M=M-1
A=M
D=M
@SP
M=M-1
A=M
D=M-D
M=-1
@242
D;JGT
@SP
A=M
M=0
@SP
M=M+1
@32766 //push constant 32766
D=A
@SP
A=M
M=D
@SP
M=M+1
@32766 //push constant 32766
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP //gt
M=M-1
A=M
D=M
@SP
M=M-1
A=M
D=M-D
M=-1
@272
D;JGT
@SP
A=M
M=0
@SP
M=M+1
@57 //push constant 57
D=A
@SP
A=M
M=D
@SP
M=M+1
@31 //push constant 31
D=A
@SP
A=M
M=D
@SP
M=M+1
@53 //push constant 53
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP //add
M=M-1
A=M
D=M
@SP
M=M-1
A=M
M=M+D
@SP
M=M+1
@112 //push constant 112
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP //sub
M=M-1
A=M
D=M
@SP
M=M-1
A=M
M=M-D
@SP
M=M+1
@SP //neg
M=M-1
A=M
M=-M
@SP
M=M+1
@SP //and
M=M-1
A=M
D=M
@SP
M=M-1
A=M
M=M&D
@SP
M=M+1
@82 //push constant 82
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP //or
M=M-1
A=M
D=M
@SP
M=M-1
A=M
M=M|D
@SP
M=M+1
@SP //not
M=M-1
A=M
M=!M
@SP
M=M+1
(INFLOOP)
@INFLOOP
0;JMP
