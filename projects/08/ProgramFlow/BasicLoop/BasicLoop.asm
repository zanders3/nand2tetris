@256 //stacksetup
D=A
@SP
M=D
@0 //push constant 0
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL //pop local 0
D=M
@0
D=D+A
@R13
M=D
@SP
M=M-1
A=M
D=M
@R13
A=M
M=D
(BasicLoop$LOOP_START) //label LOOP_START
@ARG //push argument 0
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
@LCL //push local 0
D=M
@0
A=D+A
D=M
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
@LCL //pop local 0
D=M
@0
D=D+A
@R13
M=D
@SP
M=M-1
A=M
D=M
@R13
A=M
M=D
@ARG //push argument 0
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
@1 //push constant 1
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
@ARG //pop argument 0
D=M
@0
D=D+A
@R13
M=D
@SP
M=M-1
A=M
D=M
@R13
A=M
M=D
@ARG //push argument 0
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP //if-goto LOOP_START
M=M-1
A=M
D=M
@BasicLoop$LOOP_START
D;JGT
@LCL //push local 0
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
(INFLOOP)
@INFLOOP
0;JMP
