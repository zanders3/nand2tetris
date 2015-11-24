@Main.fibonacci //function Main.fibonacci 0
@SP
A=M
D=A
@SP
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
@2 //push constant 2
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
@37
D;JLT
@SP
A=M
M=0
@SP
M=M+1
@SP //if-goto IF_TRUE
M=M-1
A=M
D=M
@Main.fibonacci
D;JGT
@Main.fibonacci //goto IF_FALSE
0;JMP
(Main.fibonacci //label IF_TRUE
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
( //label IF_FALSE
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
@2 //push constant 2
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
