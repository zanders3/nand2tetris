@256 //stacksetup
D=A
@SP
M=D
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
@SP //pop pointer 1
M=M-1
A=M
D=M
@THAT
M=D
@0 //push constant 0
D=A
@SP
A=M
M=D
@SP
M=M+1
@THAT //pop that 0
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
@1 //push constant 1
D=A
@SP
A=M
M=D
@SP
M=M+1
@THAT //pop that 1
D=M
@1
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
(FibonacciSeries$MAIN_LOOP_START) //label MAIN_LOOP_START
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
@SP //if-goto COMPUTE_ELEMENT
M=M-1
A=M
D=M
@FibonacciSeries$COMPUTE_ELEMENT
D;JGT
@FibonacciSeries$END_PROGRAM //goto END_PROGRAM
0;JMP
(FibonacciSeries$COMPUTE_ELEMENT) //label COMPUTE_ELEMENT
@THAT //push that 0
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT //push that 1
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
@THAT //pop that 2
D=M
@2
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
@THAT //push pointer 1
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
@SP //pop pointer 1
M=M-1
A=M
D=M
@THAT
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
@FibonacciSeries$MAIN_LOOP_START //goto MAIN_LOOP_START
0;JMP
(FibonacciSeries$END_PROGRAM) //label END_PROGRAM
(INFLOOP)
@INFLOOP
0;JMP
