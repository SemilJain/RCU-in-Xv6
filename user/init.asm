
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	1101                	add	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	add	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   c:	4589                	li	a1,2
   e:	00001517          	auipc	a0,0x1
  12:	a8250513          	add	a0,a0,-1406 # a90 <updateNode+0x3c>
  16:	00000097          	auipc	ra,0x0
  1a:	3e4080e7          	jalr	996(ra) # 3fa <open>
  1e:	06054363          	bltz	a0,84 <main+0x84>
    mknod("console", CONSOLE, 0);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  22:	4501                	li	a0,0
  24:	00000097          	auipc	ra,0x0
  28:	40e080e7          	jalr	1038(ra) # 432 <dup>
  dup(0);  // stderr
  2c:	4501                	li	a0,0
  2e:	00000097          	auipc	ra,0x0
  32:	404080e7          	jalr	1028(ra) # 432 <dup>

  for(;;){
    printf("init: starting sh\n");
  36:	00001917          	auipc	s2,0x1
  3a:	a6290913          	add	s2,s2,-1438 # a98 <updateNode+0x44>
  3e:	854a                	mv	a0,s2
  40:	00000097          	auipc	ra,0x0
  44:	732080e7          	jalr	1842(ra) # 772 <printf>
    pid = fork();
  48:	00000097          	auipc	ra,0x0
  4c:	36a080e7          	jalr	874(ra) # 3b2 <fork>
  50:	84aa                	mv	s1,a0
    if(pid < 0){
  52:	04054d63          	bltz	a0,ac <main+0xac>
      printf("init: fork failed\n");
      exit(1);
    }
    if(pid == 0){
  56:	c925                	beqz	a0,c6 <main+0xc6>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  58:	4501                	li	a0,0
  5a:	00000097          	auipc	ra,0x0
  5e:	368080e7          	jalr	872(ra) # 3c2 <wait>
      if(wpid == pid){
  62:	fca48ee3          	beq	s1,a0,3e <main+0x3e>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  66:	fe0559e3          	bgez	a0,58 <main+0x58>
        printf("init: wait returned an error\n");
  6a:	00001517          	auipc	a0,0x1
  6e:	a7e50513          	add	a0,a0,-1410 # ae8 <updateNode+0x94>
  72:	00000097          	auipc	ra,0x0
  76:	700080e7          	jalr	1792(ra) # 772 <printf>
        exit(1);
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	33e080e7          	jalr	830(ra) # 3ba <exit>
    mknod("console", CONSOLE, 0);
  84:	4601                	li	a2,0
  86:	4585                	li	a1,1
  88:	00001517          	auipc	a0,0x1
  8c:	a0850513          	add	a0,a0,-1528 # a90 <updateNode+0x3c>
  90:	00000097          	auipc	ra,0x0
  94:	372080e7          	jalr	882(ra) # 402 <mknod>
    open("console", O_RDWR);
  98:	4589                	li	a1,2
  9a:	00001517          	auipc	a0,0x1
  9e:	9f650513          	add	a0,a0,-1546 # a90 <updateNode+0x3c>
  a2:	00000097          	auipc	ra,0x0
  a6:	358080e7          	jalr	856(ra) # 3fa <open>
  aa:	bfa5                	j	22 <main+0x22>
      printf("init: fork failed\n");
  ac:	00001517          	auipc	a0,0x1
  b0:	a0450513          	add	a0,a0,-1532 # ab0 <updateNode+0x5c>
  b4:	00000097          	auipc	ra,0x0
  b8:	6be080e7          	jalr	1726(ra) # 772 <printf>
      exit(1);
  bc:	4505                	li	a0,1
  be:	00000097          	auipc	ra,0x0
  c2:	2fc080e7          	jalr	764(ra) # 3ba <exit>
      exec("sh", argv);
  c6:	00001597          	auipc	a1,0x1
  ca:	f3a58593          	add	a1,a1,-198 # 1000 <argv>
  ce:	00001517          	auipc	a0,0x1
  d2:	9fa50513          	add	a0,a0,-1542 # ac8 <updateNode+0x74>
  d6:	00000097          	auipc	ra,0x0
  da:	31c080e7          	jalr	796(ra) # 3f2 <exec>
      printf("init: exec sh failed\n");
  de:	00001517          	auipc	a0,0x1
  e2:	9f250513          	add	a0,a0,-1550 # ad0 <updateNode+0x7c>
  e6:	00000097          	auipc	ra,0x0
  ea:	68c080e7          	jalr	1676(ra) # 772 <printf>
      exit(1);
  ee:	4505                	li	a0,1
  f0:	00000097          	auipc	ra,0x0
  f4:	2ca080e7          	jalr	714(ra) # 3ba <exit>

00000000000000f8 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  f8:	1141                	add	sp,sp,-16
  fa:	e406                	sd	ra,8(sp)
  fc:	e022                	sd	s0,0(sp)
  fe:	0800                	add	s0,sp,16
  extern int main();
  main();
 100:	00000097          	auipc	ra,0x0
 104:	f00080e7          	jalr	-256(ra) # 0 <main>
  exit(0);
 108:	4501                	li	a0,0
 10a:	00000097          	auipc	ra,0x0
 10e:	2b0080e7          	jalr	688(ra) # 3ba <exit>

0000000000000112 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 112:	1141                	add	sp,sp,-16
 114:	e422                	sd	s0,8(sp)
 116:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 118:	87aa                	mv	a5,a0
 11a:	0585                	add	a1,a1,1
 11c:	0785                	add	a5,a5,1
 11e:	fff5c703          	lbu	a4,-1(a1)
 122:	fee78fa3          	sb	a4,-1(a5)
 126:	fb75                	bnez	a4,11a <strcpy+0x8>
    ;
  return os;
}
 128:	6422                	ld	s0,8(sp)
 12a:	0141                	add	sp,sp,16
 12c:	8082                	ret

000000000000012e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 12e:	1141                	add	sp,sp,-16
 130:	e422                	sd	s0,8(sp)
 132:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 134:	00054783          	lbu	a5,0(a0)
 138:	cb91                	beqz	a5,14c <strcmp+0x1e>
 13a:	0005c703          	lbu	a4,0(a1)
 13e:	00f71763          	bne	a4,a5,14c <strcmp+0x1e>
    p++, q++;
 142:	0505                	add	a0,a0,1
 144:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 146:	00054783          	lbu	a5,0(a0)
 14a:	fbe5                	bnez	a5,13a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 14c:	0005c503          	lbu	a0,0(a1)
}
 150:	40a7853b          	subw	a0,a5,a0
 154:	6422                	ld	s0,8(sp)
 156:	0141                	add	sp,sp,16
 158:	8082                	ret

000000000000015a <strlen>:

uint
strlen(const char *s)
{
 15a:	1141                	add	sp,sp,-16
 15c:	e422                	sd	s0,8(sp)
 15e:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 160:	00054783          	lbu	a5,0(a0)
 164:	cf91                	beqz	a5,180 <strlen+0x26>
 166:	0505                	add	a0,a0,1
 168:	87aa                	mv	a5,a0
 16a:	86be                	mv	a3,a5
 16c:	0785                	add	a5,a5,1
 16e:	fff7c703          	lbu	a4,-1(a5)
 172:	ff65                	bnez	a4,16a <strlen+0x10>
 174:	40a6853b          	subw	a0,a3,a0
 178:	2505                	addw	a0,a0,1
    ;
  return n;
}
 17a:	6422                	ld	s0,8(sp)
 17c:	0141                	add	sp,sp,16
 17e:	8082                	ret
  for(n = 0; s[n]; n++)
 180:	4501                	li	a0,0
 182:	bfe5                	j	17a <strlen+0x20>

0000000000000184 <memset>:

void*
memset(void *dst, int c, uint n)
{
 184:	1141                	add	sp,sp,-16
 186:	e422                	sd	s0,8(sp)
 188:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 18a:	ca19                	beqz	a2,1a0 <memset+0x1c>
 18c:	87aa                	mv	a5,a0
 18e:	1602                	sll	a2,a2,0x20
 190:	9201                	srl	a2,a2,0x20
 192:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 196:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 19a:	0785                	add	a5,a5,1
 19c:	fee79de3          	bne	a5,a4,196 <memset+0x12>
  }
  return dst;
}
 1a0:	6422                	ld	s0,8(sp)
 1a2:	0141                	add	sp,sp,16
 1a4:	8082                	ret

00000000000001a6 <strchr>:

char*
strchr(const char *s, char c)
{
 1a6:	1141                	add	sp,sp,-16
 1a8:	e422                	sd	s0,8(sp)
 1aa:	0800                	add	s0,sp,16
  for(; *s; s++)
 1ac:	00054783          	lbu	a5,0(a0)
 1b0:	cb99                	beqz	a5,1c6 <strchr+0x20>
    if(*s == c)
 1b2:	00f58763          	beq	a1,a5,1c0 <strchr+0x1a>
  for(; *s; s++)
 1b6:	0505                	add	a0,a0,1
 1b8:	00054783          	lbu	a5,0(a0)
 1bc:	fbfd                	bnez	a5,1b2 <strchr+0xc>
      return (char*)s;
  return 0;
 1be:	4501                	li	a0,0
}
 1c0:	6422                	ld	s0,8(sp)
 1c2:	0141                	add	sp,sp,16
 1c4:	8082                	ret
  return 0;
 1c6:	4501                	li	a0,0
 1c8:	bfe5                	j	1c0 <strchr+0x1a>

00000000000001ca <gets>:

char*
gets(char *buf, int max)
{
 1ca:	711d                	add	sp,sp,-96
 1cc:	ec86                	sd	ra,88(sp)
 1ce:	e8a2                	sd	s0,80(sp)
 1d0:	e4a6                	sd	s1,72(sp)
 1d2:	e0ca                	sd	s2,64(sp)
 1d4:	fc4e                	sd	s3,56(sp)
 1d6:	f852                	sd	s4,48(sp)
 1d8:	f456                	sd	s5,40(sp)
 1da:	f05a                	sd	s6,32(sp)
 1dc:	ec5e                	sd	s7,24(sp)
 1de:	1080                	add	s0,sp,96
 1e0:	8baa                	mv	s7,a0
 1e2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e4:	892a                	mv	s2,a0
 1e6:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1e8:	4aa9                	li	s5,10
 1ea:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1ec:	89a6                	mv	s3,s1
 1ee:	2485                	addw	s1,s1,1
 1f0:	0344d863          	bge	s1,s4,220 <gets+0x56>
    cc = read(0, &c, 1);
 1f4:	4605                	li	a2,1
 1f6:	faf40593          	add	a1,s0,-81
 1fa:	4501                	li	a0,0
 1fc:	00000097          	auipc	ra,0x0
 200:	1d6080e7          	jalr	470(ra) # 3d2 <read>
    if(cc < 1)
 204:	00a05e63          	blez	a0,220 <gets+0x56>
    buf[i++] = c;
 208:	faf44783          	lbu	a5,-81(s0)
 20c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 210:	01578763          	beq	a5,s5,21e <gets+0x54>
 214:	0905                	add	s2,s2,1
 216:	fd679be3          	bne	a5,s6,1ec <gets+0x22>
  for(i=0; i+1 < max; ){
 21a:	89a6                	mv	s3,s1
 21c:	a011                	j	220 <gets+0x56>
 21e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 220:	99de                	add	s3,s3,s7
 222:	00098023          	sb	zero,0(s3)
  return buf;
}
 226:	855e                	mv	a0,s7
 228:	60e6                	ld	ra,88(sp)
 22a:	6446                	ld	s0,80(sp)
 22c:	64a6                	ld	s1,72(sp)
 22e:	6906                	ld	s2,64(sp)
 230:	79e2                	ld	s3,56(sp)
 232:	7a42                	ld	s4,48(sp)
 234:	7aa2                	ld	s5,40(sp)
 236:	7b02                	ld	s6,32(sp)
 238:	6be2                	ld	s7,24(sp)
 23a:	6125                	add	sp,sp,96
 23c:	8082                	ret

000000000000023e <stat>:

int
stat(const char *n, struct stat *st)
{
 23e:	1101                	add	sp,sp,-32
 240:	ec06                	sd	ra,24(sp)
 242:	e822                	sd	s0,16(sp)
 244:	e426                	sd	s1,8(sp)
 246:	e04a                	sd	s2,0(sp)
 248:	1000                	add	s0,sp,32
 24a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 24c:	4581                	li	a1,0
 24e:	00000097          	auipc	ra,0x0
 252:	1ac080e7          	jalr	428(ra) # 3fa <open>
  if(fd < 0)
 256:	02054563          	bltz	a0,280 <stat+0x42>
 25a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 25c:	85ca                	mv	a1,s2
 25e:	00000097          	auipc	ra,0x0
 262:	1b4080e7          	jalr	436(ra) # 412 <fstat>
 266:	892a                	mv	s2,a0
  close(fd);
 268:	8526                	mv	a0,s1
 26a:	00000097          	auipc	ra,0x0
 26e:	178080e7          	jalr	376(ra) # 3e2 <close>
  return r;
}
 272:	854a                	mv	a0,s2
 274:	60e2                	ld	ra,24(sp)
 276:	6442                	ld	s0,16(sp)
 278:	64a2                	ld	s1,8(sp)
 27a:	6902                	ld	s2,0(sp)
 27c:	6105                	add	sp,sp,32
 27e:	8082                	ret
    return -1;
 280:	597d                	li	s2,-1
 282:	bfc5                	j	272 <stat+0x34>

0000000000000284 <atoi>:

int
atoi(const char *s)
{
 284:	1141                	add	sp,sp,-16
 286:	e422                	sd	s0,8(sp)
 288:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 28a:	00054683          	lbu	a3,0(a0)
 28e:	fd06879b          	addw	a5,a3,-48
 292:	0ff7f793          	zext.b	a5,a5
 296:	4625                	li	a2,9
 298:	02f66863          	bltu	a2,a5,2c8 <atoi+0x44>
 29c:	872a                	mv	a4,a0
  n = 0;
 29e:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2a0:	0705                	add	a4,a4,1
 2a2:	0025179b          	sllw	a5,a0,0x2
 2a6:	9fa9                	addw	a5,a5,a0
 2a8:	0017979b          	sllw	a5,a5,0x1
 2ac:	9fb5                	addw	a5,a5,a3
 2ae:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2b2:	00074683          	lbu	a3,0(a4)
 2b6:	fd06879b          	addw	a5,a3,-48
 2ba:	0ff7f793          	zext.b	a5,a5
 2be:	fef671e3          	bgeu	a2,a5,2a0 <atoi+0x1c>
  return n;
}
 2c2:	6422                	ld	s0,8(sp)
 2c4:	0141                	add	sp,sp,16
 2c6:	8082                	ret
  n = 0;
 2c8:	4501                	li	a0,0
 2ca:	bfe5                	j	2c2 <atoi+0x3e>

00000000000002cc <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2cc:	1141                	add	sp,sp,-16
 2ce:	e422                	sd	s0,8(sp)
 2d0:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2d2:	02b57463          	bgeu	a0,a1,2fa <memmove+0x2e>
    while(n-- > 0)
 2d6:	00c05f63          	blez	a2,2f4 <memmove+0x28>
 2da:	1602                	sll	a2,a2,0x20
 2dc:	9201                	srl	a2,a2,0x20
 2de:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2e2:	872a                	mv	a4,a0
      *dst++ = *src++;
 2e4:	0585                	add	a1,a1,1
 2e6:	0705                	add	a4,a4,1
 2e8:	fff5c683          	lbu	a3,-1(a1)
 2ec:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2f0:	fee79ae3          	bne	a5,a4,2e4 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2f4:	6422                	ld	s0,8(sp)
 2f6:	0141                	add	sp,sp,16
 2f8:	8082                	ret
    dst += n;
 2fa:	00c50733          	add	a4,a0,a2
    src += n;
 2fe:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 300:	fec05ae3          	blez	a2,2f4 <memmove+0x28>
 304:	fff6079b          	addw	a5,a2,-1
 308:	1782                	sll	a5,a5,0x20
 30a:	9381                	srl	a5,a5,0x20
 30c:	fff7c793          	not	a5,a5
 310:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 312:	15fd                	add	a1,a1,-1
 314:	177d                	add	a4,a4,-1
 316:	0005c683          	lbu	a3,0(a1)
 31a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 31e:	fee79ae3          	bne	a5,a4,312 <memmove+0x46>
 322:	bfc9                	j	2f4 <memmove+0x28>

0000000000000324 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 324:	1141                	add	sp,sp,-16
 326:	e422                	sd	s0,8(sp)
 328:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 32a:	ca05                	beqz	a2,35a <memcmp+0x36>
 32c:	fff6069b          	addw	a3,a2,-1
 330:	1682                	sll	a3,a3,0x20
 332:	9281                	srl	a3,a3,0x20
 334:	0685                	add	a3,a3,1
 336:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 338:	00054783          	lbu	a5,0(a0)
 33c:	0005c703          	lbu	a4,0(a1)
 340:	00e79863          	bne	a5,a4,350 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 344:	0505                	add	a0,a0,1
    p2++;
 346:	0585                	add	a1,a1,1
  while (n-- > 0) {
 348:	fed518e3          	bne	a0,a3,338 <memcmp+0x14>
  }
  return 0;
 34c:	4501                	li	a0,0
 34e:	a019                	j	354 <memcmp+0x30>
      return *p1 - *p2;
 350:	40e7853b          	subw	a0,a5,a4
}
 354:	6422                	ld	s0,8(sp)
 356:	0141                	add	sp,sp,16
 358:	8082                	ret
  return 0;
 35a:	4501                	li	a0,0
 35c:	bfe5                	j	354 <memcmp+0x30>

000000000000035e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 35e:	1141                	add	sp,sp,-16
 360:	e406                	sd	ra,8(sp)
 362:	e022                	sd	s0,0(sp)
 364:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 366:	00000097          	auipc	ra,0x0
 36a:	f66080e7          	jalr	-154(ra) # 2cc <memmove>
}
 36e:	60a2                	ld	ra,8(sp)
 370:	6402                	ld	s0,0(sp)
 372:	0141                	add	sp,sp,16
 374:	8082                	ret

0000000000000376 <initlock>:

// Initialize the spinlock
void initlock(struct spinlock_u *lk) {
 376:	1141                	add	sp,sp,-16
 378:	e422                	sd	s0,8(sp)
 37a:	0800                	add	s0,sp,16
  lk->locked = 0;
 37c:	00052023          	sw	zero,0(a0)
}
 380:	6422                	ld	s0,8(sp)
 382:	0141                	add	sp,sp,16
 384:	8082                	ret

0000000000000386 <acquire>:

// Acquire the spinlock
void acquire(struct spinlock_u *lk) {
 386:	1141                	add	sp,sp,-16
 388:	e422                	sd	s0,8(sp)
 38a:	0800                	add	s0,sp,16
  while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 38c:	4705                	li	a4,1
 38e:	87ba                	mv	a5,a4
 390:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
 394:	2781                	sext.w	a5,a5
 396:	ffe5                	bnez	a5,38e <acquire+0x8>
    ; // Spin until the lock is acquired
}
 398:	6422                	ld	s0,8(sp)
 39a:	0141                	add	sp,sp,16
 39c:	8082                	ret

000000000000039e <release>:

// Release the spinlock
void release(struct spinlock_u *lk) {
 39e:	1141                	add	sp,sp,-16
 3a0:	e422                	sd	s0,8(sp)
 3a2:	0800                	add	s0,sp,16
  __sync_lock_release(&lk->locked);
 3a4:	0f50000f          	fence	iorw,ow
 3a8:	0805202f          	amoswap.w	zero,zero,(a0)
}
 3ac:	6422                	ld	s0,8(sp)
 3ae:	0141                	add	sp,sp,16
 3b0:	8082                	ret

00000000000003b2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3b2:	4885                	li	a7,1
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <exit>:
.global exit
exit:
 li a7, SYS_exit
 3ba:	4889                	li	a7,2
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3c2:	488d                	li	a7,3
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3ca:	4891                	li	a7,4
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <read>:
.global read
read:
 li a7, SYS_read
 3d2:	4895                	li	a7,5
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <write>:
.global write
write:
 li a7, SYS_write
 3da:	48c1                	li	a7,16
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <close>:
.global close
close:
 li a7, SYS_close
 3e2:	48d5                	li	a7,21
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <kill>:
.global kill
kill:
 li a7, SYS_kill
 3ea:	4899                	li	a7,6
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3f2:	489d                	li	a7,7
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <open>:
.global open
open:
 li a7, SYS_open
 3fa:	48bd                	li	a7,15
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 402:	48c5                	li	a7,17
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 40a:	48c9                	li	a7,18
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 412:	48a1                	li	a7,8
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <link>:
.global link
link:
 li a7, SYS_link
 41a:	48cd                	li	a7,19
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 422:	48d1                	li	a7,20
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 42a:	48a5                	li	a7,9
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <dup>:
.global dup
dup:
 li a7, SYS_dup
 432:	48a9                	li	a7,10
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 43a:	48ad                	li	a7,11
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 442:	48b1                	li	a7,12
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 44a:	48b5                	li	a7,13
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 452:	48b9                	li	a7,14
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <rcureadlock>:
.global rcureadlock
rcureadlock:
 li a7, SYS_rcureadlock
 45a:	48dd                	li	a7,23
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <rcureadunlock>:
.global rcureadunlock
rcureadunlock:
 li a7, SYS_rcureadunlock
 462:	48e1                	li	a7,24
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <rcusync>:
.global rcusync
rcusync:
 li a7, SYS_rcusync
 46a:	48d9                	li	a7,22
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <thread_create>:
.global thread_create
thread_create:
 li a7, SYS_thread_create
 472:	48e5                	li	a7,25
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <thread_join>:
.global thread_join
thread_join:
 li a7, SYS_thread_join
 47a:	48e9                	li	a7,26
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <thread_exit>:
.global thread_exit
thread_exit:
 li a7, SYS_thread_exit
 482:	48ed                	li	a7,27
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <klist_insert>:
.global klist_insert
klist_insert:
 li a7, SYS_klist_insert
 48a:	48f1                	li	a7,28
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <klist_delete>:
.global klist_delete
klist_delete:
 li a7, SYS_klist_delete
 492:	48f5                	li	a7,29
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <klist_query>:
.global klist_query
klist_query:
 li a7, SYS_klist_query
 49a:	48f9                	li	a7,30
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <klist_print>:
.global klist_print
klist_print:
 li a7, SYS_klist_print
 4a2:	48fd                	li	a7,31
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4aa:	1101                	add	sp,sp,-32
 4ac:	ec06                	sd	ra,24(sp)
 4ae:	e822                	sd	s0,16(sp)
 4b0:	1000                	add	s0,sp,32
 4b2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4b6:	4605                	li	a2,1
 4b8:	fef40593          	add	a1,s0,-17
 4bc:	00000097          	auipc	ra,0x0
 4c0:	f1e080e7          	jalr	-226(ra) # 3da <write>
}
 4c4:	60e2                	ld	ra,24(sp)
 4c6:	6442                	ld	s0,16(sp)
 4c8:	6105                	add	sp,sp,32
 4ca:	8082                	ret

00000000000004cc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4cc:	7139                	add	sp,sp,-64
 4ce:	fc06                	sd	ra,56(sp)
 4d0:	f822                	sd	s0,48(sp)
 4d2:	f426                	sd	s1,40(sp)
 4d4:	f04a                	sd	s2,32(sp)
 4d6:	ec4e                	sd	s3,24(sp)
 4d8:	0080                	add	s0,sp,64
 4da:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4dc:	c299                	beqz	a3,4e2 <printint+0x16>
 4de:	0805c963          	bltz	a1,570 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4e2:	2581                	sext.w	a1,a1
  neg = 0;
 4e4:	4881                	li	a7,0
 4e6:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 4ea:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4ec:	2601                	sext.w	a2,a2
 4ee:	00000517          	auipc	a0,0x0
 4f2:	67a50513          	add	a0,a0,1658 # b68 <digits>
 4f6:	883a                	mv	a6,a4
 4f8:	2705                	addw	a4,a4,1
 4fa:	02c5f7bb          	remuw	a5,a1,a2
 4fe:	1782                	sll	a5,a5,0x20
 500:	9381                	srl	a5,a5,0x20
 502:	97aa                	add	a5,a5,a0
 504:	0007c783          	lbu	a5,0(a5)
 508:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 50c:	0005879b          	sext.w	a5,a1
 510:	02c5d5bb          	divuw	a1,a1,a2
 514:	0685                	add	a3,a3,1
 516:	fec7f0e3          	bgeu	a5,a2,4f6 <printint+0x2a>
  if(neg)
 51a:	00088c63          	beqz	a7,532 <printint+0x66>
    buf[i++] = '-';
 51e:	fd070793          	add	a5,a4,-48
 522:	00878733          	add	a4,a5,s0
 526:	02d00793          	li	a5,45
 52a:	fef70823          	sb	a5,-16(a4)
 52e:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 532:	02e05863          	blez	a4,562 <printint+0x96>
 536:	fc040793          	add	a5,s0,-64
 53a:	00e78933          	add	s2,a5,a4
 53e:	fff78993          	add	s3,a5,-1
 542:	99ba                	add	s3,s3,a4
 544:	377d                	addw	a4,a4,-1
 546:	1702                	sll	a4,a4,0x20
 548:	9301                	srl	a4,a4,0x20
 54a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 54e:	fff94583          	lbu	a1,-1(s2)
 552:	8526                	mv	a0,s1
 554:	00000097          	auipc	ra,0x0
 558:	f56080e7          	jalr	-170(ra) # 4aa <putc>
  while(--i >= 0)
 55c:	197d                	add	s2,s2,-1
 55e:	ff3918e3          	bne	s2,s3,54e <printint+0x82>
}
 562:	70e2                	ld	ra,56(sp)
 564:	7442                	ld	s0,48(sp)
 566:	74a2                	ld	s1,40(sp)
 568:	7902                	ld	s2,32(sp)
 56a:	69e2                	ld	s3,24(sp)
 56c:	6121                	add	sp,sp,64
 56e:	8082                	ret
    x = -xx;
 570:	40b005bb          	negw	a1,a1
    neg = 1;
 574:	4885                	li	a7,1
    x = -xx;
 576:	bf85                	j	4e6 <printint+0x1a>

0000000000000578 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 578:	715d                	add	sp,sp,-80
 57a:	e486                	sd	ra,72(sp)
 57c:	e0a2                	sd	s0,64(sp)
 57e:	fc26                	sd	s1,56(sp)
 580:	f84a                	sd	s2,48(sp)
 582:	f44e                	sd	s3,40(sp)
 584:	f052                	sd	s4,32(sp)
 586:	ec56                	sd	s5,24(sp)
 588:	e85a                	sd	s6,16(sp)
 58a:	e45e                	sd	s7,8(sp)
 58c:	e062                	sd	s8,0(sp)
 58e:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 590:	0005c903          	lbu	s2,0(a1)
 594:	18090c63          	beqz	s2,72c <vprintf+0x1b4>
 598:	8aaa                	mv	s5,a0
 59a:	8bb2                	mv	s7,a2
 59c:	00158493          	add	s1,a1,1
  state = 0;
 5a0:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5a2:	02500a13          	li	s4,37
 5a6:	4b55                	li	s6,21
 5a8:	a839                	j	5c6 <vprintf+0x4e>
        putc(fd, c);
 5aa:	85ca                	mv	a1,s2
 5ac:	8556                	mv	a0,s5
 5ae:	00000097          	auipc	ra,0x0
 5b2:	efc080e7          	jalr	-260(ra) # 4aa <putc>
 5b6:	a019                	j	5bc <vprintf+0x44>
    } else if(state == '%'){
 5b8:	01498d63          	beq	s3,s4,5d2 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 5bc:	0485                	add	s1,s1,1
 5be:	fff4c903          	lbu	s2,-1(s1)
 5c2:	16090563          	beqz	s2,72c <vprintf+0x1b4>
    if(state == 0){
 5c6:	fe0999e3          	bnez	s3,5b8 <vprintf+0x40>
      if(c == '%'){
 5ca:	ff4910e3          	bne	s2,s4,5aa <vprintf+0x32>
        state = '%';
 5ce:	89d2                	mv	s3,s4
 5d0:	b7f5                	j	5bc <vprintf+0x44>
      if(c == 'd'){
 5d2:	13490263          	beq	s2,s4,6f6 <vprintf+0x17e>
 5d6:	f9d9079b          	addw	a5,s2,-99
 5da:	0ff7f793          	zext.b	a5,a5
 5de:	12fb6563          	bltu	s6,a5,708 <vprintf+0x190>
 5e2:	f9d9079b          	addw	a5,s2,-99
 5e6:	0ff7f713          	zext.b	a4,a5
 5ea:	10eb6f63          	bltu	s6,a4,708 <vprintf+0x190>
 5ee:	00271793          	sll	a5,a4,0x2
 5f2:	00000717          	auipc	a4,0x0
 5f6:	51e70713          	add	a4,a4,1310 # b10 <updateNode+0xbc>
 5fa:	97ba                	add	a5,a5,a4
 5fc:	439c                	lw	a5,0(a5)
 5fe:	97ba                	add	a5,a5,a4
 600:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 602:	008b8913          	add	s2,s7,8
 606:	4685                	li	a3,1
 608:	4629                	li	a2,10
 60a:	000ba583          	lw	a1,0(s7)
 60e:	8556                	mv	a0,s5
 610:	00000097          	auipc	ra,0x0
 614:	ebc080e7          	jalr	-324(ra) # 4cc <printint>
 618:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 61a:	4981                	li	s3,0
 61c:	b745                	j	5bc <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 61e:	008b8913          	add	s2,s7,8
 622:	4681                	li	a3,0
 624:	4629                	li	a2,10
 626:	000ba583          	lw	a1,0(s7)
 62a:	8556                	mv	a0,s5
 62c:	00000097          	auipc	ra,0x0
 630:	ea0080e7          	jalr	-352(ra) # 4cc <printint>
 634:	8bca                	mv	s7,s2
      state = 0;
 636:	4981                	li	s3,0
 638:	b751                	j	5bc <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 63a:	008b8913          	add	s2,s7,8
 63e:	4681                	li	a3,0
 640:	4641                	li	a2,16
 642:	000ba583          	lw	a1,0(s7)
 646:	8556                	mv	a0,s5
 648:	00000097          	auipc	ra,0x0
 64c:	e84080e7          	jalr	-380(ra) # 4cc <printint>
 650:	8bca                	mv	s7,s2
      state = 0;
 652:	4981                	li	s3,0
 654:	b7a5                	j	5bc <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 656:	008b8c13          	add	s8,s7,8
 65a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 65e:	03000593          	li	a1,48
 662:	8556                	mv	a0,s5
 664:	00000097          	auipc	ra,0x0
 668:	e46080e7          	jalr	-442(ra) # 4aa <putc>
  putc(fd, 'x');
 66c:	07800593          	li	a1,120
 670:	8556                	mv	a0,s5
 672:	00000097          	auipc	ra,0x0
 676:	e38080e7          	jalr	-456(ra) # 4aa <putc>
 67a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 67c:	00000b97          	auipc	s7,0x0
 680:	4ecb8b93          	add	s7,s7,1260 # b68 <digits>
 684:	03c9d793          	srl	a5,s3,0x3c
 688:	97de                	add	a5,a5,s7
 68a:	0007c583          	lbu	a1,0(a5)
 68e:	8556                	mv	a0,s5
 690:	00000097          	auipc	ra,0x0
 694:	e1a080e7          	jalr	-486(ra) # 4aa <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 698:	0992                	sll	s3,s3,0x4
 69a:	397d                	addw	s2,s2,-1
 69c:	fe0914e3          	bnez	s2,684 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 6a0:	8be2                	mv	s7,s8
      state = 0;
 6a2:	4981                	li	s3,0
 6a4:	bf21                	j	5bc <vprintf+0x44>
        s = va_arg(ap, char*);
 6a6:	008b8993          	add	s3,s7,8
 6aa:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 6ae:	02090163          	beqz	s2,6d0 <vprintf+0x158>
        while(*s != 0){
 6b2:	00094583          	lbu	a1,0(s2)
 6b6:	c9a5                	beqz	a1,726 <vprintf+0x1ae>
          putc(fd, *s);
 6b8:	8556                	mv	a0,s5
 6ba:	00000097          	auipc	ra,0x0
 6be:	df0080e7          	jalr	-528(ra) # 4aa <putc>
          s++;
 6c2:	0905                	add	s2,s2,1
        while(*s != 0){
 6c4:	00094583          	lbu	a1,0(s2)
 6c8:	f9e5                	bnez	a1,6b8 <vprintf+0x140>
        s = va_arg(ap, char*);
 6ca:	8bce                	mv	s7,s3
      state = 0;
 6cc:	4981                	li	s3,0
 6ce:	b5fd                	j	5bc <vprintf+0x44>
          s = "(null)";
 6d0:	00000917          	auipc	s2,0x0
 6d4:	43890913          	add	s2,s2,1080 # b08 <updateNode+0xb4>
        while(*s != 0){
 6d8:	02800593          	li	a1,40
 6dc:	bff1                	j	6b8 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 6de:	008b8913          	add	s2,s7,8
 6e2:	000bc583          	lbu	a1,0(s7)
 6e6:	8556                	mv	a0,s5
 6e8:	00000097          	auipc	ra,0x0
 6ec:	dc2080e7          	jalr	-574(ra) # 4aa <putc>
 6f0:	8bca                	mv	s7,s2
      state = 0;
 6f2:	4981                	li	s3,0
 6f4:	b5e1                	j	5bc <vprintf+0x44>
        putc(fd, c);
 6f6:	02500593          	li	a1,37
 6fa:	8556                	mv	a0,s5
 6fc:	00000097          	auipc	ra,0x0
 700:	dae080e7          	jalr	-594(ra) # 4aa <putc>
      state = 0;
 704:	4981                	li	s3,0
 706:	bd5d                	j	5bc <vprintf+0x44>
        putc(fd, '%');
 708:	02500593          	li	a1,37
 70c:	8556                	mv	a0,s5
 70e:	00000097          	auipc	ra,0x0
 712:	d9c080e7          	jalr	-612(ra) # 4aa <putc>
        putc(fd, c);
 716:	85ca                	mv	a1,s2
 718:	8556                	mv	a0,s5
 71a:	00000097          	auipc	ra,0x0
 71e:	d90080e7          	jalr	-624(ra) # 4aa <putc>
      state = 0;
 722:	4981                	li	s3,0
 724:	bd61                	j	5bc <vprintf+0x44>
        s = va_arg(ap, char*);
 726:	8bce                	mv	s7,s3
      state = 0;
 728:	4981                	li	s3,0
 72a:	bd49                	j	5bc <vprintf+0x44>
    }
  }
}
 72c:	60a6                	ld	ra,72(sp)
 72e:	6406                	ld	s0,64(sp)
 730:	74e2                	ld	s1,56(sp)
 732:	7942                	ld	s2,48(sp)
 734:	79a2                	ld	s3,40(sp)
 736:	7a02                	ld	s4,32(sp)
 738:	6ae2                	ld	s5,24(sp)
 73a:	6b42                	ld	s6,16(sp)
 73c:	6ba2                	ld	s7,8(sp)
 73e:	6c02                	ld	s8,0(sp)
 740:	6161                	add	sp,sp,80
 742:	8082                	ret

0000000000000744 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 744:	715d                	add	sp,sp,-80
 746:	ec06                	sd	ra,24(sp)
 748:	e822                	sd	s0,16(sp)
 74a:	1000                	add	s0,sp,32
 74c:	e010                	sd	a2,0(s0)
 74e:	e414                	sd	a3,8(s0)
 750:	e818                	sd	a4,16(s0)
 752:	ec1c                	sd	a5,24(s0)
 754:	03043023          	sd	a6,32(s0)
 758:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 75c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 760:	8622                	mv	a2,s0
 762:	00000097          	auipc	ra,0x0
 766:	e16080e7          	jalr	-490(ra) # 578 <vprintf>
}
 76a:	60e2                	ld	ra,24(sp)
 76c:	6442                	ld	s0,16(sp)
 76e:	6161                	add	sp,sp,80
 770:	8082                	ret

0000000000000772 <printf>:

void
printf(const char *fmt, ...)
{
 772:	711d                	add	sp,sp,-96
 774:	ec06                	sd	ra,24(sp)
 776:	e822                	sd	s0,16(sp)
 778:	1000                	add	s0,sp,32
 77a:	e40c                	sd	a1,8(s0)
 77c:	e810                	sd	a2,16(s0)
 77e:	ec14                	sd	a3,24(s0)
 780:	f018                	sd	a4,32(s0)
 782:	f41c                	sd	a5,40(s0)
 784:	03043823          	sd	a6,48(s0)
 788:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 78c:	00840613          	add	a2,s0,8
 790:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 794:	85aa                	mv	a1,a0
 796:	4505                	li	a0,1
 798:	00000097          	auipc	ra,0x0
 79c:	de0080e7          	jalr	-544(ra) # 578 <vprintf>
}
 7a0:	60e2                	ld	ra,24(sp)
 7a2:	6442                	ld	s0,16(sp)
 7a4:	6125                	add	sp,sp,96
 7a6:	8082                	ret

00000000000007a8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a8:	1141                	add	sp,sp,-16
 7aa:	e422                	sd	s0,8(sp)
 7ac:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7ae:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b2:	00001797          	auipc	a5,0x1
 7b6:	85e7b783          	ld	a5,-1954(a5) # 1010 <freep>
 7ba:	a02d                	j	7e4 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7bc:	4618                	lw	a4,8(a2)
 7be:	9f2d                	addw	a4,a4,a1
 7c0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7c4:	6398                	ld	a4,0(a5)
 7c6:	6310                	ld	a2,0(a4)
 7c8:	a83d                	j	806 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7ca:	ff852703          	lw	a4,-8(a0)
 7ce:	9f31                	addw	a4,a4,a2
 7d0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7d2:	ff053683          	ld	a3,-16(a0)
 7d6:	a091                	j	81a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d8:	6398                	ld	a4,0(a5)
 7da:	00e7e463          	bltu	a5,a4,7e2 <free+0x3a>
 7de:	00e6ea63          	bltu	a3,a4,7f2 <free+0x4a>
{
 7e2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e4:	fed7fae3          	bgeu	a5,a3,7d8 <free+0x30>
 7e8:	6398                	ld	a4,0(a5)
 7ea:	00e6e463          	bltu	a3,a4,7f2 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ee:	fee7eae3          	bltu	a5,a4,7e2 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 7f2:	ff852583          	lw	a1,-8(a0)
 7f6:	6390                	ld	a2,0(a5)
 7f8:	02059813          	sll	a6,a1,0x20
 7fc:	01c85713          	srl	a4,a6,0x1c
 800:	9736                	add	a4,a4,a3
 802:	fae60de3          	beq	a2,a4,7bc <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 806:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 80a:	4790                	lw	a2,8(a5)
 80c:	02061593          	sll	a1,a2,0x20
 810:	01c5d713          	srl	a4,a1,0x1c
 814:	973e                	add	a4,a4,a5
 816:	fae68ae3          	beq	a3,a4,7ca <free+0x22>
    p->s.ptr = bp->s.ptr;
 81a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 81c:	00000717          	auipc	a4,0x0
 820:	7ef73a23          	sd	a5,2036(a4) # 1010 <freep>
}
 824:	6422                	ld	s0,8(sp)
 826:	0141                	add	sp,sp,16
 828:	8082                	ret

000000000000082a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 82a:	7139                	add	sp,sp,-64
 82c:	fc06                	sd	ra,56(sp)
 82e:	f822                	sd	s0,48(sp)
 830:	f426                	sd	s1,40(sp)
 832:	f04a                	sd	s2,32(sp)
 834:	ec4e                	sd	s3,24(sp)
 836:	e852                	sd	s4,16(sp)
 838:	e456                	sd	s5,8(sp)
 83a:	e05a                	sd	s6,0(sp)
 83c:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 83e:	02051493          	sll	s1,a0,0x20
 842:	9081                	srl	s1,s1,0x20
 844:	04bd                	add	s1,s1,15
 846:	8091                	srl	s1,s1,0x4
 848:	0014899b          	addw	s3,s1,1
 84c:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 84e:	00000517          	auipc	a0,0x0
 852:	7c253503          	ld	a0,1986(a0) # 1010 <freep>
 856:	c515                	beqz	a0,882 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 858:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 85a:	4798                	lw	a4,8(a5)
 85c:	02977f63          	bgeu	a4,s1,89a <malloc+0x70>
  if(nu < 4096)
 860:	8a4e                	mv	s4,s3
 862:	0009871b          	sext.w	a4,s3
 866:	6685                	lui	a3,0x1
 868:	00d77363          	bgeu	a4,a3,86e <malloc+0x44>
 86c:	6a05                	lui	s4,0x1
 86e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 872:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 876:	00000917          	auipc	s2,0x0
 87a:	79a90913          	add	s2,s2,1946 # 1010 <freep>
  if(p == (char*)-1)
 87e:	5afd                	li	s5,-1
 880:	a895                	j	8f4 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 882:	00000797          	auipc	a5,0x0
 886:	79e78793          	add	a5,a5,1950 # 1020 <base>
 88a:	00000717          	auipc	a4,0x0
 88e:	78f73323          	sd	a5,1926(a4) # 1010 <freep>
 892:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 894:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 898:	b7e1                	j	860 <malloc+0x36>
      if(p->s.size == nunits)
 89a:	02e48c63          	beq	s1,a4,8d2 <malloc+0xa8>
        p->s.size -= nunits;
 89e:	4137073b          	subw	a4,a4,s3
 8a2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8a4:	02071693          	sll	a3,a4,0x20
 8a8:	01c6d713          	srl	a4,a3,0x1c
 8ac:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8ae:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8b2:	00000717          	auipc	a4,0x0
 8b6:	74a73f23          	sd	a0,1886(a4) # 1010 <freep>
      return (void*)(p + 1);
 8ba:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8be:	70e2                	ld	ra,56(sp)
 8c0:	7442                	ld	s0,48(sp)
 8c2:	74a2                	ld	s1,40(sp)
 8c4:	7902                	ld	s2,32(sp)
 8c6:	69e2                	ld	s3,24(sp)
 8c8:	6a42                	ld	s4,16(sp)
 8ca:	6aa2                	ld	s5,8(sp)
 8cc:	6b02                	ld	s6,0(sp)
 8ce:	6121                	add	sp,sp,64
 8d0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8d2:	6398                	ld	a4,0(a5)
 8d4:	e118                	sd	a4,0(a0)
 8d6:	bff1                	j	8b2 <malloc+0x88>
  hp->s.size = nu;
 8d8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8dc:	0541                	add	a0,a0,16
 8de:	00000097          	auipc	ra,0x0
 8e2:	eca080e7          	jalr	-310(ra) # 7a8 <free>
  return freep;
 8e6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8ea:	d971                	beqz	a0,8be <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ec:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ee:	4798                	lw	a4,8(a5)
 8f0:	fa9775e3          	bgeu	a4,s1,89a <malloc+0x70>
    if(p == freep)
 8f4:	00093703          	ld	a4,0(s2)
 8f8:	853e                	mv	a0,a5
 8fa:	fef719e3          	bne	a4,a5,8ec <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 8fe:	8552                	mv	a0,s4
 900:	00000097          	auipc	ra,0x0
 904:	b42080e7          	jalr	-1214(ra) # 442 <sbrk>
  if(p == (char*)-1)
 908:	fd5518e3          	bne	a0,s5,8d8 <malloc+0xae>
        return 0;
 90c:	4501                	li	a0,0
 90e:	bf45                	j	8be <malloc+0x94>

0000000000000910 <init_lock>:
#include "linkedlist.h"

// Define a node structure for the linked list
struct spinlock_u list_lock;

void init_lock(){
 910:	1141                	add	sp,sp,-16
 912:	e406                	sd	ra,8(sp)
 914:	e022                	sd	s0,0(sp)
 916:	0800                	add	s0,sp,16
    initlock(&list_lock);
 918:	00000517          	auipc	a0,0x0
 91c:	70050513          	add	a0,a0,1792 # 1018 <list_lock>
 920:	00000097          	auipc	ra,0x0
 924:	a56080e7          	jalr	-1450(ra) # 376 <initlock>
}
 928:	60a2                	ld	ra,8(sp)
 92a:	6402                	ld	s0,0(sp)
 92c:	0141                	add	sp,sp,16
 92e:	8082                	ret

0000000000000930 <insert>:

// Function to insert a node at the beginning of the linked list
void insert(struct Node **head_ref, int new_data) {
 930:	1101                	add	sp,sp,-32
 932:	ec06                	sd	ra,24(sp)
 934:	e822                	sd	s0,16(sp)
 936:	e426                	sd	s1,8(sp)
 938:	e04a                	sd	s2,0(sp)
 93a:	1000                	add	s0,sp,32
 93c:	84aa                	mv	s1,a0
 93e:	892e                	mv	s2,a1
    struct Node *new_node = malloc(sizeof(struct Node));
 940:	4541                	li	a0,16
 942:	00000097          	auipc	ra,0x0
 946:	ee8080e7          	jalr	-280(ra) # 82a <malloc>
    new_node->data = new_data;
 94a:	01252023          	sw	s2,0(a0)
    new_node->next = *head_ref;
 94e:	609c                	ld	a5,0(s1)
 950:	e51c                	sd	a5,8(a0)
    *head_ref = new_node;
 952:	e088                	sd	a0,0(s1)
}
 954:	60e2                	ld	ra,24(sp)
 956:	6442                	ld	s0,16(sp)
 958:	64a2                	ld	s1,8(sp)
 95a:	6902                	ld	s2,0(sp)
 95c:	6105                	add	sp,sp,32
 95e:	8082                	ret

0000000000000960 <deleteNode>:

// Function to delete a node with a given key from the linked list
void deleteNode(struct Node **head_ref, int key) {
 960:	7179                	add	sp,sp,-48
 962:	f406                	sd	ra,40(sp)
 964:	f022                	sd	s0,32(sp)
 966:	ec26                	sd	s1,24(sp)
 968:	e84a                	sd	s2,16(sp)
 96a:	e44e                	sd	s3,8(sp)
 96c:	1800                	add	s0,sp,48
 96e:	89aa                	mv	s3,a0
 970:	892e                	mv	s2,a1
    struct Node *temp = *head_ref, *prev = 0;
 972:	6104                	ld	s1,0(a0)

    acquire(&list_lock);
 974:	00000517          	auipc	a0,0x0
 978:	6a450513          	add	a0,a0,1700 # 1018 <list_lock>
 97c:	00000097          	auipc	ra,0x0
 980:	a0a080e7          	jalr	-1526(ra) # 386 <acquire>
    if (temp != 0 && temp->data == key) {
 984:	c0b1                	beqz	s1,9c8 <deleteNode+0x68>
 986:	409c                	lw	a5,0(s1)
 988:	4701                	li	a4,0
 98a:	01278a63          	beq	a5,s2,99e <deleteNode+0x3e>
        rcusync();
        free(temp);
        return;
    }

    while (temp != 0 && temp->data != key) {
 98e:	409c                	lw	a5,0(s1)
 990:	05278563          	beq	a5,s2,9da <deleteNode+0x7a>
        prev = temp;
        temp = temp->next;
 994:	649c                	ld	a5,8(s1)
    while (temp != 0 && temp->data != key) {
 996:	8726                	mv	a4,s1
 998:	cb85                	beqz	a5,9c8 <deleteNode+0x68>
        temp = temp->next;
 99a:	84be                	mv	s1,a5
 99c:	bfcd                	j	98e <deleteNode+0x2e>
        *head_ref = temp->next;
 99e:	649c                	ld	a5,8(s1)
 9a0:	00f9b023          	sd	a5,0(s3)
        release(&list_lock);
 9a4:	00000517          	auipc	a0,0x0
 9a8:	67450513          	add	a0,a0,1652 # 1018 <list_lock>
 9ac:	00000097          	auipc	ra,0x0
 9b0:	9f2080e7          	jalr	-1550(ra) # 39e <release>
        rcusync();
 9b4:	00000097          	auipc	ra,0x0
 9b8:	ab6080e7          	jalr	-1354(ra) # 46a <rcusync>
        free(temp);
 9bc:	8526                	mv	a0,s1
 9be:	00000097          	auipc	ra,0x0
 9c2:	dea080e7          	jalr	-534(ra) # 7a8 <free>
        return;
 9c6:	a82d                	j	a00 <deleteNode+0xa0>
    }

    if (temp == 0) {
        release(&list_lock);
 9c8:	00000517          	auipc	a0,0x0
 9cc:	65050513          	add	a0,a0,1616 # 1018 <list_lock>
 9d0:	00000097          	auipc	ra,0x0
 9d4:	9ce080e7          	jalr	-1586(ra) # 39e <release>
        return;
 9d8:	a025                	j	a00 <deleteNode+0xa0>
    }
    prev->next = temp->next;
 9da:	649c                	ld	a5,8(s1)
 9dc:	e71c                	sd	a5,8(a4)
    release(&list_lock);
 9de:	00000517          	auipc	a0,0x0
 9e2:	63a50513          	add	a0,a0,1594 # 1018 <list_lock>
 9e6:	00000097          	auipc	ra,0x0
 9ea:	9b8080e7          	jalr	-1608(ra) # 39e <release>
    rcusync();
 9ee:	00000097          	auipc	ra,0x0
 9f2:	a7c080e7          	jalr	-1412(ra) # 46a <rcusync>
    free(temp);
 9f6:	8526                	mv	a0,s1
 9f8:	00000097          	auipc	ra,0x0
 9fc:	db0080e7          	jalr	-592(ra) # 7a8 <free>
}
 a00:	70a2                	ld	ra,40(sp)
 a02:	7402                	ld	s0,32(sp)
 a04:	64e2                	ld	s1,24(sp)
 a06:	6942                	ld	s2,16(sp)
 a08:	69a2                	ld	s3,8(sp)
 a0a:	6145                	add	sp,sp,48
 a0c:	8082                	ret

0000000000000a0e <search>:

// Function to search for a node with a given key in the linked list
struct Node* search(struct Node *head, int key) {
 a0e:	1101                	add	sp,sp,-32
 a10:	ec06                	sd	ra,24(sp)
 a12:	e822                	sd	s0,16(sp)
 a14:	e426                	sd	s1,8(sp)
 a16:	e04a                	sd	s2,0(sp)
 a18:	1000                	add	s0,sp,32
 a1a:	84aa                	mv	s1,a0
 a1c:	892e                	mv	s2,a1

    struct Node *current = head;
    rcureadlock();
 a1e:	00000097          	auipc	ra,0x0
 a22:	a3c080e7          	jalr	-1476(ra) # 45a <rcureadlock>
    while (current != 0) {
 a26:	c491                	beqz	s1,a32 <search+0x24>
        if (current->data == key) {
 a28:	409c                	lw	a5,0(s1)
 a2a:	01278f63          	beq	a5,s2,a48 <search+0x3a>
            rcureadunlock();
            return current; // Node found
        }
        current = current->next;
 a2e:	6484                	ld	s1,8(s1)
    while (current != 0) {
 a30:	fce5                	bnez	s1,a28 <search+0x1a>
    }
    rcureadunlock();
 a32:	00000097          	auipc	ra,0x0
 a36:	a30080e7          	jalr	-1488(ra) # 462 <rcureadunlock>
    return 0; // Node not found
 a3a:	4501                	li	a0,0
}
 a3c:	60e2                	ld	ra,24(sp)
 a3e:	6442                	ld	s0,16(sp)
 a40:	64a2                	ld	s1,8(sp)
 a42:	6902                	ld	s2,0(sp)
 a44:	6105                	add	sp,sp,32
 a46:	8082                	ret
            rcureadunlock();
 a48:	00000097          	auipc	ra,0x0
 a4c:	a1a080e7          	jalr	-1510(ra) # 462 <rcureadunlock>
            return current; // Node found
 a50:	8526                	mv	a0,s1
 a52:	b7ed                	j	a3c <search+0x2e>

0000000000000a54 <updateNode>:

// Function to update the value of a node with a given key in the linked list
void updateNode(struct Node *head, int key, int new_data) {
 a54:	1101                	add	sp,sp,-32
 a56:	ec06                	sd	ra,24(sp)
 a58:	e822                	sd	s0,16(sp)
 a5a:	e426                	sd	s1,8(sp)
 a5c:	e04a                	sd	s2,0(sp)
 a5e:	1000                	add	s0,sp,32
 a60:	892e                	mv	s2,a1
 a62:	84b2                	mv	s1,a2
    struct Node *nodeToUpdate = search(head, key);
 a64:	00000097          	auipc	ra,0x0
 a68:	faa080e7          	jalr	-86(ra) # a0e <search>

    if (nodeToUpdate != 0) {
 a6c:	c901                	beqz	a0,a7c <updateNode+0x28>
        nodeToUpdate->data = new_data; // Update the node's data
 a6e:	c104                	sw	s1,0(a0)
    } else {
        printf("Node with key %d not found.\n", key);
    }
}
 a70:	60e2                	ld	ra,24(sp)
 a72:	6442                	ld	s0,16(sp)
 a74:	64a2                	ld	s1,8(sp)
 a76:	6902                	ld	s2,0(sp)
 a78:	6105                	add	sp,sp,32
 a7a:	8082                	ret
        printf("Node with key %d not found.\n", key);
 a7c:	85ca                	mv	a1,s2
 a7e:	00000517          	auipc	a0,0x0
 a82:	10250513          	add	a0,a0,258 # b80 <digits+0x18>
 a86:	00000097          	auipc	ra,0x0
 a8a:	cec080e7          	jalr	-788(ra) # 772 <printf>
}
 a8e:	b7cd                	j	a70 <updateNode+0x1c>
