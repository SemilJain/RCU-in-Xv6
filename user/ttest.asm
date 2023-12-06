
user/_ttest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <delay>:
//     initlock(&thread_lock);
// }
volatile int total_balance = 0;
struct balance b1 = {"b1", 3200};
struct balance b2 = {"b2", 2800};
volatile unsigned int delay (unsigned int d) {
   0:	1141                	add	sp,sp,-16
   2:	e422                	sd	s0,8(sp)
   4:	0800                	add	s0,sp,16
   unsigned int i; 
   for (i = 0; i < d; i++) {
   6:	c511                	beqz	a0,12 <delay+0x12>
   8:	4781                	li	a5,0
       __asm volatile( "nop" ::: );
   a:	0001                	nop
   for (i = 0; i < d; i++) {
   c:	2785                	addw	a5,a5,1
   e:	fef51ee3          	bne	a0,a5,a <delay+0xa>
   }

   return i;   
}
  12:	6422                	ld	s0,8(sp)
  14:	0141                	add	sp,sp,16
  16:	8082                	ret

0000000000000018 <do_work>:

void do_work(void *arg){
  18:	7139                	add	sp,sp,-64
  1a:	fc06                	sd	ra,56(sp)
  1c:	f822                	sd	s0,48(sp)
  1e:	f426                	sd	s1,40(sp)
  20:	f04a                	sd	s2,32(sp)
  22:	ec4e                	sd	s3,24(sp)
  24:	e852                	sd	s4,16(sp)
  26:	e456                	sd	s5,8(sp)
  28:	e05a                	sd	s6,0(sp)
  2a:	0080                	add	s0,sp,64
  2c:	8aaa                	mv	s5,a0
    int i; 
    int old;
    struct balance *b = (struct balance*) arg; 
    fprintf(1, "Starting do_work: s:%s\n", b->name);
  2e:	862a                	mv	a2,a0
  30:	00001597          	auipc	a1,0x1
  34:	c2058593          	add	a1,a1,-992 # c50 <updateNode+0x3e>
  38:	4505                	li	a0,1
  3a:	00001097          	auipc	ra,0x1
  3e:	8c8080e7          	jalr	-1848(ra) # 902 <fprintf>

    for (i = 0; i < b->amount; i++) { 
  42:	020aa783          	lw	a5,32(s5)
  46:	04f05863          	blez	a5,96 <do_work+0x7e>
  4a:	4901                	li	s2,0
        //  thread_spin_lock(lock);
        // thread_mutex_lock(lock);
        acquire(&thread_lock);
  4c:	00001a17          	auipc	s4,0x1
  50:	00ca0a13          	add	s4,s4,12 # 1058 <thread_lock>
         old = total_balance;
  54:	00001997          	auipc	s3,0x1
  58:	ffc98993          	add	s3,s3,-4 # 1050 <total_balance>
         delay(100000);
  5c:	6b61                	lui	s6,0x18
  5e:	6a0b0b13          	add	s6,s6,1696 # 186a0 <base+0x17630>
        acquire(&thread_lock);
  62:	8552                	mv	a0,s4
  64:	00000097          	auipc	ra,0x0
  68:	4e0080e7          	jalr	1248(ra) # 544 <acquire>
         old = total_balance;
  6c:	0009a483          	lw	s1,0(s3)
  70:	2481                	sext.w	s1,s1
         delay(100000);
  72:	855a                	mv	a0,s6
  74:	00000097          	auipc	ra,0x0
  78:	f8c080e7          	jalr	-116(ra) # 0 <delay>
         total_balance = old + 1;
  7c:	2485                	addw	s1,s1,1
  7e:	0099a023          	sw	s1,0(s3)
         release(&thread_lock);
  82:	8552                	mv	a0,s4
  84:	00000097          	auipc	ra,0x0
  88:	4d8080e7          	jalr	1240(ra) # 55c <release>
    for (i = 0; i < b->amount; i++) { 
  8c:	2905                	addw	s2,s2,1
  8e:	020aa783          	lw	a5,32(s5)
  92:	fcf948e3          	blt	s2,a5,62 <do_work+0x4a>
        //  thread_spin_unlock(lock);
        // thread_mutex_unlock(lock);

    }
  
    fprintf(1, "Done s:%s\n", b->name);
  96:	8656                	mv	a2,s5
  98:	00001597          	auipc	a1,0x1
  9c:	bd058593          	add	a1,a1,-1072 # c68 <updateNode+0x56>
  a0:	4505                	li	a0,1
  a2:	00001097          	auipc	ra,0x1
  a6:	860080e7          	jalr	-1952(ra) # 902 <fprintf>

    thread_exit(0);
  aa:	4501                	li	a0,0
  ac:	00000097          	auipc	ra,0x0
  b0:	594080e7          	jalr	1428(ra) # 640 <thread_exit>
    return;
}
  b4:	70e2                	ld	ra,56(sp)
  b6:	7442                	ld	s0,48(sp)
  b8:	74a2                	ld	s1,40(sp)
  ba:	7902                	ld	s2,32(sp)
  bc:	69e2                	ld	s3,24(sp)
  be:	6a42                	ld	s4,16(sp)
  c0:	6aa2                	ld	s5,8(sp)
  c2:	6b02                	ld	s6,0(sp)
  c4:	6121                	add	sp,sp,64
  c6:	8082                	ret

00000000000000c8 <do_work2>:
void do_work2(){
  c8:	7139                	add	sp,sp,-64
  ca:	fc06                	sd	ra,56(sp)
  cc:	f822                	sd	s0,48(sp)
  ce:	f426                	sd	s1,40(sp)
  d0:	f04a                	sd	s2,32(sp)
  d2:	ec4e                	sd	s3,24(sp)
  d4:	e852                	sd	s4,16(sp)
  d6:	e456                	sd	s5,8(sp)
  d8:	e05a                	sd	s6,0(sp)
  da:	0080                	add	s0,sp,64
    int i; 
    int old;
    // struct balance *b = b1; 
    fprintf(1, "Starting do_work: s:%s\n", b1.name);
  dc:	00001497          	auipc	s1,0x1
  e0:	f2448493          	add	s1,s1,-220 # 1000 <b1>
  e4:	8626                	mv	a2,s1
  e6:	00001597          	auipc	a1,0x1
  ea:	b6a58593          	add	a1,a1,-1174 # c50 <updateNode+0x3e>
  ee:	4505                	li	a0,1
  f0:	00001097          	auipc	ra,0x1
  f4:	812080e7          	jalr	-2030(ra) # 902 <fprintf>

    for (i = 0; i < b1.amount; i++) { 
  f8:	509c                	lw	a5,32(s1)
  fa:	04f05963          	blez	a5,14c <do_work2+0x84>
  fe:	4901                	li	s2,0
        //  thread_spin_lock(lock);
        // thread_mutex_lock(lock);
        acquire(&thread_lock);
 100:	00001a17          	auipc	s4,0x1
 104:	f58a0a13          	add	s4,s4,-168 # 1058 <thread_lock>
         old = total_balance;
 108:	00001997          	auipc	s3,0x1
 10c:	f4898993          	add	s3,s3,-184 # 1050 <total_balance>
         delay(100000);
 110:	6ae1                	lui	s5,0x18
 112:	6a0a8a93          	add	s5,s5,1696 # 186a0 <base+0x17630>
    for (i = 0; i < b1.amount; i++) { 
 116:	8b26                	mv	s6,s1
        acquire(&thread_lock);
 118:	8552                	mv	a0,s4
 11a:	00000097          	auipc	ra,0x0
 11e:	42a080e7          	jalr	1066(ra) # 544 <acquire>
         old = total_balance;
 122:	0009a483          	lw	s1,0(s3)
 126:	2481                	sext.w	s1,s1
         delay(100000);
 128:	8556                	mv	a0,s5
 12a:	00000097          	auipc	ra,0x0
 12e:	ed6080e7          	jalr	-298(ra) # 0 <delay>
         total_balance = old + 1;
 132:	2485                	addw	s1,s1,1
 134:	0099a023          	sw	s1,0(s3)
         release(&thread_lock);
 138:	8552                	mv	a0,s4
 13a:	00000097          	auipc	ra,0x0
 13e:	422080e7          	jalr	1058(ra) # 55c <release>
    for (i = 0; i < b1.amount; i++) { 
 142:	2905                	addw	s2,s2,1
 144:	020b2783          	lw	a5,32(s6)
 148:	fcf948e3          	blt	s2,a5,118 <do_work2+0x50>
        //  thread_spin_unlock(lock);
        // thread_mutex_unlock(lock);
    }
  
    fprintf(1, "Done s:%s\n", b1.name);
 14c:	00001617          	auipc	a2,0x1
 150:	eb460613          	add	a2,a2,-332 # 1000 <b1>
 154:	00001597          	auipc	a1,0x1
 158:	b1458593          	add	a1,a1,-1260 # c68 <updateNode+0x56>
 15c:	4505                	li	a0,1
 15e:	00000097          	auipc	ra,0x0
 162:	7a4080e7          	jalr	1956(ra) # 902 <fprintf>

    thread_exit(0);
 166:	4501                	li	a0,0
 168:	00000097          	auipc	ra,0x0
 16c:	4d8080e7          	jalr	1240(ra) # 640 <thread_exit>
    return;
}
 170:	70e2                	ld	ra,56(sp)
 172:	7442                	ld	s0,48(sp)
 174:	74a2                	ld	s1,40(sp)
 176:	7902                	ld	s2,32(sp)
 178:	69e2                	ld	s3,24(sp)
 17a:	6a42                	ld	s4,16(sp)
 17c:	6aa2                	ld	s5,8(sp)
 17e:	6b02                	ld	s6,0(sp)
 180:	6121                	add	sp,sp,64
 182:	8082                	ret

0000000000000184 <main>:

int main(int argc, char *argv[]) {
 184:	7119                	add	sp,sp,-128
 186:	fc86                	sd	ra,120(sp)
 188:	f8a2                	sd	s0,112(sp)
 18a:	f4a6                	sd	s1,104(sp)
 18c:	f0ca                	sd	s2,96(sp)
 18e:	ecce                	sd	s3,88(sp)
 190:	0100                	add	s0,sp,128
//   thread_spin_init(lock);
initlock(&thread_lock);
 192:	00001517          	auipc	a0,0x1
 196:	ec650513          	add	a0,a0,-314 # 1058 <thread_lock>
 19a:	00000097          	auipc	ra,0x0
 19e:	39a080e7          	jalr	922(ra) # 534 <initlock>
  struct balance b1 = {"b1", 3200};
 1a2:	00001797          	auipc	a5,0x1
 1a6:	b4678793          	add	a5,a5,-1210 # ce8 <updateNode+0xd6>
 1aa:	638c                	ld	a1,0(a5)
 1ac:	6790                	ld	a2,8(a5)
 1ae:	6b94                	ld	a3,16(a5)
 1b0:	6f98                	ld	a4,24(a5)
 1b2:	fab43423          	sd	a1,-88(s0)
 1b6:	fac43823          	sd	a2,-80(s0)
 1ba:	fad43c23          	sd	a3,-72(s0)
 1be:	fce43023          	sd	a4,-64(s0)
 1c2:	5398                	lw	a4,32(a5)
 1c4:	fce42423          	sw	a4,-56(s0)
  struct balance b2 = {"b2", 2800};
 1c8:	778c                	ld	a1,40(a5)
 1ca:	7b90                	ld	a2,48(a5)
 1cc:	7f94                	ld	a3,56(a5)
 1ce:	63b8                	ld	a4,64(a5)
 1d0:	f8b43023          	sd	a1,-128(s0)
 1d4:	f8c43423          	sd	a2,-120(s0)
 1d8:	f8d43823          	sd	a3,-112(s0)
 1dc:	f8e43c23          	sd	a4,-104(s0)
 1e0:	47bc                	lw	a5,72(a5)
 1e2:	faf42023          	sw	a5,-96(s0)
 
  void *s1, *s2;
  int t1, t2, r1, r2;

  s1 = malloc(4096);
 1e6:	6505                	lui	a0,0x1
 1e8:	00001097          	auipc	ra,0x1
 1ec:	800080e7          	jalr	-2048(ra) # 9e8 <malloc>
 1f0:	84aa                	mv	s1,a0
  s2 = malloc(4096);
 1f2:	6505                	lui	a0,0x1
 1f4:	00000097          	auipc	ra,0x0
 1f8:	7f4080e7          	jalr	2036(ra) # 9e8 <malloc>
 1fc:	892a                	mv	s2,a0
  fprintf(1, "ustack addr %p\n", s1);
 1fe:	8626                	mv	a2,s1
 200:	00001597          	auipc	a1,0x1
 204:	a7858593          	add	a1,a1,-1416 # c78 <updateNode+0x66>
 208:	4505                	li	a0,1
 20a:	00000097          	auipc	ra,0x0
 20e:	6f8080e7          	jalr	1784(ra) # 902 <fprintf>
    fprintf(1,"in here");
 212:	00001597          	auipc	a1,0x1
 216:	a7658593          	add	a1,a1,-1418 # c88 <updateNode+0x76>
 21a:	4505                	li	a0,1
 21c:	00000097          	auipc	ra,0x0
 220:	6e6080e7          	jalr	1766(ra) # 902 <fprintf>
  t1 = thread_create(do_work, (void*)&b1, s1);
 224:	8626                	mv	a2,s1
 226:	fa840593          	add	a1,s0,-88
 22a:	00000517          	auipc	a0,0x0
 22e:	dee50513          	add	a0,a0,-530 # 18 <do_work>
 232:	00000097          	auipc	ra,0x0
 236:	3fe080e7          	jalr	1022(ra) # 630 <thread_create>
 23a:	84aa                	mv	s1,a0
  fprintf(1,"in here1");
 23c:	00001597          	auipc	a1,0x1
 240:	a5458593          	add	a1,a1,-1452 # c90 <updateNode+0x7e>
 244:	4505                	li	a0,1
 246:	00000097          	auipc	ra,0x0
 24a:	6bc080e7          	jalr	1724(ra) # 902 <fprintf>
  t2 = thread_create(do_work2, (void*)&b2, s2); 
 24e:	864a                	mv	a2,s2
 250:	f8040593          	add	a1,s0,-128
 254:	00000517          	auipc	a0,0x0
 258:	e7450513          	add	a0,a0,-396 # c8 <do_work2>
 25c:	00000097          	auipc	ra,0x0
 260:	3d4080e7          	jalr	980(ra) # 630 <thread_create>
 264:	89aa                	mv	s3,a0
  fprintf(1,"in here2");
 266:	00001597          	auipc	a1,0x1
 26a:	a3a58593          	add	a1,a1,-1478 # ca0 <updateNode+0x8e>
 26e:	4505                	li	a0,1
 270:	00000097          	auipc	ra,0x0
 274:	692080e7          	jalr	1682(ra) # 902 <fprintf>
  r1 = thread_join();
 278:	00000097          	auipc	ra,0x0
 27c:	3c0080e7          	jalr	960(ra) # 638 <thread_join>
 280:	892a                	mv	s2,a0
  r2 = thread_join();
 282:	00000097          	auipc	ra,0x0
 286:	3b6080e7          	jalr	950(ra) # 638 <thread_join>
 28a:	87aa                	mv	a5,a0
  
  fprintf(1, "Threads finished: (%d):%d, (%d):%d, shared balance:%d\n", 
 28c:	00001817          	auipc	a6,0x1
 290:	dc482803          	lw	a6,-572(a6) # 1050 <total_balance>
 294:	874e                	mv	a4,s3
 296:	86ca                	mv	a3,s2
 298:	8626                	mv	a2,s1
 29a:	00001597          	auipc	a1,0x1
 29e:	a1658593          	add	a1,a1,-1514 # cb0 <updateNode+0x9e>
 2a2:	4505                	li	a0,1
 2a4:	00000097          	auipc	ra,0x0
 2a8:	65e080e7          	jalr	1630(ra) # 902 <fprintf>
      t1, r1, t2, r2, total_balance);

  exit(0);
 2ac:	4501                	li	a0,0
 2ae:	00000097          	auipc	ra,0x0
 2b2:	2ca080e7          	jalr	714(ra) # 578 <exit>

00000000000002b6 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 2b6:	1141                	add	sp,sp,-16
 2b8:	e406                	sd	ra,8(sp)
 2ba:	e022                	sd	s0,0(sp)
 2bc:	0800                	add	s0,sp,16
  extern int main();
  main();
 2be:	00000097          	auipc	ra,0x0
 2c2:	ec6080e7          	jalr	-314(ra) # 184 <main>
  exit(0);
 2c6:	4501                	li	a0,0
 2c8:	00000097          	auipc	ra,0x0
 2cc:	2b0080e7          	jalr	688(ra) # 578 <exit>

00000000000002d0 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 2d0:	1141                	add	sp,sp,-16
 2d2:	e422                	sd	s0,8(sp)
 2d4:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2d6:	87aa                	mv	a5,a0
 2d8:	0585                	add	a1,a1,1
 2da:	0785                	add	a5,a5,1
 2dc:	fff5c703          	lbu	a4,-1(a1)
 2e0:	fee78fa3          	sb	a4,-1(a5)
 2e4:	fb75                	bnez	a4,2d8 <strcpy+0x8>
    ;
  return os;
}
 2e6:	6422                	ld	s0,8(sp)
 2e8:	0141                	add	sp,sp,16
 2ea:	8082                	ret

00000000000002ec <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2ec:	1141                	add	sp,sp,-16
 2ee:	e422                	sd	s0,8(sp)
 2f0:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 2f2:	00054783          	lbu	a5,0(a0)
 2f6:	cb91                	beqz	a5,30a <strcmp+0x1e>
 2f8:	0005c703          	lbu	a4,0(a1)
 2fc:	00f71763          	bne	a4,a5,30a <strcmp+0x1e>
    p++, q++;
 300:	0505                	add	a0,a0,1
 302:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 304:	00054783          	lbu	a5,0(a0)
 308:	fbe5                	bnez	a5,2f8 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 30a:	0005c503          	lbu	a0,0(a1)
}
 30e:	40a7853b          	subw	a0,a5,a0
 312:	6422                	ld	s0,8(sp)
 314:	0141                	add	sp,sp,16
 316:	8082                	ret

0000000000000318 <strlen>:

uint
strlen(const char *s)
{
 318:	1141                	add	sp,sp,-16
 31a:	e422                	sd	s0,8(sp)
 31c:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 31e:	00054783          	lbu	a5,0(a0)
 322:	cf91                	beqz	a5,33e <strlen+0x26>
 324:	0505                	add	a0,a0,1
 326:	87aa                	mv	a5,a0
 328:	86be                	mv	a3,a5
 32a:	0785                	add	a5,a5,1
 32c:	fff7c703          	lbu	a4,-1(a5)
 330:	ff65                	bnez	a4,328 <strlen+0x10>
 332:	40a6853b          	subw	a0,a3,a0
 336:	2505                	addw	a0,a0,1
    ;
  return n;
}
 338:	6422                	ld	s0,8(sp)
 33a:	0141                	add	sp,sp,16
 33c:	8082                	ret
  for(n = 0; s[n]; n++)
 33e:	4501                	li	a0,0
 340:	bfe5                	j	338 <strlen+0x20>

0000000000000342 <memset>:

void*
memset(void *dst, int c, uint n)
{
 342:	1141                	add	sp,sp,-16
 344:	e422                	sd	s0,8(sp)
 346:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 348:	ca19                	beqz	a2,35e <memset+0x1c>
 34a:	87aa                	mv	a5,a0
 34c:	1602                	sll	a2,a2,0x20
 34e:	9201                	srl	a2,a2,0x20
 350:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 354:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 358:	0785                	add	a5,a5,1
 35a:	fee79de3          	bne	a5,a4,354 <memset+0x12>
  }
  return dst;
}
 35e:	6422                	ld	s0,8(sp)
 360:	0141                	add	sp,sp,16
 362:	8082                	ret

0000000000000364 <strchr>:

char*
strchr(const char *s, char c)
{
 364:	1141                	add	sp,sp,-16
 366:	e422                	sd	s0,8(sp)
 368:	0800                	add	s0,sp,16
  for(; *s; s++)
 36a:	00054783          	lbu	a5,0(a0)
 36e:	cb99                	beqz	a5,384 <strchr+0x20>
    if(*s == c)
 370:	00f58763          	beq	a1,a5,37e <strchr+0x1a>
  for(; *s; s++)
 374:	0505                	add	a0,a0,1
 376:	00054783          	lbu	a5,0(a0)
 37a:	fbfd                	bnez	a5,370 <strchr+0xc>
      return (char*)s;
  return 0;
 37c:	4501                	li	a0,0
}
 37e:	6422                	ld	s0,8(sp)
 380:	0141                	add	sp,sp,16
 382:	8082                	ret
  return 0;
 384:	4501                	li	a0,0
 386:	bfe5                	j	37e <strchr+0x1a>

0000000000000388 <gets>:

char*
gets(char *buf, int max)
{
 388:	711d                	add	sp,sp,-96
 38a:	ec86                	sd	ra,88(sp)
 38c:	e8a2                	sd	s0,80(sp)
 38e:	e4a6                	sd	s1,72(sp)
 390:	e0ca                	sd	s2,64(sp)
 392:	fc4e                	sd	s3,56(sp)
 394:	f852                	sd	s4,48(sp)
 396:	f456                	sd	s5,40(sp)
 398:	f05a                	sd	s6,32(sp)
 39a:	ec5e                	sd	s7,24(sp)
 39c:	1080                	add	s0,sp,96
 39e:	8baa                	mv	s7,a0
 3a0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3a2:	892a                	mv	s2,a0
 3a4:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3a6:	4aa9                	li	s5,10
 3a8:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3aa:	89a6                	mv	s3,s1
 3ac:	2485                	addw	s1,s1,1
 3ae:	0344d863          	bge	s1,s4,3de <gets+0x56>
    cc = read(0, &c, 1);
 3b2:	4605                	li	a2,1
 3b4:	faf40593          	add	a1,s0,-81
 3b8:	4501                	li	a0,0
 3ba:	00000097          	auipc	ra,0x0
 3be:	1d6080e7          	jalr	470(ra) # 590 <read>
    if(cc < 1)
 3c2:	00a05e63          	blez	a0,3de <gets+0x56>
    buf[i++] = c;
 3c6:	faf44783          	lbu	a5,-81(s0)
 3ca:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3ce:	01578763          	beq	a5,s5,3dc <gets+0x54>
 3d2:	0905                	add	s2,s2,1
 3d4:	fd679be3          	bne	a5,s6,3aa <gets+0x22>
  for(i=0; i+1 < max; ){
 3d8:	89a6                	mv	s3,s1
 3da:	a011                	j	3de <gets+0x56>
 3dc:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3de:	99de                	add	s3,s3,s7
 3e0:	00098023          	sb	zero,0(s3)
  return buf;
}
 3e4:	855e                	mv	a0,s7
 3e6:	60e6                	ld	ra,88(sp)
 3e8:	6446                	ld	s0,80(sp)
 3ea:	64a6                	ld	s1,72(sp)
 3ec:	6906                	ld	s2,64(sp)
 3ee:	79e2                	ld	s3,56(sp)
 3f0:	7a42                	ld	s4,48(sp)
 3f2:	7aa2                	ld	s5,40(sp)
 3f4:	7b02                	ld	s6,32(sp)
 3f6:	6be2                	ld	s7,24(sp)
 3f8:	6125                	add	sp,sp,96
 3fa:	8082                	ret

00000000000003fc <stat>:

int
stat(const char *n, struct stat *st)
{
 3fc:	1101                	add	sp,sp,-32
 3fe:	ec06                	sd	ra,24(sp)
 400:	e822                	sd	s0,16(sp)
 402:	e426                	sd	s1,8(sp)
 404:	e04a                	sd	s2,0(sp)
 406:	1000                	add	s0,sp,32
 408:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 40a:	4581                	li	a1,0
 40c:	00000097          	auipc	ra,0x0
 410:	1ac080e7          	jalr	428(ra) # 5b8 <open>
  if(fd < 0)
 414:	02054563          	bltz	a0,43e <stat+0x42>
 418:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 41a:	85ca                	mv	a1,s2
 41c:	00000097          	auipc	ra,0x0
 420:	1b4080e7          	jalr	436(ra) # 5d0 <fstat>
 424:	892a                	mv	s2,a0
  close(fd);
 426:	8526                	mv	a0,s1
 428:	00000097          	auipc	ra,0x0
 42c:	178080e7          	jalr	376(ra) # 5a0 <close>
  return r;
}
 430:	854a                	mv	a0,s2
 432:	60e2                	ld	ra,24(sp)
 434:	6442                	ld	s0,16(sp)
 436:	64a2                	ld	s1,8(sp)
 438:	6902                	ld	s2,0(sp)
 43a:	6105                	add	sp,sp,32
 43c:	8082                	ret
    return -1;
 43e:	597d                	li	s2,-1
 440:	bfc5                	j	430 <stat+0x34>

0000000000000442 <atoi>:

int
atoi(const char *s)
{
 442:	1141                	add	sp,sp,-16
 444:	e422                	sd	s0,8(sp)
 446:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 448:	00054683          	lbu	a3,0(a0)
 44c:	fd06879b          	addw	a5,a3,-48
 450:	0ff7f793          	zext.b	a5,a5
 454:	4625                	li	a2,9
 456:	02f66863          	bltu	a2,a5,486 <atoi+0x44>
 45a:	872a                	mv	a4,a0
  n = 0;
 45c:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 45e:	0705                	add	a4,a4,1
 460:	0025179b          	sllw	a5,a0,0x2
 464:	9fa9                	addw	a5,a5,a0
 466:	0017979b          	sllw	a5,a5,0x1
 46a:	9fb5                	addw	a5,a5,a3
 46c:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 470:	00074683          	lbu	a3,0(a4)
 474:	fd06879b          	addw	a5,a3,-48
 478:	0ff7f793          	zext.b	a5,a5
 47c:	fef671e3          	bgeu	a2,a5,45e <atoi+0x1c>
  return n;
}
 480:	6422                	ld	s0,8(sp)
 482:	0141                	add	sp,sp,16
 484:	8082                	ret
  n = 0;
 486:	4501                	li	a0,0
 488:	bfe5                	j	480 <atoi+0x3e>

000000000000048a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 48a:	1141                	add	sp,sp,-16
 48c:	e422                	sd	s0,8(sp)
 48e:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 490:	02b57463          	bgeu	a0,a1,4b8 <memmove+0x2e>
    while(n-- > 0)
 494:	00c05f63          	blez	a2,4b2 <memmove+0x28>
 498:	1602                	sll	a2,a2,0x20
 49a:	9201                	srl	a2,a2,0x20
 49c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4a0:	872a                	mv	a4,a0
      *dst++ = *src++;
 4a2:	0585                	add	a1,a1,1
 4a4:	0705                	add	a4,a4,1
 4a6:	fff5c683          	lbu	a3,-1(a1)
 4aa:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4ae:	fee79ae3          	bne	a5,a4,4a2 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4b2:	6422                	ld	s0,8(sp)
 4b4:	0141                	add	sp,sp,16
 4b6:	8082                	ret
    dst += n;
 4b8:	00c50733          	add	a4,a0,a2
    src += n;
 4bc:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4be:	fec05ae3          	blez	a2,4b2 <memmove+0x28>
 4c2:	fff6079b          	addw	a5,a2,-1
 4c6:	1782                	sll	a5,a5,0x20
 4c8:	9381                	srl	a5,a5,0x20
 4ca:	fff7c793          	not	a5,a5
 4ce:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4d0:	15fd                	add	a1,a1,-1
 4d2:	177d                	add	a4,a4,-1
 4d4:	0005c683          	lbu	a3,0(a1)
 4d8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4dc:	fee79ae3          	bne	a5,a4,4d0 <memmove+0x46>
 4e0:	bfc9                	j	4b2 <memmove+0x28>

00000000000004e2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4e2:	1141                	add	sp,sp,-16
 4e4:	e422                	sd	s0,8(sp)
 4e6:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4e8:	ca05                	beqz	a2,518 <memcmp+0x36>
 4ea:	fff6069b          	addw	a3,a2,-1
 4ee:	1682                	sll	a3,a3,0x20
 4f0:	9281                	srl	a3,a3,0x20
 4f2:	0685                	add	a3,a3,1
 4f4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4f6:	00054783          	lbu	a5,0(a0)
 4fa:	0005c703          	lbu	a4,0(a1)
 4fe:	00e79863          	bne	a5,a4,50e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 502:	0505                	add	a0,a0,1
    p2++;
 504:	0585                	add	a1,a1,1
  while (n-- > 0) {
 506:	fed518e3          	bne	a0,a3,4f6 <memcmp+0x14>
  }
  return 0;
 50a:	4501                	li	a0,0
 50c:	a019                	j	512 <memcmp+0x30>
      return *p1 - *p2;
 50e:	40e7853b          	subw	a0,a5,a4
}
 512:	6422                	ld	s0,8(sp)
 514:	0141                	add	sp,sp,16
 516:	8082                	ret
  return 0;
 518:	4501                	li	a0,0
 51a:	bfe5                	j	512 <memcmp+0x30>

000000000000051c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 51c:	1141                	add	sp,sp,-16
 51e:	e406                	sd	ra,8(sp)
 520:	e022                	sd	s0,0(sp)
 522:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 524:	00000097          	auipc	ra,0x0
 528:	f66080e7          	jalr	-154(ra) # 48a <memmove>
}
 52c:	60a2                	ld	ra,8(sp)
 52e:	6402                	ld	s0,0(sp)
 530:	0141                	add	sp,sp,16
 532:	8082                	ret

0000000000000534 <initlock>:

// Initialize the spinlock
void initlock(struct spinlock_u *lk) {
 534:	1141                	add	sp,sp,-16
 536:	e422                	sd	s0,8(sp)
 538:	0800                	add	s0,sp,16
  lk->locked = 0;
 53a:	00052023          	sw	zero,0(a0)
}
 53e:	6422                	ld	s0,8(sp)
 540:	0141                	add	sp,sp,16
 542:	8082                	ret

0000000000000544 <acquire>:

// Acquire the spinlock
void acquire(struct spinlock_u *lk) {
 544:	1141                	add	sp,sp,-16
 546:	e422                	sd	s0,8(sp)
 548:	0800                	add	s0,sp,16
  while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 54a:	4705                	li	a4,1
 54c:	87ba                	mv	a5,a4
 54e:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
 552:	2781                	sext.w	a5,a5
 554:	ffe5                	bnez	a5,54c <acquire+0x8>
    ; // Spin until the lock is acquired
}
 556:	6422                	ld	s0,8(sp)
 558:	0141                	add	sp,sp,16
 55a:	8082                	ret

000000000000055c <release>:

// Release the spinlock
void release(struct spinlock_u *lk) {
 55c:	1141                	add	sp,sp,-16
 55e:	e422                	sd	s0,8(sp)
 560:	0800                	add	s0,sp,16
  __sync_lock_release(&lk->locked);
 562:	0f50000f          	fence	iorw,ow
 566:	0805202f          	amoswap.w	zero,zero,(a0)
}
 56a:	6422                	ld	s0,8(sp)
 56c:	0141                	add	sp,sp,16
 56e:	8082                	ret

0000000000000570 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 570:	4885                	li	a7,1
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <exit>:
.global exit
exit:
 li a7, SYS_exit
 578:	4889                	li	a7,2
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <wait>:
.global wait
wait:
 li a7, SYS_wait
 580:	488d                	li	a7,3
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 588:	4891                	li	a7,4
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <read>:
.global read
read:
 li a7, SYS_read
 590:	4895                	li	a7,5
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <write>:
.global write
write:
 li a7, SYS_write
 598:	48c1                	li	a7,16
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <close>:
.global close
close:
 li a7, SYS_close
 5a0:	48d5                	li	a7,21
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5a8:	4899                	li	a7,6
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5b0:	489d                	li	a7,7
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <open>:
.global open
open:
 li a7, SYS_open
 5b8:	48bd                	li	a7,15
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5c0:	48c5                	li	a7,17
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5c8:	48c9                	li	a7,18
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5d0:	48a1                	li	a7,8
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <link>:
.global link
link:
 li a7, SYS_link
 5d8:	48cd                	li	a7,19
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5e0:	48d1                	li	a7,20
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5e8:	48a5                	li	a7,9
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5f0:	48a9                	li	a7,10
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5f8:	48ad                	li	a7,11
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 600:	48b1                	li	a7,12
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 608:	48b5                	li	a7,13
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 610:	48b9                	li	a7,14
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <rcureadlock>:
.global rcureadlock
rcureadlock:
 li a7, SYS_rcureadlock
 618:	48dd                	li	a7,23
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <rcureadunlock>:
.global rcureadunlock
rcureadunlock:
 li a7, SYS_rcureadunlock
 620:	48e1                	li	a7,24
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <rcusync>:
.global rcusync
rcusync:
 li a7, SYS_rcusync
 628:	48d9                	li	a7,22
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <thread_create>:
.global thread_create
thread_create:
 li a7, SYS_thread_create
 630:	48e5                	li	a7,25
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <thread_join>:
.global thread_join
thread_join:
 li a7, SYS_thread_join
 638:	48e9                	li	a7,26
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <thread_exit>:
.global thread_exit
thread_exit:
 li a7, SYS_thread_exit
 640:	48ed                	li	a7,27
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <klist_insert>:
.global klist_insert
klist_insert:
 li a7, SYS_klist_insert
 648:	48f1                	li	a7,28
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <klist_delete>:
.global klist_delete
klist_delete:
 li a7, SYS_klist_delete
 650:	48f5                	li	a7,29
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <klist_query>:
.global klist_query
klist_query:
 li a7, SYS_klist_query
 658:	48f9                	li	a7,30
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <klist_print>:
.global klist_print
klist_print:
 li a7, SYS_klist_print
 660:	48fd                	li	a7,31
 ecall
 662:	00000073          	ecall
 ret
 666:	8082                	ret

0000000000000668 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 668:	1101                	add	sp,sp,-32
 66a:	ec06                	sd	ra,24(sp)
 66c:	e822                	sd	s0,16(sp)
 66e:	1000                	add	s0,sp,32
 670:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 674:	4605                	li	a2,1
 676:	fef40593          	add	a1,s0,-17
 67a:	00000097          	auipc	ra,0x0
 67e:	f1e080e7          	jalr	-226(ra) # 598 <write>
}
 682:	60e2                	ld	ra,24(sp)
 684:	6442                	ld	s0,16(sp)
 686:	6105                	add	sp,sp,32
 688:	8082                	ret

000000000000068a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 68a:	7139                	add	sp,sp,-64
 68c:	fc06                	sd	ra,56(sp)
 68e:	f822                	sd	s0,48(sp)
 690:	f426                	sd	s1,40(sp)
 692:	f04a                	sd	s2,32(sp)
 694:	ec4e                	sd	s3,24(sp)
 696:	0080                	add	s0,sp,64
 698:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 69a:	c299                	beqz	a3,6a0 <printint+0x16>
 69c:	0805c963          	bltz	a1,72e <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6a0:	2581                	sext.w	a1,a1
  neg = 0;
 6a2:	4881                	li	a7,0
 6a4:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 6a8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6aa:	2601                	sext.w	a2,a2
 6ac:	00000517          	auipc	a0,0x0
 6b0:	6ec50513          	add	a0,a0,1772 # d98 <digits>
 6b4:	883a                	mv	a6,a4
 6b6:	2705                	addw	a4,a4,1
 6b8:	02c5f7bb          	remuw	a5,a1,a2
 6bc:	1782                	sll	a5,a5,0x20
 6be:	9381                	srl	a5,a5,0x20
 6c0:	97aa                	add	a5,a5,a0
 6c2:	0007c783          	lbu	a5,0(a5)
 6c6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6ca:	0005879b          	sext.w	a5,a1
 6ce:	02c5d5bb          	divuw	a1,a1,a2
 6d2:	0685                	add	a3,a3,1
 6d4:	fec7f0e3          	bgeu	a5,a2,6b4 <printint+0x2a>
  if(neg)
 6d8:	00088c63          	beqz	a7,6f0 <printint+0x66>
    buf[i++] = '-';
 6dc:	fd070793          	add	a5,a4,-48
 6e0:	00878733          	add	a4,a5,s0
 6e4:	02d00793          	li	a5,45
 6e8:	fef70823          	sb	a5,-16(a4)
 6ec:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 6f0:	02e05863          	blez	a4,720 <printint+0x96>
 6f4:	fc040793          	add	a5,s0,-64
 6f8:	00e78933          	add	s2,a5,a4
 6fc:	fff78993          	add	s3,a5,-1
 700:	99ba                	add	s3,s3,a4
 702:	377d                	addw	a4,a4,-1
 704:	1702                	sll	a4,a4,0x20
 706:	9301                	srl	a4,a4,0x20
 708:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 70c:	fff94583          	lbu	a1,-1(s2)
 710:	8526                	mv	a0,s1
 712:	00000097          	auipc	ra,0x0
 716:	f56080e7          	jalr	-170(ra) # 668 <putc>
  while(--i >= 0)
 71a:	197d                	add	s2,s2,-1
 71c:	ff3918e3          	bne	s2,s3,70c <printint+0x82>
}
 720:	70e2                	ld	ra,56(sp)
 722:	7442                	ld	s0,48(sp)
 724:	74a2                	ld	s1,40(sp)
 726:	7902                	ld	s2,32(sp)
 728:	69e2                	ld	s3,24(sp)
 72a:	6121                	add	sp,sp,64
 72c:	8082                	ret
    x = -xx;
 72e:	40b005bb          	negw	a1,a1
    neg = 1;
 732:	4885                	li	a7,1
    x = -xx;
 734:	bf85                	j	6a4 <printint+0x1a>

0000000000000736 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 736:	715d                	add	sp,sp,-80
 738:	e486                	sd	ra,72(sp)
 73a:	e0a2                	sd	s0,64(sp)
 73c:	fc26                	sd	s1,56(sp)
 73e:	f84a                	sd	s2,48(sp)
 740:	f44e                	sd	s3,40(sp)
 742:	f052                	sd	s4,32(sp)
 744:	ec56                	sd	s5,24(sp)
 746:	e85a                	sd	s6,16(sp)
 748:	e45e                	sd	s7,8(sp)
 74a:	e062                	sd	s8,0(sp)
 74c:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 74e:	0005c903          	lbu	s2,0(a1)
 752:	18090c63          	beqz	s2,8ea <vprintf+0x1b4>
 756:	8aaa                	mv	s5,a0
 758:	8bb2                	mv	s7,a2
 75a:	00158493          	add	s1,a1,1
  state = 0;
 75e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 760:	02500a13          	li	s4,37
 764:	4b55                	li	s6,21
 766:	a839                	j	784 <vprintf+0x4e>
        putc(fd, c);
 768:	85ca                	mv	a1,s2
 76a:	8556                	mv	a0,s5
 76c:	00000097          	auipc	ra,0x0
 770:	efc080e7          	jalr	-260(ra) # 668 <putc>
 774:	a019                	j	77a <vprintf+0x44>
    } else if(state == '%'){
 776:	01498d63          	beq	s3,s4,790 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 77a:	0485                	add	s1,s1,1
 77c:	fff4c903          	lbu	s2,-1(s1)
 780:	16090563          	beqz	s2,8ea <vprintf+0x1b4>
    if(state == 0){
 784:	fe0999e3          	bnez	s3,776 <vprintf+0x40>
      if(c == '%'){
 788:	ff4910e3          	bne	s2,s4,768 <vprintf+0x32>
        state = '%';
 78c:	89d2                	mv	s3,s4
 78e:	b7f5                	j	77a <vprintf+0x44>
      if(c == 'd'){
 790:	13490263          	beq	s2,s4,8b4 <vprintf+0x17e>
 794:	f9d9079b          	addw	a5,s2,-99
 798:	0ff7f793          	zext.b	a5,a5
 79c:	12fb6563          	bltu	s6,a5,8c6 <vprintf+0x190>
 7a0:	f9d9079b          	addw	a5,s2,-99
 7a4:	0ff7f713          	zext.b	a4,a5
 7a8:	10eb6f63          	bltu	s6,a4,8c6 <vprintf+0x190>
 7ac:	00271793          	sll	a5,a4,0x2
 7b0:	00000717          	auipc	a4,0x0
 7b4:	59070713          	add	a4,a4,1424 # d40 <updateNode+0x12e>
 7b8:	97ba                	add	a5,a5,a4
 7ba:	439c                	lw	a5,0(a5)
 7bc:	97ba                	add	a5,a5,a4
 7be:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 7c0:	008b8913          	add	s2,s7,8
 7c4:	4685                	li	a3,1
 7c6:	4629                	li	a2,10
 7c8:	000ba583          	lw	a1,0(s7)
 7cc:	8556                	mv	a0,s5
 7ce:	00000097          	auipc	ra,0x0
 7d2:	ebc080e7          	jalr	-324(ra) # 68a <printint>
 7d6:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7d8:	4981                	li	s3,0
 7da:	b745                	j	77a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7dc:	008b8913          	add	s2,s7,8
 7e0:	4681                	li	a3,0
 7e2:	4629                	li	a2,10
 7e4:	000ba583          	lw	a1,0(s7)
 7e8:	8556                	mv	a0,s5
 7ea:	00000097          	auipc	ra,0x0
 7ee:	ea0080e7          	jalr	-352(ra) # 68a <printint>
 7f2:	8bca                	mv	s7,s2
      state = 0;
 7f4:	4981                	li	s3,0
 7f6:	b751                	j	77a <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 7f8:	008b8913          	add	s2,s7,8
 7fc:	4681                	li	a3,0
 7fe:	4641                	li	a2,16
 800:	000ba583          	lw	a1,0(s7)
 804:	8556                	mv	a0,s5
 806:	00000097          	auipc	ra,0x0
 80a:	e84080e7          	jalr	-380(ra) # 68a <printint>
 80e:	8bca                	mv	s7,s2
      state = 0;
 810:	4981                	li	s3,0
 812:	b7a5                	j	77a <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 814:	008b8c13          	add	s8,s7,8
 818:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 81c:	03000593          	li	a1,48
 820:	8556                	mv	a0,s5
 822:	00000097          	auipc	ra,0x0
 826:	e46080e7          	jalr	-442(ra) # 668 <putc>
  putc(fd, 'x');
 82a:	07800593          	li	a1,120
 82e:	8556                	mv	a0,s5
 830:	00000097          	auipc	ra,0x0
 834:	e38080e7          	jalr	-456(ra) # 668 <putc>
 838:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 83a:	00000b97          	auipc	s7,0x0
 83e:	55eb8b93          	add	s7,s7,1374 # d98 <digits>
 842:	03c9d793          	srl	a5,s3,0x3c
 846:	97de                	add	a5,a5,s7
 848:	0007c583          	lbu	a1,0(a5)
 84c:	8556                	mv	a0,s5
 84e:	00000097          	auipc	ra,0x0
 852:	e1a080e7          	jalr	-486(ra) # 668 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 856:	0992                	sll	s3,s3,0x4
 858:	397d                	addw	s2,s2,-1
 85a:	fe0914e3          	bnez	s2,842 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 85e:	8be2                	mv	s7,s8
      state = 0;
 860:	4981                	li	s3,0
 862:	bf21                	j	77a <vprintf+0x44>
        s = va_arg(ap, char*);
 864:	008b8993          	add	s3,s7,8
 868:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 86c:	02090163          	beqz	s2,88e <vprintf+0x158>
        while(*s != 0){
 870:	00094583          	lbu	a1,0(s2)
 874:	c9a5                	beqz	a1,8e4 <vprintf+0x1ae>
          putc(fd, *s);
 876:	8556                	mv	a0,s5
 878:	00000097          	auipc	ra,0x0
 87c:	df0080e7          	jalr	-528(ra) # 668 <putc>
          s++;
 880:	0905                	add	s2,s2,1
        while(*s != 0){
 882:	00094583          	lbu	a1,0(s2)
 886:	f9e5                	bnez	a1,876 <vprintf+0x140>
        s = va_arg(ap, char*);
 888:	8bce                	mv	s7,s3
      state = 0;
 88a:	4981                	li	s3,0
 88c:	b5fd                	j	77a <vprintf+0x44>
          s = "(null)";
 88e:	00000917          	auipc	s2,0x0
 892:	4aa90913          	add	s2,s2,1194 # d38 <updateNode+0x126>
        while(*s != 0){
 896:	02800593          	li	a1,40
 89a:	bff1                	j	876 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 89c:	008b8913          	add	s2,s7,8
 8a0:	000bc583          	lbu	a1,0(s7)
 8a4:	8556                	mv	a0,s5
 8a6:	00000097          	auipc	ra,0x0
 8aa:	dc2080e7          	jalr	-574(ra) # 668 <putc>
 8ae:	8bca                	mv	s7,s2
      state = 0;
 8b0:	4981                	li	s3,0
 8b2:	b5e1                	j	77a <vprintf+0x44>
        putc(fd, c);
 8b4:	02500593          	li	a1,37
 8b8:	8556                	mv	a0,s5
 8ba:	00000097          	auipc	ra,0x0
 8be:	dae080e7          	jalr	-594(ra) # 668 <putc>
      state = 0;
 8c2:	4981                	li	s3,0
 8c4:	bd5d                	j	77a <vprintf+0x44>
        putc(fd, '%');
 8c6:	02500593          	li	a1,37
 8ca:	8556                	mv	a0,s5
 8cc:	00000097          	auipc	ra,0x0
 8d0:	d9c080e7          	jalr	-612(ra) # 668 <putc>
        putc(fd, c);
 8d4:	85ca                	mv	a1,s2
 8d6:	8556                	mv	a0,s5
 8d8:	00000097          	auipc	ra,0x0
 8dc:	d90080e7          	jalr	-624(ra) # 668 <putc>
      state = 0;
 8e0:	4981                	li	s3,0
 8e2:	bd61                	j	77a <vprintf+0x44>
        s = va_arg(ap, char*);
 8e4:	8bce                	mv	s7,s3
      state = 0;
 8e6:	4981                	li	s3,0
 8e8:	bd49                	j	77a <vprintf+0x44>
    }
  }
}
 8ea:	60a6                	ld	ra,72(sp)
 8ec:	6406                	ld	s0,64(sp)
 8ee:	74e2                	ld	s1,56(sp)
 8f0:	7942                	ld	s2,48(sp)
 8f2:	79a2                	ld	s3,40(sp)
 8f4:	7a02                	ld	s4,32(sp)
 8f6:	6ae2                	ld	s5,24(sp)
 8f8:	6b42                	ld	s6,16(sp)
 8fa:	6ba2                	ld	s7,8(sp)
 8fc:	6c02                	ld	s8,0(sp)
 8fe:	6161                	add	sp,sp,80
 900:	8082                	ret

0000000000000902 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 902:	715d                	add	sp,sp,-80
 904:	ec06                	sd	ra,24(sp)
 906:	e822                	sd	s0,16(sp)
 908:	1000                	add	s0,sp,32
 90a:	e010                	sd	a2,0(s0)
 90c:	e414                	sd	a3,8(s0)
 90e:	e818                	sd	a4,16(s0)
 910:	ec1c                	sd	a5,24(s0)
 912:	03043023          	sd	a6,32(s0)
 916:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 91a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 91e:	8622                	mv	a2,s0
 920:	00000097          	auipc	ra,0x0
 924:	e16080e7          	jalr	-490(ra) # 736 <vprintf>
}
 928:	60e2                	ld	ra,24(sp)
 92a:	6442                	ld	s0,16(sp)
 92c:	6161                	add	sp,sp,80
 92e:	8082                	ret

0000000000000930 <printf>:

void
printf(const char *fmt, ...)
{
 930:	711d                	add	sp,sp,-96
 932:	ec06                	sd	ra,24(sp)
 934:	e822                	sd	s0,16(sp)
 936:	1000                	add	s0,sp,32
 938:	e40c                	sd	a1,8(s0)
 93a:	e810                	sd	a2,16(s0)
 93c:	ec14                	sd	a3,24(s0)
 93e:	f018                	sd	a4,32(s0)
 940:	f41c                	sd	a5,40(s0)
 942:	03043823          	sd	a6,48(s0)
 946:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 94a:	00840613          	add	a2,s0,8
 94e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 952:	85aa                	mv	a1,a0
 954:	4505                	li	a0,1
 956:	00000097          	auipc	ra,0x0
 95a:	de0080e7          	jalr	-544(ra) # 736 <vprintf>
}
 95e:	60e2                	ld	ra,24(sp)
 960:	6442                	ld	s0,16(sp)
 962:	6125                	add	sp,sp,96
 964:	8082                	ret

0000000000000966 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 966:	1141                	add	sp,sp,-16
 968:	e422                	sd	s0,8(sp)
 96a:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 96c:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 970:	00000797          	auipc	a5,0x0
 974:	6f07b783          	ld	a5,1776(a5) # 1060 <freep>
 978:	a02d                	j	9a2 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 97a:	4618                	lw	a4,8(a2)
 97c:	9f2d                	addw	a4,a4,a1
 97e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 982:	6398                	ld	a4,0(a5)
 984:	6310                	ld	a2,0(a4)
 986:	a83d                	j	9c4 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 988:	ff852703          	lw	a4,-8(a0)
 98c:	9f31                	addw	a4,a4,a2
 98e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 990:	ff053683          	ld	a3,-16(a0)
 994:	a091                	j	9d8 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 996:	6398                	ld	a4,0(a5)
 998:	00e7e463          	bltu	a5,a4,9a0 <free+0x3a>
 99c:	00e6ea63          	bltu	a3,a4,9b0 <free+0x4a>
{
 9a0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9a2:	fed7fae3          	bgeu	a5,a3,996 <free+0x30>
 9a6:	6398                	ld	a4,0(a5)
 9a8:	00e6e463          	bltu	a3,a4,9b0 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9ac:	fee7eae3          	bltu	a5,a4,9a0 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 9b0:	ff852583          	lw	a1,-8(a0)
 9b4:	6390                	ld	a2,0(a5)
 9b6:	02059813          	sll	a6,a1,0x20
 9ba:	01c85713          	srl	a4,a6,0x1c
 9be:	9736                	add	a4,a4,a3
 9c0:	fae60de3          	beq	a2,a4,97a <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 9c4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9c8:	4790                	lw	a2,8(a5)
 9ca:	02061593          	sll	a1,a2,0x20
 9ce:	01c5d713          	srl	a4,a1,0x1c
 9d2:	973e                	add	a4,a4,a5
 9d4:	fae68ae3          	beq	a3,a4,988 <free+0x22>
    p->s.ptr = bp->s.ptr;
 9d8:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9da:	00000717          	auipc	a4,0x0
 9de:	68f73323          	sd	a5,1670(a4) # 1060 <freep>
}
 9e2:	6422                	ld	s0,8(sp)
 9e4:	0141                	add	sp,sp,16
 9e6:	8082                	ret

00000000000009e8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9e8:	7139                	add	sp,sp,-64
 9ea:	fc06                	sd	ra,56(sp)
 9ec:	f822                	sd	s0,48(sp)
 9ee:	f426                	sd	s1,40(sp)
 9f0:	f04a                	sd	s2,32(sp)
 9f2:	ec4e                	sd	s3,24(sp)
 9f4:	e852                	sd	s4,16(sp)
 9f6:	e456                	sd	s5,8(sp)
 9f8:	e05a                	sd	s6,0(sp)
 9fa:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9fc:	02051493          	sll	s1,a0,0x20
 a00:	9081                	srl	s1,s1,0x20
 a02:	04bd                	add	s1,s1,15
 a04:	8091                	srl	s1,s1,0x4
 a06:	0014899b          	addw	s3,s1,1
 a0a:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 a0c:	00000517          	auipc	a0,0x0
 a10:	65453503          	ld	a0,1620(a0) # 1060 <freep>
 a14:	c515                	beqz	a0,a40 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a16:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a18:	4798                	lw	a4,8(a5)
 a1a:	02977f63          	bgeu	a4,s1,a58 <malloc+0x70>
  if(nu < 4096)
 a1e:	8a4e                	mv	s4,s3
 a20:	0009871b          	sext.w	a4,s3
 a24:	6685                	lui	a3,0x1
 a26:	00d77363          	bgeu	a4,a3,a2c <malloc+0x44>
 a2a:	6a05                	lui	s4,0x1
 a2c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a30:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a34:	00000917          	auipc	s2,0x0
 a38:	62c90913          	add	s2,s2,1580 # 1060 <freep>
  if(p == (char*)-1)
 a3c:	5afd                	li	s5,-1
 a3e:	a895                	j	ab2 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 a40:	00000797          	auipc	a5,0x0
 a44:	63078793          	add	a5,a5,1584 # 1070 <base>
 a48:	00000717          	auipc	a4,0x0
 a4c:	60f73c23          	sd	a5,1560(a4) # 1060 <freep>
 a50:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a52:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a56:	b7e1                	j	a1e <malloc+0x36>
      if(p->s.size == nunits)
 a58:	02e48c63          	beq	s1,a4,a90 <malloc+0xa8>
        p->s.size -= nunits;
 a5c:	4137073b          	subw	a4,a4,s3
 a60:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a62:	02071693          	sll	a3,a4,0x20
 a66:	01c6d713          	srl	a4,a3,0x1c
 a6a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a6c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a70:	00000717          	auipc	a4,0x0
 a74:	5ea73823          	sd	a0,1520(a4) # 1060 <freep>
      return (void*)(p + 1);
 a78:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a7c:	70e2                	ld	ra,56(sp)
 a7e:	7442                	ld	s0,48(sp)
 a80:	74a2                	ld	s1,40(sp)
 a82:	7902                	ld	s2,32(sp)
 a84:	69e2                	ld	s3,24(sp)
 a86:	6a42                	ld	s4,16(sp)
 a88:	6aa2                	ld	s5,8(sp)
 a8a:	6b02                	ld	s6,0(sp)
 a8c:	6121                	add	sp,sp,64
 a8e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a90:	6398                	ld	a4,0(a5)
 a92:	e118                	sd	a4,0(a0)
 a94:	bff1                	j	a70 <malloc+0x88>
  hp->s.size = nu;
 a96:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a9a:	0541                	add	a0,a0,16
 a9c:	00000097          	auipc	ra,0x0
 aa0:	eca080e7          	jalr	-310(ra) # 966 <free>
  return freep;
 aa4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 aa8:	d971                	beqz	a0,a7c <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aaa:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 aac:	4798                	lw	a4,8(a5)
 aae:	fa9775e3          	bgeu	a4,s1,a58 <malloc+0x70>
    if(p == freep)
 ab2:	00093703          	ld	a4,0(s2)
 ab6:	853e                	mv	a0,a5
 ab8:	fef719e3          	bne	a4,a5,aaa <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 abc:	8552                	mv	a0,s4
 abe:	00000097          	auipc	ra,0x0
 ac2:	b42080e7          	jalr	-1214(ra) # 600 <sbrk>
  if(p == (char*)-1)
 ac6:	fd5518e3          	bne	a0,s5,a96 <malloc+0xae>
        return 0;
 aca:	4501                	li	a0,0
 acc:	bf45                	j	a7c <malloc+0x94>

0000000000000ace <init_lock>:
#include "linkedlist.h"

// Define a node structure for the linked list
struct spinlock_u list_lock;

void init_lock(){
 ace:	1141                	add	sp,sp,-16
 ad0:	e406                	sd	ra,8(sp)
 ad2:	e022                	sd	s0,0(sp)
 ad4:	0800                	add	s0,sp,16
    initlock(&list_lock);
 ad6:	00000517          	auipc	a0,0x0
 ada:	59250513          	add	a0,a0,1426 # 1068 <list_lock>
 ade:	00000097          	auipc	ra,0x0
 ae2:	a56080e7          	jalr	-1450(ra) # 534 <initlock>
}
 ae6:	60a2                	ld	ra,8(sp)
 ae8:	6402                	ld	s0,0(sp)
 aea:	0141                	add	sp,sp,16
 aec:	8082                	ret

0000000000000aee <insert>:

// Function to insert a node at the beginning of the linked list
void insert(struct Node **head_ref, int new_data) {
 aee:	1101                	add	sp,sp,-32
 af0:	ec06                	sd	ra,24(sp)
 af2:	e822                	sd	s0,16(sp)
 af4:	e426                	sd	s1,8(sp)
 af6:	e04a                	sd	s2,0(sp)
 af8:	1000                	add	s0,sp,32
 afa:	84aa                	mv	s1,a0
 afc:	892e                	mv	s2,a1
    struct Node *new_node = malloc(sizeof(struct Node));
 afe:	4541                	li	a0,16
 b00:	00000097          	auipc	ra,0x0
 b04:	ee8080e7          	jalr	-280(ra) # 9e8 <malloc>
    new_node->data = new_data;
 b08:	01252023          	sw	s2,0(a0)
    new_node->next = *head_ref;
 b0c:	609c                	ld	a5,0(s1)
 b0e:	e51c                	sd	a5,8(a0)
    *head_ref = new_node;
 b10:	e088                	sd	a0,0(s1)
}
 b12:	60e2                	ld	ra,24(sp)
 b14:	6442                	ld	s0,16(sp)
 b16:	64a2                	ld	s1,8(sp)
 b18:	6902                	ld	s2,0(sp)
 b1a:	6105                	add	sp,sp,32
 b1c:	8082                	ret

0000000000000b1e <deleteNode>:

// Function to delete a node with a given key from the linked list
void deleteNode(struct Node **head_ref, int key) {
 b1e:	7179                	add	sp,sp,-48
 b20:	f406                	sd	ra,40(sp)
 b22:	f022                	sd	s0,32(sp)
 b24:	ec26                	sd	s1,24(sp)
 b26:	e84a                	sd	s2,16(sp)
 b28:	e44e                	sd	s3,8(sp)
 b2a:	1800                	add	s0,sp,48
 b2c:	89aa                	mv	s3,a0
 b2e:	892e                	mv	s2,a1
    struct Node *temp = *head_ref, *prev = 0;
 b30:	6104                	ld	s1,0(a0)

    acquire(&list_lock);
 b32:	00000517          	auipc	a0,0x0
 b36:	53650513          	add	a0,a0,1334 # 1068 <list_lock>
 b3a:	00000097          	auipc	ra,0x0
 b3e:	a0a080e7          	jalr	-1526(ra) # 544 <acquire>
    if (temp != 0 && temp->data == key) {
 b42:	c0b1                	beqz	s1,b86 <deleteNode+0x68>
 b44:	409c                	lw	a5,0(s1)
 b46:	4701                	li	a4,0
 b48:	01278a63          	beq	a5,s2,b5c <deleteNode+0x3e>
        rcusync();
        free(temp);
        return;
    }

    while (temp != 0 && temp->data != key) {
 b4c:	409c                	lw	a5,0(s1)
 b4e:	05278563          	beq	a5,s2,b98 <deleteNode+0x7a>
        prev = temp;
        temp = temp->next;
 b52:	649c                	ld	a5,8(s1)
    while (temp != 0 && temp->data != key) {
 b54:	8726                	mv	a4,s1
 b56:	cb85                	beqz	a5,b86 <deleteNode+0x68>
        temp = temp->next;
 b58:	84be                	mv	s1,a5
 b5a:	bfcd                	j	b4c <deleteNode+0x2e>
        *head_ref = temp->next;
 b5c:	649c                	ld	a5,8(s1)
 b5e:	00f9b023          	sd	a5,0(s3)
        release(&list_lock);
 b62:	00000517          	auipc	a0,0x0
 b66:	50650513          	add	a0,a0,1286 # 1068 <list_lock>
 b6a:	00000097          	auipc	ra,0x0
 b6e:	9f2080e7          	jalr	-1550(ra) # 55c <release>
        rcusync();
 b72:	00000097          	auipc	ra,0x0
 b76:	ab6080e7          	jalr	-1354(ra) # 628 <rcusync>
        free(temp);
 b7a:	8526                	mv	a0,s1
 b7c:	00000097          	auipc	ra,0x0
 b80:	dea080e7          	jalr	-534(ra) # 966 <free>
        return;
 b84:	a82d                	j	bbe <deleteNode+0xa0>
    }

    if (temp == 0) {
        release(&list_lock);
 b86:	00000517          	auipc	a0,0x0
 b8a:	4e250513          	add	a0,a0,1250 # 1068 <list_lock>
 b8e:	00000097          	auipc	ra,0x0
 b92:	9ce080e7          	jalr	-1586(ra) # 55c <release>
        return;
 b96:	a025                	j	bbe <deleteNode+0xa0>
    }
    prev->next = temp->next;
 b98:	649c                	ld	a5,8(s1)
 b9a:	e71c                	sd	a5,8(a4)
    release(&list_lock);
 b9c:	00000517          	auipc	a0,0x0
 ba0:	4cc50513          	add	a0,a0,1228 # 1068 <list_lock>
 ba4:	00000097          	auipc	ra,0x0
 ba8:	9b8080e7          	jalr	-1608(ra) # 55c <release>
    rcusync();
 bac:	00000097          	auipc	ra,0x0
 bb0:	a7c080e7          	jalr	-1412(ra) # 628 <rcusync>
    free(temp);
 bb4:	8526                	mv	a0,s1
 bb6:	00000097          	auipc	ra,0x0
 bba:	db0080e7          	jalr	-592(ra) # 966 <free>
}
 bbe:	70a2                	ld	ra,40(sp)
 bc0:	7402                	ld	s0,32(sp)
 bc2:	64e2                	ld	s1,24(sp)
 bc4:	6942                	ld	s2,16(sp)
 bc6:	69a2                	ld	s3,8(sp)
 bc8:	6145                	add	sp,sp,48
 bca:	8082                	ret

0000000000000bcc <search>:

// Function to search for a node with a given key in the linked list
struct Node* search(struct Node *head, int key) {
 bcc:	1101                	add	sp,sp,-32
 bce:	ec06                	sd	ra,24(sp)
 bd0:	e822                	sd	s0,16(sp)
 bd2:	e426                	sd	s1,8(sp)
 bd4:	e04a                	sd	s2,0(sp)
 bd6:	1000                	add	s0,sp,32
 bd8:	84aa                	mv	s1,a0
 bda:	892e                	mv	s2,a1

    struct Node *current = head;
    rcureadlock();
 bdc:	00000097          	auipc	ra,0x0
 be0:	a3c080e7          	jalr	-1476(ra) # 618 <rcureadlock>
    while (current != 0) {
 be4:	c491                	beqz	s1,bf0 <search+0x24>
        if (current->data == key) {
 be6:	409c                	lw	a5,0(s1)
 be8:	01278f63          	beq	a5,s2,c06 <search+0x3a>
            rcureadunlock();
            return current; // Node found
        }
        current = current->next;
 bec:	6484                	ld	s1,8(s1)
    while (current != 0) {
 bee:	fce5                	bnez	s1,be6 <search+0x1a>
    }
    rcureadunlock();
 bf0:	00000097          	auipc	ra,0x0
 bf4:	a30080e7          	jalr	-1488(ra) # 620 <rcureadunlock>
    return 0; // Node not found
 bf8:	4501                	li	a0,0
}
 bfa:	60e2                	ld	ra,24(sp)
 bfc:	6442                	ld	s0,16(sp)
 bfe:	64a2                	ld	s1,8(sp)
 c00:	6902                	ld	s2,0(sp)
 c02:	6105                	add	sp,sp,32
 c04:	8082                	ret
            rcureadunlock();
 c06:	00000097          	auipc	ra,0x0
 c0a:	a1a080e7          	jalr	-1510(ra) # 620 <rcureadunlock>
            return current; // Node found
 c0e:	8526                	mv	a0,s1
 c10:	b7ed                	j	bfa <search+0x2e>

0000000000000c12 <updateNode>:

// Function to update the value of a node with a given key in the linked list
void updateNode(struct Node *head, int key, int new_data) {
 c12:	1101                	add	sp,sp,-32
 c14:	ec06                	sd	ra,24(sp)
 c16:	e822                	sd	s0,16(sp)
 c18:	e426                	sd	s1,8(sp)
 c1a:	e04a                	sd	s2,0(sp)
 c1c:	1000                	add	s0,sp,32
 c1e:	892e                	mv	s2,a1
 c20:	84b2                	mv	s1,a2
    struct Node *nodeToUpdate = search(head, key);
 c22:	00000097          	auipc	ra,0x0
 c26:	faa080e7          	jalr	-86(ra) # bcc <search>

    if (nodeToUpdate != 0) {
 c2a:	c901                	beqz	a0,c3a <updateNode+0x28>
        nodeToUpdate->data = new_data; // Update the node's data
 c2c:	c104                	sw	s1,0(a0)
    } else {
        printf("Node with key %d not found.\n", key);
    }
}
 c2e:	60e2                	ld	ra,24(sp)
 c30:	6442                	ld	s0,16(sp)
 c32:	64a2                	ld	s1,8(sp)
 c34:	6902                	ld	s2,0(sp)
 c36:	6105                	add	sp,sp,32
 c38:	8082                	ret
        printf("Node with key %d not found.\n", key);
 c3a:	85ca                	mv	a1,s2
 c3c:	00000517          	auipc	a0,0x0
 c40:	17450513          	add	a0,a0,372 # db0 <digits+0x18>
 c44:	00000097          	auipc	ra,0x0
 c48:	cec080e7          	jalr	-788(ra) # 930 <printf>
}
 c4c:	b7cd                	j	c2e <updateNode+0x1c>
