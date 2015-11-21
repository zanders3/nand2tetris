@256 //stack setup
D=A
@SP
M=D
@7 //push constant 7
D=A
@SP
A=M
M=D
@SP
M=M+1
@8 //push constant 8
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
