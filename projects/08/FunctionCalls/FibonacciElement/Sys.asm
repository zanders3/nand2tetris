@Sys.init //function Sys.init 0
@SP
A=M
D=A
@SP
M=D
@4 //push constant 4
D=A
@SP
A=M
M=D
@SP
M=M+1
@Main.fibonacci$RETURN //push RETURN ADDRESS
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL //push LCL
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG //push ARG
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS //push THIS
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT //push THAT
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP //ARG = SP-n-5
A=M
D=M
@6
D=D-A
@ARG
M=D
@SP //LCL = SP
D=M
@LCL
M=D
@Main.fibonacci
0;JMP
(Main.fibonacci$RETURN)
(Sys.init //label WHILE
@Sys.init //goto WHILE
0;JMP
(INFLOOP)
@INFLOOP
0;JMP
