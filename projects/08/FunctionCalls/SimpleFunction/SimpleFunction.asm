@SimpleFunction.test //function SimpleFunction.test 2
@SP
A=M
M=0
A=A+1
M=0
A=A+1
D=A
@SP
M=D
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
@LCL //push local 1
D=M
@1
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
@SP //not
M=M-1
A=M
M=!M
@SP
M=M+1
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
@ARG //push argument 1
D=M
@1
A=D+A
D=M
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
@LCL //RETURN FRAME = LCL
D=M
@R14
M=D
@5 //RET = *(FRAME-5)
A=D-A
D=M
@R15
M=D
@SP //*ARG= pop()
A=M-1
D=M
@ARG
A=M
M=D
@ARG //SP = ARG + 1
D=M+1
@SP
M=D
@R14 //FRAME=FRAME-1; THAT = *FRAME;
AM=M-1
D=M
@THAT
M=D
@R14 //FRAME=FRAME-1; THIS = *FRAME;
AM=M-1
D=M
@THIS
M=D
@R14 //FRAME=FRAME-1; ARG = *FRAME;
AM=M-1
D=M
@ARG
M=D
@R14 //FRAME=FRAME-1; LCL = *FRAME;
AM=M-1
D=M
@LCL
M=D
@R15
A=M
0;JMP
(INFLOOP)
@INFLOOP
0;JMP
