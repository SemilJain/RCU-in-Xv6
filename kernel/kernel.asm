
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	b3010113          	add	sp,sp,-1232 # 80008b30 <stack0>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	add	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	076000ef          	jal	8000008c <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <timerinit>:
// at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    8000001c:	1141                	add	sp,sp,-16
    8000001e:	e422                	sd	s0,8(sp)
    80000020:	0800                	add	s0,sp,16
// which hart (core) is this?
static inline uint64
r_mhartid()
{
  uint64 x;
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80000022:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80000026:	0007859b          	sext.w	a1,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    8000002a:	0037979b          	sllw	a5,a5,0x3
    8000002e:	02004737          	lui	a4,0x2004
    80000032:	97ba                	add	a5,a5,a4
    80000034:	0200c737          	lui	a4,0x200c
    80000038:	ff873703          	ld	a4,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000003c:	000f4637          	lui	a2,0xf4
    80000040:	24060613          	add	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80000044:	9732                	add	a4,a4,a2
    80000046:	e398                	sd	a4,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    80000048:	00259693          	sll	a3,a1,0x2
    8000004c:	96ae                	add	a3,a3,a1
    8000004e:	068e                	sll	a3,a3,0x3
    80000050:	00009717          	auipc	a4,0x9
    80000054:	9a070713          	add	a4,a4,-1632 # 800089f0 <timer_scratch>
    80000058:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    8000005a:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    8000005c:	f310                	sd	a2,32(a4)
}

static inline void 
w_mscratch(uint64 x)
{
  asm volatile("csrw mscratch, %0" : : "r" (x));
    8000005e:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    80000062:	00006797          	auipc	a5,0x6
    80000066:	0fe78793          	add	a5,a5,254 # 80006160 <timervec>
    8000006a:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    8000006e:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80000072:	0087e793          	or	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80000076:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    8000007a:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    8000007e:	0807e793          	or	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80000082:	30479073          	csrw	mie,a5
}
    80000086:	6422                	ld	s0,8(sp)
    80000088:	0141                	add	sp,sp,16
    8000008a:	8082                	ret

000000008000008c <start>:
{
    8000008c:	1141                	add	sp,sp,-16
    8000008e:	e406                	sd	ra,8(sp)
    80000090:	e022                	sd	s0,0(sp)
    80000092:	0800                	add	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80000094:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80000098:	7779                	lui	a4,0xffffe
    8000009a:	7ff70713          	add	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffdc787>
    8000009e:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    800000a0:	6705                	lui	a4,0x1
    800000a2:	80070713          	add	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800000a6:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    800000a8:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    800000ac:	00001797          	auipc	a5,0x1
    800000b0:	de878793          	add	a5,a5,-536 # 80000e94 <main>
    800000b4:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    800000b8:	4781                	li	a5,0
    800000ba:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    800000be:	67c1                	lui	a5,0x10
    800000c0:	17fd                	add	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800000c2:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    800000c6:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    800000ca:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    800000ce:	2227e793          	or	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    800000d2:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    800000d6:	57fd                	li	a5,-1
    800000d8:	83a9                	srl	a5,a5,0xa
    800000da:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    800000de:	47bd                	li	a5,15
    800000e0:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    800000e4:	00000097          	auipc	ra,0x0
    800000e8:	f38080e7          	jalr	-200(ra) # 8000001c <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800000ec:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    800000f0:	2781                	sext.w	a5,a5
}

static inline void 
w_tp(uint64 x)
{
  asm volatile("mv tp, %0" : : "r" (x));
    800000f2:	823e                	mv	tp,a5
  asm volatile("mret");
    800000f4:	30200073          	mret
}
    800000f8:	60a2                	ld	ra,8(sp)
    800000fa:	6402                	ld	s0,0(sp)
    800000fc:	0141                	add	sp,sp,16
    800000fe:	8082                	ret

0000000080000100 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80000100:	715d                	add	sp,sp,-80
    80000102:	e486                	sd	ra,72(sp)
    80000104:	e0a2                	sd	s0,64(sp)
    80000106:	fc26                	sd	s1,56(sp)
    80000108:	f84a                	sd	s2,48(sp)
    8000010a:	f44e                	sd	s3,40(sp)
    8000010c:	f052                	sd	s4,32(sp)
    8000010e:	ec56                	sd	s5,24(sp)
    80000110:	0880                	add	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    80000112:	04c05763          	blez	a2,80000160 <consolewrite+0x60>
    80000116:	8a2a                	mv	s4,a0
    80000118:	84ae                	mv	s1,a1
    8000011a:	89b2                	mv	s3,a2
    8000011c:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    8000011e:	5afd                	li	s5,-1
    80000120:	4685                	li	a3,1
    80000122:	8626                	mv	a2,s1
    80000124:	85d2                	mv	a1,s4
    80000126:	fbf40513          	add	a0,s0,-65
    8000012a:	00002097          	auipc	ra,0x2
    8000012e:	3cc080e7          	jalr	972(ra) # 800024f6 <either_copyin>
    80000132:	01550d63          	beq	a0,s5,8000014c <consolewrite+0x4c>
      break;
    uartputc(c);
    80000136:	fbf44503          	lbu	a0,-65(s0)
    8000013a:	00000097          	auipc	ra,0x0
    8000013e:	780080e7          	jalr	1920(ra) # 800008ba <uartputc>
  for(i = 0; i < n; i++){
    80000142:	2905                	addw	s2,s2,1
    80000144:	0485                	add	s1,s1,1
    80000146:	fd299de3          	bne	s3,s2,80000120 <consolewrite+0x20>
    8000014a:	894e                	mv	s2,s3
  }

  return i;
}
    8000014c:	854a                	mv	a0,s2
    8000014e:	60a6                	ld	ra,72(sp)
    80000150:	6406                	ld	s0,64(sp)
    80000152:	74e2                	ld	s1,56(sp)
    80000154:	7942                	ld	s2,48(sp)
    80000156:	79a2                	ld	s3,40(sp)
    80000158:	7a02                	ld	s4,32(sp)
    8000015a:	6ae2                	ld	s5,24(sp)
    8000015c:	6161                	add	sp,sp,80
    8000015e:	8082                	ret
  for(i = 0; i < n; i++){
    80000160:	4901                	li	s2,0
    80000162:	b7ed                	j	8000014c <consolewrite+0x4c>

0000000080000164 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80000164:	711d                	add	sp,sp,-96
    80000166:	ec86                	sd	ra,88(sp)
    80000168:	e8a2                	sd	s0,80(sp)
    8000016a:	e4a6                	sd	s1,72(sp)
    8000016c:	e0ca                	sd	s2,64(sp)
    8000016e:	fc4e                	sd	s3,56(sp)
    80000170:	f852                	sd	s4,48(sp)
    80000172:	f456                	sd	s5,40(sp)
    80000174:	f05a                	sd	s6,32(sp)
    80000176:	ec5e                	sd	s7,24(sp)
    80000178:	1080                	add	s0,sp,96
    8000017a:	8aaa                	mv	s5,a0
    8000017c:	8a2e                	mv	s4,a1
    8000017e:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80000180:	00060b1b          	sext.w	s6,a2
  acquire(&cons.lock);
    80000184:	00011517          	auipc	a0,0x11
    80000188:	9ac50513          	add	a0,a0,-1620 # 80010b30 <cons>
    8000018c:	00001097          	auipc	ra,0x1
    80000190:	a68080e7          	jalr	-1432(ra) # 80000bf4 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80000194:	00011497          	auipc	s1,0x11
    80000198:	99c48493          	add	s1,s1,-1636 # 80010b30 <cons>
      if(killed(myproc())){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    8000019c:	00011917          	auipc	s2,0x11
    800001a0:	a2c90913          	add	s2,s2,-1492 # 80010bc8 <cons+0x98>
  while(n > 0){
    800001a4:	09305263          	blez	s3,80000228 <consoleread+0xc4>
    while(cons.r == cons.w){
    800001a8:	0984a783          	lw	a5,152(s1)
    800001ac:	09c4a703          	lw	a4,156(s1)
    800001b0:	02f71763          	bne	a4,a5,800001de <consoleread+0x7a>
      if(killed(myproc())){
    800001b4:	00002097          	auipc	ra,0x2
    800001b8:	814080e7          	jalr	-2028(ra) # 800019c8 <myproc>
    800001bc:	00002097          	auipc	ra,0x2
    800001c0:	184080e7          	jalr	388(ra) # 80002340 <killed>
    800001c4:	ed2d                	bnez	a0,8000023e <consoleread+0xda>
      sleep(&cons.r, &cons.lock);
    800001c6:	85a6                	mv	a1,s1
    800001c8:	854a                	mv	a0,s2
    800001ca:	00002097          	auipc	ra,0x2
    800001ce:	ece080e7          	jalr	-306(ra) # 80002098 <sleep>
    while(cons.r == cons.w){
    800001d2:	0984a783          	lw	a5,152(s1)
    800001d6:	09c4a703          	lw	a4,156(s1)
    800001da:	fcf70de3          	beq	a4,a5,800001b4 <consoleread+0x50>
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    800001de:	00011717          	auipc	a4,0x11
    800001e2:	95270713          	add	a4,a4,-1710 # 80010b30 <cons>
    800001e6:	0017869b          	addw	a3,a5,1
    800001ea:	08d72c23          	sw	a3,152(a4)
    800001ee:	07f7f693          	and	a3,a5,127
    800001f2:	9736                	add	a4,a4,a3
    800001f4:	01874703          	lbu	a4,24(a4)
    800001f8:	00070b9b          	sext.w	s7,a4

    if(c == C('D')){  // end-of-file
    800001fc:	4691                	li	a3,4
    800001fe:	06db8463          	beq	s7,a3,80000266 <consoleread+0x102>
      }
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    80000202:	fae407a3          	sb	a4,-81(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80000206:	4685                	li	a3,1
    80000208:	faf40613          	add	a2,s0,-81
    8000020c:	85d2                	mv	a1,s4
    8000020e:	8556                	mv	a0,s5
    80000210:	00002097          	auipc	ra,0x2
    80000214:	290080e7          	jalr	656(ra) # 800024a0 <either_copyout>
    80000218:	57fd                	li	a5,-1
    8000021a:	00f50763          	beq	a0,a5,80000228 <consoleread+0xc4>
      break;

    dst++;
    8000021e:	0a05                	add	s4,s4,1
    --n;
    80000220:	39fd                	addw	s3,s3,-1

    if(c == '\n'){
    80000222:	47a9                	li	a5,10
    80000224:	f8fb90e3          	bne	s7,a5,800001a4 <consoleread+0x40>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80000228:	00011517          	auipc	a0,0x11
    8000022c:	90850513          	add	a0,a0,-1784 # 80010b30 <cons>
    80000230:	00001097          	auipc	ra,0x1
    80000234:	a78080e7          	jalr	-1416(ra) # 80000ca8 <release>

  return target - n;
    80000238:	413b053b          	subw	a0,s6,s3
    8000023c:	a811                	j	80000250 <consoleread+0xec>
        release(&cons.lock);
    8000023e:	00011517          	auipc	a0,0x11
    80000242:	8f250513          	add	a0,a0,-1806 # 80010b30 <cons>
    80000246:	00001097          	auipc	ra,0x1
    8000024a:	a62080e7          	jalr	-1438(ra) # 80000ca8 <release>
        return -1;
    8000024e:	557d                	li	a0,-1
}
    80000250:	60e6                	ld	ra,88(sp)
    80000252:	6446                	ld	s0,80(sp)
    80000254:	64a6                	ld	s1,72(sp)
    80000256:	6906                	ld	s2,64(sp)
    80000258:	79e2                	ld	s3,56(sp)
    8000025a:	7a42                	ld	s4,48(sp)
    8000025c:	7aa2                	ld	s5,40(sp)
    8000025e:	7b02                	ld	s6,32(sp)
    80000260:	6be2                	ld	s7,24(sp)
    80000262:	6125                	add	sp,sp,96
    80000264:	8082                	ret
      if(n < target){
    80000266:	0009871b          	sext.w	a4,s3
    8000026a:	fb677fe3          	bgeu	a4,s6,80000228 <consoleread+0xc4>
        cons.r--;
    8000026e:	00011717          	auipc	a4,0x11
    80000272:	94f72d23          	sw	a5,-1702(a4) # 80010bc8 <cons+0x98>
    80000276:	bf4d                	j	80000228 <consoleread+0xc4>

0000000080000278 <consputc>:
{
    80000278:	1141                	add	sp,sp,-16
    8000027a:	e406                	sd	ra,8(sp)
    8000027c:	e022                	sd	s0,0(sp)
    8000027e:	0800                	add	s0,sp,16
  if(c == BACKSPACE){
    80000280:	10000793          	li	a5,256
    80000284:	00f50a63          	beq	a0,a5,80000298 <consputc+0x20>
    uartputc_sync(c);
    80000288:	00000097          	auipc	ra,0x0
    8000028c:	560080e7          	jalr	1376(ra) # 800007e8 <uartputc_sync>
}
    80000290:	60a2                	ld	ra,8(sp)
    80000292:	6402                	ld	s0,0(sp)
    80000294:	0141                	add	sp,sp,16
    80000296:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80000298:	4521                	li	a0,8
    8000029a:	00000097          	auipc	ra,0x0
    8000029e:	54e080e7          	jalr	1358(ra) # 800007e8 <uartputc_sync>
    800002a2:	02000513          	li	a0,32
    800002a6:	00000097          	auipc	ra,0x0
    800002aa:	542080e7          	jalr	1346(ra) # 800007e8 <uartputc_sync>
    800002ae:	4521                	li	a0,8
    800002b0:	00000097          	auipc	ra,0x0
    800002b4:	538080e7          	jalr	1336(ra) # 800007e8 <uartputc_sync>
    800002b8:	bfe1                	j	80000290 <consputc+0x18>

00000000800002ba <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800002ba:	1101                	add	sp,sp,-32
    800002bc:	ec06                	sd	ra,24(sp)
    800002be:	e822                	sd	s0,16(sp)
    800002c0:	e426                	sd	s1,8(sp)
    800002c2:	e04a                	sd	s2,0(sp)
    800002c4:	1000                	add	s0,sp,32
    800002c6:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    800002c8:	00011517          	auipc	a0,0x11
    800002cc:	86850513          	add	a0,a0,-1944 # 80010b30 <cons>
    800002d0:	00001097          	auipc	ra,0x1
    800002d4:	924080e7          	jalr	-1756(ra) # 80000bf4 <acquire>

  switch(c){
    800002d8:	47d5                	li	a5,21
    800002da:	0af48663          	beq	s1,a5,80000386 <consoleintr+0xcc>
    800002de:	0297ca63          	blt	a5,s1,80000312 <consoleintr+0x58>
    800002e2:	47a1                	li	a5,8
    800002e4:	0ef48763          	beq	s1,a5,800003d2 <consoleintr+0x118>
    800002e8:	47c1                	li	a5,16
    800002ea:	10f49a63          	bne	s1,a5,800003fe <consoleintr+0x144>
  case C('P'):  // Print process list.
    procdump();
    800002ee:	00002097          	auipc	ra,0x2
    800002f2:	25e080e7          	jalr	606(ra) # 8000254c <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    800002f6:	00011517          	auipc	a0,0x11
    800002fa:	83a50513          	add	a0,a0,-1990 # 80010b30 <cons>
    800002fe:	00001097          	auipc	ra,0x1
    80000302:	9aa080e7          	jalr	-1622(ra) # 80000ca8 <release>
}
    80000306:	60e2                	ld	ra,24(sp)
    80000308:	6442                	ld	s0,16(sp)
    8000030a:	64a2                	ld	s1,8(sp)
    8000030c:	6902                	ld	s2,0(sp)
    8000030e:	6105                	add	sp,sp,32
    80000310:	8082                	ret
  switch(c){
    80000312:	07f00793          	li	a5,127
    80000316:	0af48e63          	beq	s1,a5,800003d2 <consoleintr+0x118>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    8000031a:	00011717          	auipc	a4,0x11
    8000031e:	81670713          	add	a4,a4,-2026 # 80010b30 <cons>
    80000322:	0a072783          	lw	a5,160(a4)
    80000326:	09872703          	lw	a4,152(a4)
    8000032a:	9f99                	subw	a5,a5,a4
    8000032c:	07f00713          	li	a4,127
    80000330:	fcf763e3          	bltu	a4,a5,800002f6 <consoleintr+0x3c>
      c = (c == '\r') ? '\n' : c;
    80000334:	47b5                	li	a5,13
    80000336:	0cf48763          	beq	s1,a5,80000404 <consoleintr+0x14a>
      consputc(c);
    8000033a:	8526                	mv	a0,s1
    8000033c:	00000097          	auipc	ra,0x0
    80000340:	f3c080e7          	jalr	-196(ra) # 80000278 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80000344:	00010797          	auipc	a5,0x10
    80000348:	7ec78793          	add	a5,a5,2028 # 80010b30 <cons>
    8000034c:	0a07a683          	lw	a3,160(a5)
    80000350:	0016871b          	addw	a4,a3,1
    80000354:	0007061b          	sext.w	a2,a4
    80000358:	0ae7a023          	sw	a4,160(a5)
    8000035c:	07f6f693          	and	a3,a3,127
    80000360:	97b6                	add	a5,a5,a3
    80000362:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    80000366:	47a9                	li	a5,10
    80000368:	0cf48563          	beq	s1,a5,80000432 <consoleintr+0x178>
    8000036c:	4791                	li	a5,4
    8000036e:	0cf48263          	beq	s1,a5,80000432 <consoleintr+0x178>
    80000372:	00011797          	auipc	a5,0x11
    80000376:	8567a783          	lw	a5,-1962(a5) # 80010bc8 <cons+0x98>
    8000037a:	9f1d                	subw	a4,a4,a5
    8000037c:	08000793          	li	a5,128
    80000380:	f6f71be3          	bne	a4,a5,800002f6 <consoleintr+0x3c>
    80000384:	a07d                	j	80000432 <consoleintr+0x178>
    while(cons.e != cons.w &&
    80000386:	00010717          	auipc	a4,0x10
    8000038a:	7aa70713          	add	a4,a4,1962 # 80010b30 <cons>
    8000038e:	0a072783          	lw	a5,160(a4)
    80000392:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80000396:	00010497          	auipc	s1,0x10
    8000039a:	79a48493          	add	s1,s1,1946 # 80010b30 <cons>
    while(cons.e != cons.w &&
    8000039e:	4929                	li	s2,10
    800003a0:	f4f70be3          	beq	a4,a5,800002f6 <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    800003a4:	37fd                	addw	a5,a5,-1
    800003a6:	07f7f713          	and	a4,a5,127
    800003aa:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    800003ac:	01874703          	lbu	a4,24(a4)
    800003b0:	f52703e3          	beq	a4,s2,800002f6 <consoleintr+0x3c>
      cons.e--;
    800003b4:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    800003b8:	10000513          	li	a0,256
    800003bc:	00000097          	auipc	ra,0x0
    800003c0:	ebc080e7          	jalr	-324(ra) # 80000278 <consputc>
    while(cons.e != cons.w &&
    800003c4:	0a04a783          	lw	a5,160(s1)
    800003c8:	09c4a703          	lw	a4,156(s1)
    800003cc:	fcf71ce3          	bne	a4,a5,800003a4 <consoleintr+0xea>
    800003d0:	b71d                	j	800002f6 <consoleintr+0x3c>
    if(cons.e != cons.w){
    800003d2:	00010717          	auipc	a4,0x10
    800003d6:	75e70713          	add	a4,a4,1886 # 80010b30 <cons>
    800003da:	0a072783          	lw	a5,160(a4)
    800003de:	09c72703          	lw	a4,156(a4)
    800003e2:	f0f70ae3          	beq	a4,a5,800002f6 <consoleintr+0x3c>
      cons.e--;
    800003e6:	37fd                	addw	a5,a5,-1
    800003e8:	00010717          	auipc	a4,0x10
    800003ec:	7ef72423          	sw	a5,2024(a4) # 80010bd0 <cons+0xa0>
      consputc(BACKSPACE);
    800003f0:	10000513          	li	a0,256
    800003f4:	00000097          	auipc	ra,0x0
    800003f8:	e84080e7          	jalr	-380(ra) # 80000278 <consputc>
    800003fc:	bded                	j	800002f6 <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    800003fe:	ee048ce3          	beqz	s1,800002f6 <consoleintr+0x3c>
    80000402:	bf21                	j	8000031a <consoleintr+0x60>
      consputc(c);
    80000404:	4529                	li	a0,10
    80000406:	00000097          	auipc	ra,0x0
    8000040a:	e72080e7          	jalr	-398(ra) # 80000278 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    8000040e:	00010797          	auipc	a5,0x10
    80000412:	72278793          	add	a5,a5,1826 # 80010b30 <cons>
    80000416:	0a07a703          	lw	a4,160(a5)
    8000041a:	0017069b          	addw	a3,a4,1
    8000041e:	0006861b          	sext.w	a2,a3
    80000422:	0ad7a023          	sw	a3,160(a5)
    80000426:	07f77713          	and	a4,a4,127
    8000042a:	97ba                	add	a5,a5,a4
    8000042c:	4729                	li	a4,10
    8000042e:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80000432:	00010797          	auipc	a5,0x10
    80000436:	78c7ad23          	sw	a2,1946(a5) # 80010bcc <cons+0x9c>
        wakeup(&cons.r);
    8000043a:	00010517          	auipc	a0,0x10
    8000043e:	78e50513          	add	a0,a0,1934 # 80010bc8 <cons+0x98>
    80000442:	00002097          	auipc	ra,0x2
    80000446:	cba080e7          	jalr	-838(ra) # 800020fc <wakeup>
    8000044a:	b575                	j	800002f6 <consoleintr+0x3c>

000000008000044c <consoleinit>:

void
consoleinit(void)
{
    8000044c:	1141                	add	sp,sp,-16
    8000044e:	e406                	sd	ra,8(sp)
    80000450:	e022                	sd	s0,0(sp)
    80000452:	0800                	add	s0,sp,16
  initlock(&cons.lock, "cons");
    80000454:	00008597          	auipc	a1,0x8
    80000458:	bbc58593          	add	a1,a1,-1092 # 80008010 <etext+0x10>
    8000045c:	00010517          	auipc	a0,0x10
    80000460:	6d450513          	add	a0,a0,1748 # 80010b30 <cons>
    80000464:	00000097          	auipc	ra,0x0
    80000468:	700080e7          	jalr	1792(ra) # 80000b64 <initlock>

  uartinit();
    8000046c:	00000097          	auipc	ra,0x0
    80000470:	32c080e7          	jalr	812(ra) # 80000798 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80000474:	00021797          	auipc	a5,0x21
    80000478:	a5478793          	add	a5,a5,-1452 # 80020ec8 <devsw>
    8000047c:	00000717          	auipc	a4,0x0
    80000480:	ce870713          	add	a4,a4,-792 # 80000164 <consoleread>
    80000484:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80000486:	00000717          	auipc	a4,0x0
    8000048a:	c7a70713          	add	a4,a4,-902 # 80000100 <consolewrite>
    8000048e:	ef98                	sd	a4,24(a5)
}
    80000490:	60a2                	ld	ra,8(sp)
    80000492:	6402                	ld	s0,0(sp)
    80000494:	0141                	add	sp,sp,16
    80000496:	8082                	ret

0000000080000498 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    80000498:	7179                	add	sp,sp,-48
    8000049a:	f406                	sd	ra,40(sp)
    8000049c:	f022                	sd	s0,32(sp)
    8000049e:	ec26                	sd	s1,24(sp)
    800004a0:	e84a                	sd	s2,16(sp)
    800004a2:	1800                	add	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    800004a4:	c219                	beqz	a2,800004aa <printint+0x12>
    800004a6:	08054763          	bltz	a0,80000534 <printint+0x9c>
    x = -xx;
  else
    x = xx;
    800004aa:	2501                	sext.w	a0,a0
    800004ac:	4881                	li	a7,0
    800004ae:	fd040693          	add	a3,s0,-48

  i = 0;
    800004b2:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    800004b4:	2581                	sext.w	a1,a1
    800004b6:	00008617          	auipc	a2,0x8
    800004ba:	b8a60613          	add	a2,a2,-1142 # 80008040 <digits>
    800004be:	883a                	mv	a6,a4
    800004c0:	2705                	addw	a4,a4,1
    800004c2:	02b577bb          	remuw	a5,a0,a1
    800004c6:	1782                	sll	a5,a5,0x20
    800004c8:	9381                	srl	a5,a5,0x20
    800004ca:	97b2                	add	a5,a5,a2
    800004cc:	0007c783          	lbu	a5,0(a5)
    800004d0:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    800004d4:	0005079b          	sext.w	a5,a0
    800004d8:	02b5553b          	divuw	a0,a0,a1
    800004dc:	0685                	add	a3,a3,1
    800004de:	feb7f0e3          	bgeu	a5,a1,800004be <printint+0x26>

  if(sign)
    800004e2:	00088c63          	beqz	a7,800004fa <printint+0x62>
    buf[i++] = '-';
    800004e6:	fe070793          	add	a5,a4,-32
    800004ea:	00878733          	add	a4,a5,s0
    800004ee:	02d00793          	li	a5,45
    800004f2:	fef70823          	sb	a5,-16(a4)
    800004f6:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
    800004fa:	02e05763          	blez	a4,80000528 <printint+0x90>
    800004fe:	fd040793          	add	a5,s0,-48
    80000502:	00e784b3          	add	s1,a5,a4
    80000506:	fff78913          	add	s2,a5,-1
    8000050a:	993a                	add	s2,s2,a4
    8000050c:	377d                	addw	a4,a4,-1
    8000050e:	1702                	sll	a4,a4,0x20
    80000510:	9301                	srl	a4,a4,0x20
    80000512:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80000516:	fff4c503          	lbu	a0,-1(s1)
    8000051a:	00000097          	auipc	ra,0x0
    8000051e:	d5e080e7          	jalr	-674(ra) # 80000278 <consputc>
  while(--i >= 0)
    80000522:	14fd                	add	s1,s1,-1
    80000524:	ff2499e3          	bne	s1,s2,80000516 <printint+0x7e>
}
    80000528:	70a2                	ld	ra,40(sp)
    8000052a:	7402                	ld	s0,32(sp)
    8000052c:	64e2                	ld	s1,24(sp)
    8000052e:	6942                	ld	s2,16(sp)
    80000530:	6145                	add	sp,sp,48
    80000532:	8082                	ret
    x = -xx;
    80000534:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    80000538:	4885                	li	a7,1
    x = -xx;
    8000053a:	bf95                	j	800004ae <printint+0x16>

000000008000053c <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    8000053c:	1101                	add	sp,sp,-32
    8000053e:	ec06                	sd	ra,24(sp)
    80000540:	e822                	sd	s0,16(sp)
    80000542:	e426                	sd	s1,8(sp)
    80000544:	1000                	add	s0,sp,32
    80000546:	84aa                	mv	s1,a0
  pr.locking = 0;
    80000548:	00010797          	auipc	a5,0x10
    8000054c:	6a07a423          	sw	zero,1704(a5) # 80010bf0 <pr+0x18>
  printf("panic: ");
    80000550:	00008517          	auipc	a0,0x8
    80000554:	ac850513          	add	a0,a0,-1336 # 80008018 <etext+0x18>
    80000558:	00000097          	auipc	ra,0x0
    8000055c:	02e080e7          	jalr	46(ra) # 80000586 <printf>
  printf(s);
    80000560:	8526                	mv	a0,s1
    80000562:	00000097          	auipc	ra,0x0
    80000566:	024080e7          	jalr	36(ra) # 80000586 <printf>
  printf("\n");
    8000056a:	00008517          	auipc	a0,0x8
    8000056e:	b5e50513          	add	a0,a0,-1186 # 800080c8 <digits+0x88>
    80000572:	00000097          	auipc	ra,0x0
    80000576:	014080e7          	jalr	20(ra) # 80000586 <printf>
  panicked = 1; // freeze uart output from other CPUs
    8000057a:	4785                	li	a5,1
    8000057c:	00008717          	auipc	a4,0x8
    80000580:	42f72a23          	sw	a5,1076(a4) # 800089b0 <panicked>
  for(;;)
    80000584:	a001                	j	80000584 <panic+0x48>

0000000080000586 <printf>:
{
    80000586:	7131                	add	sp,sp,-192
    80000588:	fc86                	sd	ra,120(sp)
    8000058a:	f8a2                	sd	s0,112(sp)
    8000058c:	f4a6                	sd	s1,104(sp)
    8000058e:	f0ca                	sd	s2,96(sp)
    80000590:	ecce                	sd	s3,88(sp)
    80000592:	e8d2                	sd	s4,80(sp)
    80000594:	e4d6                	sd	s5,72(sp)
    80000596:	e0da                	sd	s6,64(sp)
    80000598:	fc5e                	sd	s7,56(sp)
    8000059a:	f862                	sd	s8,48(sp)
    8000059c:	f466                	sd	s9,40(sp)
    8000059e:	f06a                	sd	s10,32(sp)
    800005a0:	ec6e                	sd	s11,24(sp)
    800005a2:	0100                	add	s0,sp,128
    800005a4:	8a2a                	mv	s4,a0
    800005a6:	e40c                	sd	a1,8(s0)
    800005a8:	e810                	sd	a2,16(s0)
    800005aa:	ec14                	sd	a3,24(s0)
    800005ac:	f018                	sd	a4,32(s0)
    800005ae:	f41c                	sd	a5,40(s0)
    800005b0:	03043823          	sd	a6,48(s0)
    800005b4:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    800005b8:	00010d97          	auipc	s11,0x10
    800005bc:	638dad83          	lw	s11,1592(s11) # 80010bf0 <pr+0x18>
  if(locking)
    800005c0:	020d9b63          	bnez	s11,800005f6 <printf+0x70>
  if (fmt == 0)
    800005c4:	040a0263          	beqz	s4,80000608 <printf+0x82>
  va_start(ap, fmt);
    800005c8:	00840793          	add	a5,s0,8
    800005cc:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    800005d0:	000a4503          	lbu	a0,0(s4)
    800005d4:	14050f63          	beqz	a0,80000732 <printf+0x1ac>
    800005d8:	4981                	li	s3,0
    if(c != '%'){
    800005da:	02500a93          	li	s5,37
    switch(c){
    800005de:	07000b93          	li	s7,112
  consputc('x');
    800005e2:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800005e4:	00008b17          	auipc	s6,0x8
    800005e8:	a5cb0b13          	add	s6,s6,-1444 # 80008040 <digits>
    switch(c){
    800005ec:	07300c93          	li	s9,115
    800005f0:	06400c13          	li	s8,100
    800005f4:	a82d                	j	8000062e <printf+0xa8>
    acquire(&pr.lock);
    800005f6:	00010517          	auipc	a0,0x10
    800005fa:	5e250513          	add	a0,a0,1506 # 80010bd8 <pr>
    800005fe:	00000097          	auipc	ra,0x0
    80000602:	5f6080e7          	jalr	1526(ra) # 80000bf4 <acquire>
    80000606:	bf7d                	j	800005c4 <printf+0x3e>
    panic("null fmt");
    80000608:	00008517          	auipc	a0,0x8
    8000060c:	a2050513          	add	a0,a0,-1504 # 80008028 <etext+0x28>
    80000610:	00000097          	auipc	ra,0x0
    80000614:	f2c080e7          	jalr	-212(ra) # 8000053c <panic>
      consputc(c);
    80000618:	00000097          	auipc	ra,0x0
    8000061c:	c60080e7          	jalr	-928(ra) # 80000278 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80000620:	2985                	addw	s3,s3,1
    80000622:	013a07b3          	add	a5,s4,s3
    80000626:	0007c503          	lbu	a0,0(a5)
    8000062a:	10050463          	beqz	a0,80000732 <printf+0x1ac>
    if(c != '%'){
    8000062e:	ff5515e3          	bne	a0,s5,80000618 <printf+0x92>
    c = fmt[++i] & 0xff;
    80000632:	2985                	addw	s3,s3,1
    80000634:	013a07b3          	add	a5,s4,s3
    80000638:	0007c783          	lbu	a5,0(a5)
    8000063c:	0007849b          	sext.w	s1,a5
    if(c == 0)
    80000640:	cbed                	beqz	a5,80000732 <printf+0x1ac>
    switch(c){
    80000642:	05778a63          	beq	a5,s7,80000696 <printf+0x110>
    80000646:	02fbf663          	bgeu	s7,a5,80000672 <printf+0xec>
    8000064a:	09978863          	beq	a5,s9,800006da <printf+0x154>
    8000064e:	07800713          	li	a4,120
    80000652:	0ce79563          	bne	a5,a4,8000071c <printf+0x196>
      printint(va_arg(ap, int), 16, 1);
    80000656:	f8843783          	ld	a5,-120(s0)
    8000065a:	00878713          	add	a4,a5,8
    8000065e:	f8e43423          	sd	a4,-120(s0)
    80000662:	4605                	li	a2,1
    80000664:	85ea                	mv	a1,s10
    80000666:	4388                	lw	a0,0(a5)
    80000668:	00000097          	auipc	ra,0x0
    8000066c:	e30080e7          	jalr	-464(ra) # 80000498 <printint>
      break;
    80000670:	bf45                	j	80000620 <printf+0x9a>
    switch(c){
    80000672:	09578f63          	beq	a5,s5,80000710 <printf+0x18a>
    80000676:	0b879363          	bne	a5,s8,8000071c <printf+0x196>
      printint(va_arg(ap, int), 10, 1);
    8000067a:	f8843783          	ld	a5,-120(s0)
    8000067e:	00878713          	add	a4,a5,8
    80000682:	f8e43423          	sd	a4,-120(s0)
    80000686:	4605                	li	a2,1
    80000688:	45a9                	li	a1,10
    8000068a:	4388                	lw	a0,0(a5)
    8000068c:	00000097          	auipc	ra,0x0
    80000690:	e0c080e7          	jalr	-500(ra) # 80000498 <printint>
      break;
    80000694:	b771                	j	80000620 <printf+0x9a>
      printptr(va_arg(ap, uint64));
    80000696:	f8843783          	ld	a5,-120(s0)
    8000069a:	00878713          	add	a4,a5,8
    8000069e:	f8e43423          	sd	a4,-120(s0)
    800006a2:	0007b903          	ld	s2,0(a5)
  consputc('0');
    800006a6:	03000513          	li	a0,48
    800006aa:	00000097          	auipc	ra,0x0
    800006ae:	bce080e7          	jalr	-1074(ra) # 80000278 <consputc>
  consputc('x');
    800006b2:	07800513          	li	a0,120
    800006b6:	00000097          	auipc	ra,0x0
    800006ba:	bc2080e7          	jalr	-1086(ra) # 80000278 <consputc>
    800006be:	84ea                	mv	s1,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800006c0:	03c95793          	srl	a5,s2,0x3c
    800006c4:	97da                	add	a5,a5,s6
    800006c6:	0007c503          	lbu	a0,0(a5)
    800006ca:	00000097          	auipc	ra,0x0
    800006ce:	bae080e7          	jalr	-1106(ra) # 80000278 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800006d2:	0912                	sll	s2,s2,0x4
    800006d4:	34fd                	addw	s1,s1,-1
    800006d6:	f4ed                	bnez	s1,800006c0 <printf+0x13a>
    800006d8:	b7a1                	j	80000620 <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    800006da:	f8843783          	ld	a5,-120(s0)
    800006de:	00878713          	add	a4,a5,8
    800006e2:	f8e43423          	sd	a4,-120(s0)
    800006e6:	6384                	ld	s1,0(a5)
    800006e8:	cc89                	beqz	s1,80000702 <printf+0x17c>
      for(; *s; s++)
    800006ea:	0004c503          	lbu	a0,0(s1)
    800006ee:	d90d                	beqz	a0,80000620 <printf+0x9a>
        consputc(*s);
    800006f0:	00000097          	auipc	ra,0x0
    800006f4:	b88080e7          	jalr	-1144(ra) # 80000278 <consputc>
      for(; *s; s++)
    800006f8:	0485                	add	s1,s1,1
    800006fa:	0004c503          	lbu	a0,0(s1)
    800006fe:	f96d                	bnez	a0,800006f0 <printf+0x16a>
    80000700:	b705                	j	80000620 <printf+0x9a>
        s = "(null)";
    80000702:	00008497          	auipc	s1,0x8
    80000706:	91e48493          	add	s1,s1,-1762 # 80008020 <etext+0x20>
      for(; *s; s++)
    8000070a:	02800513          	li	a0,40
    8000070e:	b7cd                	j	800006f0 <printf+0x16a>
      consputc('%');
    80000710:	8556                	mv	a0,s5
    80000712:	00000097          	auipc	ra,0x0
    80000716:	b66080e7          	jalr	-1178(ra) # 80000278 <consputc>
      break;
    8000071a:	b719                	j	80000620 <printf+0x9a>
      consputc('%');
    8000071c:	8556                	mv	a0,s5
    8000071e:	00000097          	auipc	ra,0x0
    80000722:	b5a080e7          	jalr	-1190(ra) # 80000278 <consputc>
      consputc(c);
    80000726:	8526                	mv	a0,s1
    80000728:	00000097          	auipc	ra,0x0
    8000072c:	b50080e7          	jalr	-1200(ra) # 80000278 <consputc>
      break;
    80000730:	bdc5                	j	80000620 <printf+0x9a>
  if(locking)
    80000732:	020d9163          	bnez	s11,80000754 <printf+0x1ce>
}
    80000736:	70e6                	ld	ra,120(sp)
    80000738:	7446                	ld	s0,112(sp)
    8000073a:	74a6                	ld	s1,104(sp)
    8000073c:	7906                	ld	s2,96(sp)
    8000073e:	69e6                	ld	s3,88(sp)
    80000740:	6a46                	ld	s4,80(sp)
    80000742:	6aa6                	ld	s5,72(sp)
    80000744:	6b06                	ld	s6,64(sp)
    80000746:	7be2                	ld	s7,56(sp)
    80000748:	7c42                	ld	s8,48(sp)
    8000074a:	7ca2                	ld	s9,40(sp)
    8000074c:	7d02                	ld	s10,32(sp)
    8000074e:	6de2                	ld	s11,24(sp)
    80000750:	6129                	add	sp,sp,192
    80000752:	8082                	ret
    release(&pr.lock);
    80000754:	00010517          	auipc	a0,0x10
    80000758:	48450513          	add	a0,a0,1156 # 80010bd8 <pr>
    8000075c:	00000097          	auipc	ra,0x0
    80000760:	54c080e7          	jalr	1356(ra) # 80000ca8 <release>
}
    80000764:	bfc9                	j	80000736 <printf+0x1b0>

0000000080000766 <printfinit>:
    ;
}

void
printfinit(void)
{
    80000766:	1101                	add	sp,sp,-32
    80000768:	ec06                	sd	ra,24(sp)
    8000076a:	e822                	sd	s0,16(sp)
    8000076c:	e426                	sd	s1,8(sp)
    8000076e:	1000                	add	s0,sp,32
  initlock(&pr.lock, "pr");
    80000770:	00010497          	auipc	s1,0x10
    80000774:	46848493          	add	s1,s1,1128 # 80010bd8 <pr>
    80000778:	00008597          	auipc	a1,0x8
    8000077c:	8c058593          	add	a1,a1,-1856 # 80008038 <etext+0x38>
    80000780:	8526                	mv	a0,s1
    80000782:	00000097          	auipc	ra,0x0
    80000786:	3e2080e7          	jalr	994(ra) # 80000b64 <initlock>
  pr.locking = 1;
    8000078a:	4785                	li	a5,1
    8000078c:	cc9c                	sw	a5,24(s1)
}
    8000078e:	60e2                	ld	ra,24(sp)
    80000790:	6442                	ld	s0,16(sp)
    80000792:	64a2                	ld	s1,8(sp)
    80000794:	6105                	add	sp,sp,32
    80000796:	8082                	ret

0000000080000798 <uartinit>:

void uartstart();

void
uartinit(void)
{
    80000798:	1141                	add	sp,sp,-16
    8000079a:	e406                	sd	ra,8(sp)
    8000079c:	e022                	sd	s0,0(sp)
    8000079e:	0800                	add	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    800007a0:	100007b7          	lui	a5,0x10000
    800007a4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    800007a8:	f8000713          	li	a4,-128
    800007ac:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    800007b0:	470d                	li	a4,3
    800007b2:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    800007b6:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    800007ba:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    800007be:	469d                	li	a3,7
    800007c0:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    800007c4:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    800007c8:	00008597          	auipc	a1,0x8
    800007cc:	89058593          	add	a1,a1,-1904 # 80008058 <digits+0x18>
    800007d0:	00010517          	auipc	a0,0x10
    800007d4:	42850513          	add	a0,a0,1064 # 80010bf8 <uart_tx_lock>
    800007d8:	00000097          	auipc	ra,0x0
    800007dc:	38c080e7          	jalr	908(ra) # 80000b64 <initlock>
}
    800007e0:	60a2                	ld	ra,8(sp)
    800007e2:	6402                	ld	s0,0(sp)
    800007e4:	0141                	add	sp,sp,16
    800007e6:	8082                	ret

00000000800007e8 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    800007e8:	1101                	add	sp,sp,-32
    800007ea:	ec06                	sd	ra,24(sp)
    800007ec:	e822                	sd	s0,16(sp)
    800007ee:	e426                	sd	s1,8(sp)
    800007f0:	1000                	add	s0,sp,32
    800007f2:	84aa                	mv	s1,a0
  push_off();
    800007f4:	00000097          	auipc	ra,0x0
    800007f8:	3b4080e7          	jalr	948(ra) # 80000ba8 <push_off>

  if(panicked){
    800007fc:	00008797          	auipc	a5,0x8
    80000800:	1b47a783          	lw	a5,436(a5) # 800089b0 <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80000804:	10000737          	lui	a4,0x10000
  if(panicked){
    80000808:	c391                	beqz	a5,8000080c <uartputc_sync+0x24>
    for(;;)
    8000080a:	a001                	j	8000080a <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    8000080c:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80000810:	0207f793          	and	a5,a5,32
    80000814:	dfe5                	beqz	a5,8000080c <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    80000816:	0ff4f513          	zext.b	a0,s1
    8000081a:	100007b7          	lui	a5,0x10000
    8000081e:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    80000822:	00000097          	auipc	ra,0x0
    80000826:	426080e7          	jalr	1062(ra) # 80000c48 <pop_off>
}
    8000082a:	60e2                	ld	ra,24(sp)
    8000082c:	6442                	ld	s0,16(sp)
    8000082e:	64a2                	ld	s1,8(sp)
    80000830:	6105                	add	sp,sp,32
    80000832:	8082                	ret

0000000080000834 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    80000834:	00008797          	auipc	a5,0x8
    80000838:	1847b783          	ld	a5,388(a5) # 800089b8 <uart_tx_r>
    8000083c:	00008717          	auipc	a4,0x8
    80000840:	18473703          	ld	a4,388(a4) # 800089c0 <uart_tx_w>
    80000844:	06f70a63          	beq	a4,a5,800008b8 <uartstart+0x84>
{
    80000848:	7139                	add	sp,sp,-64
    8000084a:	fc06                	sd	ra,56(sp)
    8000084c:	f822                	sd	s0,48(sp)
    8000084e:	f426                	sd	s1,40(sp)
    80000850:	f04a                	sd	s2,32(sp)
    80000852:	ec4e                	sd	s3,24(sp)
    80000854:	e852                	sd	s4,16(sp)
    80000856:	e456                	sd	s5,8(sp)
    80000858:	0080                	add	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    8000085a:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    8000085e:	00010a17          	auipc	s4,0x10
    80000862:	39aa0a13          	add	s4,s4,922 # 80010bf8 <uart_tx_lock>
    uart_tx_r += 1;
    80000866:	00008497          	auipc	s1,0x8
    8000086a:	15248493          	add	s1,s1,338 # 800089b8 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    8000086e:	00008997          	auipc	s3,0x8
    80000872:	15298993          	add	s3,s3,338 # 800089c0 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80000876:	00594703          	lbu	a4,5(s2) # 10000005 <_entry-0x6ffffffb>
    8000087a:	02077713          	and	a4,a4,32
    8000087e:	c705                	beqz	a4,800008a6 <uartstart+0x72>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80000880:	01f7f713          	and	a4,a5,31
    80000884:	9752                	add	a4,a4,s4
    80000886:	01874a83          	lbu	s5,24(a4)
    uart_tx_r += 1;
    8000088a:	0785                	add	a5,a5,1
    8000088c:	e09c                	sd	a5,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    8000088e:	8526                	mv	a0,s1
    80000890:	00002097          	auipc	ra,0x2
    80000894:	86c080e7          	jalr	-1940(ra) # 800020fc <wakeup>
    
    WriteReg(THR, c);
    80000898:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    8000089c:	609c                	ld	a5,0(s1)
    8000089e:	0009b703          	ld	a4,0(s3)
    800008a2:	fcf71ae3          	bne	a4,a5,80000876 <uartstart+0x42>
  }
}
    800008a6:	70e2                	ld	ra,56(sp)
    800008a8:	7442                	ld	s0,48(sp)
    800008aa:	74a2                	ld	s1,40(sp)
    800008ac:	7902                	ld	s2,32(sp)
    800008ae:	69e2                	ld	s3,24(sp)
    800008b0:	6a42                	ld	s4,16(sp)
    800008b2:	6aa2                	ld	s5,8(sp)
    800008b4:	6121                	add	sp,sp,64
    800008b6:	8082                	ret
    800008b8:	8082                	ret

00000000800008ba <uartputc>:
{
    800008ba:	7179                	add	sp,sp,-48
    800008bc:	f406                	sd	ra,40(sp)
    800008be:	f022                	sd	s0,32(sp)
    800008c0:	ec26                	sd	s1,24(sp)
    800008c2:	e84a                	sd	s2,16(sp)
    800008c4:	e44e                	sd	s3,8(sp)
    800008c6:	e052                	sd	s4,0(sp)
    800008c8:	1800                	add	s0,sp,48
    800008ca:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    800008cc:	00010517          	auipc	a0,0x10
    800008d0:	32c50513          	add	a0,a0,812 # 80010bf8 <uart_tx_lock>
    800008d4:	00000097          	auipc	ra,0x0
    800008d8:	320080e7          	jalr	800(ra) # 80000bf4 <acquire>
  if(panicked){
    800008dc:	00008797          	auipc	a5,0x8
    800008e0:	0d47a783          	lw	a5,212(a5) # 800089b0 <panicked>
    800008e4:	e7c9                	bnez	a5,8000096e <uartputc+0xb4>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800008e6:	00008717          	auipc	a4,0x8
    800008ea:	0da73703          	ld	a4,218(a4) # 800089c0 <uart_tx_w>
    800008ee:	00008797          	auipc	a5,0x8
    800008f2:	0ca7b783          	ld	a5,202(a5) # 800089b8 <uart_tx_r>
    800008f6:	02078793          	add	a5,a5,32
    sleep(&uart_tx_r, &uart_tx_lock);
    800008fa:	00010997          	auipc	s3,0x10
    800008fe:	2fe98993          	add	s3,s3,766 # 80010bf8 <uart_tx_lock>
    80000902:	00008497          	auipc	s1,0x8
    80000906:	0b648493          	add	s1,s1,182 # 800089b8 <uart_tx_r>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000090a:	00008917          	auipc	s2,0x8
    8000090e:	0b690913          	add	s2,s2,182 # 800089c0 <uart_tx_w>
    80000912:	00e79f63          	bne	a5,a4,80000930 <uartputc+0x76>
    sleep(&uart_tx_r, &uart_tx_lock);
    80000916:	85ce                	mv	a1,s3
    80000918:	8526                	mv	a0,s1
    8000091a:	00001097          	auipc	ra,0x1
    8000091e:	77e080e7          	jalr	1918(ra) # 80002098 <sleep>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80000922:	00093703          	ld	a4,0(s2)
    80000926:	609c                	ld	a5,0(s1)
    80000928:	02078793          	add	a5,a5,32
    8000092c:	fee785e3          	beq	a5,a4,80000916 <uartputc+0x5c>
  uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80000930:	00010497          	auipc	s1,0x10
    80000934:	2c848493          	add	s1,s1,712 # 80010bf8 <uart_tx_lock>
    80000938:	01f77793          	and	a5,a4,31
    8000093c:	97a6                	add	a5,a5,s1
    8000093e:	01478c23          	sb	s4,24(a5)
  uart_tx_w += 1;
    80000942:	0705                	add	a4,a4,1
    80000944:	00008797          	auipc	a5,0x8
    80000948:	06e7be23          	sd	a4,124(a5) # 800089c0 <uart_tx_w>
  uartstart();
    8000094c:	00000097          	auipc	ra,0x0
    80000950:	ee8080e7          	jalr	-280(ra) # 80000834 <uartstart>
  release(&uart_tx_lock);
    80000954:	8526                	mv	a0,s1
    80000956:	00000097          	auipc	ra,0x0
    8000095a:	352080e7          	jalr	850(ra) # 80000ca8 <release>
}
    8000095e:	70a2                	ld	ra,40(sp)
    80000960:	7402                	ld	s0,32(sp)
    80000962:	64e2                	ld	s1,24(sp)
    80000964:	6942                	ld	s2,16(sp)
    80000966:	69a2                	ld	s3,8(sp)
    80000968:	6a02                	ld	s4,0(sp)
    8000096a:	6145                	add	sp,sp,48
    8000096c:	8082                	ret
    for(;;)
    8000096e:	a001                	j	8000096e <uartputc+0xb4>

0000000080000970 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80000970:	1141                	add	sp,sp,-16
    80000972:	e422                	sd	s0,8(sp)
    80000974:	0800                	add	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80000976:	100007b7          	lui	a5,0x10000
    8000097a:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    8000097e:	8b85                	and	a5,a5,1
    80000980:	cb81                	beqz	a5,80000990 <uartgetc+0x20>
    // input data is ready.
    return ReadReg(RHR);
    80000982:	100007b7          	lui	a5,0x10000
    80000986:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    8000098a:	6422                	ld	s0,8(sp)
    8000098c:	0141                	add	sp,sp,16
    8000098e:	8082                	ret
    return -1;
    80000990:	557d                	li	a0,-1
    80000992:	bfe5                	j	8000098a <uartgetc+0x1a>

0000000080000994 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    80000994:	1101                	add	sp,sp,-32
    80000996:	ec06                	sd	ra,24(sp)
    80000998:	e822                	sd	s0,16(sp)
    8000099a:	e426                	sd	s1,8(sp)
    8000099c:	1000                	add	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    8000099e:	54fd                	li	s1,-1
    800009a0:	a029                	j	800009aa <uartintr+0x16>
      break;
    consoleintr(c);
    800009a2:	00000097          	auipc	ra,0x0
    800009a6:	918080e7          	jalr	-1768(ra) # 800002ba <consoleintr>
    int c = uartgetc();
    800009aa:	00000097          	auipc	ra,0x0
    800009ae:	fc6080e7          	jalr	-58(ra) # 80000970 <uartgetc>
    if(c == -1)
    800009b2:	fe9518e3          	bne	a0,s1,800009a2 <uartintr+0xe>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    800009b6:	00010497          	auipc	s1,0x10
    800009ba:	24248493          	add	s1,s1,578 # 80010bf8 <uart_tx_lock>
    800009be:	8526                	mv	a0,s1
    800009c0:	00000097          	auipc	ra,0x0
    800009c4:	234080e7          	jalr	564(ra) # 80000bf4 <acquire>
  uartstart();
    800009c8:	00000097          	auipc	ra,0x0
    800009cc:	e6c080e7          	jalr	-404(ra) # 80000834 <uartstart>
  release(&uart_tx_lock);
    800009d0:	8526                	mv	a0,s1
    800009d2:	00000097          	auipc	ra,0x0
    800009d6:	2d6080e7          	jalr	726(ra) # 80000ca8 <release>
}
    800009da:	60e2                	ld	ra,24(sp)
    800009dc:	6442                	ld	s0,16(sp)
    800009de:	64a2                	ld	s1,8(sp)
    800009e0:	6105                	add	sp,sp,32
    800009e2:	8082                	ret

00000000800009e4 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    800009e4:	1101                	add	sp,sp,-32
    800009e6:	ec06                	sd	ra,24(sp)
    800009e8:	e822                	sd	s0,16(sp)
    800009ea:	e426                	sd	s1,8(sp)
    800009ec:	e04a                	sd	s2,0(sp)
    800009ee:	1000                	add	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    800009f0:	03451793          	sll	a5,a0,0x34
    800009f4:	ebb9                	bnez	a5,80000a4a <kfree+0x66>
    800009f6:	84aa                	mv	s1,a0
    800009f8:	00021797          	auipc	a5,0x21
    800009fc:	68078793          	add	a5,a5,1664 # 80022078 <end>
    80000a00:	04f56563          	bltu	a0,a5,80000a4a <kfree+0x66>
    80000a04:	47c5                	li	a5,17
    80000a06:	07ee                	sll	a5,a5,0x1b
    80000a08:	04f57163          	bgeu	a0,a5,80000a4a <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000a0c:	6605                	lui	a2,0x1
    80000a0e:	4585                	li	a1,1
    80000a10:	00000097          	auipc	ra,0x0
    80000a14:	2e0080e7          	jalr	736(ra) # 80000cf0 <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000a18:	00010917          	auipc	s2,0x10
    80000a1c:	21890913          	add	s2,s2,536 # 80010c30 <kmem>
    80000a20:	854a                	mv	a0,s2
    80000a22:	00000097          	auipc	ra,0x0
    80000a26:	1d2080e7          	jalr	466(ra) # 80000bf4 <acquire>
  r->next = kmem.freelist;
    80000a2a:	01893783          	ld	a5,24(s2)
    80000a2e:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000a30:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    80000a34:	854a                	mv	a0,s2
    80000a36:	00000097          	auipc	ra,0x0
    80000a3a:	272080e7          	jalr	626(ra) # 80000ca8 <release>
}
    80000a3e:	60e2                	ld	ra,24(sp)
    80000a40:	6442                	ld	s0,16(sp)
    80000a42:	64a2                	ld	s1,8(sp)
    80000a44:	6902                	ld	s2,0(sp)
    80000a46:	6105                	add	sp,sp,32
    80000a48:	8082                	ret
    panic("kfree");
    80000a4a:	00007517          	auipc	a0,0x7
    80000a4e:	61650513          	add	a0,a0,1558 # 80008060 <digits+0x20>
    80000a52:	00000097          	auipc	ra,0x0
    80000a56:	aea080e7          	jalr	-1302(ra) # 8000053c <panic>

0000000080000a5a <freerange>:
{
    80000a5a:	7179                	add	sp,sp,-48
    80000a5c:	f406                	sd	ra,40(sp)
    80000a5e:	f022                	sd	s0,32(sp)
    80000a60:	ec26                	sd	s1,24(sp)
    80000a62:	e84a                	sd	s2,16(sp)
    80000a64:	e44e                	sd	s3,8(sp)
    80000a66:	e052                	sd	s4,0(sp)
    80000a68:	1800                	add	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    80000a6a:	6785                	lui	a5,0x1
    80000a6c:	fff78713          	add	a4,a5,-1 # fff <_entry-0x7ffff001>
    80000a70:	00e504b3          	add	s1,a0,a4
    80000a74:	777d                	lui	a4,0xfffff
    80000a76:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000a78:	94be                	add	s1,s1,a5
    80000a7a:	0095ee63          	bltu	a1,s1,80000a96 <freerange+0x3c>
    80000a7e:	892e                	mv	s2,a1
    kfree(p);
    80000a80:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000a82:	6985                	lui	s3,0x1
    kfree(p);
    80000a84:	01448533          	add	a0,s1,s4
    80000a88:	00000097          	auipc	ra,0x0
    80000a8c:	f5c080e7          	jalr	-164(ra) # 800009e4 <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000a90:	94ce                	add	s1,s1,s3
    80000a92:	fe9979e3          	bgeu	s2,s1,80000a84 <freerange+0x2a>
}
    80000a96:	70a2                	ld	ra,40(sp)
    80000a98:	7402                	ld	s0,32(sp)
    80000a9a:	64e2                	ld	s1,24(sp)
    80000a9c:	6942                	ld	s2,16(sp)
    80000a9e:	69a2                	ld	s3,8(sp)
    80000aa0:	6a02                	ld	s4,0(sp)
    80000aa2:	6145                	add	sp,sp,48
    80000aa4:	8082                	ret

0000000080000aa6 <kinit>:
{
    80000aa6:	1141                	add	sp,sp,-16
    80000aa8:	e406                	sd	ra,8(sp)
    80000aaa:	e022                	sd	s0,0(sp)
    80000aac:	0800                	add	s0,sp,16
  initlock(&kmem.lock, "kmem");
    80000aae:	00007597          	auipc	a1,0x7
    80000ab2:	5ba58593          	add	a1,a1,1466 # 80008068 <digits+0x28>
    80000ab6:	00010517          	auipc	a0,0x10
    80000aba:	17a50513          	add	a0,a0,378 # 80010c30 <kmem>
    80000abe:	00000097          	auipc	ra,0x0
    80000ac2:	0a6080e7          	jalr	166(ra) # 80000b64 <initlock>
  freerange(end, (void*)PHYSTOP);
    80000ac6:	45c5                	li	a1,17
    80000ac8:	05ee                	sll	a1,a1,0x1b
    80000aca:	00021517          	auipc	a0,0x21
    80000ace:	5ae50513          	add	a0,a0,1454 # 80022078 <end>
    80000ad2:	00000097          	auipc	ra,0x0
    80000ad6:	f88080e7          	jalr	-120(ra) # 80000a5a <freerange>
}
    80000ada:	60a2                	ld	ra,8(sp)
    80000adc:	6402                	ld	s0,0(sp)
    80000ade:	0141                	add	sp,sp,16
    80000ae0:	8082                	ret

0000000080000ae2 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000ae2:	1101                	add	sp,sp,-32
    80000ae4:	ec06                	sd	ra,24(sp)
    80000ae6:	e822                	sd	s0,16(sp)
    80000ae8:	e426                	sd	s1,8(sp)
    80000aea:	1000                	add	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000aec:	00010497          	auipc	s1,0x10
    80000af0:	14448493          	add	s1,s1,324 # 80010c30 <kmem>
    80000af4:	8526                	mv	a0,s1
    80000af6:	00000097          	auipc	ra,0x0
    80000afa:	0fe080e7          	jalr	254(ra) # 80000bf4 <acquire>
  r = kmem.freelist;
    80000afe:	6c84                	ld	s1,24(s1)
  if(r)
    80000b00:	c885                	beqz	s1,80000b30 <kalloc+0x4e>
    kmem.freelist = r->next;
    80000b02:	609c                	ld	a5,0(s1)
    80000b04:	00010517          	auipc	a0,0x10
    80000b08:	12c50513          	add	a0,a0,300 # 80010c30 <kmem>
    80000b0c:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000b0e:	00000097          	auipc	ra,0x0
    80000b12:	19a080e7          	jalr	410(ra) # 80000ca8 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    80000b16:	6605                	lui	a2,0x1
    80000b18:	4595                	li	a1,5
    80000b1a:	8526                	mv	a0,s1
    80000b1c:	00000097          	auipc	ra,0x0
    80000b20:	1d4080e7          	jalr	468(ra) # 80000cf0 <memset>
  return (void*)r;
}
    80000b24:	8526                	mv	a0,s1
    80000b26:	60e2                	ld	ra,24(sp)
    80000b28:	6442                	ld	s0,16(sp)
    80000b2a:	64a2                	ld	s1,8(sp)
    80000b2c:	6105                	add	sp,sp,32
    80000b2e:	8082                	ret
  release(&kmem.lock);
    80000b30:	00010517          	auipc	a0,0x10
    80000b34:	10050513          	add	a0,a0,256 # 80010c30 <kmem>
    80000b38:	00000097          	auipc	ra,0x0
    80000b3c:	170080e7          	jalr	368(ra) # 80000ca8 <release>
  if(r)
    80000b40:	b7d5                	j	80000b24 <kalloc+0x42>

0000000080000b42 <get_total_free_pages>:

int
get_total_free_pages(void)
{
    80000b42:	1141                	add	sp,sp,-16
    80000b44:	e422                	sd	s0,8(sp)
    80000b46:	0800                	add	s0,sp,16
  int count = 0;
  struct run *r;
  r = kmem.freelist;
    80000b48:	00010797          	auipc	a5,0x10
    80000b4c:	1007b783          	ld	a5,256(a5) # 80010c48 <kmem+0x18>
  while (r) {
    80000b50:	cb81                	beqz	a5,80000b60 <get_total_free_pages+0x1e>
  int count = 0;
    80000b52:	4501                	li	a0,0
    count++;
    80000b54:	2505                	addw	a0,a0,1
    r = r->next;
    80000b56:	639c                	ld	a5,0(a5)
  while (r) {
    80000b58:	fff5                	bnez	a5,80000b54 <get_total_free_pages+0x12>
  }
  return count;
}
    80000b5a:	6422                	ld	s0,8(sp)
    80000b5c:	0141                	add	sp,sp,16
    80000b5e:	8082                	ret
  int count = 0;
    80000b60:	4501                	li	a0,0
    80000b62:	bfe5                	j	80000b5a <get_total_free_pages+0x18>

0000000080000b64 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80000b64:	1141                	add	sp,sp,-16
    80000b66:	e422                	sd	s0,8(sp)
    80000b68:	0800                	add	s0,sp,16
  lk->name = name;
    80000b6a:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80000b6c:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80000b70:	00053823          	sd	zero,16(a0)
}
    80000b74:	6422                	ld	s0,8(sp)
    80000b76:	0141                	add	sp,sp,16
    80000b78:	8082                	ret

0000000080000b7a <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80000b7a:	411c                	lw	a5,0(a0)
    80000b7c:	e399                	bnez	a5,80000b82 <holding+0x8>
    80000b7e:	4501                	li	a0,0
  return r;
}
    80000b80:	8082                	ret
{
    80000b82:	1101                	add	sp,sp,-32
    80000b84:	ec06                	sd	ra,24(sp)
    80000b86:	e822                	sd	s0,16(sp)
    80000b88:	e426                	sd	s1,8(sp)
    80000b8a:	1000                	add	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80000b8c:	6904                	ld	s1,16(a0)
    80000b8e:	00001097          	auipc	ra,0x1
    80000b92:	e1e080e7          	jalr	-482(ra) # 800019ac <mycpu>
    80000b96:	40a48533          	sub	a0,s1,a0
    80000b9a:	00153513          	seqz	a0,a0
}
    80000b9e:	60e2                	ld	ra,24(sp)
    80000ba0:	6442                	ld	s0,16(sp)
    80000ba2:	64a2                	ld	s1,8(sp)
    80000ba4:	6105                	add	sp,sp,32
    80000ba6:	8082                	ret

0000000080000ba8 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80000ba8:	1101                	add	sp,sp,-32
    80000baa:	ec06                	sd	ra,24(sp)
    80000bac:	e822                	sd	s0,16(sp)
    80000bae:	e426                	sd	s1,8(sp)
    80000bb0:	1000                	add	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000bb2:	100024f3          	csrr	s1,sstatus
    80000bb6:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80000bba:	9bf5                	and	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000bbc:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    80000bc0:	00001097          	auipc	ra,0x1
    80000bc4:	dec080e7          	jalr	-532(ra) # 800019ac <mycpu>
    80000bc8:	5d3c                	lw	a5,120(a0)
    80000bca:	cf89                	beqz	a5,80000be4 <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80000bcc:	00001097          	auipc	ra,0x1
    80000bd0:	de0080e7          	jalr	-544(ra) # 800019ac <mycpu>
    80000bd4:	5d3c                	lw	a5,120(a0)
    80000bd6:	2785                	addw	a5,a5,1
    80000bd8:	dd3c                	sw	a5,120(a0)
}
    80000bda:	60e2                	ld	ra,24(sp)
    80000bdc:	6442                	ld	s0,16(sp)
    80000bde:	64a2                	ld	s1,8(sp)
    80000be0:	6105                	add	sp,sp,32
    80000be2:	8082                	ret
    mycpu()->intena = old;
    80000be4:	00001097          	auipc	ra,0x1
    80000be8:	dc8080e7          	jalr	-568(ra) # 800019ac <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80000bec:	8085                	srl	s1,s1,0x1
    80000bee:	8885                	and	s1,s1,1
    80000bf0:	dd64                	sw	s1,124(a0)
    80000bf2:	bfe9                	j	80000bcc <push_off+0x24>

0000000080000bf4 <acquire>:
{
    80000bf4:	1101                	add	sp,sp,-32
    80000bf6:	ec06                	sd	ra,24(sp)
    80000bf8:	e822                	sd	s0,16(sp)
    80000bfa:	e426                	sd	s1,8(sp)
    80000bfc:	1000                	add	s0,sp,32
    80000bfe:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80000c00:	00000097          	auipc	ra,0x0
    80000c04:	fa8080e7          	jalr	-88(ra) # 80000ba8 <push_off>
  if(holding(lk))
    80000c08:	8526                	mv	a0,s1
    80000c0a:	00000097          	auipc	ra,0x0
    80000c0e:	f70080e7          	jalr	-144(ra) # 80000b7a <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80000c12:	4705                	li	a4,1
  if(holding(lk))
    80000c14:	e115                	bnez	a0,80000c38 <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80000c16:	87ba                	mv	a5,a4
    80000c18:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80000c1c:	2781                	sext.w	a5,a5
    80000c1e:	ffe5                	bnez	a5,80000c16 <acquire+0x22>
  __sync_synchronize();
    80000c20:	0ff0000f          	fence
  lk->cpu = mycpu();
    80000c24:	00001097          	auipc	ra,0x1
    80000c28:	d88080e7          	jalr	-632(ra) # 800019ac <mycpu>
    80000c2c:	e888                	sd	a0,16(s1)
}
    80000c2e:	60e2                	ld	ra,24(sp)
    80000c30:	6442                	ld	s0,16(sp)
    80000c32:	64a2                	ld	s1,8(sp)
    80000c34:	6105                	add	sp,sp,32
    80000c36:	8082                	ret
    panic("acquire");
    80000c38:	00007517          	auipc	a0,0x7
    80000c3c:	43850513          	add	a0,a0,1080 # 80008070 <digits+0x30>
    80000c40:	00000097          	auipc	ra,0x0
    80000c44:	8fc080e7          	jalr	-1796(ra) # 8000053c <panic>

0000000080000c48 <pop_off>:

void
pop_off(void)
{
    80000c48:	1141                	add	sp,sp,-16
    80000c4a:	e406                	sd	ra,8(sp)
    80000c4c:	e022                	sd	s0,0(sp)
    80000c4e:	0800                	add	s0,sp,16
  struct cpu *c = mycpu();
    80000c50:	00001097          	auipc	ra,0x1
    80000c54:	d5c080e7          	jalr	-676(ra) # 800019ac <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000c58:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80000c5c:	8b89                	and	a5,a5,2
  if(intr_get())
    80000c5e:	e78d                	bnez	a5,80000c88 <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80000c60:	5d3c                	lw	a5,120(a0)
    80000c62:	02f05b63          	blez	a5,80000c98 <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    80000c66:	37fd                	addw	a5,a5,-1
    80000c68:	0007871b          	sext.w	a4,a5
    80000c6c:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80000c6e:	eb09                	bnez	a4,80000c80 <pop_off+0x38>
    80000c70:	5d7c                	lw	a5,124(a0)
    80000c72:	c799                	beqz	a5,80000c80 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000c74:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80000c78:	0027e793          	or	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000c7c:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80000c80:	60a2                	ld	ra,8(sp)
    80000c82:	6402                	ld	s0,0(sp)
    80000c84:	0141                	add	sp,sp,16
    80000c86:	8082                	ret
    panic("pop_off - interruptible");
    80000c88:	00007517          	auipc	a0,0x7
    80000c8c:	3f050513          	add	a0,a0,1008 # 80008078 <digits+0x38>
    80000c90:	00000097          	auipc	ra,0x0
    80000c94:	8ac080e7          	jalr	-1876(ra) # 8000053c <panic>
    panic("pop_off");
    80000c98:	00007517          	auipc	a0,0x7
    80000c9c:	3f850513          	add	a0,a0,1016 # 80008090 <digits+0x50>
    80000ca0:	00000097          	auipc	ra,0x0
    80000ca4:	89c080e7          	jalr	-1892(ra) # 8000053c <panic>

0000000080000ca8 <release>:
{
    80000ca8:	1101                	add	sp,sp,-32
    80000caa:	ec06                	sd	ra,24(sp)
    80000cac:	e822                	sd	s0,16(sp)
    80000cae:	e426                	sd	s1,8(sp)
    80000cb0:	1000                	add	s0,sp,32
    80000cb2:	84aa                	mv	s1,a0
  if(!holding(lk))
    80000cb4:	00000097          	auipc	ra,0x0
    80000cb8:	ec6080e7          	jalr	-314(ra) # 80000b7a <holding>
    80000cbc:	c115                	beqz	a0,80000ce0 <release+0x38>
  lk->cpu = 0;
    80000cbe:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80000cc2:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    80000cc6:	0f50000f          	fence	iorw,ow
    80000cca:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    80000cce:	00000097          	auipc	ra,0x0
    80000cd2:	f7a080e7          	jalr	-134(ra) # 80000c48 <pop_off>
}
    80000cd6:	60e2                	ld	ra,24(sp)
    80000cd8:	6442                	ld	s0,16(sp)
    80000cda:	64a2                	ld	s1,8(sp)
    80000cdc:	6105                	add	sp,sp,32
    80000cde:	8082                	ret
    panic("release");
    80000ce0:	00007517          	auipc	a0,0x7
    80000ce4:	3b850513          	add	a0,a0,952 # 80008098 <digits+0x58>
    80000ce8:	00000097          	auipc	ra,0x0
    80000cec:	854080e7          	jalr	-1964(ra) # 8000053c <panic>

0000000080000cf0 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    80000cf0:	1141                	add	sp,sp,-16
    80000cf2:	e422                	sd	s0,8(sp)
    80000cf4:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000cf6:	ca19                	beqz	a2,80000d0c <memset+0x1c>
    80000cf8:	87aa                	mv	a5,a0
    80000cfa:	1602                	sll	a2,a2,0x20
    80000cfc:	9201                	srl	a2,a2,0x20
    80000cfe:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    80000d02:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000d06:	0785                	add	a5,a5,1
    80000d08:	fee79de3          	bne	a5,a4,80000d02 <memset+0x12>
  }
  return dst;
}
    80000d0c:	6422                	ld	s0,8(sp)
    80000d0e:	0141                	add	sp,sp,16
    80000d10:	8082                	ret

0000000080000d12 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    80000d12:	1141                	add	sp,sp,-16
    80000d14:	e422                	sd	s0,8(sp)
    80000d16:	0800                	add	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    80000d18:	ca05                	beqz	a2,80000d48 <memcmp+0x36>
    80000d1a:	fff6069b          	addw	a3,a2,-1 # fff <_entry-0x7ffff001>
    80000d1e:	1682                	sll	a3,a3,0x20
    80000d20:	9281                	srl	a3,a3,0x20
    80000d22:	0685                	add	a3,a3,1
    80000d24:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    80000d26:	00054783          	lbu	a5,0(a0)
    80000d2a:	0005c703          	lbu	a4,0(a1)
    80000d2e:	00e79863          	bne	a5,a4,80000d3e <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    80000d32:	0505                	add	a0,a0,1
    80000d34:	0585                	add	a1,a1,1
  while(n-- > 0){
    80000d36:	fed518e3          	bne	a0,a3,80000d26 <memcmp+0x14>
  }

  return 0;
    80000d3a:	4501                	li	a0,0
    80000d3c:	a019                	j	80000d42 <memcmp+0x30>
      return *s1 - *s2;
    80000d3e:	40e7853b          	subw	a0,a5,a4
}
    80000d42:	6422                	ld	s0,8(sp)
    80000d44:	0141                	add	sp,sp,16
    80000d46:	8082                	ret
  return 0;
    80000d48:	4501                	li	a0,0
    80000d4a:	bfe5                	j	80000d42 <memcmp+0x30>

0000000080000d4c <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    80000d4c:	1141                	add	sp,sp,-16
    80000d4e:	e422                	sd	s0,8(sp)
    80000d50:	0800                	add	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    80000d52:	c205                	beqz	a2,80000d72 <memmove+0x26>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    80000d54:	02a5e263          	bltu	a1,a0,80000d78 <memmove+0x2c>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    80000d58:	1602                	sll	a2,a2,0x20
    80000d5a:	9201                	srl	a2,a2,0x20
    80000d5c:	00c587b3          	add	a5,a1,a2
{
    80000d60:	872a                	mv	a4,a0
      *d++ = *s++;
    80000d62:	0585                	add	a1,a1,1
    80000d64:	0705                	add	a4,a4,1 # fffffffffffff001 <end+0xffffffff7ffdcf89>
    80000d66:	fff5c683          	lbu	a3,-1(a1)
    80000d6a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    80000d6e:	fef59ae3          	bne	a1,a5,80000d62 <memmove+0x16>

  return dst;
}
    80000d72:	6422                	ld	s0,8(sp)
    80000d74:	0141                	add	sp,sp,16
    80000d76:	8082                	ret
  if(s < d && s + n > d){
    80000d78:	02061693          	sll	a3,a2,0x20
    80000d7c:	9281                	srl	a3,a3,0x20
    80000d7e:	00d58733          	add	a4,a1,a3
    80000d82:	fce57be3          	bgeu	a0,a4,80000d58 <memmove+0xc>
    d += n;
    80000d86:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    80000d88:	fff6079b          	addw	a5,a2,-1
    80000d8c:	1782                	sll	a5,a5,0x20
    80000d8e:	9381                	srl	a5,a5,0x20
    80000d90:	fff7c793          	not	a5,a5
    80000d94:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000d96:	177d                	add	a4,a4,-1
    80000d98:	16fd                	add	a3,a3,-1
    80000d9a:	00074603          	lbu	a2,0(a4)
    80000d9e:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    80000da2:	fee79ae3          	bne	a5,a4,80000d96 <memmove+0x4a>
    80000da6:	b7f1                	j	80000d72 <memmove+0x26>

0000000080000da8 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000da8:	1141                	add	sp,sp,-16
    80000daa:	e406                	sd	ra,8(sp)
    80000dac:	e022                	sd	s0,0(sp)
    80000dae:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
    80000db0:	00000097          	auipc	ra,0x0
    80000db4:	f9c080e7          	jalr	-100(ra) # 80000d4c <memmove>
}
    80000db8:	60a2                	ld	ra,8(sp)
    80000dba:	6402                	ld	s0,0(sp)
    80000dbc:	0141                	add	sp,sp,16
    80000dbe:	8082                	ret

0000000080000dc0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000dc0:	1141                	add	sp,sp,-16
    80000dc2:	e422                	sd	s0,8(sp)
    80000dc4:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000dc6:	ce11                	beqz	a2,80000de2 <strncmp+0x22>
    80000dc8:	00054783          	lbu	a5,0(a0)
    80000dcc:	cf89                	beqz	a5,80000de6 <strncmp+0x26>
    80000dce:	0005c703          	lbu	a4,0(a1)
    80000dd2:	00f71a63          	bne	a4,a5,80000de6 <strncmp+0x26>
    n--, p++, q++;
    80000dd6:	367d                	addw	a2,a2,-1
    80000dd8:	0505                	add	a0,a0,1
    80000dda:	0585                	add	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000ddc:	f675                	bnez	a2,80000dc8 <strncmp+0x8>
  if(n == 0)
    return 0;
    80000dde:	4501                	li	a0,0
    80000de0:	a809                	j	80000df2 <strncmp+0x32>
    80000de2:	4501                	li	a0,0
    80000de4:	a039                	j	80000df2 <strncmp+0x32>
  if(n == 0)
    80000de6:	ca09                	beqz	a2,80000df8 <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    80000de8:	00054503          	lbu	a0,0(a0)
    80000dec:	0005c783          	lbu	a5,0(a1)
    80000df0:	9d1d                	subw	a0,a0,a5
}
    80000df2:	6422                	ld	s0,8(sp)
    80000df4:	0141                	add	sp,sp,16
    80000df6:	8082                	ret
    return 0;
    80000df8:	4501                	li	a0,0
    80000dfa:	bfe5                	j	80000df2 <strncmp+0x32>

0000000080000dfc <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000dfc:	1141                	add	sp,sp,-16
    80000dfe:	e422                	sd	s0,8(sp)
    80000e00:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000e02:	87aa                	mv	a5,a0
    80000e04:	86b2                	mv	a3,a2
    80000e06:	367d                	addw	a2,a2,-1
    80000e08:	00d05963          	blez	a3,80000e1a <strncpy+0x1e>
    80000e0c:	0785                	add	a5,a5,1
    80000e0e:	0005c703          	lbu	a4,0(a1)
    80000e12:	fee78fa3          	sb	a4,-1(a5)
    80000e16:	0585                	add	a1,a1,1
    80000e18:	f775                	bnez	a4,80000e04 <strncpy+0x8>
    ;
  while(n-- > 0)
    80000e1a:	873e                	mv	a4,a5
    80000e1c:	9fb5                	addw	a5,a5,a3
    80000e1e:	37fd                	addw	a5,a5,-1
    80000e20:	00c05963          	blez	a2,80000e32 <strncpy+0x36>
    *s++ = 0;
    80000e24:	0705                	add	a4,a4,1
    80000e26:	fe070fa3          	sb	zero,-1(a4)
  while(n-- > 0)
    80000e2a:	40e786bb          	subw	a3,a5,a4
    80000e2e:	fed04be3          	bgtz	a3,80000e24 <strncpy+0x28>
  return os;
}
    80000e32:	6422                	ld	s0,8(sp)
    80000e34:	0141                	add	sp,sp,16
    80000e36:	8082                	ret

0000000080000e38 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    80000e38:	1141                	add	sp,sp,-16
    80000e3a:	e422                	sd	s0,8(sp)
    80000e3c:	0800                	add	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    80000e3e:	02c05363          	blez	a2,80000e64 <safestrcpy+0x2c>
    80000e42:	fff6069b          	addw	a3,a2,-1
    80000e46:	1682                	sll	a3,a3,0x20
    80000e48:	9281                	srl	a3,a3,0x20
    80000e4a:	96ae                	add	a3,a3,a1
    80000e4c:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    80000e4e:	00d58963          	beq	a1,a3,80000e60 <safestrcpy+0x28>
    80000e52:	0585                	add	a1,a1,1
    80000e54:	0785                	add	a5,a5,1
    80000e56:	fff5c703          	lbu	a4,-1(a1)
    80000e5a:	fee78fa3          	sb	a4,-1(a5)
    80000e5e:	fb65                	bnez	a4,80000e4e <safestrcpy+0x16>
    ;
  *s = 0;
    80000e60:	00078023          	sb	zero,0(a5)
  return os;
}
    80000e64:	6422                	ld	s0,8(sp)
    80000e66:	0141                	add	sp,sp,16
    80000e68:	8082                	ret

0000000080000e6a <strlen>:

int
strlen(const char *s)
{
    80000e6a:	1141                	add	sp,sp,-16
    80000e6c:	e422                	sd	s0,8(sp)
    80000e6e:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    80000e70:	00054783          	lbu	a5,0(a0)
    80000e74:	cf91                	beqz	a5,80000e90 <strlen+0x26>
    80000e76:	0505                	add	a0,a0,1
    80000e78:	87aa                	mv	a5,a0
    80000e7a:	86be                	mv	a3,a5
    80000e7c:	0785                	add	a5,a5,1
    80000e7e:	fff7c703          	lbu	a4,-1(a5)
    80000e82:	ff65                	bnez	a4,80000e7a <strlen+0x10>
    80000e84:	40a6853b          	subw	a0,a3,a0
    80000e88:	2505                	addw	a0,a0,1
    ;
  return n;
}
    80000e8a:	6422                	ld	s0,8(sp)
    80000e8c:	0141                	add	sp,sp,16
    80000e8e:	8082                	ret
  for(n = 0; s[n]; n++)
    80000e90:	4501                	li	a0,0
    80000e92:	bfe5                	j	80000e8a <strlen+0x20>

0000000080000e94 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000e94:	1141                	add	sp,sp,-16
    80000e96:	e406                	sd	ra,8(sp)
    80000e98:	e022                	sd	s0,0(sp)
    80000e9a:	0800                	add	s0,sp,16
  if(cpuid() == 0){
    80000e9c:	00001097          	auipc	ra,0x1
    80000ea0:	b00080e7          	jalr	-1280(ra) # 8000199c <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000ea4:	00008717          	auipc	a4,0x8
    80000ea8:	b2470713          	add	a4,a4,-1244 # 800089c8 <started>
  if(cpuid() == 0){
    80000eac:	c139                	beqz	a0,80000ef2 <main+0x5e>
    while(started == 0)
    80000eae:	431c                	lw	a5,0(a4)
    80000eb0:	2781                	sext.w	a5,a5
    80000eb2:	dff5                	beqz	a5,80000eae <main+0x1a>
      ;
    __sync_synchronize();
    80000eb4:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    80000eb8:	00001097          	auipc	ra,0x1
    80000ebc:	ae4080e7          	jalr	-1308(ra) # 8000199c <cpuid>
    80000ec0:	85aa                	mv	a1,a0
    80000ec2:	00007517          	auipc	a0,0x7
    80000ec6:	1f650513          	add	a0,a0,502 # 800080b8 <digits+0x78>
    80000eca:	fffff097          	auipc	ra,0xfffff
    80000ece:	6bc080e7          	jalr	1724(ra) # 80000586 <printf>
    kvminithart();    // turn on paging
    80000ed2:	00000097          	auipc	ra,0x0
    80000ed6:	0d8080e7          	jalr	216(ra) # 80000faa <kvminithart>
    trapinithart();   // install kernel trap vector
    80000eda:	00002097          	auipc	ra,0x2
    80000ede:	b18080e7          	jalr	-1256(ra) # 800029f2 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000ee2:	00005097          	auipc	ra,0x5
    80000ee6:	2be080e7          	jalr	702(ra) # 800061a0 <plicinithart>
  }

  scheduler();        
    80000eea:	00001097          	auipc	ra,0x1
    80000eee:	fda080e7          	jalr	-38(ra) # 80001ec4 <scheduler>
    consoleinit();
    80000ef2:	fffff097          	auipc	ra,0xfffff
    80000ef6:	55a080e7          	jalr	1370(ra) # 8000044c <consoleinit>
    printfinit();
    80000efa:	00000097          	auipc	ra,0x0
    80000efe:	86c080e7          	jalr	-1940(ra) # 80000766 <printfinit>
    printf("\n");
    80000f02:	00007517          	auipc	a0,0x7
    80000f06:	1c650513          	add	a0,a0,454 # 800080c8 <digits+0x88>
    80000f0a:	fffff097          	auipc	ra,0xfffff
    80000f0e:	67c080e7          	jalr	1660(ra) # 80000586 <printf>
    printf("xv6 kernel is booting\n");
    80000f12:	00007517          	auipc	a0,0x7
    80000f16:	18e50513          	add	a0,a0,398 # 800080a0 <digits+0x60>
    80000f1a:	fffff097          	auipc	ra,0xfffff
    80000f1e:	66c080e7          	jalr	1644(ra) # 80000586 <printf>
    printf("\n");
    80000f22:	00007517          	auipc	a0,0x7
    80000f26:	1a650513          	add	a0,a0,422 # 800080c8 <digits+0x88>
    80000f2a:	fffff097          	auipc	ra,0xfffff
    80000f2e:	65c080e7          	jalr	1628(ra) # 80000586 <printf>
    kinit();         // physical page allocator
    80000f32:	00000097          	auipc	ra,0x0
    80000f36:	b74080e7          	jalr	-1164(ra) # 80000aa6 <kinit>
    kvminit();       // create kernel page table
    80000f3a:	00000097          	auipc	ra,0x0
    80000f3e:	326080e7          	jalr	806(ra) # 80001260 <kvminit>
    kvminithart();   // turn on paging
    80000f42:	00000097          	auipc	ra,0x0
    80000f46:	068080e7          	jalr	104(ra) # 80000faa <kvminithart>
    procinit();      // process table
    80000f4a:	00001097          	auipc	ra,0x1
    80000f4e:	99e080e7          	jalr	-1634(ra) # 800018e8 <procinit>
    trapinit();      // trap vectors
    80000f52:	00002097          	auipc	ra,0x2
    80000f56:	a78080e7          	jalr	-1416(ra) # 800029ca <trapinit>
    trapinithart();  // install kernel trap vector
    80000f5a:	00002097          	auipc	ra,0x2
    80000f5e:	a98080e7          	jalr	-1384(ra) # 800029f2 <trapinithart>
    plicinit();      // set up interrupt controller
    80000f62:	00005097          	auipc	ra,0x5
    80000f66:	228080e7          	jalr	552(ra) # 8000618a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80000f6a:	00005097          	auipc	ra,0x5
    80000f6e:	236080e7          	jalr	566(ra) # 800061a0 <plicinithart>
    binit();         // buffer cache
    80000f72:	00002097          	auipc	ra,0x2
    80000f76:	430080e7          	jalr	1072(ra) # 800033a2 <binit>
    iinit();         // inode table
    80000f7a:	00003097          	auipc	ra,0x3
    80000f7e:	ace080e7          	jalr	-1330(ra) # 80003a48 <iinit>
    fileinit();      // file table
    80000f82:	00004097          	auipc	ra,0x4
    80000f86:	a44080e7          	jalr	-1468(ra) # 800049c6 <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000f8a:	00005097          	auipc	ra,0x5
    80000f8e:	31e080e7          	jalr	798(ra) # 800062a8 <virtio_disk_init>
    userinit();      // first user process
    80000f92:	00001097          	auipc	ra,0x1
    80000f96:	d14080e7          	jalr	-748(ra) # 80001ca6 <userinit>
    __sync_synchronize();
    80000f9a:	0ff0000f          	fence
    started = 1;
    80000f9e:	4785                	li	a5,1
    80000fa0:	00008717          	auipc	a4,0x8
    80000fa4:	a2f72423          	sw	a5,-1496(a4) # 800089c8 <started>
    80000fa8:	b789                	j	80000eea <main+0x56>

0000000080000faa <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80000faa:	1141                	add	sp,sp,-16
    80000fac:	e422                	sd	s0,8(sp)
    80000fae:	0800                	add	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80000fb0:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    80000fb4:	00008797          	auipc	a5,0x8
    80000fb8:	a1c7b783          	ld	a5,-1508(a5) # 800089d0 <kernel_pagetable>
    80000fbc:	83b1                	srl	a5,a5,0xc
    80000fbe:	577d                	li	a4,-1
    80000fc0:	177e                	sll	a4,a4,0x3f
    80000fc2:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    80000fc4:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    80000fc8:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    80000fcc:	6422                	ld	s0,8(sp)
    80000fce:	0141                	add	sp,sp,16
    80000fd0:	8082                	ret

0000000080000fd2 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80000fd2:	7139                	add	sp,sp,-64
    80000fd4:	fc06                	sd	ra,56(sp)
    80000fd6:	f822                	sd	s0,48(sp)
    80000fd8:	f426                	sd	s1,40(sp)
    80000fda:	f04a                	sd	s2,32(sp)
    80000fdc:	ec4e                	sd	s3,24(sp)
    80000fde:	e852                	sd	s4,16(sp)
    80000fe0:	e456                	sd	s5,8(sp)
    80000fe2:	e05a                	sd	s6,0(sp)
    80000fe4:	0080                	add	s0,sp,64
    80000fe6:	84aa                	mv	s1,a0
    80000fe8:	89ae                	mv	s3,a1
    80000fea:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    80000fec:	57fd                	li	a5,-1
    80000fee:	83e9                	srl	a5,a5,0x1a
    80000ff0:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80000ff2:	4b31                	li	s6,12
  if(va >= MAXVA)
    80000ff4:	04b7f263          	bgeu	a5,a1,80001038 <walk+0x66>
    panic("walk");
    80000ff8:	00007517          	auipc	a0,0x7
    80000ffc:	0d850513          	add	a0,a0,216 # 800080d0 <digits+0x90>
    80001000:	fffff097          	auipc	ra,0xfffff
    80001004:	53c080e7          	jalr	1340(ra) # 8000053c <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80001008:	060a8663          	beqz	s5,80001074 <walk+0xa2>
    8000100c:	00000097          	auipc	ra,0x0
    80001010:	ad6080e7          	jalr	-1322(ra) # 80000ae2 <kalloc>
    80001014:	84aa                	mv	s1,a0
    80001016:	c529                	beqz	a0,80001060 <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    80001018:	6605                	lui	a2,0x1
    8000101a:	4581                	li	a1,0
    8000101c:	00000097          	auipc	ra,0x0
    80001020:	cd4080e7          	jalr	-812(ra) # 80000cf0 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80001024:	00c4d793          	srl	a5,s1,0xc
    80001028:	07aa                	sll	a5,a5,0xa
    8000102a:	0017e793          	or	a5,a5,1
    8000102e:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    80001032:	3a5d                	addw	s4,s4,-9 # ffffffffffffeff7 <end+0xffffffff7ffdcf7f>
    80001034:	036a0063          	beq	s4,s6,80001054 <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    80001038:	0149d933          	srl	s2,s3,s4
    8000103c:	1ff97913          	and	s2,s2,511
    80001040:	090e                	sll	s2,s2,0x3
    80001042:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    80001044:	00093483          	ld	s1,0(s2)
    80001048:	0014f793          	and	a5,s1,1
    8000104c:	dfd5                	beqz	a5,80001008 <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    8000104e:	80a9                	srl	s1,s1,0xa
    80001050:	04b2                	sll	s1,s1,0xc
    80001052:	b7c5                	j	80001032 <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    80001054:	00c9d513          	srl	a0,s3,0xc
    80001058:	1ff57513          	and	a0,a0,511
    8000105c:	050e                	sll	a0,a0,0x3
    8000105e:	9526                	add	a0,a0,s1
}
    80001060:	70e2                	ld	ra,56(sp)
    80001062:	7442                	ld	s0,48(sp)
    80001064:	74a2                	ld	s1,40(sp)
    80001066:	7902                	ld	s2,32(sp)
    80001068:	69e2                	ld	s3,24(sp)
    8000106a:	6a42                	ld	s4,16(sp)
    8000106c:	6aa2                	ld	s5,8(sp)
    8000106e:	6b02                	ld	s6,0(sp)
    80001070:	6121                	add	sp,sp,64
    80001072:	8082                	ret
        return 0;
    80001074:	4501                	li	a0,0
    80001076:	b7ed                	j	80001060 <walk+0x8e>

0000000080001078 <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80001078:	57fd                	li	a5,-1
    8000107a:	83e9                	srl	a5,a5,0x1a
    8000107c:	00b7f463          	bgeu	a5,a1,80001084 <walkaddr+0xc>
    return 0;
    80001080:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80001082:	8082                	ret
{
    80001084:	1141                	add	sp,sp,-16
    80001086:	e406                	sd	ra,8(sp)
    80001088:	e022                	sd	s0,0(sp)
    8000108a:	0800                	add	s0,sp,16
  pte = walk(pagetable, va, 0);
    8000108c:	4601                	li	a2,0
    8000108e:	00000097          	auipc	ra,0x0
    80001092:	f44080e7          	jalr	-188(ra) # 80000fd2 <walk>
  if(pte == 0)
    80001096:	c105                	beqz	a0,800010b6 <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    80001098:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    8000109a:	0117f693          	and	a3,a5,17
    8000109e:	4745                	li	a4,17
    return 0;
    800010a0:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    800010a2:	00e68663          	beq	a3,a4,800010ae <walkaddr+0x36>
}
    800010a6:	60a2                	ld	ra,8(sp)
    800010a8:	6402                	ld	s0,0(sp)
    800010aa:	0141                	add	sp,sp,16
    800010ac:	8082                	ret
  pa = PTE2PA(*pte);
    800010ae:	83a9                	srl	a5,a5,0xa
    800010b0:	00c79513          	sll	a0,a5,0xc
  return pa;
    800010b4:	bfcd                	j	800010a6 <walkaddr+0x2e>
    return 0;
    800010b6:	4501                	li	a0,0
    800010b8:	b7fd                	j	800010a6 <walkaddr+0x2e>

00000000800010ba <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    800010ba:	715d                	add	sp,sp,-80
    800010bc:	e486                	sd	ra,72(sp)
    800010be:	e0a2                	sd	s0,64(sp)
    800010c0:	fc26                	sd	s1,56(sp)
    800010c2:	f84a                	sd	s2,48(sp)
    800010c4:	f44e                	sd	s3,40(sp)
    800010c6:	f052                	sd	s4,32(sp)
    800010c8:	ec56                	sd	s5,24(sp)
    800010ca:	e85a                	sd	s6,16(sp)
    800010cc:	e45e                	sd	s7,8(sp)
    800010ce:	0880                	add	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    800010d0:	c639                	beqz	a2,8000111e <mappages+0x64>
    800010d2:	8aaa                	mv	s5,a0
    800010d4:	8b3a                	mv	s6,a4
    panic("mappages: size");
  
  a = PGROUNDDOWN(va);
    800010d6:	777d                	lui	a4,0xfffff
    800010d8:	00e5f7b3          	and	a5,a1,a4
  last = PGROUNDDOWN(va + size - 1);
    800010dc:	fff58993          	add	s3,a1,-1
    800010e0:	99b2                	add	s3,s3,a2
    800010e2:	00e9f9b3          	and	s3,s3,a4
  a = PGROUNDDOWN(va);
    800010e6:	893e                	mv	s2,a5
    800010e8:	40f68a33          	sub	s4,a3,a5
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    800010ec:	6b85                	lui	s7,0x1
    800010ee:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    800010f2:	4605                	li	a2,1
    800010f4:	85ca                	mv	a1,s2
    800010f6:	8556                	mv	a0,s5
    800010f8:	00000097          	auipc	ra,0x0
    800010fc:	eda080e7          	jalr	-294(ra) # 80000fd2 <walk>
    80001100:	cd1d                	beqz	a0,8000113e <mappages+0x84>
    if(*pte & PTE_V)
    80001102:	611c                	ld	a5,0(a0)
    80001104:	8b85                	and	a5,a5,1
    80001106:	e785                	bnez	a5,8000112e <mappages+0x74>
    *pte = PA2PTE(pa) | perm | PTE_V;
    80001108:	80b1                	srl	s1,s1,0xc
    8000110a:	04aa                	sll	s1,s1,0xa
    8000110c:	0164e4b3          	or	s1,s1,s6
    80001110:	0014e493          	or	s1,s1,1
    80001114:	e104                	sd	s1,0(a0)
    if(a == last)
    80001116:	05390063          	beq	s2,s3,80001156 <mappages+0x9c>
    a += PGSIZE;
    8000111a:	995e                	add	s2,s2,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    8000111c:	bfc9                	j	800010ee <mappages+0x34>
    panic("mappages: size");
    8000111e:	00007517          	auipc	a0,0x7
    80001122:	fba50513          	add	a0,a0,-70 # 800080d8 <digits+0x98>
    80001126:	fffff097          	auipc	ra,0xfffff
    8000112a:	416080e7          	jalr	1046(ra) # 8000053c <panic>
      panic("mappages: remap");
    8000112e:	00007517          	auipc	a0,0x7
    80001132:	fba50513          	add	a0,a0,-70 # 800080e8 <digits+0xa8>
    80001136:	fffff097          	auipc	ra,0xfffff
    8000113a:	406080e7          	jalr	1030(ra) # 8000053c <panic>
      return -1;
    8000113e:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    80001140:	60a6                	ld	ra,72(sp)
    80001142:	6406                	ld	s0,64(sp)
    80001144:	74e2                	ld	s1,56(sp)
    80001146:	7942                	ld	s2,48(sp)
    80001148:	79a2                	ld	s3,40(sp)
    8000114a:	7a02                	ld	s4,32(sp)
    8000114c:	6ae2                	ld	s5,24(sp)
    8000114e:	6b42                	ld	s6,16(sp)
    80001150:	6ba2                	ld	s7,8(sp)
    80001152:	6161                	add	sp,sp,80
    80001154:	8082                	ret
  return 0;
    80001156:	4501                	li	a0,0
    80001158:	b7e5                	j	80001140 <mappages+0x86>

000000008000115a <kvmmap>:
{
    8000115a:	1141                	add	sp,sp,-16
    8000115c:	e406                	sd	ra,8(sp)
    8000115e:	e022                	sd	s0,0(sp)
    80001160:	0800                	add	s0,sp,16
    80001162:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80001164:	86b2                	mv	a3,a2
    80001166:	863e                	mv	a2,a5
    80001168:	00000097          	auipc	ra,0x0
    8000116c:	f52080e7          	jalr	-174(ra) # 800010ba <mappages>
    80001170:	e509                	bnez	a0,8000117a <kvmmap+0x20>
}
    80001172:	60a2                	ld	ra,8(sp)
    80001174:	6402                	ld	s0,0(sp)
    80001176:	0141                	add	sp,sp,16
    80001178:	8082                	ret
    panic("kvmmap");
    8000117a:	00007517          	auipc	a0,0x7
    8000117e:	f7e50513          	add	a0,a0,-130 # 800080f8 <digits+0xb8>
    80001182:	fffff097          	auipc	ra,0xfffff
    80001186:	3ba080e7          	jalr	954(ra) # 8000053c <panic>

000000008000118a <kvmmake>:
{
    8000118a:	1101                	add	sp,sp,-32
    8000118c:	ec06                	sd	ra,24(sp)
    8000118e:	e822                	sd	s0,16(sp)
    80001190:	e426                	sd	s1,8(sp)
    80001192:	e04a                	sd	s2,0(sp)
    80001194:	1000                	add	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    80001196:	00000097          	auipc	ra,0x0
    8000119a:	94c080e7          	jalr	-1716(ra) # 80000ae2 <kalloc>
    8000119e:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    800011a0:	6605                	lui	a2,0x1
    800011a2:	4581                	li	a1,0
    800011a4:	00000097          	auipc	ra,0x0
    800011a8:	b4c080e7          	jalr	-1204(ra) # 80000cf0 <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    800011ac:	4719                	li	a4,6
    800011ae:	6685                	lui	a3,0x1
    800011b0:	10000637          	lui	a2,0x10000
    800011b4:	100005b7          	lui	a1,0x10000
    800011b8:	8526                	mv	a0,s1
    800011ba:	00000097          	auipc	ra,0x0
    800011be:	fa0080e7          	jalr	-96(ra) # 8000115a <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    800011c2:	4719                	li	a4,6
    800011c4:	6685                	lui	a3,0x1
    800011c6:	10001637          	lui	a2,0x10001
    800011ca:	100015b7          	lui	a1,0x10001
    800011ce:	8526                	mv	a0,s1
    800011d0:	00000097          	auipc	ra,0x0
    800011d4:	f8a080e7          	jalr	-118(ra) # 8000115a <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    800011d8:	4719                	li	a4,6
    800011da:	004006b7          	lui	a3,0x400
    800011de:	0c000637          	lui	a2,0xc000
    800011e2:	0c0005b7          	lui	a1,0xc000
    800011e6:	8526                	mv	a0,s1
    800011e8:	00000097          	auipc	ra,0x0
    800011ec:	f72080e7          	jalr	-142(ra) # 8000115a <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800011f0:	00007917          	auipc	s2,0x7
    800011f4:	e1090913          	add	s2,s2,-496 # 80008000 <etext>
    800011f8:	4729                	li	a4,10
    800011fa:	80007697          	auipc	a3,0x80007
    800011fe:	e0668693          	add	a3,a3,-506 # 8000 <_entry-0x7fff8000>
    80001202:	4605                	li	a2,1
    80001204:	067e                	sll	a2,a2,0x1f
    80001206:	85b2                	mv	a1,a2
    80001208:	8526                	mv	a0,s1
    8000120a:	00000097          	auipc	ra,0x0
    8000120e:	f50080e7          	jalr	-176(ra) # 8000115a <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    80001212:	4719                	li	a4,6
    80001214:	46c5                	li	a3,17
    80001216:	06ee                	sll	a3,a3,0x1b
    80001218:	412686b3          	sub	a3,a3,s2
    8000121c:	864a                	mv	a2,s2
    8000121e:	85ca                	mv	a1,s2
    80001220:	8526                	mv	a0,s1
    80001222:	00000097          	auipc	ra,0x0
    80001226:	f38080e7          	jalr	-200(ra) # 8000115a <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    8000122a:	4729                	li	a4,10
    8000122c:	6685                	lui	a3,0x1
    8000122e:	00006617          	auipc	a2,0x6
    80001232:	dd260613          	add	a2,a2,-558 # 80007000 <_trampoline>
    80001236:	040005b7          	lui	a1,0x4000
    8000123a:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    8000123c:	05b2                	sll	a1,a1,0xc
    8000123e:	8526                	mv	a0,s1
    80001240:	00000097          	auipc	ra,0x0
    80001244:	f1a080e7          	jalr	-230(ra) # 8000115a <kvmmap>
  proc_mapstacks(kpgtbl);
    80001248:	8526                	mv	a0,s1
    8000124a:	00000097          	auipc	ra,0x0
    8000124e:	608080e7          	jalr	1544(ra) # 80001852 <proc_mapstacks>
}
    80001252:	8526                	mv	a0,s1
    80001254:	60e2                	ld	ra,24(sp)
    80001256:	6442                	ld	s0,16(sp)
    80001258:	64a2                	ld	s1,8(sp)
    8000125a:	6902                	ld	s2,0(sp)
    8000125c:	6105                	add	sp,sp,32
    8000125e:	8082                	ret

0000000080001260 <kvminit>:
{
    80001260:	1141                	add	sp,sp,-16
    80001262:	e406                	sd	ra,8(sp)
    80001264:	e022                	sd	s0,0(sp)
    80001266:	0800                	add	s0,sp,16
  kernel_pagetable = kvmmake();
    80001268:	00000097          	auipc	ra,0x0
    8000126c:	f22080e7          	jalr	-222(ra) # 8000118a <kvmmake>
    80001270:	00007797          	auipc	a5,0x7
    80001274:	76a7b023          	sd	a0,1888(a5) # 800089d0 <kernel_pagetable>
}
    80001278:	60a2                	ld	ra,8(sp)
    8000127a:	6402                	ld	s0,0(sp)
    8000127c:	0141                	add	sp,sp,16
    8000127e:	8082                	ret

0000000080001280 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80001280:	715d                	add	sp,sp,-80
    80001282:	e486                	sd	ra,72(sp)
    80001284:	e0a2                	sd	s0,64(sp)
    80001286:	fc26                	sd	s1,56(sp)
    80001288:	f84a                	sd	s2,48(sp)
    8000128a:	f44e                	sd	s3,40(sp)
    8000128c:	f052                	sd	s4,32(sp)
    8000128e:	ec56                	sd	s5,24(sp)
    80001290:	e85a                	sd	s6,16(sp)
    80001292:	e45e                	sd	s7,8(sp)
    80001294:	0880                	add	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80001296:	03459793          	sll	a5,a1,0x34
    8000129a:	e795                	bnez	a5,800012c6 <uvmunmap+0x46>
    8000129c:	8a2a                	mv	s4,a0
    8000129e:	892e                	mv	s2,a1
    800012a0:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800012a2:	0632                	sll	a2,a2,0xc
    800012a4:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    800012a8:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800012aa:	6b05                	lui	s6,0x1
    800012ac:	0735e263          	bltu	a1,s3,80001310 <uvmunmap+0x90>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    800012b0:	60a6                	ld	ra,72(sp)
    800012b2:	6406                	ld	s0,64(sp)
    800012b4:	74e2                	ld	s1,56(sp)
    800012b6:	7942                	ld	s2,48(sp)
    800012b8:	79a2                	ld	s3,40(sp)
    800012ba:	7a02                	ld	s4,32(sp)
    800012bc:	6ae2                	ld	s5,24(sp)
    800012be:	6b42                	ld	s6,16(sp)
    800012c0:	6ba2                	ld	s7,8(sp)
    800012c2:	6161                	add	sp,sp,80
    800012c4:	8082                	ret
    panic("uvmunmap: not aligned");
    800012c6:	00007517          	auipc	a0,0x7
    800012ca:	e3a50513          	add	a0,a0,-454 # 80008100 <digits+0xc0>
    800012ce:	fffff097          	auipc	ra,0xfffff
    800012d2:	26e080e7          	jalr	622(ra) # 8000053c <panic>
      panic("uvmunmap: walk");
    800012d6:	00007517          	auipc	a0,0x7
    800012da:	e4250513          	add	a0,a0,-446 # 80008118 <digits+0xd8>
    800012de:	fffff097          	auipc	ra,0xfffff
    800012e2:	25e080e7          	jalr	606(ra) # 8000053c <panic>
      panic("uvmunmap: not mapped");
    800012e6:	00007517          	auipc	a0,0x7
    800012ea:	e4250513          	add	a0,a0,-446 # 80008128 <digits+0xe8>
    800012ee:	fffff097          	auipc	ra,0xfffff
    800012f2:	24e080e7          	jalr	590(ra) # 8000053c <panic>
      panic("uvmunmap: not a leaf");
    800012f6:	00007517          	auipc	a0,0x7
    800012fa:	e4a50513          	add	a0,a0,-438 # 80008140 <digits+0x100>
    800012fe:	fffff097          	auipc	ra,0xfffff
    80001302:	23e080e7          	jalr	574(ra) # 8000053c <panic>
    *pte = 0;
    80001306:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    8000130a:	995a                	add	s2,s2,s6
    8000130c:	fb3972e3          	bgeu	s2,s3,800012b0 <uvmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    80001310:	4601                	li	a2,0
    80001312:	85ca                	mv	a1,s2
    80001314:	8552                	mv	a0,s4
    80001316:	00000097          	auipc	ra,0x0
    8000131a:	cbc080e7          	jalr	-836(ra) # 80000fd2 <walk>
    8000131e:	84aa                	mv	s1,a0
    80001320:	d95d                	beqz	a0,800012d6 <uvmunmap+0x56>
    if((*pte & PTE_V) == 0)
    80001322:	6108                	ld	a0,0(a0)
    80001324:	00157793          	and	a5,a0,1
    80001328:	dfdd                	beqz	a5,800012e6 <uvmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V)
    8000132a:	3ff57793          	and	a5,a0,1023
    8000132e:	fd7784e3          	beq	a5,s7,800012f6 <uvmunmap+0x76>
    if(do_free){
    80001332:	fc0a8ae3          	beqz	s5,80001306 <uvmunmap+0x86>
      uint64 pa = PTE2PA(*pte);
    80001336:	8129                	srl	a0,a0,0xa
      kfree((void*)pa);
    80001338:	0532                	sll	a0,a0,0xc
    8000133a:	fffff097          	auipc	ra,0xfffff
    8000133e:	6aa080e7          	jalr	1706(ra) # 800009e4 <kfree>
    80001342:	b7d1                	j	80001306 <uvmunmap+0x86>

0000000080001344 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80001344:	1101                	add	sp,sp,-32
    80001346:	ec06                	sd	ra,24(sp)
    80001348:	e822                	sd	s0,16(sp)
    8000134a:	e426                	sd	s1,8(sp)
    8000134c:	1000                	add	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    8000134e:	fffff097          	auipc	ra,0xfffff
    80001352:	794080e7          	jalr	1940(ra) # 80000ae2 <kalloc>
    80001356:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80001358:	c519                	beqz	a0,80001366 <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    8000135a:	6605                	lui	a2,0x1
    8000135c:	4581                	li	a1,0
    8000135e:	00000097          	auipc	ra,0x0
    80001362:	992080e7          	jalr	-1646(ra) # 80000cf0 <memset>
  return pagetable;
}
    80001366:	8526                	mv	a0,s1
    80001368:	60e2                	ld	ra,24(sp)
    8000136a:	6442                	ld	s0,16(sp)
    8000136c:	64a2                	ld	s1,8(sp)
    8000136e:	6105                	add	sp,sp,32
    80001370:	8082                	ret

0000000080001372 <uvmfirst>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvmfirst(pagetable_t pagetable, uchar *src, uint sz)
{
    80001372:	7179                	add	sp,sp,-48
    80001374:	f406                	sd	ra,40(sp)
    80001376:	f022                	sd	s0,32(sp)
    80001378:	ec26                	sd	s1,24(sp)
    8000137a:	e84a                	sd	s2,16(sp)
    8000137c:	e44e                	sd	s3,8(sp)
    8000137e:	e052                	sd	s4,0(sp)
    80001380:	1800                	add	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    80001382:	6785                	lui	a5,0x1
    80001384:	04f67863          	bgeu	a2,a5,800013d4 <uvmfirst+0x62>
    80001388:	8a2a                	mv	s4,a0
    8000138a:	89ae                	mv	s3,a1
    8000138c:	84b2                	mv	s1,a2
    panic("uvmfirst: more than a page");
  mem = kalloc();
    8000138e:	fffff097          	auipc	ra,0xfffff
    80001392:	754080e7          	jalr	1876(ra) # 80000ae2 <kalloc>
    80001396:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    80001398:	6605                	lui	a2,0x1
    8000139a:	4581                	li	a1,0
    8000139c:	00000097          	auipc	ra,0x0
    800013a0:	954080e7          	jalr	-1708(ra) # 80000cf0 <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    800013a4:	4779                	li	a4,30
    800013a6:	86ca                	mv	a3,s2
    800013a8:	6605                	lui	a2,0x1
    800013aa:	4581                	li	a1,0
    800013ac:	8552                	mv	a0,s4
    800013ae:	00000097          	auipc	ra,0x0
    800013b2:	d0c080e7          	jalr	-756(ra) # 800010ba <mappages>
  memmove(mem, src, sz);
    800013b6:	8626                	mv	a2,s1
    800013b8:	85ce                	mv	a1,s3
    800013ba:	854a                	mv	a0,s2
    800013bc:	00000097          	auipc	ra,0x0
    800013c0:	990080e7          	jalr	-1648(ra) # 80000d4c <memmove>
}
    800013c4:	70a2                	ld	ra,40(sp)
    800013c6:	7402                	ld	s0,32(sp)
    800013c8:	64e2                	ld	s1,24(sp)
    800013ca:	6942                	ld	s2,16(sp)
    800013cc:	69a2                	ld	s3,8(sp)
    800013ce:	6a02                	ld	s4,0(sp)
    800013d0:	6145                	add	sp,sp,48
    800013d2:	8082                	ret
    panic("uvmfirst: more than a page");
    800013d4:	00007517          	auipc	a0,0x7
    800013d8:	d8450513          	add	a0,a0,-636 # 80008158 <digits+0x118>
    800013dc:	fffff097          	auipc	ra,0xfffff
    800013e0:	160080e7          	jalr	352(ra) # 8000053c <panic>

00000000800013e4 <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    800013e4:	1101                	add	sp,sp,-32
    800013e6:	ec06                	sd	ra,24(sp)
    800013e8:	e822                	sd	s0,16(sp)
    800013ea:	e426                	sd	s1,8(sp)
    800013ec:	1000                	add	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    800013ee:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    800013f0:	00b67d63          	bgeu	a2,a1,8000140a <uvmdealloc+0x26>
    800013f4:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    800013f6:	6785                	lui	a5,0x1
    800013f8:	17fd                	add	a5,a5,-1 # fff <_entry-0x7ffff001>
    800013fa:	00f60733          	add	a4,a2,a5
    800013fe:	76fd                	lui	a3,0xfffff
    80001400:	8f75                	and	a4,a4,a3
    80001402:	97ae                	add	a5,a5,a1
    80001404:	8ff5                	and	a5,a5,a3
    80001406:	00f76863          	bltu	a4,a5,80001416 <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    8000140a:	8526                	mv	a0,s1
    8000140c:	60e2                	ld	ra,24(sp)
    8000140e:	6442                	ld	s0,16(sp)
    80001410:	64a2                	ld	s1,8(sp)
    80001412:	6105                	add	sp,sp,32
    80001414:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80001416:	8f99                	sub	a5,a5,a4
    80001418:	83b1                	srl	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    8000141a:	4685                	li	a3,1
    8000141c:	0007861b          	sext.w	a2,a5
    80001420:	85ba                	mv	a1,a4
    80001422:	00000097          	auipc	ra,0x0
    80001426:	e5e080e7          	jalr	-418(ra) # 80001280 <uvmunmap>
    8000142a:	b7c5                	j	8000140a <uvmdealloc+0x26>

000000008000142c <uvmalloc>:
  if(newsz < oldsz)
    8000142c:	0ab66563          	bltu	a2,a1,800014d6 <uvmalloc+0xaa>
{
    80001430:	7139                	add	sp,sp,-64
    80001432:	fc06                	sd	ra,56(sp)
    80001434:	f822                	sd	s0,48(sp)
    80001436:	f426                	sd	s1,40(sp)
    80001438:	f04a                	sd	s2,32(sp)
    8000143a:	ec4e                	sd	s3,24(sp)
    8000143c:	e852                	sd	s4,16(sp)
    8000143e:	e456                	sd	s5,8(sp)
    80001440:	e05a                	sd	s6,0(sp)
    80001442:	0080                	add	s0,sp,64
    80001444:	8aaa                	mv	s5,a0
    80001446:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    80001448:	6785                	lui	a5,0x1
    8000144a:	17fd                	add	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000144c:	95be                	add	a1,a1,a5
    8000144e:	77fd                	lui	a5,0xfffff
    80001450:	00f5f9b3          	and	s3,a1,a5
  for(a = oldsz; a < newsz; a += PGSIZE){
    80001454:	08c9f363          	bgeu	s3,a2,800014da <uvmalloc+0xae>
    80001458:	894e                	mv	s2,s3
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    8000145a:	0126eb13          	or	s6,a3,18
    mem = kalloc();
    8000145e:	fffff097          	auipc	ra,0xfffff
    80001462:	684080e7          	jalr	1668(ra) # 80000ae2 <kalloc>
    80001466:	84aa                	mv	s1,a0
    if(mem == 0){
    80001468:	c51d                	beqz	a0,80001496 <uvmalloc+0x6a>
    memset(mem, 0, PGSIZE);
    8000146a:	6605                	lui	a2,0x1
    8000146c:	4581                	li	a1,0
    8000146e:	00000097          	auipc	ra,0x0
    80001472:	882080e7          	jalr	-1918(ra) # 80000cf0 <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80001476:	875a                	mv	a4,s6
    80001478:	86a6                	mv	a3,s1
    8000147a:	6605                	lui	a2,0x1
    8000147c:	85ca                	mv	a1,s2
    8000147e:	8556                	mv	a0,s5
    80001480:	00000097          	auipc	ra,0x0
    80001484:	c3a080e7          	jalr	-966(ra) # 800010ba <mappages>
    80001488:	e90d                	bnez	a0,800014ba <uvmalloc+0x8e>
  for(a = oldsz; a < newsz; a += PGSIZE){
    8000148a:	6785                	lui	a5,0x1
    8000148c:	993e                	add	s2,s2,a5
    8000148e:	fd4968e3          	bltu	s2,s4,8000145e <uvmalloc+0x32>
  return newsz;
    80001492:	8552                	mv	a0,s4
    80001494:	a809                	j	800014a6 <uvmalloc+0x7a>
      uvmdealloc(pagetable, a, oldsz);
    80001496:	864e                	mv	a2,s3
    80001498:	85ca                	mv	a1,s2
    8000149a:	8556                	mv	a0,s5
    8000149c:	00000097          	auipc	ra,0x0
    800014a0:	f48080e7          	jalr	-184(ra) # 800013e4 <uvmdealloc>
      return 0;
    800014a4:	4501                	li	a0,0
}
    800014a6:	70e2                	ld	ra,56(sp)
    800014a8:	7442                	ld	s0,48(sp)
    800014aa:	74a2                	ld	s1,40(sp)
    800014ac:	7902                	ld	s2,32(sp)
    800014ae:	69e2                	ld	s3,24(sp)
    800014b0:	6a42                	ld	s4,16(sp)
    800014b2:	6aa2                	ld	s5,8(sp)
    800014b4:	6b02                	ld	s6,0(sp)
    800014b6:	6121                	add	sp,sp,64
    800014b8:	8082                	ret
      kfree(mem);
    800014ba:	8526                	mv	a0,s1
    800014bc:	fffff097          	auipc	ra,0xfffff
    800014c0:	528080e7          	jalr	1320(ra) # 800009e4 <kfree>
      uvmdealloc(pagetable, a, oldsz);
    800014c4:	864e                	mv	a2,s3
    800014c6:	85ca                	mv	a1,s2
    800014c8:	8556                	mv	a0,s5
    800014ca:	00000097          	auipc	ra,0x0
    800014ce:	f1a080e7          	jalr	-230(ra) # 800013e4 <uvmdealloc>
      return 0;
    800014d2:	4501                	li	a0,0
    800014d4:	bfc9                	j	800014a6 <uvmalloc+0x7a>
    return oldsz;
    800014d6:	852e                	mv	a0,a1
}
    800014d8:	8082                	ret
  return newsz;
    800014da:	8532                	mv	a0,a2
    800014dc:	b7e9                	j	800014a6 <uvmalloc+0x7a>

00000000800014de <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    800014de:	7179                	add	sp,sp,-48
    800014e0:	f406                	sd	ra,40(sp)
    800014e2:	f022                	sd	s0,32(sp)
    800014e4:	ec26                	sd	s1,24(sp)
    800014e6:	e84a                	sd	s2,16(sp)
    800014e8:	e44e                	sd	s3,8(sp)
    800014ea:	e052                	sd	s4,0(sp)
    800014ec:	1800                	add	s0,sp,48
    800014ee:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    800014f0:	84aa                	mv	s1,a0
    800014f2:	6905                	lui	s2,0x1
    800014f4:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800014f6:	4985                	li	s3,1
    800014f8:	a829                	j	80001512 <freewalk+0x34>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    800014fa:	83a9                	srl	a5,a5,0xa
      freewalk((pagetable_t)child);
    800014fc:	00c79513          	sll	a0,a5,0xc
    80001500:	00000097          	auipc	ra,0x0
    80001504:	fde080e7          	jalr	-34(ra) # 800014de <freewalk>
      pagetable[i] = 0;
    80001508:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    8000150c:	04a1                	add	s1,s1,8
    8000150e:	03248163          	beq	s1,s2,80001530 <freewalk+0x52>
    pte_t pte = pagetable[i];
    80001512:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80001514:	00f7f713          	and	a4,a5,15
    80001518:	ff3701e3          	beq	a4,s3,800014fa <freewalk+0x1c>
    } else if(pte & PTE_V){
    8000151c:	8b85                	and	a5,a5,1
    8000151e:	d7fd                	beqz	a5,8000150c <freewalk+0x2e>
      panic("freewalk: leaf");
    80001520:	00007517          	auipc	a0,0x7
    80001524:	c5850513          	add	a0,a0,-936 # 80008178 <digits+0x138>
    80001528:	fffff097          	auipc	ra,0xfffff
    8000152c:	014080e7          	jalr	20(ra) # 8000053c <panic>
    }
  }
  kfree((void*)pagetable);
    80001530:	8552                	mv	a0,s4
    80001532:	fffff097          	auipc	ra,0xfffff
    80001536:	4b2080e7          	jalr	1202(ra) # 800009e4 <kfree>
}
    8000153a:	70a2                	ld	ra,40(sp)
    8000153c:	7402                	ld	s0,32(sp)
    8000153e:	64e2                	ld	s1,24(sp)
    80001540:	6942                	ld	s2,16(sp)
    80001542:	69a2                	ld	s3,8(sp)
    80001544:	6a02                	ld	s4,0(sp)
    80001546:	6145                	add	sp,sp,48
    80001548:	8082                	ret

000000008000154a <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    8000154a:	1101                	add	sp,sp,-32
    8000154c:	ec06                	sd	ra,24(sp)
    8000154e:	e822                	sd	s0,16(sp)
    80001550:	e426                	sd	s1,8(sp)
    80001552:	1000                	add	s0,sp,32
    80001554:	84aa                	mv	s1,a0
  if(sz > 0)
    80001556:	e999                	bnez	a1,8000156c <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80001558:	8526                	mv	a0,s1
    8000155a:	00000097          	auipc	ra,0x0
    8000155e:	f84080e7          	jalr	-124(ra) # 800014de <freewalk>
}
    80001562:	60e2                	ld	ra,24(sp)
    80001564:	6442                	ld	s0,16(sp)
    80001566:	64a2                	ld	s1,8(sp)
    80001568:	6105                	add	sp,sp,32
    8000156a:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    8000156c:	6785                	lui	a5,0x1
    8000156e:	17fd                	add	a5,a5,-1 # fff <_entry-0x7ffff001>
    80001570:	95be                	add	a1,a1,a5
    80001572:	4685                	li	a3,1
    80001574:	00c5d613          	srl	a2,a1,0xc
    80001578:	4581                	li	a1,0
    8000157a:	00000097          	auipc	ra,0x0
    8000157e:	d06080e7          	jalr	-762(ra) # 80001280 <uvmunmap>
    80001582:	bfd9                	j	80001558 <uvmfree+0xe>

0000000080001584 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80001584:	c679                	beqz	a2,80001652 <uvmcopy+0xce>
{
    80001586:	715d                	add	sp,sp,-80
    80001588:	e486                	sd	ra,72(sp)
    8000158a:	e0a2                	sd	s0,64(sp)
    8000158c:	fc26                	sd	s1,56(sp)
    8000158e:	f84a                	sd	s2,48(sp)
    80001590:	f44e                	sd	s3,40(sp)
    80001592:	f052                	sd	s4,32(sp)
    80001594:	ec56                	sd	s5,24(sp)
    80001596:	e85a                	sd	s6,16(sp)
    80001598:	e45e                	sd	s7,8(sp)
    8000159a:	0880                	add	s0,sp,80
    8000159c:	8b2a                	mv	s6,a0
    8000159e:	8aae                	mv	s5,a1
    800015a0:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    800015a2:	4981                	li	s3,0
    if((pte = walk(old, i, 0)) == 0)
    800015a4:	4601                	li	a2,0
    800015a6:	85ce                	mv	a1,s3
    800015a8:	855a                	mv	a0,s6
    800015aa:	00000097          	auipc	ra,0x0
    800015ae:	a28080e7          	jalr	-1496(ra) # 80000fd2 <walk>
    800015b2:	c531                	beqz	a0,800015fe <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    800015b4:	6118                	ld	a4,0(a0)
    800015b6:	00177793          	and	a5,a4,1
    800015ba:	cbb1                	beqz	a5,8000160e <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    800015bc:	00a75593          	srl	a1,a4,0xa
    800015c0:	00c59b93          	sll	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    800015c4:	3ff77493          	and	s1,a4,1023
    if((mem = kalloc()) == 0)
    800015c8:	fffff097          	auipc	ra,0xfffff
    800015cc:	51a080e7          	jalr	1306(ra) # 80000ae2 <kalloc>
    800015d0:	892a                	mv	s2,a0
    800015d2:	c939                	beqz	a0,80001628 <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    800015d4:	6605                	lui	a2,0x1
    800015d6:	85de                	mv	a1,s7
    800015d8:	fffff097          	auipc	ra,0xfffff
    800015dc:	774080e7          	jalr	1908(ra) # 80000d4c <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    800015e0:	8726                	mv	a4,s1
    800015e2:	86ca                	mv	a3,s2
    800015e4:	6605                	lui	a2,0x1
    800015e6:	85ce                	mv	a1,s3
    800015e8:	8556                	mv	a0,s5
    800015ea:	00000097          	auipc	ra,0x0
    800015ee:	ad0080e7          	jalr	-1328(ra) # 800010ba <mappages>
    800015f2:	e515                	bnez	a0,8000161e <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    800015f4:	6785                	lui	a5,0x1
    800015f6:	99be                	add	s3,s3,a5
    800015f8:	fb49e6e3          	bltu	s3,s4,800015a4 <uvmcopy+0x20>
    800015fc:	a081                	j	8000163c <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    800015fe:	00007517          	auipc	a0,0x7
    80001602:	b8a50513          	add	a0,a0,-1142 # 80008188 <digits+0x148>
    80001606:	fffff097          	auipc	ra,0xfffff
    8000160a:	f36080e7          	jalr	-202(ra) # 8000053c <panic>
      panic("uvmcopy: page not present");
    8000160e:	00007517          	auipc	a0,0x7
    80001612:	b9a50513          	add	a0,a0,-1126 # 800081a8 <digits+0x168>
    80001616:	fffff097          	auipc	ra,0xfffff
    8000161a:	f26080e7          	jalr	-218(ra) # 8000053c <panic>
      kfree(mem);
    8000161e:	854a                	mv	a0,s2
    80001620:	fffff097          	auipc	ra,0xfffff
    80001624:	3c4080e7          	jalr	964(ra) # 800009e4 <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80001628:	4685                	li	a3,1
    8000162a:	00c9d613          	srl	a2,s3,0xc
    8000162e:	4581                	li	a1,0
    80001630:	8556                	mv	a0,s5
    80001632:	00000097          	auipc	ra,0x0
    80001636:	c4e080e7          	jalr	-946(ra) # 80001280 <uvmunmap>
  return -1;
    8000163a:	557d                	li	a0,-1
}
    8000163c:	60a6                	ld	ra,72(sp)
    8000163e:	6406                	ld	s0,64(sp)
    80001640:	74e2                	ld	s1,56(sp)
    80001642:	7942                	ld	s2,48(sp)
    80001644:	79a2                	ld	s3,40(sp)
    80001646:	7a02                	ld	s4,32(sp)
    80001648:	6ae2                	ld	s5,24(sp)
    8000164a:	6b42                	ld	s6,16(sp)
    8000164c:	6ba2                	ld	s7,8(sp)
    8000164e:	6161                	add	sp,sp,80
    80001650:	8082                	ret
  return 0;
    80001652:	4501                	li	a0,0
}
    80001654:	8082                	ret

0000000080001656 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80001656:	1141                	add	sp,sp,-16
    80001658:	e406                	sd	ra,8(sp)
    8000165a:	e022                	sd	s0,0(sp)
    8000165c:	0800                	add	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    8000165e:	4601                	li	a2,0
    80001660:	00000097          	auipc	ra,0x0
    80001664:	972080e7          	jalr	-1678(ra) # 80000fd2 <walk>
  if(pte == 0)
    80001668:	c901                	beqz	a0,80001678 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    8000166a:	611c                	ld	a5,0(a0)
    8000166c:	9bbd                	and	a5,a5,-17
    8000166e:	e11c                	sd	a5,0(a0)
}
    80001670:	60a2                	ld	ra,8(sp)
    80001672:	6402                	ld	s0,0(sp)
    80001674:	0141                	add	sp,sp,16
    80001676:	8082                	ret
    panic("uvmclear");
    80001678:	00007517          	auipc	a0,0x7
    8000167c:	b5050513          	add	a0,a0,-1200 # 800081c8 <digits+0x188>
    80001680:	fffff097          	auipc	ra,0xfffff
    80001684:	ebc080e7          	jalr	-324(ra) # 8000053c <panic>

0000000080001688 <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80001688:	c6bd                	beqz	a3,800016f6 <copyout+0x6e>
{
    8000168a:	715d                	add	sp,sp,-80
    8000168c:	e486                	sd	ra,72(sp)
    8000168e:	e0a2                	sd	s0,64(sp)
    80001690:	fc26                	sd	s1,56(sp)
    80001692:	f84a                	sd	s2,48(sp)
    80001694:	f44e                	sd	s3,40(sp)
    80001696:	f052                	sd	s4,32(sp)
    80001698:	ec56                	sd	s5,24(sp)
    8000169a:	e85a                	sd	s6,16(sp)
    8000169c:	e45e                	sd	s7,8(sp)
    8000169e:	e062                	sd	s8,0(sp)
    800016a0:	0880                	add	s0,sp,80
    800016a2:	8b2a                	mv	s6,a0
    800016a4:	8c2e                	mv	s8,a1
    800016a6:	8a32                	mv	s4,a2
    800016a8:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    800016aa:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    800016ac:	6a85                	lui	s5,0x1
    800016ae:	a015                	j	800016d2 <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    800016b0:	9562                	add	a0,a0,s8
    800016b2:	0004861b          	sext.w	a2,s1
    800016b6:	85d2                	mv	a1,s4
    800016b8:	41250533          	sub	a0,a0,s2
    800016bc:	fffff097          	auipc	ra,0xfffff
    800016c0:	690080e7          	jalr	1680(ra) # 80000d4c <memmove>

    len -= n;
    800016c4:	409989b3          	sub	s3,s3,s1
    src += n;
    800016c8:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    800016ca:	01590c33          	add	s8,s2,s5
  while(len > 0){
    800016ce:	02098263          	beqz	s3,800016f2 <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    800016d2:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    800016d6:	85ca                	mv	a1,s2
    800016d8:	855a                	mv	a0,s6
    800016da:	00000097          	auipc	ra,0x0
    800016de:	99e080e7          	jalr	-1634(ra) # 80001078 <walkaddr>
    if(pa0 == 0)
    800016e2:	cd01                	beqz	a0,800016fa <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    800016e4:	418904b3          	sub	s1,s2,s8
    800016e8:	94d6                	add	s1,s1,s5
    800016ea:	fc99f3e3          	bgeu	s3,s1,800016b0 <copyout+0x28>
    800016ee:	84ce                	mv	s1,s3
    800016f0:	b7c1                	j	800016b0 <copyout+0x28>
  }
  return 0;
    800016f2:	4501                	li	a0,0
    800016f4:	a021                	j	800016fc <copyout+0x74>
    800016f6:	4501                	li	a0,0
}
    800016f8:	8082                	ret
      return -1;
    800016fa:	557d                	li	a0,-1
}
    800016fc:	60a6                	ld	ra,72(sp)
    800016fe:	6406                	ld	s0,64(sp)
    80001700:	74e2                	ld	s1,56(sp)
    80001702:	7942                	ld	s2,48(sp)
    80001704:	79a2                	ld	s3,40(sp)
    80001706:	7a02                	ld	s4,32(sp)
    80001708:	6ae2                	ld	s5,24(sp)
    8000170a:	6b42                	ld	s6,16(sp)
    8000170c:	6ba2                	ld	s7,8(sp)
    8000170e:	6c02                	ld	s8,0(sp)
    80001710:	6161                	add	sp,sp,80
    80001712:	8082                	ret

0000000080001714 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80001714:	caa5                	beqz	a3,80001784 <copyin+0x70>
{
    80001716:	715d                	add	sp,sp,-80
    80001718:	e486                	sd	ra,72(sp)
    8000171a:	e0a2                	sd	s0,64(sp)
    8000171c:	fc26                	sd	s1,56(sp)
    8000171e:	f84a                	sd	s2,48(sp)
    80001720:	f44e                	sd	s3,40(sp)
    80001722:	f052                	sd	s4,32(sp)
    80001724:	ec56                	sd	s5,24(sp)
    80001726:	e85a                	sd	s6,16(sp)
    80001728:	e45e                	sd	s7,8(sp)
    8000172a:	e062                	sd	s8,0(sp)
    8000172c:	0880                	add	s0,sp,80
    8000172e:	8b2a                	mv	s6,a0
    80001730:	8a2e                	mv	s4,a1
    80001732:	8c32                	mv	s8,a2
    80001734:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80001736:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80001738:	6a85                	lui	s5,0x1
    8000173a:	a01d                	j	80001760 <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    8000173c:	018505b3          	add	a1,a0,s8
    80001740:	0004861b          	sext.w	a2,s1
    80001744:	412585b3          	sub	a1,a1,s2
    80001748:	8552                	mv	a0,s4
    8000174a:	fffff097          	auipc	ra,0xfffff
    8000174e:	602080e7          	jalr	1538(ra) # 80000d4c <memmove>

    len -= n;
    80001752:	409989b3          	sub	s3,s3,s1
    dst += n;
    80001756:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80001758:	01590c33          	add	s8,s2,s5
  while(len > 0){
    8000175c:	02098263          	beqz	s3,80001780 <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    80001760:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80001764:	85ca                	mv	a1,s2
    80001766:	855a                	mv	a0,s6
    80001768:	00000097          	auipc	ra,0x0
    8000176c:	910080e7          	jalr	-1776(ra) # 80001078 <walkaddr>
    if(pa0 == 0)
    80001770:	cd01                	beqz	a0,80001788 <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80001772:	418904b3          	sub	s1,s2,s8
    80001776:	94d6                	add	s1,s1,s5
    80001778:	fc99f2e3          	bgeu	s3,s1,8000173c <copyin+0x28>
    8000177c:	84ce                	mv	s1,s3
    8000177e:	bf7d                	j	8000173c <copyin+0x28>
  }
  return 0;
    80001780:	4501                	li	a0,0
    80001782:	a021                	j	8000178a <copyin+0x76>
    80001784:	4501                	li	a0,0
}
    80001786:	8082                	ret
      return -1;
    80001788:	557d                	li	a0,-1
}
    8000178a:	60a6                	ld	ra,72(sp)
    8000178c:	6406                	ld	s0,64(sp)
    8000178e:	74e2                	ld	s1,56(sp)
    80001790:	7942                	ld	s2,48(sp)
    80001792:	79a2                	ld	s3,40(sp)
    80001794:	7a02                	ld	s4,32(sp)
    80001796:	6ae2                	ld	s5,24(sp)
    80001798:	6b42                	ld	s6,16(sp)
    8000179a:	6ba2                	ld	s7,8(sp)
    8000179c:	6c02                	ld	s8,0(sp)
    8000179e:	6161                	add	sp,sp,80
    800017a0:	8082                	ret

00000000800017a2 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    800017a2:	c2dd                	beqz	a3,80001848 <copyinstr+0xa6>
{
    800017a4:	715d                	add	sp,sp,-80
    800017a6:	e486                	sd	ra,72(sp)
    800017a8:	e0a2                	sd	s0,64(sp)
    800017aa:	fc26                	sd	s1,56(sp)
    800017ac:	f84a                	sd	s2,48(sp)
    800017ae:	f44e                	sd	s3,40(sp)
    800017b0:	f052                	sd	s4,32(sp)
    800017b2:	ec56                	sd	s5,24(sp)
    800017b4:	e85a                	sd	s6,16(sp)
    800017b6:	e45e                	sd	s7,8(sp)
    800017b8:	0880                	add	s0,sp,80
    800017ba:	8a2a                	mv	s4,a0
    800017bc:	8b2e                	mv	s6,a1
    800017be:	8bb2                	mv	s7,a2
    800017c0:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    800017c2:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    800017c4:	6985                	lui	s3,0x1
    800017c6:	a02d                	j	800017f0 <copyinstr+0x4e>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    800017c8:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    800017cc:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    800017ce:	37fd                	addw	a5,a5,-1
    800017d0:	0007851b          	sext.w	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    800017d4:	60a6                	ld	ra,72(sp)
    800017d6:	6406                	ld	s0,64(sp)
    800017d8:	74e2                	ld	s1,56(sp)
    800017da:	7942                	ld	s2,48(sp)
    800017dc:	79a2                	ld	s3,40(sp)
    800017de:	7a02                	ld	s4,32(sp)
    800017e0:	6ae2                	ld	s5,24(sp)
    800017e2:	6b42                	ld	s6,16(sp)
    800017e4:	6ba2                	ld	s7,8(sp)
    800017e6:	6161                	add	sp,sp,80
    800017e8:	8082                	ret
    srcva = va0 + PGSIZE;
    800017ea:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    800017ee:	c8a9                	beqz	s1,80001840 <copyinstr+0x9e>
    va0 = PGROUNDDOWN(srcva);
    800017f0:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    800017f4:	85ca                	mv	a1,s2
    800017f6:	8552                	mv	a0,s4
    800017f8:	00000097          	auipc	ra,0x0
    800017fc:	880080e7          	jalr	-1920(ra) # 80001078 <walkaddr>
    if(pa0 == 0)
    80001800:	c131                	beqz	a0,80001844 <copyinstr+0xa2>
    n = PGSIZE - (srcva - va0);
    80001802:	417906b3          	sub	a3,s2,s7
    80001806:	96ce                	add	a3,a3,s3
    80001808:	00d4f363          	bgeu	s1,a3,8000180e <copyinstr+0x6c>
    8000180c:	86a6                	mv	a3,s1
    char *p = (char *) (pa0 + (srcva - va0));
    8000180e:	955e                	add	a0,a0,s7
    80001810:	41250533          	sub	a0,a0,s2
    while(n > 0){
    80001814:	daf9                	beqz	a3,800017ea <copyinstr+0x48>
    80001816:	87da                	mv	a5,s6
    80001818:	885a                	mv	a6,s6
      if(*p == '\0'){
    8000181a:	41650633          	sub	a2,a0,s6
    while(n > 0){
    8000181e:	96da                	add	a3,a3,s6
    80001820:	85be                	mv	a1,a5
      if(*p == '\0'){
    80001822:	00f60733          	add	a4,a2,a5
    80001826:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <end+0xffffffff7ffdcf88>
    8000182a:	df59                	beqz	a4,800017c8 <copyinstr+0x26>
        *dst = *p;
    8000182c:	00e78023          	sb	a4,0(a5)
      dst++;
    80001830:	0785                	add	a5,a5,1
    while(n > 0){
    80001832:	fed797e3          	bne	a5,a3,80001820 <copyinstr+0x7e>
    80001836:	14fd                	add	s1,s1,-1
    80001838:	94c2                	add	s1,s1,a6
      --max;
    8000183a:	8c8d                	sub	s1,s1,a1
      dst++;
    8000183c:	8b3e                	mv	s6,a5
    8000183e:	b775                	j	800017ea <copyinstr+0x48>
    80001840:	4781                	li	a5,0
    80001842:	b771                	j	800017ce <copyinstr+0x2c>
      return -1;
    80001844:	557d                	li	a0,-1
    80001846:	b779                	j	800017d4 <copyinstr+0x32>
  int got_null = 0;
    80001848:	4781                	li	a5,0
  if(got_null){
    8000184a:	37fd                	addw	a5,a5,-1
    8000184c:	0007851b          	sext.w	a0,a5
}
    80001850:	8082                	ret

0000000080001852 <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    80001852:	7139                	add	sp,sp,-64
    80001854:	fc06                	sd	ra,56(sp)
    80001856:	f822                	sd	s0,48(sp)
    80001858:	f426                	sd	s1,40(sp)
    8000185a:	f04a                	sd	s2,32(sp)
    8000185c:	ec4e                	sd	s3,24(sp)
    8000185e:	e852                	sd	s4,16(sp)
    80001860:	e456                	sd	s5,8(sp)
    80001862:	e05a                	sd	s6,0(sp)
    80001864:	0080                	add	s0,sp,64
    80001866:	89aa                	mv	s3,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80001868:	00010497          	auipc	s1,0x10
    8000186c:	81848493          	add	s1,s1,-2024 # 80011080 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80001870:	8b26                	mv	s6,s1
    80001872:	00006a97          	auipc	s5,0x6
    80001876:	78ea8a93          	add	s5,s5,1934 # 80008000 <etext>
    8000187a:	04000937          	lui	s2,0x4000
    8000187e:	197d                	add	s2,s2,-1 # 3ffffff <_entry-0x7c000001>
    80001880:	0932                	sll	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80001882:	00015a17          	auipc	s4,0x15
    80001886:	3fea0a13          	add	s4,s4,1022 # 80016c80 <tickslock>
    char *pa = kalloc();
    8000188a:	fffff097          	auipc	ra,0xfffff
    8000188e:	258080e7          	jalr	600(ra) # 80000ae2 <kalloc>
    80001892:	862a                	mv	a2,a0
    if(pa == 0)
    80001894:	c131                	beqz	a0,800018d8 <proc_mapstacks+0x86>
    uint64 va = KSTACK((int) (p - proc));
    80001896:	416485b3          	sub	a1,s1,s6
    8000189a:	8591                	sra	a1,a1,0x4
    8000189c:	000ab783          	ld	a5,0(s5)
    800018a0:	02f585b3          	mul	a1,a1,a5
    800018a4:	2585                	addw	a1,a1,1
    800018a6:	00d5959b          	sllw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    800018aa:	4719                	li	a4,6
    800018ac:	6685                	lui	a3,0x1
    800018ae:	40b905b3          	sub	a1,s2,a1
    800018b2:	854e                	mv	a0,s3
    800018b4:	00000097          	auipc	ra,0x0
    800018b8:	8a6080e7          	jalr	-1882(ra) # 8000115a <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    800018bc:	17048493          	add	s1,s1,368
    800018c0:	fd4495e3          	bne	s1,s4,8000188a <proc_mapstacks+0x38>
  }
}
    800018c4:	70e2                	ld	ra,56(sp)
    800018c6:	7442                	ld	s0,48(sp)
    800018c8:	74a2                	ld	s1,40(sp)
    800018ca:	7902                	ld	s2,32(sp)
    800018cc:	69e2                	ld	s3,24(sp)
    800018ce:	6a42                	ld	s4,16(sp)
    800018d0:	6aa2                	ld	s5,8(sp)
    800018d2:	6b02                	ld	s6,0(sp)
    800018d4:	6121                	add	sp,sp,64
    800018d6:	8082                	ret
      panic("kalloc");
    800018d8:	00007517          	auipc	a0,0x7
    800018dc:	90050513          	add	a0,a0,-1792 # 800081d8 <digits+0x198>
    800018e0:	fffff097          	auipc	ra,0xfffff
    800018e4:	c5c080e7          	jalr	-932(ra) # 8000053c <panic>

00000000800018e8 <procinit>:

// initialize the proc table.
void
procinit(void)
{
    800018e8:	7139                	add	sp,sp,-64
    800018ea:	fc06                	sd	ra,56(sp)
    800018ec:	f822                	sd	s0,48(sp)
    800018ee:	f426                	sd	s1,40(sp)
    800018f0:	f04a                	sd	s2,32(sp)
    800018f2:	ec4e                	sd	s3,24(sp)
    800018f4:	e852                	sd	s4,16(sp)
    800018f6:	e456                	sd	s5,8(sp)
    800018f8:	e05a                	sd	s6,0(sp)
    800018fa:	0080                	add	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    800018fc:	00007597          	auipc	a1,0x7
    80001900:	8e458593          	add	a1,a1,-1820 # 800081e0 <digits+0x1a0>
    80001904:	0000f517          	auipc	a0,0xf
    80001908:	34c50513          	add	a0,a0,844 # 80010c50 <pid_lock>
    8000190c:	fffff097          	auipc	ra,0xfffff
    80001910:	258080e7          	jalr	600(ra) # 80000b64 <initlock>
  initlock(&wait_lock, "wait_lock");
    80001914:	00007597          	auipc	a1,0x7
    80001918:	8d458593          	add	a1,a1,-1836 # 800081e8 <digits+0x1a8>
    8000191c:	0000f517          	auipc	a0,0xf
    80001920:	34c50513          	add	a0,a0,844 # 80010c68 <wait_lock>
    80001924:	fffff097          	auipc	ra,0xfffff
    80001928:	240080e7          	jalr	576(ra) # 80000b64 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    8000192c:	0000f497          	auipc	s1,0xf
    80001930:	75448493          	add	s1,s1,1876 # 80011080 <proc>
      initlock(&p->lock, "proc");
    80001934:	00007b17          	auipc	s6,0x7
    80001938:	8c4b0b13          	add	s6,s6,-1852 # 800081f8 <digits+0x1b8>
      p->state = UNUSED;
      p->kstack = KSTACK((int) (p - proc));
    8000193c:	8aa6                	mv	s5,s1
    8000193e:	00006a17          	auipc	s4,0x6
    80001942:	6c2a0a13          	add	s4,s4,1730 # 80008000 <etext>
    80001946:	04000937          	lui	s2,0x4000
    8000194a:	197d                	add	s2,s2,-1 # 3ffffff <_entry-0x7c000001>
    8000194c:	0932                	sll	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    8000194e:	00015997          	auipc	s3,0x15
    80001952:	33298993          	add	s3,s3,818 # 80016c80 <tickslock>
      initlock(&p->lock, "proc");
    80001956:	85da                	mv	a1,s6
    80001958:	8526                	mv	a0,s1
    8000195a:	fffff097          	auipc	ra,0xfffff
    8000195e:	20a080e7          	jalr	522(ra) # 80000b64 <initlock>
      p->state = UNUSED;
    80001962:	0004ac23          	sw	zero,24(s1)
      p->kstack = KSTACK((int) (p - proc));
    80001966:	415487b3          	sub	a5,s1,s5
    8000196a:	8791                	sra	a5,a5,0x4
    8000196c:	000a3703          	ld	a4,0(s4)
    80001970:	02e787b3          	mul	a5,a5,a4
    80001974:	2785                	addw	a5,a5,1
    80001976:	00d7979b          	sllw	a5,a5,0xd
    8000197a:	40f907b3          	sub	a5,s2,a5
    8000197e:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80001980:	17048493          	add	s1,s1,368
    80001984:	fd3499e3          	bne	s1,s3,80001956 <procinit+0x6e>
  }
}
    80001988:	70e2                	ld	ra,56(sp)
    8000198a:	7442                	ld	s0,48(sp)
    8000198c:	74a2                	ld	s1,40(sp)
    8000198e:	7902                	ld	s2,32(sp)
    80001990:	69e2                	ld	s3,24(sp)
    80001992:	6a42                	ld	s4,16(sp)
    80001994:	6aa2                	ld	s5,8(sp)
    80001996:	6b02                	ld	s6,0(sp)
    80001998:	6121                	add	sp,sp,64
    8000199a:	8082                	ret

000000008000199c <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    8000199c:	1141                	add	sp,sp,-16
    8000199e:	e422                	sd	s0,8(sp)
    800019a0:	0800                	add	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    800019a2:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    800019a4:	2501                	sext.w	a0,a0
    800019a6:	6422                	ld	s0,8(sp)
    800019a8:	0141                	add	sp,sp,16
    800019aa:	8082                	ret

00000000800019ac <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    800019ac:	1141                	add	sp,sp,-16
    800019ae:	e422                	sd	s0,8(sp)
    800019b0:	0800                	add	s0,sp,16
    800019b2:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    800019b4:	2781                	sext.w	a5,a5
    800019b6:	079e                	sll	a5,a5,0x7
  return c;
}
    800019b8:	0000f517          	auipc	a0,0xf
    800019bc:	2c850513          	add	a0,a0,712 # 80010c80 <cpus>
    800019c0:	953e                	add	a0,a0,a5
    800019c2:	6422                	ld	s0,8(sp)
    800019c4:	0141                	add	sp,sp,16
    800019c6:	8082                	ret

00000000800019c8 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    800019c8:	1101                	add	sp,sp,-32
    800019ca:	ec06                	sd	ra,24(sp)
    800019cc:	e822                	sd	s0,16(sp)
    800019ce:	e426                	sd	s1,8(sp)
    800019d0:	1000                	add	s0,sp,32
  push_off();
    800019d2:	fffff097          	auipc	ra,0xfffff
    800019d6:	1d6080e7          	jalr	470(ra) # 80000ba8 <push_off>
    800019da:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    800019dc:	2781                	sext.w	a5,a5
    800019de:	079e                	sll	a5,a5,0x7
    800019e0:	0000f717          	auipc	a4,0xf
    800019e4:	27070713          	add	a4,a4,624 # 80010c50 <pid_lock>
    800019e8:	97ba                	add	a5,a5,a4
    800019ea:	7b84                	ld	s1,48(a5)
  pop_off();
    800019ec:	fffff097          	auipc	ra,0xfffff
    800019f0:	25c080e7          	jalr	604(ra) # 80000c48 <pop_off>
  return p;
}
    800019f4:	8526                	mv	a0,s1
    800019f6:	60e2                	ld	ra,24(sp)
    800019f8:	6442                	ld	s0,16(sp)
    800019fa:	64a2                	ld	s1,8(sp)
    800019fc:	6105                	add	sp,sp,32
    800019fe:	8082                	ret

0000000080001a00 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80001a00:	1141                	add	sp,sp,-16
    80001a02:	e406                	sd	ra,8(sp)
    80001a04:	e022                	sd	s0,0(sp)
    80001a06:	0800                	add	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80001a08:	00000097          	auipc	ra,0x0
    80001a0c:	fc0080e7          	jalr	-64(ra) # 800019c8 <myproc>
    80001a10:	fffff097          	auipc	ra,0xfffff
    80001a14:	298080e7          	jalr	664(ra) # 80000ca8 <release>

  if (first) {
    80001a18:	00007797          	auipc	a5,0x7
    80001a1c:	f487a783          	lw	a5,-184(a5) # 80008960 <first.1>
    80001a20:	eb89                	bnez	a5,80001a32 <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    80001a22:	00001097          	auipc	ra,0x1
    80001a26:	fe8080e7          	jalr	-24(ra) # 80002a0a <usertrapret>
}
    80001a2a:	60a2                	ld	ra,8(sp)
    80001a2c:	6402                	ld	s0,0(sp)
    80001a2e:	0141                	add	sp,sp,16
    80001a30:	8082                	ret
    first = 0;
    80001a32:	00007797          	auipc	a5,0x7
    80001a36:	f207a723          	sw	zero,-210(a5) # 80008960 <first.1>
    fsinit(ROOTDEV);
    80001a3a:	4505                	li	a0,1
    80001a3c:	00002097          	auipc	ra,0x2
    80001a40:	f8c080e7          	jalr	-116(ra) # 800039c8 <fsinit>
    80001a44:	bff9                	j	80001a22 <forkret+0x22>

0000000080001a46 <allocpid>:
{
    80001a46:	1101                	add	sp,sp,-32
    80001a48:	ec06                	sd	ra,24(sp)
    80001a4a:	e822                	sd	s0,16(sp)
    80001a4c:	e426                	sd	s1,8(sp)
    80001a4e:	e04a                	sd	s2,0(sp)
    80001a50:	1000                	add	s0,sp,32
  acquire(&pid_lock);
    80001a52:	0000f917          	auipc	s2,0xf
    80001a56:	1fe90913          	add	s2,s2,510 # 80010c50 <pid_lock>
    80001a5a:	854a                	mv	a0,s2
    80001a5c:	fffff097          	auipc	ra,0xfffff
    80001a60:	198080e7          	jalr	408(ra) # 80000bf4 <acquire>
  pid = nextpid;
    80001a64:	00007797          	auipc	a5,0x7
    80001a68:	f0078793          	add	a5,a5,-256 # 80008964 <nextpid>
    80001a6c:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80001a6e:	0014871b          	addw	a4,s1,1
    80001a72:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80001a74:	854a                	mv	a0,s2
    80001a76:	fffff097          	auipc	ra,0xfffff
    80001a7a:	232080e7          	jalr	562(ra) # 80000ca8 <release>
}
    80001a7e:	8526                	mv	a0,s1
    80001a80:	60e2                	ld	ra,24(sp)
    80001a82:	6442                	ld	s0,16(sp)
    80001a84:	64a2                	ld	s1,8(sp)
    80001a86:	6902                	ld	s2,0(sp)
    80001a88:	6105                	add	sp,sp,32
    80001a8a:	8082                	ret

0000000080001a8c <proc_pagetable>:
{
    80001a8c:	1101                	add	sp,sp,-32
    80001a8e:	ec06                	sd	ra,24(sp)
    80001a90:	e822                	sd	s0,16(sp)
    80001a92:	e426                	sd	s1,8(sp)
    80001a94:	e04a                	sd	s2,0(sp)
    80001a96:	1000                	add	s0,sp,32
    80001a98:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80001a9a:	00000097          	auipc	ra,0x0
    80001a9e:	8aa080e7          	jalr	-1878(ra) # 80001344 <uvmcreate>
    80001aa2:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80001aa4:	c121                	beqz	a0,80001ae4 <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80001aa6:	4729                	li	a4,10
    80001aa8:	00005697          	auipc	a3,0x5
    80001aac:	55868693          	add	a3,a3,1368 # 80007000 <_trampoline>
    80001ab0:	6605                	lui	a2,0x1
    80001ab2:	040005b7          	lui	a1,0x4000
    80001ab6:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001ab8:	05b2                	sll	a1,a1,0xc
    80001aba:	fffff097          	auipc	ra,0xfffff
    80001abe:	600080e7          	jalr	1536(ra) # 800010ba <mappages>
    80001ac2:	02054863          	bltz	a0,80001af2 <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80001ac6:	4719                	li	a4,6
    80001ac8:	05893683          	ld	a3,88(s2)
    80001acc:	6605                	lui	a2,0x1
    80001ace:	020005b7          	lui	a1,0x2000
    80001ad2:	15fd                	add	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80001ad4:	05b6                	sll	a1,a1,0xd
    80001ad6:	8526                	mv	a0,s1
    80001ad8:	fffff097          	auipc	ra,0xfffff
    80001adc:	5e2080e7          	jalr	1506(ra) # 800010ba <mappages>
    80001ae0:	02054163          	bltz	a0,80001b02 <proc_pagetable+0x76>
}
    80001ae4:	8526                	mv	a0,s1
    80001ae6:	60e2                	ld	ra,24(sp)
    80001ae8:	6442                	ld	s0,16(sp)
    80001aea:	64a2                	ld	s1,8(sp)
    80001aec:	6902                	ld	s2,0(sp)
    80001aee:	6105                	add	sp,sp,32
    80001af0:	8082                	ret
    uvmfree(pagetable, 0);
    80001af2:	4581                	li	a1,0
    80001af4:	8526                	mv	a0,s1
    80001af6:	00000097          	auipc	ra,0x0
    80001afa:	a54080e7          	jalr	-1452(ra) # 8000154a <uvmfree>
    return 0;
    80001afe:	4481                	li	s1,0
    80001b00:	b7d5                	j	80001ae4 <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001b02:	4681                	li	a3,0
    80001b04:	4605                	li	a2,1
    80001b06:	040005b7          	lui	a1,0x4000
    80001b0a:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001b0c:	05b2                	sll	a1,a1,0xc
    80001b0e:	8526                	mv	a0,s1
    80001b10:	fffff097          	auipc	ra,0xfffff
    80001b14:	770080e7          	jalr	1904(ra) # 80001280 <uvmunmap>
    uvmfree(pagetable, 0);
    80001b18:	4581                	li	a1,0
    80001b1a:	8526                	mv	a0,s1
    80001b1c:	00000097          	auipc	ra,0x0
    80001b20:	a2e080e7          	jalr	-1490(ra) # 8000154a <uvmfree>
    return 0;
    80001b24:	4481                	li	s1,0
    80001b26:	bf7d                	j	80001ae4 <proc_pagetable+0x58>

0000000080001b28 <proc_freepagetable>:
{
    80001b28:	1101                	add	sp,sp,-32
    80001b2a:	ec06                	sd	ra,24(sp)
    80001b2c:	e822                	sd	s0,16(sp)
    80001b2e:	e426                	sd	s1,8(sp)
    80001b30:	e04a                	sd	s2,0(sp)
    80001b32:	1000                	add	s0,sp,32
    80001b34:	84aa                	mv	s1,a0
    80001b36:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001b38:	4681                	li	a3,0
    80001b3a:	4605                	li	a2,1
    80001b3c:	040005b7          	lui	a1,0x4000
    80001b40:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001b42:	05b2                	sll	a1,a1,0xc
    80001b44:	fffff097          	auipc	ra,0xfffff
    80001b48:	73c080e7          	jalr	1852(ra) # 80001280 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80001b4c:	4681                	li	a3,0
    80001b4e:	4605                	li	a2,1
    80001b50:	020005b7          	lui	a1,0x2000
    80001b54:	15fd                	add	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80001b56:	05b6                	sll	a1,a1,0xd
    80001b58:	8526                	mv	a0,s1
    80001b5a:	fffff097          	auipc	ra,0xfffff
    80001b5e:	726080e7          	jalr	1830(ra) # 80001280 <uvmunmap>
  uvmfree(pagetable, sz);
    80001b62:	85ca                	mv	a1,s2
    80001b64:	8526                	mv	a0,s1
    80001b66:	00000097          	auipc	ra,0x0
    80001b6a:	9e4080e7          	jalr	-1564(ra) # 8000154a <uvmfree>
}
    80001b6e:	60e2                	ld	ra,24(sp)
    80001b70:	6442                	ld	s0,16(sp)
    80001b72:	64a2                	ld	s1,8(sp)
    80001b74:	6902                	ld	s2,0(sp)
    80001b76:	6105                	add	sp,sp,32
    80001b78:	8082                	ret

0000000080001b7a <freeproc>:
{
    80001b7a:	1101                	add	sp,sp,-32
    80001b7c:	ec06                	sd	ra,24(sp)
    80001b7e:	e822                	sd	s0,16(sp)
    80001b80:	e426                	sd	s1,8(sp)
    80001b82:	1000                	add	s0,sp,32
    80001b84:	84aa                	mv	s1,a0
  if(p->trapframe)
    80001b86:	6d28                	ld	a0,88(a0)
    80001b88:	c509                	beqz	a0,80001b92 <freeproc+0x18>
    kfree((void*)p->trapframe);
    80001b8a:	fffff097          	auipc	ra,0xfffff
    80001b8e:	e5a080e7          	jalr	-422(ra) # 800009e4 <kfree>
  p->trapframe = 0;
    80001b92:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    80001b96:	68a8                	ld	a0,80(s1)
    80001b98:	c511                	beqz	a0,80001ba4 <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    80001b9a:	64ac                	ld	a1,72(s1)
    80001b9c:	00000097          	auipc	ra,0x0
    80001ba0:	f8c080e7          	jalr	-116(ra) # 80001b28 <proc_freepagetable>
  p->pagetable = 0;
    80001ba4:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80001ba8:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80001bac:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80001bb0:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    80001bb4:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80001bb8:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80001bbc:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80001bc0:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80001bc4:	0004ac23          	sw	zero,24(s1)
}
    80001bc8:	60e2                	ld	ra,24(sp)
    80001bca:	6442                	ld	s0,16(sp)
    80001bcc:	64a2                	ld	s1,8(sp)
    80001bce:	6105                	add	sp,sp,32
    80001bd0:	8082                	ret

0000000080001bd2 <allocproc>:
{
    80001bd2:	1101                	add	sp,sp,-32
    80001bd4:	ec06                	sd	ra,24(sp)
    80001bd6:	e822                	sd	s0,16(sp)
    80001bd8:	e426                	sd	s1,8(sp)
    80001bda:	e04a                	sd	s2,0(sp)
    80001bdc:	1000                	add	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80001bde:	0000f497          	auipc	s1,0xf
    80001be2:	4a248493          	add	s1,s1,1186 # 80011080 <proc>
    80001be6:	00015917          	auipc	s2,0x15
    80001bea:	09a90913          	add	s2,s2,154 # 80016c80 <tickslock>
    acquire(&p->lock);
    80001bee:	8526                	mv	a0,s1
    80001bf0:	fffff097          	auipc	ra,0xfffff
    80001bf4:	004080e7          	jalr	4(ra) # 80000bf4 <acquire>
    if(p->state == UNUSED) {
    80001bf8:	4c9c                	lw	a5,24(s1)
    80001bfa:	cf81                	beqz	a5,80001c12 <allocproc+0x40>
      release(&p->lock);
    80001bfc:	8526                	mv	a0,s1
    80001bfe:	fffff097          	auipc	ra,0xfffff
    80001c02:	0aa080e7          	jalr	170(ra) # 80000ca8 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001c06:	17048493          	add	s1,s1,368
    80001c0a:	ff2492e3          	bne	s1,s2,80001bee <allocproc+0x1c>
  return 0;
    80001c0e:	4481                	li	s1,0
    80001c10:	a8a1                	j	80001c68 <allocproc+0x96>
  p->pid = allocpid();
    80001c12:	00000097          	auipc	ra,0x0
    80001c16:	e34080e7          	jalr	-460(ra) # 80001a46 <allocpid>
    80001c1a:	d888                	sw	a0,48(s1)
  p->state = USED;
    80001c1c:	4785                	li	a5,1
    80001c1e:	cc9c                	sw	a5,24(s1)
  p->cpu_affinity = -1;
    80001c20:	57fd                	li	a5,-1
    80001c22:	16f4a423          	sw	a5,360(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80001c26:	fffff097          	auipc	ra,0xfffff
    80001c2a:	ebc080e7          	jalr	-324(ra) # 80000ae2 <kalloc>
    80001c2e:	892a                	mv	s2,a0
    80001c30:	eca8                	sd	a0,88(s1)
    80001c32:	c131                	beqz	a0,80001c76 <allocproc+0xa4>
  p->pagetable = proc_pagetable(p);
    80001c34:	8526                	mv	a0,s1
    80001c36:	00000097          	auipc	ra,0x0
    80001c3a:	e56080e7          	jalr	-426(ra) # 80001a8c <proc_pagetable>
    80001c3e:	892a                	mv	s2,a0
    80001c40:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    80001c42:	c531                	beqz	a0,80001c8e <allocproc+0xbc>
  memset(&p->context, 0, sizeof(p->context));
    80001c44:	07000613          	li	a2,112
    80001c48:	4581                	li	a1,0
    80001c4a:	06048513          	add	a0,s1,96
    80001c4e:	fffff097          	auipc	ra,0xfffff
    80001c52:	0a2080e7          	jalr	162(ra) # 80000cf0 <memset>
  p->context.ra = (uint64)forkret;
    80001c56:	00000797          	auipc	a5,0x0
    80001c5a:	daa78793          	add	a5,a5,-598 # 80001a00 <forkret>
    80001c5e:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    80001c60:	60bc                	ld	a5,64(s1)
    80001c62:	6705                	lui	a4,0x1
    80001c64:	97ba                	add	a5,a5,a4
    80001c66:	f4bc                	sd	a5,104(s1)
}
    80001c68:	8526                	mv	a0,s1
    80001c6a:	60e2                	ld	ra,24(sp)
    80001c6c:	6442                	ld	s0,16(sp)
    80001c6e:	64a2                	ld	s1,8(sp)
    80001c70:	6902                	ld	s2,0(sp)
    80001c72:	6105                	add	sp,sp,32
    80001c74:	8082                	ret
    freeproc(p);
    80001c76:	8526                	mv	a0,s1
    80001c78:	00000097          	auipc	ra,0x0
    80001c7c:	f02080e7          	jalr	-254(ra) # 80001b7a <freeproc>
    release(&p->lock);
    80001c80:	8526                	mv	a0,s1
    80001c82:	fffff097          	auipc	ra,0xfffff
    80001c86:	026080e7          	jalr	38(ra) # 80000ca8 <release>
    return 0;
    80001c8a:	84ca                	mv	s1,s2
    80001c8c:	bff1                	j	80001c68 <allocproc+0x96>
    freeproc(p);
    80001c8e:	8526                	mv	a0,s1
    80001c90:	00000097          	auipc	ra,0x0
    80001c94:	eea080e7          	jalr	-278(ra) # 80001b7a <freeproc>
    release(&p->lock);
    80001c98:	8526                	mv	a0,s1
    80001c9a:	fffff097          	auipc	ra,0xfffff
    80001c9e:	00e080e7          	jalr	14(ra) # 80000ca8 <release>
    return 0;
    80001ca2:	84ca                	mv	s1,s2
    80001ca4:	b7d1                	j	80001c68 <allocproc+0x96>

0000000080001ca6 <userinit>:
{
    80001ca6:	1101                	add	sp,sp,-32
    80001ca8:	ec06                	sd	ra,24(sp)
    80001caa:	e822                	sd	s0,16(sp)
    80001cac:	e426                	sd	s1,8(sp)
    80001cae:	1000                	add	s0,sp,32
  p = allocproc();
    80001cb0:	00000097          	auipc	ra,0x0
    80001cb4:	f22080e7          	jalr	-222(ra) # 80001bd2 <allocproc>
    80001cb8:	84aa                	mv	s1,a0
  initproc = p;
    80001cba:	00007797          	auipc	a5,0x7
    80001cbe:	d0a7bf23          	sd	a0,-738(a5) # 800089d8 <initproc>
  uvmfirst(p->pagetable, initcode, sizeof(initcode));
    80001cc2:	03400613          	li	a2,52
    80001cc6:	00007597          	auipc	a1,0x7
    80001cca:	caa58593          	add	a1,a1,-854 # 80008970 <initcode>
    80001cce:	6928                	ld	a0,80(a0)
    80001cd0:	fffff097          	auipc	ra,0xfffff
    80001cd4:	6a2080e7          	jalr	1698(ra) # 80001372 <uvmfirst>
  p->sz = PGSIZE;
    80001cd8:	6785                	lui	a5,0x1
    80001cda:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    80001cdc:	6cb8                	ld	a4,88(s1)
    80001cde:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80001ce2:	6cb8                	ld	a4,88(s1)
    80001ce4:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001ce6:	4641                	li	a2,16
    80001ce8:	00006597          	auipc	a1,0x6
    80001cec:	51858593          	add	a1,a1,1304 # 80008200 <digits+0x1c0>
    80001cf0:	15848513          	add	a0,s1,344
    80001cf4:	fffff097          	auipc	ra,0xfffff
    80001cf8:	144080e7          	jalr	324(ra) # 80000e38 <safestrcpy>
  p->cwd = namei("/");
    80001cfc:	00006517          	auipc	a0,0x6
    80001d00:	51450513          	add	a0,a0,1300 # 80008210 <digits+0x1d0>
    80001d04:	00002097          	auipc	ra,0x2
    80001d08:	6e2080e7          	jalr	1762(ra) # 800043e6 <namei>
    80001d0c:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    80001d10:	478d                	li	a5,3
    80001d12:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    80001d14:	8526                	mv	a0,s1
    80001d16:	fffff097          	auipc	ra,0xfffff
    80001d1a:	f92080e7          	jalr	-110(ra) # 80000ca8 <release>
}
    80001d1e:	60e2                	ld	ra,24(sp)
    80001d20:	6442                	ld	s0,16(sp)
    80001d22:	64a2                	ld	s1,8(sp)
    80001d24:	6105                	add	sp,sp,32
    80001d26:	8082                	ret

0000000080001d28 <growproc>:
{
    80001d28:	1101                	add	sp,sp,-32
    80001d2a:	ec06                	sd	ra,24(sp)
    80001d2c:	e822                	sd	s0,16(sp)
    80001d2e:	e426                	sd	s1,8(sp)
    80001d30:	e04a                	sd	s2,0(sp)
    80001d32:	1000                	add	s0,sp,32
    80001d34:	892a                	mv	s2,a0
  struct proc *p = myproc();
    80001d36:	00000097          	auipc	ra,0x0
    80001d3a:	c92080e7          	jalr	-878(ra) # 800019c8 <myproc>
    80001d3e:	84aa                	mv	s1,a0
  sz = p->sz;
    80001d40:	652c                	ld	a1,72(a0)
  if(n > 0){
    80001d42:	01204c63          	bgtz	s2,80001d5a <growproc+0x32>
  } else if(n < 0){
    80001d46:	02094663          	bltz	s2,80001d72 <growproc+0x4a>
  p->sz = sz;
    80001d4a:	e4ac                	sd	a1,72(s1)
  return 0;
    80001d4c:	4501                	li	a0,0
}
    80001d4e:	60e2                	ld	ra,24(sp)
    80001d50:	6442                	ld	s0,16(sp)
    80001d52:	64a2                	ld	s1,8(sp)
    80001d54:	6902                	ld	s2,0(sp)
    80001d56:	6105                	add	sp,sp,32
    80001d58:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    80001d5a:	4691                	li	a3,4
    80001d5c:	00b90633          	add	a2,s2,a1
    80001d60:	6928                	ld	a0,80(a0)
    80001d62:	fffff097          	auipc	ra,0xfffff
    80001d66:	6ca080e7          	jalr	1738(ra) # 8000142c <uvmalloc>
    80001d6a:	85aa                	mv	a1,a0
    80001d6c:	fd79                	bnez	a0,80001d4a <growproc+0x22>
      return -1;
    80001d6e:	557d                	li	a0,-1
    80001d70:	bff9                	j	80001d4e <growproc+0x26>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80001d72:	00b90633          	add	a2,s2,a1
    80001d76:	6928                	ld	a0,80(a0)
    80001d78:	fffff097          	auipc	ra,0xfffff
    80001d7c:	66c080e7          	jalr	1644(ra) # 800013e4 <uvmdealloc>
    80001d80:	85aa                	mv	a1,a0
    80001d82:	b7e1                	j	80001d4a <growproc+0x22>

0000000080001d84 <fork>:
{
    80001d84:	7139                	add	sp,sp,-64
    80001d86:	fc06                	sd	ra,56(sp)
    80001d88:	f822                	sd	s0,48(sp)
    80001d8a:	f426                	sd	s1,40(sp)
    80001d8c:	f04a                	sd	s2,32(sp)
    80001d8e:	ec4e                	sd	s3,24(sp)
    80001d90:	e852                	sd	s4,16(sp)
    80001d92:	e456                	sd	s5,8(sp)
    80001d94:	0080                	add	s0,sp,64
  struct proc *p = myproc();
    80001d96:	00000097          	auipc	ra,0x0
    80001d9a:	c32080e7          	jalr	-974(ra) # 800019c8 <myproc>
    80001d9e:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    80001da0:	00000097          	auipc	ra,0x0
    80001da4:	e32080e7          	jalr	-462(ra) # 80001bd2 <allocproc>
    80001da8:	10050c63          	beqz	a0,80001ec0 <fork+0x13c>
    80001dac:	8a2a                	mv	s4,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80001dae:	048ab603          	ld	a2,72(s5)
    80001db2:	692c                	ld	a1,80(a0)
    80001db4:	050ab503          	ld	a0,80(s5)
    80001db8:	fffff097          	auipc	ra,0xfffff
    80001dbc:	7cc080e7          	jalr	1996(ra) # 80001584 <uvmcopy>
    80001dc0:	04054863          	bltz	a0,80001e10 <fork+0x8c>
  np->sz = p->sz;
    80001dc4:	048ab783          	ld	a5,72(s5)
    80001dc8:	04fa3423          	sd	a5,72(s4)
  *(np->trapframe) = *(p->trapframe);
    80001dcc:	058ab683          	ld	a3,88(s5)
    80001dd0:	87b6                	mv	a5,a3
    80001dd2:	058a3703          	ld	a4,88(s4)
    80001dd6:	12068693          	add	a3,a3,288
    80001dda:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    80001dde:	6788                	ld	a0,8(a5)
    80001de0:	6b8c                	ld	a1,16(a5)
    80001de2:	6f90                	ld	a2,24(a5)
    80001de4:	01073023          	sd	a6,0(a4)
    80001de8:	e708                	sd	a0,8(a4)
    80001dea:	eb0c                	sd	a1,16(a4)
    80001dec:	ef10                	sd	a2,24(a4)
    80001dee:	02078793          	add	a5,a5,32
    80001df2:	02070713          	add	a4,a4,32
    80001df6:	fed792e3          	bne	a5,a3,80001dda <fork+0x56>
  np->trapframe->a0 = 0;
    80001dfa:	058a3783          	ld	a5,88(s4)
    80001dfe:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    80001e02:	0d0a8493          	add	s1,s5,208
    80001e06:	0d0a0913          	add	s2,s4,208
    80001e0a:	150a8993          	add	s3,s5,336
    80001e0e:	a00d                	j	80001e30 <fork+0xac>
    freeproc(np);
    80001e10:	8552                	mv	a0,s4
    80001e12:	00000097          	auipc	ra,0x0
    80001e16:	d68080e7          	jalr	-664(ra) # 80001b7a <freeproc>
    release(&np->lock);
    80001e1a:	8552                	mv	a0,s4
    80001e1c:	fffff097          	auipc	ra,0xfffff
    80001e20:	e8c080e7          	jalr	-372(ra) # 80000ca8 <release>
    return -1;
    80001e24:	597d                	li	s2,-1
    80001e26:	a059                	j	80001eac <fork+0x128>
  for(i = 0; i < NOFILE; i++)
    80001e28:	04a1                	add	s1,s1,8
    80001e2a:	0921                	add	s2,s2,8
    80001e2c:	01348b63          	beq	s1,s3,80001e42 <fork+0xbe>
    if(p->ofile[i])
    80001e30:	6088                	ld	a0,0(s1)
    80001e32:	d97d                	beqz	a0,80001e28 <fork+0xa4>
      np->ofile[i] = filedup(p->ofile[i]);
    80001e34:	00003097          	auipc	ra,0x3
    80001e38:	c24080e7          	jalr	-988(ra) # 80004a58 <filedup>
    80001e3c:	00a93023          	sd	a0,0(s2)
    80001e40:	b7e5                	j	80001e28 <fork+0xa4>
  np->cwd = idup(p->cwd);
    80001e42:	150ab503          	ld	a0,336(s5)
    80001e46:	00002097          	auipc	ra,0x2
    80001e4a:	dbc080e7          	jalr	-580(ra) # 80003c02 <idup>
    80001e4e:	14aa3823          	sd	a0,336(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001e52:	4641                	li	a2,16
    80001e54:	158a8593          	add	a1,s5,344
    80001e58:	158a0513          	add	a0,s4,344
    80001e5c:	fffff097          	auipc	ra,0xfffff
    80001e60:	fdc080e7          	jalr	-36(ra) # 80000e38 <safestrcpy>
  pid = np->pid;
    80001e64:	030a2903          	lw	s2,48(s4)
  release(&np->lock);
    80001e68:	8552                	mv	a0,s4
    80001e6a:	fffff097          	auipc	ra,0xfffff
    80001e6e:	e3e080e7          	jalr	-450(ra) # 80000ca8 <release>
  acquire(&wait_lock);
    80001e72:	0000f497          	auipc	s1,0xf
    80001e76:	df648493          	add	s1,s1,-522 # 80010c68 <wait_lock>
    80001e7a:	8526                	mv	a0,s1
    80001e7c:	fffff097          	auipc	ra,0xfffff
    80001e80:	d78080e7          	jalr	-648(ra) # 80000bf4 <acquire>
  np->parent = p;
    80001e84:	035a3c23          	sd	s5,56(s4)
  release(&wait_lock);
    80001e88:	8526                	mv	a0,s1
    80001e8a:	fffff097          	auipc	ra,0xfffff
    80001e8e:	e1e080e7          	jalr	-482(ra) # 80000ca8 <release>
  acquire(&np->lock);
    80001e92:	8552                	mv	a0,s4
    80001e94:	fffff097          	auipc	ra,0xfffff
    80001e98:	d60080e7          	jalr	-672(ra) # 80000bf4 <acquire>
  np->state = RUNNABLE;
    80001e9c:	478d                	li	a5,3
    80001e9e:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    80001ea2:	8552                	mv	a0,s4
    80001ea4:	fffff097          	auipc	ra,0xfffff
    80001ea8:	e04080e7          	jalr	-508(ra) # 80000ca8 <release>
}
    80001eac:	854a                	mv	a0,s2
    80001eae:	70e2                	ld	ra,56(sp)
    80001eb0:	7442                	ld	s0,48(sp)
    80001eb2:	74a2                	ld	s1,40(sp)
    80001eb4:	7902                	ld	s2,32(sp)
    80001eb6:	69e2                	ld	s3,24(sp)
    80001eb8:	6a42                	ld	s4,16(sp)
    80001eba:	6aa2                	ld	s5,8(sp)
    80001ebc:	6121                	add	sp,sp,64
    80001ebe:	8082                	ret
    return -1;
    80001ec0:	597d                	li	s2,-1
    80001ec2:	b7ed                	j	80001eac <fork+0x128>

0000000080001ec4 <scheduler>:
{
    80001ec4:	715d                	add	sp,sp,-80
    80001ec6:	e486                	sd	ra,72(sp)
    80001ec8:	e0a2                	sd	s0,64(sp)
    80001eca:	fc26                	sd	s1,56(sp)
    80001ecc:	f84a                	sd	s2,48(sp)
    80001ece:	f44e                	sd	s3,40(sp)
    80001ed0:	f052                	sd	s4,32(sp)
    80001ed2:	ec56                	sd	s5,24(sp)
    80001ed4:	e85a                	sd	s6,16(sp)
    80001ed6:	e45e                	sd	s7,8(sp)
    80001ed8:	e062                	sd	s8,0(sp)
    80001eda:	0880                	add	s0,sp,80
    80001edc:	8792                	mv	a5,tp
  int id = r_tp();
    80001ede:	2781                	sext.w	a5,a5
    80001ee0:	8a92                	mv	s5,tp
    80001ee2:	2a81                	sext.w	s5,s5
  c->proc = 0;
    80001ee4:	00779c13          	sll	s8,a5,0x7
    80001ee8:	0000f717          	auipc	a4,0xf
    80001eec:	d6870713          	add	a4,a4,-664 # 80010c50 <pid_lock>
    80001ef0:	9762                	add	a4,a4,s8
    80001ef2:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    80001ef6:	0000f717          	auipc	a4,0xf
    80001efa:	d9270713          	add	a4,a4,-622 # 80010c88 <cpus+0x8>
    80001efe:	9c3a                	add	s8,s8,a4
      if (p->cpu_affinity != -1 && p->cpu_affinity != cpu_id)
    80001f00:	59fd                	li	s3,-1
      if(p->state == RUNNABLE) {
    80001f02:	4a0d                	li	s4,3
        c->proc = p;
    80001f04:	079e                	sll	a5,a5,0x7
    80001f06:	0000fb17          	auipc	s6,0xf
    80001f0a:	d4ab0b13          	add	s6,s6,-694 # 80010c50 <pid_lock>
    80001f0e:	9b3e                	add	s6,s6,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    80001f10:	00015917          	auipc	s2,0x15
    80001f14:	d7090913          	add	s2,s2,-656 # 80016c80 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001f18:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001f1c:	0027e793          	or	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001f20:	10079073          	csrw	sstatus,a5
    80001f24:	0000f497          	auipc	s1,0xf
    80001f28:	15c48493          	add	s1,s1,348 # 80011080 <proc>
        p->state = RUNNING;
    80001f2c:	4b91                	li	s7,4
    80001f2e:	a829                	j	80001f48 <scheduler+0x84>
      if(p->state == RUNNABLE) {
    80001f30:	4c9c                	lw	a5,24(s1)
    80001f32:	03478c63          	beq	a5,s4,80001f6a <scheduler+0xa6>
      release(&p->lock);
    80001f36:	8526                	mv	a0,s1
    80001f38:	fffff097          	auipc	ra,0xfffff
    80001f3c:	d70080e7          	jalr	-656(ra) # 80000ca8 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80001f40:	17048493          	add	s1,s1,368
    80001f44:	fd248ae3          	beq	s1,s2,80001f18 <scheduler+0x54>
      acquire(&p->lock);
    80001f48:	8526                	mv	a0,s1
    80001f4a:	fffff097          	auipc	ra,0xfffff
    80001f4e:	caa080e7          	jalr	-854(ra) # 80000bf4 <acquire>
      if (p->cpu_affinity != -1 && p->cpu_affinity != cpu_id)
    80001f52:	1684a783          	lw	a5,360(s1)
    80001f56:	fd378de3          	beq	a5,s3,80001f30 <scheduler+0x6c>
    80001f5a:	fd578be3          	beq	a5,s5,80001f30 <scheduler+0x6c>
        release(&p->lock);
    80001f5e:	8526                	mv	a0,s1
    80001f60:	fffff097          	auipc	ra,0xfffff
    80001f64:	d48080e7          	jalr	-696(ra) # 80000ca8 <release>
        continue;
    80001f68:	bfe1                	j	80001f40 <scheduler+0x7c>
        p->state = RUNNING;
    80001f6a:	0174ac23          	sw	s7,24(s1)
        c->proc = p;
    80001f6e:	029b3823          	sd	s1,48(s6)
        swtch(&c->context, &p->context);
    80001f72:	06048593          	add	a1,s1,96
    80001f76:	8562                	mv	a0,s8
    80001f78:	00001097          	auipc	ra,0x1
    80001f7c:	9e8080e7          	jalr	-1560(ra) # 80002960 <swtch>
        c->proc = 0;
    80001f80:	020b3823          	sd	zero,48(s6)
    80001f84:	bf4d                	j	80001f36 <scheduler+0x72>

0000000080001f86 <sched>:
{
    80001f86:	7179                	add	sp,sp,-48
    80001f88:	f406                	sd	ra,40(sp)
    80001f8a:	f022                	sd	s0,32(sp)
    80001f8c:	ec26                	sd	s1,24(sp)
    80001f8e:	e84a                	sd	s2,16(sp)
    80001f90:	e44e                	sd	s3,8(sp)
    80001f92:	1800                	add	s0,sp,48
  struct proc *p = myproc();
    80001f94:	00000097          	auipc	ra,0x0
    80001f98:	a34080e7          	jalr	-1484(ra) # 800019c8 <myproc>
    80001f9c:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80001f9e:	fffff097          	auipc	ra,0xfffff
    80001fa2:	bdc080e7          	jalr	-1060(ra) # 80000b7a <holding>
    80001fa6:	c93d                	beqz	a0,8000201c <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001fa8:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    80001faa:	2781                	sext.w	a5,a5
    80001fac:	079e                	sll	a5,a5,0x7
    80001fae:	0000f717          	auipc	a4,0xf
    80001fb2:	ca270713          	add	a4,a4,-862 # 80010c50 <pid_lock>
    80001fb6:	97ba                	add	a5,a5,a4
    80001fb8:	0a87a703          	lw	a4,168(a5)
    80001fbc:	4785                	li	a5,1
    80001fbe:	06f71763          	bne	a4,a5,8000202c <sched+0xa6>
  if(p->state == RUNNING)
    80001fc2:	4c98                	lw	a4,24(s1)
    80001fc4:	4791                	li	a5,4
    80001fc6:	06f70b63          	beq	a4,a5,8000203c <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001fca:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001fce:	8b89                	and	a5,a5,2
  if(intr_get())
    80001fd0:	efb5                	bnez	a5,8000204c <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001fd2:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80001fd4:	0000f917          	auipc	s2,0xf
    80001fd8:	c7c90913          	add	s2,s2,-900 # 80010c50 <pid_lock>
    80001fdc:	2781                	sext.w	a5,a5
    80001fde:	079e                	sll	a5,a5,0x7
    80001fe0:	97ca                	add	a5,a5,s2
    80001fe2:	0ac7a983          	lw	s3,172(a5)
    80001fe6:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    80001fe8:	2781                	sext.w	a5,a5
    80001fea:	079e                	sll	a5,a5,0x7
    80001fec:	0000f597          	auipc	a1,0xf
    80001ff0:	c9c58593          	add	a1,a1,-868 # 80010c88 <cpus+0x8>
    80001ff4:	95be                	add	a1,a1,a5
    80001ff6:	06048513          	add	a0,s1,96
    80001ffa:	00001097          	auipc	ra,0x1
    80001ffe:	966080e7          	jalr	-1690(ra) # 80002960 <swtch>
    80002002:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80002004:	2781                	sext.w	a5,a5
    80002006:	079e                	sll	a5,a5,0x7
    80002008:	993e                	add	s2,s2,a5
    8000200a:	0b392623          	sw	s3,172(s2)
}
    8000200e:	70a2                	ld	ra,40(sp)
    80002010:	7402                	ld	s0,32(sp)
    80002012:	64e2                	ld	s1,24(sp)
    80002014:	6942                	ld	s2,16(sp)
    80002016:	69a2                	ld	s3,8(sp)
    80002018:	6145                	add	sp,sp,48
    8000201a:	8082                	ret
    panic("sched p->lock");
    8000201c:	00006517          	auipc	a0,0x6
    80002020:	1fc50513          	add	a0,a0,508 # 80008218 <digits+0x1d8>
    80002024:	ffffe097          	auipc	ra,0xffffe
    80002028:	518080e7          	jalr	1304(ra) # 8000053c <panic>
    panic("sched locks");
    8000202c:	00006517          	auipc	a0,0x6
    80002030:	1fc50513          	add	a0,a0,508 # 80008228 <digits+0x1e8>
    80002034:	ffffe097          	auipc	ra,0xffffe
    80002038:	508080e7          	jalr	1288(ra) # 8000053c <panic>
    panic("sched running");
    8000203c:	00006517          	auipc	a0,0x6
    80002040:	1fc50513          	add	a0,a0,508 # 80008238 <digits+0x1f8>
    80002044:	ffffe097          	auipc	ra,0xffffe
    80002048:	4f8080e7          	jalr	1272(ra) # 8000053c <panic>
    panic("sched interruptible");
    8000204c:	00006517          	auipc	a0,0x6
    80002050:	1fc50513          	add	a0,a0,508 # 80008248 <digits+0x208>
    80002054:	ffffe097          	auipc	ra,0xffffe
    80002058:	4e8080e7          	jalr	1256(ra) # 8000053c <panic>

000000008000205c <yield>:
{
    8000205c:	1101                	add	sp,sp,-32
    8000205e:	ec06                	sd	ra,24(sp)
    80002060:	e822                	sd	s0,16(sp)
    80002062:	e426                	sd	s1,8(sp)
    80002064:	1000                	add	s0,sp,32
  struct proc *p = myproc();
    80002066:	00000097          	auipc	ra,0x0
    8000206a:	962080e7          	jalr	-1694(ra) # 800019c8 <myproc>
    8000206e:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80002070:	fffff097          	auipc	ra,0xfffff
    80002074:	b84080e7          	jalr	-1148(ra) # 80000bf4 <acquire>
  p->state = RUNNABLE;
    80002078:	478d                	li	a5,3
    8000207a:	cc9c                	sw	a5,24(s1)
  sched();
    8000207c:	00000097          	auipc	ra,0x0
    80002080:	f0a080e7          	jalr	-246(ra) # 80001f86 <sched>
  release(&p->lock);
    80002084:	8526                	mv	a0,s1
    80002086:	fffff097          	auipc	ra,0xfffff
    8000208a:	c22080e7          	jalr	-990(ra) # 80000ca8 <release>
}
    8000208e:	60e2                	ld	ra,24(sp)
    80002090:	6442                	ld	s0,16(sp)
    80002092:	64a2                	ld	s1,8(sp)
    80002094:	6105                	add	sp,sp,32
    80002096:	8082                	ret

0000000080002098 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80002098:	7179                	add	sp,sp,-48
    8000209a:	f406                	sd	ra,40(sp)
    8000209c:	f022                	sd	s0,32(sp)
    8000209e:	ec26                	sd	s1,24(sp)
    800020a0:	e84a                	sd	s2,16(sp)
    800020a2:	e44e                	sd	s3,8(sp)
    800020a4:	1800                	add	s0,sp,48
    800020a6:	89aa                	mv	s3,a0
    800020a8:	892e                	mv	s2,a1
  struct proc *p = myproc();
    800020aa:	00000097          	auipc	ra,0x0
    800020ae:	91e080e7          	jalr	-1762(ra) # 800019c8 <myproc>
    800020b2:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    800020b4:	fffff097          	auipc	ra,0xfffff
    800020b8:	b40080e7          	jalr	-1216(ra) # 80000bf4 <acquire>
  release(lk);
    800020bc:	854a                	mv	a0,s2
    800020be:	fffff097          	auipc	ra,0xfffff
    800020c2:	bea080e7          	jalr	-1046(ra) # 80000ca8 <release>

  // Go to sleep.
  p->chan = chan;
    800020c6:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    800020ca:	4789                	li	a5,2
    800020cc:	cc9c                	sw	a5,24(s1)

  sched();
    800020ce:	00000097          	auipc	ra,0x0
    800020d2:	eb8080e7          	jalr	-328(ra) # 80001f86 <sched>

  // Tidy up.
  p->chan = 0;
    800020d6:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    800020da:	8526                	mv	a0,s1
    800020dc:	fffff097          	auipc	ra,0xfffff
    800020e0:	bcc080e7          	jalr	-1076(ra) # 80000ca8 <release>
  acquire(lk);
    800020e4:	854a                	mv	a0,s2
    800020e6:	fffff097          	auipc	ra,0xfffff
    800020ea:	b0e080e7          	jalr	-1266(ra) # 80000bf4 <acquire>
}
    800020ee:	70a2                	ld	ra,40(sp)
    800020f0:	7402                	ld	s0,32(sp)
    800020f2:	64e2                	ld	s1,24(sp)
    800020f4:	6942                	ld	s2,16(sp)
    800020f6:	69a2                	ld	s3,8(sp)
    800020f8:	6145                	add	sp,sp,48
    800020fa:	8082                	ret

00000000800020fc <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    800020fc:	7139                	add	sp,sp,-64
    800020fe:	fc06                	sd	ra,56(sp)
    80002100:	f822                	sd	s0,48(sp)
    80002102:	f426                	sd	s1,40(sp)
    80002104:	f04a                	sd	s2,32(sp)
    80002106:	ec4e                	sd	s3,24(sp)
    80002108:	e852                	sd	s4,16(sp)
    8000210a:	e456                	sd	s5,8(sp)
    8000210c:	0080                	add	s0,sp,64
    8000210e:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    80002110:	0000f497          	auipc	s1,0xf
    80002114:	f7048493          	add	s1,s1,-144 # 80011080 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    80002118:	4989                	li	s3,2
        p->state = RUNNABLE;
    8000211a:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    8000211c:	00015917          	auipc	s2,0x15
    80002120:	b6490913          	add	s2,s2,-1180 # 80016c80 <tickslock>
    80002124:	a811                	j	80002138 <wakeup+0x3c>
      }
      release(&p->lock);
    80002126:	8526                	mv	a0,s1
    80002128:	fffff097          	auipc	ra,0xfffff
    8000212c:	b80080e7          	jalr	-1152(ra) # 80000ca8 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80002130:	17048493          	add	s1,s1,368
    80002134:	03248663          	beq	s1,s2,80002160 <wakeup+0x64>
    if(p != myproc()){
    80002138:	00000097          	auipc	ra,0x0
    8000213c:	890080e7          	jalr	-1904(ra) # 800019c8 <myproc>
    80002140:	fea488e3          	beq	s1,a0,80002130 <wakeup+0x34>
      acquire(&p->lock);
    80002144:	8526                	mv	a0,s1
    80002146:	fffff097          	auipc	ra,0xfffff
    8000214a:	aae080e7          	jalr	-1362(ra) # 80000bf4 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    8000214e:	4c9c                	lw	a5,24(s1)
    80002150:	fd379be3          	bne	a5,s3,80002126 <wakeup+0x2a>
    80002154:	709c                	ld	a5,32(s1)
    80002156:	fd4798e3          	bne	a5,s4,80002126 <wakeup+0x2a>
        p->state = RUNNABLE;
    8000215a:	0154ac23          	sw	s5,24(s1)
    8000215e:	b7e1                	j	80002126 <wakeup+0x2a>
    }
  }
}
    80002160:	70e2                	ld	ra,56(sp)
    80002162:	7442                	ld	s0,48(sp)
    80002164:	74a2                	ld	s1,40(sp)
    80002166:	7902                	ld	s2,32(sp)
    80002168:	69e2                	ld	s3,24(sp)
    8000216a:	6a42                	ld	s4,16(sp)
    8000216c:	6aa2                	ld	s5,8(sp)
    8000216e:	6121                	add	sp,sp,64
    80002170:	8082                	ret

0000000080002172 <reparent>:
{
    80002172:	7179                	add	sp,sp,-48
    80002174:	f406                	sd	ra,40(sp)
    80002176:	f022                	sd	s0,32(sp)
    80002178:	ec26                	sd	s1,24(sp)
    8000217a:	e84a                	sd	s2,16(sp)
    8000217c:	e44e                	sd	s3,8(sp)
    8000217e:	e052                	sd	s4,0(sp)
    80002180:	1800                	add	s0,sp,48
    80002182:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80002184:	0000f497          	auipc	s1,0xf
    80002188:	efc48493          	add	s1,s1,-260 # 80011080 <proc>
      pp->parent = initproc;
    8000218c:	00007a17          	auipc	s4,0x7
    80002190:	84ca0a13          	add	s4,s4,-1972 # 800089d8 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80002194:	00015997          	auipc	s3,0x15
    80002198:	aec98993          	add	s3,s3,-1300 # 80016c80 <tickslock>
    8000219c:	a029                	j	800021a6 <reparent+0x34>
    8000219e:	17048493          	add	s1,s1,368
    800021a2:	01348d63          	beq	s1,s3,800021bc <reparent+0x4a>
    if(pp->parent == p){
    800021a6:	7c9c                	ld	a5,56(s1)
    800021a8:	ff279be3          	bne	a5,s2,8000219e <reparent+0x2c>
      pp->parent = initproc;
    800021ac:	000a3503          	ld	a0,0(s4)
    800021b0:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    800021b2:	00000097          	auipc	ra,0x0
    800021b6:	f4a080e7          	jalr	-182(ra) # 800020fc <wakeup>
    800021ba:	b7d5                	j	8000219e <reparent+0x2c>
}
    800021bc:	70a2                	ld	ra,40(sp)
    800021be:	7402                	ld	s0,32(sp)
    800021c0:	64e2                	ld	s1,24(sp)
    800021c2:	6942                	ld	s2,16(sp)
    800021c4:	69a2                	ld	s3,8(sp)
    800021c6:	6a02                	ld	s4,0(sp)
    800021c8:	6145                	add	sp,sp,48
    800021ca:	8082                	ret

00000000800021cc <exit>:
{
    800021cc:	7179                	add	sp,sp,-48
    800021ce:	f406                	sd	ra,40(sp)
    800021d0:	f022                	sd	s0,32(sp)
    800021d2:	ec26                	sd	s1,24(sp)
    800021d4:	e84a                	sd	s2,16(sp)
    800021d6:	e44e                	sd	s3,8(sp)
    800021d8:	e052                	sd	s4,0(sp)
    800021da:	1800                	add	s0,sp,48
    800021dc:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    800021de:	fffff097          	auipc	ra,0xfffff
    800021e2:	7ea080e7          	jalr	2026(ra) # 800019c8 <myproc>
    800021e6:	89aa                	mv	s3,a0
  if(p == initproc)
    800021e8:	00006797          	auipc	a5,0x6
    800021ec:	7f07b783          	ld	a5,2032(a5) # 800089d8 <initproc>
    800021f0:	0d050493          	add	s1,a0,208
    800021f4:	15050913          	add	s2,a0,336
    800021f8:	02a79363          	bne	a5,a0,8000221e <exit+0x52>
    panic("init exiting");
    800021fc:	00006517          	auipc	a0,0x6
    80002200:	06450513          	add	a0,a0,100 # 80008260 <digits+0x220>
    80002204:	ffffe097          	auipc	ra,0xffffe
    80002208:	338080e7          	jalr	824(ra) # 8000053c <panic>
      fileclose(f);
    8000220c:	00003097          	auipc	ra,0x3
    80002210:	89e080e7          	jalr	-1890(ra) # 80004aaa <fileclose>
      p->ofile[fd] = 0;
    80002214:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    80002218:	04a1                	add	s1,s1,8
    8000221a:	01248563          	beq	s1,s2,80002224 <exit+0x58>
    if(p->ofile[fd]){
    8000221e:	6088                	ld	a0,0(s1)
    80002220:	f575                	bnez	a0,8000220c <exit+0x40>
    80002222:	bfdd                	j	80002218 <exit+0x4c>
  begin_op();
    80002224:	00002097          	auipc	ra,0x2
    80002228:	3c2080e7          	jalr	962(ra) # 800045e6 <begin_op>
  iput(p->cwd);
    8000222c:	1509b503          	ld	a0,336(s3)
    80002230:	00002097          	auipc	ra,0x2
    80002234:	bca080e7          	jalr	-1078(ra) # 80003dfa <iput>
  end_op();
    80002238:	00002097          	auipc	ra,0x2
    8000223c:	428080e7          	jalr	1064(ra) # 80004660 <end_op>
  p->cwd = 0;
    80002240:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    80002244:	0000f497          	auipc	s1,0xf
    80002248:	a2448493          	add	s1,s1,-1500 # 80010c68 <wait_lock>
    8000224c:	8526                	mv	a0,s1
    8000224e:	fffff097          	auipc	ra,0xfffff
    80002252:	9a6080e7          	jalr	-1626(ra) # 80000bf4 <acquire>
  reparent(p);
    80002256:	854e                	mv	a0,s3
    80002258:	00000097          	auipc	ra,0x0
    8000225c:	f1a080e7          	jalr	-230(ra) # 80002172 <reparent>
  wakeup(p->parent);
    80002260:	0389b503          	ld	a0,56(s3)
    80002264:	00000097          	auipc	ra,0x0
    80002268:	e98080e7          	jalr	-360(ra) # 800020fc <wakeup>
  acquire(&p->lock);
    8000226c:	854e                	mv	a0,s3
    8000226e:	fffff097          	auipc	ra,0xfffff
    80002272:	986080e7          	jalr	-1658(ra) # 80000bf4 <acquire>
  p->xstate = status;
    80002276:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    8000227a:	4795                	li	a5,5
    8000227c:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    80002280:	8526                	mv	a0,s1
    80002282:	fffff097          	auipc	ra,0xfffff
    80002286:	a26080e7          	jalr	-1498(ra) # 80000ca8 <release>
  sched();
    8000228a:	00000097          	auipc	ra,0x0
    8000228e:	cfc080e7          	jalr	-772(ra) # 80001f86 <sched>
  panic("zombie exit");
    80002292:	00006517          	auipc	a0,0x6
    80002296:	fde50513          	add	a0,a0,-34 # 80008270 <digits+0x230>
    8000229a:	ffffe097          	auipc	ra,0xffffe
    8000229e:	2a2080e7          	jalr	674(ra) # 8000053c <panic>

00000000800022a2 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    800022a2:	7179                	add	sp,sp,-48
    800022a4:	f406                	sd	ra,40(sp)
    800022a6:	f022                	sd	s0,32(sp)
    800022a8:	ec26                	sd	s1,24(sp)
    800022aa:	e84a                	sd	s2,16(sp)
    800022ac:	e44e                	sd	s3,8(sp)
    800022ae:	1800                	add	s0,sp,48
    800022b0:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    800022b2:	0000f497          	auipc	s1,0xf
    800022b6:	dce48493          	add	s1,s1,-562 # 80011080 <proc>
    800022ba:	00015997          	auipc	s3,0x15
    800022be:	9c698993          	add	s3,s3,-1594 # 80016c80 <tickslock>
    acquire(&p->lock);
    800022c2:	8526                	mv	a0,s1
    800022c4:	fffff097          	auipc	ra,0xfffff
    800022c8:	930080e7          	jalr	-1744(ra) # 80000bf4 <acquire>
    if(p->pid == pid){
    800022cc:	589c                	lw	a5,48(s1)
    800022ce:	01278d63          	beq	a5,s2,800022e8 <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    800022d2:	8526                	mv	a0,s1
    800022d4:	fffff097          	auipc	ra,0xfffff
    800022d8:	9d4080e7          	jalr	-1580(ra) # 80000ca8 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    800022dc:	17048493          	add	s1,s1,368
    800022e0:	ff3491e3          	bne	s1,s3,800022c2 <kill+0x20>
  }
  return -1;
    800022e4:	557d                	li	a0,-1
    800022e6:	a829                	j	80002300 <kill+0x5e>
      p->killed = 1;
    800022e8:	4785                	li	a5,1
    800022ea:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    800022ec:	4c98                	lw	a4,24(s1)
    800022ee:	4789                	li	a5,2
    800022f0:	00f70f63          	beq	a4,a5,8000230e <kill+0x6c>
      release(&p->lock);
    800022f4:	8526                	mv	a0,s1
    800022f6:	fffff097          	auipc	ra,0xfffff
    800022fa:	9b2080e7          	jalr	-1614(ra) # 80000ca8 <release>
      return 0;
    800022fe:	4501                	li	a0,0
}
    80002300:	70a2                	ld	ra,40(sp)
    80002302:	7402                	ld	s0,32(sp)
    80002304:	64e2                	ld	s1,24(sp)
    80002306:	6942                	ld	s2,16(sp)
    80002308:	69a2                	ld	s3,8(sp)
    8000230a:	6145                	add	sp,sp,48
    8000230c:	8082                	ret
        p->state = RUNNABLE;
    8000230e:	478d                	li	a5,3
    80002310:	cc9c                	sw	a5,24(s1)
    80002312:	b7cd                	j	800022f4 <kill+0x52>

0000000080002314 <setkilled>:

void
setkilled(struct proc *p)
{
    80002314:	1101                	add	sp,sp,-32
    80002316:	ec06                	sd	ra,24(sp)
    80002318:	e822                	sd	s0,16(sp)
    8000231a:	e426                	sd	s1,8(sp)
    8000231c:	1000                	add	s0,sp,32
    8000231e:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80002320:	fffff097          	auipc	ra,0xfffff
    80002324:	8d4080e7          	jalr	-1836(ra) # 80000bf4 <acquire>
  p->killed = 1;
    80002328:	4785                	li	a5,1
    8000232a:	d49c                	sw	a5,40(s1)
  release(&p->lock);
    8000232c:	8526                	mv	a0,s1
    8000232e:	fffff097          	auipc	ra,0xfffff
    80002332:	97a080e7          	jalr	-1670(ra) # 80000ca8 <release>
}
    80002336:	60e2                	ld	ra,24(sp)
    80002338:	6442                	ld	s0,16(sp)
    8000233a:	64a2                	ld	s1,8(sp)
    8000233c:	6105                	add	sp,sp,32
    8000233e:	8082                	ret

0000000080002340 <killed>:

int
killed(struct proc *p)
{
    80002340:	1101                	add	sp,sp,-32
    80002342:	ec06                	sd	ra,24(sp)
    80002344:	e822                	sd	s0,16(sp)
    80002346:	e426                	sd	s1,8(sp)
    80002348:	e04a                	sd	s2,0(sp)
    8000234a:	1000                	add	s0,sp,32
    8000234c:	84aa                	mv	s1,a0
  int k;
  
  acquire(&p->lock);
    8000234e:	fffff097          	auipc	ra,0xfffff
    80002352:	8a6080e7          	jalr	-1882(ra) # 80000bf4 <acquire>
  k = p->killed;
    80002356:	0284a903          	lw	s2,40(s1)
  release(&p->lock);
    8000235a:	8526                	mv	a0,s1
    8000235c:	fffff097          	auipc	ra,0xfffff
    80002360:	94c080e7          	jalr	-1716(ra) # 80000ca8 <release>
  return k;
}
    80002364:	854a                	mv	a0,s2
    80002366:	60e2                	ld	ra,24(sp)
    80002368:	6442                	ld	s0,16(sp)
    8000236a:	64a2                	ld	s1,8(sp)
    8000236c:	6902                	ld	s2,0(sp)
    8000236e:	6105                	add	sp,sp,32
    80002370:	8082                	ret

0000000080002372 <wait>:
{
    80002372:	715d                	add	sp,sp,-80
    80002374:	e486                	sd	ra,72(sp)
    80002376:	e0a2                	sd	s0,64(sp)
    80002378:	fc26                	sd	s1,56(sp)
    8000237a:	f84a                	sd	s2,48(sp)
    8000237c:	f44e                	sd	s3,40(sp)
    8000237e:	f052                	sd	s4,32(sp)
    80002380:	ec56                	sd	s5,24(sp)
    80002382:	e85a                	sd	s6,16(sp)
    80002384:	e45e                	sd	s7,8(sp)
    80002386:	e062                	sd	s8,0(sp)
    80002388:	0880                	add	s0,sp,80
    8000238a:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    8000238c:	fffff097          	auipc	ra,0xfffff
    80002390:	63c080e7          	jalr	1596(ra) # 800019c8 <myproc>
    80002394:	892a                	mv	s2,a0
  acquire(&wait_lock);
    80002396:	0000f517          	auipc	a0,0xf
    8000239a:	8d250513          	add	a0,a0,-1838 # 80010c68 <wait_lock>
    8000239e:	fffff097          	auipc	ra,0xfffff
    800023a2:	856080e7          	jalr	-1962(ra) # 80000bf4 <acquire>
    havekids = 0;
    800023a6:	4b81                	li	s7,0
        if(pp->state == ZOMBIE){
    800023a8:	4a15                	li	s4,5
        havekids = 1;
    800023aa:	4a85                	li	s5,1
    for(pp = proc; pp < &proc[NPROC]; pp++){
    800023ac:	00015997          	auipc	s3,0x15
    800023b0:	8d498993          	add	s3,s3,-1836 # 80016c80 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800023b4:	0000fc17          	auipc	s8,0xf
    800023b8:	8b4c0c13          	add	s8,s8,-1868 # 80010c68 <wait_lock>
    800023bc:	a0d1                	j	80002480 <wait+0x10e>
          pid = pp->pid;
    800023be:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    800023c2:	000b0e63          	beqz	s6,800023de <wait+0x6c>
    800023c6:	4691                	li	a3,4
    800023c8:	02c48613          	add	a2,s1,44
    800023cc:	85da                	mv	a1,s6
    800023ce:	05093503          	ld	a0,80(s2)
    800023d2:	fffff097          	auipc	ra,0xfffff
    800023d6:	2b6080e7          	jalr	694(ra) # 80001688 <copyout>
    800023da:	04054163          	bltz	a0,8000241c <wait+0xaa>
          freeproc(pp);
    800023de:	8526                	mv	a0,s1
    800023e0:	fffff097          	auipc	ra,0xfffff
    800023e4:	79a080e7          	jalr	1946(ra) # 80001b7a <freeproc>
          release(&pp->lock);
    800023e8:	8526                	mv	a0,s1
    800023ea:	fffff097          	auipc	ra,0xfffff
    800023ee:	8be080e7          	jalr	-1858(ra) # 80000ca8 <release>
          release(&wait_lock);
    800023f2:	0000f517          	auipc	a0,0xf
    800023f6:	87650513          	add	a0,a0,-1930 # 80010c68 <wait_lock>
    800023fa:	fffff097          	auipc	ra,0xfffff
    800023fe:	8ae080e7          	jalr	-1874(ra) # 80000ca8 <release>
}
    80002402:	854e                	mv	a0,s3
    80002404:	60a6                	ld	ra,72(sp)
    80002406:	6406                	ld	s0,64(sp)
    80002408:	74e2                	ld	s1,56(sp)
    8000240a:	7942                	ld	s2,48(sp)
    8000240c:	79a2                	ld	s3,40(sp)
    8000240e:	7a02                	ld	s4,32(sp)
    80002410:	6ae2                	ld	s5,24(sp)
    80002412:	6b42                	ld	s6,16(sp)
    80002414:	6ba2                	ld	s7,8(sp)
    80002416:	6c02                	ld	s8,0(sp)
    80002418:	6161                	add	sp,sp,80
    8000241a:	8082                	ret
            release(&pp->lock);
    8000241c:	8526                	mv	a0,s1
    8000241e:	fffff097          	auipc	ra,0xfffff
    80002422:	88a080e7          	jalr	-1910(ra) # 80000ca8 <release>
            release(&wait_lock);
    80002426:	0000f517          	auipc	a0,0xf
    8000242a:	84250513          	add	a0,a0,-1982 # 80010c68 <wait_lock>
    8000242e:	fffff097          	auipc	ra,0xfffff
    80002432:	87a080e7          	jalr	-1926(ra) # 80000ca8 <release>
            return -1;
    80002436:	59fd                	li	s3,-1
    80002438:	b7e9                	j	80002402 <wait+0x90>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    8000243a:	17048493          	add	s1,s1,368
    8000243e:	03348463          	beq	s1,s3,80002466 <wait+0xf4>
      if(pp->parent == p){
    80002442:	7c9c                	ld	a5,56(s1)
    80002444:	ff279be3          	bne	a5,s2,8000243a <wait+0xc8>
        acquire(&pp->lock);
    80002448:	8526                	mv	a0,s1
    8000244a:	ffffe097          	auipc	ra,0xffffe
    8000244e:	7aa080e7          	jalr	1962(ra) # 80000bf4 <acquire>
        if(pp->state == ZOMBIE){
    80002452:	4c9c                	lw	a5,24(s1)
    80002454:	f74785e3          	beq	a5,s4,800023be <wait+0x4c>
        release(&pp->lock);
    80002458:	8526                	mv	a0,s1
    8000245a:	fffff097          	auipc	ra,0xfffff
    8000245e:	84e080e7          	jalr	-1970(ra) # 80000ca8 <release>
        havekids = 1;
    80002462:	8756                	mv	a4,s5
    80002464:	bfd9                	j	8000243a <wait+0xc8>
    if(!havekids || killed(p)){
    80002466:	c31d                	beqz	a4,8000248c <wait+0x11a>
    80002468:	854a                	mv	a0,s2
    8000246a:	00000097          	auipc	ra,0x0
    8000246e:	ed6080e7          	jalr	-298(ra) # 80002340 <killed>
    80002472:	ed09                	bnez	a0,8000248c <wait+0x11a>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80002474:	85e2                	mv	a1,s8
    80002476:	854a                	mv	a0,s2
    80002478:	00000097          	auipc	ra,0x0
    8000247c:	c20080e7          	jalr	-992(ra) # 80002098 <sleep>
    havekids = 0;
    80002480:	875e                	mv	a4,s7
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80002482:	0000f497          	auipc	s1,0xf
    80002486:	bfe48493          	add	s1,s1,-1026 # 80011080 <proc>
    8000248a:	bf65                	j	80002442 <wait+0xd0>
      release(&wait_lock);
    8000248c:	0000e517          	auipc	a0,0xe
    80002490:	7dc50513          	add	a0,a0,2012 # 80010c68 <wait_lock>
    80002494:	fffff097          	auipc	ra,0xfffff
    80002498:	814080e7          	jalr	-2028(ra) # 80000ca8 <release>
      return -1;
    8000249c:	59fd                	li	s3,-1
    8000249e:	b795                	j	80002402 <wait+0x90>

00000000800024a0 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    800024a0:	7179                	add	sp,sp,-48
    800024a2:	f406                	sd	ra,40(sp)
    800024a4:	f022                	sd	s0,32(sp)
    800024a6:	ec26                	sd	s1,24(sp)
    800024a8:	e84a                	sd	s2,16(sp)
    800024aa:	e44e                	sd	s3,8(sp)
    800024ac:	e052                	sd	s4,0(sp)
    800024ae:	1800                	add	s0,sp,48
    800024b0:	84aa                	mv	s1,a0
    800024b2:	892e                	mv	s2,a1
    800024b4:	89b2                	mv	s3,a2
    800024b6:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800024b8:	fffff097          	auipc	ra,0xfffff
    800024bc:	510080e7          	jalr	1296(ra) # 800019c8 <myproc>
  if(user_dst){
    800024c0:	c08d                	beqz	s1,800024e2 <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    800024c2:	86d2                	mv	a3,s4
    800024c4:	864e                	mv	a2,s3
    800024c6:	85ca                	mv	a1,s2
    800024c8:	6928                	ld	a0,80(a0)
    800024ca:	fffff097          	auipc	ra,0xfffff
    800024ce:	1be080e7          	jalr	446(ra) # 80001688 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    800024d2:	70a2                	ld	ra,40(sp)
    800024d4:	7402                	ld	s0,32(sp)
    800024d6:	64e2                	ld	s1,24(sp)
    800024d8:	6942                	ld	s2,16(sp)
    800024da:	69a2                	ld	s3,8(sp)
    800024dc:	6a02                	ld	s4,0(sp)
    800024de:	6145                	add	sp,sp,48
    800024e0:	8082                	ret
    memmove((char *)dst, src, len);
    800024e2:	000a061b          	sext.w	a2,s4
    800024e6:	85ce                	mv	a1,s3
    800024e8:	854a                	mv	a0,s2
    800024ea:	fffff097          	auipc	ra,0xfffff
    800024ee:	862080e7          	jalr	-1950(ra) # 80000d4c <memmove>
    return 0;
    800024f2:	8526                	mv	a0,s1
    800024f4:	bff9                	j	800024d2 <either_copyout+0x32>

00000000800024f6 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    800024f6:	7179                	add	sp,sp,-48
    800024f8:	f406                	sd	ra,40(sp)
    800024fa:	f022                	sd	s0,32(sp)
    800024fc:	ec26                	sd	s1,24(sp)
    800024fe:	e84a                	sd	s2,16(sp)
    80002500:	e44e                	sd	s3,8(sp)
    80002502:	e052                	sd	s4,0(sp)
    80002504:	1800                	add	s0,sp,48
    80002506:	892a                	mv	s2,a0
    80002508:	84ae                	mv	s1,a1
    8000250a:	89b2                	mv	s3,a2
    8000250c:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    8000250e:	fffff097          	auipc	ra,0xfffff
    80002512:	4ba080e7          	jalr	1210(ra) # 800019c8 <myproc>
  if(user_src){
    80002516:	c08d                	beqz	s1,80002538 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80002518:	86d2                	mv	a3,s4
    8000251a:	864e                	mv	a2,s3
    8000251c:	85ca                	mv	a1,s2
    8000251e:	6928                	ld	a0,80(a0)
    80002520:	fffff097          	auipc	ra,0xfffff
    80002524:	1f4080e7          	jalr	500(ra) # 80001714 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80002528:	70a2                	ld	ra,40(sp)
    8000252a:	7402                	ld	s0,32(sp)
    8000252c:	64e2                	ld	s1,24(sp)
    8000252e:	6942                	ld	s2,16(sp)
    80002530:	69a2                	ld	s3,8(sp)
    80002532:	6a02                	ld	s4,0(sp)
    80002534:	6145                	add	sp,sp,48
    80002536:	8082                	ret
    memmove(dst, (char*)src, len);
    80002538:	000a061b          	sext.w	a2,s4
    8000253c:	85ce                	mv	a1,s3
    8000253e:	854a                	mv	a0,s2
    80002540:	fffff097          	auipc	ra,0xfffff
    80002544:	80c080e7          	jalr	-2036(ra) # 80000d4c <memmove>
    return 0;
    80002548:	8526                	mv	a0,s1
    8000254a:	bff9                	j	80002528 <either_copyin+0x32>

000000008000254c <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    8000254c:	715d                	add	sp,sp,-80
    8000254e:	e486                	sd	ra,72(sp)
    80002550:	e0a2                	sd	s0,64(sp)
    80002552:	fc26                	sd	s1,56(sp)
    80002554:	f84a                	sd	s2,48(sp)
    80002556:	f44e                	sd	s3,40(sp)
    80002558:	f052                	sd	s4,32(sp)
    8000255a:	ec56                	sd	s5,24(sp)
    8000255c:	e85a                	sd	s6,16(sp)
    8000255e:	e45e                	sd	s7,8(sp)
    80002560:	0880                	add	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80002562:	00006517          	auipc	a0,0x6
    80002566:	b6650513          	add	a0,a0,-1178 # 800080c8 <digits+0x88>
    8000256a:	ffffe097          	auipc	ra,0xffffe
    8000256e:	01c080e7          	jalr	28(ra) # 80000586 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80002572:	0000f497          	auipc	s1,0xf
    80002576:	c6648493          	add	s1,s1,-922 # 800111d8 <proc+0x158>
    8000257a:	00015917          	auipc	s2,0x15
    8000257e:	85e90913          	add	s2,s2,-1954 # 80016dd8 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002582:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80002584:	00006997          	auipc	s3,0x6
    80002588:	cfc98993          	add	s3,s3,-772 # 80008280 <digits+0x240>
    printf("%d %s %s", p->pid, state, p->name);
    8000258c:	00006a97          	auipc	s5,0x6
    80002590:	cfca8a93          	add	s5,s5,-772 # 80008288 <digits+0x248>
    printf("\n");
    80002594:	00006a17          	auipc	s4,0x6
    80002598:	b34a0a13          	add	s4,s4,-1228 # 800080c8 <digits+0x88>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    8000259c:	00006b97          	auipc	s7,0x6
    800025a0:	d64b8b93          	add	s7,s7,-668 # 80008300 <states.0>
    800025a4:	a00d                	j	800025c6 <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    800025a6:	ed86a583          	lw	a1,-296(a3)
    800025aa:	8556                	mv	a0,s5
    800025ac:	ffffe097          	auipc	ra,0xffffe
    800025b0:	fda080e7          	jalr	-38(ra) # 80000586 <printf>
    printf("\n");
    800025b4:	8552                	mv	a0,s4
    800025b6:	ffffe097          	auipc	ra,0xffffe
    800025ba:	fd0080e7          	jalr	-48(ra) # 80000586 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    800025be:	17048493          	add	s1,s1,368
    800025c2:	03248263          	beq	s1,s2,800025e6 <procdump+0x9a>
    if(p->state == UNUSED)
    800025c6:	86a6                	mv	a3,s1
    800025c8:	ec04a783          	lw	a5,-320(s1)
    800025cc:	dbed                	beqz	a5,800025be <procdump+0x72>
      state = "???";
    800025ce:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800025d0:	fcfb6be3          	bltu	s6,a5,800025a6 <procdump+0x5a>
    800025d4:	02079713          	sll	a4,a5,0x20
    800025d8:	01d75793          	srl	a5,a4,0x1d
    800025dc:	97de                	add	a5,a5,s7
    800025de:	6390                	ld	a2,0(a5)
    800025e0:	f279                	bnez	a2,800025a6 <procdump+0x5a>
      state = "???";
    800025e2:	864e                	mv	a2,s3
    800025e4:	b7c9                	j	800025a6 <procdump+0x5a>
  }
}
    800025e6:	60a6                	ld	ra,72(sp)
    800025e8:	6406                	ld	s0,64(sp)
    800025ea:	74e2                	ld	s1,56(sp)
    800025ec:	7942                	ld	s2,48(sp)
    800025ee:	79a2                	ld	s3,40(sp)
    800025f0:	7a02                	ld	s4,32(sp)
    800025f2:	6ae2                	ld	s5,24(sp)
    800025f4:	6b42                	ld	s6,16(sp)
    800025f6:	6ba2                	ld	s7,8(sp)
    800025f8:	6161                	add	sp,sp,80
    800025fa:	8082                	ret

00000000800025fc <thread_create>:

int
thread_create(void(*fcn)(void*), void *arg, void*stack)
{
    800025fc:	715d                	add	sp,sp,-80
    800025fe:	e486                	sd	ra,72(sp)
    80002600:	e0a2                	sd	s0,64(sp)
    80002602:	fc26                	sd	s1,56(sp)
    80002604:	f84a                	sd	s2,48(sp)
    80002606:	f44e                	sd	s3,40(sp)
    80002608:	f052                	sd	s4,32(sp)
    8000260a:	ec56                	sd	s5,24(sp)
    8000260c:	e85a                	sd	s6,16(sp)
    8000260e:	e45e                	sd	s7,8(sp)
    80002610:	0880                	add	s0,sp,80
    80002612:	8a2a                	mv	s4,a0
    80002614:	8b2e                	mv	s6,a1
    80002616:	8932                	mv	s2,a2
  int i, pid;
  struct proc *np;
  struct proc *p = myproc();
    80002618:	fffff097          	auipc	ra,0xfffff
    8000261c:	3b0080e7          	jalr	944(ra) # 800019c8 <myproc>
    80002620:	8aaa                	mv	s5,a0

  // Allocate process.
  if((np = allocproc()) == 0){
    80002622:	fffff097          	auipc	ra,0xfffff
    80002626:	5b0080e7          	jalr	1456(ra) # 80001bd2 <allocproc>
    8000262a:	16050763          	beqz	a0,80002798 <thread_create+0x19c>
    8000262e:	89aa                	mv	s3,a0
    return -1;
  }

  // Copy user memory from parent to child.
  np->pagetable = np->pagetable;
  np->sz = p->sz;
    80002630:	048ab783          	ld	a5,72(s5)
    80002634:	e53c                	sd	a5,72(a0)
  acquire(&wait_lock);
    80002636:	0000e497          	auipc	s1,0xe
    8000263a:	63248493          	add	s1,s1,1586 # 80010c68 <wait_lock>
    8000263e:	8526                	mv	a0,s1
    80002640:	ffffe097          	auipc	ra,0xffffe
    80002644:	5b4080e7          	jalr	1460(ra) # 80000bf4 <acquire>
  np->parent = p;
    80002648:	0359bc23          	sd	s5,56(s3)
  release(&wait_lock);
    8000264c:	8526                	mv	a0,s1
    8000264e:	ffffe097          	auipc	ra,0xffffe
    80002652:	65a080e7          	jalr	1626(ra) # 80000ca8 <release>
  // copy saved user registers.
  *(np->trapframe) = *(p->trapframe);
    80002656:	058ab683          	ld	a3,88(s5)
    8000265a:	87b6                	mv	a5,a3
    8000265c:	0589b703          	ld	a4,88(s3)
    80002660:	12068693          	add	a3,a3,288
    80002664:	0007b803          	ld	a6,0(a5)
    80002668:	6788                	ld	a0,8(a5)
    8000266a:	6b8c                	ld	a1,16(a5)
    8000266c:	6f90                	ld	a2,24(a5)
    8000266e:	01073023          	sd	a6,0(a4)
    80002672:	e708                	sd	a0,8(a4)
    80002674:	eb0c                	sd	a1,16(a4)
    80002676:	ef10                	sd	a2,24(a4)
    80002678:	02078793          	add	a5,a5,32
    8000267c:	02070713          	add	a4,a4,32
    80002680:	fed792e3          	bne	a5,a3,80002664 <thread_create+0x68>
  // np->trapframe->sp = (uint64) stack;
  // np->trapframe->sp += 4096 - 1 * sizeof(void*);


  void *sarg, *sret;
  sret = stack + 4096 - 2 * sizeof(uint64 *);
    80002684:	6485                	lui	s1,0x1
    80002686:	ff048b93          	add	s7,s1,-16 # ff0 <_entry-0x7ffff010>
  printf("stack addr %p\n", sret);
    8000268a:	017905b3          	add	a1,s2,s7
    8000268e:	00006517          	auipc	a0,0x6
    80002692:	c0a50513          	add	a0,a0,-1014 # 80008298 <digits+0x258>
    80002696:	ffffe097          	auipc	ra,0xffffe
    8000269a:	ef0080e7          	jalr	-272(ra) # 80000586 <printf>
  *(uint64*)sret = (uint64)0xFFFFFFF;
    8000269e:	94ca                	add	s1,s1,s2
    800026a0:	100007b7          	lui	a5,0x10000
    800026a4:	17fd                	add	a5,a5,-1 # fffffff <_entry-0x70000001>
    800026a6:	fef4b823          	sd	a5,-16(s1)
  printf("kern 2\n");
    800026aa:	00006517          	auipc	a0,0x6
    800026ae:	bfe50513          	add	a0,a0,-1026 # 800082a8 <digits+0x268>
    800026b2:	ffffe097          	auipc	ra,0xffffe
    800026b6:	ed4080e7          	jalr	-300(ra) # 80000586 <printf>
  sarg = stack + 4096 - 1 * sizeof(void *);
  *(uint64*)sarg = (uint64)arg;
    800026ba:	ff64bc23          	sd	s6,-8(s1)

  np->trapframe->sp = (uint64) stack;
    800026be:	0589b783          	ld	a5,88(s3)
    800026c2:	0327b823          	sd	s2,48(a5)
  np->trapframe->sp += 4096 - 2 * sizeof(void*);
    800026c6:	0589b703          	ld	a4,88(s3)
    800026ca:	7b1c                	ld	a5,48(a4)
    800026cc:	97de                	add	a5,a5,s7
    800026ce:	fb1c                	sd	a5,48(a4)
  np->trapframe->s0 = np->trapframe->sp;
    800026d0:	0589b783          	ld	a5,88(s3)
    800026d4:	7b98                	ld	a4,48(a5)
    800026d6:	f3b8                	sd	a4,96(a5)
  np->trapframe->epc = (uint64) fcn;
    800026d8:	0589b783          	ld	a5,88(s3)
    800026dc:	0147bc23          	sd	s4,24(a5)

  np->is_thread = 1;
    800026e0:	4785                	li	a5,1
    800026e2:	16f9a623          	sw	a5,364(s3)
  // Cause fork to return 0 in the child.
  np->trapframe->a0 = 0;
    800026e6:	0589b783          	ld	a5,88(s3)
    800026ea:	0607b823          	sd	zero,112(a5)
  // increment reference counts on open file descriptors.
  for(i = 0; i < NOFILE; i++)
    800026ee:	0d0a8493          	add	s1,s5,208
    800026f2:	0d098913          	add	s2,s3,208
    800026f6:	150a8a13          	add	s4,s5,336
    800026fa:	a029                	j	80002704 <thread_create+0x108>
    800026fc:	04a1                	add	s1,s1,8
    800026fe:	0921                	add	s2,s2,8
    80002700:	01448b63          	beq	s1,s4,80002716 <thread_create+0x11a>
    if(p->ofile[i])
    80002704:	6088                	ld	a0,0(s1)
    80002706:	d97d                	beqz	a0,800026fc <thread_create+0x100>
      np->ofile[i] = filedup(p->ofile[i]);
    80002708:	00002097          	auipc	ra,0x2
    8000270c:	350080e7          	jalr	848(ra) # 80004a58 <filedup>
    80002710:	00a93023          	sd	a0,0(s2)
    80002714:	b7e5                	j	800026fc <thread_create+0x100>
  np->cwd = idup(p->cwd);
    80002716:	150ab503          	ld	a0,336(s5)
    8000271a:	00001097          	auipc	ra,0x1
    8000271e:	4e8080e7          	jalr	1256(ra) # 80003c02 <idup>
    80002722:	14a9b823          	sd	a0,336(s3)
  printf("kern here4");
    80002726:	00006517          	auipc	a0,0x6
    8000272a:	b8a50513          	add	a0,a0,-1142 # 800082b0 <digits+0x270>
    8000272e:	ffffe097          	auipc	ra,0xffffe
    80002732:	e58080e7          	jalr	-424(ra) # 80000586 <printf>
  safestrcpy(np->name, p->name, sizeof(p->name));
    80002736:	4641                	li	a2,16
    80002738:	158a8593          	add	a1,s5,344
    8000273c:	15898513          	add	a0,s3,344
    80002740:	ffffe097          	auipc	ra,0xffffe
    80002744:	6f8080e7          	jalr	1784(ra) # 80000e38 <safestrcpy>

  pid = np->pid;
    80002748:	0309a483          	lw	s1,48(s3)

  release(&np->lock);
    8000274c:	854e                	mv	a0,s3
    8000274e:	ffffe097          	auipc	ra,0xffffe
    80002752:	55a080e7          	jalr	1370(ra) # 80000ca8 <release>

  

  acquire(&np->lock);
    80002756:	854e                	mv	a0,s3
    80002758:	ffffe097          	auipc	ra,0xffffe
    8000275c:	49c080e7          	jalr	1180(ra) # 80000bf4 <acquire>
  np->state = RUNNABLE;
    80002760:	478d                	li	a5,3
    80002762:	00f9ac23          	sw	a5,24(s3)
  release(&np->lock);
    80002766:	854e                	mv	a0,s3
    80002768:	ffffe097          	auipc	ra,0xffffe
    8000276c:	540080e7          	jalr	1344(ra) # 80000ca8 <release>
  printf("kern here5");
    80002770:	00006517          	auipc	a0,0x6
    80002774:	b5050513          	add	a0,a0,-1200 # 800082c0 <digits+0x280>
    80002778:	ffffe097          	auipc	ra,0xffffe
    8000277c:	e0e080e7          	jalr	-498(ra) # 80000586 <printf>
  return pid;
}
    80002780:	8526                	mv	a0,s1
    80002782:	60a6                	ld	ra,72(sp)
    80002784:	6406                	ld	s0,64(sp)
    80002786:	74e2                	ld	s1,56(sp)
    80002788:	7942                	ld	s2,48(sp)
    8000278a:	79a2                	ld	s3,40(sp)
    8000278c:	7a02                	ld	s4,32(sp)
    8000278e:	6ae2                	ld	s5,24(sp)
    80002790:	6b42                	ld	s6,16(sp)
    80002792:	6ba2                	ld	s7,8(sp)
    80002794:	6161                	add	sp,sp,80
    80002796:	8082                	ret
    return -1;
    80002798:	54fd                	li	s1,-1
    8000279a:	b7dd                	j	80002780 <thread_create+0x184>

000000008000279c <thread_join>:

int
thread_join(void)
{
    8000279c:	715d                	add	sp,sp,-80
    8000279e:	e486                	sd	ra,72(sp)
    800027a0:	e0a2                	sd	s0,64(sp)
    800027a2:	fc26                	sd	s1,56(sp)
    800027a4:	f84a                	sd	s2,48(sp)
    800027a6:	f44e                	sd	s3,40(sp)
    800027a8:	f052                	sd	s4,32(sp)
    800027aa:	ec56                	sd	s5,24(sp)
    800027ac:	e85a                	sd	s6,16(sp)
    800027ae:	e45e                	sd	s7,8(sp)
    800027b0:	0880                	add	s0,sp,80
  struct proc *pp;
  int havekids, pid;
  struct proc *p = myproc();
    800027b2:	fffff097          	auipc	ra,0xfffff
    800027b6:	216080e7          	jalr	534(ra) # 800019c8 <myproc>
    800027ba:	892a                	mv	s2,a0

  acquire(&wait_lock);
    800027bc:	0000e517          	auipc	a0,0xe
    800027c0:	4ac50513          	add	a0,a0,1196 # 80010c68 <wait_lock>
    800027c4:	ffffe097          	auipc	ra,0xffffe
    800027c8:	430080e7          	jalr	1072(ra) # 80000bf4 <acquire>

  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    800027cc:	4b01                	li	s6,0
      if(pp->parent == p){
        // make sure the child isn't still in exit() or swtch().
        acquire(&pp->lock);

        havekids = 1;
        if(pp->state == ZOMBIE){
    800027ce:	4a15                	li	s4,5
        havekids = 1;
    800027d0:	4a85                	li	s5,1
    for(pp = proc; pp < &proc[NPROC]; pp++){
    800027d2:	00014997          	auipc	s3,0x14
    800027d6:	4ae98993          	add	s3,s3,1198 # 80016c80 <tickslock>
      release(&wait_lock);
      return -1;
    }
    
    // Wait for a child to exit.
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800027da:	0000eb97          	auipc	s7,0xe
    800027de:	48eb8b93          	add	s7,s7,1166 # 80010c68 <wait_lock>
    800027e2:	a061                	j	8000286a <thread_join+0xce>
          pid = pp->pid;
    800027e4:	0304a903          	lw	s2,48(s1)
          freeproc(pp);
    800027e8:	8526                	mv	a0,s1
    800027ea:	fffff097          	auipc	ra,0xfffff
    800027ee:	390080e7          	jalr	912(ra) # 80001b7a <freeproc>
          release(&pp->lock);
    800027f2:	8526                	mv	a0,s1
    800027f4:	ffffe097          	auipc	ra,0xffffe
    800027f8:	4b4080e7          	jalr	1204(ra) # 80000ca8 <release>
          release(&wait_lock);
    800027fc:	0000e517          	auipc	a0,0xe
    80002800:	46c50513          	add	a0,a0,1132 # 80010c68 <wait_lock>
    80002804:	ffffe097          	auipc	ra,0xffffe
    80002808:	4a4080e7          	jalr	1188(ra) # 80000ca8 <release>
  }
}
    8000280c:	854a                	mv	a0,s2
    8000280e:	60a6                	ld	ra,72(sp)
    80002810:	6406                	ld	s0,64(sp)
    80002812:	74e2                	ld	s1,56(sp)
    80002814:	7942                	ld	s2,48(sp)
    80002816:	79a2                	ld	s3,40(sp)
    80002818:	7a02                	ld	s4,32(sp)
    8000281a:	6ae2                	ld	s5,24(sp)
    8000281c:	6b42                	ld	s6,16(sp)
    8000281e:	6ba2                	ld	s7,8(sp)
    80002820:	6161                	add	sp,sp,80
    80002822:	8082                	ret
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80002824:	17048493          	add	s1,s1,368
    80002828:	03348463          	beq	s1,s3,80002850 <thread_join+0xb4>
      if(pp->parent == p){
    8000282c:	7c9c                	ld	a5,56(s1)
    8000282e:	ff279be3          	bne	a5,s2,80002824 <thread_join+0x88>
        acquire(&pp->lock);
    80002832:	8526                	mv	a0,s1
    80002834:	ffffe097          	auipc	ra,0xffffe
    80002838:	3c0080e7          	jalr	960(ra) # 80000bf4 <acquire>
        if(pp->state == ZOMBIE){
    8000283c:	4c9c                	lw	a5,24(s1)
    8000283e:	fb4783e3          	beq	a5,s4,800027e4 <thread_join+0x48>
        release(&pp->lock);
    80002842:	8526                	mv	a0,s1
    80002844:	ffffe097          	auipc	ra,0xffffe
    80002848:	464080e7          	jalr	1124(ra) # 80000ca8 <release>
        havekids = 1;
    8000284c:	8756                	mv	a4,s5
    8000284e:	bfd9                	j	80002824 <thread_join+0x88>
    if(!havekids || killed(p)){
    80002850:	c31d                	beqz	a4,80002876 <thread_join+0xda>
    80002852:	854a                	mv	a0,s2
    80002854:	00000097          	auipc	ra,0x0
    80002858:	aec080e7          	jalr	-1300(ra) # 80002340 <killed>
    8000285c:	ed09                	bnez	a0,80002876 <thread_join+0xda>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    8000285e:	85de                	mv	a1,s7
    80002860:	854a                	mv	a0,s2
    80002862:	00000097          	auipc	ra,0x0
    80002866:	836080e7          	jalr	-1994(ra) # 80002098 <sleep>
    havekids = 0;
    8000286a:	875a                	mv	a4,s6
    for(pp = proc; pp < &proc[NPROC]; pp++){
    8000286c:	0000f497          	auipc	s1,0xf
    80002870:	81448493          	add	s1,s1,-2028 # 80011080 <proc>
    80002874:	bf65                	j	8000282c <thread_join+0x90>
      release(&wait_lock);
    80002876:	0000e517          	auipc	a0,0xe
    8000287a:	3f250513          	add	a0,a0,1010 # 80010c68 <wait_lock>
    8000287e:	ffffe097          	auipc	ra,0xffffe
    80002882:	42a080e7          	jalr	1066(ra) # 80000ca8 <release>
      return -1;
    80002886:	597d                	li	s2,-1
    80002888:	b751                	j	8000280c <thread_join+0x70>

000000008000288a <thread_exit>:

int
thread_exit(int status)
{
    8000288a:	7179                	add	sp,sp,-48
    8000288c:	f406                	sd	ra,40(sp)
    8000288e:	f022                	sd	s0,32(sp)
    80002890:	ec26                	sd	s1,24(sp)
    80002892:	e84a                	sd	s2,16(sp)
    80002894:	e44e                	sd	s3,8(sp)
    80002896:	e052                	sd	s4,0(sp)
    80002898:	1800                	add	s0,sp,48
    8000289a:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    8000289c:	fffff097          	auipc	ra,0xfffff
    800028a0:	12c080e7          	jalr	300(ra) # 800019c8 <myproc>
    800028a4:	89aa                	mv	s3,a0

  if(p == initproc)
    800028a6:	00006797          	auipc	a5,0x6
    800028aa:	1327b783          	ld	a5,306(a5) # 800089d8 <initproc>
    800028ae:	0d050493          	add	s1,a0,208
    800028b2:	15050913          	add	s2,a0,336
    800028b6:	02a79363          	bne	a5,a0,800028dc <thread_exit+0x52>
    panic("init exiting");
    800028ba:	00006517          	auipc	a0,0x6
    800028be:	9a650513          	add	a0,a0,-1626 # 80008260 <digits+0x220>
    800028c2:	ffffe097          	auipc	ra,0xffffe
    800028c6:	c7a080e7          	jalr	-902(ra) # 8000053c <panic>

  // Close all open files.
  for(int fd = 0; fd < NOFILE; fd++){
    if(p->ofile[fd]){
      struct file *f = p->ofile[fd];
      fileclose(f);
    800028ca:	00002097          	auipc	ra,0x2
    800028ce:	1e0080e7          	jalr	480(ra) # 80004aaa <fileclose>
      p->ofile[fd] = 0;
    800028d2:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    800028d6:	04a1                	add	s1,s1,8
    800028d8:	01248563          	beq	s1,s2,800028e2 <thread_exit+0x58>
    if(p->ofile[fd]){
    800028dc:	6088                	ld	a0,0(s1)
    800028de:	f575                	bnez	a0,800028ca <thread_exit+0x40>
    800028e0:	bfdd                	j	800028d6 <thread_exit+0x4c>
    }
  }

  begin_op();
    800028e2:	00002097          	auipc	ra,0x2
    800028e6:	d04080e7          	jalr	-764(ra) # 800045e6 <begin_op>
  iput(p->cwd);
    800028ea:	1509b503          	ld	a0,336(s3)
    800028ee:	00001097          	auipc	ra,0x1
    800028f2:	50c080e7          	jalr	1292(ra) # 80003dfa <iput>
  end_op();
    800028f6:	00002097          	auipc	ra,0x2
    800028fa:	d6a080e7          	jalr	-662(ra) # 80004660 <end_op>
  p->cwd = 0;
    800028fe:	1409b823          	sd	zero,336(s3)

  acquire(&wait_lock);
    80002902:	0000e497          	auipc	s1,0xe
    80002906:	36648493          	add	s1,s1,870 # 80010c68 <wait_lock>
    8000290a:	8526                	mv	a0,s1
    8000290c:	ffffe097          	auipc	ra,0xffffe
    80002910:	2e8080e7          	jalr	744(ra) # 80000bf4 <acquire>

  // Give any children to init.
  reparent(p);
    80002914:	854e                	mv	a0,s3
    80002916:	00000097          	auipc	ra,0x0
    8000291a:	85c080e7          	jalr	-1956(ra) # 80002172 <reparent>

  // Parent might be sleeping in wait().
  wakeup(p->parent);
    8000291e:	0389b503          	ld	a0,56(s3)
    80002922:	fffff097          	auipc	ra,0xfffff
    80002926:	7da080e7          	jalr	2010(ra) # 800020fc <wakeup>
  
  acquire(&p->lock);
    8000292a:	854e                	mv	a0,s3
    8000292c:	ffffe097          	auipc	ra,0xffffe
    80002930:	2c8080e7          	jalr	712(ra) # 80000bf4 <acquire>

  p->xstate = status;
    80002934:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    80002938:	4795                	li	a5,5
    8000293a:	00f9ac23          	sw	a5,24(s3)

  release(&wait_lock);
    8000293e:	8526                	mv	a0,s1
    80002940:	ffffe097          	auipc	ra,0xffffe
    80002944:	368080e7          	jalr	872(ra) # 80000ca8 <release>

  // Jump into the scheduler, never to return.
  sched();
    80002948:	fffff097          	auipc	ra,0xfffff
    8000294c:	63e080e7          	jalr	1598(ra) # 80001f86 <sched>
  panic("zombie exit");
    80002950:	00006517          	auipc	a0,0x6
    80002954:	92050513          	add	a0,a0,-1760 # 80008270 <digits+0x230>
    80002958:	ffffe097          	auipc	ra,0xffffe
    8000295c:	be4080e7          	jalr	-1052(ra) # 8000053c <panic>

0000000080002960 <swtch>:
    80002960:	00153023          	sd	ra,0(a0)
    80002964:	00253423          	sd	sp,8(a0)
    80002968:	e900                	sd	s0,16(a0)
    8000296a:	ed04                	sd	s1,24(a0)
    8000296c:	03253023          	sd	s2,32(a0)
    80002970:	03353423          	sd	s3,40(a0)
    80002974:	03453823          	sd	s4,48(a0)
    80002978:	03553c23          	sd	s5,56(a0)
    8000297c:	05653023          	sd	s6,64(a0)
    80002980:	05753423          	sd	s7,72(a0)
    80002984:	05853823          	sd	s8,80(a0)
    80002988:	05953c23          	sd	s9,88(a0)
    8000298c:	07a53023          	sd	s10,96(a0)
    80002990:	07b53423          	sd	s11,104(a0)
    80002994:	0005b083          	ld	ra,0(a1)
    80002998:	0085b103          	ld	sp,8(a1)
    8000299c:	6980                	ld	s0,16(a1)
    8000299e:	6d84                	ld	s1,24(a1)
    800029a0:	0205b903          	ld	s2,32(a1)
    800029a4:	0285b983          	ld	s3,40(a1)
    800029a8:	0305ba03          	ld	s4,48(a1)
    800029ac:	0385ba83          	ld	s5,56(a1)
    800029b0:	0405bb03          	ld	s6,64(a1)
    800029b4:	0485bb83          	ld	s7,72(a1)
    800029b8:	0505bc03          	ld	s8,80(a1)
    800029bc:	0585bc83          	ld	s9,88(a1)
    800029c0:	0605bd03          	ld	s10,96(a1)
    800029c4:	0685bd83          	ld	s11,104(a1)
    800029c8:	8082                	ret

00000000800029ca <trapinit>:

extern int devintr();

void
trapinit(void)
{
    800029ca:	1141                	add	sp,sp,-16
    800029cc:	e406                	sd	ra,8(sp)
    800029ce:	e022                	sd	s0,0(sp)
    800029d0:	0800                	add	s0,sp,16
  initlock(&tickslock, "time");
    800029d2:	00006597          	auipc	a1,0x6
    800029d6:	95e58593          	add	a1,a1,-1698 # 80008330 <states.0+0x30>
    800029da:	00014517          	auipc	a0,0x14
    800029de:	2a650513          	add	a0,a0,678 # 80016c80 <tickslock>
    800029e2:	ffffe097          	auipc	ra,0xffffe
    800029e6:	182080e7          	jalr	386(ra) # 80000b64 <initlock>
}
    800029ea:	60a2                	ld	ra,8(sp)
    800029ec:	6402                	ld	s0,0(sp)
    800029ee:	0141                	add	sp,sp,16
    800029f0:	8082                	ret

00000000800029f2 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    800029f2:	1141                	add	sp,sp,-16
    800029f4:	e422                	sd	s0,8(sp)
    800029f6:	0800                	add	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    800029f8:	00003797          	auipc	a5,0x3
    800029fc:	6d878793          	add	a5,a5,1752 # 800060d0 <kernelvec>
    80002a00:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80002a04:	6422                	ld	s0,8(sp)
    80002a06:	0141                	add	sp,sp,16
    80002a08:	8082                	ret

0000000080002a0a <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80002a0a:	1141                	add	sp,sp,-16
    80002a0c:	e406                	sd	ra,8(sp)
    80002a0e:	e022                	sd	s0,0(sp)
    80002a10:	0800                	add	s0,sp,16
  struct proc *p = myproc();
    80002a12:	fffff097          	auipc	ra,0xfffff
    80002a16:	fb6080e7          	jalr	-74(ra) # 800019c8 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002a1a:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80002a1e:	9bf5                	and	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002a20:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    80002a24:	00004697          	auipc	a3,0x4
    80002a28:	5dc68693          	add	a3,a3,1500 # 80007000 <_trampoline>
    80002a2c:	00004717          	auipc	a4,0x4
    80002a30:	5d470713          	add	a4,a4,1492 # 80007000 <_trampoline>
    80002a34:	8f15                	sub	a4,a4,a3
    80002a36:	040007b7          	lui	a5,0x4000
    80002a3a:	17fd                	add	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80002a3c:	07b2                	sll	a5,a5,0xc
    80002a3e:	973e                	add	a4,a4,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002a40:	10571073          	csrw	stvec,a4
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80002a44:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80002a46:	18002673          	csrr	a2,satp
    80002a4a:	e310                	sd	a2,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80002a4c:	6d30                	ld	a2,88(a0)
    80002a4e:	6138                	ld	a4,64(a0)
    80002a50:	6585                	lui	a1,0x1
    80002a52:	972e                	add	a4,a4,a1
    80002a54:	e618                	sd	a4,8(a2)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80002a56:	6d38                	ld	a4,88(a0)
    80002a58:	00000617          	auipc	a2,0x0
    80002a5c:	13460613          	add	a2,a2,308 # 80002b8c <usertrap>
    80002a60:	eb10                	sd	a2,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80002a62:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80002a64:	8612                	mv	a2,tp
    80002a66:	f310                	sd	a2,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002a68:	10002773          	csrr	a4,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80002a6c:	eff77713          	and	a4,a4,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80002a70:	02076713          	or	a4,a4,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002a74:	10071073          	csrw	sstatus,a4
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80002a78:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80002a7a:	6f18                	ld	a4,24(a4)
    80002a7c:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80002a80:	6928                	ld	a0,80(a0)
    80002a82:	8131                	srl	a0,a0,0xc

  // jump to userret in trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80002a84:	00004717          	auipc	a4,0x4
    80002a88:	61870713          	add	a4,a4,1560 # 8000709c <userret>
    80002a8c:	8f15                	sub	a4,a4,a3
    80002a8e:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    80002a90:	577d                	li	a4,-1
    80002a92:	177e                	sll	a4,a4,0x3f
    80002a94:	8d59                	or	a0,a0,a4
    80002a96:	9782                	jalr	a5
}
    80002a98:	60a2                	ld	ra,8(sp)
    80002a9a:	6402                	ld	s0,0(sp)
    80002a9c:	0141                	add	sp,sp,16
    80002a9e:	8082                	ret

0000000080002aa0 <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80002aa0:	1101                	add	sp,sp,-32
    80002aa2:	ec06                	sd	ra,24(sp)
    80002aa4:	e822                	sd	s0,16(sp)
    80002aa6:	e426                	sd	s1,8(sp)
    80002aa8:	1000                	add	s0,sp,32
  acquire(&tickslock);
    80002aaa:	00014497          	auipc	s1,0x14
    80002aae:	1d648493          	add	s1,s1,470 # 80016c80 <tickslock>
    80002ab2:	8526                	mv	a0,s1
    80002ab4:	ffffe097          	auipc	ra,0xffffe
    80002ab8:	140080e7          	jalr	320(ra) # 80000bf4 <acquire>
  ticks++;
    80002abc:	00006517          	auipc	a0,0x6
    80002ac0:	f2450513          	add	a0,a0,-220 # 800089e0 <ticks>
    80002ac4:	411c                	lw	a5,0(a0)
    80002ac6:	2785                	addw	a5,a5,1
    80002ac8:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80002aca:	fffff097          	auipc	ra,0xfffff
    80002ace:	632080e7          	jalr	1586(ra) # 800020fc <wakeup>
  release(&tickslock);
    80002ad2:	8526                	mv	a0,s1
    80002ad4:	ffffe097          	auipc	ra,0xffffe
    80002ad8:	1d4080e7          	jalr	468(ra) # 80000ca8 <release>
}
    80002adc:	60e2                	ld	ra,24(sp)
    80002ade:	6442                	ld	s0,16(sp)
    80002ae0:	64a2                	ld	s1,8(sp)
    80002ae2:	6105                	add	sp,sp,32
    80002ae4:	8082                	ret

0000000080002ae6 <devintr>:
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002ae6:	142027f3          	csrr	a5,scause
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80002aea:	4501                	li	a0,0
  if((scause & 0x8000000000000000L) &&
    80002aec:	0807df63          	bgez	a5,80002b8a <devintr+0xa4>
{
    80002af0:	1101                	add	sp,sp,-32
    80002af2:	ec06                	sd	ra,24(sp)
    80002af4:	e822                	sd	s0,16(sp)
    80002af6:	e426                	sd	s1,8(sp)
    80002af8:	1000                	add	s0,sp,32
     (scause & 0xff) == 9){
    80002afa:	0ff7f713          	zext.b	a4,a5
  if((scause & 0x8000000000000000L) &&
    80002afe:	46a5                	li	a3,9
    80002b00:	00d70d63          	beq	a4,a3,80002b1a <devintr+0x34>
  } else if(scause == 0x8000000000000001L){
    80002b04:	577d                	li	a4,-1
    80002b06:	177e                	sll	a4,a4,0x3f
    80002b08:	0705                	add	a4,a4,1
    return 0;
    80002b0a:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80002b0c:	04e78e63          	beq	a5,a4,80002b68 <devintr+0x82>
  }
}
    80002b10:	60e2                	ld	ra,24(sp)
    80002b12:	6442                	ld	s0,16(sp)
    80002b14:	64a2                	ld	s1,8(sp)
    80002b16:	6105                	add	sp,sp,32
    80002b18:	8082                	ret
    int irq = plic_claim();
    80002b1a:	00003097          	auipc	ra,0x3
    80002b1e:	6be080e7          	jalr	1726(ra) # 800061d8 <plic_claim>
    80002b22:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80002b24:	47a9                	li	a5,10
    80002b26:	02f50763          	beq	a0,a5,80002b54 <devintr+0x6e>
    } else if(irq == VIRTIO0_IRQ){
    80002b2a:	4785                	li	a5,1
    80002b2c:	02f50963          	beq	a0,a5,80002b5e <devintr+0x78>
    return 1;
    80002b30:	4505                	li	a0,1
    } else if(irq){
    80002b32:	dcf9                	beqz	s1,80002b10 <devintr+0x2a>
      printf("unexpected interrupt irq=%d\n", irq);
    80002b34:	85a6                	mv	a1,s1
    80002b36:	00006517          	auipc	a0,0x6
    80002b3a:	80250513          	add	a0,a0,-2046 # 80008338 <states.0+0x38>
    80002b3e:	ffffe097          	auipc	ra,0xffffe
    80002b42:	a48080e7          	jalr	-1464(ra) # 80000586 <printf>
      plic_complete(irq);
    80002b46:	8526                	mv	a0,s1
    80002b48:	00003097          	auipc	ra,0x3
    80002b4c:	6b4080e7          	jalr	1716(ra) # 800061fc <plic_complete>
    return 1;
    80002b50:	4505                	li	a0,1
    80002b52:	bf7d                	j	80002b10 <devintr+0x2a>
      uartintr();
    80002b54:	ffffe097          	auipc	ra,0xffffe
    80002b58:	e40080e7          	jalr	-448(ra) # 80000994 <uartintr>
    if(irq)
    80002b5c:	b7ed                	j	80002b46 <devintr+0x60>
      virtio_disk_intr();
    80002b5e:	00004097          	auipc	ra,0x4
    80002b62:	b64080e7          	jalr	-1180(ra) # 800066c2 <virtio_disk_intr>
    if(irq)
    80002b66:	b7c5                	j	80002b46 <devintr+0x60>
    if(cpuid() == 0){
    80002b68:	fffff097          	auipc	ra,0xfffff
    80002b6c:	e34080e7          	jalr	-460(ra) # 8000199c <cpuid>
    80002b70:	c901                	beqz	a0,80002b80 <devintr+0x9a>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80002b72:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80002b76:	9bf5                	and	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80002b78:	14479073          	csrw	sip,a5
    return 2;
    80002b7c:	4509                	li	a0,2
    80002b7e:	bf49                	j	80002b10 <devintr+0x2a>
      clockintr();
    80002b80:	00000097          	auipc	ra,0x0
    80002b84:	f20080e7          	jalr	-224(ra) # 80002aa0 <clockintr>
    80002b88:	b7ed                	j	80002b72 <devintr+0x8c>
}
    80002b8a:	8082                	ret

0000000080002b8c <usertrap>:
{
    80002b8c:	1101                	add	sp,sp,-32
    80002b8e:	ec06                	sd	ra,24(sp)
    80002b90:	e822                	sd	s0,16(sp)
    80002b92:	e426                	sd	s1,8(sp)
    80002b94:	e04a                	sd	s2,0(sp)
    80002b96:	1000                	add	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002b98:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80002b9c:	1007f793          	and	a5,a5,256
    80002ba0:	e3b1                	bnez	a5,80002be4 <usertrap+0x58>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002ba2:	00003797          	auipc	a5,0x3
    80002ba6:	52e78793          	add	a5,a5,1326 # 800060d0 <kernelvec>
    80002baa:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80002bae:	fffff097          	auipc	ra,0xfffff
    80002bb2:	e1a080e7          	jalr	-486(ra) # 800019c8 <myproc>
    80002bb6:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80002bb8:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002bba:	14102773          	csrr	a4,sepc
    80002bbe:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002bc0:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80002bc4:	47a1                	li	a5,8
    80002bc6:	02f70763          	beq	a4,a5,80002bf4 <usertrap+0x68>
  } else if((which_dev = devintr()) != 0){
    80002bca:	00000097          	auipc	ra,0x0
    80002bce:	f1c080e7          	jalr	-228(ra) # 80002ae6 <devintr>
    80002bd2:	892a                	mv	s2,a0
    80002bd4:	c151                	beqz	a0,80002c58 <usertrap+0xcc>
  if(killed(p))
    80002bd6:	8526                	mv	a0,s1
    80002bd8:	fffff097          	auipc	ra,0xfffff
    80002bdc:	768080e7          	jalr	1896(ra) # 80002340 <killed>
    80002be0:	c929                	beqz	a0,80002c32 <usertrap+0xa6>
    80002be2:	a099                	j	80002c28 <usertrap+0x9c>
    panic("usertrap: not from user mode");
    80002be4:	00005517          	auipc	a0,0x5
    80002be8:	77450513          	add	a0,a0,1908 # 80008358 <states.0+0x58>
    80002bec:	ffffe097          	auipc	ra,0xffffe
    80002bf0:	950080e7          	jalr	-1712(ra) # 8000053c <panic>
    if(killed(p))
    80002bf4:	fffff097          	auipc	ra,0xfffff
    80002bf8:	74c080e7          	jalr	1868(ra) # 80002340 <killed>
    80002bfc:	e921                	bnez	a0,80002c4c <usertrap+0xc0>
    p->trapframe->epc += 4;
    80002bfe:	6cb8                	ld	a4,88(s1)
    80002c00:	6f1c                	ld	a5,24(a4)
    80002c02:	0791                	add	a5,a5,4
    80002c04:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002c06:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80002c0a:	0027e793          	or	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002c0e:	10079073          	csrw	sstatus,a5
    syscall();
    80002c12:	00000097          	auipc	ra,0x0
    80002c16:	2d4080e7          	jalr	724(ra) # 80002ee6 <syscall>
  if(killed(p))
    80002c1a:	8526                	mv	a0,s1
    80002c1c:	fffff097          	auipc	ra,0xfffff
    80002c20:	724080e7          	jalr	1828(ra) # 80002340 <killed>
    80002c24:	c911                	beqz	a0,80002c38 <usertrap+0xac>
    80002c26:	4901                	li	s2,0
    exit(-1);
    80002c28:	557d                	li	a0,-1
    80002c2a:	fffff097          	auipc	ra,0xfffff
    80002c2e:	5a2080e7          	jalr	1442(ra) # 800021cc <exit>
  if(which_dev == 2)
    80002c32:	4789                	li	a5,2
    80002c34:	04f90f63          	beq	s2,a5,80002c92 <usertrap+0x106>
  usertrapret();
    80002c38:	00000097          	auipc	ra,0x0
    80002c3c:	dd2080e7          	jalr	-558(ra) # 80002a0a <usertrapret>
}
    80002c40:	60e2                	ld	ra,24(sp)
    80002c42:	6442                	ld	s0,16(sp)
    80002c44:	64a2                	ld	s1,8(sp)
    80002c46:	6902                	ld	s2,0(sp)
    80002c48:	6105                	add	sp,sp,32
    80002c4a:	8082                	ret
      exit(-1);
    80002c4c:	557d                	li	a0,-1
    80002c4e:	fffff097          	auipc	ra,0xfffff
    80002c52:	57e080e7          	jalr	1406(ra) # 800021cc <exit>
    80002c56:	b765                	j	80002bfe <usertrap+0x72>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002c58:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80002c5c:	5890                	lw	a2,48(s1)
    80002c5e:	00005517          	auipc	a0,0x5
    80002c62:	71a50513          	add	a0,a0,1818 # 80008378 <states.0+0x78>
    80002c66:	ffffe097          	auipc	ra,0xffffe
    80002c6a:	920080e7          	jalr	-1760(ra) # 80000586 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002c6e:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002c72:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002c76:	00005517          	auipc	a0,0x5
    80002c7a:	73250513          	add	a0,a0,1842 # 800083a8 <states.0+0xa8>
    80002c7e:	ffffe097          	auipc	ra,0xffffe
    80002c82:	908080e7          	jalr	-1784(ra) # 80000586 <printf>
    setkilled(p);
    80002c86:	8526                	mv	a0,s1
    80002c88:	fffff097          	auipc	ra,0xfffff
    80002c8c:	68c080e7          	jalr	1676(ra) # 80002314 <setkilled>
    80002c90:	b769                	j	80002c1a <usertrap+0x8e>
    yield();
    80002c92:	fffff097          	auipc	ra,0xfffff
    80002c96:	3ca080e7          	jalr	970(ra) # 8000205c <yield>
    80002c9a:	bf79                	j	80002c38 <usertrap+0xac>

0000000080002c9c <kerneltrap>:
{
    80002c9c:	7179                	add	sp,sp,-48
    80002c9e:	f406                	sd	ra,40(sp)
    80002ca0:	f022                	sd	s0,32(sp)
    80002ca2:	ec26                	sd	s1,24(sp)
    80002ca4:	e84a                	sd	s2,16(sp)
    80002ca6:	e44e                	sd	s3,8(sp)
    80002ca8:	1800                	add	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002caa:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002cae:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002cb2:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80002cb6:	1004f793          	and	a5,s1,256
    80002cba:	cb85                	beqz	a5,80002cea <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002cbc:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80002cc0:	8b89                	and	a5,a5,2
  if(intr_get() != 0)
    80002cc2:	ef85                	bnez	a5,80002cfa <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80002cc4:	00000097          	auipc	ra,0x0
    80002cc8:	e22080e7          	jalr	-478(ra) # 80002ae6 <devintr>
    80002ccc:	cd1d                	beqz	a0,80002d0a <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002cce:	4789                	li	a5,2
    80002cd0:	06f50a63          	beq	a0,a5,80002d44 <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80002cd4:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002cd8:	10049073          	csrw	sstatus,s1
}
    80002cdc:	70a2                	ld	ra,40(sp)
    80002cde:	7402                	ld	s0,32(sp)
    80002ce0:	64e2                	ld	s1,24(sp)
    80002ce2:	6942                	ld	s2,16(sp)
    80002ce4:	69a2                	ld	s3,8(sp)
    80002ce6:	6145                	add	sp,sp,48
    80002ce8:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80002cea:	00005517          	auipc	a0,0x5
    80002cee:	6de50513          	add	a0,a0,1758 # 800083c8 <states.0+0xc8>
    80002cf2:	ffffe097          	auipc	ra,0xffffe
    80002cf6:	84a080e7          	jalr	-1974(ra) # 8000053c <panic>
    panic("kerneltrap: interrupts enabled");
    80002cfa:	00005517          	auipc	a0,0x5
    80002cfe:	6f650513          	add	a0,a0,1782 # 800083f0 <states.0+0xf0>
    80002d02:	ffffe097          	auipc	ra,0xffffe
    80002d06:	83a080e7          	jalr	-1990(ra) # 8000053c <panic>
    printf("scause %p\n", scause);
    80002d0a:	85ce                	mv	a1,s3
    80002d0c:	00005517          	auipc	a0,0x5
    80002d10:	70450513          	add	a0,a0,1796 # 80008410 <states.0+0x110>
    80002d14:	ffffe097          	auipc	ra,0xffffe
    80002d18:	872080e7          	jalr	-1934(ra) # 80000586 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002d1c:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002d20:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002d24:	00005517          	auipc	a0,0x5
    80002d28:	6fc50513          	add	a0,a0,1788 # 80008420 <states.0+0x120>
    80002d2c:	ffffe097          	auipc	ra,0xffffe
    80002d30:	85a080e7          	jalr	-1958(ra) # 80000586 <printf>
    panic("kerneltrap");
    80002d34:	00005517          	auipc	a0,0x5
    80002d38:	70450513          	add	a0,a0,1796 # 80008438 <states.0+0x138>
    80002d3c:	ffffe097          	auipc	ra,0xffffe
    80002d40:	800080e7          	jalr	-2048(ra) # 8000053c <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002d44:	fffff097          	auipc	ra,0xfffff
    80002d48:	c84080e7          	jalr	-892(ra) # 800019c8 <myproc>
    80002d4c:	d541                	beqz	a0,80002cd4 <kerneltrap+0x38>
    80002d4e:	fffff097          	auipc	ra,0xfffff
    80002d52:	c7a080e7          	jalr	-902(ra) # 800019c8 <myproc>
    80002d56:	4d18                	lw	a4,24(a0)
    80002d58:	4791                	li	a5,4
    80002d5a:	f6f71de3          	bne	a4,a5,80002cd4 <kerneltrap+0x38>
    yield();
    80002d5e:	fffff097          	auipc	ra,0xfffff
    80002d62:	2fe080e7          	jalr	766(ra) # 8000205c <yield>
    80002d66:	b7bd                	j	80002cd4 <kerneltrap+0x38>

0000000080002d68 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80002d68:	1101                	add	sp,sp,-32
    80002d6a:	ec06                	sd	ra,24(sp)
    80002d6c:	e822                	sd	s0,16(sp)
    80002d6e:	e426                	sd	s1,8(sp)
    80002d70:	1000                	add	s0,sp,32
    80002d72:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80002d74:	fffff097          	auipc	ra,0xfffff
    80002d78:	c54080e7          	jalr	-940(ra) # 800019c8 <myproc>
  switch (n) {
    80002d7c:	4795                	li	a5,5
    80002d7e:	0497e163          	bltu	a5,s1,80002dc0 <argraw+0x58>
    80002d82:	048a                	sll	s1,s1,0x2
    80002d84:	00005717          	auipc	a4,0x5
    80002d88:	6ec70713          	add	a4,a4,1772 # 80008470 <states.0+0x170>
    80002d8c:	94ba                	add	s1,s1,a4
    80002d8e:	409c                	lw	a5,0(s1)
    80002d90:	97ba                	add	a5,a5,a4
    80002d92:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80002d94:	6d3c                	ld	a5,88(a0)
    80002d96:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80002d98:	60e2                	ld	ra,24(sp)
    80002d9a:	6442                	ld	s0,16(sp)
    80002d9c:	64a2                	ld	s1,8(sp)
    80002d9e:	6105                	add	sp,sp,32
    80002da0:	8082                	ret
    return p->trapframe->a1;
    80002da2:	6d3c                	ld	a5,88(a0)
    80002da4:	7fa8                	ld	a0,120(a5)
    80002da6:	bfcd                	j	80002d98 <argraw+0x30>
    return p->trapframe->a2;
    80002da8:	6d3c                	ld	a5,88(a0)
    80002daa:	63c8                	ld	a0,128(a5)
    80002dac:	b7f5                	j	80002d98 <argraw+0x30>
    return p->trapframe->a3;
    80002dae:	6d3c                	ld	a5,88(a0)
    80002db0:	67c8                	ld	a0,136(a5)
    80002db2:	b7dd                	j	80002d98 <argraw+0x30>
    return p->trapframe->a4;
    80002db4:	6d3c                	ld	a5,88(a0)
    80002db6:	6bc8                	ld	a0,144(a5)
    80002db8:	b7c5                	j	80002d98 <argraw+0x30>
    return p->trapframe->a5;
    80002dba:	6d3c                	ld	a5,88(a0)
    80002dbc:	6fc8                	ld	a0,152(a5)
    80002dbe:	bfe9                	j	80002d98 <argraw+0x30>
  panic("argraw");
    80002dc0:	00005517          	auipc	a0,0x5
    80002dc4:	68850513          	add	a0,a0,1672 # 80008448 <states.0+0x148>
    80002dc8:	ffffd097          	auipc	ra,0xffffd
    80002dcc:	774080e7          	jalr	1908(ra) # 8000053c <panic>

0000000080002dd0 <fetchaddr>:
{
    80002dd0:	1101                	add	sp,sp,-32
    80002dd2:	ec06                	sd	ra,24(sp)
    80002dd4:	e822                	sd	s0,16(sp)
    80002dd6:	e426                	sd	s1,8(sp)
    80002dd8:	e04a                	sd	s2,0(sp)
    80002dda:	1000                	add	s0,sp,32
    80002ddc:	84aa                	mv	s1,a0
    80002dde:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80002de0:	fffff097          	auipc	ra,0xfffff
    80002de4:	be8080e7          	jalr	-1048(ra) # 800019c8 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    80002de8:	653c                	ld	a5,72(a0)
    80002dea:	02f4f863          	bgeu	s1,a5,80002e1a <fetchaddr+0x4a>
    80002dee:	00848713          	add	a4,s1,8
    80002df2:	02e7e663          	bltu	a5,a4,80002e1e <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80002df6:	46a1                	li	a3,8
    80002df8:	8626                	mv	a2,s1
    80002dfa:	85ca                	mv	a1,s2
    80002dfc:	6928                	ld	a0,80(a0)
    80002dfe:	fffff097          	auipc	ra,0xfffff
    80002e02:	916080e7          	jalr	-1770(ra) # 80001714 <copyin>
    80002e06:	00a03533          	snez	a0,a0
    80002e0a:	40a00533          	neg	a0,a0
}
    80002e0e:	60e2                	ld	ra,24(sp)
    80002e10:	6442                	ld	s0,16(sp)
    80002e12:	64a2                	ld	s1,8(sp)
    80002e14:	6902                	ld	s2,0(sp)
    80002e16:	6105                	add	sp,sp,32
    80002e18:	8082                	ret
    return -1;
    80002e1a:	557d                	li	a0,-1
    80002e1c:	bfcd                	j	80002e0e <fetchaddr+0x3e>
    80002e1e:	557d                	li	a0,-1
    80002e20:	b7fd                	j	80002e0e <fetchaddr+0x3e>

0000000080002e22 <fetchstr>:
{
    80002e22:	7179                	add	sp,sp,-48
    80002e24:	f406                	sd	ra,40(sp)
    80002e26:	f022                	sd	s0,32(sp)
    80002e28:	ec26                	sd	s1,24(sp)
    80002e2a:	e84a                	sd	s2,16(sp)
    80002e2c:	e44e                	sd	s3,8(sp)
    80002e2e:	1800                	add	s0,sp,48
    80002e30:	892a                	mv	s2,a0
    80002e32:	84ae                	mv	s1,a1
    80002e34:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80002e36:	fffff097          	auipc	ra,0xfffff
    80002e3a:	b92080e7          	jalr	-1134(ra) # 800019c8 <myproc>
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    80002e3e:	86ce                	mv	a3,s3
    80002e40:	864a                	mv	a2,s2
    80002e42:	85a6                	mv	a1,s1
    80002e44:	6928                	ld	a0,80(a0)
    80002e46:	fffff097          	auipc	ra,0xfffff
    80002e4a:	95c080e7          	jalr	-1700(ra) # 800017a2 <copyinstr>
    80002e4e:	00054e63          	bltz	a0,80002e6a <fetchstr+0x48>
  return strlen(buf);
    80002e52:	8526                	mv	a0,s1
    80002e54:	ffffe097          	auipc	ra,0xffffe
    80002e58:	016080e7          	jalr	22(ra) # 80000e6a <strlen>
}
    80002e5c:	70a2                	ld	ra,40(sp)
    80002e5e:	7402                	ld	s0,32(sp)
    80002e60:	64e2                	ld	s1,24(sp)
    80002e62:	6942                	ld	s2,16(sp)
    80002e64:	69a2                	ld	s3,8(sp)
    80002e66:	6145                	add	sp,sp,48
    80002e68:	8082                	ret
    return -1;
    80002e6a:	557d                	li	a0,-1
    80002e6c:	bfc5                	j	80002e5c <fetchstr+0x3a>

0000000080002e6e <argint>:

// Fetch the nth 32-bit system call argument.
void
argint(int n, int *ip)
{
    80002e6e:	1101                	add	sp,sp,-32
    80002e70:	ec06                	sd	ra,24(sp)
    80002e72:	e822                	sd	s0,16(sp)
    80002e74:	e426                	sd	s1,8(sp)
    80002e76:	1000                	add	s0,sp,32
    80002e78:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002e7a:	00000097          	auipc	ra,0x0
    80002e7e:	eee080e7          	jalr	-274(ra) # 80002d68 <argraw>
    80002e82:	c088                	sw	a0,0(s1)
}
    80002e84:	60e2                	ld	ra,24(sp)
    80002e86:	6442                	ld	s0,16(sp)
    80002e88:	64a2                	ld	s1,8(sp)
    80002e8a:	6105                	add	sp,sp,32
    80002e8c:	8082                	ret

0000000080002e8e <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr(int n, uint64 *ip)
{
    80002e8e:	1101                	add	sp,sp,-32
    80002e90:	ec06                	sd	ra,24(sp)
    80002e92:	e822                	sd	s0,16(sp)
    80002e94:	e426                	sd	s1,8(sp)
    80002e96:	1000                	add	s0,sp,32
    80002e98:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002e9a:	00000097          	auipc	ra,0x0
    80002e9e:	ece080e7          	jalr	-306(ra) # 80002d68 <argraw>
    80002ea2:	e088                	sd	a0,0(s1)
}
    80002ea4:	60e2                	ld	ra,24(sp)
    80002ea6:	6442                	ld	s0,16(sp)
    80002ea8:	64a2                	ld	s1,8(sp)
    80002eaa:	6105                	add	sp,sp,32
    80002eac:	8082                	ret

0000000080002eae <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80002eae:	7179                	add	sp,sp,-48
    80002eb0:	f406                	sd	ra,40(sp)
    80002eb2:	f022                	sd	s0,32(sp)
    80002eb4:	ec26                	sd	s1,24(sp)
    80002eb6:	e84a                	sd	s2,16(sp)
    80002eb8:	1800                	add	s0,sp,48
    80002eba:	84ae                	mv	s1,a1
    80002ebc:	8932                	mv	s2,a2
  uint64 addr;
  argaddr(n, &addr);
    80002ebe:	fd840593          	add	a1,s0,-40
    80002ec2:	00000097          	auipc	ra,0x0
    80002ec6:	fcc080e7          	jalr	-52(ra) # 80002e8e <argaddr>
  return fetchstr(addr, buf, max);
    80002eca:	864a                	mv	a2,s2
    80002ecc:	85a6                	mv	a1,s1
    80002ece:	fd843503          	ld	a0,-40(s0)
    80002ed2:	00000097          	auipc	ra,0x0
    80002ed6:	f50080e7          	jalr	-176(ra) # 80002e22 <fetchstr>
}
    80002eda:	70a2                	ld	ra,40(sp)
    80002edc:	7402                	ld	s0,32(sp)
    80002ede:	64e2                	ld	s1,24(sp)
    80002ee0:	6942                	ld	s2,16(sp)
    80002ee2:	6145                	add	sp,sp,48
    80002ee4:	8082                	ret

0000000080002ee6 <syscall>:

};

void
syscall(void)
{
    80002ee6:	1101                	add	sp,sp,-32
    80002ee8:	ec06                	sd	ra,24(sp)
    80002eea:	e822                	sd	s0,16(sp)
    80002eec:	e426                	sd	s1,8(sp)
    80002eee:	e04a                	sd	s2,0(sp)
    80002ef0:	1000                	add	s0,sp,32
  int num;
  struct proc *p = myproc();
    80002ef2:	fffff097          	auipc	ra,0xfffff
    80002ef6:	ad6080e7          	jalr	-1322(ra) # 800019c8 <myproc>
    80002efa:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80002efc:	05853903          	ld	s2,88(a0)
    80002f00:	0a893783          	ld	a5,168(s2)
    80002f04:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002f08:	37fd                	addw	a5,a5,-1
    80002f0a:	4779                	li	a4,30
    80002f0c:	00f76f63          	bltu	a4,a5,80002f2a <syscall+0x44>
    80002f10:	00369713          	sll	a4,a3,0x3
    80002f14:	00005797          	auipc	a5,0x5
    80002f18:	57478793          	add	a5,a5,1396 # 80008488 <syscalls>
    80002f1c:	97ba                	add	a5,a5,a4
    80002f1e:	639c                	ld	a5,0(a5)
    80002f20:	c789                	beqz	a5,80002f2a <syscall+0x44>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    80002f22:	9782                	jalr	a5
    80002f24:	06a93823          	sd	a0,112(s2)
    80002f28:	a839                	j	80002f46 <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80002f2a:	15848613          	add	a2,s1,344
    80002f2e:	588c                	lw	a1,48(s1)
    80002f30:	00005517          	auipc	a0,0x5
    80002f34:	52050513          	add	a0,a0,1312 # 80008450 <states.0+0x150>
    80002f38:	ffffd097          	auipc	ra,0xffffd
    80002f3c:	64e080e7          	jalr	1614(ra) # 80000586 <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    80002f40:	6cbc                	ld	a5,88(s1)
    80002f42:	577d                	li	a4,-1
    80002f44:	fbb8                	sd	a4,112(a5)
  }
}
    80002f46:	60e2                	ld	ra,24(sp)
    80002f48:	6442                	ld	s0,16(sp)
    80002f4a:	64a2                	ld	s1,8(sp)
    80002f4c:	6902                	ld	s2,0(sp)
    80002f4e:	6105                	add	sp,sp,32
    80002f50:	8082                	ret

0000000080002f52 <sys_exit>:
#include "proc.h"
#include "klinkedlist.h"

uint64
sys_exit(void)
{
    80002f52:	1101                	add	sp,sp,-32
    80002f54:	ec06                	sd	ra,24(sp)
    80002f56:	e822                	sd	s0,16(sp)
    80002f58:	1000                	add	s0,sp,32
  int n;
  argint(0, &n);
    80002f5a:	fec40593          	add	a1,s0,-20
    80002f5e:	4501                	li	a0,0
    80002f60:	00000097          	auipc	ra,0x0
    80002f64:	f0e080e7          	jalr	-242(ra) # 80002e6e <argint>
  exit(n);
    80002f68:	fec42503          	lw	a0,-20(s0)
    80002f6c:	fffff097          	auipc	ra,0xfffff
    80002f70:	260080e7          	jalr	608(ra) # 800021cc <exit>
  return 0;  // not reached
}
    80002f74:	4501                	li	a0,0
    80002f76:	60e2                	ld	ra,24(sp)
    80002f78:	6442                	ld	s0,16(sp)
    80002f7a:	6105                	add	sp,sp,32
    80002f7c:	8082                	ret

0000000080002f7e <sys_getpid>:

uint64
sys_getpid(void)
{
    80002f7e:	1141                	add	sp,sp,-16
    80002f80:	e406                	sd	ra,8(sp)
    80002f82:	e022                	sd	s0,0(sp)
    80002f84:	0800                	add	s0,sp,16
  return myproc()->pid;
    80002f86:	fffff097          	auipc	ra,0xfffff
    80002f8a:	a42080e7          	jalr	-1470(ra) # 800019c8 <myproc>
}
    80002f8e:	5908                	lw	a0,48(a0)
    80002f90:	60a2                	ld	ra,8(sp)
    80002f92:	6402                	ld	s0,0(sp)
    80002f94:	0141                	add	sp,sp,16
    80002f96:	8082                	ret

0000000080002f98 <sys_fork>:

uint64
sys_fork(void)
{
    80002f98:	1141                	add	sp,sp,-16
    80002f9a:	e406                	sd	ra,8(sp)
    80002f9c:	e022                	sd	s0,0(sp)
    80002f9e:	0800                	add	s0,sp,16
  return fork();
    80002fa0:	fffff097          	auipc	ra,0xfffff
    80002fa4:	de4080e7          	jalr	-540(ra) # 80001d84 <fork>
}
    80002fa8:	60a2                	ld	ra,8(sp)
    80002faa:	6402                	ld	s0,0(sp)
    80002fac:	0141                	add	sp,sp,16
    80002fae:	8082                	ret

0000000080002fb0 <sys_wait>:

uint64
sys_wait(void)
{
    80002fb0:	1101                	add	sp,sp,-32
    80002fb2:	ec06                	sd	ra,24(sp)
    80002fb4:	e822                	sd	s0,16(sp)
    80002fb6:	1000                	add	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    80002fb8:	fe840593          	add	a1,s0,-24
    80002fbc:	4501                	li	a0,0
    80002fbe:	00000097          	auipc	ra,0x0
    80002fc2:	ed0080e7          	jalr	-304(ra) # 80002e8e <argaddr>
  return wait(p);
    80002fc6:	fe843503          	ld	a0,-24(s0)
    80002fca:	fffff097          	auipc	ra,0xfffff
    80002fce:	3a8080e7          	jalr	936(ra) # 80002372 <wait>
}
    80002fd2:	60e2                	ld	ra,24(sp)
    80002fd4:	6442                	ld	s0,16(sp)
    80002fd6:	6105                	add	sp,sp,32
    80002fd8:	8082                	ret

0000000080002fda <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80002fda:	7179                	add	sp,sp,-48
    80002fdc:	f406                	sd	ra,40(sp)
    80002fde:	f022                	sd	s0,32(sp)
    80002fe0:	ec26                	sd	s1,24(sp)
    80002fe2:	1800                	add	s0,sp,48
  uint64 addr;
  int n;

  argint(0, &n);
    80002fe4:	fdc40593          	add	a1,s0,-36
    80002fe8:	4501                	li	a0,0
    80002fea:	00000097          	auipc	ra,0x0
    80002fee:	e84080e7          	jalr	-380(ra) # 80002e6e <argint>
  addr = myproc()->sz;
    80002ff2:	fffff097          	auipc	ra,0xfffff
    80002ff6:	9d6080e7          	jalr	-1578(ra) # 800019c8 <myproc>
    80002ffa:	6524                	ld	s1,72(a0)
  if(growproc(n) < 0)
    80002ffc:	fdc42503          	lw	a0,-36(s0)
    80003000:	fffff097          	auipc	ra,0xfffff
    80003004:	d28080e7          	jalr	-728(ra) # 80001d28 <growproc>
    80003008:	00054863          	bltz	a0,80003018 <sys_sbrk+0x3e>
    return -1;
  return addr;
}
    8000300c:	8526                	mv	a0,s1
    8000300e:	70a2                	ld	ra,40(sp)
    80003010:	7402                	ld	s0,32(sp)
    80003012:	64e2                	ld	s1,24(sp)
    80003014:	6145                	add	sp,sp,48
    80003016:	8082                	ret
    return -1;
    80003018:	54fd                	li	s1,-1
    8000301a:	bfcd                	j	8000300c <sys_sbrk+0x32>

000000008000301c <sys_sleep>:

uint64
sys_sleep(void)
{
    8000301c:	7139                	add	sp,sp,-64
    8000301e:	fc06                	sd	ra,56(sp)
    80003020:	f822                	sd	s0,48(sp)
    80003022:	f426                	sd	s1,40(sp)
    80003024:	f04a                	sd	s2,32(sp)
    80003026:	ec4e                	sd	s3,24(sp)
    80003028:	0080                	add	s0,sp,64
  int n;
  uint ticks0;

  argint(0, &n);
    8000302a:	fcc40593          	add	a1,s0,-52
    8000302e:	4501                	li	a0,0
    80003030:	00000097          	auipc	ra,0x0
    80003034:	e3e080e7          	jalr	-450(ra) # 80002e6e <argint>
  acquire(&tickslock);
    80003038:	00014517          	auipc	a0,0x14
    8000303c:	c4850513          	add	a0,a0,-952 # 80016c80 <tickslock>
    80003040:	ffffe097          	auipc	ra,0xffffe
    80003044:	bb4080e7          	jalr	-1100(ra) # 80000bf4 <acquire>
  ticks0 = ticks;
    80003048:	00006917          	auipc	s2,0x6
    8000304c:	99892903          	lw	s2,-1640(s2) # 800089e0 <ticks>
  while(ticks - ticks0 < n){
    80003050:	fcc42783          	lw	a5,-52(s0)
    80003054:	cf9d                	beqz	a5,80003092 <sys_sleep+0x76>
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80003056:	00014997          	auipc	s3,0x14
    8000305a:	c2a98993          	add	s3,s3,-982 # 80016c80 <tickslock>
    8000305e:	00006497          	auipc	s1,0x6
    80003062:	98248493          	add	s1,s1,-1662 # 800089e0 <ticks>
    if(killed(myproc())){
    80003066:	fffff097          	auipc	ra,0xfffff
    8000306a:	962080e7          	jalr	-1694(ra) # 800019c8 <myproc>
    8000306e:	fffff097          	auipc	ra,0xfffff
    80003072:	2d2080e7          	jalr	722(ra) # 80002340 <killed>
    80003076:	ed15                	bnez	a0,800030b2 <sys_sleep+0x96>
    sleep(&ticks, &tickslock);
    80003078:	85ce                	mv	a1,s3
    8000307a:	8526                	mv	a0,s1
    8000307c:	fffff097          	auipc	ra,0xfffff
    80003080:	01c080e7          	jalr	28(ra) # 80002098 <sleep>
  while(ticks - ticks0 < n){
    80003084:	409c                	lw	a5,0(s1)
    80003086:	412787bb          	subw	a5,a5,s2
    8000308a:	fcc42703          	lw	a4,-52(s0)
    8000308e:	fce7ece3          	bltu	a5,a4,80003066 <sys_sleep+0x4a>
  }
  release(&tickslock);
    80003092:	00014517          	auipc	a0,0x14
    80003096:	bee50513          	add	a0,a0,-1042 # 80016c80 <tickslock>
    8000309a:	ffffe097          	auipc	ra,0xffffe
    8000309e:	c0e080e7          	jalr	-1010(ra) # 80000ca8 <release>
  return 0;
    800030a2:	4501                	li	a0,0
}
    800030a4:	70e2                	ld	ra,56(sp)
    800030a6:	7442                	ld	s0,48(sp)
    800030a8:	74a2                	ld	s1,40(sp)
    800030aa:	7902                	ld	s2,32(sp)
    800030ac:	69e2                	ld	s3,24(sp)
    800030ae:	6121                	add	sp,sp,64
    800030b0:	8082                	ret
      release(&tickslock);
    800030b2:	00014517          	auipc	a0,0x14
    800030b6:	bce50513          	add	a0,a0,-1074 # 80016c80 <tickslock>
    800030ba:	ffffe097          	auipc	ra,0xffffe
    800030be:	bee080e7          	jalr	-1042(ra) # 80000ca8 <release>
      return -1;
    800030c2:	557d                	li	a0,-1
    800030c4:	b7c5                	j	800030a4 <sys_sleep+0x88>

00000000800030c6 <sys_kill>:

uint64
sys_kill(void)
{
    800030c6:	1101                	add	sp,sp,-32
    800030c8:	ec06                	sd	ra,24(sp)
    800030ca:	e822                	sd	s0,16(sp)
    800030cc:	1000                	add	s0,sp,32
  int pid;

  argint(0, &pid);
    800030ce:	fec40593          	add	a1,s0,-20
    800030d2:	4501                	li	a0,0
    800030d4:	00000097          	auipc	ra,0x0
    800030d8:	d9a080e7          	jalr	-614(ra) # 80002e6e <argint>
  return kill(pid);
    800030dc:	fec42503          	lw	a0,-20(s0)
    800030e0:	fffff097          	auipc	ra,0xfffff
    800030e4:	1c2080e7          	jalr	450(ra) # 800022a2 <kill>
}
    800030e8:	60e2                	ld	ra,24(sp)
    800030ea:	6442                	ld	s0,16(sp)
    800030ec:	6105                	add	sp,sp,32
    800030ee:	8082                	ret

00000000800030f0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    800030f0:	1101                	add	sp,sp,-32
    800030f2:	ec06                	sd	ra,24(sp)
    800030f4:	e822                	sd	s0,16(sp)
    800030f6:	e426                	sd	s1,8(sp)
    800030f8:	1000                	add	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    800030fa:	00014517          	auipc	a0,0x14
    800030fe:	b8650513          	add	a0,a0,-1146 # 80016c80 <tickslock>
    80003102:	ffffe097          	auipc	ra,0xffffe
    80003106:	af2080e7          	jalr	-1294(ra) # 80000bf4 <acquire>
  xticks = ticks;
    8000310a:	00006497          	auipc	s1,0x6
    8000310e:	8d64a483          	lw	s1,-1834(s1) # 800089e0 <ticks>
  release(&tickslock);
    80003112:	00014517          	auipc	a0,0x14
    80003116:	b6e50513          	add	a0,a0,-1170 # 80016c80 <tickslock>
    8000311a:	ffffe097          	auipc	ra,0xffffe
    8000311e:	b8e080e7          	jalr	-1138(ra) # 80000ca8 <release>
  return xticks;
}
    80003122:	02049513          	sll	a0,s1,0x20
    80003126:	9101                	srl	a0,a0,0x20
    80003128:	60e2                	ld	ra,24(sp)
    8000312a:	6442                	ld	s0,16(sp)
    8000312c:	64a2                	ld	s1,8(sp)
    8000312e:	6105                	add	sp,sp,32
    80003130:	8082                	ret

0000000080003132 <sys_rcureadlock>:

uint64
sys_rcureadlock(void)
{
    80003132:	1141                	add	sp,sp,-16
    80003134:	e406                	sd	ra,8(sp)
    80003136:	e022                	sd	s0,0(sp)
    80003138:	0800                	add	s0,sp,16
  // rcu_read_lock();
  push_off();
    8000313a:	ffffe097          	auipc	ra,0xffffe
    8000313e:	a6e080e7          	jalr	-1426(ra) # 80000ba8 <push_off>
  return 1;
}
    80003142:	4505                	li	a0,1
    80003144:	60a2                	ld	ra,8(sp)
    80003146:	6402                	ld	s0,0(sp)
    80003148:	0141                	add	sp,sp,16
    8000314a:	8082                	ret

000000008000314c <sys_rcureadunlock>:

uint64
sys_rcureadunlock(void)
{
    8000314c:	1141                	add	sp,sp,-16
    8000314e:	e406                	sd	ra,8(sp)
    80003150:	e022                	sd	s0,0(sp)
    80003152:	0800                	add	s0,sp,16
  // rcu_read_unlock();
  pop_off();
    80003154:	ffffe097          	auipc	ra,0xffffe
    80003158:	af4080e7          	jalr	-1292(ra) # 80000c48 <pop_off>
  return 1;
}
    8000315c:	4505                	li	a0,1
    8000315e:	60a2                	ld	ra,8(sp)
    80003160:	6402                	ld	s0,0(sp)
    80003162:	0141                	add	sp,sp,16
    80003164:	8082                	ret

0000000080003166 <sys_rcusync>:

uint64
sys_rcusync(void)
{
    80003166:	1101                	add	sp,sp,-32
    80003168:	ec06                	sd	ra,24(sp)
    8000316a:	e822                	sd	s0,16(sp)
    8000316c:	e426                	sd	s1,8(sp)
    8000316e:	1000                	add	s0,sp,32
  // synchronize_rcu();
  int i = 0;
    struct proc *p = myproc();
    80003170:	fffff097          	auipc	ra,0xfffff
    80003174:	858080e7          	jalr	-1960(ra) # 800019c8 <myproc>
    80003178:	84aa                	mv	s1,a0
    // how to identify number of CPUs running ?
    while (i < 2) {
        p->cpu_affinity =  i++;
    8000317a:	16052423          	sw	zero,360(a0)
        yield();
    8000317e:	fffff097          	auipc	ra,0xfffff
    80003182:	ede080e7          	jalr	-290(ra) # 8000205c <yield>
        p->cpu_affinity =  i++;
    80003186:	4785                	li	a5,1
    80003188:	16f4a423          	sw	a5,360(s1)
        yield();
    8000318c:	fffff097          	auipc	ra,0xfffff
    80003190:	ed0080e7          	jalr	-304(ra) # 8000205c <yield>
    }
   p->cpu_affinity = -1;
    80003194:	57fd                	li	a5,-1
    80003196:	16f4a423          	sw	a5,360(s1)
    printf ("\n RCU sync done!");
    8000319a:	00005517          	auipc	a0,0x5
    8000319e:	3ee50513          	add	a0,a0,1006 # 80008588 <syscalls+0x100>
    800031a2:	ffffd097          	auipc	ra,0xffffd
    800031a6:	3e4080e7          	jalr	996(ra) # 80000586 <printf>
  return 1;
}
    800031aa:	4505                	li	a0,1
    800031ac:	60e2                	ld	ra,24(sp)
    800031ae:	6442                	ld	s0,16(sp)
    800031b0:	64a2                	ld	s1,8(sp)
    800031b2:	6105                	add	sp,sp,32
    800031b4:	8082                	ret

00000000800031b6 <sys_thread_create>:

uint64
sys_thread_create(void)
{
    800031b6:	7179                	add	sp,sp,-48
    800031b8:	f406                	sd	ra,40(sp)
    800031ba:	f022                	sd	s0,32(sp)
    800031bc:	1800                	add	s0,sp,48
  void (*fcn)(void *);
  void *arg; //char?
  void *user_stack; //char?

  argaddr(0, (uint64 *)&fcn);
    800031be:	fe840593          	add	a1,s0,-24
    800031c2:	4501                	li	a0,0
    800031c4:	00000097          	auipc	ra,0x0
    800031c8:	cca080e7          	jalr	-822(ra) # 80002e8e <argaddr>
  argaddr(1, (uint64 *)&arg);
    800031cc:	fe040593          	add	a1,s0,-32
    800031d0:	4505                	li	a0,1
    800031d2:	00000097          	auipc	ra,0x0
    800031d6:	cbc080e7          	jalr	-836(ra) # 80002e8e <argaddr>
  argaddr(2, (uint64 *)&user_stack);
    800031da:	fd840593          	add	a1,s0,-40
    800031de:	4509                	li	a0,2
    800031e0:	00000097          	auipc	ra,0x0
    800031e4:	cae080e7          	jalr	-850(ra) # 80002e8e <argaddr>
  return thread_create(fcn,arg,user_stack);
    800031e8:	fd843603          	ld	a2,-40(s0)
    800031ec:	fe043583          	ld	a1,-32(s0)
    800031f0:	fe843503          	ld	a0,-24(s0)
    800031f4:	fffff097          	auipc	ra,0xfffff
    800031f8:	408080e7          	jalr	1032(ra) # 800025fc <thread_create>
}
    800031fc:	70a2                	ld	ra,40(sp)
    800031fe:	7402                	ld	s0,32(sp)
    80003200:	6145                	add	sp,sp,48
    80003202:	8082                	ret

0000000080003204 <sys_thread_join>:

uint64
sys_thread_join(void)
{
    80003204:	1141                	add	sp,sp,-16
    80003206:	e406                	sd	ra,8(sp)
    80003208:	e022                	sd	s0,0(sp)
    8000320a:	0800                	add	s0,sp,16
  return thread_join();
    8000320c:	fffff097          	auipc	ra,0xfffff
    80003210:	590080e7          	jalr	1424(ra) # 8000279c <thread_join>
}
    80003214:	60a2                	ld	ra,8(sp)
    80003216:	6402                	ld	s0,0(sp)
    80003218:	0141                	add	sp,sp,16
    8000321a:	8082                	ret

000000008000321c <sys_thread_exit>:

uint64
sys_thread_exit(void)
{
    8000321c:	1101                	add	sp,sp,-32
    8000321e:	ec06                	sd	ra,24(sp)
    80003220:	e822                	sd	s0,16(sp)
    80003222:	1000                	add	s0,sp,32
  int n;
  argint(0, &n);
    80003224:	fec40593          	add	a1,s0,-20
    80003228:	4501                	li	a0,0
    8000322a:	00000097          	auipc	ra,0x0
    8000322e:	c44080e7          	jalr	-956(ra) # 80002e6e <argint>
  return thread_exit(n);
    80003232:	fec42503          	lw	a0,-20(s0)
    80003236:	fffff097          	auipc	ra,0xfffff
    8000323a:	654080e7          	jalr	1620(ra) # 8000288a <thread_exit>
}
    8000323e:	60e2                	ld	ra,24(sp)
    80003240:	6442                	ld	s0,16(sp)
    80003242:	6105                	add	sp,sp,32
    80003244:	8082                	ret

0000000080003246 <sys_klist_insert>:

uint64
sys_klist_insert(void)
{
    80003246:	7179                	add	sp,sp,-48
    80003248:	f406                	sd	ra,40(sp)
    8000324a:	f022                	sd	s0,32(sp)
    8000324c:	ec26                	sd	s1,24(sp)
    8000324e:	1800                	add	s0,sp,48
  int n, is_rcu;
  argint(0, &n);
    80003250:	fdc40593          	add	a1,s0,-36
    80003254:	4501                	li	a0,0
    80003256:	00000097          	auipc	ra,0x0
    8000325a:	c18080e7          	jalr	-1000(ra) # 80002e6e <argint>
  argint(1, &is_rcu);
    8000325e:	fd840593          	add	a1,s0,-40
    80003262:	4505                	li	a0,1
    80003264:	00000097          	auipc	ra,0x0
    80003268:	c0a080e7          	jalr	-1014(ra) # 80002e6e <argint>
  if (is_rcu)
    8000326c:	fd842783          	lw	a5,-40(s0)
    80003270:	cf8d                	beqz	a5,800032aa <sys_klist_insert+0x64>
  {
    init_list();
    80003272:	00003097          	auipc	ra,0x3
    80003276:	690080e7          	jalr	1680(ra) # 80006902 <init_list>
  } else{
    init_list_lock();
  }
  
  for (int i = 1; i <= n; i++)
    8000327a:	fdc42783          	lw	a5,-36(s0)
    8000327e:	4485                	li	s1,1
    80003280:	04f04463          	bgtz	a5,800032c8 <sys_klist_insert+0x82>
    } else{
      insert_lock(i);
    }
    
  }
  printf("Total free pages %d\n",get_total_free_pages());
    80003284:	ffffe097          	auipc	ra,0xffffe
    80003288:	8be080e7          	jalr	-1858(ra) # 80000b42 <get_total_free_pages>
    8000328c:	85aa                	mv	a1,a0
    8000328e:	00005517          	auipc	a0,0x5
    80003292:	31250513          	add	a0,a0,786 # 800085a0 <syscalls+0x118>
    80003296:	ffffd097          	auipc	ra,0xffffd
    8000329a:	2f0080e7          	jalr	752(ra) # 80000586 <printf>
  return 1;
}
    8000329e:	4505                	li	a0,1
    800032a0:	70a2                	ld	ra,40(sp)
    800032a2:	7402                	ld	s0,32(sp)
    800032a4:	64e2                	ld	s1,24(sp)
    800032a6:	6145                	add	sp,sp,48
    800032a8:	8082                	ret
    init_list_lock();
    800032aa:	00003097          	auipc	ra,0x3
    800032ae:	608080e7          	jalr	1544(ra) # 800068b2 <init_list_lock>
    800032b2:	b7e1                	j	8000327a <sys_klist_insert+0x34>
      insert_lock(i);
    800032b4:	8526                	mv	a0,s1
    800032b6:	00003097          	auipc	ra,0x3
    800032ba:	678080e7          	jalr	1656(ra) # 8000692e <insert_lock>
  for (int i = 1; i <= n; i++)
    800032be:	2485                	addw	s1,s1,1
    800032c0:	fdc42783          	lw	a5,-36(s0)
    800032c4:	fc97c0e3          	blt	a5,s1,80003284 <sys_klist_insert+0x3e>
    if (is_rcu)
    800032c8:	fd842783          	lw	a5,-40(s0)
    800032cc:	d7e5                	beqz	a5,800032b4 <sys_klist_insert+0x6e>
      insert(i);
    800032ce:	8526                	mv	a0,s1
    800032d0:	00003097          	auipc	ra,0x3
    800032d4:	6c2080e7          	jalr	1730(ra) # 80006992 <insert>
    800032d8:	b7dd                	j	800032be <sys_klist_insert+0x78>

00000000800032da <sys_klist_delete>:

uint64
sys_klist_delete(void)
{
    800032da:	1101                	add	sp,sp,-32
    800032dc:	ec06                	sd	ra,24(sp)
    800032de:	e822                	sd	s0,16(sp)
    800032e0:	1000                	add	s0,sp,32
  int n, is_rcu;
  argint(0, &n);
    800032e2:	fec40593          	add	a1,s0,-20
    800032e6:	4501                	li	a0,0
    800032e8:	00000097          	auipc	ra,0x0
    800032ec:	b86080e7          	jalr	-1146(ra) # 80002e6e <argint>
  argint(1, &is_rcu);
    800032f0:	fe840593          	add	a1,s0,-24
    800032f4:	4505                	li	a0,1
    800032f6:	00000097          	auipc	ra,0x0
    800032fa:	b78080e7          	jalr	-1160(ra) # 80002e6e <argint>
  if (is_rcu)
    800032fe:	fe842783          	lw	a5,-24(s0)
    80003302:	cf81                	beqz	a5,8000331a <sys_klist_delete+0x40>
    {
      deleteNode(n);
    80003304:	fec42503          	lw	a0,-20(s0)
    80003308:	00003097          	auipc	ra,0x3
    8000330c:	792080e7          	jalr	1938(ra) # 80006a9a <deleteNode>
    } else{
      deleteNode_lock(n);
    }
  
  return 1;
}
    80003310:	4505                	li	a0,1
    80003312:	60e2                	ld	ra,24(sp)
    80003314:	6442                	ld	s0,16(sp)
    80003316:	6105                	add	sp,sp,32
    80003318:	8082                	ret
      deleteNode_lock(n);
    8000331a:	fec42503          	lw	a0,-20(s0)
    8000331e:	00003097          	auipc	ra,0x3
    80003322:	6d6080e7          	jalr	1750(ra) # 800069f4 <deleteNode_lock>
    80003326:	b7ed                	j	80003310 <sys_klist_delete+0x36>

0000000080003328 <sys_klist_query>:

uint64
sys_klist_query(void)
{
    80003328:	1101                	add	sp,sp,-32
    8000332a:	ec06                	sd	ra,24(sp)
    8000332c:	e822                	sd	s0,16(sp)
    8000332e:	1000                	add	s0,sp,32
  int n, is_rcu;
  argint(0, &n);
    80003330:	fec40593          	add	a1,s0,-20
    80003334:	4501                	li	a0,0
    80003336:	00000097          	auipc	ra,0x0
    8000333a:	b38080e7          	jalr	-1224(ra) # 80002e6e <argint>
  argint(1, &is_rcu);
    8000333e:	fe840593          	add	a1,s0,-24
    80003342:	4505                	li	a0,1
    80003344:	00000097          	auipc	ra,0x0
    80003348:	b2a080e7          	jalr	-1238(ra) # 80002e6e <argint>
  struct Node * res;
  if (is_rcu)
    8000334c:	fe842783          	lw	a5,-24(s0)
    80003350:	c78d                	beqz	a5,8000337a <sys_klist_query+0x52>
    {
      res = search(n);
    80003352:	fec42503          	lw	a0,-20(s0)
    80003356:	00003097          	auipc	ra,0x3
    8000335a:	7f6080e7          	jalr	2038(ra) # 80006b4c <search>
    } else{
      res = search_lock(n);
    }
    if (res!=0)
    8000335e:	c909                	beqz	a0,80003370 <sys_klist_query+0x48>
    {
      printf("present\n");    
    80003360:	00005517          	auipc	a0,0x5
    80003364:	25850513          	add	a0,a0,600 # 800085b8 <syscalls+0x130>
    80003368:	ffffd097          	auipc	ra,0xffffd
    8000336c:	21e080e7          	jalr	542(ra) # 80000586 <printf>
    }

  return 1;
}
    80003370:	4505                	li	a0,1
    80003372:	60e2                	ld	ra,24(sp)
    80003374:	6442                	ld	s0,16(sp)
    80003376:	6105                	add	sp,sp,32
    80003378:	8082                	ret
      res = search_lock(n);
    8000337a:	fec42503          	lw	a0,-20(s0)
    8000337e:	00004097          	auipc	ra,0x4
    80003382:	81a080e7          	jalr	-2022(ra) # 80006b98 <search_lock>
    80003386:	bfe1                	j	8000335e <sys_klist_query+0x36>

0000000080003388 <sys_klist_print>:

uint64
sys_klist_print(void)
{
    80003388:	1141                	add	sp,sp,-16
    8000338a:	e406                	sd	ra,8(sp)
    8000338c:	e022                	sd	s0,0(sp)
    8000338e:	0800                	add	s0,sp,16
    printList(); 
    80003390:	00004097          	auipc	ra,0x4
    80003394:	8a4080e7          	jalr	-1884(ra) # 80006c34 <printList>
  return 1;
    80003398:	4505                	li	a0,1
    8000339a:	60a2                	ld	ra,8(sp)
    8000339c:	6402                	ld	s0,0(sp)
    8000339e:	0141                	add	sp,sp,16
    800033a0:	8082                	ret

00000000800033a2 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    800033a2:	7179                	add	sp,sp,-48
    800033a4:	f406                	sd	ra,40(sp)
    800033a6:	f022                	sd	s0,32(sp)
    800033a8:	ec26                	sd	s1,24(sp)
    800033aa:	e84a                	sd	s2,16(sp)
    800033ac:	e44e                	sd	s3,8(sp)
    800033ae:	e052                	sd	s4,0(sp)
    800033b0:	1800                	add	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    800033b2:	00005597          	auipc	a1,0x5
    800033b6:	21658593          	add	a1,a1,534 # 800085c8 <syscalls+0x140>
    800033ba:	00014517          	auipc	a0,0x14
    800033be:	8de50513          	add	a0,a0,-1826 # 80016c98 <bcache>
    800033c2:	ffffd097          	auipc	ra,0xffffd
    800033c6:	7a2080e7          	jalr	1954(ra) # 80000b64 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    800033ca:	0001c797          	auipc	a5,0x1c
    800033ce:	8ce78793          	add	a5,a5,-1842 # 8001ec98 <bcache+0x8000>
    800033d2:	0001c717          	auipc	a4,0x1c
    800033d6:	b2e70713          	add	a4,a4,-1234 # 8001ef00 <bcache+0x8268>
    800033da:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    800033de:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800033e2:	00014497          	auipc	s1,0x14
    800033e6:	8ce48493          	add	s1,s1,-1842 # 80016cb0 <bcache+0x18>
    b->next = bcache.head.next;
    800033ea:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    800033ec:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    800033ee:	00005a17          	auipc	s4,0x5
    800033f2:	1e2a0a13          	add	s4,s4,482 # 800085d0 <syscalls+0x148>
    b->next = bcache.head.next;
    800033f6:	2b893783          	ld	a5,696(s2)
    800033fa:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    800033fc:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80003400:	85d2                	mv	a1,s4
    80003402:	01048513          	add	a0,s1,16
    80003406:	00001097          	auipc	ra,0x1
    8000340a:	496080e7          	jalr	1174(ra) # 8000489c <initsleeplock>
    bcache.head.next->prev = b;
    8000340e:	2b893783          	ld	a5,696(s2)
    80003412:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80003414:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80003418:	45848493          	add	s1,s1,1112
    8000341c:	fd349de3          	bne	s1,s3,800033f6 <binit+0x54>
  }
}
    80003420:	70a2                	ld	ra,40(sp)
    80003422:	7402                	ld	s0,32(sp)
    80003424:	64e2                	ld	s1,24(sp)
    80003426:	6942                	ld	s2,16(sp)
    80003428:	69a2                	ld	s3,8(sp)
    8000342a:	6a02                	ld	s4,0(sp)
    8000342c:	6145                	add	sp,sp,48
    8000342e:	8082                	ret

0000000080003430 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80003430:	7179                	add	sp,sp,-48
    80003432:	f406                	sd	ra,40(sp)
    80003434:	f022                	sd	s0,32(sp)
    80003436:	ec26                	sd	s1,24(sp)
    80003438:	e84a                	sd	s2,16(sp)
    8000343a:	e44e                	sd	s3,8(sp)
    8000343c:	1800                	add	s0,sp,48
    8000343e:	892a                	mv	s2,a0
    80003440:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    80003442:	00014517          	auipc	a0,0x14
    80003446:	85650513          	add	a0,a0,-1962 # 80016c98 <bcache>
    8000344a:	ffffd097          	auipc	ra,0xffffd
    8000344e:	7aa080e7          	jalr	1962(ra) # 80000bf4 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80003452:	0001c497          	auipc	s1,0x1c
    80003456:	afe4b483          	ld	s1,-1282(s1) # 8001ef50 <bcache+0x82b8>
    8000345a:	0001c797          	auipc	a5,0x1c
    8000345e:	aa678793          	add	a5,a5,-1370 # 8001ef00 <bcache+0x8268>
    80003462:	02f48f63          	beq	s1,a5,800034a0 <bread+0x70>
    80003466:	873e                	mv	a4,a5
    80003468:	a021                	j	80003470 <bread+0x40>
    8000346a:	68a4                	ld	s1,80(s1)
    8000346c:	02e48a63          	beq	s1,a4,800034a0 <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    80003470:	449c                	lw	a5,8(s1)
    80003472:	ff279ce3          	bne	a5,s2,8000346a <bread+0x3a>
    80003476:	44dc                	lw	a5,12(s1)
    80003478:	ff3799e3          	bne	a5,s3,8000346a <bread+0x3a>
      b->refcnt++;
    8000347c:	40bc                	lw	a5,64(s1)
    8000347e:	2785                	addw	a5,a5,1
    80003480:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80003482:	00014517          	auipc	a0,0x14
    80003486:	81650513          	add	a0,a0,-2026 # 80016c98 <bcache>
    8000348a:	ffffe097          	auipc	ra,0xffffe
    8000348e:	81e080e7          	jalr	-2018(ra) # 80000ca8 <release>
      acquiresleep(&b->lock);
    80003492:	01048513          	add	a0,s1,16
    80003496:	00001097          	auipc	ra,0x1
    8000349a:	440080e7          	jalr	1088(ra) # 800048d6 <acquiresleep>
      return b;
    8000349e:	a8b9                	j	800034fc <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800034a0:	0001c497          	auipc	s1,0x1c
    800034a4:	aa84b483          	ld	s1,-1368(s1) # 8001ef48 <bcache+0x82b0>
    800034a8:	0001c797          	auipc	a5,0x1c
    800034ac:	a5878793          	add	a5,a5,-1448 # 8001ef00 <bcache+0x8268>
    800034b0:	00f48863          	beq	s1,a5,800034c0 <bread+0x90>
    800034b4:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    800034b6:	40bc                	lw	a5,64(s1)
    800034b8:	cf81                	beqz	a5,800034d0 <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800034ba:	64a4                	ld	s1,72(s1)
    800034bc:	fee49de3          	bne	s1,a4,800034b6 <bread+0x86>
  panic("bget: no buffers");
    800034c0:	00005517          	auipc	a0,0x5
    800034c4:	11850513          	add	a0,a0,280 # 800085d8 <syscalls+0x150>
    800034c8:	ffffd097          	auipc	ra,0xffffd
    800034cc:	074080e7          	jalr	116(ra) # 8000053c <panic>
      b->dev = dev;
    800034d0:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    800034d4:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    800034d8:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    800034dc:	4785                	li	a5,1
    800034de:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800034e0:	00013517          	auipc	a0,0x13
    800034e4:	7b850513          	add	a0,a0,1976 # 80016c98 <bcache>
    800034e8:	ffffd097          	auipc	ra,0xffffd
    800034ec:	7c0080e7          	jalr	1984(ra) # 80000ca8 <release>
      acquiresleep(&b->lock);
    800034f0:	01048513          	add	a0,s1,16
    800034f4:	00001097          	auipc	ra,0x1
    800034f8:	3e2080e7          	jalr	994(ra) # 800048d6 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    800034fc:	409c                	lw	a5,0(s1)
    800034fe:	cb89                	beqz	a5,80003510 <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    80003500:	8526                	mv	a0,s1
    80003502:	70a2                	ld	ra,40(sp)
    80003504:	7402                	ld	s0,32(sp)
    80003506:	64e2                	ld	s1,24(sp)
    80003508:	6942                	ld	s2,16(sp)
    8000350a:	69a2                	ld	s3,8(sp)
    8000350c:	6145                	add	sp,sp,48
    8000350e:	8082                	ret
    virtio_disk_rw(b, 0);
    80003510:	4581                	li	a1,0
    80003512:	8526                	mv	a0,s1
    80003514:	00003097          	auipc	ra,0x3
    80003518:	f7e080e7          	jalr	-130(ra) # 80006492 <virtio_disk_rw>
    b->valid = 1;
    8000351c:	4785                	li	a5,1
    8000351e:	c09c                	sw	a5,0(s1)
  return b;
    80003520:	b7c5                	j	80003500 <bread+0xd0>

0000000080003522 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80003522:	1101                	add	sp,sp,-32
    80003524:	ec06                	sd	ra,24(sp)
    80003526:	e822                	sd	s0,16(sp)
    80003528:	e426                	sd	s1,8(sp)
    8000352a:	1000                	add	s0,sp,32
    8000352c:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    8000352e:	0541                	add	a0,a0,16
    80003530:	00001097          	auipc	ra,0x1
    80003534:	440080e7          	jalr	1088(ra) # 80004970 <holdingsleep>
    80003538:	cd01                	beqz	a0,80003550 <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    8000353a:	4585                	li	a1,1
    8000353c:	8526                	mv	a0,s1
    8000353e:	00003097          	auipc	ra,0x3
    80003542:	f54080e7          	jalr	-172(ra) # 80006492 <virtio_disk_rw>
}
    80003546:	60e2                	ld	ra,24(sp)
    80003548:	6442                	ld	s0,16(sp)
    8000354a:	64a2                	ld	s1,8(sp)
    8000354c:	6105                	add	sp,sp,32
    8000354e:	8082                	ret
    panic("bwrite");
    80003550:	00005517          	auipc	a0,0x5
    80003554:	0a050513          	add	a0,a0,160 # 800085f0 <syscalls+0x168>
    80003558:	ffffd097          	auipc	ra,0xffffd
    8000355c:	fe4080e7          	jalr	-28(ra) # 8000053c <panic>

0000000080003560 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80003560:	1101                	add	sp,sp,-32
    80003562:	ec06                	sd	ra,24(sp)
    80003564:	e822                	sd	s0,16(sp)
    80003566:	e426                	sd	s1,8(sp)
    80003568:	e04a                	sd	s2,0(sp)
    8000356a:	1000                	add	s0,sp,32
    8000356c:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    8000356e:	01050913          	add	s2,a0,16
    80003572:	854a                	mv	a0,s2
    80003574:	00001097          	auipc	ra,0x1
    80003578:	3fc080e7          	jalr	1020(ra) # 80004970 <holdingsleep>
    8000357c:	c925                	beqz	a0,800035ec <brelse+0x8c>
    panic("brelse");

  releasesleep(&b->lock);
    8000357e:	854a                	mv	a0,s2
    80003580:	00001097          	auipc	ra,0x1
    80003584:	3ac080e7          	jalr	940(ra) # 8000492c <releasesleep>

  acquire(&bcache.lock);
    80003588:	00013517          	auipc	a0,0x13
    8000358c:	71050513          	add	a0,a0,1808 # 80016c98 <bcache>
    80003590:	ffffd097          	auipc	ra,0xffffd
    80003594:	664080e7          	jalr	1636(ra) # 80000bf4 <acquire>
  b->refcnt--;
    80003598:	40bc                	lw	a5,64(s1)
    8000359a:	37fd                	addw	a5,a5,-1
    8000359c:	0007871b          	sext.w	a4,a5
    800035a0:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    800035a2:	e71d                	bnez	a4,800035d0 <brelse+0x70>
    // no one is waiting for it.
    b->next->prev = b->prev;
    800035a4:	68b8                	ld	a4,80(s1)
    800035a6:	64bc                	ld	a5,72(s1)
    800035a8:	e73c                	sd	a5,72(a4)
    b->prev->next = b->next;
    800035aa:	68b8                	ld	a4,80(s1)
    800035ac:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    800035ae:	0001b797          	auipc	a5,0x1b
    800035b2:	6ea78793          	add	a5,a5,1770 # 8001ec98 <bcache+0x8000>
    800035b6:	2b87b703          	ld	a4,696(a5)
    800035ba:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    800035bc:	0001c717          	auipc	a4,0x1c
    800035c0:	94470713          	add	a4,a4,-1724 # 8001ef00 <bcache+0x8268>
    800035c4:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    800035c6:	2b87b703          	ld	a4,696(a5)
    800035ca:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    800035cc:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    800035d0:	00013517          	auipc	a0,0x13
    800035d4:	6c850513          	add	a0,a0,1736 # 80016c98 <bcache>
    800035d8:	ffffd097          	auipc	ra,0xffffd
    800035dc:	6d0080e7          	jalr	1744(ra) # 80000ca8 <release>
}
    800035e0:	60e2                	ld	ra,24(sp)
    800035e2:	6442                	ld	s0,16(sp)
    800035e4:	64a2                	ld	s1,8(sp)
    800035e6:	6902                	ld	s2,0(sp)
    800035e8:	6105                	add	sp,sp,32
    800035ea:	8082                	ret
    panic("brelse");
    800035ec:	00005517          	auipc	a0,0x5
    800035f0:	00c50513          	add	a0,a0,12 # 800085f8 <syscalls+0x170>
    800035f4:	ffffd097          	auipc	ra,0xffffd
    800035f8:	f48080e7          	jalr	-184(ra) # 8000053c <panic>

00000000800035fc <bpin>:

void
bpin(struct buf *b) {
    800035fc:	1101                	add	sp,sp,-32
    800035fe:	ec06                	sd	ra,24(sp)
    80003600:	e822                	sd	s0,16(sp)
    80003602:	e426                	sd	s1,8(sp)
    80003604:	1000                	add	s0,sp,32
    80003606:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80003608:	00013517          	auipc	a0,0x13
    8000360c:	69050513          	add	a0,a0,1680 # 80016c98 <bcache>
    80003610:	ffffd097          	auipc	ra,0xffffd
    80003614:	5e4080e7          	jalr	1508(ra) # 80000bf4 <acquire>
  b->refcnt++;
    80003618:	40bc                	lw	a5,64(s1)
    8000361a:	2785                	addw	a5,a5,1
    8000361c:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8000361e:	00013517          	auipc	a0,0x13
    80003622:	67a50513          	add	a0,a0,1658 # 80016c98 <bcache>
    80003626:	ffffd097          	auipc	ra,0xffffd
    8000362a:	682080e7          	jalr	1666(ra) # 80000ca8 <release>
}
    8000362e:	60e2                	ld	ra,24(sp)
    80003630:	6442                	ld	s0,16(sp)
    80003632:	64a2                	ld	s1,8(sp)
    80003634:	6105                	add	sp,sp,32
    80003636:	8082                	ret

0000000080003638 <bunpin>:

void
bunpin(struct buf *b) {
    80003638:	1101                	add	sp,sp,-32
    8000363a:	ec06                	sd	ra,24(sp)
    8000363c:	e822                	sd	s0,16(sp)
    8000363e:	e426                	sd	s1,8(sp)
    80003640:	1000                	add	s0,sp,32
    80003642:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80003644:	00013517          	auipc	a0,0x13
    80003648:	65450513          	add	a0,a0,1620 # 80016c98 <bcache>
    8000364c:	ffffd097          	auipc	ra,0xffffd
    80003650:	5a8080e7          	jalr	1448(ra) # 80000bf4 <acquire>
  b->refcnt--;
    80003654:	40bc                	lw	a5,64(s1)
    80003656:	37fd                	addw	a5,a5,-1
    80003658:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8000365a:	00013517          	auipc	a0,0x13
    8000365e:	63e50513          	add	a0,a0,1598 # 80016c98 <bcache>
    80003662:	ffffd097          	auipc	ra,0xffffd
    80003666:	646080e7          	jalr	1606(ra) # 80000ca8 <release>
}
    8000366a:	60e2                	ld	ra,24(sp)
    8000366c:	6442                	ld	s0,16(sp)
    8000366e:	64a2                	ld	s1,8(sp)
    80003670:	6105                	add	sp,sp,32
    80003672:	8082                	ret

0000000080003674 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80003674:	1101                	add	sp,sp,-32
    80003676:	ec06                	sd	ra,24(sp)
    80003678:	e822                	sd	s0,16(sp)
    8000367a:	e426                	sd	s1,8(sp)
    8000367c:	e04a                	sd	s2,0(sp)
    8000367e:	1000                	add	s0,sp,32
    80003680:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80003682:	00d5d59b          	srlw	a1,a1,0xd
    80003686:	0001c797          	auipc	a5,0x1c
    8000368a:	cee7a783          	lw	a5,-786(a5) # 8001f374 <sb+0x1c>
    8000368e:	9dbd                	addw	a1,a1,a5
    80003690:	00000097          	auipc	ra,0x0
    80003694:	da0080e7          	jalr	-608(ra) # 80003430 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    80003698:	0074f713          	and	a4,s1,7
    8000369c:	4785                	li	a5,1
    8000369e:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    800036a2:	14ce                	sll	s1,s1,0x33
    800036a4:	90d9                	srl	s1,s1,0x36
    800036a6:	00950733          	add	a4,a0,s1
    800036aa:	05874703          	lbu	a4,88(a4)
    800036ae:	00e7f6b3          	and	a3,a5,a4
    800036b2:	c69d                	beqz	a3,800036e0 <bfree+0x6c>
    800036b4:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    800036b6:	94aa                	add	s1,s1,a0
    800036b8:	fff7c793          	not	a5,a5
    800036bc:	8f7d                	and	a4,a4,a5
    800036be:	04e48c23          	sb	a4,88(s1)
  log_write(bp);
    800036c2:	00001097          	auipc	ra,0x1
    800036c6:	0f6080e7          	jalr	246(ra) # 800047b8 <log_write>
  brelse(bp);
    800036ca:	854a                	mv	a0,s2
    800036cc:	00000097          	auipc	ra,0x0
    800036d0:	e94080e7          	jalr	-364(ra) # 80003560 <brelse>
}
    800036d4:	60e2                	ld	ra,24(sp)
    800036d6:	6442                	ld	s0,16(sp)
    800036d8:	64a2                	ld	s1,8(sp)
    800036da:	6902                	ld	s2,0(sp)
    800036dc:	6105                	add	sp,sp,32
    800036de:	8082                	ret
    panic("freeing free block");
    800036e0:	00005517          	auipc	a0,0x5
    800036e4:	f2050513          	add	a0,a0,-224 # 80008600 <syscalls+0x178>
    800036e8:	ffffd097          	auipc	ra,0xffffd
    800036ec:	e54080e7          	jalr	-428(ra) # 8000053c <panic>

00000000800036f0 <balloc>:
{
    800036f0:	711d                	add	sp,sp,-96
    800036f2:	ec86                	sd	ra,88(sp)
    800036f4:	e8a2                	sd	s0,80(sp)
    800036f6:	e4a6                	sd	s1,72(sp)
    800036f8:	e0ca                	sd	s2,64(sp)
    800036fa:	fc4e                	sd	s3,56(sp)
    800036fc:	f852                	sd	s4,48(sp)
    800036fe:	f456                	sd	s5,40(sp)
    80003700:	f05a                	sd	s6,32(sp)
    80003702:	ec5e                	sd	s7,24(sp)
    80003704:	e862                	sd	s8,16(sp)
    80003706:	e466                	sd	s9,8(sp)
    80003708:	1080                	add	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    8000370a:	0001c797          	auipc	a5,0x1c
    8000370e:	c527a783          	lw	a5,-942(a5) # 8001f35c <sb+0x4>
    80003712:	cff5                	beqz	a5,8000380e <balloc+0x11e>
    80003714:	8baa                	mv	s7,a0
    80003716:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80003718:	0001cb17          	auipc	s6,0x1c
    8000371c:	c40b0b13          	add	s6,s6,-960 # 8001f358 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003720:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    80003722:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003724:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80003726:	6c89                	lui	s9,0x2
    80003728:	a061                	j	800037b0 <balloc+0xc0>
        bp->data[bi/8] |= m;  // Mark block in use.
    8000372a:	97ca                	add	a5,a5,s2
    8000372c:	8e55                	or	a2,a2,a3
    8000372e:	04c78c23          	sb	a2,88(a5)
        log_write(bp);
    80003732:	854a                	mv	a0,s2
    80003734:	00001097          	auipc	ra,0x1
    80003738:	084080e7          	jalr	132(ra) # 800047b8 <log_write>
        brelse(bp);
    8000373c:	854a                	mv	a0,s2
    8000373e:	00000097          	auipc	ra,0x0
    80003742:	e22080e7          	jalr	-478(ra) # 80003560 <brelse>
  bp = bread(dev, bno);
    80003746:	85a6                	mv	a1,s1
    80003748:	855e                	mv	a0,s7
    8000374a:	00000097          	auipc	ra,0x0
    8000374e:	ce6080e7          	jalr	-794(ra) # 80003430 <bread>
    80003752:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    80003754:	40000613          	li	a2,1024
    80003758:	4581                	li	a1,0
    8000375a:	05850513          	add	a0,a0,88
    8000375e:	ffffd097          	auipc	ra,0xffffd
    80003762:	592080e7          	jalr	1426(ra) # 80000cf0 <memset>
  log_write(bp);
    80003766:	854a                	mv	a0,s2
    80003768:	00001097          	auipc	ra,0x1
    8000376c:	050080e7          	jalr	80(ra) # 800047b8 <log_write>
  brelse(bp);
    80003770:	854a                	mv	a0,s2
    80003772:	00000097          	auipc	ra,0x0
    80003776:	dee080e7          	jalr	-530(ra) # 80003560 <brelse>
}
    8000377a:	8526                	mv	a0,s1
    8000377c:	60e6                	ld	ra,88(sp)
    8000377e:	6446                	ld	s0,80(sp)
    80003780:	64a6                	ld	s1,72(sp)
    80003782:	6906                	ld	s2,64(sp)
    80003784:	79e2                	ld	s3,56(sp)
    80003786:	7a42                	ld	s4,48(sp)
    80003788:	7aa2                	ld	s5,40(sp)
    8000378a:	7b02                	ld	s6,32(sp)
    8000378c:	6be2                	ld	s7,24(sp)
    8000378e:	6c42                	ld	s8,16(sp)
    80003790:	6ca2                	ld	s9,8(sp)
    80003792:	6125                	add	sp,sp,96
    80003794:	8082                	ret
    brelse(bp);
    80003796:	854a                	mv	a0,s2
    80003798:	00000097          	auipc	ra,0x0
    8000379c:	dc8080e7          	jalr	-568(ra) # 80003560 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    800037a0:	015c87bb          	addw	a5,s9,s5
    800037a4:	00078a9b          	sext.w	s5,a5
    800037a8:	004b2703          	lw	a4,4(s6)
    800037ac:	06eaf163          	bgeu	s5,a4,8000380e <balloc+0x11e>
    bp = bread(dev, BBLOCK(b, sb));
    800037b0:	41fad79b          	sraw	a5,s5,0x1f
    800037b4:	0137d79b          	srlw	a5,a5,0x13
    800037b8:	015787bb          	addw	a5,a5,s5
    800037bc:	40d7d79b          	sraw	a5,a5,0xd
    800037c0:	01cb2583          	lw	a1,28(s6)
    800037c4:	9dbd                	addw	a1,a1,a5
    800037c6:	855e                	mv	a0,s7
    800037c8:	00000097          	auipc	ra,0x0
    800037cc:	c68080e7          	jalr	-920(ra) # 80003430 <bread>
    800037d0:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800037d2:	004b2503          	lw	a0,4(s6)
    800037d6:	000a849b          	sext.w	s1,s5
    800037da:	8762                	mv	a4,s8
    800037dc:	faa4fde3          	bgeu	s1,a0,80003796 <balloc+0xa6>
      m = 1 << (bi % 8);
    800037e0:	00777693          	and	a3,a4,7
    800037e4:	00d996bb          	sllw	a3,s3,a3
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    800037e8:	41f7579b          	sraw	a5,a4,0x1f
    800037ec:	01d7d79b          	srlw	a5,a5,0x1d
    800037f0:	9fb9                	addw	a5,a5,a4
    800037f2:	4037d79b          	sraw	a5,a5,0x3
    800037f6:	00f90633          	add	a2,s2,a5
    800037fa:	05864603          	lbu	a2,88(a2)
    800037fe:	00c6f5b3          	and	a1,a3,a2
    80003802:	d585                	beqz	a1,8000372a <balloc+0x3a>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003804:	2705                	addw	a4,a4,1
    80003806:	2485                	addw	s1,s1,1
    80003808:	fd471ae3          	bne	a4,s4,800037dc <balloc+0xec>
    8000380c:	b769                	j	80003796 <balloc+0xa6>
  printf("balloc: out of blocks\n");
    8000380e:	00005517          	auipc	a0,0x5
    80003812:	e0a50513          	add	a0,a0,-502 # 80008618 <syscalls+0x190>
    80003816:	ffffd097          	auipc	ra,0xffffd
    8000381a:	d70080e7          	jalr	-656(ra) # 80000586 <printf>
  return 0;
    8000381e:	4481                	li	s1,0
    80003820:	bfa9                	j	8000377a <balloc+0x8a>

0000000080003822 <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    80003822:	7179                	add	sp,sp,-48
    80003824:	f406                	sd	ra,40(sp)
    80003826:	f022                	sd	s0,32(sp)
    80003828:	ec26                	sd	s1,24(sp)
    8000382a:	e84a                	sd	s2,16(sp)
    8000382c:	e44e                	sd	s3,8(sp)
    8000382e:	e052                	sd	s4,0(sp)
    80003830:	1800                	add	s0,sp,48
    80003832:	89aa                	mv	s3,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80003834:	47ad                	li	a5,11
    80003836:	02b7e863          	bltu	a5,a1,80003866 <bmap+0x44>
    if((addr = ip->addrs[bn]) == 0){
    8000383a:	02059793          	sll	a5,a1,0x20
    8000383e:	01e7d593          	srl	a1,a5,0x1e
    80003842:	00b504b3          	add	s1,a0,a1
    80003846:	0504a903          	lw	s2,80(s1)
    8000384a:	06091e63          	bnez	s2,800038c6 <bmap+0xa4>
      addr = balloc(ip->dev);
    8000384e:	4108                	lw	a0,0(a0)
    80003850:	00000097          	auipc	ra,0x0
    80003854:	ea0080e7          	jalr	-352(ra) # 800036f0 <balloc>
    80003858:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    8000385c:	06090563          	beqz	s2,800038c6 <bmap+0xa4>
        return 0;
      ip->addrs[bn] = addr;
    80003860:	0524a823          	sw	s2,80(s1)
    80003864:	a08d                	j	800038c6 <bmap+0xa4>
    }
    return addr;
  }
  bn -= NDIRECT;
    80003866:	ff45849b          	addw	s1,a1,-12
    8000386a:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    8000386e:	0ff00793          	li	a5,255
    80003872:	08e7e563          	bltu	a5,a4,800038fc <bmap+0xda>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    80003876:	08052903          	lw	s2,128(a0)
    8000387a:	00091d63          	bnez	s2,80003894 <bmap+0x72>
      addr = balloc(ip->dev);
    8000387e:	4108                	lw	a0,0(a0)
    80003880:	00000097          	auipc	ra,0x0
    80003884:	e70080e7          	jalr	-400(ra) # 800036f0 <balloc>
    80003888:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    8000388c:	02090d63          	beqz	s2,800038c6 <bmap+0xa4>
        return 0;
      ip->addrs[NDIRECT] = addr;
    80003890:	0929a023          	sw	s2,128(s3)
    }
    bp = bread(ip->dev, addr);
    80003894:	85ca                	mv	a1,s2
    80003896:	0009a503          	lw	a0,0(s3)
    8000389a:	00000097          	auipc	ra,0x0
    8000389e:	b96080e7          	jalr	-1130(ra) # 80003430 <bread>
    800038a2:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    800038a4:	05850793          	add	a5,a0,88
    if((addr = a[bn]) == 0){
    800038a8:	02049713          	sll	a4,s1,0x20
    800038ac:	01e75593          	srl	a1,a4,0x1e
    800038b0:	00b784b3          	add	s1,a5,a1
    800038b4:	0004a903          	lw	s2,0(s1)
    800038b8:	02090063          	beqz	s2,800038d8 <bmap+0xb6>
      if(addr){
        a[bn] = addr;
        log_write(bp);
      }
    }
    brelse(bp);
    800038bc:	8552                	mv	a0,s4
    800038be:	00000097          	auipc	ra,0x0
    800038c2:	ca2080e7          	jalr	-862(ra) # 80003560 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    800038c6:	854a                	mv	a0,s2
    800038c8:	70a2                	ld	ra,40(sp)
    800038ca:	7402                	ld	s0,32(sp)
    800038cc:	64e2                	ld	s1,24(sp)
    800038ce:	6942                	ld	s2,16(sp)
    800038d0:	69a2                	ld	s3,8(sp)
    800038d2:	6a02                	ld	s4,0(sp)
    800038d4:	6145                	add	sp,sp,48
    800038d6:	8082                	ret
      addr = balloc(ip->dev);
    800038d8:	0009a503          	lw	a0,0(s3)
    800038dc:	00000097          	auipc	ra,0x0
    800038e0:	e14080e7          	jalr	-492(ra) # 800036f0 <balloc>
    800038e4:	0005091b          	sext.w	s2,a0
      if(addr){
    800038e8:	fc090ae3          	beqz	s2,800038bc <bmap+0x9a>
        a[bn] = addr;
    800038ec:	0124a023          	sw	s2,0(s1)
        log_write(bp);
    800038f0:	8552                	mv	a0,s4
    800038f2:	00001097          	auipc	ra,0x1
    800038f6:	ec6080e7          	jalr	-314(ra) # 800047b8 <log_write>
    800038fa:	b7c9                	j	800038bc <bmap+0x9a>
  panic("bmap: out of range");
    800038fc:	00005517          	auipc	a0,0x5
    80003900:	d3450513          	add	a0,a0,-716 # 80008630 <syscalls+0x1a8>
    80003904:	ffffd097          	auipc	ra,0xffffd
    80003908:	c38080e7          	jalr	-968(ra) # 8000053c <panic>

000000008000390c <iget>:
{
    8000390c:	7179                	add	sp,sp,-48
    8000390e:	f406                	sd	ra,40(sp)
    80003910:	f022                	sd	s0,32(sp)
    80003912:	ec26                	sd	s1,24(sp)
    80003914:	e84a                	sd	s2,16(sp)
    80003916:	e44e                	sd	s3,8(sp)
    80003918:	e052                	sd	s4,0(sp)
    8000391a:	1800                	add	s0,sp,48
    8000391c:	89aa                	mv	s3,a0
    8000391e:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    80003920:	0001c517          	auipc	a0,0x1c
    80003924:	a5850513          	add	a0,a0,-1448 # 8001f378 <itable>
    80003928:	ffffd097          	auipc	ra,0xffffd
    8000392c:	2cc080e7          	jalr	716(ra) # 80000bf4 <acquire>
  empty = 0;
    80003930:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80003932:	0001c497          	auipc	s1,0x1c
    80003936:	a5e48493          	add	s1,s1,-1442 # 8001f390 <itable+0x18>
    8000393a:	0001d697          	auipc	a3,0x1d
    8000393e:	4e668693          	add	a3,a3,1254 # 80020e20 <log>
    80003942:	a039                	j	80003950 <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80003944:	02090b63          	beqz	s2,8000397a <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80003948:	08848493          	add	s1,s1,136
    8000394c:	02d48a63          	beq	s1,a3,80003980 <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80003950:	449c                	lw	a5,8(s1)
    80003952:	fef059e3          	blez	a5,80003944 <iget+0x38>
    80003956:	4098                	lw	a4,0(s1)
    80003958:	ff3716e3          	bne	a4,s3,80003944 <iget+0x38>
    8000395c:	40d8                	lw	a4,4(s1)
    8000395e:	ff4713e3          	bne	a4,s4,80003944 <iget+0x38>
      ip->ref++;
    80003962:	2785                	addw	a5,a5,1
    80003964:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80003966:	0001c517          	auipc	a0,0x1c
    8000396a:	a1250513          	add	a0,a0,-1518 # 8001f378 <itable>
    8000396e:	ffffd097          	auipc	ra,0xffffd
    80003972:	33a080e7          	jalr	826(ra) # 80000ca8 <release>
      return ip;
    80003976:	8926                	mv	s2,s1
    80003978:	a03d                	j	800039a6 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    8000397a:	f7f9                	bnez	a5,80003948 <iget+0x3c>
    8000397c:	8926                	mv	s2,s1
    8000397e:	b7e9                	j	80003948 <iget+0x3c>
  if(empty == 0)
    80003980:	02090c63          	beqz	s2,800039b8 <iget+0xac>
  ip->dev = dev;
    80003984:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80003988:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    8000398c:	4785                	li	a5,1
    8000398e:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80003992:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80003996:	0001c517          	auipc	a0,0x1c
    8000399a:	9e250513          	add	a0,a0,-1566 # 8001f378 <itable>
    8000399e:	ffffd097          	auipc	ra,0xffffd
    800039a2:	30a080e7          	jalr	778(ra) # 80000ca8 <release>
}
    800039a6:	854a                	mv	a0,s2
    800039a8:	70a2                	ld	ra,40(sp)
    800039aa:	7402                	ld	s0,32(sp)
    800039ac:	64e2                	ld	s1,24(sp)
    800039ae:	6942                	ld	s2,16(sp)
    800039b0:	69a2                	ld	s3,8(sp)
    800039b2:	6a02                	ld	s4,0(sp)
    800039b4:	6145                	add	sp,sp,48
    800039b6:	8082                	ret
    panic("iget: no inodes");
    800039b8:	00005517          	auipc	a0,0x5
    800039bc:	c9050513          	add	a0,a0,-880 # 80008648 <syscalls+0x1c0>
    800039c0:	ffffd097          	auipc	ra,0xffffd
    800039c4:	b7c080e7          	jalr	-1156(ra) # 8000053c <panic>

00000000800039c8 <fsinit>:
fsinit(int dev) {
    800039c8:	7179                	add	sp,sp,-48
    800039ca:	f406                	sd	ra,40(sp)
    800039cc:	f022                	sd	s0,32(sp)
    800039ce:	ec26                	sd	s1,24(sp)
    800039d0:	e84a                	sd	s2,16(sp)
    800039d2:	e44e                	sd	s3,8(sp)
    800039d4:	1800                	add	s0,sp,48
    800039d6:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    800039d8:	4585                	li	a1,1
    800039da:	00000097          	auipc	ra,0x0
    800039de:	a56080e7          	jalr	-1450(ra) # 80003430 <bread>
    800039e2:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    800039e4:	0001c997          	auipc	s3,0x1c
    800039e8:	97498993          	add	s3,s3,-1676 # 8001f358 <sb>
    800039ec:	02000613          	li	a2,32
    800039f0:	05850593          	add	a1,a0,88
    800039f4:	854e                	mv	a0,s3
    800039f6:	ffffd097          	auipc	ra,0xffffd
    800039fa:	356080e7          	jalr	854(ra) # 80000d4c <memmove>
  brelse(bp);
    800039fe:	8526                	mv	a0,s1
    80003a00:	00000097          	auipc	ra,0x0
    80003a04:	b60080e7          	jalr	-1184(ra) # 80003560 <brelse>
  if(sb.magic != FSMAGIC)
    80003a08:	0009a703          	lw	a4,0(s3)
    80003a0c:	102037b7          	lui	a5,0x10203
    80003a10:	04078793          	add	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80003a14:	02f71263          	bne	a4,a5,80003a38 <fsinit+0x70>
  initlog(dev, &sb);
    80003a18:	0001c597          	auipc	a1,0x1c
    80003a1c:	94058593          	add	a1,a1,-1728 # 8001f358 <sb>
    80003a20:	854a                	mv	a0,s2
    80003a22:	00001097          	auipc	ra,0x1
    80003a26:	b2c080e7          	jalr	-1236(ra) # 8000454e <initlog>
}
    80003a2a:	70a2                	ld	ra,40(sp)
    80003a2c:	7402                	ld	s0,32(sp)
    80003a2e:	64e2                	ld	s1,24(sp)
    80003a30:	6942                	ld	s2,16(sp)
    80003a32:	69a2                	ld	s3,8(sp)
    80003a34:	6145                	add	sp,sp,48
    80003a36:	8082                	ret
    panic("invalid file system");
    80003a38:	00005517          	auipc	a0,0x5
    80003a3c:	c2050513          	add	a0,a0,-992 # 80008658 <syscalls+0x1d0>
    80003a40:	ffffd097          	auipc	ra,0xffffd
    80003a44:	afc080e7          	jalr	-1284(ra) # 8000053c <panic>

0000000080003a48 <iinit>:
{
    80003a48:	7179                	add	sp,sp,-48
    80003a4a:	f406                	sd	ra,40(sp)
    80003a4c:	f022                	sd	s0,32(sp)
    80003a4e:	ec26                	sd	s1,24(sp)
    80003a50:	e84a                	sd	s2,16(sp)
    80003a52:	e44e                	sd	s3,8(sp)
    80003a54:	1800                	add	s0,sp,48
  initlock(&itable.lock, "itable");
    80003a56:	00005597          	auipc	a1,0x5
    80003a5a:	c1a58593          	add	a1,a1,-998 # 80008670 <syscalls+0x1e8>
    80003a5e:	0001c517          	auipc	a0,0x1c
    80003a62:	91a50513          	add	a0,a0,-1766 # 8001f378 <itable>
    80003a66:	ffffd097          	auipc	ra,0xffffd
    80003a6a:	0fe080e7          	jalr	254(ra) # 80000b64 <initlock>
  for(i = 0; i < NINODE; i++) {
    80003a6e:	0001c497          	auipc	s1,0x1c
    80003a72:	93248493          	add	s1,s1,-1742 # 8001f3a0 <itable+0x28>
    80003a76:	0001d997          	auipc	s3,0x1d
    80003a7a:	3ba98993          	add	s3,s3,954 # 80020e30 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80003a7e:	00005917          	auipc	s2,0x5
    80003a82:	bfa90913          	add	s2,s2,-1030 # 80008678 <syscalls+0x1f0>
    80003a86:	85ca                	mv	a1,s2
    80003a88:	8526                	mv	a0,s1
    80003a8a:	00001097          	auipc	ra,0x1
    80003a8e:	e12080e7          	jalr	-494(ra) # 8000489c <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80003a92:	08848493          	add	s1,s1,136
    80003a96:	ff3498e3          	bne	s1,s3,80003a86 <iinit+0x3e>
}
    80003a9a:	70a2                	ld	ra,40(sp)
    80003a9c:	7402                	ld	s0,32(sp)
    80003a9e:	64e2                	ld	s1,24(sp)
    80003aa0:	6942                	ld	s2,16(sp)
    80003aa2:	69a2                	ld	s3,8(sp)
    80003aa4:	6145                	add	sp,sp,48
    80003aa6:	8082                	ret

0000000080003aa8 <ialloc>:
{
    80003aa8:	7139                	add	sp,sp,-64
    80003aaa:	fc06                	sd	ra,56(sp)
    80003aac:	f822                	sd	s0,48(sp)
    80003aae:	f426                	sd	s1,40(sp)
    80003ab0:	f04a                	sd	s2,32(sp)
    80003ab2:	ec4e                	sd	s3,24(sp)
    80003ab4:	e852                	sd	s4,16(sp)
    80003ab6:	e456                	sd	s5,8(sp)
    80003ab8:	e05a                	sd	s6,0(sp)
    80003aba:	0080                	add	s0,sp,64
  for(inum = 1; inum < sb.ninodes; inum++){
    80003abc:	0001c717          	auipc	a4,0x1c
    80003ac0:	8a872703          	lw	a4,-1880(a4) # 8001f364 <sb+0xc>
    80003ac4:	4785                	li	a5,1
    80003ac6:	04e7f863          	bgeu	a5,a4,80003b16 <ialloc+0x6e>
    80003aca:	8aaa                	mv	s5,a0
    80003acc:	8b2e                	mv	s6,a1
    80003ace:	4905                	li	s2,1
    bp = bread(dev, IBLOCK(inum, sb));
    80003ad0:	0001ca17          	auipc	s4,0x1c
    80003ad4:	888a0a13          	add	s4,s4,-1912 # 8001f358 <sb>
    80003ad8:	00495593          	srl	a1,s2,0x4
    80003adc:	018a2783          	lw	a5,24(s4)
    80003ae0:	9dbd                	addw	a1,a1,a5
    80003ae2:	8556                	mv	a0,s5
    80003ae4:	00000097          	auipc	ra,0x0
    80003ae8:	94c080e7          	jalr	-1716(ra) # 80003430 <bread>
    80003aec:	84aa                	mv	s1,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80003aee:	05850993          	add	s3,a0,88
    80003af2:	00f97793          	and	a5,s2,15
    80003af6:	079a                	sll	a5,a5,0x6
    80003af8:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80003afa:	00099783          	lh	a5,0(s3)
    80003afe:	cf9d                	beqz	a5,80003b3c <ialloc+0x94>
    brelse(bp);
    80003b00:	00000097          	auipc	ra,0x0
    80003b04:	a60080e7          	jalr	-1440(ra) # 80003560 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80003b08:	0905                	add	s2,s2,1
    80003b0a:	00ca2703          	lw	a4,12(s4)
    80003b0e:	0009079b          	sext.w	a5,s2
    80003b12:	fce7e3e3          	bltu	a5,a4,80003ad8 <ialloc+0x30>
  printf("ialloc: no inodes\n");
    80003b16:	00005517          	auipc	a0,0x5
    80003b1a:	b6a50513          	add	a0,a0,-1174 # 80008680 <syscalls+0x1f8>
    80003b1e:	ffffd097          	auipc	ra,0xffffd
    80003b22:	a68080e7          	jalr	-1432(ra) # 80000586 <printf>
  return 0;
    80003b26:	4501                	li	a0,0
}
    80003b28:	70e2                	ld	ra,56(sp)
    80003b2a:	7442                	ld	s0,48(sp)
    80003b2c:	74a2                	ld	s1,40(sp)
    80003b2e:	7902                	ld	s2,32(sp)
    80003b30:	69e2                	ld	s3,24(sp)
    80003b32:	6a42                	ld	s4,16(sp)
    80003b34:	6aa2                	ld	s5,8(sp)
    80003b36:	6b02                	ld	s6,0(sp)
    80003b38:	6121                	add	sp,sp,64
    80003b3a:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    80003b3c:	04000613          	li	a2,64
    80003b40:	4581                	li	a1,0
    80003b42:	854e                	mv	a0,s3
    80003b44:	ffffd097          	auipc	ra,0xffffd
    80003b48:	1ac080e7          	jalr	428(ra) # 80000cf0 <memset>
      dip->type = type;
    80003b4c:	01699023          	sh	s6,0(s3)
      log_write(bp);   // mark it allocated on the disk
    80003b50:	8526                	mv	a0,s1
    80003b52:	00001097          	auipc	ra,0x1
    80003b56:	c66080e7          	jalr	-922(ra) # 800047b8 <log_write>
      brelse(bp);
    80003b5a:	8526                	mv	a0,s1
    80003b5c:	00000097          	auipc	ra,0x0
    80003b60:	a04080e7          	jalr	-1532(ra) # 80003560 <brelse>
      return iget(dev, inum);
    80003b64:	0009059b          	sext.w	a1,s2
    80003b68:	8556                	mv	a0,s5
    80003b6a:	00000097          	auipc	ra,0x0
    80003b6e:	da2080e7          	jalr	-606(ra) # 8000390c <iget>
    80003b72:	bf5d                	j	80003b28 <ialloc+0x80>

0000000080003b74 <iupdate>:
{
    80003b74:	1101                	add	sp,sp,-32
    80003b76:	ec06                	sd	ra,24(sp)
    80003b78:	e822                	sd	s0,16(sp)
    80003b7a:	e426                	sd	s1,8(sp)
    80003b7c:	e04a                	sd	s2,0(sp)
    80003b7e:	1000                	add	s0,sp,32
    80003b80:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003b82:	415c                	lw	a5,4(a0)
    80003b84:	0047d79b          	srlw	a5,a5,0x4
    80003b88:	0001b597          	auipc	a1,0x1b
    80003b8c:	7e85a583          	lw	a1,2024(a1) # 8001f370 <sb+0x18>
    80003b90:	9dbd                	addw	a1,a1,a5
    80003b92:	4108                	lw	a0,0(a0)
    80003b94:	00000097          	auipc	ra,0x0
    80003b98:	89c080e7          	jalr	-1892(ra) # 80003430 <bread>
    80003b9c:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80003b9e:	05850793          	add	a5,a0,88
    80003ba2:	40d8                	lw	a4,4(s1)
    80003ba4:	8b3d                	and	a4,a4,15
    80003ba6:	071a                	sll	a4,a4,0x6
    80003ba8:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    80003baa:	04449703          	lh	a4,68(s1)
    80003bae:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80003bb2:	04649703          	lh	a4,70(s1)
    80003bb6:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80003bba:	04849703          	lh	a4,72(s1)
    80003bbe:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80003bc2:	04a49703          	lh	a4,74(s1)
    80003bc6:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80003bca:	44f8                	lw	a4,76(s1)
    80003bcc:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80003bce:	03400613          	li	a2,52
    80003bd2:	05048593          	add	a1,s1,80
    80003bd6:	00c78513          	add	a0,a5,12
    80003bda:	ffffd097          	auipc	ra,0xffffd
    80003bde:	172080e7          	jalr	370(ra) # 80000d4c <memmove>
  log_write(bp);
    80003be2:	854a                	mv	a0,s2
    80003be4:	00001097          	auipc	ra,0x1
    80003be8:	bd4080e7          	jalr	-1068(ra) # 800047b8 <log_write>
  brelse(bp);
    80003bec:	854a                	mv	a0,s2
    80003bee:	00000097          	auipc	ra,0x0
    80003bf2:	972080e7          	jalr	-1678(ra) # 80003560 <brelse>
}
    80003bf6:	60e2                	ld	ra,24(sp)
    80003bf8:	6442                	ld	s0,16(sp)
    80003bfa:	64a2                	ld	s1,8(sp)
    80003bfc:	6902                	ld	s2,0(sp)
    80003bfe:	6105                	add	sp,sp,32
    80003c00:	8082                	ret

0000000080003c02 <idup>:
{
    80003c02:	1101                	add	sp,sp,-32
    80003c04:	ec06                	sd	ra,24(sp)
    80003c06:	e822                	sd	s0,16(sp)
    80003c08:	e426                	sd	s1,8(sp)
    80003c0a:	1000                	add	s0,sp,32
    80003c0c:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80003c0e:	0001b517          	auipc	a0,0x1b
    80003c12:	76a50513          	add	a0,a0,1898 # 8001f378 <itable>
    80003c16:	ffffd097          	auipc	ra,0xffffd
    80003c1a:	fde080e7          	jalr	-34(ra) # 80000bf4 <acquire>
  ip->ref++;
    80003c1e:	449c                	lw	a5,8(s1)
    80003c20:	2785                	addw	a5,a5,1
    80003c22:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80003c24:	0001b517          	auipc	a0,0x1b
    80003c28:	75450513          	add	a0,a0,1876 # 8001f378 <itable>
    80003c2c:	ffffd097          	auipc	ra,0xffffd
    80003c30:	07c080e7          	jalr	124(ra) # 80000ca8 <release>
}
    80003c34:	8526                	mv	a0,s1
    80003c36:	60e2                	ld	ra,24(sp)
    80003c38:	6442                	ld	s0,16(sp)
    80003c3a:	64a2                	ld	s1,8(sp)
    80003c3c:	6105                	add	sp,sp,32
    80003c3e:	8082                	ret

0000000080003c40 <ilock>:
{
    80003c40:	1101                	add	sp,sp,-32
    80003c42:	ec06                	sd	ra,24(sp)
    80003c44:	e822                	sd	s0,16(sp)
    80003c46:	e426                	sd	s1,8(sp)
    80003c48:	e04a                	sd	s2,0(sp)
    80003c4a:	1000                	add	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80003c4c:	c115                	beqz	a0,80003c70 <ilock+0x30>
    80003c4e:	84aa                	mv	s1,a0
    80003c50:	451c                	lw	a5,8(a0)
    80003c52:	00f05f63          	blez	a5,80003c70 <ilock+0x30>
  acquiresleep(&ip->lock);
    80003c56:	0541                	add	a0,a0,16
    80003c58:	00001097          	auipc	ra,0x1
    80003c5c:	c7e080e7          	jalr	-898(ra) # 800048d6 <acquiresleep>
  if(ip->valid == 0){
    80003c60:	40bc                	lw	a5,64(s1)
    80003c62:	cf99                	beqz	a5,80003c80 <ilock+0x40>
}
    80003c64:	60e2                	ld	ra,24(sp)
    80003c66:	6442                	ld	s0,16(sp)
    80003c68:	64a2                	ld	s1,8(sp)
    80003c6a:	6902                	ld	s2,0(sp)
    80003c6c:	6105                	add	sp,sp,32
    80003c6e:	8082                	ret
    panic("ilock");
    80003c70:	00005517          	auipc	a0,0x5
    80003c74:	a2850513          	add	a0,a0,-1496 # 80008698 <syscalls+0x210>
    80003c78:	ffffd097          	auipc	ra,0xffffd
    80003c7c:	8c4080e7          	jalr	-1852(ra) # 8000053c <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003c80:	40dc                	lw	a5,4(s1)
    80003c82:	0047d79b          	srlw	a5,a5,0x4
    80003c86:	0001b597          	auipc	a1,0x1b
    80003c8a:	6ea5a583          	lw	a1,1770(a1) # 8001f370 <sb+0x18>
    80003c8e:	9dbd                	addw	a1,a1,a5
    80003c90:	4088                	lw	a0,0(s1)
    80003c92:	fffff097          	auipc	ra,0xfffff
    80003c96:	79e080e7          	jalr	1950(ra) # 80003430 <bread>
    80003c9a:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80003c9c:	05850593          	add	a1,a0,88
    80003ca0:	40dc                	lw	a5,4(s1)
    80003ca2:	8bbd                	and	a5,a5,15
    80003ca4:	079a                	sll	a5,a5,0x6
    80003ca6:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80003ca8:	00059783          	lh	a5,0(a1)
    80003cac:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80003cb0:	00259783          	lh	a5,2(a1)
    80003cb4:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80003cb8:	00459783          	lh	a5,4(a1)
    80003cbc:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80003cc0:	00659783          	lh	a5,6(a1)
    80003cc4:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80003cc8:	459c                	lw	a5,8(a1)
    80003cca:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80003ccc:	03400613          	li	a2,52
    80003cd0:	05b1                	add	a1,a1,12
    80003cd2:	05048513          	add	a0,s1,80
    80003cd6:	ffffd097          	auipc	ra,0xffffd
    80003cda:	076080e7          	jalr	118(ra) # 80000d4c <memmove>
    brelse(bp);
    80003cde:	854a                	mv	a0,s2
    80003ce0:	00000097          	auipc	ra,0x0
    80003ce4:	880080e7          	jalr	-1920(ra) # 80003560 <brelse>
    ip->valid = 1;
    80003ce8:	4785                	li	a5,1
    80003cea:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80003cec:	04449783          	lh	a5,68(s1)
    80003cf0:	fbb5                	bnez	a5,80003c64 <ilock+0x24>
      panic("ilock: no type");
    80003cf2:	00005517          	auipc	a0,0x5
    80003cf6:	9ae50513          	add	a0,a0,-1618 # 800086a0 <syscalls+0x218>
    80003cfa:	ffffd097          	auipc	ra,0xffffd
    80003cfe:	842080e7          	jalr	-1982(ra) # 8000053c <panic>

0000000080003d02 <iunlock>:
{
    80003d02:	1101                	add	sp,sp,-32
    80003d04:	ec06                	sd	ra,24(sp)
    80003d06:	e822                	sd	s0,16(sp)
    80003d08:	e426                	sd	s1,8(sp)
    80003d0a:	e04a                	sd	s2,0(sp)
    80003d0c:	1000                	add	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80003d0e:	c905                	beqz	a0,80003d3e <iunlock+0x3c>
    80003d10:	84aa                	mv	s1,a0
    80003d12:	01050913          	add	s2,a0,16
    80003d16:	854a                	mv	a0,s2
    80003d18:	00001097          	auipc	ra,0x1
    80003d1c:	c58080e7          	jalr	-936(ra) # 80004970 <holdingsleep>
    80003d20:	cd19                	beqz	a0,80003d3e <iunlock+0x3c>
    80003d22:	449c                	lw	a5,8(s1)
    80003d24:	00f05d63          	blez	a5,80003d3e <iunlock+0x3c>
  releasesleep(&ip->lock);
    80003d28:	854a                	mv	a0,s2
    80003d2a:	00001097          	auipc	ra,0x1
    80003d2e:	c02080e7          	jalr	-1022(ra) # 8000492c <releasesleep>
}
    80003d32:	60e2                	ld	ra,24(sp)
    80003d34:	6442                	ld	s0,16(sp)
    80003d36:	64a2                	ld	s1,8(sp)
    80003d38:	6902                	ld	s2,0(sp)
    80003d3a:	6105                	add	sp,sp,32
    80003d3c:	8082                	ret
    panic("iunlock");
    80003d3e:	00005517          	auipc	a0,0x5
    80003d42:	97250513          	add	a0,a0,-1678 # 800086b0 <syscalls+0x228>
    80003d46:	ffffc097          	auipc	ra,0xffffc
    80003d4a:	7f6080e7          	jalr	2038(ra) # 8000053c <panic>

0000000080003d4e <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80003d4e:	7179                	add	sp,sp,-48
    80003d50:	f406                	sd	ra,40(sp)
    80003d52:	f022                	sd	s0,32(sp)
    80003d54:	ec26                	sd	s1,24(sp)
    80003d56:	e84a                	sd	s2,16(sp)
    80003d58:	e44e                	sd	s3,8(sp)
    80003d5a:	e052                	sd	s4,0(sp)
    80003d5c:	1800                	add	s0,sp,48
    80003d5e:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80003d60:	05050493          	add	s1,a0,80
    80003d64:	08050913          	add	s2,a0,128
    80003d68:	a021                	j	80003d70 <itrunc+0x22>
    80003d6a:	0491                	add	s1,s1,4
    80003d6c:	01248d63          	beq	s1,s2,80003d86 <itrunc+0x38>
    if(ip->addrs[i]){
    80003d70:	408c                	lw	a1,0(s1)
    80003d72:	dde5                	beqz	a1,80003d6a <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    80003d74:	0009a503          	lw	a0,0(s3)
    80003d78:	00000097          	auipc	ra,0x0
    80003d7c:	8fc080e7          	jalr	-1796(ra) # 80003674 <bfree>
      ip->addrs[i] = 0;
    80003d80:	0004a023          	sw	zero,0(s1)
    80003d84:	b7dd                	j	80003d6a <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    80003d86:	0809a583          	lw	a1,128(s3)
    80003d8a:	e185                	bnez	a1,80003daa <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80003d8c:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80003d90:	854e                	mv	a0,s3
    80003d92:	00000097          	auipc	ra,0x0
    80003d96:	de2080e7          	jalr	-542(ra) # 80003b74 <iupdate>
}
    80003d9a:	70a2                	ld	ra,40(sp)
    80003d9c:	7402                	ld	s0,32(sp)
    80003d9e:	64e2                	ld	s1,24(sp)
    80003da0:	6942                	ld	s2,16(sp)
    80003da2:	69a2                	ld	s3,8(sp)
    80003da4:	6a02                	ld	s4,0(sp)
    80003da6:	6145                	add	sp,sp,48
    80003da8:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80003daa:	0009a503          	lw	a0,0(s3)
    80003dae:	fffff097          	auipc	ra,0xfffff
    80003db2:	682080e7          	jalr	1666(ra) # 80003430 <bread>
    80003db6:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80003db8:	05850493          	add	s1,a0,88
    80003dbc:	45850913          	add	s2,a0,1112
    80003dc0:	a021                	j	80003dc8 <itrunc+0x7a>
    80003dc2:	0491                	add	s1,s1,4
    80003dc4:	01248b63          	beq	s1,s2,80003dda <itrunc+0x8c>
      if(a[j])
    80003dc8:	408c                	lw	a1,0(s1)
    80003dca:	dde5                	beqz	a1,80003dc2 <itrunc+0x74>
        bfree(ip->dev, a[j]);
    80003dcc:	0009a503          	lw	a0,0(s3)
    80003dd0:	00000097          	auipc	ra,0x0
    80003dd4:	8a4080e7          	jalr	-1884(ra) # 80003674 <bfree>
    80003dd8:	b7ed                	j	80003dc2 <itrunc+0x74>
    brelse(bp);
    80003dda:	8552                	mv	a0,s4
    80003ddc:	fffff097          	auipc	ra,0xfffff
    80003de0:	784080e7          	jalr	1924(ra) # 80003560 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80003de4:	0809a583          	lw	a1,128(s3)
    80003de8:	0009a503          	lw	a0,0(s3)
    80003dec:	00000097          	auipc	ra,0x0
    80003df0:	888080e7          	jalr	-1912(ra) # 80003674 <bfree>
    ip->addrs[NDIRECT] = 0;
    80003df4:	0809a023          	sw	zero,128(s3)
    80003df8:	bf51                	j	80003d8c <itrunc+0x3e>

0000000080003dfa <iput>:
{
    80003dfa:	1101                	add	sp,sp,-32
    80003dfc:	ec06                	sd	ra,24(sp)
    80003dfe:	e822                	sd	s0,16(sp)
    80003e00:	e426                	sd	s1,8(sp)
    80003e02:	e04a                	sd	s2,0(sp)
    80003e04:	1000                	add	s0,sp,32
    80003e06:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80003e08:	0001b517          	auipc	a0,0x1b
    80003e0c:	57050513          	add	a0,a0,1392 # 8001f378 <itable>
    80003e10:	ffffd097          	auipc	ra,0xffffd
    80003e14:	de4080e7          	jalr	-540(ra) # 80000bf4 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80003e18:	4498                	lw	a4,8(s1)
    80003e1a:	4785                	li	a5,1
    80003e1c:	02f70363          	beq	a4,a5,80003e42 <iput+0x48>
  ip->ref--;
    80003e20:	449c                	lw	a5,8(s1)
    80003e22:	37fd                	addw	a5,a5,-1
    80003e24:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80003e26:	0001b517          	auipc	a0,0x1b
    80003e2a:	55250513          	add	a0,a0,1362 # 8001f378 <itable>
    80003e2e:	ffffd097          	auipc	ra,0xffffd
    80003e32:	e7a080e7          	jalr	-390(ra) # 80000ca8 <release>
}
    80003e36:	60e2                	ld	ra,24(sp)
    80003e38:	6442                	ld	s0,16(sp)
    80003e3a:	64a2                	ld	s1,8(sp)
    80003e3c:	6902                	ld	s2,0(sp)
    80003e3e:	6105                	add	sp,sp,32
    80003e40:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80003e42:	40bc                	lw	a5,64(s1)
    80003e44:	dff1                	beqz	a5,80003e20 <iput+0x26>
    80003e46:	04a49783          	lh	a5,74(s1)
    80003e4a:	fbf9                	bnez	a5,80003e20 <iput+0x26>
    acquiresleep(&ip->lock);
    80003e4c:	01048913          	add	s2,s1,16
    80003e50:	854a                	mv	a0,s2
    80003e52:	00001097          	auipc	ra,0x1
    80003e56:	a84080e7          	jalr	-1404(ra) # 800048d6 <acquiresleep>
    release(&itable.lock);
    80003e5a:	0001b517          	auipc	a0,0x1b
    80003e5e:	51e50513          	add	a0,a0,1310 # 8001f378 <itable>
    80003e62:	ffffd097          	auipc	ra,0xffffd
    80003e66:	e46080e7          	jalr	-442(ra) # 80000ca8 <release>
    itrunc(ip);
    80003e6a:	8526                	mv	a0,s1
    80003e6c:	00000097          	auipc	ra,0x0
    80003e70:	ee2080e7          	jalr	-286(ra) # 80003d4e <itrunc>
    ip->type = 0;
    80003e74:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80003e78:	8526                	mv	a0,s1
    80003e7a:	00000097          	auipc	ra,0x0
    80003e7e:	cfa080e7          	jalr	-774(ra) # 80003b74 <iupdate>
    ip->valid = 0;
    80003e82:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80003e86:	854a                	mv	a0,s2
    80003e88:	00001097          	auipc	ra,0x1
    80003e8c:	aa4080e7          	jalr	-1372(ra) # 8000492c <releasesleep>
    acquire(&itable.lock);
    80003e90:	0001b517          	auipc	a0,0x1b
    80003e94:	4e850513          	add	a0,a0,1256 # 8001f378 <itable>
    80003e98:	ffffd097          	auipc	ra,0xffffd
    80003e9c:	d5c080e7          	jalr	-676(ra) # 80000bf4 <acquire>
    80003ea0:	b741                	j	80003e20 <iput+0x26>

0000000080003ea2 <iunlockput>:
{
    80003ea2:	1101                	add	sp,sp,-32
    80003ea4:	ec06                	sd	ra,24(sp)
    80003ea6:	e822                	sd	s0,16(sp)
    80003ea8:	e426                	sd	s1,8(sp)
    80003eaa:	1000                	add	s0,sp,32
    80003eac:	84aa                	mv	s1,a0
  iunlock(ip);
    80003eae:	00000097          	auipc	ra,0x0
    80003eb2:	e54080e7          	jalr	-428(ra) # 80003d02 <iunlock>
  iput(ip);
    80003eb6:	8526                	mv	a0,s1
    80003eb8:	00000097          	auipc	ra,0x0
    80003ebc:	f42080e7          	jalr	-190(ra) # 80003dfa <iput>
}
    80003ec0:	60e2                	ld	ra,24(sp)
    80003ec2:	6442                	ld	s0,16(sp)
    80003ec4:	64a2                	ld	s1,8(sp)
    80003ec6:	6105                	add	sp,sp,32
    80003ec8:	8082                	ret

0000000080003eca <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80003eca:	1141                	add	sp,sp,-16
    80003ecc:	e422                	sd	s0,8(sp)
    80003ece:	0800                	add	s0,sp,16
  st->dev = ip->dev;
    80003ed0:	411c                	lw	a5,0(a0)
    80003ed2:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80003ed4:	415c                	lw	a5,4(a0)
    80003ed6:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80003ed8:	04451783          	lh	a5,68(a0)
    80003edc:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80003ee0:	04a51783          	lh	a5,74(a0)
    80003ee4:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80003ee8:	04c56783          	lwu	a5,76(a0)
    80003eec:	e99c                	sd	a5,16(a1)
}
    80003eee:	6422                	ld	s0,8(sp)
    80003ef0:	0141                	add	sp,sp,16
    80003ef2:	8082                	ret

0000000080003ef4 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003ef4:	457c                	lw	a5,76(a0)
    80003ef6:	0ed7e963          	bltu	a5,a3,80003fe8 <readi+0xf4>
{
    80003efa:	7159                	add	sp,sp,-112
    80003efc:	f486                	sd	ra,104(sp)
    80003efe:	f0a2                	sd	s0,96(sp)
    80003f00:	eca6                	sd	s1,88(sp)
    80003f02:	e8ca                	sd	s2,80(sp)
    80003f04:	e4ce                	sd	s3,72(sp)
    80003f06:	e0d2                	sd	s4,64(sp)
    80003f08:	fc56                	sd	s5,56(sp)
    80003f0a:	f85a                	sd	s6,48(sp)
    80003f0c:	f45e                	sd	s7,40(sp)
    80003f0e:	f062                	sd	s8,32(sp)
    80003f10:	ec66                	sd	s9,24(sp)
    80003f12:	e86a                	sd	s10,16(sp)
    80003f14:	e46e                	sd	s11,8(sp)
    80003f16:	1880                	add	s0,sp,112
    80003f18:	8b2a                	mv	s6,a0
    80003f1a:	8bae                	mv	s7,a1
    80003f1c:	8a32                	mv	s4,a2
    80003f1e:	84b6                	mv	s1,a3
    80003f20:	8aba                	mv	s5,a4
  if(off > ip->size || off + n < off)
    80003f22:	9f35                	addw	a4,a4,a3
    return 0;
    80003f24:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80003f26:	0ad76063          	bltu	a4,a3,80003fc6 <readi+0xd2>
  if(off + n > ip->size)
    80003f2a:	00e7f463          	bgeu	a5,a4,80003f32 <readi+0x3e>
    n = ip->size - off;
    80003f2e:	40d78abb          	subw	s5,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003f32:	0a0a8963          	beqz	s5,80003fe4 <readi+0xf0>
    80003f36:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80003f38:	40000c93          	li	s9,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80003f3c:	5c7d                	li	s8,-1
    80003f3e:	a82d                	j	80003f78 <readi+0x84>
    80003f40:	020d1d93          	sll	s11,s10,0x20
    80003f44:	020ddd93          	srl	s11,s11,0x20
    80003f48:	05890613          	add	a2,s2,88
    80003f4c:	86ee                	mv	a3,s11
    80003f4e:	963a                	add	a2,a2,a4
    80003f50:	85d2                	mv	a1,s4
    80003f52:	855e                	mv	a0,s7
    80003f54:	ffffe097          	auipc	ra,0xffffe
    80003f58:	54c080e7          	jalr	1356(ra) # 800024a0 <either_copyout>
    80003f5c:	05850d63          	beq	a0,s8,80003fb6 <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80003f60:	854a                	mv	a0,s2
    80003f62:	fffff097          	auipc	ra,0xfffff
    80003f66:	5fe080e7          	jalr	1534(ra) # 80003560 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003f6a:	013d09bb          	addw	s3,s10,s3
    80003f6e:	009d04bb          	addw	s1,s10,s1
    80003f72:	9a6e                	add	s4,s4,s11
    80003f74:	0559f763          	bgeu	s3,s5,80003fc2 <readi+0xce>
    uint addr = bmap(ip, off/BSIZE);
    80003f78:	00a4d59b          	srlw	a1,s1,0xa
    80003f7c:	855a                	mv	a0,s6
    80003f7e:	00000097          	auipc	ra,0x0
    80003f82:	8a4080e7          	jalr	-1884(ra) # 80003822 <bmap>
    80003f86:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    80003f8a:	cd85                	beqz	a1,80003fc2 <readi+0xce>
    bp = bread(ip->dev, addr);
    80003f8c:	000b2503          	lw	a0,0(s6)
    80003f90:	fffff097          	auipc	ra,0xfffff
    80003f94:	4a0080e7          	jalr	1184(ra) # 80003430 <bread>
    80003f98:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003f9a:	3ff4f713          	and	a4,s1,1023
    80003f9e:	40ec87bb          	subw	a5,s9,a4
    80003fa2:	413a86bb          	subw	a3,s5,s3
    80003fa6:	8d3e                	mv	s10,a5
    80003fa8:	2781                	sext.w	a5,a5
    80003faa:	0006861b          	sext.w	a2,a3
    80003fae:	f8f679e3          	bgeu	a2,a5,80003f40 <readi+0x4c>
    80003fb2:	8d36                	mv	s10,a3
    80003fb4:	b771                	j	80003f40 <readi+0x4c>
      brelse(bp);
    80003fb6:	854a                	mv	a0,s2
    80003fb8:	fffff097          	auipc	ra,0xfffff
    80003fbc:	5a8080e7          	jalr	1448(ra) # 80003560 <brelse>
      tot = -1;
    80003fc0:	59fd                	li	s3,-1
  }
  return tot;
    80003fc2:	0009851b          	sext.w	a0,s3
}
    80003fc6:	70a6                	ld	ra,104(sp)
    80003fc8:	7406                	ld	s0,96(sp)
    80003fca:	64e6                	ld	s1,88(sp)
    80003fcc:	6946                	ld	s2,80(sp)
    80003fce:	69a6                	ld	s3,72(sp)
    80003fd0:	6a06                	ld	s4,64(sp)
    80003fd2:	7ae2                	ld	s5,56(sp)
    80003fd4:	7b42                	ld	s6,48(sp)
    80003fd6:	7ba2                	ld	s7,40(sp)
    80003fd8:	7c02                	ld	s8,32(sp)
    80003fda:	6ce2                	ld	s9,24(sp)
    80003fdc:	6d42                	ld	s10,16(sp)
    80003fde:	6da2                	ld	s11,8(sp)
    80003fe0:	6165                	add	sp,sp,112
    80003fe2:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003fe4:	89d6                	mv	s3,s5
    80003fe6:	bff1                	j	80003fc2 <readi+0xce>
    return 0;
    80003fe8:	4501                	li	a0,0
}
    80003fea:	8082                	ret

0000000080003fec <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003fec:	457c                	lw	a5,76(a0)
    80003fee:	10d7e863          	bltu	a5,a3,800040fe <writei+0x112>
{
    80003ff2:	7159                	add	sp,sp,-112
    80003ff4:	f486                	sd	ra,104(sp)
    80003ff6:	f0a2                	sd	s0,96(sp)
    80003ff8:	eca6                	sd	s1,88(sp)
    80003ffa:	e8ca                	sd	s2,80(sp)
    80003ffc:	e4ce                	sd	s3,72(sp)
    80003ffe:	e0d2                	sd	s4,64(sp)
    80004000:	fc56                	sd	s5,56(sp)
    80004002:	f85a                	sd	s6,48(sp)
    80004004:	f45e                	sd	s7,40(sp)
    80004006:	f062                	sd	s8,32(sp)
    80004008:	ec66                	sd	s9,24(sp)
    8000400a:	e86a                	sd	s10,16(sp)
    8000400c:	e46e                	sd	s11,8(sp)
    8000400e:	1880                	add	s0,sp,112
    80004010:	8aaa                	mv	s5,a0
    80004012:	8bae                	mv	s7,a1
    80004014:	8a32                	mv	s4,a2
    80004016:	8936                	mv	s2,a3
    80004018:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    8000401a:	00e687bb          	addw	a5,a3,a4
    8000401e:	0ed7e263          	bltu	a5,a3,80004102 <writei+0x116>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80004022:	00043737          	lui	a4,0x43
    80004026:	0ef76063          	bltu	a4,a5,80004106 <writei+0x11a>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    8000402a:	0c0b0863          	beqz	s6,800040fa <writei+0x10e>
    8000402e:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80004030:	40000c93          	li	s9,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80004034:	5c7d                	li	s8,-1
    80004036:	a091                	j	8000407a <writei+0x8e>
    80004038:	020d1d93          	sll	s11,s10,0x20
    8000403c:	020ddd93          	srl	s11,s11,0x20
    80004040:	05848513          	add	a0,s1,88
    80004044:	86ee                	mv	a3,s11
    80004046:	8652                	mv	a2,s4
    80004048:	85de                	mv	a1,s7
    8000404a:	953a                	add	a0,a0,a4
    8000404c:	ffffe097          	auipc	ra,0xffffe
    80004050:	4aa080e7          	jalr	1194(ra) # 800024f6 <either_copyin>
    80004054:	07850263          	beq	a0,s8,800040b8 <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    80004058:	8526                	mv	a0,s1
    8000405a:	00000097          	auipc	ra,0x0
    8000405e:	75e080e7          	jalr	1886(ra) # 800047b8 <log_write>
    brelse(bp);
    80004062:	8526                	mv	a0,s1
    80004064:	fffff097          	auipc	ra,0xfffff
    80004068:	4fc080e7          	jalr	1276(ra) # 80003560 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    8000406c:	013d09bb          	addw	s3,s10,s3
    80004070:	012d093b          	addw	s2,s10,s2
    80004074:	9a6e                	add	s4,s4,s11
    80004076:	0569f663          	bgeu	s3,s6,800040c2 <writei+0xd6>
    uint addr = bmap(ip, off/BSIZE);
    8000407a:	00a9559b          	srlw	a1,s2,0xa
    8000407e:	8556                	mv	a0,s5
    80004080:	fffff097          	auipc	ra,0xfffff
    80004084:	7a2080e7          	jalr	1954(ra) # 80003822 <bmap>
    80004088:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    8000408c:	c99d                	beqz	a1,800040c2 <writei+0xd6>
    bp = bread(ip->dev, addr);
    8000408e:	000aa503          	lw	a0,0(s5)
    80004092:	fffff097          	auipc	ra,0xfffff
    80004096:	39e080e7          	jalr	926(ra) # 80003430 <bread>
    8000409a:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    8000409c:	3ff97713          	and	a4,s2,1023
    800040a0:	40ec87bb          	subw	a5,s9,a4
    800040a4:	413b06bb          	subw	a3,s6,s3
    800040a8:	8d3e                	mv	s10,a5
    800040aa:	2781                	sext.w	a5,a5
    800040ac:	0006861b          	sext.w	a2,a3
    800040b0:	f8f674e3          	bgeu	a2,a5,80004038 <writei+0x4c>
    800040b4:	8d36                	mv	s10,a3
    800040b6:	b749                	j	80004038 <writei+0x4c>
      brelse(bp);
    800040b8:	8526                	mv	a0,s1
    800040ba:	fffff097          	auipc	ra,0xfffff
    800040be:	4a6080e7          	jalr	1190(ra) # 80003560 <brelse>
  }

  if(off > ip->size)
    800040c2:	04caa783          	lw	a5,76(s5)
    800040c6:	0127f463          	bgeu	a5,s2,800040ce <writei+0xe2>
    ip->size = off;
    800040ca:	052aa623          	sw	s2,76(s5)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    800040ce:	8556                	mv	a0,s5
    800040d0:	00000097          	auipc	ra,0x0
    800040d4:	aa4080e7          	jalr	-1372(ra) # 80003b74 <iupdate>

  return tot;
    800040d8:	0009851b          	sext.w	a0,s3
}
    800040dc:	70a6                	ld	ra,104(sp)
    800040de:	7406                	ld	s0,96(sp)
    800040e0:	64e6                	ld	s1,88(sp)
    800040e2:	6946                	ld	s2,80(sp)
    800040e4:	69a6                	ld	s3,72(sp)
    800040e6:	6a06                	ld	s4,64(sp)
    800040e8:	7ae2                	ld	s5,56(sp)
    800040ea:	7b42                	ld	s6,48(sp)
    800040ec:	7ba2                	ld	s7,40(sp)
    800040ee:	7c02                	ld	s8,32(sp)
    800040f0:	6ce2                	ld	s9,24(sp)
    800040f2:	6d42                	ld	s10,16(sp)
    800040f4:	6da2                	ld	s11,8(sp)
    800040f6:	6165                	add	sp,sp,112
    800040f8:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800040fa:	89da                	mv	s3,s6
    800040fc:	bfc9                	j	800040ce <writei+0xe2>
    return -1;
    800040fe:	557d                	li	a0,-1
}
    80004100:	8082                	ret
    return -1;
    80004102:	557d                	li	a0,-1
    80004104:	bfe1                	j	800040dc <writei+0xf0>
    return -1;
    80004106:	557d                	li	a0,-1
    80004108:	bfd1                	j	800040dc <writei+0xf0>

000000008000410a <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    8000410a:	1141                	add	sp,sp,-16
    8000410c:	e406                	sd	ra,8(sp)
    8000410e:	e022                	sd	s0,0(sp)
    80004110:	0800                	add	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80004112:	4639                	li	a2,14
    80004114:	ffffd097          	auipc	ra,0xffffd
    80004118:	cac080e7          	jalr	-852(ra) # 80000dc0 <strncmp>
}
    8000411c:	60a2                	ld	ra,8(sp)
    8000411e:	6402                	ld	s0,0(sp)
    80004120:	0141                	add	sp,sp,16
    80004122:	8082                	ret

0000000080004124 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80004124:	7139                	add	sp,sp,-64
    80004126:	fc06                	sd	ra,56(sp)
    80004128:	f822                	sd	s0,48(sp)
    8000412a:	f426                	sd	s1,40(sp)
    8000412c:	f04a                	sd	s2,32(sp)
    8000412e:	ec4e                	sd	s3,24(sp)
    80004130:	e852                	sd	s4,16(sp)
    80004132:	0080                	add	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80004134:	04451703          	lh	a4,68(a0)
    80004138:	4785                	li	a5,1
    8000413a:	00f71a63          	bne	a4,a5,8000414e <dirlookup+0x2a>
    8000413e:	892a                	mv	s2,a0
    80004140:	89ae                	mv	s3,a1
    80004142:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80004144:	457c                	lw	a5,76(a0)
    80004146:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80004148:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000414a:	e79d                	bnez	a5,80004178 <dirlookup+0x54>
    8000414c:	a8a5                	j	800041c4 <dirlookup+0xa0>
    panic("dirlookup not DIR");
    8000414e:	00004517          	auipc	a0,0x4
    80004152:	56a50513          	add	a0,a0,1386 # 800086b8 <syscalls+0x230>
    80004156:	ffffc097          	auipc	ra,0xffffc
    8000415a:	3e6080e7          	jalr	998(ra) # 8000053c <panic>
      panic("dirlookup read");
    8000415e:	00004517          	auipc	a0,0x4
    80004162:	57250513          	add	a0,a0,1394 # 800086d0 <syscalls+0x248>
    80004166:	ffffc097          	auipc	ra,0xffffc
    8000416a:	3d6080e7          	jalr	982(ra) # 8000053c <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000416e:	24c1                	addw	s1,s1,16
    80004170:	04c92783          	lw	a5,76(s2)
    80004174:	04f4f763          	bgeu	s1,a5,800041c2 <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004178:	4741                	li	a4,16
    8000417a:	86a6                	mv	a3,s1
    8000417c:	fc040613          	add	a2,s0,-64
    80004180:	4581                	li	a1,0
    80004182:	854a                	mv	a0,s2
    80004184:	00000097          	auipc	ra,0x0
    80004188:	d70080e7          	jalr	-656(ra) # 80003ef4 <readi>
    8000418c:	47c1                	li	a5,16
    8000418e:	fcf518e3          	bne	a0,a5,8000415e <dirlookup+0x3a>
    if(de.inum == 0)
    80004192:	fc045783          	lhu	a5,-64(s0)
    80004196:	dfe1                	beqz	a5,8000416e <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    80004198:	fc240593          	add	a1,s0,-62
    8000419c:	854e                	mv	a0,s3
    8000419e:	00000097          	auipc	ra,0x0
    800041a2:	f6c080e7          	jalr	-148(ra) # 8000410a <namecmp>
    800041a6:	f561                	bnez	a0,8000416e <dirlookup+0x4a>
      if(poff)
    800041a8:	000a0463          	beqz	s4,800041b0 <dirlookup+0x8c>
        *poff = off;
    800041ac:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    800041b0:	fc045583          	lhu	a1,-64(s0)
    800041b4:	00092503          	lw	a0,0(s2)
    800041b8:	fffff097          	auipc	ra,0xfffff
    800041bc:	754080e7          	jalr	1876(ra) # 8000390c <iget>
    800041c0:	a011                	j	800041c4 <dirlookup+0xa0>
  return 0;
    800041c2:	4501                	li	a0,0
}
    800041c4:	70e2                	ld	ra,56(sp)
    800041c6:	7442                	ld	s0,48(sp)
    800041c8:	74a2                	ld	s1,40(sp)
    800041ca:	7902                	ld	s2,32(sp)
    800041cc:	69e2                	ld	s3,24(sp)
    800041ce:	6a42                	ld	s4,16(sp)
    800041d0:	6121                	add	sp,sp,64
    800041d2:	8082                	ret

00000000800041d4 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    800041d4:	711d                	add	sp,sp,-96
    800041d6:	ec86                	sd	ra,88(sp)
    800041d8:	e8a2                	sd	s0,80(sp)
    800041da:	e4a6                	sd	s1,72(sp)
    800041dc:	e0ca                	sd	s2,64(sp)
    800041de:	fc4e                	sd	s3,56(sp)
    800041e0:	f852                	sd	s4,48(sp)
    800041e2:	f456                	sd	s5,40(sp)
    800041e4:	f05a                	sd	s6,32(sp)
    800041e6:	ec5e                	sd	s7,24(sp)
    800041e8:	e862                	sd	s8,16(sp)
    800041ea:	e466                	sd	s9,8(sp)
    800041ec:	1080                	add	s0,sp,96
    800041ee:	84aa                	mv	s1,a0
    800041f0:	8b2e                	mv	s6,a1
    800041f2:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    800041f4:	00054703          	lbu	a4,0(a0)
    800041f8:	02f00793          	li	a5,47
    800041fc:	02f70263          	beq	a4,a5,80004220 <namex+0x4c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80004200:	ffffd097          	auipc	ra,0xffffd
    80004204:	7c8080e7          	jalr	1992(ra) # 800019c8 <myproc>
    80004208:	15053503          	ld	a0,336(a0)
    8000420c:	00000097          	auipc	ra,0x0
    80004210:	9f6080e7          	jalr	-1546(ra) # 80003c02 <idup>
    80004214:	8a2a                	mv	s4,a0
  while(*path == '/')
    80004216:	02f00913          	li	s2,47
  if(len >= DIRSIZ)
    8000421a:	4c35                	li	s8,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    8000421c:	4b85                	li	s7,1
    8000421e:	a875                	j	800042da <namex+0x106>
    ip = iget(ROOTDEV, ROOTINO);
    80004220:	4585                	li	a1,1
    80004222:	4505                	li	a0,1
    80004224:	fffff097          	auipc	ra,0xfffff
    80004228:	6e8080e7          	jalr	1768(ra) # 8000390c <iget>
    8000422c:	8a2a                	mv	s4,a0
    8000422e:	b7e5                	j	80004216 <namex+0x42>
      iunlockput(ip);
    80004230:	8552                	mv	a0,s4
    80004232:	00000097          	auipc	ra,0x0
    80004236:	c70080e7          	jalr	-912(ra) # 80003ea2 <iunlockput>
      return 0;
    8000423a:	4a01                	li	s4,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    8000423c:	8552                	mv	a0,s4
    8000423e:	60e6                	ld	ra,88(sp)
    80004240:	6446                	ld	s0,80(sp)
    80004242:	64a6                	ld	s1,72(sp)
    80004244:	6906                	ld	s2,64(sp)
    80004246:	79e2                	ld	s3,56(sp)
    80004248:	7a42                	ld	s4,48(sp)
    8000424a:	7aa2                	ld	s5,40(sp)
    8000424c:	7b02                	ld	s6,32(sp)
    8000424e:	6be2                	ld	s7,24(sp)
    80004250:	6c42                	ld	s8,16(sp)
    80004252:	6ca2                	ld	s9,8(sp)
    80004254:	6125                	add	sp,sp,96
    80004256:	8082                	ret
      iunlock(ip);
    80004258:	8552                	mv	a0,s4
    8000425a:	00000097          	auipc	ra,0x0
    8000425e:	aa8080e7          	jalr	-1368(ra) # 80003d02 <iunlock>
      return ip;
    80004262:	bfe9                	j	8000423c <namex+0x68>
      iunlockput(ip);
    80004264:	8552                	mv	a0,s4
    80004266:	00000097          	auipc	ra,0x0
    8000426a:	c3c080e7          	jalr	-964(ra) # 80003ea2 <iunlockput>
      return 0;
    8000426e:	8a4e                	mv	s4,s3
    80004270:	b7f1                	j	8000423c <namex+0x68>
  len = path - s;
    80004272:	40998633          	sub	a2,s3,s1
    80004276:	00060c9b          	sext.w	s9,a2
  if(len >= DIRSIZ)
    8000427a:	099c5863          	bge	s8,s9,8000430a <namex+0x136>
    memmove(name, s, DIRSIZ);
    8000427e:	4639                	li	a2,14
    80004280:	85a6                	mv	a1,s1
    80004282:	8556                	mv	a0,s5
    80004284:	ffffd097          	auipc	ra,0xffffd
    80004288:	ac8080e7          	jalr	-1336(ra) # 80000d4c <memmove>
    8000428c:	84ce                	mv	s1,s3
  while(*path == '/')
    8000428e:	0004c783          	lbu	a5,0(s1)
    80004292:	01279763          	bne	a5,s2,800042a0 <namex+0xcc>
    path++;
    80004296:	0485                	add	s1,s1,1
  while(*path == '/')
    80004298:	0004c783          	lbu	a5,0(s1)
    8000429c:	ff278de3          	beq	a5,s2,80004296 <namex+0xc2>
    ilock(ip);
    800042a0:	8552                	mv	a0,s4
    800042a2:	00000097          	auipc	ra,0x0
    800042a6:	99e080e7          	jalr	-1634(ra) # 80003c40 <ilock>
    if(ip->type != T_DIR){
    800042aa:	044a1783          	lh	a5,68(s4)
    800042ae:	f97791e3          	bne	a5,s7,80004230 <namex+0x5c>
    if(nameiparent && *path == '\0'){
    800042b2:	000b0563          	beqz	s6,800042bc <namex+0xe8>
    800042b6:	0004c783          	lbu	a5,0(s1)
    800042ba:	dfd9                	beqz	a5,80004258 <namex+0x84>
    if((next = dirlookup(ip, name, 0)) == 0){
    800042bc:	4601                	li	a2,0
    800042be:	85d6                	mv	a1,s5
    800042c0:	8552                	mv	a0,s4
    800042c2:	00000097          	auipc	ra,0x0
    800042c6:	e62080e7          	jalr	-414(ra) # 80004124 <dirlookup>
    800042ca:	89aa                	mv	s3,a0
    800042cc:	dd41                	beqz	a0,80004264 <namex+0x90>
    iunlockput(ip);
    800042ce:	8552                	mv	a0,s4
    800042d0:	00000097          	auipc	ra,0x0
    800042d4:	bd2080e7          	jalr	-1070(ra) # 80003ea2 <iunlockput>
    ip = next;
    800042d8:	8a4e                	mv	s4,s3
  while(*path == '/')
    800042da:	0004c783          	lbu	a5,0(s1)
    800042de:	01279763          	bne	a5,s2,800042ec <namex+0x118>
    path++;
    800042e2:	0485                	add	s1,s1,1
  while(*path == '/')
    800042e4:	0004c783          	lbu	a5,0(s1)
    800042e8:	ff278de3          	beq	a5,s2,800042e2 <namex+0x10e>
  if(*path == 0)
    800042ec:	cb9d                	beqz	a5,80004322 <namex+0x14e>
  while(*path != '/' && *path != 0)
    800042ee:	0004c783          	lbu	a5,0(s1)
    800042f2:	89a6                	mv	s3,s1
  len = path - s;
    800042f4:	4c81                	li	s9,0
    800042f6:	4601                	li	a2,0
  while(*path != '/' && *path != 0)
    800042f8:	01278963          	beq	a5,s2,8000430a <namex+0x136>
    800042fc:	dbbd                	beqz	a5,80004272 <namex+0x9e>
    path++;
    800042fe:	0985                	add	s3,s3,1
  while(*path != '/' && *path != 0)
    80004300:	0009c783          	lbu	a5,0(s3)
    80004304:	ff279ce3          	bne	a5,s2,800042fc <namex+0x128>
    80004308:	b7ad                	j	80004272 <namex+0x9e>
    memmove(name, s, len);
    8000430a:	2601                	sext.w	a2,a2
    8000430c:	85a6                	mv	a1,s1
    8000430e:	8556                	mv	a0,s5
    80004310:	ffffd097          	auipc	ra,0xffffd
    80004314:	a3c080e7          	jalr	-1476(ra) # 80000d4c <memmove>
    name[len] = 0;
    80004318:	9cd6                	add	s9,s9,s5
    8000431a:	000c8023          	sb	zero,0(s9) # 2000 <_entry-0x7fffe000>
    8000431e:	84ce                	mv	s1,s3
    80004320:	b7bd                	j	8000428e <namex+0xba>
  if(nameiparent){
    80004322:	f00b0de3          	beqz	s6,8000423c <namex+0x68>
    iput(ip);
    80004326:	8552                	mv	a0,s4
    80004328:	00000097          	auipc	ra,0x0
    8000432c:	ad2080e7          	jalr	-1326(ra) # 80003dfa <iput>
    return 0;
    80004330:	4a01                	li	s4,0
    80004332:	b729                	j	8000423c <namex+0x68>

0000000080004334 <dirlink>:
{
    80004334:	7139                	add	sp,sp,-64
    80004336:	fc06                	sd	ra,56(sp)
    80004338:	f822                	sd	s0,48(sp)
    8000433a:	f426                	sd	s1,40(sp)
    8000433c:	f04a                	sd	s2,32(sp)
    8000433e:	ec4e                	sd	s3,24(sp)
    80004340:	e852                	sd	s4,16(sp)
    80004342:	0080                	add	s0,sp,64
    80004344:	892a                	mv	s2,a0
    80004346:	8a2e                	mv	s4,a1
    80004348:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    8000434a:	4601                	li	a2,0
    8000434c:	00000097          	auipc	ra,0x0
    80004350:	dd8080e7          	jalr	-552(ra) # 80004124 <dirlookup>
    80004354:	e93d                	bnez	a0,800043ca <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80004356:	04c92483          	lw	s1,76(s2)
    8000435a:	c49d                	beqz	s1,80004388 <dirlink+0x54>
    8000435c:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000435e:	4741                	li	a4,16
    80004360:	86a6                	mv	a3,s1
    80004362:	fc040613          	add	a2,s0,-64
    80004366:	4581                	li	a1,0
    80004368:	854a                	mv	a0,s2
    8000436a:	00000097          	auipc	ra,0x0
    8000436e:	b8a080e7          	jalr	-1142(ra) # 80003ef4 <readi>
    80004372:	47c1                	li	a5,16
    80004374:	06f51163          	bne	a0,a5,800043d6 <dirlink+0xa2>
    if(de.inum == 0)
    80004378:	fc045783          	lhu	a5,-64(s0)
    8000437c:	c791                	beqz	a5,80004388 <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000437e:	24c1                	addw	s1,s1,16
    80004380:	04c92783          	lw	a5,76(s2)
    80004384:	fcf4ede3          	bltu	s1,a5,8000435e <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    80004388:	4639                	li	a2,14
    8000438a:	85d2                	mv	a1,s4
    8000438c:	fc240513          	add	a0,s0,-62
    80004390:	ffffd097          	auipc	ra,0xffffd
    80004394:	a6c080e7          	jalr	-1428(ra) # 80000dfc <strncpy>
  de.inum = inum;
    80004398:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000439c:	4741                	li	a4,16
    8000439e:	86a6                	mv	a3,s1
    800043a0:	fc040613          	add	a2,s0,-64
    800043a4:	4581                	li	a1,0
    800043a6:	854a                	mv	a0,s2
    800043a8:	00000097          	auipc	ra,0x0
    800043ac:	c44080e7          	jalr	-956(ra) # 80003fec <writei>
    800043b0:	1541                	add	a0,a0,-16
    800043b2:	00a03533          	snez	a0,a0
    800043b6:	40a00533          	neg	a0,a0
}
    800043ba:	70e2                	ld	ra,56(sp)
    800043bc:	7442                	ld	s0,48(sp)
    800043be:	74a2                	ld	s1,40(sp)
    800043c0:	7902                	ld	s2,32(sp)
    800043c2:	69e2                	ld	s3,24(sp)
    800043c4:	6a42                	ld	s4,16(sp)
    800043c6:	6121                	add	sp,sp,64
    800043c8:	8082                	ret
    iput(ip);
    800043ca:	00000097          	auipc	ra,0x0
    800043ce:	a30080e7          	jalr	-1488(ra) # 80003dfa <iput>
    return -1;
    800043d2:	557d                	li	a0,-1
    800043d4:	b7dd                	j	800043ba <dirlink+0x86>
      panic("dirlink read");
    800043d6:	00004517          	auipc	a0,0x4
    800043da:	30a50513          	add	a0,a0,778 # 800086e0 <syscalls+0x258>
    800043de:	ffffc097          	auipc	ra,0xffffc
    800043e2:	15e080e7          	jalr	350(ra) # 8000053c <panic>

00000000800043e6 <namei>:

struct inode*
namei(char *path)
{
    800043e6:	1101                	add	sp,sp,-32
    800043e8:	ec06                	sd	ra,24(sp)
    800043ea:	e822                	sd	s0,16(sp)
    800043ec:	1000                	add	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    800043ee:	fe040613          	add	a2,s0,-32
    800043f2:	4581                	li	a1,0
    800043f4:	00000097          	auipc	ra,0x0
    800043f8:	de0080e7          	jalr	-544(ra) # 800041d4 <namex>
}
    800043fc:	60e2                	ld	ra,24(sp)
    800043fe:	6442                	ld	s0,16(sp)
    80004400:	6105                	add	sp,sp,32
    80004402:	8082                	ret

0000000080004404 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80004404:	1141                	add	sp,sp,-16
    80004406:	e406                	sd	ra,8(sp)
    80004408:	e022                	sd	s0,0(sp)
    8000440a:	0800                	add	s0,sp,16
    8000440c:	862e                	mv	a2,a1
  return namex(path, 1, name);
    8000440e:	4585                	li	a1,1
    80004410:	00000097          	auipc	ra,0x0
    80004414:	dc4080e7          	jalr	-572(ra) # 800041d4 <namex>
}
    80004418:	60a2                	ld	ra,8(sp)
    8000441a:	6402                	ld	s0,0(sp)
    8000441c:	0141                	add	sp,sp,16
    8000441e:	8082                	ret

0000000080004420 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80004420:	1101                	add	sp,sp,-32
    80004422:	ec06                	sd	ra,24(sp)
    80004424:	e822                	sd	s0,16(sp)
    80004426:	e426                	sd	s1,8(sp)
    80004428:	e04a                	sd	s2,0(sp)
    8000442a:	1000                	add	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    8000442c:	0001d917          	auipc	s2,0x1d
    80004430:	9f490913          	add	s2,s2,-1548 # 80020e20 <log>
    80004434:	01892583          	lw	a1,24(s2)
    80004438:	02892503          	lw	a0,40(s2)
    8000443c:	fffff097          	auipc	ra,0xfffff
    80004440:	ff4080e7          	jalr	-12(ra) # 80003430 <bread>
    80004444:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    80004446:	02c92603          	lw	a2,44(s2)
    8000444a:	cd30                	sw	a2,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    8000444c:	00c05f63          	blez	a2,8000446a <write_head+0x4a>
    80004450:	0001d717          	auipc	a4,0x1d
    80004454:	a0070713          	add	a4,a4,-1536 # 80020e50 <log+0x30>
    80004458:	87aa                	mv	a5,a0
    8000445a:	060a                	sll	a2,a2,0x2
    8000445c:	962a                	add	a2,a2,a0
    hb->block[i] = log.lh.block[i];
    8000445e:	4314                	lw	a3,0(a4)
    80004460:	cff4                	sw	a3,92(a5)
  for (i = 0; i < log.lh.n; i++) {
    80004462:	0711                	add	a4,a4,4
    80004464:	0791                	add	a5,a5,4
    80004466:	fec79ce3          	bne	a5,a2,8000445e <write_head+0x3e>
  }
  bwrite(buf);
    8000446a:	8526                	mv	a0,s1
    8000446c:	fffff097          	auipc	ra,0xfffff
    80004470:	0b6080e7          	jalr	182(ra) # 80003522 <bwrite>
  brelse(buf);
    80004474:	8526                	mv	a0,s1
    80004476:	fffff097          	auipc	ra,0xfffff
    8000447a:	0ea080e7          	jalr	234(ra) # 80003560 <brelse>
}
    8000447e:	60e2                	ld	ra,24(sp)
    80004480:	6442                	ld	s0,16(sp)
    80004482:	64a2                	ld	s1,8(sp)
    80004484:	6902                	ld	s2,0(sp)
    80004486:	6105                	add	sp,sp,32
    80004488:	8082                	ret

000000008000448a <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    8000448a:	0001d797          	auipc	a5,0x1d
    8000448e:	9c27a783          	lw	a5,-1598(a5) # 80020e4c <log+0x2c>
    80004492:	0af05d63          	blez	a5,8000454c <install_trans+0xc2>
{
    80004496:	7139                	add	sp,sp,-64
    80004498:	fc06                	sd	ra,56(sp)
    8000449a:	f822                	sd	s0,48(sp)
    8000449c:	f426                	sd	s1,40(sp)
    8000449e:	f04a                	sd	s2,32(sp)
    800044a0:	ec4e                	sd	s3,24(sp)
    800044a2:	e852                	sd	s4,16(sp)
    800044a4:	e456                	sd	s5,8(sp)
    800044a6:	e05a                	sd	s6,0(sp)
    800044a8:	0080                	add	s0,sp,64
    800044aa:	8b2a                	mv	s6,a0
    800044ac:	0001da97          	auipc	s5,0x1d
    800044b0:	9a4a8a93          	add	s5,s5,-1628 # 80020e50 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    800044b4:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    800044b6:	0001d997          	auipc	s3,0x1d
    800044ba:	96a98993          	add	s3,s3,-1686 # 80020e20 <log>
    800044be:	a00d                	j	800044e0 <install_trans+0x56>
    brelse(lbuf);
    800044c0:	854a                	mv	a0,s2
    800044c2:	fffff097          	auipc	ra,0xfffff
    800044c6:	09e080e7          	jalr	158(ra) # 80003560 <brelse>
    brelse(dbuf);
    800044ca:	8526                	mv	a0,s1
    800044cc:	fffff097          	auipc	ra,0xfffff
    800044d0:	094080e7          	jalr	148(ra) # 80003560 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800044d4:	2a05                	addw	s4,s4,1
    800044d6:	0a91                	add	s5,s5,4
    800044d8:	02c9a783          	lw	a5,44(s3)
    800044dc:	04fa5e63          	bge	s4,a5,80004538 <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    800044e0:	0189a583          	lw	a1,24(s3)
    800044e4:	014585bb          	addw	a1,a1,s4
    800044e8:	2585                	addw	a1,a1,1
    800044ea:	0289a503          	lw	a0,40(s3)
    800044ee:	fffff097          	auipc	ra,0xfffff
    800044f2:	f42080e7          	jalr	-190(ra) # 80003430 <bread>
    800044f6:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    800044f8:	000aa583          	lw	a1,0(s5)
    800044fc:	0289a503          	lw	a0,40(s3)
    80004500:	fffff097          	auipc	ra,0xfffff
    80004504:	f30080e7          	jalr	-208(ra) # 80003430 <bread>
    80004508:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    8000450a:	40000613          	li	a2,1024
    8000450e:	05890593          	add	a1,s2,88
    80004512:	05850513          	add	a0,a0,88
    80004516:	ffffd097          	auipc	ra,0xffffd
    8000451a:	836080e7          	jalr	-1994(ra) # 80000d4c <memmove>
    bwrite(dbuf);  // write dst to disk
    8000451e:	8526                	mv	a0,s1
    80004520:	fffff097          	auipc	ra,0xfffff
    80004524:	002080e7          	jalr	2(ra) # 80003522 <bwrite>
    if(recovering == 0)
    80004528:	f80b1ce3          	bnez	s6,800044c0 <install_trans+0x36>
      bunpin(dbuf);
    8000452c:	8526                	mv	a0,s1
    8000452e:	fffff097          	auipc	ra,0xfffff
    80004532:	10a080e7          	jalr	266(ra) # 80003638 <bunpin>
    80004536:	b769                	j	800044c0 <install_trans+0x36>
}
    80004538:	70e2                	ld	ra,56(sp)
    8000453a:	7442                	ld	s0,48(sp)
    8000453c:	74a2                	ld	s1,40(sp)
    8000453e:	7902                	ld	s2,32(sp)
    80004540:	69e2                	ld	s3,24(sp)
    80004542:	6a42                	ld	s4,16(sp)
    80004544:	6aa2                	ld	s5,8(sp)
    80004546:	6b02                	ld	s6,0(sp)
    80004548:	6121                	add	sp,sp,64
    8000454a:	8082                	ret
    8000454c:	8082                	ret

000000008000454e <initlog>:
{
    8000454e:	7179                	add	sp,sp,-48
    80004550:	f406                	sd	ra,40(sp)
    80004552:	f022                	sd	s0,32(sp)
    80004554:	ec26                	sd	s1,24(sp)
    80004556:	e84a                	sd	s2,16(sp)
    80004558:	e44e                	sd	s3,8(sp)
    8000455a:	1800                	add	s0,sp,48
    8000455c:	892a                	mv	s2,a0
    8000455e:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80004560:	0001d497          	auipc	s1,0x1d
    80004564:	8c048493          	add	s1,s1,-1856 # 80020e20 <log>
    80004568:	00004597          	auipc	a1,0x4
    8000456c:	18858593          	add	a1,a1,392 # 800086f0 <syscalls+0x268>
    80004570:	8526                	mv	a0,s1
    80004572:	ffffc097          	auipc	ra,0xffffc
    80004576:	5f2080e7          	jalr	1522(ra) # 80000b64 <initlock>
  log.start = sb->logstart;
    8000457a:	0149a583          	lw	a1,20(s3)
    8000457e:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    80004580:	0109a783          	lw	a5,16(s3)
    80004584:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    80004586:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    8000458a:	854a                	mv	a0,s2
    8000458c:	fffff097          	auipc	ra,0xfffff
    80004590:	ea4080e7          	jalr	-348(ra) # 80003430 <bread>
  log.lh.n = lh->n;
    80004594:	4d30                	lw	a2,88(a0)
    80004596:	d4d0                	sw	a2,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    80004598:	00c05f63          	blez	a2,800045b6 <initlog+0x68>
    8000459c:	87aa                	mv	a5,a0
    8000459e:	0001d717          	auipc	a4,0x1d
    800045a2:	8b270713          	add	a4,a4,-1870 # 80020e50 <log+0x30>
    800045a6:	060a                	sll	a2,a2,0x2
    800045a8:	962a                	add	a2,a2,a0
    log.lh.block[i] = lh->block[i];
    800045aa:	4ff4                	lw	a3,92(a5)
    800045ac:	c314                	sw	a3,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    800045ae:	0791                	add	a5,a5,4
    800045b0:	0711                	add	a4,a4,4
    800045b2:	fec79ce3          	bne	a5,a2,800045aa <initlog+0x5c>
  brelse(buf);
    800045b6:	fffff097          	auipc	ra,0xfffff
    800045ba:	faa080e7          	jalr	-86(ra) # 80003560 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    800045be:	4505                	li	a0,1
    800045c0:	00000097          	auipc	ra,0x0
    800045c4:	eca080e7          	jalr	-310(ra) # 8000448a <install_trans>
  log.lh.n = 0;
    800045c8:	0001d797          	auipc	a5,0x1d
    800045cc:	8807a223          	sw	zero,-1916(a5) # 80020e4c <log+0x2c>
  write_head(); // clear the log
    800045d0:	00000097          	auipc	ra,0x0
    800045d4:	e50080e7          	jalr	-432(ra) # 80004420 <write_head>
}
    800045d8:	70a2                	ld	ra,40(sp)
    800045da:	7402                	ld	s0,32(sp)
    800045dc:	64e2                	ld	s1,24(sp)
    800045de:	6942                	ld	s2,16(sp)
    800045e0:	69a2                	ld	s3,8(sp)
    800045e2:	6145                	add	sp,sp,48
    800045e4:	8082                	ret

00000000800045e6 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    800045e6:	1101                	add	sp,sp,-32
    800045e8:	ec06                	sd	ra,24(sp)
    800045ea:	e822                	sd	s0,16(sp)
    800045ec:	e426                	sd	s1,8(sp)
    800045ee:	e04a                	sd	s2,0(sp)
    800045f0:	1000                	add	s0,sp,32
  acquire(&log.lock);
    800045f2:	0001d517          	auipc	a0,0x1d
    800045f6:	82e50513          	add	a0,a0,-2002 # 80020e20 <log>
    800045fa:	ffffc097          	auipc	ra,0xffffc
    800045fe:	5fa080e7          	jalr	1530(ra) # 80000bf4 <acquire>
  while(1){
    if(log.committing){
    80004602:	0001d497          	auipc	s1,0x1d
    80004606:	81e48493          	add	s1,s1,-2018 # 80020e20 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    8000460a:	4979                	li	s2,30
    8000460c:	a039                	j	8000461a <begin_op+0x34>
      sleep(&log, &log.lock);
    8000460e:	85a6                	mv	a1,s1
    80004610:	8526                	mv	a0,s1
    80004612:	ffffe097          	auipc	ra,0xffffe
    80004616:	a86080e7          	jalr	-1402(ra) # 80002098 <sleep>
    if(log.committing){
    8000461a:	50dc                	lw	a5,36(s1)
    8000461c:	fbed                	bnez	a5,8000460e <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    8000461e:	5098                	lw	a4,32(s1)
    80004620:	2705                	addw	a4,a4,1
    80004622:	0027179b          	sllw	a5,a4,0x2
    80004626:	9fb9                	addw	a5,a5,a4
    80004628:	0017979b          	sllw	a5,a5,0x1
    8000462c:	54d4                	lw	a3,44(s1)
    8000462e:	9fb5                	addw	a5,a5,a3
    80004630:	00f95963          	bge	s2,a5,80004642 <begin_op+0x5c>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80004634:	85a6                	mv	a1,s1
    80004636:	8526                	mv	a0,s1
    80004638:	ffffe097          	auipc	ra,0xffffe
    8000463c:	a60080e7          	jalr	-1440(ra) # 80002098 <sleep>
    80004640:	bfe9                	j	8000461a <begin_op+0x34>
    } else {
      log.outstanding += 1;
    80004642:	0001c517          	auipc	a0,0x1c
    80004646:	7de50513          	add	a0,a0,2014 # 80020e20 <log>
    8000464a:	d118                	sw	a4,32(a0)
      release(&log.lock);
    8000464c:	ffffc097          	auipc	ra,0xffffc
    80004650:	65c080e7          	jalr	1628(ra) # 80000ca8 <release>
      break;
    }
  }
}
    80004654:	60e2                	ld	ra,24(sp)
    80004656:	6442                	ld	s0,16(sp)
    80004658:	64a2                	ld	s1,8(sp)
    8000465a:	6902                	ld	s2,0(sp)
    8000465c:	6105                	add	sp,sp,32
    8000465e:	8082                	ret

0000000080004660 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80004660:	7139                	add	sp,sp,-64
    80004662:	fc06                	sd	ra,56(sp)
    80004664:	f822                	sd	s0,48(sp)
    80004666:	f426                	sd	s1,40(sp)
    80004668:	f04a                	sd	s2,32(sp)
    8000466a:	ec4e                	sd	s3,24(sp)
    8000466c:	e852                	sd	s4,16(sp)
    8000466e:	e456                	sd	s5,8(sp)
    80004670:	0080                	add	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80004672:	0001c497          	auipc	s1,0x1c
    80004676:	7ae48493          	add	s1,s1,1966 # 80020e20 <log>
    8000467a:	8526                	mv	a0,s1
    8000467c:	ffffc097          	auipc	ra,0xffffc
    80004680:	578080e7          	jalr	1400(ra) # 80000bf4 <acquire>
  log.outstanding -= 1;
    80004684:	509c                	lw	a5,32(s1)
    80004686:	37fd                	addw	a5,a5,-1
    80004688:	0007891b          	sext.w	s2,a5
    8000468c:	d09c                	sw	a5,32(s1)
  if(log.committing)
    8000468e:	50dc                	lw	a5,36(s1)
    80004690:	e7b9                	bnez	a5,800046de <end_op+0x7e>
    panic("log.committing");
  if(log.outstanding == 0){
    80004692:	04091e63          	bnez	s2,800046ee <end_op+0x8e>
    do_commit = 1;
    log.committing = 1;
    80004696:	0001c497          	auipc	s1,0x1c
    8000469a:	78a48493          	add	s1,s1,1930 # 80020e20 <log>
    8000469e:	4785                	li	a5,1
    800046a0:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    800046a2:	8526                	mv	a0,s1
    800046a4:	ffffc097          	auipc	ra,0xffffc
    800046a8:	604080e7          	jalr	1540(ra) # 80000ca8 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    800046ac:	54dc                	lw	a5,44(s1)
    800046ae:	06f04763          	bgtz	a5,8000471c <end_op+0xbc>
    acquire(&log.lock);
    800046b2:	0001c497          	auipc	s1,0x1c
    800046b6:	76e48493          	add	s1,s1,1902 # 80020e20 <log>
    800046ba:	8526                	mv	a0,s1
    800046bc:	ffffc097          	auipc	ra,0xffffc
    800046c0:	538080e7          	jalr	1336(ra) # 80000bf4 <acquire>
    log.committing = 0;
    800046c4:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    800046c8:	8526                	mv	a0,s1
    800046ca:	ffffe097          	auipc	ra,0xffffe
    800046ce:	a32080e7          	jalr	-1486(ra) # 800020fc <wakeup>
    release(&log.lock);
    800046d2:	8526                	mv	a0,s1
    800046d4:	ffffc097          	auipc	ra,0xffffc
    800046d8:	5d4080e7          	jalr	1492(ra) # 80000ca8 <release>
}
    800046dc:	a03d                	j	8000470a <end_op+0xaa>
    panic("log.committing");
    800046de:	00004517          	auipc	a0,0x4
    800046e2:	01a50513          	add	a0,a0,26 # 800086f8 <syscalls+0x270>
    800046e6:	ffffc097          	auipc	ra,0xffffc
    800046ea:	e56080e7          	jalr	-426(ra) # 8000053c <panic>
    wakeup(&log);
    800046ee:	0001c497          	auipc	s1,0x1c
    800046f2:	73248493          	add	s1,s1,1842 # 80020e20 <log>
    800046f6:	8526                	mv	a0,s1
    800046f8:	ffffe097          	auipc	ra,0xffffe
    800046fc:	a04080e7          	jalr	-1532(ra) # 800020fc <wakeup>
  release(&log.lock);
    80004700:	8526                	mv	a0,s1
    80004702:	ffffc097          	auipc	ra,0xffffc
    80004706:	5a6080e7          	jalr	1446(ra) # 80000ca8 <release>
}
    8000470a:	70e2                	ld	ra,56(sp)
    8000470c:	7442                	ld	s0,48(sp)
    8000470e:	74a2                	ld	s1,40(sp)
    80004710:	7902                	ld	s2,32(sp)
    80004712:	69e2                	ld	s3,24(sp)
    80004714:	6a42                	ld	s4,16(sp)
    80004716:	6aa2                	ld	s5,8(sp)
    80004718:	6121                	add	sp,sp,64
    8000471a:	8082                	ret
  for (tail = 0; tail < log.lh.n; tail++) {
    8000471c:	0001ca97          	auipc	s5,0x1c
    80004720:	734a8a93          	add	s5,s5,1844 # 80020e50 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80004724:	0001ca17          	auipc	s4,0x1c
    80004728:	6fca0a13          	add	s4,s4,1788 # 80020e20 <log>
    8000472c:	018a2583          	lw	a1,24(s4)
    80004730:	012585bb          	addw	a1,a1,s2
    80004734:	2585                	addw	a1,a1,1
    80004736:	028a2503          	lw	a0,40(s4)
    8000473a:	fffff097          	auipc	ra,0xfffff
    8000473e:	cf6080e7          	jalr	-778(ra) # 80003430 <bread>
    80004742:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80004744:	000aa583          	lw	a1,0(s5)
    80004748:	028a2503          	lw	a0,40(s4)
    8000474c:	fffff097          	auipc	ra,0xfffff
    80004750:	ce4080e7          	jalr	-796(ra) # 80003430 <bread>
    80004754:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    80004756:	40000613          	li	a2,1024
    8000475a:	05850593          	add	a1,a0,88
    8000475e:	05848513          	add	a0,s1,88
    80004762:	ffffc097          	auipc	ra,0xffffc
    80004766:	5ea080e7          	jalr	1514(ra) # 80000d4c <memmove>
    bwrite(to);  // write the log
    8000476a:	8526                	mv	a0,s1
    8000476c:	fffff097          	auipc	ra,0xfffff
    80004770:	db6080e7          	jalr	-586(ra) # 80003522 <bwrite>
    brelse(from);
    80004774:	854e                	mv	a0,s3
    80004776:	fffff097          	auipc	ra,0xfffff
    8000477a:	dea080e7          	jalr	-534(ra) # 80003560 <brelse>
    brelse(to);
    8000477e:	8526                	mv	a0,s1
    80004780:	fffff097          	auipc	ra,0xfffff
    80004784:	de0080e7          	jalr	-544(ra) # 80003560 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80004788:	2905                	addw	s2,s2,1
    8000478a:	0a91                	add	s5,s5,4
    8000478c:	02ca2783          	lw	a5,44(s4)
    80004790:	f8f94ee3          	blt	s2,a5,8000472c <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    80004794:	00000097          	auipc	ra,0x0
    80004798:	c8c080e7          	jalr	-884(ra) # 80004420 <write_head>
    install_trans(0); // Now install writes to home locations
    8000479c:	4501                	li	a0,0
    8000479e:	00000097          	auipc	ra,0x0
    800047a2:	cec080e7          	jalr	-788(ra) # 8000448a <install_trans>
    log.lh.n = 0;
    800047a6:	0001c797          	auipc	a5,0x1c
    800047aa:	6a07a323          	sw	zero,1702(a5) # 80020e4c <log+0x2c>
    write_head();    // Erase the transaction from the log
    800047ae:	00000097          	auipc	ra,0x0
    800047b2:	c72080e7          	jalr	-910(ra) # 80004420 <write_head>
    800047b6:	bdf5                	j	800046b2 <end_op+0x52>

00000000800047b8 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    800047b8:	1101                	add	sp,sp,-32
    800047ba:	ec06                	sd	ra,24(sp)
    800047bc:	e822                	sd	s0,16(sp)
    800047be:	e426                	sd	s1,8(sp)
    800047c0:	e04a                	sd	s2,0(sp)
    800047c2:	1000                	add	s0,sp,32
    800047c4:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    800047c6:	0001c917          	auipc	s2,0x1c
    800047ca:	65a90913          	add	s2,s2,1626 # 80020e20 <log>
    800047ce:	854a                	mv	a0,s2
    800047d0:	ffffc097          	auipc	ra,0xffffc
    800047d4:	424080e7          	jalr	1060(ra) # 80000bf4 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    800047d8:	02c92603          	lw	a2,44(s2)
    800047dc:	47f5                	li	a5,29
    800047de:	06c7c563          	blt	a5,a2,80004848 <log_write+0x90>
    800047e2:	0001c797          	auipc	a5,0x1c
    800047e6:	65a7a783          	lw	a5,1626(a5) # 80020e3c <log+0x1c>
    800047ea:	37fd                	addw	a5,a5,-1
    800047ec:	04f65e63          	bge	a2,a5,80004848 <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    800047f0:	0001c797          	auipc	a5,0x1c
    800047f4:	6507a783          	lw	a5,1616(a5) # 80020e40 <log+0x20>
    800047f8:	06f05063          	blez	a5,80004858 <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    800047fc:	4781                	li	a5,0
    800047fe:	06c05563          	blez	a2,80004868 <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80004802:	44cc                	lw	a1,12(s1)
    80004804:	0001c717          	auipc	a4,0x1c
    80004808:	64c70713          	add	a4,a4,1612 # 80020e50 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    8000480c:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    8000480e:	4314                	lw	a3,0(a4)
    80004810:	04b68c63          	beq	a3,a1,80004868 <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    80004814:	2785                	addw	a5,a5,1
    80004816:	0711                	add	a4,a4,4
    80004818:	fef61be3          	bne	a2,a5,8000480e <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    8000481c:	0621                	add	a2,a2,8
    8000481e:	060a                	sll	a2,a2,0x2
    80004820:	0001c797          	auipc	a5,0x1c
    80004824:	60078793          	add	a5,a5,1536 # 80020e20 <log>
    80004828:	97b2                	add	a5,a5,a2
    8000482a:	44d8                	lw	a4,12(s1)
    8000482c:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    8000482e:	8526                	mv	a0,s1
    80004830:	fffff097          	auipc	ra,0xfffff
    80004834:	dcc080e7          	jalr	-564(ra) # 800035fc <bpin>
    log.lh.n++;
    80004838:	0001c717          	auipc	a4,0x1c
    8000483c:	5e870713          	add	a4,a4,1512 # 80020e20 <log>
    80004840:	575c                	lw	a5,44(a4)
    80004842:	2785                	addw	a5,a5,1
    80004844:	d75c                	sw	a5,44(a4)
    80004846:	a82d                	j	80004880 <log_write+0xc8>
    panic("too big a transaction");
    80004848:	00004517          	auipc	a0,0x4
    8000484c:	ec050513          	add	a0,a0,-320 # 80008708 <syscalls+0x280>
    80004850:	ffffc097          	auipc	ra,0xffffc
    80004854:	cec080e7          	jalr	-788(ra) # 8000053c <panic>
    panic("log_write outside of trans");
    80004858:	00004517          	auipc	a0,0x4
    8000485c:	ec850513          	add	a0,a0,-312 # 80008720 <syscalls+0x298>
    80004860:	ffffc097          	auipc	ra,0xffffc
    80004864:	cdc080e7          	jalr	-804(ra) # 8000053c <panic>
  log.lh.block[i] = b->blockno;
    80004868:	00878693          	add	a3,a5,8
    8000486c:	068a                	sll	a3,a3,0x2
    8000486e:	0001c717          	auipc	a4,0x1c
    80004872:	5b270713          	add	a4,a4,1458 # 80020e20 <log>
    80004876:	9736                	add	a4,a4,a3
    80004878:	44d4                	lw	a3,12(s1)
    8000487a:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    8000487c:	faf609e3          	beq	a2,a5,8000482e <log_write+0x76>
  }
  release(&log.lock);
    80004880:	0001c517          	auipc	a0,0x1c
    80004884:	5a050513          	add	a0,a0,1440 # 80020e20 <log>
    80004888:	ffffc097          	auipc	ra,0xffffc
    8000488c:	420080e7          	jalr	1056(ra) # 80000ca8 <release>
}
    80004890:	60e2                	ld	ra,24(sp)
    80004892:	6442                	ld	s0,16(sp)
    80004894:	64a2                	ld	s1,8(sp)
    80004896:	6902                	ld	s2,0(sp)
    80004898:	6105                	add	sp,sp,32
    8000489a:	8082                	ret

000000008000489c <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    8000489c:	1101                	add	sp,sp,-32
    8000489e:	ec06                	sd	ra,24(sp)
    800048a0:	e822                	sd	s0,16(sp)
    800048a2:	e426                	sd	s1,8(sp)
    800048a4:	e04a                	sd	s2,0(sp)
    800048a6:	1000                	add	s0,sp,32
    800048a8:	84aa                	mv	s1,a0
    800048aa:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    800048ac:	00004597          	auipc	a1,0x4
    800048b0:	e9458593          	add	a1,a1,-364 # 80008740 <syscalls+0x2b8>
    800048b4:	0521                	add	a0,a0,8
    800048b6:	ffffc097          	auipc	ra,0xffffc
    800048ba:	2ae080e7          	jalr	686(ra) # 80000b64 <initlock>
  lk->name = name;
    800048be:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    800048c2:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800048c6:	0204a423          	sw	zero,40(s1)
}
    800048ca:	60e2                	ld	ra,24(sp)
    800048cc:	6442                	ld	s0,16(sp)
    800048ce:	64a2                	ld	s1,8(sp)
    800048d0:	6902                	ld	s2,0(sp)
    800048d2:	6105                	add	sp,sp,32
    800048d4:	8082                	ret

00000000800048d6 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    800048d6:	1101                	add	sp,sp,-32
    800048d8:	ec06                	sd	ra,24(sp)
    800048da:	e822                	sd	s0,16(sp)
    800048dc:	e426                	sd	s1,8(sp)
    800048de:	e04a                	sd	s2,0(sp)
    800048e0:	1000                	add	s0,sp,32
    800048e2:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800048e4:	00850913          	add	s2,a0,8
    800048e8:	854a                	mv	a0,s2
    800048ea:	ffffc097          	auipc	ra,0xffffc
    800048ee:	30a080e7          	jalr	778(ra) # 80000bf4 <acquire>
  while (lk->locked) {
    800048f2:	409c                	lw	a5,0(s1)
    800048f4:	cb89                	beqz	a5,80004906 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    800048f6:	85ca                	mv	a1,s2
    800048f8:	8526                	mv	a0,s1
    800048fa:	ffffd097          	auipc	ra,0xffffd
    800048fe:	79e080e7          	jalr	1950(ra) # 80002098 <sleep>
  while (lk->locked) {
    80004902:	409c                	lw	a5,0(s1)
    80004904:	fbed                	bnez	a5,800048f6 <acquiresleep+0x20>
  }
  lk->locked = 1;
    80004906:	4785                	li	a5,1
    80004908:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    8000490a:	ffffd097          	auipc	ra,0xffffd
    8000490e:	0be080e7          	jalr	190(ra) # 800019c8 <myproc>
    80004912:	591c                	lw	a5,48(a0)
    80004914:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    80004916:	854a                	mv	a0,s2
    80004918:	ffffc097          	auipc	ra,0xffffc
    8000491c:	390080e7          	jalr	912(ra) # 80000ca8 <release>
}
    80004920:	60e2                	ld	ra,24(sp)
    80004922:	6442                	ld	s0,16(sp)
    80004924:	64a2                	ld	s1,8(sp)
    80004926:	6902                	ld	s2,0(sp)
    80004928:	6105                	add	sp,sp,32
    8000492a:	8082                	ret

000000008000492c <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    8000492c:	1101                	add	sp,sp,-32
    8000492e:	ec06                	sd	ra,24(sp)
    80004930:	e822                	sd	s0,16(sp)
    80004932:	e426                	sd	s1,8(sp)
    80004934:	e04a                	sd	s2,0(sp)
    80004936:	1000                	add	s0,sp,32
    80004938:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    8000493a:	00850913          	add	s2,a0,8
    8000493e:	854a                	mv	a0,s2
    80004940:	ffffc097          	auipc	ra,0xffffc
    80004944:	2b4080e7          	jalr	692(ra) # 80000bf4 <acquire>
  lk->locked = 0;
    80004948:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    8000494c:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80004950:	8526                	mv	a0,s1
    80004952:	ffffd097          	auipc	ra,0xffffd
    80004956:	7aa080e7          	jalr	1962(ra) # 800020fc <wakeup>
  release(&lk->lk);
    8000495a:	854a                	mv	a0,s2
    8000495c:	ffffc097          	auipc	ra,0xffffc
    80004960:	34c080e7          	jalr	844(ra) # 80000ca8 <release>
}
    80004964:	60e2                	ld	ra,24(sp)
    80004966:	6442                	ld	s0,16(sp)
    80004968:	64a2                	ld	s1,8(sp)
    8000496a:	6902                	ld	s2,0(sp)
    8000496c:	6105                	add	sp,sp,32
    8000496e:	8082                	ret

0000000080004970 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80004970:	7179                	add	sp,sp,-48
    80004972:	f406                	sd	ra,40(sp)
    80004974:	f022                	sd	s0,32(sp)
    80004976:	ec26                	sd	s1,24(sp)
    80004978:	e84a                	sd	s2,16(sp)
    8000497a:	e44e                	sd	s3,8(sp)
    8000497c:	1800                	add	s0,sp,48
    8000497e:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80004980:	00850913          	add	s2,a0,8
    80004984:	854a                	mv	a0,s2
    80004986:	ffffc097          	auipc	ra,0xffffc
    8000498a:	26e080e7          	jalr	622(ra) # 80000bf4 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    8000498e:	409c                	lw	a5,0(s1)
    80004990:	ef99                	bnez	a5,800049ae <holdingsleep+0x3e>
    80004992:	4481                	li	s1,0
  release(&lk->lk);
    80004994:	854a                	mv	a0,s2
    80004996:	ffffc097          	auipc	ra,0xffffc
    8000499a:	312080e7          	jalr	786(ra) # 80000ca8 <release>
  return r;
}
    8000499e:	8526                	mv	a0,s1
    800049a0:	70a2                	ld	ra,40(sp)
    800049a2:	7402                	ld	s0,32(sp)
    800049a4:	64e2                	ld	s1,24(sp)
    800049a6:	6942                	ld	s2,16(sp)
    800049a8:	69a2                	ld	s3,8(sp)
    800049aa:	6145                	add	sp,sp,48
    800049ac:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    800049ae:	0284a983          	lw	s3,40(s1)
    800049b2:	ffffd097          	auipc	ra,0xffffd
    800049b6:	016080e7          	jalr	22(ra) # 800019c8 <myproc>
    800049ba:	5904                	lw	s1,48(a0)
    800049bc:	413484b3          	sub	s1,s1,s3
    800049c0:	0014b493          	seqz	s1,s1
    800049c4:	bfc1                	j	80004994 <holdingsleep+0x24>

00000000800049c6 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    800049c6:	1141                	add	sp,sp,-16
    800049c8:	e406                	sd	ra,8(sp)
    800049ca:	e022                	sd	s0,0(sp)
    800049cc:	0800                	add	s0,sp,16
  initlock(&ftable.lock, "ftable");
    800049ce:	00004597          	auipc	a1,0x4
    800049d2:	d8258593          	add	a1,a1,-638 # 80008750 <syscalls+0x2c8>
    800049d6:	0001c517          	auipc	a0,0x1c
    800049da:	59250513          	add	a0,a0,1426 # 80020f68 <ftable>
    800049de:	ffffc097          	auipc	ra,0xffffc
    800049e2:	186080e7          	jalr	390(ra) # 80000b64 <initlock>
}
    800049e6:	60a2                	ld	ra,8(sp)
    800049e8:	6402                	ld	s0,0(sp)
    800049ea:	0141                	add	sp,sp,16
    800049ec:	8082                	ret

00000000800049ee <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    800049ee:	1101                	add	sp,sp,-32
    800049f0:	ec06                	sd	ra,24(sp)
    800049f2:	e822                	sd	s0,16(sp)
    800049f4:	e426                	sd	s1,8(sp)
    800049f6:	1000                	add	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    800049f8:	0001c517          	auipc	a0,0x1c
    800049fc:	57050513          	add	a0,a0,1392 # 80020f68 <ftable>
    80004a00:	ffffc097          	auipc	ra,0xffffc
    80004a04:	1f4080e7          	jalr	500(ra) # 80000bf4 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80004a08:	0001c497          	auipc	s1,0x1c
    80004a0c:	57848493          	add	s1,s1,1400 # 80020f80 <ftable+0x18>
    80004a10:	0001d717          	auipc	a4,0x1d
    80004a14:	51070713          	add	a4,a4,1296 # 80021f20 <disk>
    if(f->ref == 0){
    80004a18:	40dc                	lw	a5,4(s1)
    80004a1a:	cf99                	beqz	a5,80004a38 <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80004a1c:	02848493          	add	s1,s1,40
    80004a20:	fee49ce3          	bne	s1,a4,80004a18 <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80004a24:	0001c517          	auipc	a0,0x1c
    80004a28:	54450513          	add	a0,a0,1348 # 80020f68 <ftable>
    80004a2c:	ffffc097          	auipc	ra,0xffffc
    80004a30:	27c080e7          	jalr	636(ra) # 80000ca8 <release>
  return 0;
    80004a34:	4481                	li	s1,0
    80004a36:	a819                	j	80004a4c <filealloc+0x5e>
      f->ref = 1;
    80004a38:	4785                	li	a5,1
    80004a3a:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80004a3c:	0001c517          	auipc	a0,0x1c
    80004a40:	52c50513          	add	a0,a0,1324 # 80020f68 <ftable>
    80004a44:	ffffc097          	auipc	ra,0xffffc
    80004a48:	264080e7          	jalr	612(ra) # 80000ca8 <release>
}
    80004a4c:	8526                	mv	a0,s1
    80004a4e:	60e2                	ld	ra,24(sp)
    80004a50:	6442                	ld	s0,16(sp)
    80004a52:	64a2                	ld	s1,8(sp)
    80004a54:	6105                	add	sp,sp,32
    80004a56:	8082                	ret

0000000080004a58 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80004a58:	1101                	add	sp,sp,-32
    80004a5a:	ec06                	sd	ra,24(sp)
    80004a5c:	e822                	sd	s0,16(sp)
    80004a5e:	e426                	sd	s1,8(sp)
    80004a60:	1000                	add	s0,sp,32
    80004a62:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80004a64:	0001c517          	auipc	a0,0x1c
    80004a68:	50450513          	add	a0,a0,1284 # 80020f68 <ftable>
    80004a6c:	ffffc097          	auipc	ra,0xffffc
    80004a70:	188080e7          	jalr	392(ra) # 80000bf4 <acquire>
  if(f->ref < 1)
    80004a74:	40dc                	lw	a5,4(s1)
    80004a76:	02f05263          	blez	a5,80004a9a <filedup+0x42>
    panic("filedup");
  f->ref++;
    80004a7a:	2785                	addw	a5,a5,1
    80004a7c:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80004a7e:	0001c517          	auipc	a0,0x1c
    80004a82:	4ea50513          	add	a0,a0,1258 # 80020f68 <ftable>
    80004a86:	ffffc097          	auipc	ra,0xffffc
    80004a8a:	222080e7          	jalr	546(ra) # 80000ca8 <release>
  return f;
}
    80004a8e:	8526                	mv	a0,s1
    80004a90:	60e2                	ld	ra,24(sp)
    80004a92:	6442                	ld	s0,16(sp)
    80004a94:	64a2                	ld	s1,8(sp)
    80004a96:	6105                	add	sp,sp,32
    80004a98:	8082                	ret
    panic("filedup");
    80004a9a:	00004517          	auipc	a0,0x4
    80004a9e:	cbe50513          	add	a0,a0,-834 # 80008758 <syscalls+0x2d0>
    80004aa2:	ffffc097          	auipc	ra,0xffffc
    80004aa6:	a9a080e7          	jalr	-1382(ra) # 8000053c <panic>

0000000080004aaa <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80004aaa:	7139                	add	sp,sp,-64
    80004aac:	fc06                	sd	ra,56(sp)
    80004aae:	f822                	sd	s0,48(sp)
    80004ab0:	f426                	sd	s1,40(sp)
    80004ab2:	f04a                	sd	s2,32(sp)
    80004ab4:	ec4e                	sd	s3,24(sp)
    80004ab6:	e852                	sd	s4,16(sp)
    80004ab8:	e456                	sd	s5,8(sp)
    80004aba:	0080                	add	s0,sp,64
    80004abc:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80004abe:	0001c517          	auipc	a0,0x1c
    80004ac2:	4aa50513          	add	a0,a0,1194 # 80020f68 <ftable>
    80004ac6:	ffffc097          	auipc	ra,0xffffc
    80004aca:	12e080e7          	jalr	302(ra) # 80000bf4 <acquire>
  if(f->ref < 1)
    80004ace:	40dc                	lw	a5,4(s1)
    80004ad0:	06f05163          	blez	a5,80004b32 <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    80004ad4:	37fd                	addw	a5,a5,-1
    80004ad6:	0007871b          	sext.w	a4,a5
    80004ada:	c0dc                	sw	a5,4(s1)
    80004adc:	06e04363          	bgtz	a4,80004b42 <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80004ae0:	0004a903          	lw	s2,0(s1)
    80004ae4:	0094ca83          	lbu	s5,9(s1)
    80004ae8:	0104ba03          	ld	s4,16(s1)
    80004aec:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80004af0:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80004af4:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80004af8:	0001c517          	auipc	a0,0x1c
    80004afc:	47050513          	add	a0,a0,1136 # 80020f68 <ftable>
    80004b00:	ffffc097          	auipc	ra,0xffffc
    80004b04:	1a8080e7          	jalr	424(ra) # 80000ca8 <release>

  if(ff.type == FD_PIPE){
    80004b08:	4785                	li	a5,1
    80004b0a:	04f90d63          	beq	s2,a5,80004b64 <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80004b0e:	3979                	addw	s2,s2,-2
    80004b10:	4785                	li	a5,1
    80004b12:	0527e063          	bltu	a5,s2,80004b52 <fileclose+0xa8>
    begin_op();
    80004b16:	00000097          	auipc	ra,0x0
    80004b1a:	ad0080e7          	jalr	-1328(ra) # 800045e6 <begin_op>
    iput(ff.ip);
    80004b1e:	854e                	mv	a0,s3
    80004b20:	fffff097          	auipc	ra,0xfffff
    80004b24:	2da080e7          	jalr	730(ra) # 80003dfa <iput>
    end_op();
    80004b28:	00000097          	auipc	ra,0x0
    80004b2c:	b38080e7          	jalr	-1224(ra) # 80004660 <end_op>
    80004b30:	a00d                	j	80004b52 <fileclose+0xa8>
    panic("fileclose");
    80004b32:	00004517          	auipc	a0,0x4
    80004b36:	c2e50513          	add	a0,a0,-978 # 80008760 <syscalls+0x2d8>
    80004b3a:	ffffc097          	auipc	ra,0xffffc
    80004b3e:	a02080e7          	jalr	-1534(ra) # 8000053c <panic>
    release(&ftable.lock);
    80004b42:	0001c517          	auipc	a0,0x1c
    80004b46:	42650513          	add	a0,a0,1062 # 80020f68 <ftable>
    80004b4a:	ffffc097          	auipc	ra,0xffffc
    80004b4e:	15e080e7          	jalr	350(ra) # 80000ca8 <release>
  }
}
    80004b52:	70e2                	ld	ra,56(sp)
    80004b54:	7442                	ld	s0,48(sp)
    80004b56:	74a2                	ld	s1,40(sp)
    80004b58:	7902                	ld	s2,32(sp)
    80004b5a:	69e2                	ld	s3,24(sp)
    80004b5c:	6a42                	ld	s4,16(sp)
    80004b5e:	6aa2                	ld	s5,8(sp)
    80004b60:	6121                	add	sp,sp,64
    80004b62:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80004b64:	85d6                	mv	a1,s5
    80004b66:	8552                	mv	a0,s4
    80004b68:	00000097          	auipc	ra,0x0
    80004b6c:	348080e7          	jalr	840(ra) # 80004eb0 <pipeclose>
    80004b70:	b7cd                	j	80004b52 <fileclose+0xa8>

0000000080004b72 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80004b72:	715d                	add	sp,sp,-80
    80004b74:	e486                	sd	ra,72(sp)
    80004b76:	e0a2                	sd	s0,64(sp)
    80004b78:	fc26                	sd	s1,56(sp)
    80004b7a:	f84a                	sd	s2,48(sp)
    80004b7c:	f44e                	sd	s3,40(sp)
    80004b7e:	0880                	add	s0,sp,80
    80004b80:	84aa                	mv	s1,a0
    80004b82:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80004b84:	ffffd097          	auipc	ra,0xffffd
    80004b88:	e44080e7          	jalr	-444(ra) # 800019c8 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80004b8c:	409c                	lw	a5,0(s1)
    80004b8e:	37f9                	addw	a5,a5,-2
    80004b90:	4705                	li	a4,1
    80004b92:	04f76763          	bltu	a4,a5,80004be0 <filestat+0x6e>
    80004b96:	892a                	mv	s2,a0
    ilock(f->ip);
    80004b98:	6c88                	ld	a0,24(s1)
    80004b9a:	fffff097          	auipc	ra,0xfffff
    80004b9e:	0a6080e7          	jalr	166(ra) # 80003c40 <ilock>
    stati(f->ip, &st);
    80004ba2:	fb840593          	add	a1,s0,-72
    80004ba6:	6c88                	ld	a0,24(s1)
    80004ba8:	fffff097          	auipc	ra,0xfffff
    80004bac:	322080e7          	jalr	802(ra) # 80003eca <stati>
    iunlock(f->ip);
    80004bb0:	6c88                	ld	a0,24(s1)
    80004bb2:	fffff097          	auipc	ra,0xfffff
    80004bb6:	150080e7          	jalr	336(ra) # 80003d02 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80004bba:	46e1                	li	a3,24
    80004bbc:	fb840613          	add	a2,s0,-72
    80004bc0:	85ce                	mv	a1,s3
    80004bc2:	05093503          	ld	a0,80(s2)
    80004bc6:	ffffd097          	auipc	ra,0xffffd
    80004bca:	ac2080e7          	jalr	-1342(ra) # 80001688 <copyout>
    80004bce:	41f5551b          	sraw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80004bd2:	60a6                	ld	ra,72(sp)
    80004bd4:	6406                	ld	s0,64(sp)
    80004bd6:	74e2                	ld	s1,56(sp)
    80004bd8:	7942                	ld	s2,48(sp)
    80004bda:	79a2                	ld	s3,40(sp)
    80004bdc:	6161                	add	sp,sp,80
    80004bde:	8082                	ret
  return -1;
    80004be0:	557d                	li	a0,-1
    80004be2:	bfc5                	j	80004bd2 <filestat+0x60>

0000000080004be4 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80004be4:	7179                	add	sp,sp,-48
    80004be6:	f406                	sd	ra,40(sp)
    80004be8:	f022                	sd	s0,32(sp)
    80004bea:	ec26                	sd	s1,24(sp)
    80004bec:	e84a                	sd	s2,16(sp)
    80004bee:	e44e                	sd	s3,8(sp)
    80004bf0:	1800                	add	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80004bf2:	00854783          	lbu	a5,8(a0)
    80004bf6:	c3d5                	beqz	a5,80004c9a <fileread+0xb6>
    80004bf8:	84aa                	mv	s1,a0
    80004bfa:	89ae                	mv	s3,a1
    80004bfc:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80004bfe:	411c                	lw	a5,0(a0)
    80004c00:	4705                	li	a4,1
    80004c02:	04e78963          	beq	a5,a4,80004c54 <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80004c06:	470d                	li	a4,3
    80004c08:	04e78d63          	beq	a5,a4,80004c62 <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80004c0c:	4709                	li	a4,2
    80004c0e:	06e79e63          	bne	a5,a4,80004c8a <fileread+0xa6>
    ilock(f->ip);
    80004c12:	6d08                	ld	a0,24(a0)
    80004c14:	fffff097          	auipc	ra,0xfffff
    80004c18:	02c080e7          	jalr	44(ra) # 80003c40 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80004c1c:	874a                	mv	a4,s2
    80004c1e:	5094                	lw	a3,32(s1)
    80004c20:	864e                	mv	a2,s3
    80004c22:	4585                	li	a1,1
    80004c24:	6c88                	ld	a0,24(s1)
    80004c26:	fffff097          	auipc	ra,0xfffff
    80004c2a:	2ce080e7          	jalr	718(ra) # 80003ef4 <readi>
    80004c2e:	892a                	mv	s2,a0
    80004c30:	00a05563          	blez	a0,80004c3a <fileread+0x56>
      f->off += r;
    80004c34:	509c                	lw	a5,32(s1)
    80004c36:	9fa9                	addw	a5,a5,a0
    80004c38:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80004c3a:	6c88                	ld	a0,24(s1)
    80004c3c:	fffff097          	auipc	ra,0xfffff
    80004c40:	0c6080e7          	jalr	198(ra) # 80003d02 <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    80004c44:	854a                	mv	a0,s2
    80004c46:	70a2                	ld	ra,40(sp)
    80004c48:	7402                	ld	s0,32(sp)
    80004c4a:	64e2                	ld	s1,24(sp)
    80004c4c:	6942                	ld	s2,16(sp)
    80004c4e:	69a2                	ld	s3,8(sp)
    80004c50:	6145                	add	sp,sp,48
    80004c52:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80004c54:	6908                	ld	a0,16(a0)
    80004c56:	00000097          	auipc	ra,0x0
    80004c5a:	3c2080e7          	jalr	962(ra) # 80005018 <piperead>
    80004c5e:	892a                	mv	s2,a0
    80004c60:	b7d5                	j	80004c44 <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80004c62:	02451783          	lh	a5,36(a0)
    80004c66:	03079693          	sll	a3,a5,0x30
    80004c6a:	92c1                	srl	a3,a3,0x30
    80004c6c:	4725                	li	a4,9
    80004c6e:	02d76863          	bltu	a4,a3,80004c9e <fileread+0xba>
    80004c72:	0792                	sll	a5,a5,0x4
    80004c74:	0001c717          	auipc	a4,0x1c
    80004c78:	25470713          	add	a4,a4,596 # 80020ec8 <devsw>
    80004c7c:	97ba                	add	a5,a5,a4
    80004c7e:	639c                	ld	a5,0(a5)
    80004c80:	c38d                	beqz	a5,80004ca2 <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    80004c82:	4505                	li	a0,1
    80004c84:	9782                	jalr	a5
    80004c86:	892a                	mv	s2,a0
    80004c88:	bf75                	j	80004c44 <fileread+0x60>
    panic("fileread");
    80004c8a:	00004517          	auipc	a0,0x4
    80004c8e:	ae650513          	add	a0,a0,-1306 # 80008770 <syscalls+0x2e8>
    80004c92:	ffffc097          	auipc	ra,0xffffc
    80004c96:	8aa080e7          	jalr	-1878(ra) # 8000053c <panic>
    return -1;
    80004c9a:	597d                	li	s2,-1
    80004c9c:	b765                	j	80004c44 <fileread+0x60>
      return -1;
    80004c9e:	597d                	li	s2,-1
    80004ca0:	b755                	j	80004c44 <fileread+0x60>
    80004ca2:	597d                	li	s2,-1
    80004ca4:	b745                	j	80004c44 <fileread+0x60>

0000000080004ca6 <filewrite>:
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if(f->writable == 0)
    80004ca6:	00954783          	lbu	a5,9(a0)
    80004caa:	10078e63          	beqz	a5,80004dc6 <filewrite+0x120>
{
    80004cae:	715d                	add	sp,sp,-80
    80004cb0:	e486                	sd	ra,72(sp)
    80004cb2:	e0a2                	sd	s0,64(sp)
    80004cb4:	fc26                	sd	s1,56(sp)
    80004cb6:	f84a                	sd	s2,48(sp)
    80004cb8:	f44e                	sd	s3,40(sp)
    80004cba:	f052                	sd	s4,32(sp)
    80004cbc:	ec56                	sd	s5,24(sp)
    80004cbe:	e85a                	sd	s6,16(sp)
    80004cc0:	e45e                	sd	s7,8(sp)
    80004cc2:	e062                	sd	s8,0(sp)
    80004cc4:	0880                	add	s0,sp,80
    80004cc6:	892a                	mv	s2,a0
    80004cc8:	8b2e                	mv	s6,a1
    80004cca:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    80004ccc:	411c                	lw	a5,0(a0)
    80004cce:	4705                	li	a4,1
    80004cd0:	02e78263          	beq	a5,a4,80004cf4 <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80004cd4:	470d                	li	a4,3
    80004cd6:	02e78563          	beq	a5,a4,80004d00 <filewrite+0x5a>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80004cda:	4709                	li	a4,2
    80004cdc:	0ce79d63          	bne	a5,a4,80004db6 <filewrite+0x110>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80004ce0:	0ac05b63          	blez	a2,80004d96 <filewrite+0xf0>
    int i = 0;
    80004ce4:	4981                	li	s3,0
      int n1 = n - i;
      if(n1 > max)
    80004ce6:	6b85                	lui	s7,0x1
    80004ce8:	c00b8b93          	add	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    80004cec:	6c05                	lui	s8,0x1
    80004cee:	c00c0c1b          	addw	s8,s8,-1024 # c00 <_entry-0x7ffff400>
    80004cf2:	a851                	j	80004d86 <filewrite+0xe0>
    ret = pipewrite(f->pipe, addr, n);
    80004cf4:	6908                	ld	a0,16(a0)
    80004cf6:	00000097          	auipc	ra,0x0
    80004cfa:	22a080e7          	jalr	554(ra) # 80004f20 <pipewrite>
    80004cfe:	a045                	j	80004d9e <filewrite+0xf8>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80004d00:	02451783          	lh	a5,36(a0)
    80004d04:	03079693          	sll	a3,a5,0x30
    80004d08:	92c1                	srl	a3,a3,0x30
    80004d0a:	4725                	li	a4,9
    80004d0c:	0ad76f63          	bltu	a4,a3,80004dca <filewrite+0x124>
    80004d10:	0792                	sll	a5,a5,0x4
    80004d12:	0001c717          	auipc	a4,0x1c
    80004d16:	1b670713          	add	a4,a4,438 # 80020ec8 <devsw>
    80004d1a:	97ba                	add	a5,a5,a4
    80004d1c:	679c                	ld	a5,8(a5)
    80004d1e:	cbc5                	beqz	a5,80004dce <filewrite+0x128>
    ret = devsw[f->major].write(1, addr, n);
    80004d20:	4505                	li	a0,1
    80004d22:	9782                	jalr	a5
    80004d24:	a8ad                	j	80004d9e <filewrite+0xf8>
      if(n1 > max)
    80004d26:	00048a9b          	sext.w	s5,s1
        n1 = max;

      begin_op();
    80004d2a:	00000097          	auipc	ra,0x0
    80004d2e:	8bc080e7          	jalr	-1860(ra) # 800045e6 <begin_op>
      ilock(f->ip);
    80004d32:	01893503          	ld	a0,24(s2)
    80004d36:	fffff097          	auipc	ra,0xfffff
    80004d3a:	f0a080e7          	jalr	-246(ra) # 80003c40 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80004d3e:	8756                	mv	a4,s5
    80004d40:	02092683          	lw	a3,32(s2)
    80004d44:	01698633          	add	a2,s3,s6
    80004d48:	4585                	li	a1,1
    80004d4a:	01893503          	ld	a0,24(s2)
    80004d4e:	fffff097          	auipc	ra,0xfffff
    80004d52:	29e080e7          	jalr	670(ra) # 80003fec <writei>
    80004d56:	84aa                	mv	s1,a0
    80004d58:	00a05763          	blez	a0,80004d66 <filewrite+0xc0>
        f->off += r;
    80004d5c:	02092783          	lw	a5,32(s2)
    80004d60:	9fa9                	addw	a5,a5,a0
    80004d62:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80004d66:	01893503          	ld	a0,24(s2)
    80004d6a:	fffff097          	auipc	ra,0xfffff
    80004d6e:	f98080e7          	jalr	-104(ra) # 80003d02 <iunlock>
      end_op();
    80004d72:	00000097          	auipc	ra,0x0
    80004d76:	8ee080e7          	jalr	-1810(ra) # 80004660 <end_op>

      if(r != n1){
    80004d7a:	009a9f63          	bne	s5,s1,80004d98 <filewrite+0xf2>
        // error from writei
        break;
      }
      i += r;
    80004d7e:	013489bb          	addw	s3,s1,s3
    while(i < n){
    80004d82:	0149db63          	bge	s3,s4,80004d98 <filewrite+0xf2>
      int n1 = n - i;
    80004d86:	413a04bb          	subw	s1,s4,s3
      if(n1 > max)
    80004d8a:	0004879b          	sext.w	a5,s1
    80004d8e:	f8fbdce3          	bge	s7,a5,80004d26 <filewrite+0x80>
    80004d92:	84e2                	mv	s1,s8
    80004d94:	bf49                	j	80004d26 <filewrite+0x80>
    int i = 0;
    80004d96:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    80004d98:	033a1d63          	bne	s4,s3,80004dd2 <filewrite+0x12c>
    80004d9c:	8552                	mv	a0,s4
  } else {
    panic("filewrite");
  }

  return ret;
}
    80004d9e:	60a6                	ld	ra,72(sp)
    80004da0:	6406                	ld	s0,64(sp)
    80004da2:	74e2                	ld	s1,56(sp)
    80004da4:	7942                	ld	s2,48(sp)
    80004da6:	79a2                	ld	s3,40(sp)
    80004da8:	7a02                	ld	s4,32(sp)
    80004daa:	6ae2                	ld	s5,24(sp)
    80004dac:	6b42                	ld	s6,16(sp)
    80004dae:	6ba2                	ld	s7,8(sp)
    80004db0:	6c02                	ld	s8,0(sp)
    80004db2:	6161                	add	sp,sp,80
    80004db4:	8082                	ret
    panic("filewrite");
    80004db6:	00004517          	auipc	a0,0x4
    80004dba:	9ca50513          	add	a0,a0,-1590 # 80008780 <syscalls+0x2f8>
    80004dbe:	ffffb097          	auipc	ra,0xffffb
    80004dc2:	77e080e7          	jalr	1918(ra) # 8000053c <panic>
    return -1;
    80004dc6:	557d                	li	a0,-1
}
    80004dc8:	8082                	ret
      return -1;
    80004dca:	557d                	li	a0,-1
    80004dcc:	bfc9                	j	80004d9e <filewrite+0xf8>
    80004dce:	557d                	li	a0,-1
    80004dd0:	b7f9                	j	80004d9e <filewrite+0xf8>
    ret = (i == n ? n : -1);
    80004dd2:	557d                	li	a0,-1
    80004dd4:	b7e9                	j	80004d9e <filewrite+0xf8>

0000000080004dd6 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80004dd6:	7179                	add	sp,sp,-48
    80004dd8:	f406                	sd	ra,40(sp)
    80004dda:	f022                	sd	s0,32(sp)
    80004ddc:	ec26                	sd	s1,24(sp)
    80004dde:	e84a                	sd	s2,16(sp)
    80004de0:	e44e                	sd	s3,8(sp)
    80004de2:	e052                	sd	s4,0(sp)
    80004de4:	1800                	add	s0,sp,48
    80004de6:	84aa                	mv	s1,a0
    80004de8:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80004dea:	0005b023          	sd	zero,0(a1)
    80004dee:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80004df2:	00000097          	auipc	ra,0x0
    80004df6:	bfc080e7          	jalr	-1028(ra) # 800049ee <filealloc>
    80004dfa:	e088                	sd	a0,0(s1)
    80004dfc:	c551                	beqz	a0,80004e88 <pipealloc+0xb2>
    80004dfe:	00000097          	auipc	ra,0x0
    80004e02:	bf0080e7          	jalr	-1040(ra) # 800049ee <filealloc>
    80004e06:	00aa3023          	sd	a0,0(s4)
    80004e0a:	c92d                	beqz	a0,80004e7c <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80004e0c:	ffffc097          	auipc	ra,0xffffc
    80004e10:	cd6080e7          	jalr	-810(ra) # 80000ae2 <kalloc>
    80004e14:	892a                	mv	s2,a0
    80004e16:	c125                	beqz	a0,80004e76 <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80004e18:	4985                	li	s3,1
    80004e1a:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80004e1e:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80004e22:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80004e26:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80004e2a:	00004597          	auipc	a1,0x4
    80004e2e:	96658593          	add	a1,a1,-1690 # 80008790 <syscalls+0x308>
    80004e32:	ffffc097          	auipc	ra,0xffffc
    80004e36:	d32080e7          	jalr	-718(ra) # 80000b64 <initlock>
  (*f0)->type = FD_PIPE;
    80004e3a:	609c                	ld	a5,0(s1)
    80004e3c:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80004e40:	609c                	ld	a5,0(s1)
    80004e42:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80004e46:	609c                	ld	a5,0(s1)
    80004e48:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80004e4c:	609c                	ld	a5,0(s1)
    80004e4e:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80004e52:	000a3783          	ld	a5,0(s4)
    80004e56:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80004e5a:	000a3783          	ld	a5,0(s4)
    80004e5e:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80004e62:	000a3783          	ld	a5,0(s4)
    80004e66:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80004e6a:	000a3783          	ld	a5,0(s4)
    80004e6e:	0127b823          	sd	s2,16(a5)
  return 0;
    80004e72:	4501                	li	a0,0
    80004e74:	a025                	j	80004e9c <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80004e76:	6088                	ld	a0,0(s1)
    80004e78:	e501                	bnez	a0,80004e80 <pipealloc+0xaa>
    80004e7a:	a039                	j	80004e88 <pipealloc+0xb2>
    80004e7c:	6088                	ld	a0,0(s1)
    80004e7e:	c51d                	beqz	a0,80004eac <pipealloc+0xd6>
    fileclose(*f0);
    80004e80:	00000097          	auipc	ra,0x0
    80004e84:	c2a080e7          	jalr	-982(ra) # 80004aaa <fileclose>
  if(*f1)
    80004e88:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80004e8c:	557d                	li	a0,-1
  if(*f1)
    80004e8e:	c799                	beqz	a5,80004e9c <pipealloc+0xc6>
    fileclose(*f1);
    80004e90:	853e                	mv	a0,a5
    80004e92:	00000097          	auipc	ra,0x0
    80004e96:	c18080e7          	jalr	-1000(ra) # 80004aaa <fileclose>
  return -1;
    80004e9a:	557d                	li	a0,-1
}
    80004e9c:	70a2                	ld	ra,40(sp)
    80004e9e:	7402                	ld	s0,32(sp)
    80004ea0:	64e2                	ld	s1,24(sp)
    80004ea2:	6942                	ld	s2,16(sp)
    80004ea4:	69a2                	ld	s3,8(sp)
    80004ea6:	6a02                	ld	s4,0(sp)
    80004ea8:	6145                	add	sp,sp,48
    80004eaa:	8082                	ret
  return -1;
    80004eac:	557d                	li	a0,-1
    80004eae:	b7fd                	j	80004e9c <pipealloc+0xc6>

0000000080004eb0 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80004eb0:	1101                	add	sp,sp,-32
    80004eb2:	ec06                	sd	ra,24(sp)
    80004eb4:	e822                	sd	s0,16(sp)
    80004eb6:	e426                	sd	s1,8(sp)
    80004eb8:	e04a                	sd	s2,0(sp)
    80004eba:	1000                	add	s0,sp,32
    80004ebc:	84aa                	mv	s1,a0
    80004ebe:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80004ec0:	ffffc097          	auipc	ra,0xffffc
    80004ec4:	d34080e7          	jalr	-716(ra) # 80000bf4 <acquire>
  if(writable){
    80004ec8:	02090d63          	beqz	s2,80004f02 <pipeclose+0x52>
    pi->writeopen = 0;
    80004ecc:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80004ed0:	21848513          	add	a0,s1,536
    80004ed4:	ffffd097          	auipc	ra,0xffffd
    80004ed8:	228080e7          	jalr	552(ra) # 800020fc <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80004edc:	2204b783          	ld	a5,544(s1)
    80004ee0:	eb95                	bnez	a5,80004f14 <pipeclose+0x64>
    release(&pi->lock);
    80004ee2:	8526                	mv	a0,s1
    80004ee4:	ffffc097          	auipc	ra,0xffffc
    80004ee8:	dc4080e7          	jalr	-572(ra) # 80000ca8 <release>
    kfree((char*)pi);
    80004eec:	8526                	mv	a0,s1
    80004eee:	ffffc097          	auipc	ra,0xffffc
    80004ef2:	af6080e7          	jalr	-1290(ra) # 800009e4 <kfree>
  } else
    release(&pi->lock);
}
    80004ef6:	60e2                	ld	ra,24(sp)
    80004ef8:	6442                	ld	s0,16(sp)
    80004efa:	64a2                	ld	s1,8(sp)
    80004efc:	6902                	ld	s2,0(sp)
    80004efe:	6105                	add	sp,sp,32
    80004f00:	8082                	ret
    pi->readopen = 0;
    80004f02:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80004f06:	21c48513          	add	a0,s1,540
    80004f0a:	ffffd097          	auipc	ra,0xffffd
    80004f0e:	1f2080e7          	jalr	498(ra) # 800020fc <wakeup>
    80004f12:	b7e9                	j	80004edc <pipeclose+0x2c>
    release(&pi->lock);
    80004f14:	8526                	mv	a0,s1
    80004f16:	ffffc097          	auipc	ra,0xffffc
    80004f1a:	d92080e7          	jalr	-622(ra) # 80000ca8 <release>
}
    80004f1e:	bfe1                	j	80004ef6 <pipeclose+0x46>

0000000080004f20 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80004f20:	711d                	add	sp,sp,-96
    80004f22:	ec86                	sd	ra,88(sp)
    80004f24:	e8a2                	sd	s0,80(sp)
    80004f26:	e4a6                	sd	s1,72(sp)
    80004f28:	e0ca                	sd	s2,64(sp)
    80004f2a:	fc4e                	sd	s3,56(sp)
    80004f2c:	f852                	sd	s4,48(sp)
    80004f2e:	f456                	sd	s5,40(sp)
    80004f30:	f05a                	sd	s6,32(sp)
    80004f32:	ec5e                	sd	s7,24(sp)
    80004f34:	e862                	sd	s8,16(sp)
    80004f36:	1080                	add	s0,sp,96
    80004f38:	84aa                	mv	s1,a0
    80004f3a:	8aae                	mv	s5,a1
    80004f3c:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80004f3e:	ffffd097          	auipc	ra,0xffffd
    80004f42:	a8a080e7          	jalr	-1398(ra) # 800019c8 <myproc>
    80004f46:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80004f48:	8526                	mv	a0,s1
    80004f4a:	ffffc097          	auipc	ra,0xffffc
    80004f4e:	caa080e7          	jalr	-854(ra) # 80000bf4 <acquire>
  while(i < n){
    80004f52:	0b405663          	blez	s4,80004ffe <pipewrite+0xde>
  int i = 0;
    80004f56:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004f58:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80004f5a:	21848c13          	add	s8,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80004f5e:	21c48b93          	add	s7,s1,540
    80004f62:	a089                	j	80004fa4 <pipewrite+0x84>
      release(&pi->lock);
    80004f64:	8526                	mv	a0,s1
    80004f66:	ffffc097          	auipc	ra,0xffffc
    80004f6a:	d42080e7          	jalr	-702(ra) # 80000ca8 <release>
      return -1;
    80004f6e:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80004f70:	854a                	mv	a0,s2
    80004f72:	60e6                	ld	ra,88(sp)
    80004f74:	6446                	ld	s0,80(sp)
    80004f76:	64a6                	ld	s1,72(sp)
    80004f78:	6906                	ld	s2,64(sp)
    80004f7a:	79e2                	ld	s3,56(sp)
    80004f7c:	7a42                	ld	s4,48(sp)
    80004f7e:	7aa2                	ld	s5,40(sp)
    80004f80:	7b02                	ld	s6,32(sp)
    80004f82:	6be2                	ld	s7,24(sp)
    80004f84:	6c42                	ld	s8,16(sp)
    80004f86:	6125                	add	sp,sp,96
    80004f88:	8082                	ret
      wakeup(&pi->nread);
    80004f8a:	8562                	mv	a0,s8
    80004f8c:	ffffd097          	auipc	ra,0xffffd
    80004f90:	170080e7          	jalr	368(ra) # 800020fc <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80004f94:	85a6                	mv	a1,s1
    80004f96:	855e                	mv	a0,s7
    80004f98:	ffffd097          	auipc	ra,0xffffd
    80004f9c:	100080e7          	jalr	256(ra) # 80002098 <sleep>
  while(i < n){
    80004fa0:	07495063          	bge	s2,s4,80005000 <pipewrite+0xe0>
    if(pi->readopen == 0 || killed(pr)){
    80004fa4:	2204a783          	lw	a5,544(s1)
    80004fa8:	dfd5                	beqz	a5,80004f64 <pipewrite+0x44>
    80004faa:	854e                	mv	a0,s3
    80004fac:	ffffd097          	auipc	ra,0xffffd
    80004fb0:	394080e7          	jalr	916(ra) # 80002340 <killed>
    80004fb4:	f945                	bnez	a0,80004f64 <pipewrite+0x44>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80004fb6:	2184a783          	lw	a5,536(s1)
    80004fba:	21c4a703          	lw	a4,540(s1)
    80004fbe:	2007879b          	addw	a5,a5,512
    80004fc2:	fcf704e3          	beq	a4,a5,80004f8a <pipewrite+0x6a>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004fc6:	4685                	li	a3,1
    80004fc8:	01590633          	add	a2,s2,s5
    80004fcc:	faf40593          	add	a1,s0,-81
    80004fd0:	0509b503          	ld	a0,80(s3)
    80004fd4:	ffffc097          	auipc	ra,0xffffc
    80004fd8:	740080e7          	jalr	1856(ra) # 80001714 <copyin>
    80004fdc:	03650263          	beq	a0,s6,80005000 <pipewrite+0xe0>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80004fe0:	21c4a783          	lw	a5,540(s1)
    80004fe4:	0017871b          	addw	a4,a5,1
    80004fe8:	20e4ae23          	sw	a4,540(s1)
    80004fec:	1ff7f793          	and	a5,a5,511
    80004ff0:	97a6                	add	a5,a5,s1
    80004ff2:	faf44703          	lbu	a4,-81(s0)
    80004ff6:	00e78c23          	sb	a4,24(a5)
      i++;
    80004ffa:	2905                	addw	s2,s2,1
    80004ffc:	b755                	j	80004fa0 <pipewrite+0x80>
  int i = 0;
    80004ffe:	4901                	li	s2,0
  wakeup(&pi->nread);
    80005000:	21848513          	add	a0,s1,536
    80005004:	ffffd097          	auipc	ra,0xffffd
    80005008:	0f8080e7          	jalr	248(ra) # 800020fc <wakeup>
  release(&pi->lock);
    8000500c:	8526                	mv	a0,s1
    8000500e:	ffffc097          	auipc	ra,0xffffc
    80005012:	c9a080e7          	jalr	-870(ra) # 80000ca8 <release>
  return i;
    80005016:	bfa9                	j	80004f70 <pipewrite+0x50>

0000000080005018 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80005018:	715d                	add	sp,sp,-80
    8000501a:	e486                	sd	ra,72(sp)
    8000501c:	e0a2                	sd	s0,64(sp)
    8000501e:	fc26                	sd	s1,56(sp)
    80005020:	f84a                	sd	s2,48(sp)
    80005022:	f44e                	sd	s3,40(sp)
    80005024:	f052                	sd	s4,32(sp)
    80005026:	ec56                	sd	s5,24(sp)
    80005028:	e85a                	sd	s6,16(sp)
    8000502a:	0880                	add	s0,sp,80
    8000502c:	84aa                	mv	s1,a0
    8000502e:	892e                	mv	s2,a1
    80005030:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80005032:	ffffd097          	auipc	ra,0xffffd
    80005036:	996080e7          	jalr	-1642(ra) # 800019c8 <myproc>
    8000503a:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    8000503c:	8526                	mv	a0,s1
    8000503e:	ffffc097          	auipc	ra,0xffffc
    80005042:	bb6080e7          	jalr	-1098(ra) # 80000bf4 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80005046:	2184a703          	lw	a4,536(s1)
    8000504a:	21c4a783          	lw	a5,540(s1)
    if(killed(pr)){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    8000504e:	21848993          	add	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80005052:	02f71763          	bne	a4,a5,80005080 <piperead+0x68>
    80005056:	2244a783          	lw	a5,548(s1)
    8000505a:	c39d                	beqz	a5,80005080 <piperead+0x68>
    if(killed(pr)){
    8000505c:	8552                	mv	a0,s4
    8000505e:	ffffd097          	auipc	ra,0xffffd
    80005062:	2e2080e7          	jalr	738(ra) # 80002340 <killed>
    80005066:	e949                	bnez	a0,800050f8 <piperead+0xe0>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80005068:	85a6                	mv	a1,s1
    8000506a:	854e                	mv	a0,s3
    8000506c:	ffffd097          	auipc	ra,0xffffd
    80005070:	02c080e7          	jalr	44(ra) # 80002098 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80005074:	2184a703          	lw	a4,536(s1)
    80005078:	21c4a783          	lw	a5,540(s1)
    8000507c:	fcf70de3          	beq	a4,a5,80005056 <piperead+0x3e>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80005080:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80005082:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80005084:	05505463          	blez	s5,800050cc <piperead+0xb4>
    if(pi->nread == pi->nwrite)
    80005088:	2184a783          	lw	a5,536(s1)
    8000508c:	21c4a703          	lw	a4,540(s1)
    80005090:	02f70e63          	beq	a4,a5,800050cc <piperead+0xb4>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80005094:	0017871b          	addw	a4,a5,1
    80005098:	20e4ac23          	sw	a4,536(s1)
    8000509c:	1ff7f793          	and	a5,a5,511
    800050a0:	97a6                	add	a5,a5,s1
    800050a2:	0187c783          	lbu	a5,24(a5)
    800050a6:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800050aa:	4685                	li	a3,1
    800050ac:	fbf40613          	add	a2,s0,-65
    800050b0:	85ca                	mv	a1,s2
    800050b2:	050a3503          	ld	a0,80(s4)
    800050b6:	ffffc097          	auipc	ra,0xffffc
    800050ba:	5d2080e7          	jalr	1490(ra) # 80001688 <copyout>
    800050be:	01650763          	beq	a0,s6,800050cc <piperead+0xb4>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800050c2:	2985                	addw	s3,s3,1
    800050c4:	0905                	add	s2,s2,1
    800050c6:	fd3a91e3          	bne	s5,s3,80005088 <piperead+0x70>
    800050ca:	89d6                	mv	s3,s5
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    800050cc:	21c48513          	add	a0,s1,540
    800050d0:	ffffd097          	auipc	ra,0xffffd
    800050d4:	02c080e7          	jalr	44(ra) # 800020fc <wakeup>
  release(&pi->lock);
    800050d8:	8526                	mv	a0,s1
    800050da:	ffffc097          	auipc	ra,0xffffc
    800050de:	bce080e7          	jalr	-1074(ra) # 80000ca8 <release>
  return i;
}
    800050e2:	854e                	mv	a0,s3
    800050e4:	60a6                	ld	ra,72(sp)
    800050e6:	6406                	ld	s0,64(sp)
    800050e8:	74e2                	ld	s1,56(sp)
    800050ea:	7942                	ld	s2,48(sp)
    800050ec:	79a2                	ld	s3,40(sp)
    800050ee:	7a02                	ld	s4,32(sp)
    800050f0:	6ae2                	ld	s5,24(sp)
    800050f2:	6b42                	ld	s6,16(sp)
    800050f4:	6161                	add	sp,sp,80
    800050f6:	8082                	ret
      release(&pi->lock);
    800050f8:	8526                	mv	a0,s1
    800050fa:	ffffc097          	auipc	ra,0xffffc
    800050fe:	bae080e7          	jalr	-1106(ra) # 80000ca8 <release>
      return -1;
    80005102:	59fd                	li	s3,-1
    80005104:	bff9                	j	800050e2 <piperead+0xca>

0000000080005106 <flags2perm>:
#include "elf.h"

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

int flags2perm(int flags)
{
    80005106:	1141                	add	sp,sp,-16
    80005108:	e422                	sd	s0,8(sp)
    8000510a:	0800                	add	s0,sp,16
    8000510c:	87aa                	mv	a5,a0
    int perm = 0;
    if(flags & 0x1)
    8000510e:	8905                	and	a0,a0,1
    80005110:	050e                	sll	a0,a0,0x3
      perm = PTE_X;
    if(flags & 0x2)
    80005112:	8b89                	and	a5,a5,2
    80005114:	c399                	beqz	a5,8000511a <flags2perm+0x14>
      perm |= PTE_W;
    80005116:	00456513          	or	a0,a0,4
    return perm;
}
    8000511a:	6422                	ld	s0,8(sp)
    8000511c:	0141                	add	sp,sp,16
    8000511e:	8082                	ret

0000000080005120 <exec>:

int
exec(char *path, char **argv)
{
    80005120:	df010113          	add	sp,sp,-528
    80005124:	20113423          	sd	ra,520(sp)
    80005128:	20813023          	sd	s0,512(sp)
    8000512c:	ffa6                	sd	s1,504(sp)
    8000512e:	fbca                	sd	s2,496(sp)
    80005130:	f7ce                	sd	s3,488(sp)
    80005132:	f3d2                	sd	s4,480(sp)
    80005134:	efd6                	sd	s5,472(sp)
    80005136:	ebda                	sd	s6,464(sp)
    80005138:	e7de                	sd	s7,456(sp)
    8000513a:	e3e2                	sd	s8,448(sp)
    8000513c:	ff66                	sd	s9,440(sp)
    8000513e:	fb6a                	sd	s10,432(sp)
    80005140:	f76e                	sd	s11,424(sp)
    80005142:	0c00                	add	s0,sp,528
    80005144:	892a                	mv	s2,a0
    80005146:	dea43c23          	sd	a0,-520(s0)
    8000514a:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    8000514e:	ffffd097          	auipc	ra,0xffffd
    80005152:	87a080e7          	jalr	-1926(ra) # 800019c8 <myproc>
    80005156:	84aa                	mv	s1,a0

  begin_op();
    80005158:	fffff097          	auipc	ra,0xfffff
    8000515c:	48e080e7          	jalr	1166(ra) # 800045e6 <begin_op>

  if((ip = namei(path)) == 0){
    80005160:	854a                	mv	a0,s2
    80005162:	fffff097          	auipc	ra,0xfffff
    80005166:	284080e7          	jalr	644(ra) # 800043e6 <namei>
    8000516a:	c92d                	beqz	a0,800051dc <exec+0xbc>
    8000516c:	8a2a                	mv	s4,a0
    end_op();
    return -1;
  }
  ilock(ip);
    8000516e:	fffff097          	auipc	ra,0xfffff
    80005172:	ad2080e7          	jalr	-1326(ra) # 80003c40 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80005176:	04000713          	li	a4,64
    8000517a:	4681                	li	a3,0
    8000517c:	e5040613          	add	a2,s0,-432
    80005180:	4581                	li	a1,0
    80005182:	8552                	mv	a0,s4
    80005184:	fffff097          	auipc	ra,0xfffff
    80005188:	d70080e7          	jalr	-656(ra) # 80003ef4 <readi>
    8000518c:	04000793          	li	a5,64
    80005190:	00f51a63          	bne	a0,a5,800051a4 <exec+0x84>
    goto bad;

  if(elf.magic != ELF_MAGIC)
    80005194:	e5042703          	lw	a4,-432(s0)
    80005198:	464c47b7          	lui	a5,0x464c4
    8000519c:	57f78793          	add	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    800051a0:	04f70463          	beq	a4,a5,800051e8 <exec+0xc8>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    800051a4:	8552                	mv	a0,s4
    800051a6:	fffff097          	auipc	ra,0xfffff
    800051aa:	cfc080e7          	jalr	-772(ra) # 80003ea2 <iunlockput>
    end_op();
    800051ae:	fffff097          	auipc	ra,0xfffff
    800051b2:	4b2080e7          	jalr	1202(ra) # 80004660 <end_op>
  }
  return -1;
    800051b6:	557d                	li	a0,-1
}
    800051b8:	20813083          	ld	ra,520(sp)
    800051bc:	20013403          	ld	s0,512(sp)
    800051c0:	74fe                	ld	s1,504(sp)
    800051c2:	795e                	ld	s2,496(sp)
    800051c4:	79be                	ld	s3,488(sp)
    800051c6:	7a1e                	ld	s4,480(sp)
    800051c8:	6afe                	ld	s5,472(sp)
    800051ca:	6b5e                	ld	s6,464(sp)
    800051cc:	6bbe                	ld	s7,456(sp)
    800051ce:	6c1e                	ld	s8,448(sp)
    800051d0:	7cfa                	ld	s9,440(sp)
    800051d2:	7d5a                	ld	s10,432(sp)
    800051d4:	7dba                	ld	s11,424(sp)
    800051d6:	21010113          	add	sp,sp,528
    800051da:	8082                	ret
    end_op();
    800051dc:	fffff097          	auipc	ra,0xfffff
    800051e0:	484080e7          	jalr	1156(ra) # 80004660 <end_op>
    return -1;
    800051e4:	557d                	li	a0,-1
    800051e6:	bfc9                	j	800051b8 <exec+0x98>
  if((pagetable = proc_pagetable(p)) == 0)
    800051e8:	8526                	mv	a0,s1
    800051ea:	ffffd097          	auipc	ra,0xffffd
    800051ee:	8a2080e7          	jalr	-1886(ra) # 80001a8c <proc_pagetable>
    800051f2:	8b2a                	mv	s6,a0
    800051f4:	d945                	beqz	a0,800051a4 <exec+0x84>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800051f6:	e7042d03          	lw	s10,-400(s0)
    800051fa:	e8845783          	lhu	a5,-376(s0)
    800051fe:	10078463          	beqz	a5,80005306 <exec+0x1e6>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80005202:	4901                	li	s2,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80005204:	4d81                	li	s11,0
    if(ph.vaddr % PGSIZE != 0)
    80005206:	6c85                	lui	s9,0x1
    80005208:	fffc8793          	add	a5,s9,-1 # fff <_entry-0x7ffff001>
    8000520c:	def43823          	sd	a5,-528(s0)

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    if(sz - i < PGSIZE)
    80005210:	6a85                	lui	s5,0x1
    80005212:	a0b5                	j	8000527e <exec+0x15e>
      panic("loadseg: address should exist");
    80005214:	00003517          	auipc	a0,0x3
    80005218:	58450513          	add	a0,a0,1412 # 80008798 <syscalls+0x310>
    8000521c:	ffffb097          	auipc	ra,0xffffb
    80005220:	320080e7          	jalr	800(ra) # 8000053c <panic>
    if(sz - i < PGSIZE)
    80005224:	2481                	sext.w	s1,s1
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80005226:	8726                	mv	a4,s1
    80005228:	012c06bb          	addw	a3,s8,s2
    8000522c:	4581                	li	a1,0
    8000522e:	8552                	mv	a0,s4
    80005230:	fffff097          	auipc	ra,0xfffff
    80005234:	cc4080e7          	jalr	-828(ra) # 80003ef4 <readi>
    80005238:	2501                	sext.w	a0,a0
    8000523a:	24a49863          	bne	s1,a0,8000548a <exec+0x36a>
  for(i = 0; i < sz; i += PGSIZE){
    8000523e:	012a893b          	addw	s2,s5,s2
    80005242:	03397563          	bgeu	s2,s3,8000526c <exec+0x14c>
    pa = walkaddr(pagetable, va + i);
    80005246:	02091593          	sll	a1,s2,0x20
    8000524a:	9181                	srl	a1,a1,0x20
    8000524c:	95de                	add	a1,a1,s7
    8000524e:	855a                	mv	a0,s6
    80005250:	ffffc097          	auipc	ra,0xffffc
    80005254:	e28080e7          	jalr	-472(ra) # 80001078 <walkaddr>
    80005258:	862a                	mv	a2,a0
    if(pa == 0)
    8000525a:	dd4d                	beqz	a0,80005214 <exec+0xf4>
    if(sz - i < PGSIZE)
    8000525c:	412984bb          	subw	s1,s3,s2
    80005260:	0004879b          	sext.w	a5,s1
    80005264:	fcfcf0e3          	bgeu	s9,a5,80005224 <exec+0x104>
    80005268:	84d6                	mv	s1,s5
    8000526a:	bf6d                	j	80005224 <exec+0x104>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    8000526c:	e0843903          	ld	s2,-504(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80005270:	2d85                	addw	s11,s11,1
    80005272:	038d0d1b          	addw	s10,s10,56
    80005276:	e8845783          	lhu	a5,-376(s0)
    8000527a:	08fdd763          	bge	s11,a5,80005308 <exec+0x1e8>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    8000527e:	2d01                	sext.w	s10,s10
    80005280:	03800713          	li	a4,56
    80005284:	86ea                	mv	a3,s10
    80005286:	e1840613          	add	a2,s0,-488
    8000528a:	4581                	li	a1,0
    8000528c:	8552                	mv	a0,s4
    8000528e:	fffff097          	auipc	ra,0xfffff
    80005292:	c66080e7          	jalr	-922(ra) # 80003ef4 <readi>
    80005296:	03800793          	li	a5,56
    8000529a:	1ef51663          	bne	a0,a5,80005486 <exec+0x366>
    if(ph.type != ELF_PROG_LOAD)
    8000529e:	e1842783          	lw	a5,-488(s0)
    800052a2:	4705                	li	a4,1
    800052a4:	fce796e3          	bne	a5,a4,80005270 <exec+0x150>
    if(ph.memsz < ph.filesz)
    800052a8:	e4043483          	ld	s1,-448(s0)
    800052ac:	e3843783          	ld	a5,-456(s0)
    800052b0:	1ef4e863          	bltu	s1,a5,800054a0 <exec+0x380>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    800052b4:	e2843783          	ld	a5,-472(s0)
    800052b8:	94be                	add	s1,s1,a5
    800052ba:	1ef4e663          	bltu	s1,a5,800054a6 <exec+0x386>
    if(ph.vaddr % PGSIZE != 0)
    800052be:	df043703          	ld	a4,-528(s0)
    800052c2:	8ff9                	and	a5,a5,a4
    800052c4:	1e079463          	bnez	a5,800054ac <exec+0x38c>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    800052c8:	e1c42503          	lw	a0,-484(s0)
    800052cc:	00000097          	auipc	ra,0x0
    800052d0:	e3a080e7          	jalr	-454(ra) # 80005106 <flags2perm>
    800052d4:	86aa                	mv	a3,a0
    800052d6:	8626                	mv	a2,s1
    800052d8:	85ca                	mv	a1,s2
    800052da:	855a                	mv	a0,s6
    800052dc:	ffffc097          	auipc	ra,0xffffc
    800052e0:	150080e7          	jalr	336(ra) # 8000142c <uvmalloc>
    800052e4:	e0a43423          	sd	a0,-504(s0)
    800052e8:	1c050563          	beqz	a0,800054b2 <exec+0x392>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    800052ec:	e2843b83          	ld	s7,-472(s0)
    800052f0:	e2042c03          	lw	s8,-480(s0)
    800052f4:	e3842983          	lw	s3,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    800052f8:	00098463          	beqz	s3,80005300 <exec+0x1e0>
    800052fc:	4901                	li	s2,0
    800052fe:	b7a1                	j	80005246 <exec+0x126>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80005300:	e0843903          	ld	s2,-504(s0)
    80005304:	b7b5                	j	80005270 <exec+0x150>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80005306:	4901                	li	s2,0
  iunlockput(ip);
    80005308:	8552                	mv	a0,s4
    8000530a:	fffff097          	auipc	ra,0xfffff
    8000530e:	b98080e7          	jalr	-1128(ra) # 80003ea2 <iunlockput>
  end_op();
    80005312:	fffff097          	auipc	ra,0xfffff
    80005316:	34e080e7          	jalr	846(ra) # 80004660 <end_op>
  p = myproc();
    8000531a:	ffffc097          	auipc	ra,0xffffc
    8000531e:	6ae080e7          	jalr	1710(ra) # 800019c8 <myproc>
    80005322:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    80005324:	04853c83          	ld	s9,72(a0)
  sz = PGROUNDUP(sz);
    80005328:	6985                	lui	s3,0x1
    8000532a:	19fd                	add	s3,s3,-1 # fff <_entry-0x7ffff001>
    8000532c:	99ca                	add	s3,s3,s2
    8000532e:	77fd                	lui	a5,0xfffff
    80005330:	00f9f9b3          	and	s3,s3,a5
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
    80005334:	4691                	li	a3,4
    80005336:	6609                	lui	a2,0x2
    80005338:	964e                	add	a2,a2,s3
    8000533a:	85ce                	mv	a1,s3
    8000533c:	855a                	mv	a0,s6
    8000533e:	ffffc097          	auipc	ra,0xffffc
    80005342:	0ee080e7          	jalr	238(ra) # 8000142c <uvmalloc>
    80005346:	892a                	mv	s2,a0
    80005348:	e0a43423          	sd	a0,-504(s0)
    8000534c:	e509                	bnez	a0,80005356 <exec+0x236>
  if(pagetable)
    8000534e:	e1343423          	sd	s3,-504(s0)
    80005352:	4a01                	li	s4,0
    80005354:	aa1d                	j	8000548a <exec+0x36a>
  uvmclear(pagetable, sz-2*PGSIZE);
    80005356:	75f9                	lui	a1,0xffffe
    80005358:	95aa                	add	a1,a1,a0
    8000535a:	855a                	mv	a0,s6
    8000535c:	ffffc097          	auipc	ra,0xffffc
    80005360:	2fa080e7          	jalr	762(ra) # 80001656 <uvmclear>
  stackbase = sp - PGSIZE;
    80005364:	7bfd                	lui	s7,0xfffff
    80005366:	9bca                	add	s7,s7,s2
  for(argc = 0; argv[argc]; argc++) {
    80005368:	e0043783          	ld	a5,-512(s0)
    8000536c:	6388                	ld	a0,0(a5)
    8000536e:	c52d                	beqz	a0,800053d8 <exec+0x2b8>
    80005370:	e9040993          	add	s3,s0,-368
    80005374:	f9040c13          	add	s8,s0,-112
    80005378:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    8000537a:	ffffc097          	auipc	ra,0xffffc
    8000537e:	af0080e7          	jalr	-1296(ra) # 80000e6a <strlen>
    80005382:	0015079b          	addw	a5,a0,1
    80005386:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    8000538a:	ff07f913          	and	s2,a5,-16
    if(sp < stackbase)
    8000538e:	13796563          	bltu	s2,s7,800054b8 <exec+0x398>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80005392:	e0043d03          	ld	s10,-512(s0)
    80005396:	000d3a03          	ld	s4,0(s10)
    8000539a:	8552                	mv	a0,s4
    8000539c:	ffffc097          	auipc	ra,0xffffc
    800053a0:	ace080e7          	jalr	-1330(ra) # 80000e6a <strlen>
    800053a4:	0015069b          	addw	a3,a0,1
    800053a8:	8652                	mv	a2,s4
    800053aa:	85ca                	mv	a1,s2
    800053ac:	855a                	mv	a0,s6
    800053ae:	ffffc097          	auipc	ra,0xffffc
    800053b2:	2da080e7          	jalr	730(ra) # 80001688 <copyout>
    800053b6:	10054363          	bltz	a0,800054bc <exec+0x39c>
    ustack[argc] = sp;
    800053ba:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    800053be:	0485                	add	s1,s1,1
    800053c0:	008d0793          	add	a5,s10,8
    800053c4:	e0f43023          	sd	a5,-512(s0)
    800053c8:	008d3503          	ld	a0,8(s10)
    800053cc:	c909                	beqz	a0,800053de <exec+0x2be>
    if(argc >= MAXARG)
    800053ce:	09a1                	add	s3,s3,8
    800053d0:	fb8995e3          	bne	s3,s8,8000537a <exec+0x25a>
  ip = 0;
    800053d4:	4a01                	li	s4,0
    800053d6:	a855                	j	8000548a <exec+0x36a>
  sp = sz;
    800053d8:	e0843903          	ld	s2,-504(s0)
  for(argc = 0; argv[argc]; argc++) {
    800053dc:	4481                	li	s1,0
  ustack[argc] = 0;
    800053de:	00349793          	sll	a5,s1,0x3
    800053e2:	f9078793          	add	a5,a5,-112 # ffffffffffffef90 <end+0xffffffff7ffdcf18>
    800053e6:	97a2                	add	a5,a5,s0
    800053e8:	f007b023          	sd	zero,-256(a5)
  sp -= (argc+1) * sizeof(uint64);
    800053ec:	00148693          	add	a3,s1,1
    800053f0:	068e                	sll	a3,a3,0x3
    800053f2:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    800053f6:	ff097913          	and	s2,s2,-16
  sz = sz1;
    800053fa:	e0843983          	ld	s3,-504(s0)
  if(sp < stackbase)
    800053fe:	f57968e3          	bltu	s2,s7,8000534e <exec+0x22e>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80005402:	e9040613          	add	a2,s0,-368
    80005406:	85ca                	mv	a1,s2
    80005408:	855a                	mv	a0,s6
    8000540a:	ffffc097          	auipc	ra,0xffffc
    8000540e:	27e080e7          	jalr	638(ra) # 80001688 <copyout>
    80005412:	0a054763          	bltz	a0,800054c0 <exec+0x3a0>
  p->trapframe->a1 = sp;
    80005416:	058ab783          	ld	a5,88(s5) # 1058 <_entry-0x7fffefa8>
    8000541a:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    8000541e:	df843783          	ld	a5,-520(s0)
    80005422:	0007c703          	lbu	a4,0(a5)
    80005426:	cf11                	beqz	a4,80005442 <exec+0x322>
    80005428:	0785                	add	a5,a5,1
    if(*s == '/')
    8000542a:	02f00693          	li	a3,47
    8000542e:	a039                	j	8000543c <exec+0x31c>
      last = s+1;
    80005430:	def43c23          	sd	a5,-520(s0)
  for(last=s=path; *s; s++)
    80005434:	0785                	add	a5,a5,1
    80005436:	fff7c703          	lbu	a4,-1(a5)
    8000543a:	c701                	beqz	a4,80005442 <exec+0x322>
    if(*s == '/')
    8000543c:	fed71ce3          	bne	a4,a3,80005434 <exec+0x314>
    80005440:	bfc5                	j	80005430 <exec+0x310>
  safestrcpy(p->name, last, sizeof(p->name));
    80005442:	4641                	li	a2,16
    80005444:	df843583          	ld	a1,-520(s0)
    80005448:	158a8513          	add	a0,s5,344
    8000544c:	ffffc097          	auipc	ra,0xffffc
    80005450:	9ec080e7          	jalr	-1556(ra) # 80000e38 <safestrcpy>
  oldpagetable = p->pagetable;
    80005454:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    80005458:	056ab823          	sd	s6,80(s5)
  p->sz = sz;
    8000545c:	e0843783          	ld	a5,-504(s0)
    80005460:	04fab423          	sd	a5,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80005464:	058ab783          	ld	a5,88(s5)
    80005468:	e6843703          	ld	a4,-408(s0)
    8000546c:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    8000546e:	058ab783          	ld	a5,88(s5)
    80005472:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80005476:	85e6                	mv	a1,s9
    80005478:	ffffc097          	auipc	ra,0xffffc
    8000547c:	6b0080e7          	jalr	1712(ra) # 80001b28 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80005480:	0004851b          	sext.w	a0,s1
    80005484:	bb15                	j	800051b8 <exec+0x98>
    80005486:	e1243423          	sd	s2,-504(s0)
    proc_freepagetable(pagetable, sz);
    8000548a:	e0843583          	ld	a1,-504(s0)
    8000548e:	855a                	mv	a0,s6
    80005490:	ffffc097          	auipc	ra,0xffffc
    80005494:	698080e7          	jalr	1688(ra) # 80001b28 <proc_freepagetable>
  return -1;
    80005498:	557d                	li	a0,-1
  if(ip){
    8000549a:	d00a0fe3          	beqz	s4,800051b8 <exec+0x98>
    8000549e:	b319                	j	800051a4 <exec+0x84>
    800054a0:	e1243423          	sd	s2,-504(s0)
    800054a4:	b7dd                	j	8000548a <exec+0x36a>
    800054a6:	e1243423          	sd	s2,-504(s0)
    800054aa:	b7c5                	j	8000548a <exec+0x36a>
    800054ac:	e1243423          	sd	s2,-504(s0)
    800054b0:	bfe9                	j	8000548a <exec+0x36a>
    800054b2:	e1243423          	sd	s2,-504(s0)
    800054b6:	bfd1                	j	8000548a <exec+0x36a>
  ip = 0;
    800054b8:	4a01                	li	s4,0
    800054ba:	bfc1                	j	8000548a <exec+0x36a>
    800054bc:	4a01                	li	s4,0
  if(pagetable)
    800054be:	b7f1                	j	8000548a <exec+0x36a>
  sz = sz1;
    800054c0:	e0843983          	ld	s3,-504(s0)
    800054c4:	b569                	j	8000534e <exec+0x22e>

00000000800054c6 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    800054c6:	7179                	add	sp,sp,-48
    800054c8:	f406                	sd	ra,40(sp)
    800054ca:	f022                	sd	s0,32(sp)
    800054cc:	ec26                	sd	s1,24(sp)
    800054ce:	e84a                	sd	s2,16(sp)
    800054d0:	1800                	add	s0,sp,48
    800054d2:	892e                	mv	s2,a1
    800054d4:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    800054d6:	fdc40593          	add	a1,s0,-36
    800054da:	ffffe097          	auipc	ra,0xffffe
    800054de:	994080e7          	jalr	-1644(ra) # 80002e6e <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    800054e2:	fdc42703          	lw	a4,-36(s0)
    800054e6:	47bd                	li	a5,15
    800054e8:	02e7eb63          	bltu	a5,a4,8000551e <argfd+0x58>
    800054ec:	ffffc097          	auipc	ra,0xffffc
    800054f0:	4dc080e7          	jalr	1244(ra) # 800019c8 <myproc>
    800054f4:	fdc42703          	lw	a4,-36(s0)
    800054f8:	01a70793          	add	a5,a4,26
    800054fc:	078e                	sll	a5,a5,0x3
    800054fe:	953e                	add	a0,a0,a5
    80005500:	611c                	ld	a5,0(a0)
    80005502:	c385                	beqz	a5,80005522 <argfd+0x5c>
    return -1;
  if(pfd)
    80005504:	00090463          	beqz	s2,8000550c <argfd+0x46>
    *pfd = fd;
    80005508:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    8000550c:	4501                	li	a0,0
  if(pf)
    8000550e:	c091                	beqz	s1,80005512 <argfd+0x4c>
    *pf = f;
    80005510:	e09c                	sd	a5,0(s1)
}
    80005512:	70a2                	ld	ra,40(sp)
    80005514:	7402                	ld	s0,32(sp)
    80005516:	64e2                	ld	s1,24(sp)
    80005518:	6942                	ld	s2,16(sp)
    8000551a:	6145                	add	sp,sp,48
    8000551c:	8082                	ret
    return -1;
    8000551e:	557d                	li	a0,-1
    80005520:	bfcd                	j	80005512 <argfd+0x4c>
    80005522:	557d                	li	a0,-1
    80005524:	b7fd                	j	80005512 <argfd+0x4c>

0000000080005526 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80005526:	1101                	add	sp,sp,-32
    80005528:	ec06                	sd	ra,24(sp)
    8000552a:	e822                	sd	s0,16(sp)
    8000552c:	e426                	sd	s1,8(sp)
    8000552e:	1000                	add	s0,sp,32
    80005530:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80005532:	ffffc097          	auipc	ra,0xffffc
    80005536:	496080e7          	jalr	1174(ra) # 800019c8 <myproc>
    8000553a:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    8000553c:	0d050793          	add	a5,a0,208
    80005540:	4501                	li	a0,0
    80005542:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80005544:	6398                	ld	a4,0(a5)
    80005546:	cb19                	beqz	a4,8000555c <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    80005548:	2505                	addw	a0,a0,1
    8000554a:	07a1                	add	a5,a5,8
    8000554c:	fed51ce3          	bne	a0,a3,80005544 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80005550:	557d                	li	a0,-1
}
    80005552:	60e2                	ld	ra,24(sp)
    80005554:	6442                	ld	s0,16(sp)
    80005556:	64a2                	ld	s1,8(sp)
    80005558:	6105                	add	sp,sp,32
    8000555a:	8082                	ret
      p->ofile[fd] = f;
    8000555c:	01a50793          	add	a5,a0,26
    80005560:	078e                	sll	a5,a5,0x3
    80005562:	963e                	add	a2,a2,a5
    80005564:	e204                	sd	s1,0(a2)
      return fd;
    80005566:	b7f5                	j	80005552 <fdalloc+0x2c>

0000000080005568 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    80005568:	715d                	add	sp,sp,-80
    8000556a:	e486                	sd	ra,72(sp)
    8000556c:	e0a2                	sd	s0,64(sp)
    8000556e:	fc26                	sd	s1,56(sp)
    80005570:	f84a                	sd	s2,48(sp)
    80005572:	f44e                	sd	s3,40(sp)
    80005574:	f052                	sd	s4,32(sp)
    80005576:	ec56                	sd	s5,24(sp)
    80005578:	e85a                	sd	s6,16(sp)
    8000557a:	0880                	add	s0,sp,80
    8000557c:	8b2e                	mv	s6,a1
    8000557e:	89b2                	mv	s3,a2
    80005580:	8936                	mv	s2,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80005582:	fb040593          	add	a1,s0,-80
    80005586:	fffff097          	auipc	ra,0xfffff
    8000558a:	e7e080e7          	jalr	-386(ra) # 80004404 <nameiparent>
    8000558e:	84aa                	mv	s1,a0
    80005590:	14050b63          	beqz	a0,800056e6 <create+0x17e>
    return 0;

  ilock(dp);
    80005594:	ffffe097          	auipc	ra,0xffffe
    80005598:	6ac080e7          	jalr	1708(ra) # 80003c40 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    8000559c:	4601                	li	a2,0
    8000559e:	fb040593          	add	a1,s0,-80
    800055a2:	8526                	mv	a0,s1
    800055a4:	fffff097          	auipc	ra,0xfffff
    800055a8:	b80080e7          	jalr	-1152(ra) # 80004124 <dirlookup>
    800055ac:	8aaa                	mv	s5,a0
    800055ae:	c921                	beqz	a0,800055fe <create+0x96>
    iunlockput(dp);
    800055b0:	8526                	mv	a0,s1
    800055b2:	fffff097          	auipc	ra,0xfffff
    800055b6:	8f0080e7          	jalr	-1808(ra) # 80003ea2 <iunlockput>
    ilock(ip);
    800055ba:	8556                	mv	a0,s5
    800055bc:	ffffe097          	auipc	ra,0xffffe
    800055c0:	684080e7          	jalr	1668(ra) # 80003c40 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    800055c4:	4789                	li	a5,2
    800055c6:	02fb1563          	bne	s6,a5,800055f0 <create+0x88>
    800055ca:	044ad783          	lhu	a5,68(s5)
    800055ce:	37f9                	addw	a5,a5,-2
    800055d0:	17c2                	sll	a5,a5,0x30
    800055d2:	93c1                	srl	a5,a5,0x30
    800055d4:	4705                	li	a4,1
    800055d6:	00f76d63          	bltu	a4,a5,800055f0 <create+0x88>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    800055da:	8556                	mv	a0,s5
    800055dc:	60a6                	ld	ra,72(sp)
    800055de:	6406                	ld	s0,64(sp)
    800055e0:	74e2                	ld	s1,56(sp)
    800055e2:	7942                	ld	s2,48(sp)
    800055e4:	79a2                	ld	s3,40(sp)
    800055e6:	7a02                	ld	s4,32(sp)
    800055e8:	6ae2                	ld	s5,24(sp)
    800055ea:	6b42                	ld	s6,16(sp)
    800055ec:	6161                	add	sp,sp,80
    800055ee:	8082                	ret
    iunlockput(ip);
    800055f0:	8556                	mv	a0,s5
    800055f2:	fffff097          	auipc	ra,0xfffff
    800055f6:	8b0080e7          	jalr	-1872(ra) # 80003ea2 <iunlockput>
    return 0;
    800055fa:	4a81                	li	s5,0
    800055fc:	bff9                	j	800055da <create+0x72>
  if((ip = ialloc(dp->dev, type)) == 0){
    800055fe:	85da                	mv	a1,s6
    80005600:	4088                	lw	a0,0(s1)
    80005602:	ffffe097          	auipc	ra,0xffffe
    80005606:	4a6080e7          	jalr	1190(ra) # 80003aa8 <ialloc>
    8000560a:	8a2a                	mv	s4,a0
    8000560c:	c529                	beqz	a0,80005656 <create+0xee>
  ilock(ip);
    8000560e:	ffffe097          	auipc	ra,0xffffe
    80005612:	632080e7          	jalr	1586(ra) # 80003c40 <ilock>
  ip->major = major;
    80005616:	053a1323          	sh	s3,70(s4)
  ip->minor = minor;
    8000561a:	052a1423          	sh	s2,72(s4)
  ip->nlink = 1;
    8000561e:	4905                	li	s2,1
    80005620:	052a1523          	sh	s2,74(s4)
  iupdate(ip);
    80005624:	8552                	mv	a0,s4
    80005626:	ffffe097          	auipc	ra,0xffffe
    8000562a:	54e080e7          	jalr	1358(ra) # 80003b74 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    8000562e:	032b0b63          	beq	s6,s2,80005664 <create+0xfc>
  if(dirlink(dp, name, ip->inum) < 0)
    80005632:	004a2603          	lw	a2,4(s4)
    80005636:	fb040593          	add	a1,s0,-80
    8000563a:	8526                	mv	a0,s1
    8000563c:	fffff097          	auipc	ra,0xfffff
    80005640:	cf8080e7          	jalr	-776(ra) # 80004334 <dirlink>
    80005644:	06054f63          	bltz	a0,800056c2 <create+0x15a>
  iunlockput(dp);
    80005648:	8526                	mv	a0,s1
    8000564a:	fffff097          	auipc	ra,0xfffff
    8000564e:	858080e7          	jalr	-1960(ra) # 80003ea2 <iunlockput>
  return ip;
    80005652:	8ad2                	mv	s5,s4
    80005654:	b759                	j	800055da <create+0x72>
    iunlockput(dp);
    80005656:	8526                	mv	a0,s1
    80005658:	fffff097          	auipc	ra,0xfffff
    8000565c:	84a080e7          	jalr	-1974(ra) # 80003ea2 <iunlockput>
    return 0;
    80005660:	8ad2                	mv	s5,s4
    80005662:	bfa5                	j	800055da <create+0x72>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80005664:	004a2603          	lw	a2,4(s4)
    80005668:	00003597          	auipc	a1,0x3
    8000566c:	15058593          	add	a1,a1,336 # 800087b8 <syscalls+0x330>
    80005670:	8552                	mv	a0,s4
    80005672:	fffff097          	auipc	ra,0xfffff
    80005676:	cc2080e7          	jalr	-830(ra) # 80004334 <dirlink>
    8000567a:	04054463          	bltz	a0,800056c2 <create+0x15a>
    8000567e:	40d0                	lw	a2,4(s1)
    80005680:	00003597          	auipc	a1,0x3
    80005684:	14058593          	add	a1,a1,320 # 800087c0 <syscalls+0x338>
    80005688:	8552                	mv	a0,s4
    8000568a:	fffff097          	auipc	ra,0xfffff
    8000568e:	caa080e7          	jalr	-854(ra) # 80004334 <dirlink>
    80005692:	02054863          	bltz	a0,800056c2 <create+0x15a>
  if(dirlink(dp, name, ip->inum) < 0)
    80005696:	004a2603          	lw	a2,4(s4)
    8000569a:	fb040593          	add	a1,s0,-80
    8000569e:	8526                	mv	a0,s1
    800056a0:	fffff097          	auipc	ra,0xfffff
    800056a4:	c94080e7          	jalr	-876(ra) # 80004334 <dirlink>
    800056a8:	00054d63          	bltz	a0,800056c2 <create+0x15a>
    dp->nlink++;  // for ".."
    800056ac:	04a4d783          	lhu	a5,74(s1)
    800056b0:	2785                	addw	a5,a5,1
    800056b2:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    800056b6:	8526                	mv	a0,s1
    800056b8:	ffffe097          	auipc	ra,0xffffe
    800056bc:	4bc080e7          	jalr	1212(ra) # 80003b74 <iupdate>
    800056c0:	b761                	j	80005648 <create+0xe0>
  ip->nlink = 0;
    800056c2:	040a1523          	sh	zero,74(s4)
  iupdate(ip);
    800056c6:	8552                	mv	a0,s4
    800056c8:	ffffe097          	auipc	ra,0xffffe
    800056cc:	4ac080e7          	jalr	1196(ra) # 80003b74 <iupdate>
  iunlockput(ip);
    800056d0:	8552                	mv	a0,s4
    800056d2:	ffffe097          	auipc	ra,0xffffe
    800056d6:	7d0080e7          	jalr	2000(ra) # 80003ea2 <iunlockput>
  iunlockput(dp);
    800056da:	8526                	mv	a0,s1
    800056dc:	ffffe097          	auipc	ra,0xffffe
    800056e0:	7c6080e7          	jalr	1990(ra) # 80003ea2 <iunlockput>
  return 0;
    800056e4:	bddd                	j	800055da <create+0x72>
    return 0;
    800056e6:	8aaa                	mv	s5,a0
    800056e8:	bdcd                	j	800055da <create+0x72>

00000000800056ea <sys_dup>:
{
    800056ea:	7179                	add	sp,sp,-48
    800056ec:	f406                	sd	ra,40(sp)
    800056ee:	f022                	sd	s0,32(sp)
    800056f0:	ec26                	sd	s1,24(sp)
    800056f2:	e84a                	sd	s2,16(sp)
    800056f4:	1800                	add	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    800056f6:	fd840613          	add	a2,s0,-40
    800056fa:	4581                	li	a1,0
    800056fc:	4501                	li	a0,0
    800056fe:	00000097          	auipc	ra,0x0
    80005702:	dc8080e7          	jalr	-568(ra) # 800054c6 <argfd>
    return -1;
    80005706:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80005708:	02054363          	bltz	a0,8000572e <sys_dup+0x44>
  if((fd=fdalloc(f)) < 0)
    8000570c:	fd843903          	ld	s2,-40(s0)
    80005710:	854a                	mv	a0,s2
    80005712:	00000097          	auipc	ra,0x0
    80005716:	e14080e7          	jalr	-492(ra) # 80005526 <fdalloc>
    8000571a:	84aa                	mv	s1,a0
    return -1;
    8000571c:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    8000571e:	00054863          	bltz	a0,8000572e <sys_dup+0x44>
  filedup(f);
    80005722:	854a                	mv	a0,s2
    80005724:	fffff097          	auipc	ra,0xfffff
    80005728:	334080e7          	jalr	820(ra) # 80004a58 <filedup>
  return fd;
    8000572c:	87a6                	mv	a5,s1
}
    8000572e:	853e                	mv	a0,a5
    80005730:	70a2                	ld	ra,40(sp)
    80005732:	7402                	ld	s0,32(sp)
    80005734:	64e2                	ld	s1,24(sp)
    80005736:	6942                	ld	s2,16(sp)
    80005738:	6145                	add	sp,sp,48
    8000573a:	8082                	ret

000000008000573c <sys_read>:
{
    8000573c:	7179                	add	sp,sp,-48
    8000573e:	f406                	sd	ra,40(sp)
    80005740:	f022                	sd	s0,32(sp)
    80005742:	1800                	add	s0,sp,48
  argaddr(1, &p);
    80005744:	fd840593          	add	a1,s0,-40
    80005748:	4505                	li	a0,1
    8000574a:	ffffd097          	auipc	ra,0xffffd
    8000574e:	744080e7          	jalr	1860(ra) # 80002e8e <argaddr>
  argint(2, &n);
    80005752:	fe440593          	add	a1,s0,-28
    80005756:	4509                	li	a0,2
    80005758:	ffffd097          	auipc	ra,0xffffd
    8000575c:	716080e7          	jalr	1814(ra) # 80002e6e <argint>
  if(argfd(0, 0, &f) < 0)
    80005760:	fe840613          	add	a2,s0,-24
    80005764:	4581                	li	a1,0
    80005766:	4501                	li	a0,0
    80005768:	00000097          	auipc	ra,0x0
    8000576c:	d5e080e7          	jalr	-674(ra) # 800054c6 <argfd>
    80005770:	87aa                	mv	a5,a0
    return -1;
    80005772:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80005774:	0007cc63          	bltz	a5,8000578c <sys_read+0x50>
  return fileread(f, p, n);
    80005778:	fe442603          	lw	a2,-28(s0)
    8000577c:	fd843583          	ld	a1,-40(s0)
    80005780:	fe843503          	ld	a0,-24(s0)
    80005784:	fffff097          	auipc	ra,0xfffff
    80005788:	460080e7          	jalr	1120(ra) # 80004be4 <fileread>
}
    8000578c:	70a2                	ld	ra,40(sp)
    8000578e:	7402                	ld	s0,32(sp)
    80005790:	6145                	add	sp,sp,48
    80005792:	8082                	ret

0000000080005794 <sys_write>:
{
    80005794:	7179                	add	sp,sp,-48
    80005796:	f406                	sd	ra,40(sp)
    80005798:	f022                	sd	s0,32(sp)
    8000579a:	1800                	add	s0,sp,48
  argaddr(1, &p);
    8000579c:	fd840593          	add	a1,s0,-40
    800057a0:	4505                	li	a0,1
    800057a2:	ffffd097          	auipc	ra,0xffffd
    800057a6:	6ec080e7          	jalr	1772(ra) # 80002e8e <argaddr>
  argint(2, &n);
    800057aa:	fe440593          	add	a1,s0,-28
    800057ae:	4509                	li	a0,2
    800057b0:	ffffd097          	auipc	ra,0xffffd
    800057b4:	6be080e7          	jalr	1726(ra) # 80002e6e <argint>
  if(argfd(0, 0, &f) < 0)
    800057b8:	fe840613          	add	a2,s0,-24
    800057bc:	4581                	li	a1,0
    800057be:	4501                	li	a0,0
    800057c0:	00000097          	auipc	ra,0x0
    800057c4:	d06080e7          	jalr	-762(ra) # 800054c6 <argfd>
    800057c8:	87aa                	mv	a5,a0
    return -1;
    800057ca:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    800057cc:	0007cc63          	bltz	a5,800057e4 <sys_write+0x50>
  return filewrite(f, p, n);
    800057d0:	fe442603          	lw	a2,-28(s0)
    800057d4:	fd843583          	ld	a1,-40(s0)
    800057d8:	fe843503          	ld	a0,-24(s0)
    800057dc:	fffff097          	auipc	ra,0xfffff
    800057e0:	4ca080e7          	jalr	1226(ra) # 80004ca6 <filewrite>
}
    800057e4:	70a2                	ld	ra,40(sp)
    800057e6:	7402                	ld	s0,32(sp)
    800057e8:	6145                	add	sp,sp,48
    800057ea:	8082                	ret

00000000800057ec <sys_close>:
{
    800057ec:	1101                	add	sp,sp,-32
    800057ee:	ec06                	sd	ra,24(sp)
    800057f0:	e822                	sd	s0,16(sp)
    800057f2:	1000                	add	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    800057f4:	fe040613          	add	a2,s0,-32
    800057f8:	fec40593          	add	a1,s0,-20
    800057fc:	4501                	li	a0,0
    800057fe:	00000097          	auipc	ra,0x0
    80005802:	cc8080e7          	jalr	-824(ra) # 800054c6 <argfd>
    return -1;
    80005806:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80005808:	02054463          	bltz	a0,80005830 <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    8000580c:	ffffc097          	auipc	ra,0xffffc
    80005810:	1bc080e7          	jalr	444(ra) # 800019c8 <myproc>
    80005814:	fec42783          	lw	a5,-20(s0)
    80005818:	07e9                	add	a5,a5,26
    8000581a:	078e                	sll	a5,a5,0x3
    8000581c:	953e                	add	a0,a0,a5
    8000581e:	00053023          	sd	zero,0(a0)
  fileclose(f);
    80005822:	fe043503          	ld	a0,-32(s0)
    80005826:	fffff097          	auipc	ra,0xfffff
    8000582a:	284080e7          	jalr	644(ra) # 80004aaa <fileclose>
  return 0;
    8000582e:	4781                	li	a5,0
}
    80005830:	853e                	mv	a0,a5
    80005832:	60e2                	ld	ra,24(sp)
    80005834:	6442                	ld	s0,16(sp)
    80005836:	6105                	add	sp,sp,32
    80005838:	8082                	ret

000000008000583a <sys_fstat>:
{
    8000583a:	1101                	add	sp,sp,-32
    8000583c:	ec06                	sd	ra,24(sp)
    8000583e:	e822                	sd	s0,16(sp)
    80005840:	1000                	add	s0,sp,32
  argaddr(1, &st);
    80005842:	fe040593          	add	a1,s0,-32
    80005846:	4505                	li	a0,1
    80005848:	ffffd097          	auipc	ra,0xffffd
    8000584c:	646080e7          	jalr	1606(ra) # 80002e8e <argaddr>
  if(argfd(0, 0, &f) < 0)
    80005850:	fe840613          	add	a2,s0,-24
    80005854:	4581                	li	a1,0
    80005856:	4501                	li	a0,0
    80005858:	00000097          	auipc	ra,0x0
    8000585c:	c6e080e7          	jalr	-914(ra) # 800054c6 <argfd>
    80005860:	87aa                	mv	a5,a0
    return -1;
    80005862:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80005864:	0007ca63          	bltz	a5,80005878 <sys_fstat+0x3e>
  return filestat(f, st);
    80005868:	fe043583          	ld	a1,-32(s0)
    8000586c:	fe843503          	ld	a0,-24(s0)
    80005870:	fffff097          	auipc	ra,0xfffff
    80005874:	302080e7          	jalr	770(ra) # 80004b72 <filestat>
}
    80005878:	60e2                	ld	ra,24(sp)
    8000587a:	6442                	ld	s0,16(sp)
    8000587c:	6105                	add	sp,sp,32
    8000587e:	8082                	ret

0000000080005880 <sys_link>:
{
    80005880:	7169                	add	sp,sp,-304
    80005882:	f606                	sd	ra,296(sp)
    80005884:	f222                	sd	s0,288(sp)
    80005886:	ee26                	sd	s1,280(sp)
    80005888:	ea4a                	sd	s2,272(sp)
    8000588a:	1a00                	add	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000588c:	08000613          	li	a2,128
    80005890:	ed040593          	add	a1,s0,-304
    80005894:	4501                	li	a0,0
    80005896:	ffffd097          	auipc	ra,0xffffd
    8000589a:	618080e7          	jalr	1560(ra) # 80002eae <argstr>
    return -1;
    8000589e:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800058a0:	10054e63          	bltz	a0,800059bc <sys_link+0x13c>
    800058a4:	08000613          	li	a2,128
    800058a8:	f5040593          	add	a1,s0,-176
    800058ac:	4505                	li	a0,1
    800058ae:	ffffd097          	auipc	ra,0xffffd
    800058b2:	600080e7          	jalr	1536(ra) # 80002eae <argstr>
    return -1;
    800058b6:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800058b8:	10054263          	bltz	a0,800059bc <sys_link+0x13c>
  begin_op();
    800058bc:	fffff097          	auipc	ra,0xfffff
    800058c0:	d2a080e7          	jalr	-726(ra) # 800045e6 <begin_op>
  if((ip = namei(old)) == 0){
    800058c4:	ed040513          	add	a0,s0,-304
    800058c8:	fffff097          	auipc	ra,0xfffff
    800058cc:	b1e080e7          	jalr	-1250(ra) # 800043e6 <namei>
    800058d0:	84aa                	mv	s1,a0
    800058d2:	c551                	beqz	a0,8000595e <sys_link+0xde>
  ilock(ip);
    800058d4:	ffffe097          	auipc	ra,0xffffe
    800058d8:	36c080e7          	jalr	876(ra) # 80003c40 <ilock>
  if(ip->type == T_DIR){
    800058dc:	04449703          	lh	a4,68(s1)
    800058e0:	4785                	li	a5,1
    800058e2:	08f70463          	beq	a4,a5,8000596a <sys_link+0xea>
  ip->nlink++;
    800058e6:	04a4d783          	lhu	a5,74(s1)
    800058ea:	2785                	addw	a5,a5,1
    800058ec:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800058f0:	8526                	mv	a0,s1
    800058f2:	ffffe097          	auipc	ra,0xffffe
    800058f6:	282080e7          	jalr	642(ra) # 80003b74 <iupdate>
  iunlock(ip);
    800058fa:	8526                	mv	a0,s1
    800058fc:	ffffe097          	auipc	ra,0xffffe
    80005900:	406080e7          	jalr	1030(ra) # 80003d02 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80005904:	fd040593          	add	a1,s0,-48
    80005908:	f5040513          	add	a0,s0,-176
    8000590c:	fffff097          	auipc	ra,0xfffff
    80005910:	af8080e7          	jalr	-1288(ra) # 80004404 <nameiparent>
    80005914:	892a                	mv	s2,a0
    80005916:	c935                	beqz	a0,8000598a <sys_link+0x10a>
  ilock(dp);
    80005918:	ffffe097          	auipc	ra,0xffffe
    8000591c:	328080e7          	jalr	808(ra) # 80003c40 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80005920:	00092703          	lw	a4,0(s2)
    80005924:	409c                	lw	a5,0(s1)
    80005926:	04f71d63          	bne	a4,a5,80005980 <sys_link+0x100>
    8000592a:	40d0                	lw	a2,4(s1)
    8000592c:	fd040593          	add	a1,s0,-48
    80005930:	854a                	mv	a0,s2
    80005932:	fffff097          	auipc	ra,0xfffff
    80005936:	a02080e7          	jalr	-1534(ra) # 80004334 <dirlink>
    8000593a:	04054363          	bltz	a0,80005980 <sys_link+0x100>
  iunlockput(dp);
    8000593e:	854a                	mv	a0,s2
    80005940:	ffffe097          	auipc	ra,0xffffe
    80005944:	562080e7          	jalr	1378(ra) # 80003ea2 <iunlockput>
  iput(ip);
    80005948:	8526                	mv	a0,s1
    8000594a:	ffffe097          	auipc	ra,0xffffe
    8000594e:	4b0080e7          	jalr	1200(ra) # 80003dfa <iput>
  end_op();
    80005952:	fffff097          	auipc	ra,0xfffff
    80005956:	d0e080e7          	jalr	-754(ra) # 80004660 <end_op>
  return 0;
    8000595a:	4781                	li	a5,0
    8000595c:	a085                	j	800059bc <sys_link+0x13c>
    end_op();
    8000595e:	fffff097          	auipc	ra,0xfffff
    80005962:	d02080e7          	jalr	-766(ra) # 80004660 <end_op>
    return -1;
    80005966:	57fd                	li	a5,-1
    80005968:	a891                	j	800059bc <sys_link+0x13c>
    iunlockput(ip);
    8000596a:	8526                	mv	a0,s1
    8000596c:	ffffe097          	auipc	ra,0xffffe
    80005970:	536080e7          	jalr	1334(ra) # 80003ea2 <iunlockput>
    end_op();
    80005974:	fffff097          	auipc	ra,0xfffff
    80005978:	cec080e7          	jalr	-788(ra) # 80004660 <end_op>
    return -1;
    8000597c:	57fd                	li	a5,-1
    8000597e:	a83d                	j	800059bc <sys_link+0x13c>
    iunlockput(dp);
    80005980:	854a                	mv	a0,s2
    80005982:	ffffe097          	auipc	ra,0xffffe
    80005986:	520080e7          	jalr	1312(ra) # 80003ea2 <iunlockput>
  ilock(ip);
    8000598a:	8526                	mv	a0,s1
    8000598c:	ffffe097          	auipc	ra,0xffffe
    80005990:	2b4080e7          	jalr	692(ra) # 80003c40 <ilock>
  ip->nlink--;
    80005994:	04a4d783          	lhu	a5,74(s1)
    80005998:	37fd                	addw	a5,a5,-1
    8000599a:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    8000599e:	8526                	mv	a0,s1
    800059a0:	ffffe097          	auipc	ra,0xffffe
    800059a4:	1d4080e7          	jalr	468(ra) # 80003b74 <iupdate>
  iunlockput(ip);
    800059a8:	8526                	mv	a0,s1
    800059aa:	ffffe097          	auipc	ra,0xffffe
    800059ae:	4f8080e7          	jalr	1272(ra) # 80003ea2 <iunlockput>
  end_op();
    800059b2:	fffff097          	auipc	ra,0xfffff
    800059b6:	cae080e7          	jalr	-850(ra) # 80004660 <end_op>
  return -1;
    800059ba:	57fd                	li	a5,-1
}
    800059bc:	853e                	mv	a0,a5
    800059be:	70b2                	ld	ra,296(sp)
    800059c0:	7412                	ld	s0,288(sp)
    800059c2:	64f2                	ld	s1,280(sp)
    800059c4:	6952                	ld	s2,272(sp)
    800059c6:	6155                	add	sp,sp,304
    800059c8:	8082                	ret

00000000800059ca <sys_unlink>:
{
    800059ca:	7151                	add	sp,sp,-240
    800059cc:	f586                	sd	ra,232(sp)
    800059ce:	f1a2                	sd	s0,224(sp)
    800059d0:	eda6                	sd	s1,216(sp)
    800059d2:	e9ca                	sd	s2,208(sp)
    800059d4:	e5ce                	sd	s3,200(sp)
    800059d6:	1980                	add	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    800059d8:	08000613          	li	a2,128
    800059dc:	f3040593          	add	a1,s0,-208
    800059e0:	4501                	li	a0,0
    800059e2:	ffffd097          	auipc	ra,0xffffd
    800059e6:	4cc080e7          	jalr	1228(ra) # 80002eae <argstr>
    800059ea:	18054163          	bltz	a0,80005b6c <sys_unlink+0x1a2>
  begin_op();
    800059ee:	fffff097          	auipc	ra,0xfffff
    800059f2:	bf8080e7          	jalr	-1032(ra) # 800045e6 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    800059f6:	fb040593          	add	a1,s0,-80
    800059fa:	f3040513          	add	a0,s0,-208
    800059fe:	fffff097          	auipc	ra,0xfffff
    80005a02:	a06080e7          	jalr	-1530(ra) # 80004404 <nameiparent>
    80005a06:	84aa                	mv	s1,a0
    80005a08:	c979                	beqz	a0,80005ade <sys_unlink+0x114>
  ilock(dp);
    80005a0a:	ffffe097          	auipc	ra,0xffffe
    80005a0e:	236080e7          	jalr	566(ra) # 80003c40 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80005a12:	00003597          	auipc	a1,0x3
    80005a16:	da658593          	add	a1,a1,-602 # 800087b8 <syscalls+0x330>
    80005a1a:	fb040513          	add	a0,s0,-80
    80005a1e:	ffffe097          	auipc	ra,0xffffe
    80005a22:	6ec080e7          	jalr	1772(ra) # 8000410a <namecmp>
    80005a26:	14050a63          	beqz	a0,80005b7a <sys_unlink+0x1b0>
    80005a2a:	00003597          	auipc	a1,0x3
    80005a2e:	d9658593          	add	a1,a1,-618 # 800087c0 <syscalls+0x338>
    80005a32:	fb040513          	add	a0,s0,-80
    80005a36:	ffffe097          	auipc	ra,0xffffe
    80005a3a:	6d4080e7          	jalr	1748(ra) # 8000410a <namecmp>
    80005a3e:	12050e63          	beqz	a0,80005b7a <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    80005a42:	f2c40613          	add	a2,s0,-212
    80005a46:	fb040593          	add	a1,s0,-80
    80005a4a:	8526                	mv	a0,s1
    80005a4c:	ffffe097          	auipc	ra,0xffffe
    80005a50:	6d8080e7          	jalr	1752(ra) # 80004124 <dirlookup>
    80005a54:	892a                	mv	s2,a0
    80005a56:	12050263          	beqz	a0,80005b7a <sys_unlink+0x1b0>
  ilock(ip);
    80005a5a:	ffffe097          	auipc	ra,0xffffe
    80005a5e:	1e6080e7          	jalr	486(ra) # 80003c40 <ilock>
  if(ip->nlink < 1)
    80005a62:	04a91783          	lh	a5,74(s2)
    80005a66:	08f05263          	blez	a5,80005aea <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80005a6a:	04491703          	lh	a4,68(s2)
    80005a6e:	4785                	li	a5,1
    80005a70:	08f70563          	beq	a4,a5,80005afa <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    80005a74:	4641                	li	a2,16
    80005a76:	4581                	li	a1,0
    80005a78:	fc040513          	add	a0,s0,-64
    80005a7c:	ffffb097          	auipc	ra,0xffffb
    80005a80:	274080e7          	jalr	628(ra) # 80000cf0 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005a84:	4741                	li	a4,16
    80005a86:	f2c42683          	lw	a3,-212(s0)
    80005a8a:	fc040613          	add	a2,s0,-64
    80005a8e:	4581                	li	a1,0
    80005a90:	8526                	mv	a0,s1
    80005a92:	ffffe097          	auipc	ra,0xffffe
    80005a96:	55a080e7          	jalr	1370(ra) # 80003fec <writei>
    80005a9a:	47c1                	li	a5,16
    80005a9c:	0af51563          	bne	a0,a5,80005b46 <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    80005aa0:	04491703          	lh	a4,68(s2)
    80005aa4:	4785                	li	a5,1
    80005aa6:	0af70863          	beq	a4,a5,80005b56 <sys_unlink+0x18c>
  iunlockput(dp);
    80005aaa:	8526                	mv	a0,s1
    80005aac:	ffffe097          	auipc	ra,0xffffe
    80005ab0:	3f6080e7          	jalr	1014(ra) # 80003ea2 <iunlockput>
  ip->nlink--;
    80005ab4:	04a95783          	lhu	a5,74(s2)
    80005ab8:	37fd                	addw	a5,a5,-1
    80005aba:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80005abe:	854a                	mv	a0,s2
    80005ac0:	ffffe097          	auipc	ra,0xffffe
    80005ac4:	0b4080e7          	jalr	180(ra) # 80003b74 <iupdate>
  iunlockput(ip);
    80005ac8:	854a                	mv	a0,s2
    80005aca:	ffffe097          	auipc	ra,0xffffe
    80005ace:	3d8080e7          	jalr	984(ra) # 80003ea2 <iunlockput>
  end_op();
    80005ad2:	fffff097          	auipc	ra,0xfffff
    80005ad6:	b8e080e7          	jalr	-1138(ra) # 80004660 <end_op>
  return 0;
    80005ada:	4501                	li	a0,0
    80005adc:	a84d                	j	80005b8e <sys_unlink+0x1c4>
    end_op();
    80005ade:	fffff097          	auipc	ra,0xfffff
    80005ae2:	b82080e7          	jalr	-1150(ra) # 80004660 <end_op>
    return -1;
    80005ae6:	557d                	li	a0,-1
    80005ae8:	a05d                	j	80005b8e <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    80005aea:	00003517          	auipc	a0,0x3
    80005aee:	cde50513          	add	a0,a0,-802 # 800087c8 <syscalls+0x340>
    80005af2:	ffffb097          	auipc	ra,0xffffb
    80005af6:	a4a080e7          	jalr	-1462(ra) # 8000053c <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80005afa:	04c92703          	lw	a4,76(s2)
    80005afe:	02000793          	li	a5,32
    80005b02:	f6e7f9e3          	bgeu	a5,a4,80005a74 <sys_unlink+0xaa>
    80005b06:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005b0a:	4741                	li	a4,16
    80005b0c:	86ce                	mv	a3,s3
    80005b0e:	f1840613          	add	a2,s0,-232
    80005b12:	4581                	li	a1,0
    80005b14:	854a                	mv	a0,s2
    80005b16:	ffffe097          	auipc	ra,0xffffe
    80005b1a:	3de080e7          	jalr	990(ra) # 80003ef4 <readi>
    80005b1e:	47c1                	li	a5,16
    80005b20:	00f51b63          	bne	a0,a5,80005b36 <sys_unlink+0x16c>
    if(de.inum != 0)
    80005b24:	f1845783          	lhu	a5,-232(s0)
    80005b28:	e7a1                	bnez	a5,80005b70 <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80005b2a:	29c1                	addw	s3,s3,16
    80005b2c:	04c92783          	lw	a5,76(s2)
    80005b30:	fcf9ede3          	bltu	s3,a5,80005b0a <sys_unlink+0x140>
    80005b34:	b781                	j	80005a74 <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80005b36:	00003517          	auipc	a0,0x3
    80005b3a:	caa50513          	add	a0,a0,-854 # 800087e0 <syscalls+0x358>
    80005b3e:	ffffb097          	auipc	ra,0xffffb
    80005b42:	9fe080e7          	jalr	-1538(ra) # 8000053c <panic>
    panic("unlink: writei");
    80005b46:	00003517          	auipc	a0,0x3
    80005b4a:	cb250513          	add	a0,a0,-846 # 800087f8 <syscalls+0x370>
    80005b4e:	ffffb097          	auipc	ra,0xffffb
    80005b52:	9ee080e7          	jalr	-1554(ra) # 8000053c <panic>
    dp->nlink--;
    80005b56:	04a4d783          	lhu	a5,74(s1)
    80005b5a:	37fd                	addw	a5,a5,-1
    80005b5c:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80005b60:	8526                	mv	a0,s1
    80005b62:	ffffe097          	auipc	ra,0xffffe
    80005b66:	012080e7          	jalr	18(ra) # 80003b74 <iupdate>
    80005b6a:	b781                	j	80005aaa <sys_unlink+0xe0>
    return -1;
    80005b6c:	557d                	li	a0,-1
    80005b6e:	a005                	j	80005b8e <sys_unlink+0x1c4>
    iunlockput(ip);
    80005b70:	854a                	mv	a0,s2
    80005b72:	ffffe097          	auipc	ra,0xffffe
    80005b76:	330080e7          	jalr	816(ra) # 80003ea2 <iunlockput>
  iunlockput(dp);
    80005b7a:	8526                	mv	a0,s1
    80005b7c:	ffffe097          	auipc	ra,0xffffe
    80005b80:	326080e7          	jalr	806(ra) # 80003ea2 <iunlockput>
  end_op();
    80005b84:	fffff097          	auipc	ra,0xfffff
    80005b88:	adc080e7          	jalr	-1316(ra) # 80004660 <end_op>
  return -1;
    80005b8c:	557d                	li	a0,-1
}
    80005b8e:	70ae                	ld	ra,232(sp)
    80005b90:	740e                	ld	s0,224(sp)
    80005b92:	64ee                	ld	s1,216(sp)
    80005b94:	694e                	ld	s2,208(sp)
    80005b96:	69ae                	ld	s3,200(sp)
    80005b98:	616d                	add	sp,sp,240
    80005b9a:	8082                	ret

0000000080005b9c <sys_open>:

uint64
sys_open(void)
{
    80005b9c:	7131                	add	sp,sp,-192
    80005b9e:	fd06                	sd	ra,184(sp)
    80005ba0:	f922                	sd	s0,176(sp)
    80005ba2:	f526                	sd	s1,168(sp)
    80005ba4:	f14a                	sd	s2,160(sp)
    80005ba6:	ed4e                	sd	s3,152(sp)
    80005ba8:	0180                	add	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    80005baa:	f4c40593          	add	a1,s0,-180
    80005bae:	4505                	li	a0,1
    80005bb0:	ffffd097          	auipc	ra,0xffffd
    80005bb4:	2be080e7          	jalr	702(ra) # 80002e6e <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    80005bb8:	08000613          	li	a2,128
    80005bbc:	f5040593          	add	a1,s0,-176
    80005bc0:	4501                	li	a0,0
    80005bc2:	ffffd097          	auipc	ra,0xffffd
    80005bc6:	2ec080e7          	jalr	748(ra) # 80002eae <argstr>
    80005bca:	87aa                	mv	a5,a0
    return -1;
    80005bcc:	557d                	li	a0,-1
  if((n = argstr(0, path, MAXPATH)) < 0)
    80005bce:	0a07c863          	bltz	a5,80005c7e <sys_open+0xe2>

  begin_op();
    80005bd2:	fffff097          	auipc	ra,0xfffff
    80005bd6:	a14080e7          	jalr	-1516(ra) # 800045e6 <begin_op>

  if(omode & O_CREATE){
    80005bda:	f4c42783          	lw	a5,-180(s0)
    80005bde:	2007f793          	and	a5,a5,512
    80005be2:	cbdd                	beqz	a5,80005c98 <sys_open+0xfc>
    ip = create(path, T_FILE, 0, 0);
    80005be4:	4681                	li	a3,0
    80005be6:	4601                	li	a2,0
    80005be8:	4589                	li	a1,2
    80005bea:	f5040513          	add	a0,s0,-176
    80005bee:	00000097          	auipc	ra,0x0
    80005bf2:	97a080e7          	jalr	-1670(ra) # 80005568 <create>
    80005bf6:	84aa                	mv	s1,a0
    if(ip == 0){
    80005bf8:	c951                	beqz	a0,80005c8c <sys_open+0xf0>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80005bfa:	04449703          	lh	a4,68(s1)
    80005bfe:	478d                	li	a5,3
    80005c00:	00f71763          	bne	a4,a5,80005c0e <sys_open+0x72>
    80005c04:	0464d703          	lhu	a4,70(s1)
    80005c08:	47a5                	li	a5,9
    80005c0a:	0ce7ec63          	bltu	a5,a4,80005ce2 <sys_open+0x146>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80005c0e:	fffff097          	auipc	ra,0xfffff
    80005c12:	de0080e7          	jalr	-544(ra) # 800049ee <filealloc>
    80005c16:	892a                	mv	s2,a0
    80005c18:	c56d                	beqz	a0,80005d02 <sys_open+0x166>
    80005c1a:	00000097          	auipc	ra,0x0
    80005c1e:	90c080e7          	jalr	-1780(ra) # 80005526 <fdalloc>
    80005c22:	89aa                	mv	s3,a0
    80005c24:	0c054a63          	bltz	a0,80005cf8 <sys_open+0x15c>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80005c28:	04449703          	lh	a4,68(s1)
    80005c2c:	478d                	li	a5,3
    80005c2e:	0ef70563          	beq	a4,a5,80005d18 <sys_open+0x17c>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80005c32:	4789                	li	a5,2
    80005c34:	00f92023          	sw	a5,0(s2)
    f->off = 0;
    80005c38:	02092023          	sw	zero,32(s2)
  }
  f->ip = ip;
    80005c3c:	00993c23          	sd	s1,24(s2)
  f->readable = !(omode & O_WRONLY);
    80005c40:	f4c42783          	lw	a5,-180(s0)
    80005c44:	0017c713          	xor	a4,a5,1
    80005c48:	8b05                	and	a4,a4,1
    80005c4a:	00e90423          	sb	a4,8(s2)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80005c4e:	0037f713          	and	a4,a5,3
    80005c52:	00e03733          	snez	a4,a4
    80005c56:	00e904a3          	sb	a4,9(s2)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80005c5a:	4007f793          	and	a5,a5,1024
    80005c5e:	c791                	beqz	a5,80005c6a <sys_open+0xce>
    80005c60:	04449703          	lh	a4,68(s1)
    80005c64:	4789                	li	a5,2
    80005c66:	0cf70063          	beq	a4,a5,80005d26 <sys_open+0x18a>
    itrunc(ip);
  }

  iunlock(ip);
    80005c6a:	8526                	mv	a0,s1
    80005c6c:	ffffe097          	auipc	ra,0xffffe
    80005c70:	096080e7          	jalr	150(ra) # 80003d02 <iunlock>
  end_op();
    80005c74:	fffff097          	auipc	ra,0xfffff
    80005c78:	9ec080e7          	jalr	-1556(ra) # 80004660 <end_op>

  return fd;
    80005c7c:	854e                	mv	a0,s3
}
    80005c7e:	70ea                	ld	ra,184(sp)
    80005c80:	744a                	ld	s0,176(sp)
    80005c82:	74aa                	ld	s1,168(sp)
    80005c84:	790a                	ld	s2,160(sp)
    80005c86:	69ea                	ld	s3,152(sp)
    80005c88:	6129                	add	sp,sp,192
    80005c8a:	8082                	ret
      end_op();
    80005c8c:	fffff097          	auipc	ra,0xfffff
    80005c90:	9d4080e7          	jalr	-1580(ra) # 80004660 <end_op>
      return -1;
    80005c94:	557d                	li	a0,-1
    80005c96:	b7e5                	j	80005c7e <sys_open+0xe2>
    if((ip = namei(path)) == 0){
    80005c98:	f5040513          	add	a0,s0,-176
    80005c9c:	ffffe097          	auipc	ra,0xffffe
    80005ca0:	74a080e7          	jalr	1866(ra) # 800043e6 <namei>
    80005ca4:	84aa                	mv	s1,a0
    80005ca6:	c905                	beqz	a0,80005cd6 <sys_open+0x13a>
    ilock(ip);
    80005ca8:	ffffe097          	auipc	ra,0xffffe
    80005cac:	f98080e7          	jalr	-104(ra) # 80003c40 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80005cb0:	04449703          	lh	a4,68(s1)
    80005cb4:	4785                	li	a5,1
    80005cb6:	f4f712e3          	bne	a4,a5,80005bfa <sys_open+0x5e>
    80005cba:	f4c42783          	lw	a5,-180(s0)
    80005cbe:	dba1                	beqz	a5,80005c0e <sys_open+0x72>
      iunlockput(ip);
    80005cc0:	8526                	mv	a0,s1
    80005cc2:	ffffe097          	auipc	ra,0xffffe
    80005cc6:	1e0080e7          	jalr	480(ra) # 80003ea2 <iunlockput>
      end_op();
    80005cca:	fffff097          	auipc	ra,0xfffff
    80005cce:	996080e7          	jalr	-1642(ra) # 80004660 <end_op>
      return -1;
    80005cd2:	557d                	li	a0,-1
    80005cd4:	b76d                	j	80005c7e <sys_open+0xe2>
      end_op();
    80005cd6:	fffff097          	auipc	ra,0xfffff
    80005cda:	98a080e7          	jalr	-1654(ra) # 80004660 <end_op>
      return -1;
    80005cde:	557d                	li	a0,-1
    80005ce0:	bf79                	j	80005c7e <sys_open+0xe2>
    iunlockput(ip);
    80005ce2:	8526                	mv	a0,s1
    80005ce4:	ffffe097          	auipc	ra,0xffffe
    80005ce8:	1be080e7          	jalr	446(ra) # 80003ea2 <iunlockput>
    end_op();
    80005cec:	fffff097          	auipc	ra,0xfffff
    80005cf0:	974080e7          	jalr	-1676(ra) # 80004660 <end_op>
    return -1;
    80005cf4:	557d                	li	a0,-1
    80005cf6:	b761                	j	80005c7e <sys_open+0xe2>
      fileclose(f);
    80005cf8:	854a                	mv	a0,s2
    80005cfa:	fffff097          	auipc	ra,0xfffff
    80005cfe:	db0080e7          	jalr	-592(ra) # 80004aaa <fileclose>
    iunlockput(ip);
    80005d02:	8526                	mv	a0,s1
    80005d04:	ffffe097          	auipc	ra,0xffffe
    80005d08:	19e080e7          	jalr	414(ra) # 80003ea2 <iunlockput>
    end_op();
    80005d0c:	fffff097          	auipc	ra,0xfffff
    80005d10:	954080e7          	jalr	-1708(ra) # 80004660 <end_op>
    return -1;
    80005d14:	557d                	li	a0,-1
    80005d16:	b7a5                	j	80005c7e <sys_open+0xe2>
    f->type = FD_DEVICE;
    80005d18:	00f92023          	sw	a5,0(s2)
    f->major = ip->major;
    80005d1c:	04649783          	lh	a5,70(s1)
    80005d20:	02f91223          	sh	a5,36(s2)
    80005d24:	bf21                	j	80005c3c <sys_open+0xa0>
    itrunc(ip);
    80005d26:	8526                	mv	a0,s1
    80005d28:	ffffe097          	auipc	ra,0xffffe
    80005d2c:	026080e7          	jalr	38(ra) # 80003d4e <itrunc>
    80005d30:	bf2d                	j	80005c6a <sys_open+0xce>

0000000080005d32 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80005d32:	7175                	add	sp,sp,-144
    80005d34:	e506                	sd	ra,136(sp)
    80005d36:	e122                	sd	s0,128(sp)
    80005d38:	0900                	add	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80005d3a:	fffff097          	auipc	ra,0xfffff
    80005d3e:	8ac080e7          	jalr	-1876(ra) # 800045e6 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80005d42:	08000613          	li	a2,128
    80005d46:	f7040593          	add	a1,s0,-144
    80005d4a:	4501                	li	a0,0
    80005d4c:	ffffd097          	auipc	ra,0xffffd
    80005d50:	162080e7          	jalr	354(ra) # 80002eae <argstr>
    80005d54:	02054963          	bltz	a0,80005d86 <sys_mkdir+0x54>
    80005d58:	4681                	li	a3,0
    80005d5a:	4601                	li	a2,0
    80005d5c:	4585                	li	a1,1
    80005d5e:	f7040513          	add	a0,s0,-144
    80005d62:	00000097          	auipc	ra,0x0
    80005d66:	806080e7          	jalr	-2042(ra) # 80005568 <create>
    80005d6a:	cd11                	beqz	a0,80005d86 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80005d6c:	ffffe097          	auipc	ra,0xffffe
    80005d70:	136080e7          	jalr	310(ra) # 80003ea2 <iunlockput>
  end_op();
    80005d74:	fffff097          	auipc	ra,0xfffff
    80005d78:	8ec080e7          	jalr	-1812(ra) # 80004660 <end_op>
  return 0;
    80005d7c:	4501                	li	a0,0
}
    80005d7e:	60aa                	ld	ra,136(sp)
    80005d80:	640a                	ld	s0,128(sp)
    80005d82:	6149                	add	sp,sp,144
    80005d84:	8082                	ret
    end_op();
    80005d86:	fffff097          	auipc	ra,0xfffff
    80005d8a:	8da080e7          	jalr	-1830(ra) # 80004660 <end_op>
    return -1;
    80005d8e:	557d                	li	a0,-1
    80005d90:	b7fd                	j	80005d7e <sys_mkdir+0x4c>

0000000080005d92 <sys_mknod>:

uint64
sys_mknod(void)
{
    80005d92:	7135                	add	sp,sp,-160
    80005d94:	ed06                	sd	ra,152(sp)
    80005d96:	e922                	sd	s0,144(sp)
    80005d98:	1100                	add	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80005d9a:	fffff097          	auipc	ra,0xfffff
    80005d9e:	84c080e7          	jalr	-1972(ra) # 800045e6 <begin_op>
  argint(1, &major);
    80005da2:	f6c40593          	add	a1,s0,-148
    80005da6:	4505                	li	a0,1
    80005da8:	ffffd097          	auipc	ra,0xffffd
    80005dac:	0c6080e7          	jalr	198(ra) # 80002e6e <argint>
  argint(2, &minor);
    80005db0:	f6840593          	add	a1,s0,-152
    80005db4:	4509                	li	a0,2
    80005db6:	ffffd097          	auipc	ra,0xffffd
    80005dba:	0b8080e7          	jalr	184(ra) # 80002e6e <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80005dbe:	08000613          	li	a2,128
    80005dc2:	f7040593          	add	a1,s0,-144
    80005dc6:	4501                	li	a0,0
    80005dc8:	ffffd097          	auipc	ra,0xffffd
    80005dcc:	0e6080e7          	jalr	230(ra) # 80002eae <argstr>
    80005dd0:	02054b63          	bltz	a0,80005e06 <sys_mknod+0x74>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80005dd4:	f6841683          	lh	a3,-152(s0)
    80005dd8:	f6c41603          	lh	a2,-148(s0)
    80005ddc:	458d                	li	a1,3
    80005dde:	f7040513          	add	a0,s0,-144
    80005de2:	fffff097          	auipc	ra,0xfffff
    80005de6:	786080e7          	jalr	1926(ra) # 80005568 <create>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80005dea:	cd11                	beqz	a0,80005e06 <sys_mknod+0x74>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80005dec:	ffffe097          	auipc	ra,0xffffe
    80005df0:	0b6080e7          	jalr	182(ra) # 80003ea2 <iunlockput>
  end_op();
    80005df4:	fffff097          	auipc	ra,0xfffff
    80005df8:	86c080e7          	jalr	-1940(ra) # 80004660 <end_op>
  return 0;
    80005dfc:	4501                	li	a0,0
}
    80005dfe:	60ea                	ld	ra,152(sp)
    80005e00:	644a                	ld	s0,144(sp)
    80005e02:	610d                	add	sp,sp,160
    80005e04:	8082                	ret
    end_op();
    80005e06:	fffff097          	auipc	ra,0xfffff
    80005e0a:	85a080e7          	jalr	-1958(ra) # 80004660 <end_op>
    return -1;
    80005e0e:	557d                	li	a0,-1
    80005e10:	b7fd                	j	80005dfe <sys_mknod+0x6c>

0000000080005e12 <sys_chdir>:

uint64
sys_chdir(void)
{
    80005e12:	7135                	add	sp,sp,-160
    80005e14:	ed06                	sd	ra,152(sp)
    80005e16:	e922                	sd	s0,144(sp)
    80005e18:	e526                	sd	s1,136(sp)
    80005e1a:	e14a                	sd	s2,128(sp)
    80005e1c:	1100                	add	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80005e1e:	ffffc097          	auipc	ra,0xffffc
    80005e22:	baa080e7          	jalr	-1110(ra) # 800019c8 <myproc>
    80005e26:	892a                	mv	s2,a0
  
  begin_op();
    80005e28:	ffffe097          	auipc	ra,0xffffe
    80005e2c:	7be080e7          	jalr	1982(ra) # 800045e6 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80005e30:	08000613          	li	a2,128
    80005e34:	f6040593          	add	a1,s0,-160
    80005e38:	4501                	li	a0,0
    80005e3a:	ffffd097          	auipc	ra,0xffffd
    80005e3e:	074080e7          	jalr	116(ra) # 80002eae <argstr>
    80005e42:	04054b63          	bltz	a0,80005e98 <sys_chdir+0x86>
    80005e46:	f6040513          	add	a0,s0,-160
    80005e4a:	ffffe097          	auipc	ra,0xffffe
    80005e4e:	59c080e7          	jalr	1436(ra) # 800043e6 <namei>
    80005e52:	84aa                	mv	s1,a0
    80005e54:	c131                	beqz	a0,80005e98 <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80005e56:	ffffe097          	auipc	ra,0xffffe
    80005e5a:	dea080e7          	jalr	-534(ra) # 80003c40 <ilock>
  if(ip->type != T_DIR){
    80005e5e:	04449703          	lh	a4,68(s1)
    80005e62:	4785                	li	a5,1
    80005e64:	04f71063          	bne	a4,a5,80005ea4 <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80005e68:	8526                	mv	a0,s1
    80005e6a:	ffffe097          	auipc	ra,0xffffe
    80005e6e:	e98080e7          	jalr	-360(ra) # 80003d02 <iunlock>
  iput(p->cwd);
    80005e72:	15093503          	ld	a0,336(s2)
    80005e76:	ffffe097          	auipc	ra,0xffffe
    80005e7a:	f84080e7          	jalr	-124(ra) # 80003dfa <iput>
  end_op();
    80005e7e:	ffffe097          	auipc	ra,0xffffe
    80005e82:	7e2080e7          	jalr	2018(ra) # 80004660 <end_op>
  p->cwd = ip;
    80005e86:	14993823          	sd	s1,336(s2)
  return 0;
    80005e8a:	4501                	li	a0,0
}
    80005e8c:	60ea                	ld	ra,152(sp)
    80005e8e:	644a                	ld	s0,144(sp)
    80005e90:	64aa                	ld	s1,136(sp)
    80005e92:	690a                	ld	s2,128(sp)
    80005e94:	610d                	add	sp,sp,160
    80005e96:	8082                	ret
    end_op();
    80005e98:	ffffe097          	auipc	ra,0xffffe
    80005e9c:	7c8080e7          	jalr	1992(ra) # 80004660 <end_op>
    return -1;
    80005ea0:	557d                	li	a0,-1
    80005ea2:	b7ed                	j	80005e8c <sys_chdir+0x7a>
    iunlockput(ip);
    80005ea4:	8526                	mv	a0,s1
    80005ea6:	ffffe097          	auipc	ra,0xffffe
    80005eaa:	ffc080e7          	jalr	-4(ra) # 80003ea2 <iunlockput>
    end_op();
    80005eae:	ffffe097          	auipc	ra,0xffffe
    80005eb2:	7b2080e7          	jalr	1970(ra) # 80004660 <end_op>
    return -1;
    80005eb6:	557d                	li	a0,-1
    80005eb8:	bfd1                	j	80005e8c <sys_chdir+0x7a>

0000000080005eba <sys_exec>:

uint64
sys_exec(void)
{
    80005eba:	7121                	add	sp,sp,-448
    80005ebc:	ff06                	sd	ra,440(sp)
    80005ebe:	fb22                	sd	s0,432(sp)
    80005ec0:	f726                	sd	s1,424(sp)
    80005ec2:	f34a                	sd	s2,416(sp)
    80005ec4:	ef4e                	sd	s3,408(sp)
    80005ec6:	eb52                	sd	s4,400(sp)
    80005ec8:	0380                	add	s0,sp,448
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    80005eca:	e4840593          	add	a1,s0,-440
    80005ece:	4505                	li	a0,1
    80005ed0:	ffffd097          	auipc	ra,0xffffd
    80005ed4:	fbe080e7          	jalr	-66(ra) # 80002e8e <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    80005ed8:	08000613          	li	a2,128
    80005edc:	f5040593          	add	a1,s0,-176
    80005ee0:	4501                	li	a0,0
    80005ee2:	ffffd097          	auipc	ra,0xffffd
    80005ee6:	fcc080e7          	jalr	-52(ra) # 80002eae <argstr>
    80005eea:	87aa                	mv	a5,a0
    return -1;
    80005eec:	557d                	li	a0,-1
  if(argstr(0, path, MAXPATH) < 0) {
    80005eee:	0c07c263          	bltz	a5,80005fb2 <sys_exec+0xf8>
  }
  memset(argv, 0, sizeof(argv));
    80005ef2:	10000613          	li	a2,256
    80005ef6:	4581                	li	a1,0
    80005ef8:	e5040513          	add	a0,s0,-432
    80005efc:	ffffb097          	auipc	ra,0xffffb
    80005f00:	df4080e7          	jalr	-524(ra) # 80000cf0 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80005f04:	e5040493          	add	s1,s0,-432
  memset(argv, 0, sizeof(argv));
    80005f08:	89a6                	mv	s3,s1
    80005f0a:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    80005f0c:	02000a13          	li	s4,32
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80005f10:	00391513          	sll	a0,s2,0x3
    80005f14:	e4040593          	add	a1,s0,-448
    80005f18:	e4843783          	ld	a5,-440(s0)
    80005f1c:	953e                	add	a0,a0,a5
    80005f1e:	ffffd097          	auipc	ra,0xffffd
    80005f22:	eb2080e7          	jalr	-334(ra) # 80002dd0 <fetchaddr>
    80005f26:	02054a63          	bltz	a0,80005f5a <sys_exec+0xa0>
      goto bad;
    }
    if(uarg == 0){
    80005f2a:	e4043783          	ld	a5,-448(s0)
    80005f2e:	c3b9                	beqz	a5,80005f74 <sys_exec+0xba>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80005f30:	ffffb097          	auipc	ra,0xffffb
    80005f34:	bb2080e7          	jalr	-1102(ra) # 80000ae2 <kalloc>
    80005f38:	85aa                	mv	a1,a0
    80005f3a:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80005f3e:	cd11                	beqz	a0,80005f5a <sys_exec+0xa0>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80005f40:	6605                	lui	a2,0x1
    80005f42:	e4043503          	ld	a0,-448(s0)
    80005f46:	ffffd097          	auipc	ra,0xffffd
    80005f4a:	edc080e7          	jalr	-292(ra) # 80002e22 <fetchstr>
    80005f4e:	00054663          	bltz	a0,80005f5a <sys_exec+0xa0>
    if(i >= NELEM(argv)){
    80005f52:	0905                	add	s2,s2,1
    80005f54:	09a1                	add	s3,s3,8
    80005f56:	fb491de3          	bne	s2,s4,80005f10 <sys_exec+0x56>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005f5a:	f5040913          	add	s2,s0,-176
    80005f5e:	6088                	ld	a0,0(s1)
    80005f60:	c921                	beqz	a0,80005fb0 <sys_exec+0xf6>
    kfree(argv[i]);
    80005f62:	ffffb097          	auipc	ra,0xffffb
    80005f66:	a82080e7          	jalr	-1406(ra) # 800009e4 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005f6a:	04a1                	add	s1,s1,8
    80005f6c:	ff2499e3          	bne	s1,s2,80005f5e <sys_exec+0xa4>
  return -1;
    80005f70:	557d                	li	a0,-1
    80005f72:	a081                	j	80005fb2 <sys_exec+0xf8>
      argv[i] = 0;
    80005f74:	0009079b          	sext.w	a5,s2
    80005f78:	078e                	sll	a5,a5,0x3
    80005f7a:	fd078793          	add	a5,a5,-48
    80005f7e:	97a2                	add	a5,a5,s0
    80005f80:	e807b023          	sd	zero,-384(a5)
  int ret = exec(path, argv);
    80005f84:	e5040593          	add	a1,s0,-432
    80005f88:	f5040513          	add	a0,s0,-176
    80005f8c:	fffff097          	auipc	ra,0xfffff
    80005f90:	194080e7          	jalr	404(ra) # 80005120 <exec>
    80005f94:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005f96:	f5040993          	add	s3,s0,-176
    80005f9a:	6088                	ld	a0,0(s1)
    80005f9c:	c901                	beqz	a0,80005fac <sys_exec+0xf2>
    kfree(argv[i]);
    80005f9e:	ffffb097          	auipc	ra,0xffffb
    80005fa2:	a46080e7          	jalr	-1466(ra) # 800009e4 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005fa6:	04a1                	add	s1,s1,8
    80005fa8:	ff3499e3          	bne	s1,s3,80005f9a <sys_exec+0xe0>
  return ret;
    80005fac:	854a                	mv	a0,s2
    80005fae:	a011                	j	80005fb2 <sys_exec+0xf8>
  return -1;
    80005fb0:	557d                	li	a0,-1
}
    80005fb2:	70fa                	ld	ra,440(sp)
    80005fb4:	745a                	ld	s0,432(sp)
    80005fb6:	74ba                	ld	s1,424(sp)
    80005fb8:	791a                	ld	s2,416(sp)
    80005fba:	69fa                	ld	s3,408(sp)
    80005fbc:	6a5a                	ld	s4,400(sp)
    80005fbe:	6139                	add	sp,sp,448
    80005fc0:	8082                	ret

0000000080005fc2 <sys_pipe>:

uint64
sys_pipe(void)
{
    80005fc2:	7139                	add	sp,sp,-64
    80005fc4:	fc06                	sd	ra,56(sp)
    80005fc6:	f822                	sd	s0,48(sp)
    80005fc8:	f426                	sd	s1,40(sp)
    80005fca:	0080                	add	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80005fcc:	ffffc097          	auipc	ra,0xffffc
    80005fd0:	9fc080e7          	jalr	-1540(ra) # 800019c8 <myproc>
    80005fd4:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    80005fd6:	fd840593          	add	a1,s0,-40
    80005fda:	4501                	li	a0,0
    80005fdc:	ffffd097          	auipc	ra,0xffffd
    80005fe0:	eb2080e7          	jalr	-334(ra) # 80002e8e <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    80005fe4:	fc840593          	add	a1,s0,-56
    80005fe8:	fd040513          	add	a0,s0,-48
    80005fec:	fffff097          	auipc	ra,0xfffff
    80005ff0:	dea080e7          	jalr	-534(ra) # 80004dd6 <pipealloc>
    return -1;
    80005ff4:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80005ff6:	0c054463          	bltz	a0,800060be <sys_pipe+0xfc>
  fd0 = -1;
    80005ffa:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80005ffe:	fd043503          	ld	a0,-48(s0)
    80006002:	fffff097          	auipc	ra,0xfffff
    80006006:	524080e7          	jalr	1316(ra) # 80005526 <fdalloc>
    8000600a:	fca42223          	sw	a0,-60(s0)
    8000600e:	08054b63          	bltz	a0,800060a4 <sys_pipe+0xe2>
    80006012:	fc843503          	ld	a0,-56(s0)
    80006016:	fffff097          	auipc	ra,0xfffff
    8000601a:	510080e7          	jalr	1296(ra) # 80005526 <fdalloc>
    8000601e:	fca42023          	sw	a0,-64(s0)
    80006022:	06054863          	bltz	a0,80006092 <sys_pipe+0xd0>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80006026:	4691                	li	a3,4
    80006028:	fc440613          	add	a2,s0,-60
    8000602c:	fd843583          	ld	a1,-40(s0)
    80006030:	68a8                	ld	a0,80(s1)
    80006032:	ffffb097          	auipc	ra,0xffffb
    80006036:	656080e7          	jalr	1622(ra) # 80001688 <copyout>
    8000603a:	02054063          	bltz	a0,8000605a <sys_pipe+0x98>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    8000603e:	4691                	li	a3,4
    80006040:	fc040613          	add	a2,s0,-64
    80006044:	fd843583          	ld	a1,-40(s0)
    80006048:	0591                	add	a1,a1,4
    8000604a:	68a8                	ld	a0,80(s1)
    8000604c:	ffffb097          	auipc	ra,0xffffb
    80006050:	63c080e7          	jalr	1596(ra) # 80001688 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80006054:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80006056:	06055463          	bgez	a0,800060be <sys_pipe+0xfc>
    p->ofile[fd0] = 0;
    8000605a:	fc442783          	lw	a5,-60(s0)
    8000605e:	07e9                	add	a5,a5,26
    80006060:	078e                	sll	a5,a5,0x3
    80006062:	97a6                	add	a5,a5,s1
    80006064:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80006068:	fc042783          	lw	a5,-64(s0)
    8000606c:	07e9                	add	a5,a5,26
    8000606e:	078e                	sll	a5,a5,0x3
    80006070:	94be                	add	s1,s1,a5
    80006072:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    80006076:	fd043503          	ld	a0,-48(s0)
    8000607a:	fffff097          	auipc	ra,0xfffff
    8000607e:	a30080e7          	jalr	-1488(ra) # 80004aaa <fileclose>
    fileclose(wf);
    80006082:	fc843503          	ld	a0,-56(s0)
    80006086:	fffff097          	auipc	ra,0xfffff
    8000608a:	a24080e7          	jalr	-1500(ra) # 80004aaa <fileclose>
    return -1;
    8000608e:	57fd                	li	a5,-1
    80006090:	a03d                	j	800060be <sys_pipe+0xfc>
    if(fd0 >= 0)
    80006092:	fc442783          	lw	a5,-60(s0)
    80006096:	0007c763          	bltz	a5,800060a4 <sys_pipe+0xe2>
      p->ofile[fd0] = 0;
    8000609a:	07e9                	add	a5,a5,26
    8000609c:	078e                	sll	a5,a5,0x3
    8000609e:	97a6                	add	a5,a5,s1
    800060a0:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    800060a4:	fd043503          	ld	a0,-48(s0)
    800060a8:	fffff097          	auipc	ra,0xfffff
    800060ac:	a02080e7          	jalr	-1534(ra) # 80004aaa <fileclose>
    fileclose(wf);
    800060b0:	fc843503          	ld	a0,-56(s0)
    800060b4:	fffff097          	auipc	ra,0xfffff
    800060b8:	9f6080e7          	jalr	-1546(ra) # 80004aaa <fileclose>
    return -1;
    800060bc:	57fd                	li	a5,-1
}
    800060be:	853e                	mv	a0,a5
    800060c0:	70e2                	ld	ra,56(sp)
    800060c2:	7442                	ld	s0,48(sp)
    800060c4:	74a2                	ld	s1,40(sp)
    800060c6:	6121                	add	sp,sp,64
    800060c8:	8082                	ret
    800060ca:	0000                	unimp
    800060cc:	0000                	unimp
	...

00000000800060d0 <kernelvec>:
    800060d0:	7111                	add	sp,sp,-256
    800060d2:	e006                	sd	ra,0(sp)
    800060d4:	e40a                	sd	sp,8(sp)
    800060d6:	e80e                	sd	gp,16(sp)
    800060d8:	ec12                	sd	tp,24(sp)
    800060da:	f016                	sd	t0,32(sp)
    800060dc:	f41a                	sd	t1,40(sp)
    800060de:	f81e                	sd	t2,48(sp)
    800060e0:	fc22                	sd	s0,56(sp)
    800060e2:	e0a6                	sd	s1,64(sp)
    800060e4:	e4aa                	sd	a0,72(sp)
    800060e6:	e8ae                	sd	a1,80(sp)
    800060e8:	ecb2                	sd	a2,88(sp)
    800060ea:	f0b6                	sd	a3,96(sp)
    800060ec:	f4ba                	sd	a4,104(sp)
    800060ee:	f8be                	sd	a5,112(sp)
    800060f0:	fcc2                	sd	a6,120(sp)
    800060f2:	e146                	sd	a7,128(sp)
    800060f4:	e54a                	sd	s2,136(sp)
    800060f6:	e94e                	sd	s3,144(sp)
    800060f8:	ed52                	sd	s4,152(sp)
    800060fa:	f156                	sd	s5,160(sp)
    800060fc:	f55a                	sd	s6,168(sp)
    800060fe:	f95e                	sd	s7,176(sp)
    80006100:	fd62                	sd	s8,184(sp)
    80006102:	e1e6                	sd	s9,192(sp)
    80006104:	e5ea                	sd	s10,200(sp)
    80006106:	e9ee                	sd	s11,208(sp)
    80006108:	edf2                	sd	t3,216(sp)
    8000610a:	f1f6                	sd	t4,224(sp)
    8000610c:	f5fa                	sd	t5,232(sp)
    8000610e:	f9fe                	sd	t6,240(sp)
    80006110:	b8dfc0ef          	jal	80002c9c <kerneltrap>
    80006114:	6082                	ld	ra,0(sp)
    80006116:	6122                	ld	sp,8(sp)
    80006118:	61c2                	ld	gp,16(sp)
    8000611a:	7282                	ld	t0,32(sp)
    8000611c:	7322                	ld	t1,40(sp)
    8000611e:	73c2                	ld	t2,48(sp)
    80006120:	7462                	ld	s0,56(sp)
    80006122:	6486                	ld	s1,64(sp)
    80006124:	6526                	ld	a0,72(sp)
    80006126:	65c6                	ld	a1,80(sp)
    80006128:	6666                	ld	a2,88(sp)
    8000612a:	7686                	ld	a3,96(sp)
    8000612c:	7726                	ld	a4,104(sp)
    8000612e:	77c6                	ld	a5,112(sp)
    80006130:	7866                	ld	a6,120(sp)
    80006132:	688a                	ld	a7,128(sp)
    80006134:	692a                	ld	s2,136(sp)
    80006136:	69ca                	ld	s3,144(sp)
    80006138:	6a6a                	ld	s4,152(sp)
    8000613a:	7a8a                	ld	s5,160(sp)
    8000613c:	7b2a                	ld	s6,168(sp)
    8000613e:	7bca                	ld	s7,176(sp)
    80006140:	7c6a                	ld	s8,184(sp)
    80006142:	6c8e                	ld	s9,192(sp)
    80006144:	6d2e                	ld	s10,200(sp)
    80006146:	6dce                	ld	s11,208(sp)
    80006148:	6e6e                	ld	t3,216(sp)
    8000614a:	7e8e                	ld	t4,224(sp)
    8000614c:	7f2e                	ld	t5,232(sp)
    8000614e:	7fce                	ld	t6,240(sp)
    80006150:	6111                	add	sp,sp,256
    80006152:	10200073          	sret
    80006156:	00000013          	nop
    8000615a:	00000013          	nop
    8000615e:	0001                	nop

0000000080006160 <timervec>:
    80006160:	34051573          	csrrw	a0,mscratch,a0
    80006164:	e10c                	sd	a1,0(a0)
    80006166:	e510                	sd	a2,8(a0)
    80006168:	e914                	sd	a3,16(a0)
    8000616a:	6d0c                	ld	a1,24(a0)
    8000616c:	7110                	ld	a2,32(a0)
    8000616e:	6194                	ld	a3,0(a1)
    80006170:	96b2                	add	a3,a3,a2
    80006172:	e194                	sd	a3,0(a1)
    80006174:	4589                	li	a1,2
    80006176:	14459073          	csrw	sip,a1
    8000617a:	6914                	ld	a3,16(a0)
    8000617c:	6510                	ld	a2,8(a0)
    8000617e:	610c                	ld	a1,0(a0)
    80006180:	34051573          	csrrw	a0,mscratch,a0
    80006184:	30200073          	mret
	...

000000008000618a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000618a:	1141                	add	sp,sp,-16
    8000618c:	e422                	sd	s0,8(sp)
    8000618e:	0800                	add	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80006190:	0c0007b7          	lui	a5,0xc000
    80006194:	4705                	li	a4,1
    80006196:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80006198:	c3d8                	sw	a4,4(a5)
}
    8000619a:	6422                	ld	s0,8(sp)
    8000619c:	0141                	add	sp,sp,16
    8000619e:	8082                	ret

00000000800061a0 <plicinithart>:

void
plicinithart(void)
{
    800061a0:	1141                	add	sp,sp,-16
    800061a2:	e406                	sd	ra,8(sp)
    800061a4:	e022                	sd	s0,0(sp)
    800061a6:	0800                	add	s0,sp,16
  int hart = cpuid();
    800061a8:	ffffb097          	auipc	ra,0xffffb
    800061ac:	7f4080e7          	jalr	2036(ra) # 8000199c <cpuid>
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    800061b0:	0085171b          	sllw	a4,a0,0x8
    800061b4:	0c0027b7          	lui	a5,0xc002
    800061b8:	97ba                	add	a5,a5,a4
    800061ba:	40200713          	li	a4,1026
    800061be:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    800061c2:	00d5151b          	sllw	a0,a0,0xd
    800061c6:	0c2017b7          	lui	a5,0xc201
    800061ca:	97aa                	add	a5,a5,a0
    800061cc:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    800061d0:	60a2                	ld	ra,8(sp)
    800061d2:	6402                	ld	s0,0(sp)
    800061d4:	0141                	add	sp,sp,16
    800061d6:	8082                	ret

00000000800061d8 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    800061d8:	1141                	add	sp,sp,-16
    800061da:	e406                	sd	ra,8(sp)
    800061dc:	e022                	sd	s0,0(sp)
    800061de:	0800                	add	s0,sp,16
  int hart = cpuid();
    800061e0:	ffffb097          	auipc	ra,0xffffb
    800061e4:	7bc080e7          	jalr	1980(ra) # 8000199c <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    800061e8:	00d5151b          	sllw	a0,a0,0xd
    800061ec:	0c2017b7          	lui	a5,0xc201
    800061f0:	97aa                	add	a5,a5,a0
  return irq;
}
    800061f2:	43c8                	lw	a0,4(a5)
    800061f4:	60a2                	ld	ra,8(sp)
    800061f6:	6402                	ld	s0,0(sp)
    800061f8:	0141                	add	sp,sp,16
    800061fa:	8082                	ret

00000000800061fc <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    800061fc:	1101                	add	sp,sp,-32
    800061fe:	ec06                	sd	ra,24(sp)
    80006200:	e822                	sd	s0,16(sp)
    80006202:	e426                	sd	s1,8(sp)
    80006204:	1000                	add	s0,sp,32
    80006206:	84aa                	mv	s1,a0
  int hart = cpuid();
    80006208:	ffffb097          	auipc	ra,0xffffb
    8000620c:	794080e7          	jalr	1940(ra) # 8000199c <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80006210:	00d5151b          	sllw	a0,a0,0xd
    80006214:	0c2017b7          	lui	a5,0xc201
    80006218:	97aa                	add	a5,a5,a0
    8000621a:	c3c4                	sw	s1,4(a5)
}
    8000621c:	60e2                	ld	ra,24(sp)
    8000621e:	6442                	ld	s0,16(sp)
    80006220:	64a2                	ld	s1,8(sp)
    80006222:	6105                	add	sp,sp,32
    80006224:	8082                	ret

0000000080006226 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80006226:	1141                	add	sp,sp,-16
    80006228:	e406                	sd	ra,8(sp)
    8000622a:	e022                	sd	s0,0(sp)
    8000622c:	0800                	add	s0,sp,16
  if(i >= NUM)
    8000622e:	479d                	li	a5,7
    80006230:	04a7cc63          	blt	a5,a0,80006288 <free_desc+0x62>
    panic("free_desc 1");
  if(disk.free[i])
    80006234:	0001c797          	auipc	a5,0x1c
    80006238:	cec78793          	add	a5,a5,-788 # 80021f20 <disk>
    8000623c:	97aa                	add	a5,a5,a0
    8000623e:	0187c783          	lbu	a5,24(a5)
    80006242:	ebb9                	bnez	a5,80006298 <free_desc+0x72>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80006244:	00451693          	sll	a3,a0,0x4
    80006248:	0001c797          	auipc	a5,0x1c
    8000624c:	cd878793          	add	a5,a5,-808 # 80021f20 <disk>
    80006250:	6398                	ld	a4,0(a5)
    80006252:	9736                	add	a4,a4,a3
    80006254:	00073023          	sd	zero,0(a4)
  disk.desc[i].len = 0;
    80006258:	6398                	ld	a4,0(a5)
    8000625a:	9736                	add	a4,a4,a3
    8000625c:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    80006260:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    80006264:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    80006268:	97aa                	add	a5,a5,a0
    8000626a:	4705                	li	a4,1
    8000626c:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    80006270:	0001c517          	auipc	a0,0x1c
    80006274:	cc850513          	add	a0,a0,-824 # 80021f38 <disk+0x18>
    80006278:	ffffc097          	auipc	ra,0xffffc
    8000627c:	e84080e7          	jalr	-380(ra) # 800020fc <wakeup>
}
    80006280:	60a2                	ld	ra,8(sp)
    80006282:	6402                	ld	s0,0(sp)
    80006284:	0141                	add	sp,sp,16
    80006286:	8082                	ret
    panic("free_desc 1");
    80006288:	00002517          	auipc	a0,0x2
    8000628c:	58050513          	add	a0,a0,1408 # 80008808 <syscalls+0x380>
    80006290:	ffffa097          	auipc	ra,0xffffa
    80006294:	2ac080e7          	jalr	684(ra) # 8000053c <panic>
    panic("free_desc 2");
    80006298:	00002517          	auipc	a0,0x2
    8000629c:	58050513          	add	a0,a0,1408 # 80008818 <syscalls+0x390>
    800062a0:	ffffa097          	auipc	ra,0xffffa
    800062a4:	29c080e7          	jalr	668(ra) # 8000053c <panic>

00000000800062a8 <virtio_disk_init>:
{
    800062a8:	1101                	add	sp,sp,-32
    800062aa:	ec06                	sd	ra,24(sp)
    800062ac:	e822                	sd	s0,16(sp)
    800062ae:	e426                	sd	s1,8(sp)
    800062b0:	e04a                	sd	s2,0(sp)
    800062b2:	1000                	add	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    800062b4:	00002597          	auipc	a1,0x2
    800062b8:	57458593          	add	a1,a1,1396 # 80008828 <syscalls+0x3a0>
    800062bc:	0001c517          	auipc	a0,0x1c
    800062c0:	d8c50513          	add	a0,a0,-628 # 80022048 <disk+0x128>
    800062c4:	ffffb097          	auipc	ra,0xffffb
    800062c8:	8a0080e7          	jalr	-1888(ra) # 80000b64 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800062cc:	100017b7          	lui	a5,0x10001
    800062d0:	4398                	lw	a4,0(a5)
    800062d2:	2701                	sext.w	a4,a4
    800062d4:	747277b7          	lui	a5,0x74727
    800062d8:	97678793          	add	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    800062dc:	14f71b63          	bne	a4,a5,80006432 <virtio_disk_init+0x18a>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    800062e0:	100017b7          	lui	a5,0x10001
    800062e4:	43dc                	lw	a5,4(a5)
    800062e6:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800062e8:	4709                	li	a4,2
    800062ea:	14e79463          	bne	a5,a4,80006432 <virtio_disk_init+0x18a>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800062ee:	100017b7          	lui	a5,0x10001
    800062f2:	479c                	lw	a5,8(a5)
    800062f4:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    800062f6:	12e79e63          	bne	a5,a4,80006432 <virtio_disk_init+0x18a>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    800062fa:	100017b7          	lui	a5,0x10001
    800062fe:	47d8                	lw	a4,12(a5)
    80006300:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80006302:	554d47b7          	lui	a5,0x554d4
    80006306:	55178793          	add	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    8000630a:	12f71463          	bne	a4,a5,80006432 <virtio_disk_init+0x18a>
  *R(VIRTIO_MMIO_STATUS) = status;
    8000630e:	100017b7          	lui	a5,0x10001
    80006312:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    80006316:	4705                	li	a4,1
    80006318:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000631a:	470d                	li	a4,3
    8000631c:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    8000631e:	4b98                	lw	a4,16(a5)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80006320:	c7ffe6b7          	lui	a3,0xc7ffe
    80006324:	75f68693          	add	a3,a3,1887 # ffffffffc7ffe75f <end+0xffffffff47fdc6e7>
    80006328:	8f75                	and	a4,a4,a3
    8000632a:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000632c:	472d                	li	a4,11
    8000632e:	dbb8                	sw	a4,112(a5)
  status = *R(VIRTIO_MMIO_STATUS);
    80006330:	5bbc                	lw	a5,112(a5)
    80006332:	0007891b          	sext.w	s2,a5
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    80006336:	8ba1                	and	a5,a5,8
    80006338:	10078563          	beqz	a5,80006442 <virtio_disk_init+0x19a>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    8000633c:	100017b7          	lui	a5,0x10001
    80006340:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    80006344:	43fc                	lw	a5,68(a5)
    80006346:	2781                	sext.w	a5,a5
    80006348:	10079563          	bnez	a5,80006452 <virtio_disk_init+0x1aa>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    8000634c:	100017b7          	lui	a5,0x10001
    80006350:	5bdc                	lw	a5,52(a5)
    80006352:	2781                	sext.w	a5,a5
  if(max == 0)
    80006354:	10078763          	beqz	a5,80006462 <virtio_disk_init+0x1ba>
  if(max < NUM)
    80006358:	471d                	li	a4,7
    8000635a:	10f77c63          	bgeu	a4,a5,80006472 <virtio_disk_init+0x1ca>
  disk.desc = kalloc();
    8000635e:	ffffa097          	auipc	ra,0xffffa
    80006362:	784080e7          	jalr	1924(ra) # 80000ae2 <kalloc>
    80006366:	0001c497          	auipc	s1,0x1c
    8000636a:	bba48493          	add	s1,s1,-1094 # 80021f20 <disk>
    8000636e:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    80006370:	ffffa097          	auipc	ra,0xffffa
    80006374:	772080e7          	jalr	1906(ra) # 80000ae2 <kalloc>
    80006378:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    8000637a:	ffffa097          	auipc	ra,0xffffa
    8000637e:	768080e7          	jalr	1896(ra) # 80000ae2 <kalloc>
    80006382:	87aa                	mv	a5,a0
    80006384:	e888                	sd	a0,16(s1)
  if(!disk.desc || !disk.avail || !disk.used)
    80006386:	6088                	ld	a0,0(s1)
    80006388:	cd6d                	beqz	a0,80006482 <virtio_disk_init+0x1da>
    8000638a:	0001c717          	auipc	a4,0x1c
    8000638e:	b9e73703          	ld	a4,-1122(a4) # 80021f28 <disk+0x8>
    80006392:	cb65                	beqz	a4,80006482 <virtio_disk_init+0x1da>
    80006394:	c7fd                	beqz	a5,80006482 <virtio_disk_init+0x1da>
  memset(disk.desc, 0, PGSIZE);
    80006396:	6605                	lui	a2,0x1
    80006398:	4581                	li	a1,0
    8000639a:	ffffb097          	auipc	ra,0xffffb
    8000639e:	956080e7          	jalr	-1706(ra) # 80000cf0 <memset>
  memset(disk.avail, 0, PGSIZE);
    800063a2:	0001c497          	auipc	s1,0x1c
    800063a6:	b7e48493          	add	s1,s1,-1154 # 80021f20 <disk>
    800063aa:	6605                	lui	a2,0x1
    800063ac:	4581                	li	a1,0
    800063ae:	6488                	ld	a0,8(s1)
    800063b0:	ffffb097          	auipc	ra,0xffffb
    800063b4:	940080e7          	jalr	-1728(ra) # 80000cf0 <memset>
  memset(disk.used, 0, PGSIZE);
    800063b8:	6605                	lui	a2,0x1
    800063ba:	4581                	li	a1,0
    800063bc:	6888                	ld	a0,16(s1)
    800063be:	ffffb097          	auipc	ra,0xffffb
    800063c2:	932080e7          	jalr	-1742(ra) # 80000cf0 <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    800063c6:	100017b7          	lui	a5,0x10001
    800063ca:	4721                	li	a4,8
    800063cc:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    800063ce:	4098                	lw	a4,0(s1)
    800063d0:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    800063d4:	40d8                	lw	a4,4(s1)
    800063d6:	08e7a223          	sw	a4,132(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    800063da:	6498                	ld	a4,8(s1)
    800063dc:	0007069b          	sext.w	a3,a4
    800063e0:	08d7a823          	sw	a3,144(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    800063e4:	9701                	sra	a4,a4,0x20
    800063e6:	08e7aa23          	sw	a4,148(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    800063ea:	6898                	ld	a4,16(s1)
    800063ec:	0007069b          	sext.w	a3,a4
    800063f0:	0ad7a023          	sw	a3,160(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    800063f4:	9701                	sra	a4,a4,0x20
    800063f6:	0ae7a223          	sw	a4,164(a5)
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    800063fa:	4705                	li	a4,1
    800063fc:	c3f8                	sw	a4,68(a5)
    disk.free[i] = 1;
    800063fe:	00e48c23          	sb	a4,24(s1)
    80006402:	00e48ca3          	sb	a4,25(s1)
    80006406:	00e48d23          	sb	a4,26(s1)
    8000640a:	00e48da3          	sb	a4,27(s1)
    8000640e:	00e48e23          	sb	a4,28(s1)
    80006412:	00e48ea3          	sb	a4,29(s1)
    80006416:	00e48f23          	sb	a4,30(s1)
    8000641a:	00e48fa3          	sb	a4,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    8000641e:	00496913          	or	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    80006422:	0727a823          	sw	s2,112(a5)
}
    80006426:	60e2                	ld	ra,24(sp)
    80006428:	6442                	ld	s0,16(sp)
    8000642a:	64a2                	ld	s1,8(sp)
    8000642c:	6902                	ld	s2,0(sp)
    8000642e:	6105                	add	sp,sp,32
    80006430:	8082                	ret
    panic("could not find virtio disk");
    80006432:	00002517          	auipc	a0,0x2
    80006436:	40650513          	add	a0,a0,1030 # 80008838 <syscalls+0x3b0>
    8000643a:	ffffa097          	auipc	ra,0xffffa
    8000643e:	102080e7          	jalr	258(ra) # 8000053c <panic>
    panic("virtio disk FEATURES_OK unset");
    80006442:	00002517          	auipc	a0,0x2
    80006446:	41650513          	add	a0,a0,1046 # 80008858 <syscalls+0x3d0>
    8000644a:	ffffa097          	auipc	ra,0xffffa
    8000644e:	0f2080e7          	jalr	242(ra) # 8000053c <panic>
    panic("virtio disk should not be ready");
    80006452:	00002517          	auipc	a0,0x2
    80006456:	42650513          	add	a0,a0,1062 # 80008878 <syscalls+0x3f0>
    8000645a:	ffffa097          	auipc	ra,0xffffa
    8000645e:	0e2080e7          	jalr	226(ra) # 8000053c <panic>
    panic("virtio disk has no queue 0");
    80006462:	00002517          	auipc	a0,0x2
    80006466:	43650513          	add	a0,a0,1078 # 80008898 <syscalls+0x410>
    8000646a:	ffffa097          	auipc	ra,0xffffa
    8000646e:	0d2080e7          	jalr	210(ra) # 8000053c <panic>
    panic("virtio disk max queue too short");
    80006472:	00002517          	auipc	a0,0x2
    80006476:	44650513          	add	a0,a0,1094 # 800088b8 <syscalls+0x430>
    8000647a:	ffffa097          	auipc	ra,0xffffa
    8000647e:	0c2080e7          	jalr	194(ra) # 8000053c <panic>
    panic("virtio disk kalloc");
    80006482:	00002517          	auipc	a0,0x2
    80006486:	45650513          	add	a0,a0,1110 # 800088d8 <syscalls+0x450>
    8000648a:	ffffa097          	auipc	ra,0xffffa
    8000648e:	0b2080e7          	jalr	178(ra) # 8000053c <panic>

0000000080006492 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80006492:	7159                	add	sp,sp,-112
    80006494:	f486                	sd	ra,104(sp)
    80006496:	f0a2                	sd	s0,96(sp)
    80006498:	eca6                	sd	s1,88(sp)
    8000649a:	e8ca                	sd	s2,80(sp)
    8000649c:	e4ce                	sd	s3,72(sp)
    8000649e:	e0d2                	sd	s4,64(sp)
    800064a0:	fc56                	sd	s5,56(sp)
    800064a2:	f85a                	sd	s6,48(sp)
    800064a4:	f45e                	sd	s7,40(sp)
    800064a6:	f062                	sd	s8,32(sp)
    800064a8:	ec66                	sd	s9,24(sp)
    800064aa:	e86a                	sd	s10,16(sp)
    800064ac:	1880                	add	s0,sp,112
    800064ae:	8a2a                	mv	s4,a0
    800064b0:	8bae                	mv	s7,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    800064b2:	00c52c83          	lw	s9,12(a0)
    800064b6:	001c9c9b          	sllw	s9,s9,0x1
    800064ba:	1c82                	sll	s9,s9,0x20
    800064bc:	020cdc93          	srl	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    800064c0:	0001c517          	auipc	a0,0x1c
    800064c4:	b8850513          	add	a0,a0,-1144 # 80022048 <disk+0x128>
    800064c8:	ffffa097          	auipc	ra,0xffffa
    800064cc:	72c080e7          	jalr	1836(ra) # 80000bf4 <acquire>
  for(int i = 0; i < 3; i++){
    800064d0:	4901                	li	s2,0
  for(int i = 0; i < NUM; i++){
    800064d2:	44a1                	li	s1,8
      disk.free[i] = 0;
    800064d4:	0001cb17          	auipc	s6,0x1c
    800064d8:	a4cb0b13          	add	s6,s6,-1460 # 80021f20 <disk>
  for(int i = 0; i < 3; i++){
    800064dc:	4a8d                	li	s5,3
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    800064de:	0001cc17          	auipc	s8,0x1c
    800064e2:	b6ac0c13          	add	s8,s8,-1174 # 80022048 <disk+0x128>
    800064e6:	a095                	j	8000654a <virtio_disk_rw+0xb8>
      disk.free[i] = 0;
    800064e8:	00fb0733          	add	a4,s6,a5
    800064ec:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    800064f0:	c11c                	sw	a5,0(a0)
    if(idx[i] < 0){
    800064f2:	0207c563          	bltz	a5,8000651c <virtio_disk_rw+0x8a>
  for(int i = 0; i < 3; i++){
    800064f6:	2605                	addw	a2,a2,1 # 1001 <_entry-0x7fffefff>
    800064f8:	0591                	add	a1,a1,4
    800064fa:	05560d63          	beq	a2,s5,80006554 <virtio_disk_rw+0xc2>
    idx[i] = alloc_desc();
    800064fe:	852e                	mv	a0,a1
  for(int i = 0; i < NUM; i++){
    80006500:	0001c717          	auipc	a4,0x1c
    80006504:	a2070713          	add	a4,a4,-1504 # 80021f20 <disk>
    80006508:	87ca                	mv	a5,s2
    if(disk.free[i]){
    8000650a:	01874683          	lbu	a3,24(a4)
    8000650e:	fee9                	bnez	a3,800064e8 <virtio_disk_rw+0x56>
  for(int i = 0; i < NUM; i++){
    80006510:	2785                	addw	a5,a5,1
    80006512:	0705                	add	a4,a4,1
    80006514:	fe979be3          	bne	a5,s1,8000650a <virtio_disk_rw+0x78>
    idx[i] = alloc_desc();
    80006518:	57fd                	li	a5,-1
    8000651a:	c11c                	sw	a5,0(a0)
      for(int j = 0; j < i; j++)
    8000651c:	00c05e63          	blez	a2,80006538 <virtio_disk_rw+0xa6>
    80006520:	060a                	sll	a2,a2,0x2
    80006522:	01360d33          	add	s10,a2,s3
        free_desc(idx[j]);
    80006526:	0009a503          	lw	a0,0(s3)
    8000652a:	00000097          	auipc	ra,0x0
    8000652e:	cfc080e7          	jalr	-772(ra) # 80006226 <free_desc>
      for(int j = 0; j < i; j++)
    80006532:	0991                	add	s3,s3,4
    80006534:	ffa999e3          	bne	s3,s10,80006526 <virtio_disk_rw+0x94>
    sleep(&disk.free[0], &disk.vdisk_lock);
    80006538:	85e2                	mv	a1,s8
    8000653a:	0001c517          	auipc	a0,0x1c
    8000653e:	9fe50513          	add	a0,a0,-1538 # 80021f38 <disk+0x18>
    80006542:	ffffc097          	auipc	ra,0xffffc
    80006546:	b56080e7          	jalr	-1194(ra) # 80002098 <sleep>
  for(int i = 0; i < 3; i++){
    8000654a:	f9040993          	add	s3,s0,-112
{
    8000654e:	85ce                	mv	a1,s3
  for(int i = 0; i < 3; i++){
    80006550:	864a                	mv	a2,s2
    80006552:	b775                	j	800064fe <virtio_disk_rw+0x6c>
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80006554:	f9042503          	lw	a0,-112(s0)
    80006558:	00a50713          	add	a4,a0,10
    8000655c:	0712                	sll	a4,a4,0x4

  if(write)
    8000655e:	0001c797          	auipc	a5,0x1c
    80006562:	9c278793          	add	a5,a5,-1598 # 80021f20 <disk>
    80006566:	00e786b3          	add	a3,a5,a4
    8000656a:	01703633          	snez	a2,s7
    8000656e:	c690                	sw	a2,8(a3)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    80006570:	0006a623          	sw	zero,12(a3)
  buf0->sector = sector;
    80006574:	0196b823          	sd	s9,16(a3)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80006578:	f6070613          	add	a2,a4,-160
    8000657c:	6394                	ld	a3,0(a5)
    8000657e:	96b2                	add	a3,a3,a2
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80006580:	00870593          	add	a1,a4,8
    80006584:	95be                	add	a1,a1,a5
  disk.desc[idx[0]].addr = (uint64) buf0;
    80006586:	e28c                	sd	a1,0(a3)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80006588:	0007b803          	ld	a6,0(a5)
    8000658c:	9642                	add	a2,a2,a6
    8000658e:	46c1                	li	a3,16
    80006590:	c614                	sw	a3,8(a2)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80006592:	4585                	li	a1,1
    80006594:	00b61623          	sh	a1,12(a2)
  disk.desc[idx[0]].next = idx[1];
    80006598:	f9442683          	lw	a3,-108(s0)
    8000659c:	00d61723          	sh	a3,14(a2)

  disk.desc[idx[1]].addr = (uint64) b->data;
    800065a0:	0692                	sll	a3,a3,0x4
    800065a2:	9836                	add	a6,a6,a3
    800065a4:	058a0613          	add	a2,s4,88
    800065a8:	00c83023          	sd	a2,0(a6)
  disk.desc[idx[1]].len = BSIZE;
    800065ac:	0007b803          	ld	a6,0(a5)
    800065b0:	96c2                	add	a3,a3,a6
    800065b2:	40000613          	li	a2,1024
    800065b6:	c690                	sw	a2,8(a3)
  if(write)
    800065b8:	001bb613          	seqz	a2,s7
    800065bc:	0016161b          	sllw	a2,a2,0x1
    disk.desc[idx[1]].flags = 0; // device reads b->data
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    800065c0:	00166613          	or	a2,a2,1
    800065c4:	00c69623          	sh	a2,12(a3)
  disk.desc[idx[1]].next = idx[2];
    800065c8:	f9842603          	lw	a2,-104(s0)
    800065cc:	00c69723          	sh	a2,14(a3)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    800065d0:	00250693          	add	a3,a0,2
    800065d4:	0692                	sll	a3,a3,0x4
    800065d6:	96be                	add	a3,a3,a5
    800065d8:	58fd                	li	a7,-1
    800065da:	01168823          	sb	a7,16(a3)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    800065de:	0612                	sll	a2,a2,0x4
    800065e0:	9832                	add	a6,a6,a2
    800065e2:	f9070713          	add	a4,a4,-112
    800065e6:	973e                	add	a4,a4,a5
    800065e8:	00e83023          	sd	a4,0(a6)
  disk.desc[idx[2]].len = 1;
    800065ec:	6398                	ld	a4,0(a5)
    800065ee:	9732                	add	a4,a4,a2
    800065f0:	c70c                	sw	a1,8(a4)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    800065f2:	4609                	li	a2,2
    800065f4:	00c71623          	sh	a2,12(a4)
  disk.desc[idx[2]].next = 0;
    800065f8:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    800065fc:	00ba2223          	sw	a1,4(s4)
  disk.info[idx[0]].b = b;
    80006600:	0146b423          	sd	s4,8(a3)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80006604:	6794                	ld	a3,8(a5)
    80006606:	0026d703          	lhu	a4,2(a3)
    8000660a:	8b1d                	and	a4,a4,7
    8000660c:	0706                	sll	a4,a4,0x1
    8000660e:	96ba                	add	a3,a3,a4
    80006610:	00a69223          	sh	a0,4(a3)

  __sync_synchronize();
    80006614:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80006618:	6798                	ld	a4,8(a5)
    8000661a:	00275783          	lhu	a5,2(a4)
    8000661e:	2785                	addw	a5,a5,1
    80006620:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80006624:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80006628:	100017b7          	lui	a5,0x10001
    8000662c:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80006630:	004a2783          	lw	a5,4(s4)
    sleep(b, &disk.vdisk_lock);
    80006634:	0001c917          	auipc	s2,0x1c
    80006638:	a1490913          	add	s2,s2,-1516 # 80022048 <disk+0x128>
  while(b->disk == 1) {
    8000663c:	4485                	li	s1,1
    8000663e:	00b79c63          	bne	a5,a1,80006656 <virtio_disk_rw+0x1c4>
    sleep(b, &disk.vdisk_lock);
    80006642:	85ca                	mv	a1,s2
    80006644:	8552                	mv	a0,s4
    80006646:	ffffc097          	auipc	ra,0xffffc
    8000664a:	a52080e7          	jalr	-1454(ra) # 80002098 <sleep>
  while(b->disk == 1) {
    8000664e:	004a2783          	lw	a5,4(s4)
    80006652:	fe9788e3          	beq	a5,s1,80006642 <virtio_disk_rw+0x1b0>
  }

  disk.info[idx[0]].b = 0;
    80006656:	f9042903          	lw	s2,-112(s0)
    8000665a:	00290713          	add	a4,s2,2
    8000665e:	0712                	sll	a4,a4,0x4
    80006660:	0001c797          	auipc	a5,0x1c
    80006664:	8c078793          	add	a5,a5,-1856 # 80021f20 <disk>
    80006668:	97ba                	add	a5,a5,a4
    8000666a:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    8000666e:	0001c997          	auipc	s3,0x1c
    80006672:	8b298993          	add	s3,s3,-1870 # 80021f20 <disk>
    80006676:	00491713          	sll	a4,s2,0x4
    8000667a:	0009b783          	ld	a5,0(s3)
    8000667e:	97ba                	add	a5,a5,a4
    80006680:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80006684:	854a                	mv	a0,s2
    80006686:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    8000668a:	00000097          	auipc	ra,0x0
    8000668e:	b9c080e7          	jalr	-1124(ra) # 80006226 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80006692:	8885                	and	s1,s1,1
    80006694:	f0ed                	bnez	s1,80006676 <virtio_disk_rw+0x1e4>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80006696:	0001c517          	auipc	a0,0x1c
    8000669a:	9b250513          	add	a0,a0,-1614 # 80022048 <disk+0x128>
    8000669e:	ffffa097          	auipc	ra,0xffffa
    800066a2:	60a080e7          	jalr	1546(ra) # 80000ca8 <release>
}
    800066a6:	70a6                	ld	ra,104(sp)
    800066a8:	7406                	ld	s0,96(sp)
    800066aa:	64e6                	ld	s1,88(sp)
    800066ac:	6946                	ld	s2,80(sp)
    800066ae:	69a6                	ld	s3,72(sp)
    800066b0:	6a06                	ld	s4,64(sp)
    800066b2:	7ae2                	ld	s5,56(sp)
    800066b4:	7b42                	ld	s6,48(sp)
    800066b6:	7ba2                	ld	s7,40(sp)
    800066b8:	7c02                	ld	s8,32(sp)
    800066ba:	6ce2                	ld	s9,24(sp)
    800066bc:	6d42                	ld	s10,16(sp)
    800066be:	6165                	add	sp,sp,112
    800066c0:	8082                	ret

00000000800066c2 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    800066c2:	1101                	add	sp,sp,-32
    800066c4:	ec06                	sd	ra,24(sp)
    800066c6:	e822                	sd	s0,16(sp)
    800066c8:	e426                	sd	s1,8(sp)
    800066ca:	1000                	add	s0,sp,32
  acquire(&disk.vdisk_lock);
    800066cc:	0001c497          	auipc	s1,0x1c
    800066d0:	85448493          	add	s1,s1,-1964 # 80021f20 <disk>
    800066d4:	0001c517          	auipc	a0,0x1c
    800066d8:	97450513          	add	a0,a0,-1676 # 80022048 <disk+0x128>
    800066dc:	ffffa097          	auipc	ra,0xffffa
    800066e0:	518080e7          	jalr	1304(ra) # 80000bf4 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    800066e4:	10001737          	lui	a4,0x10001
    800066e8:	533c                	lw	a5,96(a4)
    800066ea:	8b8d                	and	a5,a5,3
    800066ec:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    800066ee:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    800066f2:	689c                	ld	a5,16(s1)
    800066f4:	0204d703          	lhu	a4,32(s1)
    800066f8:	0027d783          	lhu	a5,2(a5)
    800066fc:	04f70863          	beq	a4,a5,8000674c <virtio_disk_intr+0x8a>
    __sync_synchronize();
    80006700:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80006704:	6898                	ld	a4,16(s1)
    80006706:	0204d783          	lhu	a5,32(s1)
    8000670a:	8b9d                	and	a5,a5,7
    8000670c:	078e                	sll	a5,a5,0x3
    8000670e:	97ba                	add	a5,a5,a4
    80006710:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80006712:	00278713          	add	a4,a5,2
    80006716:	0712                	sll	a4,a4,0x4
    80006718:	9726                	add	a4,a4,s1
    8000671a:	01074703          	lbu	a4,16(a4) # 10001010 <_entry-0x6fffeff0>
    8000671e:	e721                	bnez	a4,80006766 <virtio_disk_intr+0xa4>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80006720:	0789                	add	a5,a5,2
    80006722:	0792                	sll	a5,a5,0x4
    80006724:	97a6                	add	a5,a5,s1
    80006726:	6788                	ld	a0,8(a5)
    b->disk = 0;   // disk is done with buf
    80006728:	00052223          	sw	zero,4(a0)
    wakeup(b);
    8000672c:	ffffc097          	auipc	ra,0xffffc
    80006730:	9d0080e7          	jalr	-1584(ra) # 800020fc <wakeup>

    disk.used_idx += 1;
    80006734:	0204d783          	lhu	a5,32(s1)
    80006738:	2785                	addw	a5,a5,1
    8000673a:	17c2                	sll	a5,a5,0x30
    8000673c:	93c1                	srl	a5,a5,0x30
    8000673e:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80006742:	6898                	ld	a4,16(s1)
    80006744:	00275703          	lhu	a4,2(a4)
    80006748:	faf71ce3          	bne	a4,a5,80006700 <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    8000674c:	0001c517          	auipc	a0,0x1c
    80006750:	8fc50513          	add	a0,a0,-1796 # 80022048 <disk+0x128>
    80006754:	ffffa097          	auipc	ra,0xffffa
    80006758:	554080e7          	jalr	1364(ra) # 80000ca8 <release>
}
    8000675c:	60e2                	ld	ra,24(sp)
    8000675e:	6442                	ld	s0,16(sp)
    80006760:	64a2                	ld	s1,8(sp)
    80006762:	6105                	add	sp,sp,32
    80006764:	8082                	ret
      panic("virtio_disk_intr status");
    80006766:	00002517          	auipc	a0,0x2
    8000676a:	18a50513          	add	a0,a0,394 # 800088f0 <syscalls+0x468>
    8000676e:	ffffa097          	auipc	ra,0xffffa
    80006772:	dce080e7          	jalr	-562(ra) # 8000053c <panic>

0000000080006776 <rcu_read_unlock>:
#include "defs.h"
#include "param.h"
#include "spinlock.h"
#include "proc.h"

void rcu_read_unlock() {
    80006776:	1141                	add	sp,sp,-16
    80006778:	e406                	sd	ra,8(sp)
    8000677a:	e022                	sd	s0,0(sp)
    8000677c:	0800                	add	s0,sp,16
    pop_off();
    8000677e:	ffffa097          	auipc	ra,0xffffa
    80006782:	4ca080e7          	jalr	1226(ra) # 80000c48 <pop_off>
}
    80006786:	60a2                	ld	ra,8(sp)
    80006788:	6402                	ld	s0,0(sp)
    8000678a:	0141                	add	sp,sp,16
    8000678c:	8082                	ret

000000008000678e <rcu_read_lock>:

void rcu_read_lock()
{
    8000678e:	1141                	add	sp,sp,-16
    80006790:	e406                	sd	ra,8(sp)
    80006792:	e022                	sd	s0,0(sp)
    80006794:	0800                	add	s0,sp,16
    push_off();
    80006796:	ffffa097          	auipc	ra,0xffffa
    8000679a:	412080e7          	jalr	1042(ra) # 80000ba8 <push_off>
}
    8000679e:	60a2                	ld	ra,8(sp)
    800067a0:	6402                	ld	s0,0(sp)
    800067a2:	0141                	add	sp,sp,16
    800067a4:	8082                	ret

00000000800067a6 <synchronize_rcu>:

void synchronize_rcu() {
    800067a6:	1101                	add	sp,sp,-32
    800067a8:	ec06                	sd	ra,24(sp)
    800067aa:	e822                	sd	s0,16(sp)
    800067ac:	e426                	sd	s1,8(sp)
    800067ae:	1000                	add	s0,sp,32
    int i = 0;
    struct proc *p = myproc();
    800067b0:	ffffb097          	auipc	ra,0xffffb
    800067b4:	218080e7          	jalr	536(ra) # 800019c8 <myproc>
    800067b8:	84aa                	mv	s1,a0
    // how to identify number of CPUs running ?
    while (i < 3) {
        p->cpu_affinity =  i++;
    800067ba:	16052423          	sw	zero,360(a0)
        yield();
    800067be:	ffffc097          	auipc	ra,0xffffc
    800067c2:	89e080e7          	jalr	-1890(ra) # 8000205c <yield>
        p->cpu_affinity =  i++;
    800067c6:	4785                	li	a5,1
    800067c8:	16f4a423          	sw	a5,360(s1)
        yield();
    800067cc:	ffffc097          	auipc	ra,0xffffc
    800067d0:	890080e7          	jalr	-1904(ra) # 8000205c <yield>
        p->cpu_affinity =  i++;
    800067d4:	4789                	li	a5,2
    800067d6:	16f4a423          	sw	a5,360(s1)
        yield();
    800067da:	ffffc097          	auipc	ra,0xffffc
    800067de:	882080e7          	jalr	-1918(ra) # 8000205c <yield>
    }
    p->cpu_affinity = -1;
    800067e2:	57fd                	li	a5,-1
    800067e4:	16f4a423          	sw	a5,360(s1)
}
    800067e8:	60e2                	ld	ra,24(sp)
    800067ea:	6442                	ld	s0,16(sp)
    800067ec:	64a2                	ld	s1,8(sp)
    800067ee:	6105                	add	sp,sp,32
    800067f0:	8082                	ret

00000000800067f2 <rw_lock_init>:

#define NUM_COUNTERS 16

//init the lock
// called by the thread running the benchmark before any child threads are spawned.
void rw_lock_init(struct ReaderWriterLock *rwlock) {
    800067f2:	1141                	add	sp,sp,-16
    800067f4:	e422                	sd	s0,8(sp)
    800067f6:	0800                	add	s0,sp,16
  rwlock->readers = 0;
    800067f8:	00053023          	sd	zero,0(a0)
  rwlock->writer = 0;
    800067fc:	00052423          	sw	zero,8(a0)
}
    80006800:	6422                	ld	s0,8(sp)
    80006802:	0141                	add	sp,sp,16
    80006804:	8082                	ret

0000000080006806 <read_lock>:
 * Readers should add themselves to the read counter,
 * then check if a writer is waiting
 * If a writer is waiting, decrement the counter and wait for the writer to finish
 * then retry
 */
void read_lock(struct ReaderWriterLock *rwlock, uint8 thread_id) {
    80006806:	1141                	add	sp,sp,-16
    80006808:	e422                	sd	s0,8(sp)
    8000680a:	0800                	add	s0,sp,16
  //acq read lock
  while (1){

    //atomic_add_fetch returns current value, but not needed
    __atomic_add_fetch(&rwlock->readers, 1, __ATOMIC_SEQ_CST);
    8000680c:	4705                	li	a4,1


    if (rwlock->writer){
      //cancel
      __atomic_add_fetch(&rwlock->readers, -1, __ATOMIC_SEQ_CST);
    8000680e:	56fd                	li	a3,-1
    __atomic_add_fetch(&rwlock->readers, 1, __ATOMIC_SEQ_CST);
    80006810:	0f50000f          	fence	iorw,ow
    80006814:	04e5302f          	amoadd.d.aq	zero,a4,(a0)
    if (rwlock->writer){
    80006818:	451c                	lw	a5,8(a0)
    8000681a:	2781                	sext.w	a5,a5
    8000681c:	cb89                	beqz	a5,8000682e <read_lock+0x28>
      __atomic_add_fetch(&rwlock->readers, -1, __ATOMIC_SEQ_CST);
    8000681e:	0f50000f          	fence	iorw,ow
    80006822:	04d5302f          	amoadd.d.aq	zero,a3,(a0)
      //wait
      while (rwlock->writer);      
    80006826:	451c                	lw	a5,8(a0)
    80006828:	2781                	sext.w	a5,a5
    8000682a:	fff5                	bnez	a5,80006826 <read_lock+0x20>
    8000682c:	b7d5                	j	80006810 <read_lock+0xa>
    } else {
      return;
    }
  }
}
    8000682e:	6422                	ld	s0,8(sp)
    80006830:	0141                	add	sp,sp,16
    80006832:	8082                	ret

0000000080006834 <read_unlock>:

//release an acquired read lock for thread `thread_id`
void read_unlock(struct ReaderWriterLock *rwlock, uint8 thread_id) {
    80006834:	1141                	add	sp,sp,-16
    80006836:	e422                	sd	s0,8(sp)
    80006838:	0800                	add	s0,sp,16
  __atomic_add_fetch(&rwlock->readers, -1, __ATOMIC_SEQ_CST);
    8000683a:	57fd                	li	a5,-1
    8000683c:	0f50000f          	fence	iorw,ow
    80006840:	04f5302f          	amoadd.d.aq	zero,a5,(a0)
  return;
}
    80006844:	6422                	ld	s0,8(sp)
    80006846:	0141                	add	sp,sp,16
    80006848:	8082                	ret

000000008000684a <write_lock>:
/**
 * Try to acquire a write lock and spin until the lock is available.
 * Spin on the writer mutex.
 * Once it is acquired, wait for the number of readers to drop to 0.
 */
void write_lock(struct ReaderWriterLock *rwlock) {
    8000684a:	1141                	add	sp,sp,-16
    8000684c:	e422                	sd	s0,8(sp)
    8000684e:	0800                	add	s0,sp,16
  // acquire write lock.
  while (__sync_lock_test_and_set(&rwlock->writer, 1))
    80006850:	4705                	li	a4,1
    80006852:	a021                	j	8000685a <write_lock+0x10>
    while (rwlock->writer != 0)
    80006854:	451c                	lw	a5,8(a0)
    80006856:	2781                	sext.w	a5,a5
    80006858:	fff5                	bnez	a5,80006854 <write_lock+0xa>
  while (__sync_lock_test_and_set(&rwlock->writer, 1))
    8000685a:	87ba                	mv	a5,a4
    8000685c:	00850693          	add	a3,a0,8
    80006860:	0cf6a7af          	amoswap.w.aq	a5,a5,(a3)
    80006864:	2781                	sext.w	a5,a5
    80006866:	f7fd                	bnez	a5,80006854 <write_lock+0xa>
      ;
  //once acquired, wait on readers
  while (rwlock->readers > 0);
    80006868:	611c                	ld	a5,0(a0)
    8000686a:	fffd                	bnez	a5,80006868 <write_lock+0x1e>
  return;
}
    8000686c:	6422                	ld	s0,8(sp)
    8000686e:	0141                	add	sp,sp,16
    80006870:	8082                	ret

0000000080006872 <write_unlock>:

//Release an acquired write lock.
void write_unlock(struct ReaderWriterLock *rwlock) {
    80006872:	1141                	add	sp,sp,-16
    80006874:	e422                	sd	s0,8(sp)
    80006876:	0800                	add	s0,sp,16
  __sync_lock_release(&rwlock->writer);
    80006878:	00850793          	add	a5,a0,8
    8000687c:	0f50000f          	fence	iorw,ow
    80006880:	0807a02f          	amoswap.w	zero,zero,(a5)
  return;
}
    80006884:	6422                	ld	s0,8(sp)
    80006886:	0141                	add	sp,sp,16
    80006888:	8082                	ret

000000008000688a <init_lock>:
// #include "rwlock.h"
// Define a node structure for the linked list
struct spinlock list_lock;
struct Node *head_ref;

void init_lock(){
    8000688a:	1141                	add	sp,sp,-16
    8000688c:	e406                	sd	ra,8(sp)
    8000688e:	e022                	sd	s0,0(sp)
    80006890:	0800                	add	s0,sp,16
    initlock(&list_lock, "list_lock");
    80006892:	00002597          	auipc	a1,0x2
    80006896:	07658593          	add	a1,a1,118 # 80008908 <syscalls+0x480>
    8000689a:	0001b517          	auipc	a0,0x1b
    8000689e:	7c650513          	add	a0,a0,1990 # 80022060 <list_lock>
    800068a2:	ffffa097          	auipc	ra,0xffffa
    800068a6:	2c2080e7          	jalr	706(ra) # 80000b64 <initlock>
}
    800068aa:	60a2                	ld	ra,8(sp)
    800068ac:	6402                	ld	s0,0(sp)
    800068ae:	0141                	add	sp,sp,16
    800068b0:	8082                	ret

00000000800068b2 <init_list_lock>:

void init_list_lock(){
    800068b2:	1101                	add	sp,sp,-32
    800068b4:	ec06                	sd	ra,24(sp)
    800068b6:	e822                	sd	s0,16(sp)
    800068b8:	e426                	sd	s1,8(sp)
    800068ba:	e04a                	sd	s2,0(sp)
    800068bc:	1000                	add	s0,sp,32
    head_ref = (struct Node *) kalloc();
    800068be:	ffffa097          	auipc	ra,0xffffa
    800068c2:	224080e7          	jalr	548(ra) # 80000ae2 <kalloc>
    800068c6:	892a                	mv	s2,a0
    800068c8:	00002497          	auipc	s1,0x2
    800068cc:	12048493          	add	s1,s1,288 # 800089e8 <head_ref>
    800068d0:	e088                	sd	a0,0(s1)
    head_ref->lock = (struct ReaderWriterLock *) kalloc();
    800068d2:	ffffa097          	auipc	ra,0xffffa
    800068d6:	210080e7          	jalr	528(ra) # 80000ae2 <kalloc>
    800068da:	00a93823          	sd	a0,16(s2)
    rw_lock_init(head_ref->lock);
    800068de:	609c                	ld	a5,0(s1)
    800068e0:	6b88                	ld	a0,16(a5)
    800068e2:	00000097          	auipc	ra,0x0
    800068e6:	f10080e7          	jalr	-240(ra) # 800067f2 <rw_lock_init>
    head_ref->data = 0;
    800068ea:	609c                	ld	a5,0(s1)
    800068ec:	0007a023          	sw	zero,0(a5)
    head_ref->next = 0;
    800068f0:	609c                	ld	a5,0(s1)
    800068f2:	0007b423          	sd	zero,8(a5)
}
    800068f6:	60e2                	ld	ra,24(sp)
    800068f8:	6442                	ld	s0,16(sp)
    800068fa:	64a2                	ld	s1,8(sp)
    800068fc:	6902                	ld	s2,0(sp)
    800068fe:	6105                	add	sp,sp,32
    80006900:	8082                	ret

0000000080006902 <init_list>:

void init_list(){
    80006902:	1141                	add	sp,sp,-16
    80006904:	e406                	sd	ra,8(sp)
    80006906:	e022                	sd	s0,0(sp)
    80006908:	0800                	add	s0,sp,16
    head_ref = (struct Node *) kalloc();
    8000690a:	ffffa097          	auipc	ra,0xffffa
    8000690e:	1d8080e7          	jalr	472(ra) # 80000ae2 <kalloc>
    80006912:	00002797          	auipc	a5,0x2
    80006916:	0d678793          	add	a5,a5,214 # 800089e8 <head_ref>
    8000691a:	e388                	sd	a0,0(a5)
    head_ref->data = 0;
    8000691c:	00052023          	sw	zero,0(a0)
    head_ref->next = 0;
    80006920:	639c                	ld	a5,0(a5)
    80006922:	0007b423          	sd	zero,8(a5)
}
    80006926:	60a2                	ld	ra,8(sp)
    80006928:	6402                	ld	s0,0(sp)
    8000692a:	0141                	add	sp,sp,16
    8000692c:	8082                	ret

000000008000692e <insert_lock>:

void insert_lock(int new_data) {
    8000692e:	1101                	add	sp,sp,-32
    80006930:	ec06                	sd	ra,24(sp)
    80006932:	e822                	sd	s0,16(sp)
    80006934:	e426                	sd	s1,8(sp)
    80006936:	e04a                	sd	s2,0(sp)
    80006938:	1000                	add	s0,sp,32
    8000693a:	892a                	mv	s2,a0
    struct Node *new_node = (struct Node *) kalloc();
    8000693c:	ffffa097          	auipc	ra,0xffffa
    80006940:	1a6080e7          	jalr	422(ra) # 80000ae2 <kalloc>
    80006944:	84aa                	mv	s1,a0
    new_node->lock = (struct ReaderWriterLock *) kalloc();
    80006946:	ffffa097          	auipc	ra,0xffffa
    8000694a:	19c080e7          	jalr	412(ra) # 80000ae2 <kalloc>
    8000694e:	e888                	sd	a0,16(s1)
    rw_lock_init(new_node->lock);
    80006950:	00000097          	auipc	ra,0x0
    80006954:	ea2080e7          	jalr	-350(ra) # 800067f2 <rw_lock_init>
    new_node->data = new_data;
    80006958:	0124a023          	sw	s2,0(s1)
    write_lock(head_ref->lock);
    8000695c:	00002917          	auipc	s2,0x2
    80006960:	08c90913          	add	s2,s2,140 # 800089e8 <head_ref>
    80006964:	00093783          	ld	a5,0(s2)
    80006968:	6b88                	ld	a0,16(a5)
    8000696a:	00000097          	auipc	ra,0x0
    8000696e:	ee0080e7          	jalr	-288(ra) # 8000684a <write_lock>
    new_node->next = head_ref;
    80006972:	00093783          	ld	a5,0(s2)
    80006976:	e49c                	sd	a5,8(s1)
    head_ref = new_node;
    80006978:	00993023          	sd	s1,0(s2)
    write_unlock(head_ref->next->lock);
    8000697c:	6b88                	ld	a0,16(a5)
    8000697e:	00000097          	auipc	ra,0x0
    80006982:	ef4080e7          	jalr	-268(ra) # 80006872 <write_unlock>
}
    80006986:	60e2                	ld	ra,24(sp)
    80006988:	6442                	ld	s0,16(sp)
    8000698a:	64a2                	ld	s1,8(sp)
    8000698c:	6902                	ld	s2,0(sp)
    8000698e:	6105                	add	sp,sp,32
    80006990:	8082                	ret

0000000080006992 <insert>:


// Function to insert a node at the beginning of the linked list
void insert(int new_data) {
    80006992:	7179                	add	sp,sp,-48
    80006994:	f406                	sd	ra,40(sp)
    80006996:	f022                	sd	s0,32(sp)
    80006998:	ec26                	sd	s1,24(sp)
    8000699a:	e84a                	sd	s2,16(sp)
    8000699c:	e44e                	sd	s3,8(sp)
    8000699e:	1800                	add	s0,sp,48
    800069a0:	892a                	mv	s2,a0
    struct Node *new_node = (struct Node *) kalloc();
    800069a2:	ffffa097          	auipc	ra,0xffffa
    800069a6:	140080e7          	jalr	320(ra) # 80000ae2 <kalloc>
    800069aa:	84aa                	mv	s1,a0
    new_node->data = new_data;
    800069ac:	01252023          	sw	s2,0(a0)
    acquire(&list_lock);
    800069b0:	0001b997          	auipc	s3,0x1b
    800069b4:	6b098993          	add	s3,s3,1712 # 80022060 <list_lock>
    800069b8:	854e                	mv	a0,s3
    800069ba:	ffffa097          	auipc	ra,0xffffa
    800069be:	23a080e7          	jalr	570(ra) # 80000bf4 <acquire>
    new_node->next = head_ref;
    800069c2:	00002917          	auipc	s2,0x2
    800069c6:	02690913          	add	s2,s2,38 # 800089e8 <head_ref>
    800069ca:	00093783          	ld	a5,0(s2)
    800069ce:	e49c                	sd	a5,8(s1)
    release(&list_lock);
    800069d0:	854e                	mv	a0,s3
    800069d2:	ffffa097          	auipc	ra,0xffffa
    800069d6:	2d6080e7          	jalr	726(ra) # 80000ca8 <release>
    synchronize_rcu();
    800069da:	00000097          	auipc	ra,0x0
    800069de:	dcc080e7          	jalr	-564(ra) # 800067a6 <synchronize_rcu>
    head_ref = new_node;
    800069e2:	00993023          	sd	s1,0(s2)
}
    800069e6:	70a2                	ld	ra,40(sp)
    800069e8:	7402                	ld	s0,32(sp)
    800069ea:	64e2                	ld	s1,24(sp)
    800069ec:	6942                	ld	s2,16(sp)
    800069ee:	69a2                	ld	s3,8(sp)
    800069f0:	6145                	add	sp,sp,48
    800069f2:	8082                	ret

00000000800069f4 <deleteNode_lock>:

void deleteNode_lock(int key) {
    800069f4:	7179                	add	sp,sp,-48
    800069f6:	f406                	sd	ra,40(sp)
    800069f8:	f022                	sd	s0,32(sp)
    800069fa:	ec26                	sd	s1,24(sp)
    800069fc:	e84a                	sd	s2,16(sp)
    800069fe:	e44e                	sd	s3,8(sp)
    80006a00:	1800                	add	s0,sp,48
    80006a02:	892a                	mv	s2,a0
    struct Node *temp = head_ref, *prev = 0;
    80006a04:	00002497          	auipc	s1,0x2
    80006a08:	fe44b483          	ld	s1,-28(s1) # 800089e8 <head_ref>

    write_lock(temp->lock);
    80006a0c:	6888                	ld	a0,16(s1)
    80006a0e:	00000097          	auipc	ra,0x0
    80006a12:	e3c080e7          	jalr	-452(ra) # 8000684a <write_lock>
    if (temp != 0 && temp->data == key) {
    80006a16:	409c                	lw	a5,0(s1)
    80006a18:	4981                	li	s3,0
    80006a1a:	01279e63          	bne	a5,s2,80006a36 <deleteNode_lock+0x42>
        head_ref = temp->next;
    80006a1e:	649c                	ld	a5,8(s1)
    80006a20:	00002717          	auipc	a4,0x2
    80006a24:	fcf73423          	sd	a5,-56(a4) # 800089e8 <head_ref>
        write_unlock(temp->lock);
    80006a28:	6888                	ld	a0,16(s1)
    80006a2a:	00000097          	auipc	ra,0x0
    80006a2e:	e48080e7          	jalr	-440(ra) # 80006872 <write_unlock>
        // kfree(temp->lock);
        // kfree(temp);
        return;
    80006a32:	a8a9                	j	80006a8c <deleteNode_lock+0x98>
        if (temp->data != key) {
            if (temp->next != 0) {
                write_lock(temp->next->lock);
                write_unlock(temp->lock);
                prev = temp;
                temp = temp->next;
    80006a34:	84be                	mv	s1,a5
        if (temp->data != key) {
    80006a36:	409c                	lw	a5,0(s1)
    80006a38:	03278c63          	beq	a5,s2,80006a70 <deleteNode_lock+0x7c>
            if (temp->next != 0) {
    80006a3c:	649c                	ld	a5,8(s1)
    80006a3e:	c785                	beqz	a5,80006a66 <deleteNode_lock+0x72>
                write_lock(temp->next->lock);
    80006a40:	6b88                	ld	a0,16(a5)
    80006a42:	00000097          	auipc	ra,0x0
    80006a46:	e08080e7          	jalr	-504(ra) # 8000684a <write_lock>
                write_unlock(temp->lock);
    80006a4a:	6888                	ld	a0,16(s1)
    80006a4c:	00000097          	auipc	ra,0x0
    80006a50:	e26080e7          	jalr	-474(ra) # 80006872 <write_unlock>
                temp = temp->next;
    80006a54:	649c                	ld	a5,8(s1)
    while (temp != 0) {
    80006a56:	89a6                	mv	s3,s1
    80006a58:	fff1                	bnez	a5,80006a34 <deleteNode_lock+0x40>
        }
    }

    if (temp == 0) {
        if (prev != 0) {
            write_unlock(prev->lock);
    80006a5a:	6888                	ld	a0,16(s1)
    80006a5c:	00000097          	auipc	ra,0x0
    80006a60:	e16080e7          	jalr	-490(ra) # 80006872 <write_unlock>
    80006a64:	a025                	j	80006a8c <deleteNode_lock+0x98>
                write_unlock(temp->lock);
    80006a66:	6888                	ld	a0,16(s1)
    80006a68:	00000097          	auipc	ra,0x0
    80006a6c:	e0a080e7          	jalr	-502(ra) # 80006872 <write_unlock>
        }
        return;
    }

    prev->next = temp->next;
    80006a70:	649c                	ld	a5,8(s1)
    80006a72:	00f9b423          	sd	a5,8(s3)
    write_unlock(prev->lock);
    80006a76:	0109b503          	ld	a0,16(s3)
    80006a7a:	00000097          	auipc	ra,0x0
    80006a7e:	df8080e7          	jalr	-520(ra) # 80006872 <write_unlock>
    write_unlock(temp->lock);
    80006a82:	6888                	ld	a0,16(s1)
    80006a84:	00000097          	auipc	ra,0x0
    80006a88:	dee080e7          	jalr	-530(ra) # 80006872 <write_unlock>
    // kfree(temp->lock);
    // kfree(temp);
}
    80006a8c:	70a2                	ld	ra,40(sp)
    80006a8e:	7402                	ld	s0,32(sp)
    80006a90:	64e2                	ld	s1,24(sp)
    80006a92:	6942                	ld	s2,16(sp)
    80006a94:	69a2                	ld	s3,8(sp)
    80006a96:	6145                	add	sp,sp,48
    80006a98:	8082                	ret

0000000080006a9a <deleteNode>:

// Function to delete a node with a given key from the linked list
void deleteNode(int key) {
    80006a9a:	1101                	add	sp,sp,-32
    80006a9c:	ec06                	sd	ra,24(sp)
    80006a9e:	e822                	sd	s0,16(sp)
    80006aa0:	e426                	sd	s1,8(sp)
    80006aa2:	e04a                	sd	s2,0(sp)
    80006aa4:	1000                	add	s0,sp,32
    80006aa6:	892a                	mv	s2,a0
    struct Node *temp = head_ref, *prev = 0;
    80006aa8:	00002497          	auipc	s1,0x2
    80006aac:	f404b483          	ld	s1,-192(s1) # 800089e8 <head_ref>
    acquire(&list_lock);
    80006ab0:	0001b517          	auipc	a0,0x1b
    80006ab4:	5b050513          	add	a0,a0,1456 # 80022060 <list_lock>
    80006ab8:	ffffa097          	auipc	ra,0xffffa
    80006abc:	13c080e7          	jalr	316(ra) # 80000bf4 <acquire>
    if (temp != 0 && temp->data == key) {
    80006ac0:	c4a1                	beqz	s1,80006b08 <deleteNode+0x6e>
    80006ac2:	409c                	lw	a5,0(s1)
    80006ac4:	4701                	li	a4,0
    80006ac6:	01278a63          	beq	a5,s2,80006ada <deleteNode+0x40>
        synchronize_rcu();
        kfree(temp);
        return;
    }

    while (temp != 0 && temp->data != key) {
    80006aca:	409c                	lw	a5,0(s1)
    80006acc:	05278763          	beq	a5,s2,80006b1a <deleteNode+0x80>
        prev = temp;
        temp = temp->next;
    80006ad0:	649c                	ld	a5,8(s1)
    while (temp != 0 && temp->data != key) {
    80006ad2:	8726                	mv	a4,s1
    80006ad4:	cb95                	beqz	a5,80006b08 <deleteNode+0x6e>
        temp = temp->next;
    80006ad6:	84be                	mv	s1,a5
    80006ad8:	bfcd                	j	80006aca <deleteNode+0x30>
        head_ref = temp->next;
    80006ada:	649c                	ld	a5,8(s1)
    80006adc:	00002717          	auipc	a4,0x2
    80006ae0:	f0f73623          	sd	a5,-244(a4) # 800089e8 <head_ref>
        release(&list_lock);
    80006ae4:	0001b517          	auipc	a0,0x1b
    80006ae8:	57c50513          	add	a0,a0,1404 # 80022060 <list_lock>
    80006aec:	ffffa097          	auipc	ra,0xffffa
    80006af0:	1bc080e7          	jalr	444(ra) # 80000ca8 <release>
        synchronize_rcu();
    80006af4:	00000097          	auipc	ra,0x0
    80006af8:	cb2080e7          	jalr	-846(ra) # 800067a6 <synchronize_rcu>
        kfree(temp);
    80006afc:	8526                	mv	a0,s1
    80006afe:	ffffa097          	auipc	ra,0xffffa
    80006b02:	ee6080e7          	jalr	-282(ra) # 800009e4 <kfree>
        return;
    80006b06:	a82d                	j	80006b40 <deleteNode+0xa6>
    }

    if (temp == 0) {
        release(&list_lock);
    80006b08:	0001b517          	auipc	a0,0x1b
    80006b0c:	55850513          	add	a0,a0,1368 # 80022060 <list_lock>
    80006b10:	ffffa097          	auipc	ra,0xffffa
    80006b14:	198080e7          	jalr	408(ra) # 80000ca8 <release>
        return;
    80006b18:	a025                	j	80006b40 <deleteNode+0xa6>
    }
    prev->next = temp->next;
    80006b1a:	649c                	ld	a5,8(s1)
    80006b1c:	e71c                	sd	a5,8(a4)
    release(&list_lock);
    80006b1e:	0001b517          	auipc	a0,0x1b
    80006b22:	54250513          	add	a0,a0,1346 # 80022060 <list_lock>
    80006b26:	ffffa097          	auipc	ra,0xffffa
    80006b2a:	182080e7          	jalr	386(ra) # 80000ca8 <release>
    synchronize_rcu();
    80006b2e:	00000097          	auipc	ra,0x0
    80006b32:	c78080e7          	jalr	-904(ra) # 800067a6 <synchronize_rcu>
    kfree(temp);
    80006b36:	8526                	mv	a0,s1
    80006b38:	ffffa097          	auipc	ra,0xffffa
    80006b3c:	eac080e7          	jalr	-340(ra) # 800009e4 <kfree>
}
    80006b40:	60e2                	ld	ra,24(sp)
    80006b42:	6442                	ld	s0,16(sp)
    80006b44:	64a2                	ld	s1,8(sp)
    80006b46:	6902                	ld	s2,0(sp)
    80006b48:	6105                	add	sp,sp,32
    80006b4a:	8082                	ret

0000000080006b4c <search>:

// Function to search for a node with a given key in the linked list
struct Node* search(int key) {
    80006b4c:	1101                	add	sp,sp,-32
    80006b4e:	ec06                	sd	ra,24(sp)
    80006b50:	e822                	sd	s0,16(sp)
    80006b52:	e426                	sd	s1,8(sp)
    80006b54:	e04a                	sd	s2,0(sp)
    80006b56:	1000                	add	s0,sp,32
    80006b58:	892a                	mv	s2,a0

    struct Node *current = head_ref;
    80006b5a:	00002497          	auipc	s1,0x2
    80006b5e:	e8e4b483          	ld	s1,-370(s1) # 800089e8 <head_ref>
    rcu_read_lock();
    80006b62:	00000097          	auipc	ra,0x0
    80006b66:	c2c080e7          	jalr	-980(ra) # 8000678e <rcu_read_lock>
    while (current != 0) {
    80006b6a:	c491                	beqz	s1,80006b76 <search+0x2a>
        if (current->data == key) {
    80006b6c:	409c                	lw	a5,0(s1)
    80006b6e:	03278063          	beq	a5,s2,80006b8e <search+0x42>
            rcu_read_unlock();
            return current; // Node found
        }
        current = current->next;
    80006b72:	6484                	ld	s1,8(s1)
    while (current != 0) {
    80006b74:	fce5                	bnez	s1,80006b6c <search+0x20>
    }
    rcu_read_unlock();
    80006b76:	00000097          	auipc	ra,0x0
    80006b7a:	c00080e7          	jalr	-1024(ra) # 80006776 <rcu_read_unlock>
    return 0; // Node not found
    80006b7e:	4481                	li	s1,0
}
    80006b80:	8526                	mv	a0,s1
    80006b82:	60e2                	ld	ra,24(sp)
    80006b84:	6442                	ld	s0,16(sp)
    80006b86:	64a2                	ld	s1,8(sp)
    80006b88:	6902                	ld	s2,0(sp)
    80006b8a:	6105                	add	sp,sp,32
    80006b8c:	8082                	ret
            rcu_read_unlock();
    80006b8e:	00000097          	auipc	ra,0x0
    80006b92:	be8080e7          	jalr	-1048(ra) # 80006776 <rcu_read_unlock>
            return current; // Node found
    80006b96:	b7ed                	j	80006b80 <search+0x34>

0000000080006b98 <search_lock>:

struct Node* search_lock(int key) {
    80006b98:	7179                	add	sp,sp,-48
    80006b9a:	f406                	sd	ra,40(sp)
    80006b9c:	f022                	sd	s0,32(sp)
    80006b9e:	ec26                	sd	s1,24(sp)
    80006ba0:	e84a                	sd	s2,16(sp)
    80006ba2:	e44e                	sd	s3,8(sp)
    80006ba4:	1800                	add	s0,sp,48
  asm volatile("mv %0, tp" : "=r" (x) );
    80006ba6:	8912                	mv	s2,tp
    int cpuid = r_tp();
    struct Node *current = head_ref;
    80006ba8:	00002497          	auipc	s1,0x2
    80006bac:	e404b483          	ld	s1,-448(s1) # 800089e8 <head_ref>
    while (current != 0) {
    80006bb0:	cc85                	beqz	s1,80006be8 <search_lock+0x50>
    80006bb2:	89aa                	mv	s3,a0
        read_lock(current->lock,cpuid);
    80006bb4:	0ff97913          	zext.b	s2,s2
    80006bb8:	85ca                	mv	a1,s2
    80006bba:	6888                	ld	a0,16(s1)
    80006bbc:	00000097          	auipc	ra,0x0
    80006bc0:	c4a080e7          	jalr	-950(ra) # 80006806 <read_lock>
        if (current->data == key) {
    80006bc4:	409c                	lw	a5,0(s1)
    80006bc6:	01378b63          	beq	a5,s3,80006bdc <search_lock+0x44>
            read_unlock(current->lock,cpuid);
            return current; // Node found
        }
        read_unlock(current->lock,cpuid);
    80006bca:	85ca                	mv	a1,s2
    80006bcc:	6888                	ld	a0,16(s1)
    80006bce:	00000097          	auipc	ra,0x0
    80006bd2:	c66080e7          	jalr	-922(ra) # 80006834 <read_unlock>
        current = current->next;
    80006bd6:	6484                	ld	s1,8(s1)
    while (current != 0) {
    80006bd8:	f0e5                	bnez	s1,80006bb8 <search_lock+0x20>
    80006bda:	a039                	j	80006be8 <search_lock+0x50>
            read_unlock(current->lock,cpuid);
    80006bdc:	85ca                	mv	a1,s2
    80006bde:	6888                	ld	a0,16(s1)
    80006be0:	00000097          	auipc	ra,0x0
    80006be4:	c54080e7          	jalr	-940(ra) # 80006834 <read_unlock>
    }
    return 0; // Node not found
}
    80006be8:	8526                	mv	a0,s1
    80006bea:	70a2                	ld	ra,40(sp)
    80006bec:	7402                	ld	s0,32(sp)
    80006bee:	64e2                	ld	s1,24(sp)
    80006bf0:	6942                	ld	s2,16(sp)
    80006bf2:	69a2                	ld	s3,8(sp)
    80006bf4:	6145                	add	sp,sp,48
    80006bf6:	8082                	ret

0000000080006bf8 <updateNode>:


// Function to update the value of a node with a given key in the linked list
void updateNode(int key, int new_data) {
    80006bf8:	1101                	add	sp,sp,-32
    80006bfa:	ec06                	sd	ra,24(sp)
    80006bfc:	e822                	sd	s0,16(sp)
    80006bfe:	e426                	sd	s1,8(sp)
    80006c00:	e04a                	sd	s2,0(sp)
    80006c02:	1000                	add	s0,sp,32
    80006c04:	892a                	mv	s2,a0
    80006c06:	84ae                	mv	s1,a1
    struct Node *nodeToUpdate = search(key);
    80006c08:	00000097          	auipc	ra,0x0
    80006c0c:	f44080e7          	jalr	-188(ra) # 80006b4c <search>

    if (nodeToUpdate != 0) {
    80006c10:	c901                	beqz	a0,80006c20 <updateNode+0x28>
        nodeToUpdate->data = new_data; // Update the node's data
    80006c12:	c104                	sw	s1,0(a0)
    } else {
        printf("Node with key %d not found.\n", key);
    }
}
    80006c14:	60e2                	ld	ra,24(sp)
    80006c16:	6442                	ld	s0,16(sp)
    80006c18:	64a2                	ld	s1,8(sp)
    80006c1a:	6902                	ld	s2,0(sp)
    80006c1c:	6105                	add	sp,sp,32
    80006c1e:	8082                	ret
        printf("Node with key %d not found.\n", key);
    80006c20:	85ca                	mv	a1,s2
    80006c22:	00002517          	auipc	a0,0x2
    80006c26:	cf650513          	add	a0,a0,-778 # 80008918 <syscalls+0x490>
    80006c2a:	ffffa097          	auipc	ra,0xffffa
    80006c2e:	95c080e7          	jalr	-1700(ra) # 80000586 <printf>
}
    80006c32:	b7cd                	j	80006c14 <updateNode+0x1c>

0000000080006c34 <printList>:

void printList() {
    80006c34:	1101                	add	sp,sp,-32
    80006c36:	ec06                	sd	ra,24(sp)
    80006c38:	e822                	sd	s0,16(sp)
    80006c3a:	e426                	sd	s1,8(sp)
    80006c3c:	e04a                	sd	s2,0(sp)
    80006c3e:	1000                	add	s0,sp,32
    printf("Final Linked List: ");
    80006c40:	00002517          	auipc	a0,0x2
    80006c44:	cf850513          	add	a0,a0,-776 # 80008938 <syscalls+0x4b0>
    80006c48:	ffffa097          	auipc	ra,0xffffa
    80006c4c:	93e080e7          	jalr	-1730(ra) # 80000586 <printf>
    struct Node *temp = head_ref;
    80006c50:	00002497          	auipc	s1,0x2
    80006c54:	d984b483          	ld	s1,-616(s1) # 800089e8 <head_ref>
    while (temp != 0) {
    80006c58:	cc89                	beqz	s1,80006c72 <printList+0x3e>
        printf("%d -> ", temp->data);
    80006c5a:	00002917          	auipc	s2,0x2
    80006c5e:	cf690913          	add	s2,s2,-778 # 80008950 <syscalls+0x4c8>
    80006c62:	408c                	lw	a1,0(s1)
    80006c64:	854a                	mv	a0,s2
    80006c66:	ffffa097          	auipc	ra,0xffffa
    80006c6a:	920080e7          	jalr	-1760(ra) # 80000586 <printf>
        temp = temp->next;
    80006c6e:	6484                	ld	s1,8(s1)
    while (temp != 0) {
    80006c70:	f8ed                	bnez	s1,80006c62 <printList+0x2e>
    }
    printf("NULL\n");
    80006c72:	00002517          	auipc	a0,0x2
    80006c76:	ce650513          	add	a0,a0,-794 # 80008958 <syscalls+0x4d0>
    80006c7a:	ffffa097          	auipc	ra,0xffffa
    80006c7e:	90c080e7          	jalr	-1780(ra) # 80000586 <printf>
}
    80006c82:	60e2                	ld	ra,24(sp)
    80006c84:	6442                	ld	s0,16(sp)
    80006c86:	64a2                	ld	s1,8(sp)
    80006c88:	6902                	ld	s2,0(sp)
    80006c8a:	6105                	add	sp,sp,32
    80006c8c:	8082                	ret
	...

0000000080007000 <_trampoline>:
    80007000:	14051073          	csrw	sscratch,a0
    80007004:	02000537          	lui	a0,0x2000
    80007008:	357d                	addw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    8000700a:	0536                	sll	a0,a0,0xd
    8000700c:	02153423          	sd	ra,40(a0)
    80007010:	02253823          	sd	sp,48(a0)
    80007014:	02353c23          	sd	gp,56(a0)
    80007018:	04453023          	sd	tp,64(a0)
    8000701c:	04553423          	sd	t0,72(a0)
    80007020:	04653823          	sd	t1,80(a0)
    80007024:	04753c23          	sd	t2,88(a0)
    80007028:	f120                	sd	s0,96(a0)
    8000702a:	f524                	sd	s1,104(a0)
    8000702c:	fd2c                	sd	a1,120(a0)
    8000702e:	e150                	sd	a2,128(a0)
    80007030:	e554                	sd	a3,136(a0)
    80007032:	e958                	sd	a4,144(a0)
    80007034:	ed5c                	sd	a5,152(a0)
    80007036:	0b053023          	sd	a6,160(a0)
    8000703a:	0b153423          	sd	a7,168(a0)
    8000703e:	0b253823          	sd	s2,176(a0)
    80007042:	0b353c23          	sd	s3,184(a0)
    80007046:	0d453023          	sd	s4,192(a0)
    8000704a:	0d553423          	sd	s5,200(a0)
    8000704e:	0d653823          	sd	s6,208(a0)
    80007052:	0d753c23          	sd	s7,216(a0)
    80007056:	0f853023          	sd	s8,224(a0)
    8000705a:	0f953423          	sd	s9,232(a0)
    8000705e:	0fa53823          	sd	s10,240(a0)
    80007062:	0fb53c23          	sd	s11,248(a0)
    80007066:	11c53023          	sd	t3,256(a0)
    8000706a:	11d53423          	sd	t4,264(a0)
    8000706e:	11e53823          	sd	t5,272(a0)
    80007072:	11f53c23          	sd	t6,280(a0)
    80007076:	140022f3          	csrr	t0,sscratch
    8000707a:	06553823          	sd	t0,112(a0)
    8000707e:	00853103          	ld	sp,8(a0)
    80007082:	02053203          	ld	tp,32(a0)
    80007086:	01053283          	ld	t0,16(a0)
    8000708a:	00053303          	ld	t1,0(a0)
    8000708e:	12000073          	sfence.vma
    80007092:	18031073          	csrw	satp,t1
    80007096:	12000073          	sfence.vma
    8000709a:	8282                	jr	t0

000000008000709c <userret>:
    8000709c:	12000073          	sfence.vma
    800070a0:	18051073          	csrw	satp,a0
    800070a4:	12000073          	sfence.vma
    800070a8:	02000537          	lui	a0,0x2000
    800070ac:	357d                	addw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    800070ae:	0536                	sll	a0,a0,0xd
    800070b0:	02853083          	ld	ra,40(a0)
    800070b4:	03053103          	ld	sp,48(a0)
    800070b8:	03853183          	ld	gp,56(a0)
    800070bc:	04053203          	ld	tp,64(a0)
    800070c0:	04853283          	ld	t0,72(a0)
    800070c4:	05053303          	ld	t1,80(a0)
    800070c8:	05853383          	ld	t2,88(a0)
    800070cc:	7120                	ld	s0,96(a0)
    800070ce:	7524                	ld	s1,104(a0)
    800070d0:	7d2c                	ld	a1,120(a0)
    800070d2:	6150                	ld	a2,128(a0)
    800070d4:	6554                	ld	a3,136(a0)
    800070d6:	6958                	ld	a4,144(a0)
    800070d8:	6d5c                	ld	a5,152(a0)
    800070da:	0a053803          	ld	a6,160(a0)
    800070de:	0a853883          	ld	a7,168(a0)
    800070e2:	0b053903          	ld	s2,176(a0)
    800070e6:	0b853983          	ld	s3,184(a0)
    800070ea:	0c053a03          	ld	s4,192(a0)
    800070ee:	0c853a83          	ld	s5,200(a0)
    800070f2:	0d053b03          	ld	s6,208(a0)
    800070f6:	0d853b83          	ld	s7,216(a0)
    800070fa:	0e053c03          	ld	s8,224(a0)
    800070fe:	0e853c83          	ld	s9,232(a0)
    80007102:	0f053d03          	ld	s10,240(a0)
    80007106:	0f853d83          	ld	s11,248(a0)
    8000710a:	10053e03          	ld	t3,256(a0)
    8000710e:	10853e83          	ld	t4,264(a0)
    80007112:	11053f03          	ld	t5,272(a0)
    80007116:	11853f83          	ld	t6,280(a0)
    8000711a:	7928                	ld	a0,112(a0)
    8000711c:	10200073          	sret
	...
