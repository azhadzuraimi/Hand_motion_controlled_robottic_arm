ORG 00H
DAT 	EQU 	P2
EN 	EQU 	P0.5
RW	EQU	P0.6
RS	EQU	P0.7
;-----START MAIN PROGRAM-------
;----------SWITCH------------
 main: 	MOV P0, #00000000B;
      	MOV A,P3
      	MOV R4,A

	MOV A, R4
	ANL A, #00100000B	;SWITCH K3
	JZ task1
	AJMP jmp1
task1:	ljmp sw1
	AJMP jmp1

jmp1:	MOV A, R4
	ANL A, #00010000B	;SWITCH K4
	JZ task2
	AJMP jmp2
task2:	ljmp sw2
	AJMP jmp2
	
jmp2:	MOV A, R4
	ANL A, #00001000B	;SWITCH K5
	JZ task3
	AJMP jmp3
task3:	ljmp sw3
	AJMP jmp3
	
jmp3:	MOV A, R4
	ANL A, #00000100B	;SWITCH K6
	JZ task4
	AJMP main
task4:	ljmp sw4
	AJMP main
	
;------MOTOR MOVE CLOCK WISE----
motor1:	MOV P0, #00000100B	;MOVE MOTOR 1 CLOCKWISE
	ACALL DELAY
	RET

motor2:	MOV P0, #00001000B	;MOVE MOTOR 1 ANTICLOCKWISE
	ACALL DELAY
	RET
	
motor3:	MOV P0, #00010000B	;MOVE MOTOR 2 CLOCKWISE
	ACALL DELAY
	RET
	
motor4:	MOV P0, #00100000B	;MOVE MOTOR 2 ANTICLOCKWISE
	ACALL DELAY
	RET
		
;------DISPLAY LCD-------------

;-----LEFT----------
SW1:	MOV A,#38H
	ACALL CMND
	MOV A,#0CH
	ACALL CMND
	MOV A,#01H
	ACALL CMND
	MOV A,#80H
	ACALL CMND 
	MOV A,#3CH
	ACALL CMND
	MOV A,#'R'
	ACALL DISP
	MOV A,#'E'
	ACALL DISP
	MOV A,#'L'
	ACALL DISP
	MOV A,#'E'
	ACALL DISP
	MOV A,#'A'
	ACALL DISP
	MOV A,#'S'
	ACALL DISP
	MOV A,#'E'
	ACALL DISP

	MOV A,#0C4H
	ACALL CMND

	MOV A,#'O'
	ACALL DISP
	MOV A,#'B'
	ACALL DISP
	MOV A,#'J'
	ACALL DISP
	MOV A,#'E'
	ACALL DISP
	MOV A,#'C'
	ACALL DISP
	MOV A,#'T'
	ACALL DISP

	ljmp motor1

;-----RIGHT-------
SW2:	MOV A,#38H
	ACALL CMND
	MOV A,#0CH
	ACALL CMND
	MOV A,#01H
	ACALL CMND
	MOV A,#80H
	ACALL CMND 
	MOV A,#3CH
	ACALL CMND
	MOV A,#'G'
	ACALL DISP
	MOV A,#'R'
	ACALL DISP
	MOV A,#'I'
	ACALL DISP
	MOV A,#'P'
	ACALL DISP

	MOV A,#0C4H
	ACALL CMND

	MOV A,#'O'
	ACALL DISP
	MOV A,#'B'
	ACALL DISP
	MOV A,#'J'
	ACALL DISP
	MOV A,#'E'
	ACALL DISP
	MOV A,#'C'
	ACALL DISP
	MOV A,#'T'
	ACALL DISP

	ljmp motor2
;-----UP-------
SW3:	MOV A,#38H
	ACALL CMND
	MOV A,#0CH
	ACALL CMND
	MOV A,#01H
	ACALL CMND
	MOV A,#80H
	ACALL CMND 
	MOV A,#3CH
	ACALL CMND
	MOV A,#'M'
	ACALL DISP
	MOV A,#'0'
	ACALL DISP
	MOV A,#'V'
	ACALL DISP
	MOV A,#'E'
	ACALL DISP

	MOV A,#0C4H
	ACALL CMND

	MOV A,#'U'
	ACALL DISP
	MOV A,#'P'
	ACALL DISP
	MOV A,#'W'
	ACALL DISP
	MOV A,#'A'
	ACALL DISP
	MOV A,#'R'
	ACALL DISP
	MOV A,#'D'
	ACALL DISP

	ljmp motor3
;-----RIGHT-------
SW4:	MOV A,#38H
	ACALL CMND
	MOV A,#0CH
	ACALL CMND
	MOV A,#01H
	ACALL CMND
	MOV A,#80H
	ACALL CMND 
	MOV A,#3CH
	ACALL CMND
	MOV A,#'M'
	ACALL DISP
	MOV A,#'0'
	ACALL DISP
	MOV A,#'V'
	ACALL DISP
	MOV A,#'E'
	ACALL DISP

	MOV A,#0C4H
	ACALL CMND

        
	MOV A,#'B'
	ACALL DISP
	MOV A,#'A'
	ACALL DISP
	MOV A,#'C'
	ACALL DISP
	MOV A,#'K'
	ACALL DISP
	MOV A,#'W'
	ACALL DISP
	MOV A,#'A'
	ACALL DISP
	MOV A,#'R'
	ACALL DISP
	MOV A,#'D'
	ACALL DISP

	ljmp motor4

;--------LOOP FOREVER-----
	HERE: SJMP HERE

;----------------------SUBROUTINE TO SEND COMMAND VALUE---------
CMND: 	MOV DAT,A
	CLR RS
	CLR RW
	SETB EN
	CLR  EN
	ACALL DELY
	RET
	;------------------------SUBROUTINE TO SEND VALUE DATA---------------
DISP:	MOV DAT,A
	SETB RS
	CLR RW
	SETB EN
	CLR EN
	ACALL DELY
	RET
;-------------SUBROUTINE TO CHECK BUSY FLAG STATUS------
DELY:	CLR 	EN
	CLR	RS
	SETB	RW
	MOV	DAT,#0FFH
	SETB	EN
	MOV	A,DAT
	JB	ACC.7,DELY
	CLR	EN
	CLR	RW
	RET
;----------SUBROUTINE DELAY-------
DELAY:	MOV R2,#1
LOOP2:	MOV R1,#255
LOOP1:	MOV R0,#255
LOOP0:	DJNZ R0, LOOP0
	DJNZ R1, LOOP1
	DJNZ R2, LOOP2
	RET
	END 
	
