
user/_forktest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print>:

#define N  1000

void
print(const char *s)
{
   0:	1101                	add	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	add	s0,sp,32
   a:	84aa                	mv	s1,a0
  write(1, s, strlen(s));
   c:	00000097          	auipc	ra,0x0
  10:	174080e7          	jalr	372(ra) # 180 <strlen>
  14:	0005061b          	sext.w	a2,a0
  18:	85a6                	mv	a1,s1
  1a:	4505                	li	a0,1
  1c:	00000097          	auipc	ra,0x0
  20:	3e4080e7          	jalr	996(ra) # 400 <write>
}
  24:	60e2                	ld	ra,24(sp)
  26:	6442                	ld	s0,16(sp)
  28:	64a2                	ld	s1,8(sp)
  2a:	6105                	add	sp,sp,32
  2c:	8082                	ret

000000000000002e <forktest>:

void
forktest(void)
{
  2e:	1101                	add	sp,sp,-32
  30:	ec06                	sd	ra,24(sp)
  32:	e822                	sd	s0,16(sp)
  34:	e426                	sd	s1,8(sp)
  36:	e04a                	sd	s2,0(sp)
  38:	1000                	add	s0,sp,32
  int n, pid;

  print("fork test\n");
  3a:	00000517          	auipc	a0,0x0
  3e:	49650513          	add	a0,a0,1174 # 4d0 <klist_print+0x8>
  42:	00000097          	auipc	ra,0x0
  46:	fbe080e7          	jalr	-66(ra) # 0 <print>

  for(n=0; n<N; n++){
  4a:	4481                	li	s1,0
  4c:	3e800913          	li	s2,1000
    pid = fork();
  50:	00000097          	auipc	ra,0x0
  54:	388080e7          	jalr	904(ra) # 3d8 <fork>
    if(pid < 0)
  58:	02054763          	bltz	a0,86 <forktest+0x58>
      break;
    if(pid == 0)
  5c:	c10d                	beqz	a0,7e <forktest+0x50>
  for(n=0; n<N; n++){
  5e:	2485                	addw	s1,s1,1
  60:	ff2498e3          	bne	s1,s2,50 <forktest+0x22>
      exit(0);
  }

  if(n == N){
    print("fork claimed to work N times!\n");
  64:	00000517          	auipc	a0,0x0
  68:	47c50513          	add	a0,a0,1148 # 4e0 <klist_print+0x18>
  6c:	00000097          	auipc	ra,0x0
  70:	f94080e7          	jalr	-108(ra) # 0 <print>
    exit(1);
  74:	4505                	li	a0,1
  76:	00000097          	auipc	ra,0x0
  7a:	36a080e7          	jalr	874(ra) # 3e0 <exit>
      exit(0);
  7e:	00000097          	auipc	ra,0x0
  82:	362080e7          	jalr	866(ra) # 3e0 <exit>
  if(n == N){
  86:	3e800793          	li	a5,1000
  8a:	fcf48de3          	beq	s1,a5,64 <forktest+0x36>
  }

  for(; n > 0; n--){
  8e:	00905b63          	blez	s1,a4 <forktest+0x76>
    if(wait(0) < 0){
  92:	4501                	li	a0,0
  94:	00000097          	auipc	ra,0x0
  98:	354080e7          	jalr	852(ra) # 3e8 <wait>
  9c:	02054a63          	bltz	a0,d0 <forktest+0xa2>
  for(; n > 0; n--){
  a0:	34fd                	addw	s1,s1,-1
  a2:	f8e5                	bnez	s1,92 <forktest+0x64>
      print("wait stopped early\n");
      exit(1);
    }
  }

  if(wait(0) != -1){
  a4:	4501                	li	a0,0
  a6:	00000097          	auipc	ra,0x0
  aa:	342080e7          	jalr	834(ra) # 3e8 <wait>
  ae:	57fd                	li	a5,-1
  b0:	02f51d63          	bne	a0,a5,ea <forktest+0xbc>
    print("wait got too many\n");
    exit(1);
  }

  print("fork test OK\n");
  b4:	00000517          	auipc	a0,0x0
  b8:	47c50513          	add	a0,a0,1148 # 530 <klist_print+0x68>
  bc:	00000097          	auipc	ra,0x0
  c0:	f44080e7          	jalr	-188(ra) # 0 <print>
}
  c4:	60e2                	ld	ra,24(sp)
  c6:	6442                	ld	s0,16(sp)
  c8:	64a2                	ld	s1,8(sp)
  ca:	6902                	ld	s2,0(sp)
  cc:	6105                	add	sp,sp,32
  ce:	8082                	ret
      print("wait stopped early\n");
  d0:	00000517          	auipc	a0,0x0
  d4:	43050513          	add	a0,a0,1072 # 500 <klist_print+0x38>
  d8:	00000097          	auipc	ra,0x0
  dc:	f28080e7          	jalr	-216(ra) # 0 <print>
      exit(1);
  e0:	4505                	li	a0,1
  e2:	00000097          	auipc	ra,0x0
  e6:	2fe080e7          	jalr	766(ra) # 3e0 <exit>
    print("wait got too many\n");
  ea:	00000517          	auipc	a0,0x0
  ee:	42e50513          	add	a0,a0,1070 # 518 <klist_print+0x50>
  f2:	00000097          	auipc	ra,0x0
  f6:	f0e080e7          	jalr	-242(ra) # 0 <print>
    exit(1);
  fa:	4505                	li	a0,1
  fc:	00000097          	auipc	ra,0x0
 100:	2e4080e7          	jalr	740(ra) # 3e0 <exit>

0000000000000104 <main>:

int
main(void)
{
 104:	1141                	add	sp,sp,-16
 106:	e406                	sd	ra,8(sp)
 108:	e022                	sd	s0,0(sp)
 10a:	0800                	add	s0,sp,16
  forktest();
 10c:	00000097          	auipc	ra,0x0
 110:	f22080e7          	jalr	-222(ra) # 2e <forktest>
  exit(0);
 114:	4501                	li	a0,0
 116:	00000097          	auipc	ra,0x0
 11a:	2ca080e7          	jalr	714(ra) # 3e0 <exit>

000000000000011e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 11e:	1141                	add	sp,sp,-16
 120:	e406                	sd	ra,8(sp)
 122:	e022                	sd	s0,0(sp)
 124:	0800                	add	s0,sp,16
  extern int main();
  main();
 126:	00000097          	auipc	ra,0x0
 12a:	fde080e7          	jalr	-34(ra) # 104 <main>
  exit(0);
 12e:	4501                	li	a0,0
 130:	00000097          	auipc	ra,0x0
 134:	2b0080e7          	jalr	688(ra) # 3e0 <exit>

0000000000000138 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 138:	1141                	add	sp,sp,-16
 13a:	e422                	sd	s0,8(sp)
 13c:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 13e:	87aa                	mv	a5,a0
 140:	0585                	add	a1,a1,1
 142:	0785                	add	a5,a5,1
 144:	fff5c703          	lbu	a4,-1(a1)
 148:	fee78fa3          	sb	a4,-1(a5)
 14c:	fb75                	bnez	a4,140 <strcpy+0x8>
    ;
  return os;
}
 14e:	6422                	ld	s0,8(sp)
 150:	0141                	add	sp,sp,16
 152:	8082                	ret

0000000000000154 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 154:	1141                	add	sp,sp,-16
 156:	e422                	sd	s0,8(sp)
 158:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 15a:	00054783          	lbu	a5,0(a0)
 15e:	cb91                	beqz	a5,172 <strcmp+0x1e>
 160:	0005c703          	lbu	a4,0(a1)
 164:	00f71763          	bne	a4,a5,172 <strcmp+0x1e>
    p++, q++;
 168:	0505                	add	a0,a0,1
 16a:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 16c:	00054783          	lbu	a5,0(a0)
 170:	fbe5                	bnez	a5,160 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 172:	0005c503          	lbu	a0,0(a1)
}
 176:	40a7853b          	subw	a0,a5,a0
 17a:	6422                	ld	s0,8(sp)
 17c:	0141                	add	sp,sp,16
 17e:	8082                	ret

0000000000000180 <strlen>:

uint
strlen(const char *s)
{
 180:	1141                	add	sp,sp,-16
 182:	e422                	sd	s0,8(sp)
 184:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 186:	00054783          	lbu	a5,0(a0)
 18a:	cf91                	beqz	a5,1a6 <strlen+0x26>
 18c:	0505                	add	a0,a0,1
 18e:	87aa                	mv	a5,a0
 190:	86be                	mv	a3,a5
 192:	0785                	add	a5,a5,1
 194:	fff7c703          	lbu	a4,-1(a5)
 198:	ff65                	bnez	a4,190 <strlen+0x10>
 19a:	40a6853b          	subw	a0,a3,a0
 19e:	2505                	addw	a0,a0,1
    ;
  return n;
}
 1a0:	6422                	ld	s0,8(sp)
 1a2:	0141                	add	sp,sp,16
 1a4:	8082                	ret
  for(n = 0; s[n]; n++)
 1a6:	4501                	li	a0,0
 1a8:	bfe5                	j	1a0 <strlen+0x20>

00000000000001aa <memset>:

void*
memset(void *dst, int c, uint n)
{
 1aa:	1141                	add	sp,sp,-16
 1ac:	e422                	sd	s0,8(sp)
 1ae:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1b0:	ca19                	beqz	a2,1c6 <memset+0x1c>
 1b2:	87aa                	mv	a5,a0
 1b4:	1602                	sll	a2,a2,0x20
 1b6:	9201                	srl	a2,a2,0x20
 1b8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1bc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1c0:	0785                	add	a5,a5,1
 1c2:	fee79de3          	bne	a5,a4,1bc <memset+0x12>
  }
  return dst;
}
 1c6:	6422                	ld	s0,8(sp)
 1c8:	0141                	add	sp,sp,16
 1ca:	8082                	ret

00000000000001cc <strchr>:

char*
strchr(const char *s, char c)
{
 1cc:	1141                	add	sp,sp,-16
 1ce:	e422                	sd	s0,8(sp)
 1d0:	0800                	add	s0,sp,16
  for(; *s; s++)
 1d2:	00054783          	lbu	a5,0(a0)
 1d6:	cb99                	beqz	a5,1ec <strchr+0x20>
    if(*s == c)
 1d8:	00f58763          	beq	a1,a5,1e6 <strchr+0x1a>
  for(; *s; s++)
 1dc:	0505                	add	a0,a0,1
 1de:	00054783          	lbu	a5,0(a0)
 1e2:	fbfd                	bnez	a5,1d8 <strchr+0xc>
      return (char*)s;
  return 0;
 1e4:	4501                	li	a0,0
}
 1e6:	6422                	ld	s0,8(sp)
 1e8:	0141                	add	sp,sp,16
 1ea:	8082                	ret
  return 0;
 1ec:	4501                	li	a0,0
 1ee:	bfe5                	j	1e6 <strchr+0x1a>

00000000000001f0 <gets>:

char*
gets(char *buf, int max)
{
 1f0:	711d                	add	sp,sp,-96
 1f2:	ec86                	sd	ra,88(sp)
 1f4:	e8a2                	sd	s0,80(sp)
 1f6:	e4a6                	sd	s1,72(sp)
 1f8:	e0ca                	sd	s2,64(sp)
 1fa:	fc4e                	sd	s3,56(sp)
 1fc:	f852                	sd	s4,48(sp)
 1fe:	f456                	sd	s5,40(sp)
 200:	f05a                	sd	s6,32(sp)
 202:	ec5e                	sd	s7,24(sp)
 204:	1080                	add	s0,sp,96
 206:	8baa                	mv	s7,a0
 208:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 20a:	892a                	mv	s2,a0
 20c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 20e:	4aa9                	li	s5,10
 210:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 212:	89a6                	mv	s3,s1
 214:	2485                	addw	s1,s1,1
 216:	0344d863          	bge	s1,s4,246 <gets+0x56>
    cc = read(0, &c, 1);
 21a:	4605                	li	a2,1
 21c:	faf40593          	add	a1,s0,-81
 220:	4501                	li	a0,0
 222:	00000097          	auipc	ra,0x0
 226:	1d6080e7          	jalr	470(ra) # 3f8 <read>
    if(cc < 1)
 22a:	00a05e63          	blez	a0,246 <gets+0x56>
    buf[i++] = c;
 22e:	faf44783          	lbu	a5,-81(s0)
 232:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 236:	01578763          	beq	a5,s5,244 <gets+0x54>
 23a:	0905                	add	s2,s2,1
 23c:	fd679be3          	bne	a5,s6,212 <gets+0x22>
  for(i=0; i+1 < max; ){
 240:	89a6                	mv	s3,s1
 242:	a011                	j	246 <gets+0x56>
 244:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 246:	99de                	add	s3,s3,s7
 248:	00098023          	sb	zero,0(s3)
  return buf;
}
 24c:	855e                	mv	a0,s7
 24e:	60e6                	ld	ra,88(sp)
 250:	6446                	ld	s0,80(sp)
 252:	64a6                	ld	s1,72(sp)
 254:	6906                	ld	s2,64(sp)
 256:	79e2                	ld	s3,56(sp)
 258:	7a42                	ld	s4,48(sp)
 25a:	7aa2                	ld	s5,40(sp)
 25c:	7b02                	ld	s6,32(sp)
 25e:	6be2                	ld	s7,24(sp)
 260:	6125                	add	sp,sp,96
 262:	8082                	ret

0000000000000264 <stat>:

int
stat(const char *n, struct stat *st)
{
 264:	1101                	add	sp,sp,-32
 266:	ec06                	sd	ra,24(sp)
 268:	e822                	sd	s0,16(sp)
 26a:	e426                	sd	s1,8(sp)
 26c:	e04a                	sd	s2,0(sp)
 26e:	1000                	add	s0,sp,32
 270:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 272:	4581                	li	a1,0
 274:	00000097          	auipc	ra,0x0
 278:	1ac080e7          	jalr	428(ra) # 420 <open>
  if(fd < 0)
 27c:	02054563          	bltz	a0,2a6 <stat+0x42>
 280:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 282:	85ca                	mv	a1,s2
 284:	00000097          	auipc	ra,0x0
 288:	1b4080e7          	jalr	436(ra) # 438 <fstat>
 28c:	892a                	mv	s2,a0
  close(fd);
 28e:	8526                	mv	a0,s1
 290:	00000097          	auipc	ra,0x0
 294:	178080e7          	jalr	376(ra) # 408 <close>
  return r;
}
 298:	854a                	mv	a0,s2
 29a:	60e2                	ld	ra,24(sp)
 29c:	6442                	ld	s0,16(sp)
 29e:	64a2                	ld	s1,8(sp)
 2a0:	6902                	ld	s2,0(sp)
 2a2:	6105                	add	sp,sp,32
 2a4:	8082                	ret
    return -1;
 2a6:	597d                	li	s2,-1
 2a8:	bfc5                	j	298 <stat+0x34>

00000000000002aa <atoi>:

int
atoi(const char *s)
{
 2aa:	1141                	add	sp,sp,-16
 2ac:	e422                	sd	s0,8(sp)
 2ae:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2b0:	00054683          	lbu	a3,0(a0)
 2b4:	fd06879b          	addw	a5,a3,-48
 2b8:	0ff7f793          	zext.b	a5,a5
 2bc:	4625                	li	a2,9
 2be:	02f66863          	bltu	a2,a5,2ee <atoi+0x44>
 2c2:	872a                	mv	a4,a0
  n = 0;
 2c4:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2c6:	0705                	add	a4,a4,1
 2c8:	0025179b          	sllw	a5,a0,0x2
 2cc:	9fa9                	addw	a5,a5,a0
 2ce:	0017979b          	sllw	a5,a5,0x1
 2d2:	9fb5                	addw	a5,a5,a3
 2d4:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2d8:	00074683          	lbu	a3,0(a4)
 2dc:	fd06879b          	addw	a5,a3,-48
 2e0:	0ff7f793          	zext.b	a5,a5
 2e4:	fef671e3          	bgeu	a2,a5,2c6 <atoi+0x1c>
  return n;
}
 2e8:	6422                	ld	s0,8(sp)
 2ea:	0141                	add	sp,sp,16
 2ec:	8082                	ret
  n = 0;
 2ee:	4501                	li	a0,0
 2f0:	bfe5                	j	2e8 <atoi+0x3e>

00000000000002f2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2f2:	1141                	add	sp,sp,-16
 2f4:	e422                	sd	s0,8(sp)
 2f6:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2f8:	02b57463          	bgeu	a0,a1,320 <memmove+0x2e>
    while(n-- > 0)
 2fc:	00c05f63          	blez	a2,31a <memmove+0x28>
 300:	1602                	sll	a2,a2,0x20
 302:	9201                	srl	a2,a2,0x20
 304:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 308:	872a                	mv	a4,a0
      *dst++ = *src++;
 30a:	0585                	add	a1,a1,1
 30c:	0705                	add	a4,a4,1
 30e:	fff5c683          	lbu	a3,-1(a1)
 312:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 316:	fee79ae3          	bne	a5,a4,30a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 31a:	6422                	ld	s0,8(sp)
 31c:	0141                	add	sp,sp,16
 31e:	8082                	ret
    dst += n;
 320:	00c50733          	add	a4,a0,a2
    src += n;
 324:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 326:	fec05ae3          	blez	a2,31a <memmove+0x28>
 32a:	fff6079b          	addw	a5,a2,-1
 32e:	1782                	sll	a5,a5,0x20
 330:	9381                	srl	a5,a5,0x20
 332:	fff7c793          	not	a5,a5
 336:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 338:	15fd                	add	a1,a1,-1
 33a:	177d                	add	a4,a4,-1
 33c:	0005c683          	lbu	a3,0(a1)
 340:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 344:	fee79ae3          	bne	a5,a4,338 <memmove+0x46>
 348:	bfc9                	j	31a <memmove+0x28>

000000000000034a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 34a:	1141                	add	sp,sp,-16
 34c:	e422                	sd	s0,8(sp)
 34e:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 350:	ca05                	beqz	a2,380 <memcmp+0x36>
 352:	fff6069b          	addw	a3,a2,-1
 356:	1682                	sll	a3,a3,0x20
 358:	9281                	srl	a3,a3,0x20
 35a:	0685                	add	a3,a3,1
 35c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 35e:	00054783          	lbu	a5,0(a0)
 362:	0005c703          	lbu	a4,0(a1)
 366:	00e79863          	bne	a5,a4,376 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 36a:	0505                	add	a0,a0,1
    p2++;
 36c:	0585                	add	a1,a1,1
  while (n-- > 0) {
 36e:	fed518e3          	bne	a0,a3,35e <memcmp+0x14>
  }
  return 0;
 372:	4501                	li	a0,0
 374:	a019                	j	37a <memcmp+0x30>
      return *p1 - *p2;
 376:	40e7853b          	subw	a0,a5,a4
}
 37a:	6422                	ld	s0,8(sp)
 37c:	0141                	add	sp,sp,16
 37e:	8082                	ret
  return 0;
 380:	4501                	li	a0,0
 382:	bfe5                	j	37a <memcmp+0x30>

0000000000000384 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 384:	1141                	add	sp,sp,-16
 386:	e406                	sd	ra,8(sp)
 388:	e022                	sd	s0,0(sp)
 38a:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 38c:	00000097          	auipc	ra,0x0
 390:	f66080e7          	jalr	-154(ra) # 2f2 <memmove>
}
 394:	60a2                	ld	ra,8(sp)
 396:	6402                	ld	s0,0(sp)
 398:	0141                	add	sp,sp,16
 39a:	8082                	ret

000000000000039c <initlock>:

// Initialize the spinlock
void initlock(struct spinlock_u *lk) {
 39c:	1141                	add	sp,sp,-16
 39e:	e422                	sd	s0,8(sp)
 3a0:	0800                	add	s0,sp,16
  lk->locked = 0;
 3a2:	00052023          	sw	zero,0(a0)
}
 3a6:	6422                	ld	s0,8(sp)
 3a8:	0141                	add	sp,sp,16
 3aa:	8082                	ret

00000000000003ac <acquire>:

// Acquire the spinlock
void acquire(struct spinlock_u *lk) {
 3ac:	1141                	add	sp,sp,-16
 3ae:	e422                	sd	s0,8(sp)
 3b0:	0800                	add	s0,sp,16
  while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 3b2:	4705                	li	a4,1
 3b4:	87ba                	mv	a5,a4
 3b6:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
 3ba:	2781                	sext.w	a5,a5
 3bc:	ffe5                	bnez	a5,3b4 <acquire+0x8>
    ; // Spin until the lock is acquired
}
 3be:	6422                	ld	s0,8(sp)
 3c0:	0141                	add	sp,sp,16
 3c2:	8082                	ret

00000000000003c4 <release>:

// Release the spinlock
void release(struct spinlock_u *lk) {
 3c4:	1141                	add	sp,sp,-16
 3c6:	e422                	sd	s0,8(sp)
 3c8:	0800                	add	s0,sp,16
  __sync_lock_release(&lk->locked);
 3ca:	0f50000f          	fence	iorw,ow
 3ce:	0805202f          	amoswap.w	zero,zero,(a0)
}
 3d2:	6422                	ld	s0,8(sp)
 3d4:	0141                	add	sp,sp,16
 3d6:	8082                	ret

00000000000003d8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3d8:	4885                	li	a7,1
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3e0:	4889                	li	a7,2
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3e8:	488d                	li	a7,3
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3f0:	4891                	li	a7,4
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <read>:
.global read
read:
 li a7, SYS_read
 3f8:	4895                	li	a7,5
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <write>:
.global write
write:
 li a7, SYS_write
 400:	48c1                	li	a7,16
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <close>:
.global close
close:
 li a7, SYS_close
 408:	48d5                	li	a7,21
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <kill>:
.global kill
kill:
 li a7, SYS_kill
 410:	4899                	li	a7,6
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <exec>:
.global exec
exec:
 li a7, SYS_exec
 418:	489d                	li	a7,7
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <open>:
.global open
open:
 li a7, SYS_open
 420:	48bd                	li	a7,15
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 428:	48c5                	li	a7,17
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 430:	48c9                	li	a7,18
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 438:	48a1                	li	a7,8
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <link>:
.global link
link:
 li a7, SYS_link
 440:	48cd                	li	a7,19
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 448:	48d1                	li	a7,20
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 450:	48a5                	li	a7,9
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <dup>:
.global dup
dup:
 li a7, SYS_dup
 458:	48a9                	li	a7,10
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 460:	48ad                	li	a7,11
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 468:	48b1                	li	a7,12
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 470:	48b5                	li	a7,13
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 478:	48b9                	li	a7,14
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <rcureadlock>:
.global rcureadlock
rcureadlock:
 li a7, SYS_rcureadlock
 480:	48dd                	li	a7,23
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <rcureadunlock>:
.global rcureadunlock
rcureadunlock:
 li a7, SYS_rcureadunlock
 488:	48e1                	li	a7,24
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <rcusync>:
.global rcusync
rcusync:
 li a7, SYS_rcusync
 490:	48d9                	li	a7,22
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <thread_create>:
.global thread_create
thread_create:
 li a7, SYS_thread_create
 498:	48e5                	li	a7,25
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <thread_join>:
.global thread_join
thread_join:
 li a7, SYS_thread_join
 4a0:	48e9                	li	a7,26
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <thread_exit>:
.global thread_exit
thread_exit:
 li a7, SYS_thread_exit
 4a8:	48ed                	li	a7,27
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <klist_insert>:
.global klist_insert
klist_insert:
 li a7, SYS_klist_insert
 4b0:	48f1                	li	a7,28
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <klist_delete>:
.global klist_delete
klist_delete:
 li a7, SYS_klist_delete
 4b8:	48f5                	li	a7,29
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <klist_query>:
.global klist_query
klist_query:
 li a7, SYS_klist_query
 4c0:	48f9                	li	a7,30
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <klist_print>:
.global klist_print
klist_print:
 li a7, SYS_klist_print
 4c8:	48fd                	li	a7,31
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret
