
user/_mkdir:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	add	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	add	s0,sp,32
  int i;

  if(argc < 2){
   c:	4785                	li	a5,1
   e:	02a7d763          	bge	a5,a0,3c <main+0x3c>
  12:	00858493          	add	s1,a1,8
  16:	ffe5091b          	addw	s2,a0,-2
  1a:	02091793          	sll	a5,s2,0x20
  1e:	01d7d913          	srl	s2,a5,0x1d
  22:	05c1                	add	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "Usage: mkdir files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
  26:	6088                	ld	a0,0(s1)
  28:	00000097          	auipc	ra,0x0
  2c:	378080e7          	jalr	888(ra) # 3a0 <mkdir>
  30:	02054463          	bltz	a0,58 <main+0x58>
  for(i = 1; i < argc; i++){
  34:	04a1                	add	s1,s1,8
  36:	ff2498e3          	bne	s1,s2,26 <main+0x26>
  3a:	a80d                	j	6c <main+0x6c>
    fprintf(2, "Usage: mkdir files...\n");
  3c:	00001597          	auipc	a1,0x1
  40:	9d458593          	add	a1,a1,-1580 # a10 <updateNode+0x3e>
  44:	4509                	li	a0,2
  46:	00000097          	auipc	ra,0x0
  4a:	67c080e7          	jalr	1660(ra) # 6c2 <fprintf>
    exit(1);
  4e:	4505                	li	a0,1
  50:	00000097          	auipc	ra,0x0
  54:	2e8080e7          	jalr	744(ra) # 338 <exit>
      fprintf(2, "mkdir: %s failed to create\n", argv[i]);
  58:	6090                	ld	a2,0(s1)
  5a:	00001597          	auipc	a1,0x1
  5e:	9ce58593          	add	a1,a1,-1586 # a28 <updateNode+0x56>
  62:	4509                	li	a0,2
  64:	00000097          	auipc	ra,0x0
  68:	65e080e7          	jalr	1630(ra) # 6c2 <fprintf>
      break;
    }
  }

  exit(0);
  6c:	4501                	li	a0,0
  6e:	00000097          	auipc	ra,0x0
  72:	2ca080e7          	jalr	714(ra) # 338 <exit>

0000000000000076 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  76:	1141                	add	sp,sp,-16
  78:	e406                	sd	ra,8(sp)
  7a:	e022                	sd	s0,0(sp)
  7c:	0800                	add	s0,sp,16
  extern int main();
  main();
  7e:	00000097          	auipc	ra,0x0
  82:	f82080e7          	jalr	-126(ra) # 0 <main>
  exit(0);
  86:	4501                	li	a0,0
  88:	00000097          	auipc	ra,0x0
  8c:	2b0080e7          	jalr	688(ra) # 338 <exit>

0000000000000090 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  90:	1141                	add	sp,sp,-16
  92:	e422                	sd	s0,8(sp)
  94:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  96:	87aa                	mv	a5,a0
  98:	0585                	add	a1,a1,1
  9a:	0785                	add	a5,a5,1
  9c:	fff5c703          	lbu	a4,-1(a1)
  a0:	fee78fa3          	sb	a4,-1(a5)
  a4:	fb75                	bnez	a4,98 <strcpy+0x8>
    ;
  return os;
}
  a6:	6422                	ld	s0,8(sp)
  a8:	0141                	add	sp,sp,16
  aa:	8082                	ret

00000000000000ac <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ac:	1141                	add	sp,sp,-16
  ae:	e422                	sd	s0,8(sp)
  b0:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  b2:	00054783          	lbu	a5,0(a0)
  b6:	cb91                	beqz	a5,ca <strcmp+0x1e>
  b8:	0005c703          	lbu	a4,0(a1)
  bc:	00f71763          	bne	a4,a5,ca <strcmp+0x1e>
    p++, q++;
  c0:	0505                	add	a0,a0,1
  c2:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  c4:	00054783          	lbu	a5,0(a0)
  c8:	fbe5                	bnez	a5,b8 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  ca:	0005c503          	lbu	a0,0(a1)
}
  ce:	40a7853b          	subw	a0,a5,a0
  d2:	6422                	ld	s0,8(sp)
  d4:	0141                	add	sp,sp,16
  d6:	8082                	ret

00000000000000d8 <strlen>:

uint
strlen(const char *s)
{
  d8:	1141                	add	sp,sp,-16
  da:	e422                	sd	s0,8(sp)
  dc:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  de:	00054783          	lbu	a5,0(a0)
  e2:	cf91                	beqz	a5,fe <strlen+0x26>
  e4:	0505                	add	a0,a0,1
  e6:	87aa                	mv	a5,a0
  e8:	86be                	mv	a3,a5
  ea:	0785                	add	a5,a5,1
  ec:	fff7c703          	lbu	a4,-1(a5)
  f0:	ff65                	bnez	a4,e8 <strlen+0x10>
  f2:	40a6853b          	subw	a0,a3,a0
  f6:	2505                	addw	a0,a0,1
    ;
  return n;
}
  f8:	6422                	ld	s0,8(sp)
  fa:	0141                	add	sp,sp,16
  fc:	8082                	ret
  for(n = 0; s[n]; n++)
  fe:	4501                	li	a0,0
 100:	bfe5                	j	f8 <strlen+0x20>

0000000000000102 <memset>:

void*
memset(void *dst, int c, uint n)
{
 102:	1141                	add	sp,sp,-16
 104:	e422                	sd	s0,8(sp)
 106:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 108:	ca19                	beqz	a2,11e <memset+0x1c>
 10a:	87aa                	mv	a5,a0
 10c:	1602                	sll	a2,a2,0x20
 10e:	9201                	srl	a2,a2,0x20
 110:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 114:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 118:	0785                	add	a5,a5,1
 11a:	fee79de3          	bne	a5,a4,114 <memset+0x12>
  }
  return dst;
}
 11e:	6422                	ld	s0,8(sp)
 120:	0141                	add	sp,sp,16
 122:	8082                	ret

0000000000000124 <strchr>:

char*
strchr(const char *s, char c)
{
 124:	1141                	add	sp,sp,-16
 126:	e422                	sd	s0,8(sp)
 128:	0800                	add	s0,sp,16
  for(; *s; s++)
 12a:	00054783          	lbu	a5,0(a0)
 12e:	cb99                	beqz	a5,144 <strchr+0x20>
    if(*s == c)
 130:	00f58763          	beq	a1,a5,13e <strchr+0x1a>
  for(; *s; s++)
 134:	0505                	add	a0,a0,1
 136:	00054783          	lbu	a5,0(a0)
 13a:	fbfd                	bnez	a5,130 <strchr+0xc>
      return (char*)s;
  return 0;
 13c:	4501                	li	a0,0
}
 13e:	6422                	ld	s0,8(sp)
 140:	0141                	add	sp,sp,16
 142:	8082                	ret
  return 0;
 144:	4501                	li	a0,0
 146:	bfe5                	j	13e <strchr+0x1a>

0000000000000148 <gets>:

char*
gets(char *buf, int max)
{
 148:	711d                	add	sp,sp,-96
 14a:	ec86                	sd	ra,88(sp)
 14c:	e8a2                	sd	s0,80(sp)
 14e:	e4a6                	sd	s1,72(sp)
 150:	e0ca                	sd	s2,64(sp)
 152:	fc4e                	sd	s3,56(sp)
 154:	f852                	sd	s4,48(sp)
 156:	f456                	sd	s5,40(sp)
 158:	f05a                	sd	s6,32(sp)
 15a:	ec5e                	sd	s7,24(sp)
 15c:	1080                	add	s0,sp,96
 15e:	8baa                	mv	s7,a0
 160:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 162:	892a                	mv	s2,a0
 164:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 166:	4aa9                	li	s5,10
 168:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 16a:	89a6                	mv	s3,s1
 16c:	2485                	addw	s1,s1,1
 16e:	0344d863          	bge	s1,s4,19e <gets+0x56>
    cc = read(0, &c, 1);
 172:	4605                	li	a2,1
 174:	faf40593          	add	a1,s0,-81
 178:	4501                	li	a0,0
 17a:	00000097          	auipc	ra,0x0
 17e:	1d6080e7          	jalr	470(ra) # 350 <read>
    if(cc < 1)
 182:	00a05e63          	blez	a0,19e <gets+0x56>
    buf[i++] = c;
 186:	faf44783          	lbu	a5,-81(s0)
 18a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 18e:	01578763          	beq	a5,s5,19c <gets+0x54>
 192:	0905                	add	s2,s2,1
 194:	fd679be3          	bne	a5,s6,16a <gets+0x22>
  for(i=0; i+1 < max; ){
 198:	89a6                	mv	s3,s1
 19a:	a011                	j	19e <gets+0x56>
 19c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 19e:	99de                	add	s3,s3,s7
 1a0:	00098023          	sb	zero,0(s3)
  return buf;
}
 1a4:	855e                	mv	a0,s7
 1a6:	60e6                	ld	ra,88(sp)
 1a8:	6446                	ld	s0,80(sp)
 1aa:	64a6                	ld	s1,72(sp)
 1ac:	6906                	ld	s2,64(sp)
 1ae:	79e2                	ld	s3,56(sp)
 1b0:	7a42                	ld	s4,48(sp)
 1b2:	7aa2                	ld	s5,40(sp)
 1b4:	7b02                	ld	s6,32(sp)
 1b6:	6be2                	ld	s7,24(sp)
 1b8:	6125                	add	sp,sp,96
 1ba:	8082                	ret

00000000000001bc <stat>:

int
stat(const char *n, struct stat *st)
{
 1bc:	1101                	add	sp,sp,-32
 1be:	ec06                	sd	ra,24(sp)
 1c0:	e822                	sd	s0,16(sp)
 1c2:	e426                	sd	s1,8(sp)
 1c4:	e04a                	sd	s2,0(sp)
 1c6:	1000                	add	s0,sp,32
 1c8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ca:	4581                	li	a1,0
 1cc:	00000097          	auipc	ra,0x0
 1d0:	1ac080e7          	jalr	428(ra) # 378 <open>
  if(fd < 0)
 1d4:	02054563          	bltz	a0,1fe <stat+0x42>
 1d8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1da:	85ca                	mv	a1,s2
 1dc:	00000097          	auipc	ra,0x0
 1e0:	1b4080e7          	jalr	436(ra) # 390 <fstat>
 1e4:	892a                	mv	s2,a0
  close(fd);
 1e6:	8526                	mv	a0,s1
 1e8:	00000097          	auipc	ra,0x0
 1ec:	178080e7          	jalr	376(ra) # 360 <close>
  return r;
}
 1f0:	854a                	mv	a0,s2
 1f2:	60e2                	ld	ra,24(sp)
 1f4:	6442                	ld	s0,16(sp)
 1f6:	64a2                	ld	s1,8(sp)
 1f8:	6902                	ld	s2,0(sp)
 1fa:	6105                	add	sp,sp,32
 1fc:	8082                	ret
    return -1;
 1fe:	597d                	li	s2,-1
 200:	bfc5                	j	1f0 <stat+0x34>

0000000000000202 <atoi>:

int
atoi(const char *s)
{
 202:	1141                	add	sp,sp,-16
 204:	e422                	sd	s0,8(sp)
 206:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 208:	00054683          	lbu	a3,0(a0)
 20c:	fd06879b          	addw	a5,a3,-48
 210:	0ff7f793          	zext.b	a5,a5
 214:	4625                	li	a2,9
 216:	02f66863          	bltu	a2,a5,246 <atoi+0x44>
 21a:	872a                	mv	a4,a0
  n = 0;
 21c:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 21e:	0705                	add	a4,a4,1
 220:	0025179b          	sllw	a5,a0,0x2
 224:	9fa9                	addw	a5,a5,a0
 226:	0017979b          	sllw	a5,a5,0x1
 22a:	9fb5                	addw	a5,a5,a3
 22c:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 230:	00074683          	lbu	a3,0(a4)
 234:	fd06879b          	addw	a5,a3,-48
 238:	0ff7f793          	zext.b	a5,a5
 23c:	fef671e3          	bgeu	a2,a5,21e <atoi+0x1c>
  return n;
}
 240:	6422                	ld	s0,8(sp)
 242:	0141                	add	sp,sp,16
 244:	8082                	ret
  n = 0;
 246:	4501                	li	a0,0
 248:	bfe5                	j	240 <atoi+0x3e>

000000000000024a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 24a:	1141                	add	sp,sp,-16
 24c:	e422                	sd	s0,8(sp)
 24e:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 250:	02b57463          	bgeu	a0,a1,278 <memmove+0x2e>
    while(n-- > 0)
 254:	00c05f63          	blez	a2,272 <memmove+0x28>
 258:	1602                	sll	a2,a2,0x20
 25a:	9201                	srl	a2,a2,0x20
 25c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 260:	872a                	mv	a4,a0
      *dst++ = *src++;
 262:	0585                	add	a1,a1,1
 264:	0705                	add	a4,a4,1
 266:	fff5c683          	lbu	a3,-1(a1)
 26a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 26e:	fee79ae3          	bne	a5,a4,262 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 272:	6422                	ld	s0,8(sp)
 274:	0141                	add	sp,sp,16
 276:	8082                	ret
    dst += n;
 278:	00c50733          	add	a4,a0,a2
    src += n;
 27c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 27e:	fec05ae3          	blez	a2,272 <memmove+0x28>
 282:	fff6079b          	addw	a5,a2,-1
 286:	1782                	sll	a5,a5,0x20
 288:	9381                	srl	a5,a5,0x20
 28a:	fff7c793          	not	a5,a5
 28e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 290:	15fd                	add	a1,a1,-1
 292:	177d                	add	a4,a4,-1
 294:	0005c683          	lbu	a3,0(a1)
 298:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 29c:	fee79ae3          	bne	a5,a4,290 <memmove+0x46>
 2a0:	bfc9                	j	272 <memmove+0x28>

00000000000002a2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2a2:	1141                	add	sp,sp,-16
 2a4:	e422                	sd	s0,8(sp)
 2a6:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2a8:	ca05                	beqz	a2,2d8 <memcmp+0x36>
 2aa:	fff6069b          	addw	a3,a2,-1
 2ae:	1682                	sll	a3,a3,0x20
 2b0:	9281                	srl	a3,a3,0x20
 2b2:	0685                	add	a3,a3,1
 2b4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2b6:	00054783          	lbu	a5,0(a0)
 2ba:	0005c703          	lbu	a4,0(a1)
 2be:	00e79863          	bne	a5,a4,2ce <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2c2:	0505                	add	a0,a0,1
    p2++;
 2c4:	0585                	add	a1,a1,1
  while (n-- > 0) {
 2c6:	fed518e3          	bne	a0,a3,2b6 <memcmp+0x14>
  }
  return 0;
 2ca:	4501                	li	a0,0
 2cc:	a019                	j	2d2 <memcmp+0x30>
      return *p1 - *p2;
 2ce:	40e7853b          	subw	a0,a5,a4
}
 2d2:	6422                	ld	s0,8(sp)
 2d4:	0141                	add	sp,sp,16
 2d6:	8082                	ret
  return 0;
 2d8:	4501                	li	a0,0
 2da:	bfe5                	j	2d2 <memcmp+0x30>

00000000000002dc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2dc:	1141                	add	sp,sp,-16
 2de:	e406                	sd	ra,8(sp)
 2e0:	e022                	sd	s0,0(sp)
 2e2:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 2e4:	00000097          	auipc	ra,0x0
 2e8:	f66080e7          	jalr	-154(ra) # 24a <memmove>
}
 2ec:	60a2                	ld	ra,8(sp)
 2ee:	6402                	ld	s0,0(sp)
 2f0:	0141                	add	sp,sp,16
 2f2:	8082                	ret

00000000000002f4 <initlock>:

// Initialize the spinlock
void initlock(struct spinlock_u *lk) {
 2f4:	1141                	add	sp,sp,-16
 2f6:	e422                	sd	s0,8(sp)
 2f8:	0800                	add	s0,sp,16
  lk->locked = 0;
 2fa:	00052023          	sw	zero,0(a0)
}
 2fe:	6422                	ld	s0,8(sp)
 300:	0141                	add	sp,sp,16
 302:	8082                	ret

0000000000000304 <acquire>:

// Acquire the spinlock
void acquire(struct spinlock_u *lk) {
 304:	1141                	add	sp,sp,-16
 306:	e422                	sd	s0,8(sp)
 308:	0800                	add	s0,sp,16
  while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 30a:	4705                	li	a4,1
 30c:	87ba                	mv	a5,a4
 30e:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
 312:	2781                	sext.w	a5,a5
 314:	ffe5                	bnez	a5,30c <acquire+0x8>
    ; // Spin until the lock is acquired
}
 316:	6422                	ld	s0,8(sp)
 318:	0141                	add	sp,sp,16
 31a:	8082                	ret

000000000000031c <release>:

// Release the spinlock
void release(struct spinlock_u *lk) {
 31c:	1141                	add	sp,sp,-16
 31e:	e422                	sd	s0,8(sp)
 320:	0800                	add	s0,sp,16
  __sync_lock_release(&lk->locked);
 322:	0f50000f          	fence	iorw,ow
 326:	0805202f          	amoswap.w	zero,zero,(a0)
}
 32a:	6422                	ld	s0,8(sp)
 32c:	0141                	add	sp,sp,16
 32e:	8082                	ret

0000000000000330 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 330:	4885                	li	a7,1
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <exit>:
.global exit
exit:
 li a7, SYS_exit
 338:	4889                	li	a7,2
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <wait>:
.global wait
wait:
 li a7, SYS_wait
 340:	488d                	li	a7,3
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 348:	4891                	li	a7,4
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <read>:
.global read
read:
 li a7, SYS_read
 350:	4895                	li	a7,5
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <write>:
.global write
write:
 li a7, SYS_write
 358:	48c1                	li	a7,16
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <close>:
.global close
close:
 li a7, SYS_close
 360:	48d5                	li	a7,21
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <kill>:
.global kill
kill:
 li a7, SYS_kill
 368:	4899                	li	a7,6
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <exec>:
.global exec
exec:
 li a7, SYS_exec
 370:	489d                	li	a7,7
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <open>:
.global open
open:
 li a7, SYS_open
 378:	48bd                	li	a7,15
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 380:	48c5                	li	a7,17
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 388:	48c9                	li	a7,18
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 390:	48a1                	li	a7,8
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <link>:
.global link
link:
 li a7, SYS_link
 398:	48cd                	li	a7,19
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3a0:	48d1                	li	a7,20
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3a8:	48a5                	li	a7,9
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3b0:	48a9                	li	a7,10
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3b8:	48ad                	li	a7,11
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3c0:	48b1                	li	a7,12
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3c8:	48b5                	li	a7,13
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3d0:	48b9                	li	a7,14
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <rcureadlock>:
.global rcureadlock
rcureadlock:
 li a7, SYS_rcureadlock
 3d8:	48dd                	li	a7,23
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <rcureadunlock>:
.global rcureadunlock
rcureadunlock:
 li a7, SYS_rcureadunlock
 3e0:	48e1                	li	a7,24
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <rcusync>:
.global rcusync
rcusync:
 li a7, SYS_rcusync
 3e8:	48d9                	li	a7,22
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <thread_create>:
.global thread_create
thread_create:
 li a7, SYS_thread_create
 3f0:	48e5                	li	a7,25
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <thread_join>:
.global thread_join
thread_join:
 li a7, SYS_thread_join
 3f8:	48e9                	li	a7,26
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <thread_exit>:
.global thread_exit
thread_exit:
 li a7, SYS_thread_exit
 400:	48ed                	li	a7,27
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <klist_insert>:
.global klist_insert
klist_insert:
 li a7, SYS_klist_insert
 408:	48f1                	li	a7,28
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <klist_delete>:
.global klist_delete
klist_delete:
 li a7, SYS_klist_delete
 410:	48f5                	li	a7,29
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <klist_query>:
.global klist_query
klist_query:
 li a7, SYS_klist_query
 418:	48f9                	li	a7,30
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <klist_print>:
.global klist_print
klist_print:
 li a7, SYS_klist_print
 420:	48fd                	li	a7,31
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 428:	1101                	add	sp,sp,-32
 42a:	ec06                	sd	ra,24(sp)
 42c:	e822                	sd	s0,16(sp)
 42e:	1000                	add	s0,sp,32
 430:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 434:	4605                	li	a2,1
 436:	fef40593          	add	a1,s0,-17
 43a:	00000097          	auipc	ra,0x0
 43e:	f1e080e7          	jalr	-226(ra) # 358 <write>
}
 442:	60e2                	ld	ra,24(sp)
 444:	6442                	ld	s0,16(sp)
 446:	6105                	add	sp,sp,32
 448:	8082                	ret

000000000000044a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 44a:	7139                	add	sp,sp,-64
 44c:	fc06                	sd	ra,56(sp)
 44e:	f822                	sd	s0,48(sp)
 450:	f426                	sd	s1,40(sp)
 452:	f04a                	sd	s2,32(sp)
 454:	ec4e                	sd	s3,24(sp)
 456:	0080                	add	s0,sp,64
 458:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 45a:	c299                	beqz	a3,460 <printint+0x16>
 45c:	0805c963          	bltz	a1,4ee <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 460:	2581                	sext.w	a1,a1
  neg = 0;
 462:	4881                	li	a7,0
 464:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 468:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 46a:	2601                	sext.w	a2,a2
 46c:	00000517          	auipc	a0,0x0
 470:	63c50513          	add	a0,a0,1596 # aa8 <digits>
 474:	883a                	mv	a6,a4
 476:	2705                	addw	a4,a4,1
 478:	02c5f7bb          	remuw	a5,a1,a2
 47c:	1782                	sll	a5,a5,0x20
 47e:	9381                	srl	a5,a5,0x20
 480:	97aa                	add	a5,a5,a0
 482:	0007c783          	lbu	a5,0(a5)
 486:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 48a:	0005879b          	sext.w	a5,a1
 48e:	02c5d5bb          	divuw	a1,a1,a2
 492:	0685                	add	a3,a3,1
 494:	fec7f0e3          	bgeu	a5,a2,474 <printint+0x2a>
  if(neg)
 498:	00088c63          	beqz	a7,4b0 <printint+0x66>
    buf[i++] = '-';
 49c:	fd070793          	add	a5,a4,-48
 4a0:	00878733          	add	a4,a5,s0
 4a4:	02d00793          	li	a5,45
 4a8:	fef70823          	sb	a5,-16(a4)
 4ac:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 4b0:	02e05863          	blez	a4,4e0 <printint+0x96>
 4b4:	fc040793          	add	a5,s0,-64
 4b8:	00e78933          	add	s2,a5,a4
 4bc:	fff78993          	add	s3,a5,-1
 4c0:	99ba                	add	s3,s3,a4
 4c2:	377d                	addw	a4,a4,-1
 4c4:	1702                	sll	a4,a4,0x20
 4c6:	9301                	srl	a4,a4,0x20
 4c8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4cc:	fff94583          	lbu	a1,-1(s2)
 4d0:	8526                	mv	a0,s1
 4d2:	00000097          	auipc	ra,0x0
 4d6:	f56080e7          	jalr	-170(ra) # 428 <putc>
  while(--i >= 0)
 4da:	197d                	add	s2,s2,-1
 4dc:	ff3918e3          	bne	s2,s3,4cc <printint+0x82>
}
 4e0:	70e2                	ld	ra,56(sp)
 4e2:	7442                	ld	s0,48(sp)
 4e4:	74a2                	ld	s1,40(sp)
 4e6:	7902                	ld	s2,32(sp)
 4e8:	69e2                	ld	s3,24(sp)
 4ea:	6121                	add	sp,sp,64
 4ec:	8082                	ret
    x = -xx;
 4ee:	40b005bb          	negw	a1,a1
    neg = 1;
 4f2:	4885                	li	a7,1
    x = -xx;
 4f4:	bf85                	j	464 <printint+0x1a>

00000000000004f6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4f6:	715d                	add	sp,sp,-80
 4f8:	e486                	sd	ra,72(sp)
 4fa:	e0a2                	sd	s0,64(sp)
 4fc:	fc26                	sd	s1,56(sp)
 4fe:	f84a                	sd	s2,48(sp)
 500:	f44e                	sd	s3,40(sp)
 502:	f052                	sd	s4,32(sp)
 504:	ec56                	sd	s5,24(sp)
 506:	e85a                	sd	s6,16(sp)
 508:	e45e                	sd	s7,8(sp)
 50a:	e062                	sd	s8,0(sp)
 50c:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 50e:	0005c903          	lbu	s2,0(a1)
 512:	18090c63          	beqz	s2,6aa <vprintf+0x1b4>
 516:	8aaa                	mv	s5,a0
 518:	8bb2                	mv	s7,a2
 51a:	00158493          	add	s1,a1,1
  state = 0;
 51e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 520:	02500a13          	li	s4,37
 524:	4b55                	li	s6,21
 526:	a839                	j	544 <vprintf+0x4e>
        putc(fd, c);
 528:	85ca                	mv	a1,s2
 52a:	8556                	mv	a0,s5
 52c:	00000097          	auipc	ra,0x0
 530:	efc080e7          	jalr	-260(ra) # 428 <putc>
 534:	a019                	j	53a <vprintf+0x44>
    } else if(state == '%'){
 536:	01498d63          	beq	s3,s4,550 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 53a:	0485                	add	s1,s1,1
 53c:	fff4c903          	lbu	s2,-1(s1)
 540:	16090563          	beqz	s2,6aa <vprintf+0x1b4>
    if(state == 0){
 544:	fe0999e3          	bnez	s3,536 <vprintf+0x40>
      if(c == '%'){
 548:	ff4910e3          	bne	s2,s4,528 <vprintf+0x32>
        state = '%';
 54c:	89d2                	mv	s3,s4
 54e:	b7f5                	j	53a <vprintf+0x44>
      if(c == 'd'){
 550:	13490263          	beq	s2,s4,674 <vprintf+0x17e>
 554:	f9d9079b          	addw	a5,s2,-99
 558:	0ff7f793          	zext.b	a5,a5
 55c:	12fb6563          	bltu	s6,a5,686 <vprintf+0x190>
 560:	f9d9079b          	addw	a5,s2,-99
 564:	0ff7f713          	zext.b	a4,a5
 568:	10eb6f63          	bltu	s6,a4,686 <vprintf+0x190>
 56c:	00271793          	sll	a5,a4,0x2
 570:	00000717          	auipc	a4,0x0
 574:	4e070713          	add	a4,a4,1248 # a50 <updateNode+0x7e>
 578:	97ba                	add	a5,a5,a4
 57a:	439c                	lw	a5,0(a5)
 57c:	97ba                	add	a5,a5,a4
 57e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 580:	008b8913          	add	s2,s7,8
 584:	4685                	li	a3,1
 586:	4629                	li	a2,10
 588:	000ba583          	lw	a1,0(s7)
 58c:	8556                	mv	a0,s5
 58e:	00000097          	auipc	ra,0x0
 592:	ebc080e7          	jalr	-324(ra) # 44a <printint>
 596:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 598:	4981                	li	s3,0
 59a:	b745                	j	53a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 59c:	008b8913          	add	s2,s7,8
 5a0:	4681                	li	a3,0
 5a2:	4629                	li	a2,10
 5a4:	000ba583          	lw	a1,0(s7)
 5a8:	8556                	mv	a0,s5
 5aa:	00000097          	auipc	ra,0x0
 5ae:	ea0080e7          	jalr	-352(ra) # 44a <printint>
 5b2:	8bca                	mv	s7,s2
      state = 0;
 5b4:	4981                	li	s3,0
 5b6:	b751                	j	53a <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 5b8:	008b8913          	add	s2,s7,8
 5bc:	4681                	li	a3,0
 5be:	4641                	li	a2,16
 5c0:	000ba583          	lw	a1,0(s7)
 5c4:	8556                	mv	a0,s5
 5c6:	00000097          	auipc	ra,0x0
 5ca:	e84080e7          	jalr	-380(ra) # 44a <printint>
 5ce:	8bca                	mv	s7,s2
      state = 0;
 5d0:	4981                	li	s3,0
 5d2:	b7a5                	j	53a <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 5d4:	008b8c13          	add	s8,s7,8
 5d8:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 5dc:	03000593          	li	a1,48
 5e0:	8556                	mv	a0,s5
 5e2:	00000097          	auipc	ra,0x0
 5e6:	e46080e7          	jalr	-442(ra) # 428 <putc>
  putc(fd, 'x');
 5ea:	07800593          	li	a1,120
 5ee:	8556                	mv	a0,s5
 5f0:	00000097          	auipc	ra,0x0
 5f4:	e38080e7          	jalr	-456(ra) # 428 <putc>
 5f8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5fa:	00000b97          	auipc	s7,0x0
 5fe:	4aeb8b93          	add	s7,s7,1198 # aa8 <digits>
 602:	03c9d793          	srl	a5,s3,0x3c
 606:	97de                	add	a5,a5,s7
 608:	0007c583          	lbu	a1,0(a5)
 60c:	8556                	mv	a0,s5
 60e:	00000097          	auipc	ra,0x0
 612:	e1a080e7          	jalr	-486(ra) # 428 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 616:	0992                	sll	s3,s3,0x4
 618:	397d                	addw	s2,s2,-1
 61a:	fe0914e3          	bnez	s2,602 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 61e:	8be2                	mv	s7,s8
      state = 0;
 620:	4981                	li	s3,0
 622:	bf21                	j	53a <vprintf+0x44>
        s = va_arg(ap, char*);
 624:	008b8993          	add	s3,s7,8
 628:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 62c:	02090163          	beqz	s2,64e <vprintf+0x158>
        while(*s != 0){
 630:	00094583          	lbu	a1,0(s2)
 634:	c9a5                	beqz	a1,6a4 <vprintf+0x1ae>
          putc(fd, *s);
 636:	8556                	mv	a0,s5
 638:	00000097          	auipc	ra,0x0
 63c:	df0080e7          	jalr	-528(ra) # 428 <putc>
          s++;
 640:	0905                	add	s2,s2,1
        while(*s != 0){
 642:	00094583          	lbu	a1,0(s2)
 646:	f9e5                	bnez	a1,636 <vprintf+0x140>
        s = va_arg(ap, char*);
 648:	8bce                	mv	s7,s3
      state = 0;
 64a:	4981                	li	s3,0
 64c:	b5fd                	j	53a <vprintf+0x44>
          s = "(null)";
 64e:	00000917          	auipc	s2,0x0
 652:	3fa90913          	add	s2,s2,1018 # a48 <updateNode+0x76>
        while(*s != 0){
 656:	02800593          	li	a1,40
 65a:	bff1                	j	636 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 65c:	008b8913          	add	s2,s7,8
 660:	000bc583          	lbu	a1,0(s7)
 664:	8556                	mv	a0,s5
 666:	00000097          	auipc	ra,0x0
 66a:	dc2080e7          	jalr	-574(ra) # 428 <putc>
 66e:	8bca                	mv	s7,s2
      state = 0;
 670:	4981                	li	s3,0
 672:	b5e1                	j	53a <vprintf+0x44>
        putc(fd, c);
 674:	02500593          	li	a1,37
 678:	8556                	mv	a0,s5
 67a:	00000097          	auipc	ra,0x0
 67e:	dae080e7          	jalr	-594(ra) # 428 <putc>
      state = 0;
 682:	4981                	li	s3,0
 684:	bd5d                	j	53a <vprintf+0x44>
        putc(fd, '%');
 686:	02500593          	li	a1,37
 68a:	8556                	mv	a0,s5
 68c:	00000097          	auipc	ra,0x0
 690:	d9c080e7          	jalr	-612(ra) # 428 <putc>
        putc(fd, c);
 694:	85ca                	mv	a1,s2
 696:	8556                	mv	a0,s5
 698:	00000097          	auipc	ra,0x0
 69c:	d90080e7          	jalr	-624(ra) # 428 <putc>
      state = 0;
 6a0:	4981                	li	s3,0
 6a2:	bd61                	j	53a <vprintf+0x44>
        s = va_arg(ap, char*);
 6a4:	8bce                	mv	s7,s3
      state = 0;
 6a6:	4981                	li	s3,0
 6a8:	bd49                	j	53a <vprintf+0x44>
    }
  }
}
 6aa:	60a6                	ld	ra,72(sp)
 6ac:	6406                	ld	s0,64(sp)
 6ae:	74e2                	ld	s1,56(sp)
 6b0:	7942                	ld	s2,48(sp)
 6b2:	79a2                	ld	s3,40(sp)
 6b4:	7a02                	ld	s4,32(sp)
 6b6:	6ae2                	ld	s5,24(sp)
 6b8:	6b42                	ld	s6,16(sp)
 6ba:	6ba2                	ld	s7,8(sp)
 6bc:	6c02                	ld	s8,0(sp)
 6be:	6161                	add	sp,sp,80
 6c0:	8082                	ret

00000000000006c2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6c2:	715d                	add	sp,sp,-80
 6c4:	ec06                	sd	ra,24(sp)
 6c6:	e822                	sd	s0,16(sp)
 6c8:	1000                	add	s0,sp,32
 6ca:	e010                	sd	a2,0(s0)
 6cc:	e414                	sd	a3,8(s0)
 6ce:	e818                	sd	a4,16(s0)
 6d0:	ec1c                	sd	a5,24(s0)
 6d2:	03043023          	sd	a6,32(s0)
 6d6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6da:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6de:	8622                	mv	a2,s0
 6e0:	00000097          	auipc	ra,0x0
 6e4:	e16080e7          	jalr	-490(ra) # 4f6 <vprintf>
}
 6e8:	60e2                	ld	ra,24(sp)
 6ea:	6442                	ld	s0,16(sp)
 6ec:	6161                	add	sp,sp,80
 6ee:	8082                	ret

00000000000006f0 <printf>:

void
printf(const char *fmt, ...)
{
 6f0:	711d                	add	sp,sp,-96
 6f2:	ec06                	sd	ra,24(sp)
 6f4:	e822                	sd	s0,16(sp)
 6f6:	1000                	add	s0,sp,32
 6f8:	e40c                	sd	a1,8(s0)
 6fa:	e810                	sd	a2,16(s0)
 6fc:	ec14                	sd	a3,24(s0)
 6fe:	f018                	sd	a4,32(s0)
 700:	f41c                	sd	a5,40(s0)
 702:	03043823          	sd	a6,48(s0)
 706:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 70a:	00840613          	add	a2,s0,8
 70e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 712:	85aa                	mv	a1,a0
 714:	4505                	li	a0,1
 716:	00000097          	auipc	ra,0x0
 71a:	de0080e7          	jalr	-544(ra) # 4f6 <vprintf>
}
 71e:	60e2                	ld	ra,24(sp)
 720:	6442                	ld	s0,16(sp)
 722:	6125                	add	sp,sp,96
 724:	8082                	ret

0000000000000726 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 726:	1141                	add	sp,sp,-16
 728:	e422                	sd	s0,8(sp)
 72a:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 72c:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 730:	00001797          	auipc	a5,0x1
 734:	8d07b783          	ld	a5,-1840(a5) # 1000 <freep>
 738:	a02d                	j	762 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 73a:	4618                	lw	a4,8(a2)
 73c:	9f2d                	addw	a4,a4,a1
 73e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 742:	6398                	ld	a4,0(a5)
 744:	6310                	ld	a2,0(a4)
 746:	a83d                	j	784 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 748:	ff852703          	lw	a4,-8(a0)
 74c:	9f31                	addw	a4,a4,a2
 74e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 750:	ff053683          	ld	a3,-16(a0)
 754:	a091                	j	798 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 756:	6398                	ld	a4,0(a5)
 758:	00e7e463          	bltu	a5,a4,760 <free+0x3a>
 75c:	00e6ea63          	bltu	a3,a4,770 <free+0x4a>
{
 760:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 762:	fed7fae3          	bgeu	a5,a3,756 <free+0x30>
 766:	6398                	ld	a4,0(a5)
 768:	00e6e463          	bltu	a3,a4,770 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 76c:	fee7eae3          	bltu	a5,a4,760 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 770:	ff852583          	lw	a1,-8(a0)
 774:	6390                	ld	a2,0(a5)
 776:	02059813          	sll	a6,a1,0x20
 77a:	01c85713          	srl	a4,a6,0x1c
 77e:	9736                	add	a4,a4,a3
 780:	fae60de3          	beq	a2,a4,73a <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 784:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 788:	4790                	lw	a2,8(a5)
 78a:	02061593          	sll	a1,a2,0x20
 78e:	01c5d713          	srl	a4,a1,0x1c
 792:	973e                	add	a4,a4,a5
 794:	fae68ae3          	beq	a3,a4,748 <free+0x22>
    p->s.ptr = bp->s.ptr;
 798:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 79a:	00001717          	auipc	a4,0x1
 79e:	86f73323          	sd	a5,-1946(a4) # 1000 <freep>
}
 7a2:	6422                	ld	s0,8(sp)
 7a4:	0141                	add	sp,sp,16
 7a6:	8082                	ret

00000000000007a8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7a8:	7139                	add	sp,sp,-64
 7aa:	fc06                	sd	ra,56(sp)
 7ac:	f822                	sd	s0,48(sp)
 7ae:	f426                	sd	s1,40(sp)
 7b0:	f04a                	sd	s2,32(sp)
 7b2:	ec4e                	sd	s3,24(sp)
 7b4:	e852                	sd	s4,16(sp)
 7b6:	e456                	sd	s5,8(sp)
 7b8:	e05a                	sd	s6,0(sp)
 7ba:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7bc:	02051493          	sll	s1,a0,0x20
 7c0:	9081                	srl	s1,s1,0x20
 7c2:	04bd                	add	s1,s1,15
 7c4:	8091                	srl	s1,s1,0x4
 7c6:	0014899b          	addw	s3,s1,1
 7ca:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 7cc:	00001517          	auipc	a0,0x1
 7d0:	83453503          	ld	a0,-1996(a0) # 1000 <freep>
 7d4:	c515                	beqz	a0,800 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7d8:	4798                	lw	a4,8(a5)
 7da:	02977f63          	bgeu	a4,s1,818 <malloc+0x70>
  if(nu < 4096)
 7de:	8a4e                	mv	s4,s3
 7e0:	0009871b          	sext.w	a4,s3
 7e4:	6685                	lui	a3,0x1
 7e6:	00d77363          	bgeu	a4,a3,7ec <malloc+0x44>
 7ea:	6a05                	lui	s4,0x1
 7ec:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7f0:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7f4:	00001917          	auipc	s2,0x1
 7f8:	80c90913          	add	s2,s2,-2036 # 1000 <freep>
  if(p == (char*)-1)
 7fc:	5afd                	li	s5,-1
 7fe:	a895                	j	872 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 800:	00001797          	auipc	a5,0x1
 804:	81078793          	add	a5,a5,-2032 # 1010 <base>
 808:	00000717          	auipc	a4,0x0
 80c:	7ef73c23          	sd	a5,2040(a4) # 1000 <freep>
 810:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 812:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 816:	b7e1                	j	7de <malloc+0x36>
      if(p->s.size == nunits)
 818:	02e48c63          	beq	s1,a4,850 <malloc+0xa8>
        p->s.size -= nunits;
 81c:	4137073b          	subw	a4,a4,s3
 820:	c798                	sw	a4,8(a5)
        p += p->s.size;
 822:	02071693          	sll	a3,a4,0x20
 826:	01c6d713          	srl	a4,a3,0x1c
 82a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 82c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 830:	00000717          	auipc	a4,0x0
 834:	7ca73823          	sd	a0,2000(a4) # 1000 <freep>
      return (void*)(p + 1);
 838:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 83c:	70e2                	ld	ra,56(sp)
 83e:	7442                	ld	s0,48(sp)
 840:	74a2                	ld	s1,40(sp)
 842:	7902                	ld	s2,32(sp)
 844:	69e2                	ld	s3,24(sp)
 846:	6a42                	ld	s4,16(sp)
 848:	6aa2                	ld	s5,8(sp)
 84a:	6b02                	ld	s6,0(sp)
 84c:	6121                	add	sp,sp,64
 84e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 850:	6398                	ld	a4,0(a5)
 852:	e118                	sd	a4,0(a0)
 854:	bff1                	j	830 <malloc+0x88>
  hp->s.size = nu;
 856:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 85a:	0541                	add	a0,a0,16
 85c:	00000097          	auipc	ra,0x0
 860:	eca080e7          	jalr	-310(ra) # 726 <free>
  return freep;
 864:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 868:	d971                	beqz	a0,83c <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 86a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 86c:	4798                	lw	a4,8(a5)
 86e:	fa9775e3          	bgeu	a4,s1,818 <malloc+0x70>
    if(p == freep)
 872:	00093703          	ld	a4,0(s2)
 876:	853e                	mv	a0,a5
 878:	fef719e3          	bne	a4,a5,86a <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 87c:	8552                	mv	a0,s4
 87e:	00000097          	auipc	ra,0x0
 882:	b42080e7          	jalr	-1214(ra) # 3c0 <sbrk>
  if(p == (char*)-1)
 886:	fd5518e3          	bne	a0,s5,856 <malloc+0xae>
        return 0;
 88a:	4501                	li	a0,0
 88c:	bf45                	j	83c <malloc+0x94>

000000000000088e <init_lock>:
#include "linkedlist.h"

// Define a node structure for the linked list
struct spinlock_u list_lock;

void init_lock(){
 88e:	1141                	add	sp,sp,-16
 890:	e406                	sd	ra,8(sp)
 892:	e022                	sd	s0,0(sp)
 894:	0800                	add	s0,sp,16
    initlock(&list_lock);
 896:	00000517          	auipc	a0,0x0
 89a:	77250513          	add	a0,a0,1906 # 1008 <list_lock>
 89e:	00000097          	auipc	ra,0x0
 8a2:	a56080e7          	jalr	-1450(ra) # 2f4 <initlock>
}
 8a6:	60a2                	ld	ra,8(sp)
 8a8:	6402                	ld	s0,0(sp)
 8aa:	0141                	add	sp,sp,16
 8ac:	8082                	ret

00000000000008ae <insert>:

// Function to insert a node at the beginning of the linked list
void insert(struct Node **head_ref, int new_data) {
 8ae:	1101                	add	sp,sp,-32
 8b0:	ec06                	sd	ra,24(sp)
 8b2:	e822                	sd	s0,16(sp)
 8b4:	e426                	sd	s1,8(sp)
 8b6:	e04a                	sd	s2,0(sp)
 8b8:	1000                	add	s0,sp,32
 8ba:	84aa                	mv	s1,a0
 8bc:	892e                	mv	s2,a1
    struct Node *new_node = malloc(sizeof(struct Node));
 8be:	4541                	li	a0,16
 8c0:	00000097          	auipc	ra,0x0
 8c4:	ee8080e7          	jalr	-280(ra) # 7a8 <malloc>
    new_node->data = new_data;
 8c8:	01252023          	sw	s2,0(a0)
    new_node->next = *head_ref;
 8cc:	609c                	ld	a5,0(s1)
 8ce:	e51c                	sd	a5,8(a0)
    *head_ref = new_node;
 8d0:	e088                	sd	a0,0(s1)
}
 8d2:	60e2                	ld	ra,24(sp)
 8d4:	6442                	ld	s0,16(sp)
 8d6:	64a2                	ld	s1,8(sp)
 8d8:	6902                	ld	s2,0(sp)
 8da:	6105                	add	sp,sp,32
 8dc:	8082                	ret

00000000000008de <deleteNode>:

// Function to delete a node with a given key from the linked list
void deleteNode(struct Node **head_ref, int key) {
 8de:	7179                	add	sp,sp,-48
 8e0:	f406                	sd	ra,40(sp)
 8e2:	f022                	sd	s0,32(sp)
 8e4:	ec26                	sd	s1,24(sp)
 8e6:	e84a                	sd	s2,16(sp)
 8e8:	e44e                	sd	s3,8(sp)
 8ea:	1800                	add	s0,sp,48
 8ec:	89aa                	mv	s3,a0
 8ee:	892e                	mv	s2,a1
    struct Node *temp = *head_ref, *prev = 0;
 8f0:	6104                	ld	s1,0(a0)

    acquire(&list_lock);
 8f2:	00000517          	auipc	a0,0x0
 8f6:	71650513          	add	a0,a0,1814 # 1008 <list_lock>
 8fa:	00000097          	auipc	ra,0x0
 8fe:	a0a080e7          	jalr	-1526(ra) # 304 <acquire>
    if (temp != 0 && temp->data == key) {
 902:	c0b1                	beqz	s1,946 <deleteNode+0x68>
 904:	409c                	lw	a5,0(s1)
 906:	4701                	li	a4,0
 908:	01278a63          	beq	a5,s2,91c <deleteNode+0x3e>
        rcusync();
        free(temp);
        return;
    }

    while (temp != 0 && temp->data != key) {
 90c:	409c                	lw	a5,0(s1)
 90e:	05278563          	beq	a5,s2,958 <deleteNode+0x7a>
        prev = temp;
        temp = temp->next;
 912:	649c                	ld	a5,8(s1)
    while (temp != 0 && temp->data != key) {
 914:	8726                	mv	a4,s1
 916:	cb85                	beqz	a5,946 <deleteNode+0x68>
        temp = temp->next;
 918:	84be                	mv	s1,a5
 91a:	bfcd                	j	90c <deleteNode+0x2e>
        *head_ref = temp->next;
 91c:	649c                	ld	a5,8(s1)
 91e:	00f9b023          	sd	a5,0(s3)
        release(&list_lock);
 922:	00000517          	auipc	a0,0x0
 926:	6e650513          	add	a0,a0,1766 # 1008 <list_lock>
 92a:	00000097          	auipc	ra,0x0
 92e:	9f2080e7          	jalr	-1550(ra) # 31c <release>
        rcusync();
 932:	00000097          	auipc	ra,0x0
 936:	ab6080e7          	jalr	-1354(ra) # 3e8 <rcusync>
        free(temp);
 93a:	8526                	mv	a0,s1
 93c:	00000097          	auipc	ra,0x0
 940:	dea080e7          	jalr	-534(ra) # 726 <free>
        return;
 944:	a82d                	j	97e <deleteNode+0xa0>
    }

    if (temp == 0) {
        release(&list_lock);
 946:	00000517          	auipc	a0,0x0
 94a:	6c250513          	add	a0,a0,1730 # 1008 <list_lock>
 94e:	00000097          	auipc	ra,0x0
 952:	9ce080e7          	jalr	-1586(ra) # 31c <release>
        return;
 956:	a025                	j	97e <deleteNode+0xa0>
    }
    prev->next = temp->next;
 958:	649c                	ld	a5,8(s1)
 95a:	e71c                	sd	a5,8(a4)
    release(&list_lock);
 95c:	00000517          	auipc	a0,0x0
 960:	6ac50513          	add	a0,a0,1708 # 1008 <list_lock>
 964:	00000097          	auipc	ra,0x0
 968:	9b8080e7          	jalr	-1608(ra) # 31c <release>
    rcusync();
 96c:	00000097          	auipc	ra,0x0
 970:	a7c080e7          	jalr	-1412(ra) # 3e8 <rcusync>
    free(temp);
 974:	8526                	mv	a0,s1
 976:	00000097          	auipc	ra,0x0
 97a:	db0080e7          	jalr	-592(ra) # 726 <free>
}
 97e:	70a2                	ld	ra,40(sp)
 980:	7402                	ld	s0,32(sp)
 982:	64e2                	ld	s1,24(sp)
 984:	6942                	ld	s2,16(sp)
 986:	69a2                	ld	s3,8(sp)
 988:	6145                	add	sp,sp,48
 98a:	8082                	ret

000000000000098c <search>:

// Function to search for a node with a given key in the linked list
struct Node* search(struct Node *head, int key) {
 98c:	1101                	add	sp,sp,-32
 98e:	ec06                	sd	ra,24(sp)
 990:	e822                	sd	s0,16(sp)
 992:	e426                	sd	s1,8(sp)
 994:	e04a                	sd	s2,0(sp)
 996:	1000                	add	s0,sp,32
 998:	84aa                	mv	s1,a0
 99a:	892e                	mv	s2,a1

    struct Node *current = head;
    rcureadlock();
 99c:	00000097          	auipc	ra,0x0
 9a0:	a3c080e7          	jalr	-1476(ra) # 3d8 <rcureadlock>
    while (current != 0) {
 9a4:	c491                	beqz	s1,9b0 <search+0x24>
        if (current->data == key) {
 9a6:	409c                	lw	a5,0(s1)
 9a8:	01278f63          	beq	a5,s2,9c6 <search+0x3a>
            rcureadunlock();
            return current; // Node found
        }
        current = current->next;
 9ac:	6484                	ld	s1,8(s1)
    while (current != 0) {
 9ae:	fce5                	bnez	s1,9a6 <search+0x1a>
    }
    rcureadunlock();
 9b0:	00000097          	auipc	ra,0x0
 9b4:	a30080e7          	jalr	-1488(ra) # 3e0 <rcureadunlock>
    return 0; // Node not found
 9b8:	4501                	li	a0,0
}
 9ba:	60e2                	ld	ra,24(sp)
 9bc:	6442                	ld	s0,16(sp)
 9be:	64a2                	ld	s1,8(sp)
 9c0:	6902                	ld	s2,0(sp)
 9c2:	6105                	add	sp,sp,32
 9c4:	8082                	ret
            rcureadunlock();
 9c6:	00000097          	auipc	ra,0x0
 9ca:	a1a080e7          	jalr	-1510(ra) # 3e0 <rcureadunlock>
            return current; // Node found
 9ce:	8526                	mv	a0,s1
 9d0:	b7ed                	j	9ba <search+0x2e>

00000000000009d2 <updateNode>:

// Function to update the value of a node with a given key in the linked list
void updateNode(struct Node *head, int key, int new_data) {
 9d2:	1101                	add	sp,sp,-32
 9d4:	ec06                	sd	ra,24(sp)
 9d6:	e822                	sd	s0,16(sp)
 9d8:	e426                	sd	s1,8(sp)
 9da:	e04a                	sd	s2,0(sp)
 9dc:	1000                	add	s0,sp,32
 9de:	892e                	mv	s2,a1
 9e0:	84b2                	mv	s1,a2
    struct Node *nodeToUpdate = search(head, key);
 9e2:	00000097          	auipc	ra,0x0
 9e6:	faa080e7          	jalr	-86(ra) # 98c <search>

    if (nodeToUpdate != 0) {
 9ea:	c901                	beqz	a0,9fa <updateNode+0x28>
        nodeToUpdate->data = new_data; // Update the node's data
 9ec:	c104                	sw	s1,0(a0)
    } else {
        printf("Node with key %d not found.\n", key);
    }
}
 9ee:	60e2                	ld	ra,24(sp)
 9f0:	6442                	ld	s0,16(sp)
 9f2:	64a2                	ld	s1,8(sp)
 9f4:	6902                	ld	s2,0(sp)
 9f6:	6105                	add	sp,sp,32
 9f8:	8082                	ret
        printf("Node with key %d not found.\n", key);
 9fa:	85ca                	mv	a1,s2
 9fc:	00000517          	auipc	a0,0x0
 a00:	0c450513          	add	a0,a0,196 # ac0 <digits+0x18>
 a04:	00000097          	auipc	ra,0x0
 a08:	cec080e7          	jalr	-788(ra) # 6f0 <printf>
}
 a0c:	b7cd                	j	9ee <updateNode+0x1c>
