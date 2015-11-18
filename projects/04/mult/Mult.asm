// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.
@R2    //R2 = 0
M=0
@R0    //IF R0==0 JUMP TO END
D=M
@END
D;JEQ
@R1    //IF R1==0 JUMP TO END
D=M
@END
D;JEQ
(LOOP)
@R1    //R2 += R1
D=M
@R2
M=D+M
@R0    //R0 -= 1
M=M-1
D=M
@LOOP  //Loop if R0 > 0
D;JGT
(END)//infinite loop
@END
0;JGT
