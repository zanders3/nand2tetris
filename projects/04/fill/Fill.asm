// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, the
// program clears the screen, i.e. writes "white" in every pixel.

// Put your code here.
(START)
@SCREEN    //R0=SCREEN
D=M
@R0
M=D
@R1		   //R1=4096
M=4096
@KEYBOARD  //D=KEYBOARD
D=M
@R2		   //R2=D
M=D
(LOOP)
@R2
D=M//D=R2
@R0  
A=M//SCREEN[R0]=D
M=D
@R0//R0=R0+1
M=M+1
@R1//R1=R1-1
M=M-1
D=M
@LOOP
D;JGT

@START
0;JMP