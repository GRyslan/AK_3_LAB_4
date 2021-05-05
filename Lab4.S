.global Lab4
.syntax unified

#define X1 #12
#define X2 #2
#define X3 #-10
#define X4 #15
#define RB #0b01110001

Lab4:
  push {lr}
  bl task1
  bl task2
  pop {pc}

task1:
  push {lr}
  mov r0, X1  // значение x1
  mov r1, #0

  mov r2, X2  // значение x2
  mov r3, #0

  mov r4, X3 // значение x3
  mov r5, #-1 

  mov r6, X4  // значениеx x4
  mov r7, #0

  // calc
  // F = 8 * (12 | 2) + (-10 - 1 - 15) / 16 = 110.375;
  // F = 8 * (x1 | x2) + (x3 - 1 - x4) / 16;

  // (x1 or x2) 
  orr r0, r2
  orr r1, r3

  // 8 * (x1 | x2)
  lsl r0, #3
  lsl r1, #3

  // x3 - 1
  sub r4, #1
  sbc r5, #1

  // (x3 - 1 - x4)
  sub r4, r6
  sbc r5, r7

  // (x3 - 1 - x4) / 16
  asr r4, #4
  lsr r5, #4

    // 8 * (x1 or x2) + (x3 - 1 - x4) / 16;
  add r0, r4
  adc r1, r5

  pop {pc}


// Correction
step1:
  push {lr}
  bvc step2

  lsr r0, #1
  lsr r1, #1

step2:
  orr r0, #0
  bne step4
  mov r1, RB

step4:
    add r1, RB
  and r5, r1, #0xc0000000
  beq step7
  eor r5, #0xc0000000
  beq step7
  lsr r0, #1
  lsr r1, #1

step7:
  bvs  endc
  push {r0}
  push {r1}
  pop  {r1}
  pop  {r0}

endc:
  pop {pc}

task2:
	push {lr}

	mov r1, 10
	mov r2, 5

	//program start
	//step1 (r0=r1+r2)
	add r0, r1, r2  
	//step2 (r2=r2-1)
	sub r2,#1
_step3:
	// (r2=r1*r0)
	mul r2,r1,r0

	//step4
	it vs
	//step6 
	lsrVS r2,r2,#1
	bVS _step8
	//step5 (r0=r1+100)
	add r0, r1,100
	//step7 (r1=r1+4)
	lsls r2, r0,#2

_step8:
	it eq
	blEQ _step3

	//step9(r1 & r2)
	and r0,r1,r2

	pop {pc}


_step10:
	add r1,r1,100

	//step11
	it cc
	blCC _step13

	bl subP2
	//step12
	add r3, r3, #5

_step13:
	it vc
	blVC _step10

	//step14
	sub r1,r1,#94
	//step15
	add r0,r1,#63


	pop {pc}

subP2:
	push {lr}

	//step17
	add r0,r1,#1
	//step18
	add r1, r0, #1

	pop {pc}
