
user/_ln:     file format elf64-littleriscv


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
   8:	1000                	add	s0,sp,32
  if(argc != 3){
   a:	478d                	li	a5,3
   c:	02f50063          	beq	a0,a5,2c <main+0x2c>
    fprintf(2, "Usage: ln old new\n");
  10:	00001597          	auipc	a1,0x1
  14:	9f058593          	add	a1,a1,-1552 # a00 <updateNode+0x44>
  18:	4509                	li	a0,2
  1a:	00000097          	auipc	ra,0x0
  1e:	692080e7          	jalr	1682(ra) # 6ac <fprintf>
    exit(1);
  22:	4505                	li	a0,1
  24:	00000097          	auipc	ra,0x0
  28:	2fe080e7          	jalr	766(ra) # 322 <exit>
  2c:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  2e:	698c                	ld	a1,16(a1)
  30:	6488                	ld	a0,8(s1)
  32:	00000097          	auipc	ra,0x0
  36:	350080e7          	jalr	848(ra) # 382 <link>
  3a:	00054763          	bltz	a0,48 <main+0x48>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	2e2080e7          	jalr	738(ra) # 322 <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  48:	6894                	ld	a3,16(s1)
  4a:	6490                	ld	a2,8(s1)
  4c:	00001597          	auipc	a1,0x1
  50:	9cc58593          	add	a1,a1,-1588 # a18 <updateNode+0x5c>
  54:	4509                	li	a0,2
  56:	00000097          	auipc	ra,0x0
  5a:	656080e7          	jalr	1622(ra) # 6ac <fprintf>
  5e:	b7c5                	j	3e <main+0x3e>

0000000000000060 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  60:	1141                	add	sp,sp,-16
  62:	e406                	sd	ra,8(sp)
  64:	e022                	sd	s0,0(sp)
  66:	0800                	add	s0,sp,16
  extern int main();
  main();
  68:	00000097          	auipc	ra,0x0
  6c:	f98080e7          	jalr	-104(ra) # 0 <main>
  exit(0);
  70:	4501                	li	a0,0
  72:	00000097          	auipc	ra,0x0
  76:	2b0080e7          	jalr	688(ra) # 322 <exit>

000000000000007a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  7a:	1141                	add	sp,sp,-16
  7c:	e422                	sd	s0,8(sp)
  7e:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  80:	87aa                	mv	a5,a0
  82:	0585                	add	a1,a1,1
  84:	0785                	add	a5,a5,1
  86:	fff5c703          	lbu	a4,-1(a1)
  8a:	fee78fa3          	sb	a4,-1(a5)
  8e:	fb75                	bnez	a4,82 <strcpy+0x8>
    ;
  return os;
}
  90:	6422                	ld	s0,8(sp)
  92:	0141                	add	sp,sp,16
  94:	8082                	ret

0000000000000096 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  96:	1141                	add	sp,sp,-16
  98:	e422                	sd	s0,8(sp)
  9a:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  9c:	00054783          	lbu	a5,0(a0)
  a0:	cb91                	beqz	a5,b4 <strcmp+0x1e>
  a2:	0005c703          	lbu	a4,0(a1)
  a6:	00f71763          	bne	a4,a5,b4 <strcmp+0x1e>
    p++, q++;
  aa:	0505                	add	a0,a0,1
  ac:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  ae:	00054783          	lbu	a5,0(a0)
  b2:	fbe5                	bnez	a5,a2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  b4:	0005c503          	lbu	a0,0(a1)
}
  b8:	40a7853b          	subw	a0,a5,a0
  bc:	6422                	ld	s0,8(sp)
  be:	0141                	add	sp,sp,16
  c0:	8082                	ret

00000000000000c2 <strlen>:

uint
strlen(const char *s)
{
  c2:	1141                	add	sp,sp,-16
  c4:	e422                	sd	s0,8(sp)
  c6:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  c8:	00054783          	lbu	a5,0(a0)
  cc:	cf91                	beqz	a5,e8 <strlen+0x26>
  ce:	0505                	add	a0,a0,1
  d0:	87aa                	mv	a5,a0
  d2:	86be                	mv	a3,a5
  d4:	0785                	add	a5,a5,1
  d6:	fff7c703          	lbu	a4,-1(a5)
  da:	ff65                	bnez	a4,d2 <strlen+0x10>
  dc:	40a6853b          	subw	a0,a3,a0
  e0:	2505                	addw	a0,a0,1
    ;
  return n;
}
  e2:	6422                	ld	s0,8(sp)
  e4:	0141                	add	sp,sp,16
  e6:	8082                	ret
  for(n = 0; s[n]; n++)
  e8:	4501                	li	a0,0
  ea:	bfe5                	j	e2 <strlen+0x20>

00000000000000ec <memset>:

void*
memset(void *dst, int c, uint n)
{
  ec:	1141                	add	sp,sp,-16
  ee:	e422                	sd	s0,8(sp)
  f0:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  f2:	ca19                	beqz	a2,108 <memset+0x1c>
  f4:	87aa                	mv	a5,a0
  f6:	1602                	sll	a2,a2,0x20
  f8:	9201                	srl	a2,a2,0x20
  fa:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  fe:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 102:	0785                	add	a5,a5,1
 104:	fee79de3          	bne	a5,a4,fe <memset+0x12>
  }
  return dst;
}
 108:	6422                	ld	s0,8(sp)
 10a:	0141                	add	sp,sp,16
 10c:	8082                	ret

000000000000010e <strchr>:

char*
strchr(const char *s, char c)
{
 10e:	1141                	add	sp,sp,-16
 110:	e422                	sd	s0,8(sp)
 112:	0800                	add	s0,sp,16
  for(; *s; s++)
 114:	00054783          	lbu	a5,0(a0)
 118:	cb99                	beqz	a5,12e <strchr+0x20>
    if(*s == c)
 11a:	00f58763          	beq	a1,a5,128 <strchr+0x1a>
  for(; *s; s++)
 11e:	0505                	add	a0,a0,1
 120:	00054783          	lbu	a5,0(a0)
 124:	fbfd                	bnez	a5,11a <strchr+0xc>
      return (char*)s;
  return 0;
 126:	4501                	li	a0,0
}
 128:	6422                	ld	s0,8(sp)
 12a:	0141                	add	sp,sp,16
 12c:	8082                	ret
  return 0;
 12e:	4501                	li	a0,0
 130:	bfe5                	j	128 <strchr+0x1a>

0000000000000132 <gets>:

char*
gets(char *buf, int max)
{
 132:	711d                	add	sp,sp,-96
 134:	ec86                	sd	ra,88(sp)
 136:	e8a2                	sd	s0,80(sp)
 138:	e4a6                	sd	s1,72(sp)
 13a:	e0ca                	sd	s2,64(sp)
 13c:	fc4e                	sd	s3,56(sp)
 13e:	f852                	sd	s4,48(sp)
 140:	f456                	sd	s5,40(sp)
 142:	f05a                	sd	s6,32(sp)
 144:	ec5e                	sd	s7,24(sp)
 146:	1080                	add	s0,sp,96
 148:	8baa                	mv	s7,a0
 14a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 14c:	892a                	mv	s2,a0
 14e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 150:	4aa9                	li	s5,10
 152:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 154:	89a6                	mv	s3,s1
 156:	2485                	addw	s1,s1,1
 158:	0344d863          	bge	s1,s4,188 <gets+0x56>
    cc = read(0, &c, 1);
 15c:	4605                	li	a2,1
 15e:	faf40593          	add	a1,s0,-81
 162:	4501                	li	a0,0
 164:	00000097          	auipc	ra,0x0
 168:	1d6080e7          	jalr	470(ra) # 33a <read>
    if(cc < 1)
 16c:	00a05e63          	blez	a0,188 <gets+0x56>
    buf[i++] = c;
 170:	faf44783          	lbu	a5,-81(s0)
 174:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 178:	01578763          	beq	a5,s5,186 <gets+0x54>
 17c:	0905                	add	s2,s2,1
 17e:	fd679be3          	bne	a5,s6,154 <gets+0x22>
  for(i=0; i+1 < max; ){
 182:	89a6                	mv	s3,s1
 184:	a011                	j	188 <gets+0x56>
 186:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 188:	99de                	add	s3,s3,s7
 18a:	00098023          	sb	zero,0(s3)
  return buf;
}
 18e:	855e                	mv	a0,s7
 190:	60e6                	ld	ra,88(sp)
 192:	6446                	ld	s0,80(sp)
 194:	64a6                	ld	s1,72(sp)
 196:	6906                	ld	s2,64(sp)
 198:	79e2                	ld	s3,56(sp)
 19a:	7a42                	ld	s4,48(sp)
 19c:	7aa2                	ld	s5,40(sp)
 19e:	7b02                	ld	s6,32(sp)
 1a0:	6be2                	ld	s7,24(sp)
 1a2:	6125                	add	sp,sp,96
 1a4:	8082                	ret

00000000000001a6 <stat>:

int
stat(const char *n, struct stat *st)
{
 1a6:	1101                	add	sp,sp,-32
 1a8:	ec06                	sd	ra,24(sp)
 1aa:	e822                	sd	s0,16(sp)
 1ac:	e426                	sd	s1,8(sp)
 1ae:	e04a                	sd	s2,0(sp)
 1b0:	1000                	add	s0,sp,32
 1b2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b4:	4581                	li	a1,0
 1b6:	00000097          	auipc	ra,0x0
 1ba:	1ac080e7          	jalr	428(ra) # 362 <open>
  if(fd < 0)
 1be:	02054563          	bltz	a0,1e8 <stat+0x42>
 1c2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1c4:	85ca                	mv	a1,s2
 1c6:	00000097          	auipc	ra,0x0
 1ca:	1b4080e7          	jalr	436(ra) # 37a <fstat>
 1ce:	892a                	mv	s2,a0
  close(fd);
 1d0:	8526                	mv	a0,s1
 1d2:	00000097          	auipc	ra,0x0
 1d6:	178080e7          	jalr	376(ra) # 34a <close>
  return r;
}
 1da:	854a                	mv	a0,s2
 1dc:	60e2                	ld	ra,24(sp)
 1de:	6442                	ld	s0,16(sp)
 1e0:	64a2                	ld	s1,8(sp)
 1e2:	6902                	ld	s2,0(sp)
 1e4:	6105                	add	sp,sp,32
 1e6:	8082                	ret
    return -1;
 1e8:	597d                	li	s2,-1
 1ea:	bfc5                	j	1da <stat+0x34>

00000000000001ec <atoi>:

int
atoi(const char *s)
{
 1ec:	1141                	add	sp,sp,-16
 1ee:	e422                	sd	s0,8(sp)
 1f0:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1f2:	00054683          	lbu	a3,0(a0)
 1f6:	fd06879b          	addw	a5,a3,-48
 1fa:	0ff7f793          	zext.b	a5,a5
 1fe:	4625                	li	a2,9
 200:	02f66863          	bltu	a2,a5,230 <atoi+0x44>
 204:	872a                	mv	a4,a0
  n = 0;
 206:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 208:	0705                	add	a4,a4,1
 20a:	0025179b          	sllw	a5,a0,0x2
 20e:	9fa9                	addw	a5,a5,a0
 210:	0017979b          	sllw	a5,a5,0x1
 214:	9fb5                	addw	a5,a5,a3
 216:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 21a:	00074683          	lbu	a3,0(a4)
 21e:	fd06879b          	addw	a5,a3,-48
 222:	0ff7f793          	zext.b	a5,a5
 226:	fef671e3          	bgeu	a2,a5,208 <atoi+0x1c>
  return n;
}
 22a:	6422                	ld	s0,8(sp)
 22c:	0141                	add	sp,sp,16
 22e:	8082                	ret
  n = 0;
 230:	4501                	li	a0,0
 232:	bfe5                	j	22a <atoi+0x3e>

0000000000000234 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 234:	1141                	add	sp,sp,-16
 236:	e422                	sd	s0,8(sp)
 238:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 23a:	02b57463          	bgeu	a0,a1,262 <memmove+0x2e>
    while(n-- > 0)
 23e:	00c05f63          	blez	a2,25c <memmove+0x28>
 242:	1602                	sll	a2,a2,0x20
 244:	9201                	srl	a2,a2,0x20
 246:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 24a:	872a                	mv	a4,a0
      *dst++ = *src++;
 24c:	0585                	add	a1,a1,1
 24e:	0705                	add	a4,a4,1
 250:	fff5c683          	lbu	a3,-1(a1)
 254:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 258:	fee79ae3          	bne	a5,a4,24c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 25c:	6422                	ld	s0,8(sp)
 25e:	0141                	add	sp,sp,16
 260:	8082                	ret
    dst += n;
 262:	00c50733          	add	a4,a0,a2
    src += n;
 266:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 268:	fec05ae3          	blez	a2,25c <memmove+0x28>
 26c:	fff6079b          	addw	a5,a2,-1
 270:	1782                	sll	a5,a5,0x20
 272:	9381                	srl	a5,a5,0x20
 274:	fff7c793          	not	a5,a5
 278:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 27a:	15fd                	add	a1,a1,-1
 27c:	177d                	add	a4,a4,-1
 27e:	0005c683          	lbu	a3,0(a1)
 282:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 286:	fee79ae3          	bne	a5,a4,27a <memmove+0x46>
 28a:	bfc9                	j	25c <memmove+0x28>

000000000000028c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 28c:	1141                	add	sp,sp,-16
 28e:	e422                	sd	s0,8(sp)
 290:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 292:	ca05                	beqz	a2,2c2 <memcmp+0x36>
 294:	fff6069b          	addw	a3,a2,-1
 298:	1682                	sll	a3,a3,0x20
 29a:	9281                	srl	a3,a3,0x20
 29c:	0685                	add	a3,a3,1
 29e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2a0:	00054783          	lbu	a5,0(a0)
 2a4:	0005c703          	lbu	a4,0(a1)
 2a8:	00e79863          	bne	a5,a4,2b8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2ac:	0505                	add	a0,a0,1
    p2++;
 2ae:	0585                	add	a1,a1,1
  while (n-- > 0) {
 2b0:	fed518e3          	bne	a0,a3,2a0 <memcmp+0x14>
  }
  return 0;
 2b4:	4501                	li	a0,0
 2b6:	a019                	j	2bc <memcmp+0x30>
      return *p1 - *p2;
 2b8:	40e7853b          	subw	a0,a5,a4
}
 2bc:	6422                	ld	s0,8(sp)
 2be:	0141                	add	sp,sp,16
 2c0:	8082                	ret
  return 0;
 2c2:	4501                	li	a0,0
 2c4:	bfe5                	j	2bc <memcmp+0x30>

00000000000002c6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2c6:	1141                	add	sp,sp,-16
 2c8:	e406                	sd	ra,8(sp)
 2ca:	e022                	sd	s0,0(sp)
 2cc:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 2ce:	00000097          	auipc	ra,0x0
 2d2:	f66080e7          	jalr	-154(ra) # 234 <memmove>
}
 2d6:	60a2                	ld	ra,8(sp)
 2d8:	6402                	ld	s0,0(sp)
 2da:	0141                	add	sp,sp,16
 2dc:	8082                	ret

00000000000002de <initlock>:

// Initialize the spinlock
void initlock(struct spinlock_u *lk) {
 2de:	1141                	add	sp,sp,-16
 2e0:	e422                	sd	s0,8(sp)
 2e2:	0800                	add	s0,sp,16
  lk->locked = 0;
 2e4:	00052023          	sw	zero,0(a0)
}
 2e8:	6422                	ld	s0,8(sp)
 2ea:	0141                	add	sp,sp,16
 2ec:	8082                	ret

00000000000002ee <acquire>:

// Acquire the spinlock
void acquire(struct spinlock_u *lk) {
 2ee:	1141                	add	sp,sp,-16
 2f0:	e422                	sd	s0,8(sp)
 2f2:	0800                	add	s0,sp,16
  while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 2f4:	4705                	li	a4,1
 2f6:	87ba                	mv	a5,a4
 2f8:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
 2fc:	2781                	sext.w	a5,a5
 2fe:	ffe5                	bnez	a5,2f6 <acquire+0x8>
    ; // Spin until the lock is acquired
}
 300:	6422                	ld	s0,8(sp)
 302:	0141                	add	sp,sp,16
 304:	8082                	ret

0000000000000306 <release>:

// Release the spinlock
void release(struct spinlock_u *lk) {
 306:	1141                	add	sp,sp,-16
 308:	e422                	sd	s0,8(sp)
 30a:	0800                	add	s0,sp,16
  __sync_lock_release(&lk->locked);
 30c:	0f50000f          	fence	iorw,ow
 310:	0805202f          	amoswap.w	zero,zero,(a0)
}
 314:	6422                	ld	s0,8(sp)
 316:	0141                	add	sp,sp,16
 318:	8082                	ret

000000000000031a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 31a:	4885                	li	a7,1
 ecall
 31c:	00000073          	ecall
 ret
 320:	8082                	ret

0000000000000322 <exit>:
.global exit
exit:
 li a7, SYS_exit
 322:	4889                	li	a7,2
 ecall
 324:	00000073          	ecall
 ret
 328:	8082                	ret

000000000000032a <wait>:
.global wait
wait:
 li a7, SYS_wait
 32a:	488d                	li	a7,3
 ecall
 32c:	00000073          	ecall
 ret
 330:	8082                	ret

0000000000000332 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 332:	4891                	li	a7,4
 ecall
 334:	00000073          	ecall
 ret
 338:	8082                	ret

000000000000033a <read>:
.global read
read:
 li a7, SYS_read
 33a:	4895                	li	a7,5
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <write>:
.global write
write:
 li a7, SYS_write
 342:	48c1                	li	a7,16
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <close>:
.global close
close:
 li a7, SYS_close
 34a:	48d5                	li	a7,21
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <kill>:
.global kill
kill:
 li a7, SYS_kill
 352:	4899                	li	a7,6
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <exec>:
.global exec
exec:
 li a7, SYS_exec
 35a:	489d                	li	a7,7
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <open>:
.global open
open:
 li a7, SYS_open
 362:	48bd                	li	a7,15
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 36a:	48c5                	li	a7,17
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 372:	48c9                	li	a7,18
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 37a:	48a1                	li	a7,8
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <link>:
.global link
link:
 li a7, SYS_link
 382:	48cd                	li	a7,19
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 38a:	48d1                	li	a7,20
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 392:	48a5                	li	a7,9
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <dup>:
.global dup
dup:
 li a7, SYS_dup
 39a:	48a9                	li	a7,10
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3a2:	48ad                	li	a7,11
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3aa:	48b1                	li	a7,12
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3b2:	48b5                	li	a7,13
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3ba:	48b9                	li	a7,14
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <rcureadlock>:
.global rcureadlock
rcureadlock:
 li a7, SYS_rcureadlock
 3c2:	48dd                	li	a7,23
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <rcureadunlock>:
.global rcureadunlock
rcureadunlock:
 li a7, SYS_rcureadunlock
 3ca:	48e1                	li	a7,24
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <rcusync>:
.global rcusync
rcusync:
 li a7, SYS_rcusync
 3d2:	48d9                	li	a7,22
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <thread_create>:
.global thread_create
thread_create:
 li a7, SYS_thread_create
 3da:	48e5                	li	a7,25
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <thread_join>:
.global thread_join
thread_join:
 li a7, SYS_thread_join
 3e2:	48e9                	li	a7,26
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <thread_exit>:
.global thread_exit
thread_exit:
 li a7, SYS_thread_exit
 3ea:	48ed                	li	a7,27
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <klist_insert>:
.global klist_insert
klist_insert:
 li a7, SYS_klist_insert
 3f2:	48f1                	li	a7,28
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <klist_delete>:
.global klist_delete
klist_delete:
 li a7, SYS_klist_delete
 3fa:	48f5                	li	a7,29
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <klist_query>:
.global klist_query
klist_query:
 li a7, SYS_klist_query
 402:	48f9                	li	a7,30
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <klist_print>:
.global klist_print
klist_print:
 li a7, SYS_klist_print
 40a:	48fd                	li	a7,31
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 412:	1101                	add	sp,sp,-32
 414:	ec06                	sd	ra,24(sp)
 416:	e822                	sd	s0,16(sp)
 418:	1000                	add	s0,sp,32
 41a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 41e:	4605                	li	a2,1
 420:	fef40593          	add	a1,s0,-17
 424:	00000097          	auipc	ra,0x0
 428:	f1e080e7          	jalr	-226(ra) # 342 <write>
}
 42c:	60e2                	ld	ra,24(sp)
 42e:	6442                	ld	s0,16(sp)
 430:	6105                	add	sp,sp,32
 432:	8082                	ret

0000000000000434 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 434:	7139                	add	sp,sp,-64
 436:	fc06                	sd	ra,56(sp)
 438:	f822                	sd	s0,48(sp)
 43a:	f426                	sd	s1,40(sp)
 43c:	f04a                	sd	s2,32(sp)
 43e:	ec4e                	sd	s3,24(sp)
 440:	0080                	add	s0,sp,64
 442:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 444:	c299                	beqz	a3,44a <printint+0x16>
 446:	0805c963          	bltz	a1,4d8 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 44a:	2581                	sext.w	a1,a1
  neg = 0;
 44c:	4881                	li	a7,0
 44e:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 452:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 454:	2601                	sext.w	a2,a2
 456:	00000517          	auipc	a0,0x0
 45a:	63a50513          	add	a0,a0,1594 # a90 <digits>
 45e:	883a                	mv	a6,a4
 460:	2705                	addw	a4,a4,1
 462:	02c5f7bb          	remuw	a5,a1,a2
 466:	1782                	sll	a5,a5,0x20
 468:	9381                	srl	a5,a5,0x20
 46a:	97aa                	add	a5,a5,a0
 46c:	0007c783          	lbu	a5,0(a5)
 470:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 474:	0005879b          	sext.w	a5,a1
 478:	02c5d5bb          	divuw	a1,a1,a2
 47c:	0685                	add	a3,a3,1
 47e:	fec7f0e3          	bgeu	a5,a2,45e <printint+0x2a>
  if(neg)
 482:	00088c63          	beqz	a7,49a <printint+0x66>
    buf[i++] = '-';
 486:	fd070793          	add	a5,a4,-48
 48a:	00878733          	add	a4,a5,s0
 48e:	02d00793          	li	a5,45
 492:	fef70823          	sb	a5,-16(a4)
 496:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 49a:	02e05863          	blez	a4,4ca <printint+0x96>
 49e:	fc040793          	add	a5,s0,-64
 4a2:	00e78933          	add	s2,a5,a4
 4a6:	fff78993          	add	s3,a5,-1
 4aa:	99ba                	add	s3,s3,a4
 4ac:	377d                	addw	a4,a4,-1
 4ae:	1702                	sll	a4,a4,0x20
 4b0:	9301                	srl	a4,a4,0x20
 4b2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4b6:	fff94583          	lbu	a1,-1(s2)
 4ba:	8526                	mv	a0,s1
 4bc:	00000097          	auipc	ra,0x0
 4c0:	f56080e7          	jalr	-170(ra) # 412 <putc>
  while(--i >= 0)
 4c4:	197d                	add	s2,s2,-1
 4c6:	ff3918e3          	bne	s2,s3,4b6 <printint+0x82>
}
 4ca:	70e2                	ld	ra,56(sp)
 4cc:	7442                	ld	s0,48(sp)
 4ce:	74a2                	ld	s1,40(sp)
 4d0:	7902                	ld	s2,32(sp)
 4d2:	69e2                	ld	s3,24(sp)
 4d4:	6121                	add	sp,sp,64
 4d6:	8082                	ret
    x = -xx;
 4d8:	40b005bb          	negw	a1,a1
    neg = 1;
 4dc:	4885                	li	a7,1
    x = -xx;
 4de:	bf85                	j	44e <printint+0x1a>

00000000000004e0 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4e0:	715d                	add	sp,sp,-80
 4e2:	e486                	sd	ra,72(sp)
 4e4:	e0a2                	sd	s0,64(sp)
 4e6:	fc26                	sd	s1,56(sp)
 4e8:	f84a                	sd	s2,48(sp)
 4ea:	f44e                	sd	s3,40(sp)
 4ec:	f052                	sd	s4,32(sp)
 4ee:	ec56                	sd	s5,24(sp)
 4f0:	e85a                	sd	s6,16(sp)
 4f2:	e45e                	sd	s7,8(sp)
 4f4:	e062                	sd	s8,0(sp)
 4f6:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4f8:	0005c903          	lbu	s2,0(a1)
 4fc:	18090c63          	beqz	s2,694 <vprintf+0x1b4>
 500:	8aaa                	mv	s5,a0
 502:	8bb2                	mv	s7,a2
 504:	00158493          	add	s1,a1,1
  state = 0;
 508:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 50a:	02500a13          	li	s4,37
 50e:	4b55                	li	s6,21
 510:	a839                	j	52e <vprintf+0x4e>
        putc(fd, c);
 512:	85ca                	mv	a1,s2
 514:	8556                	mv	a0,s5
 516:	00000097          	auipc	ra,0x0
 51a:	efc080e7          	jalr	-260(ra) # 412 <putc>
 51e:	a019                	j	524 <vprintf+0x44>
    } else if(state == '%'){
 520:	01498d63          	beq	s3,s4,53a <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 524:	0485                	add	s1,s1,1
 526:	fff4c903          	lbu	s2,-1(s1)
 52a:	16090563          	beqz	s2,694 <vprintf+0x1b4>
    if(state == 0){
 52e:	fe0999e3          	bnez	s3,520 <vprintf+0x40>
      if(c == '%'){
 532:	ff4910e3          	bne	s2,s4,512 <vprintf+0x32>
        state = '%';
 536:	89d2                	mv	s3,s4
 538:	b7f5                	j	524 <vprintf+0x44>
      if(c == 'd'){
 53a:	13490263          	beq	s2,s4,65e <vprintf+0x17e>
 53e:	f9d9079b          	addw	a5,s2,-99
 542:	0ff7f793          	zext.b	a5,a5
 546:	12fb6563          	bltu	s6,a5,670 <vprintf+0x190>
 54a:	f9d9079b          	addw	a5,s2,-99
 54e:	0ff7f713          	zext.b	a4,a5
 552:	10eb6f63          	bltu	s6,a4,670 <vprintf+0x190>
 556:	00271793          	sll	a5,a4,0x2
 55a:	00000717          	auipc	a4,0x0
 55e:	4de70713          	add	a4,a4,1246 # a38 <updateNode+0x7c>
 562:	97ba                	add	a5,a5,a4
 564:	439c                	lw	a5,0(a5)
 566:	97ba                	add	a5,a5,a4
 568:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 56a:	008b8913          	add	s2,s7,8
 56e:	4685                	li	a3,1
 570:	4629                	li	a2,10
 572:	000ba583          	lw	a1,0(s7)
 576:	8556                	mv	a0,s5
 578:	00000097          	auipc	ra,0x0
 57c:	ebc080e7          	jalr	-324(ra) # 434 <printint>
 580:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 582:	4981                	li	s3,0
 584:	b745                	j	524 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 586:	008b8913          	add	s2,s7,8
 58a:	4681                	li	a3,0
 58c:	4629                	li	a2,10
 58e:	000ba583          	lw	a1,0(s7)
 592:	8556                	mv	a0,s5
 594:	00000097          	auipc	ra,0x0
 598:	ea0080e7          	jalr	-352(ra) # 434 <printint>
 59c:	8bca                	mv	s7,s2
      state = 0;
 59e:	4981                	li	s3,0
 5a0:	b751                	j	524 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 5a2:	008b8913          	add	s2,s7,8
 5a6:	4681                	li	a3,0
 5a8:	4641                	li	a2,16
 5aa:	000ba583          	lw	a1,0(s7)
 5ae:	8556                	mv	a0,s5
 5b0:	00000097          	auipc	ra,0x0
 5b4:	e84080e7          	jalr	-380(ra) # 434 <printint>
 5b8:	8bca                	mv	s7,s2
      state = 0;
 5ba:	4981                	li	s3,0
 5bc:	b7a5                	j	524 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 5be:	008b8c13          	add	s8,s7,8
 5c2:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 5c6:	03000593          	li	a1,48
 5ca:	8556                	mv	a0,s5
 5cc:	00000097          	auipc	ra,0x0
 5d0:	e46080e7          	jalr	-442(ra) # 412 <putc>
  putc(fd, 'x');
 5d4:	07800593          	li	a1,120
 5d8:	8556                	mv	a0,s5
 5da:	00000097          	auipc	ra,0x0
 5de:	e38080e7          	jalr	-456(ra) # 412 <putc>
 5e2:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5e4:	00000b97          	auipc	s7,0x0
 5e8:	4acb8b93          	add	s7,s7,1196 # a90 <digits>
 5ec:	03c9d793          	srl	a5,s3,0x3c
 5f0:	97de                	add	a5,a5,s7
 5f2:	0007c583          	lbu	a1,0(a5)
 5f6:	8556                	mv	a0,s5
 5f8:	00000097          	auipc	ra,0x0
 5fc:	e1a080e7          	jalr	-486(ra) # 412 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 600:	0992                	sll	s3,s3,0x4
 602:	397d                	addw	s2,s2,-1
 604:	fe0914e3          	bnez	s2,5ec <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 608:	8be2                	mv	s7,s8
      state = 0;
 60a:	4981                	li	s3,0
 60c:	bf21                	j	524 <vprintf+0x44>
        s = va_arg(ap, char*);
 60e:	008b8993          	add	s3,s7,8
 612:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 616:	02090163          	beqz	s2,638 <vprintf+0x158>
        while(*s != 0){
 61a:	00094583          	lbu	a1,0(s2)
 61e:	c9a5                	beqz	a1,68e <vprintf+0x1ae>
          putc(fd, *s);
 620:	8556                	mv	a0,s5
 622:	00000097          	auipc	ra,0x0
 626:	df0080e7          	jalr	-528(ra) # 412 <putc>
          s++;
 62a:	0905                	add	s2,s2,1
        while(*s != 0){
 62c:	00094583          	lbu	a1,0(s2)
 630:	f9e5                	bnez	a1,620 <vprintf+0x140>
        s = va_arg(ap, char*);
 632:	8bce                	mv	s7,s3
      state = 0;
 634:	4981                	li	s3,0
 636:	b5fd                	j	524 <vprintf+0x44>
          s = "(null)";
 638:	00000917          	auipc	s2,0x0
 63c:	3f890913          	add	s2,s2,1016 # a30 <updateNode+0x74>
        while(*s != 0){
 640:	02800593          	li	a1,40
 644:	bff1                	j	620 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 646:	008b8913          	add	s2,s7,8
 64a:	000bc583          	lbu	a1,0(s7)
 64e:	8556                	mv	a0,s5
 650:	00000097          	auipc	ra,0x0
 654:	dc2080e7          	jalr	-574(ra) # 412 <putc>
 658:	8bca                	mv	s7,s2
      state = 0;
 65a:	4981                	li	s3,0
 65c:	b5e1                	j	524 <vprintf+0x44>
        putc(fd, c);
 65e:	02500593          	li	a1,37
 662:	8556                	mv	a0,s5
 664:	00000097          	auipc	ra,0x0
 668:	dae080e7          	jalr	-594(ra) # 412 <putc>
      state = 0;
 66c:	4981                	li	s3,0
 66e:	bd5d                	j	524 <vprintf+0x44>
        putc(fd, '%');
 670:	02500593          	li	a1,37
 674:	8556                	mv	a0,s5
 676:	00000097          	auipc	ra,0x0
 67a:	d9c080e7          	jalr	-612(ra) # 412 <putc>
        putc(fd, c);
 67e:	85ca                	mv	a1,s2
 680:	8556                	mv	a0,s5
 682:	00000097          	auipc	ra,0x0
 686:	d90080e7          	jalr	-624(ra) # 412 <putc>
      state = 0;
 68a:	4981                	li	s3,0
 68c:	bd61                	j	524 <vprintf+0x44>
        s = va_arg(ap, char*);
 68e:	8bce                	mv	s7,s3
      state = 0;
 690:	4981                	li	s3,0
 692:	bd49                	j	524 <vprintf+0x44>
    }
  }
}
 694:	60a6                	ld	ra,72(sp)
 696:	6406                	ld	s0,64(sp)
 698:	74e2                	ld	s1,56(sp)
 69a:	7942                	ld	s2,48(sp)
 69c:	79a2                	ld	s3,40(sp)
 69e:	7a02                	ld	s4,32(sp)
 6a0:	6ae2                	ld	s5,24(sp)
 6a2:	6b42                	ld	s6,16(sp)
 6a4:	6ba2                	ld	s7,8(sp)
 6a6:	6c02                	ld	s8,0(sp)
 6a8:	6161                	add	sp,sp,80
 6aa:	8082                	ret

00000000000006ac <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6ac:	715d                	add	sp,sp,-80
 6ae:	ec06                	sd	ra,24(sp)
 6b0:	e822                	sd	s0,16(sp)
 6b2:	1000                	add	s0,sp,32
 6b4:	e010                	sd	a2,0(s0)
 6b6:	e414                	sd	a3,8(s0)
 6b8:	e818                	sd	a4,16(s0)
 6ba:	ec1c                	sd	a5,24(s0)
 6bc:	03043023          	sd	a6,32(s0)
 6c0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6c4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6c8:	8622                	mv	a2,s0
 6ca:	00000097          	auipc	ra,0x0
 6ce:	e16080e7          	jalr	-490(ra) # 4e0 <vprintf>
}
 6d2:	60e2                	ld	ra,24(sp)
 6d4:	6442                	ld	s0,16(sp)
 6d6:	6161                	add	sp,sp,80
 6d8:	8082                	ret

00000000000006da <printf>:

void
printf(const char *fmt, ...)
{
 6da:	711d                	add	sp,sp,-96
 6dc:	ec06                	sd	ra,24(sp)
 6de:	e822                	sd	s0,16(sp)
 6e0:	1000                	add	s0,sp,32
 6e2:	e40c                	sd	a1,8(s0)
 6e4:	e810                	sd	a2,16(s0)
 6e6:	ec14                	sd	a3,24(s0)
 6e8:	f018                	sd	a4,32(s0)
 6ea:	f41c                	sd	a5,40(s0)
 6ec:	03043823          	sd	a6,48(s0)
 6f0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6f4:	00840613          	add	a2,s0,8
 6f8:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6fc:	85aa                	mv	a1,a0
 6fe:	4505                	li	a0,1
 700:	00000097          	auipc	ra,0x0
 704:	de0080e7          	jalr	-544(ra) # 4e0 <vprintf>
}
 708:	60e2                	ld	ra,24(sp)
 70a:	6442                	ld	s0,16(sp)
 70c:	6125                	add	sp,sp,96
 70e:	8082                	ret

0000000000000710 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 710:	1141                	add	sp,sp,-16
 712:	e422                	sd	s0,8(sp)
 714:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 716:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 71a:	00001797          	auipc	a5,0x1
 71e:	8e67b783          	ld	a5,-1818(a5) # 1000 <freep>
 722:	a02d                	j	74c <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 724:	4618                	lw	a4,8(a2)
 726:	9f2d                	addw	a4,a4,a1
 728:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 72c:	6398                	ld	a4,0(a5)
 72e:	6310                	ld	a2,0(a4)
 730:	a83d                	j	76e <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 732:	ff852703          	lw	a4,-8(a0)
 736:	9f31                	addw	a4,a4,a2
 738:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 73a:	ff053683          	ld	a3,-16(a0)
 73e:	a091                	j	782 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 740:	6398                	ld	a4,0(a5)
 742:	00e7e463          	bltu	a5,a4,74a <free+0x3a>
 746:	00e6ea63          	bltu	a3,a4,75a <free+0x4a>
{
 74a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 74c:	fed7fae3          	bgeu	a5,a3,740 <free+0x30>
 750:	6398                	ld	a4,0(a5)
 752:	00e6e463          	bltu	a3,a4,75a <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 756:	fee7eae3          	bltu	a5,a4,74a <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 75a:	ff852583          	lw	a1,-8(a0)
 75e:	6390                	ld	a2,0(a5)
 760:	02059813          	sll	a6,a1,0x20
 764:	01c85713          	srl	a4,a6,0x1c
 768:	9736                	add	a4,a4,a3
 76a:	fae60de3          	beq	a2,a4,724 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 76e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 772:	4790                	lw	a2,8(a5)
 774:	02061593          	sll	a1,a2,0x20
 778:	01c5d713          	srl	a4,a1,0x1c
 77c:	973e                	add	a4,a4,a5
 77e:	fae68ae3          	beq	a3,a4,732 <free+0x22>
    p->s.ptr = bp->s.ptr;
 782:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 784:	00001717          	auipc	a4,0x1
 788:	86f73e23          	sd	a5,-1924(a4) # 1000 <freep>
}
 78c:	6422                	ld	s0,8(sp)
 78e:	0141                	add	sp,sp,16
 790:	8082                	ret

0000000000000792 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 792:	7139                	add	sp,sp,-64
 794:	fc06                	sd	ra,56(sp)
 796:	f822                	sd	s0,48(sp)
 798:	f426                	sd	s1,40(sp)
 79a:	f04a                	sd	s2,32(sp)
 79c:	ec4e                	sd	s3,24(sp)
 79e:	e852                	sd	s4,16(sp)
 7a0:	e456                	sd	s5,8(sp)
 7a2:	e05a                	sd	s6,0(sp)
 7a4:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a6:	02051493          	sll	s1,a0,0x20
 7aa:	9081                	srl	s1,s1,0x20
 7ac:	04bd                	add	s1,s1,15
 7ae:	8091                	srl	s1,s1,0x4
 7b0:	0014899b          	addw	s3,s1,1
 7b4:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 7b6:	00001517          	auipc	a0,0x1
 7ba:	84a53503          	ld	a0,-1974(a0) # 1000 <freep>
 7be:	c515                	beqz	a0,7ea <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7c2:	4798                	lw	a4,8(a5)
 7c4:	02977f63          	bgeu	a4,s1,802 <malloc+0x70>
  if(nu < 4096)
 7c8:	8a4e                	mv	s4,s3
 7ca:	0009871b          	sext.w	a4,s3
 7ce:	6685                	lui	a3,0x1
 7d0:	00d77363          	bgeu	a4,a3,7d6 <malloc+0x44>
 7d4:	6a05                	lui	s4,0x1
 7d6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7da:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7de:	00001917          	auipc	s2,0x1
 7e2:	82290913          	add	s2,s2,-2014 # 1000 <freep>
  if(p == (char*)-1)
 7e6:	5afd                	li	s5,-1
 7e8:	a895                	j	85c <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 7ea:	00001797          	auipc	a5,0x1
 7ee:	82678793          	add	a5,a5,-2010 # 1010 <base>
 7f2:	00001717          	auipc	a4,0x1
 7f6:	80f73723          	sd	a5,-2034(a4) # 1000 <freep>
 7fa:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7fc:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 800:	b7e1                	j	7c8 <malloc+0x36>
      if(p->s.size == nunits)
 802:	02e48c63          	beq	s1,a4,83a <malloc+0xa8>
        p->s.size -= nunits;
 806:	4137073b          	subw	a4,a4,s3
 80a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 80c:	02071693          	sll	a3,a4,0x20
 810:	01c6d713          	srl	a4,a3,0x1c
 814:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 816:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 81a:	00000717          	auipc	a4,0x0
 81e:	7ea73323          	sd	a0,2022(a4) # 1000 <freep>
      return (void*)(p + 1);
 822:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 826:	70e2                	ld	ra,56(sp)
 828:	7442                	ld	s0,48(sp)
 82a:	74a2                	ld	s1,40(sp)
 82c:	7902                	ld	s2,32(sp)
 82e:	69e2                	ld	s3,24(sp)
 830:	6a42                	ld	s4,16(sp)
 832:	6aa2                	ld	s5,8(sp)
 834:	6b02                	ld	s6,0(sp)
 836:	6121                	add	sp,sp,64
 838:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 83a:	6398                	ld	a4,0(a5)
 83c:	e118                	sd	a4,0(a0)
 83e:	bff1                	j	81a <malloc+0x88>
  hp->s.size = nu;
 840:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 844:	0541                	add	a0,a0,16
 846:	00000097          	auipc	ra,0x0
 84a:	eca080e7          	jalr	-310(ra) # 710 <free>
  return freep;
 84e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 852:	d971                	beqz	a0,826 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 854:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 856:	4798                	lw	a4,8(a5)
 858:	fa9775e3          	bgeu	a4,s1,802 <malloc+0x70>
    if(p == freep)
 85c:	00093703          	ld	a4,0(s2)
 860:	853e                	mv	a0,a5
 862:	fef719e3          	bne	a4,a5,854 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 866:	8552                	mv	a0,s4
 868:	00000097          	auipc	ra,0x0
 86c:	b42080e7          	jalr	-1214(ra) # 3aa <sbrk>
  if(p == (char*)-1)
 870:	fd5518e3          	bne	a0,s5,840 <malloc+0xae>
        return 0;
 874:	4501                	li	a0,0
 876:	bf45                	j	826 <malloc+0x94>

0000000000000878 <init_lock>:
#include "linkedlist.h"

// Define a node structure for the linked list
struct spinlock_u list_lock;

void init_lock(){
 878:	1141                	add	sp,sp,-16
 87a:	e406                	sd	ra,8(sp)
 87c:	e022                	sd	s0,0(sp)
 87e:	0800                	add	s0,sp,16
    initlock(&list_lock);
 880:	00000517          	auipc	a0,0x0
 884:	78850513          	add	a0,a0,1928 # 1008 <list_lock>
 888:	00000097          	auipc	ra,0x0
 88c:	a56080e7          	jalr	-1450(ra) # 2de <initlock>
}
 890:	60a2                	ld	ra,8(sp)
 892:	6402                	ld	s0,0(sp)
 894:	0141                	add	sp,sp,16
 896:	8082                	ret

0000000000000898 <insert>:

// Function to insert a node at the beginning of the linked list
void insert(struct Node **head_ref, int new_data) {
 898:	1101                	add	sp,sp,-32
 89a:	ec06                	sd	ra,24(sp)
 89c:	e822                	sd	s0,16(sp)
 89e:	e426                	sd	s1,8(sp)
 8a0:	e04a                	sd	s2,0(sp)
 8a2:	1000                	add	s0,sp,32
 8a4:	84aa                	mv	s1,a0
 8a6:	892e                	mv	s2,a1
    struct Node *new_node = malloc(sizeof(struct Node));
 8a8:	4541                	li	a0,16
 8aa:	00000097          	auipc	ra,0x0
 8ae:	ee8080e7          	jalr	-280(ra) # 792 <malloc>
    new_node->data = new_data;
 8b2:	01252023          	sw	s2,0(a0)
    new_node->next = *head_ref;
 8b6:	609c                	ld	a5,0(s1)
 8b8:	e51c                	sd	a5,8(a0)
    *head_ref = new_node;
 8ba:	e088                	sd	a0,0(s1)
}
 8bc:	60e2                	ld	ra,24(sp)
 8be:	6442                	ld	s0,16(sp)
 8c0:	64a2                	ld	s1,8(sp)
 8c2:	6902                	ld	s2,0(sp)
 8c4:	6105                	add	sp,sp,32
 8c6:	8082                	ret

00000000000008c8 <deleteNode>:

// Function to delete a node with a given key from the linked list
void deleteNode(struct Node **head_ref, int key) {
 8c8:	7179                	add	sp,sp,-48
 8ca:	f406                	sd	ra,40(sp)
 8cc:	f022                	sd	s0,32(sp)
 8ce:	ec26                	sd	s1,24(sp)
 8d0:	e84a                	sd	s2,16(sp)
 8d2:	e44e                	sd	s3,8(sp)
 8d4:	1800                	add	s0,sp,48
 8d6:	89aa                	mv	s3,a0
 8d8:	892e                	mv	s2,a1
    struct Node *temp = *head_ref, *prev = 0;
 8da:	6104                	ld	s1,0(a0)

    acquire(&list_lock);
 8dc:	00000517          	auipc	a0,0x0
 8e0:	72c50513          	add	a0,a0,1836 # 1008 <list_lock>
 8e4:	00000097          	auipc	ra,0x0
 8e8:	a0a080e7          	jalr	-1526(ra) # 2ee <acquire>
    if (temp != 0 && temp->data == key) {
 8ec:	c0b1                	beqz	s1,930 <deleteNode+0x68>
 8ee:	409c                	lw	a5,0(s1)
 8f0:	4701                	li	a4,0
 8f2:	01278a63          	beq	a5,s2,906 <deleteNode+0x3e>
        rcusync();
        free(temp);
        return;
    }

    while (temp != 0 && temp->data != key) {
 8f6:	409c                	lw	a5,0(s1)
 8f8:	05278563          	beq	a5,s2,942 <deleteNode+0x7a>
        prev = temp;
        temp = temp->next;
 8fc:	649c                	ld	a5,8(s1)
    while (temp != 0 && temp->data != key) {
 8fe:	8726                	mv	a4,s1
 900:	cb85                	beqz	a5,930 <deleteNode+0x68>
        temp = temp->next;
 902:	84be                	mv	s1,a5
 904:	bfcd                	j	8f6 <deleteNode+0x2e>
        *head_ref = temp->next;
 906:	649c                	ld	a5,8(s1)
 908:	00f9b023          	sd	a5,0(s3)
        release(&list_lock);
 90c:	00000517          	auipc	a0,0x0
 910:	6fc50513          	add	a0,a0,1788 # 1008 <list_lock>
 914:	00000097          	auipc	ra,0x0
 918:	9f2080e7          	jalr	-1550(ra) # 306 <release>
        rcusync();
 91c:	00000097          	auipc	ra,0x0
 920:	ab6080e7          	jalr	-1354(ra) # 3d2 <rcusync>
        free(temp);
 924:	8526                	mv	a0,s1
 926:	00000097          	auipc	ra,0x0
 92a:	dea080e7          	jalr	-534(ra) # 710 <free>
        return;
 92e:	a82d                	j	968 <deleteNode+0xa0>
    }

    if (temp == 0) {
        release(&list_lock);
 930:	00000517          	auipc	a0,0x0
 934:	6d850513          	add	a0,a0,1752 # 1008 <list_lock>
 938:	00000097          	auipc	ra,0x0
 93c:	9ce080e7          	jalr	-1586(ra) # 306 <release>
        return;
 940:	a025                	j	968 <deleteNode+0xa0>
    }
    prev->next = temp->next;
 942:	649c                	ld	a5,8(s1)
 944:	e71c                	sd	a5,8(a4)
    release(&list_lock);
 946:	00000517          	auipc	a0,0x0
 94a:	6c250513          	add	a0,a0,1730 # 1008 <list_lock>
 94e:	00000097          	auipc	ra,0x0
 952:	9b8080e7          	jalr	-1608(ra) # 306 <release>
    rcusync();
 956:	00000097          	auipc	ra,0x0
 95a:	a7c080e7          	jalr	-1412(ra) # 3d2 <rcusync>
    free(temp);
 95e:	8526                	mv	a0,s1
 960:	00000097          	auipc	ra,0x0
 964:	db0080e7          	jalr	-592(ra) # 710 <free>
}
 968:	70a2                	ld	ra,40(sp)
 96a:	7402                	ld	s0,32(sp)
 96c:	64e2                	ld	s1,24(sp)
 96e:	6942                	ld	s2,16(sp)
 970:	69a2                	ld	s3,8(sp)
 972:	6145                	add	sp,sp,48
 974:	8082                	ret

0000000000000976 <search>:

// Function to search for a node with a given key in the linked list
struct Node* search(struct Node *head, int key) {
 976:	1101                	add	sp,sp,-32
 978:	ec06                	sd	ra,24(sp)
 97a:	e822                	sd	s0,16(sp)
 97c:	e426                	sd	s1,8(sp)
 97e:	e04a                	sd	s2,0(sp)
 980:	1000                	add	s0,sp,32
 982:	84aa                	mv	s1,a0
 984:	892e                	mv	s2,a1

    struct Node *current = head;
    rcureadlock();
 986:	00000097          	auipc	ra,0x0
 98a:	a3c080e7          	jalr	-1476(ra) # 3c2 <rcureadlock>
    while (current != 0) {
 98e:	c491                	beqz	s1,99a <search+0x24>
        if (current->data == key) {
 990:	409c                	lw	a5,0(s1)
 992:	01278f63          	beq	a5,s2,9b0 <search+0x3a>
            rcureadunlock();
            return current; // Node found
        }
        current = current->next;
 996:	6484                	ld	s1,8(s1)
    while (current != 0) {
 998:	fce5                	bnez	s1,990 <search+0x1a>
    }
    rcureadunlock();
 99a:	00000097          	auipc	ra,0x0
 99e:	a30080e7          	jalr	-1488(ra) # 3ca <rcureadunlock>
    return 0; // Node not found
 9a2:	4501                	li	a0,0
}
 9a4:	60e2                	ld	ra,24(sp)
 9a6:	6442                	ld	s0,16(sp)
 9a8:	64a2                	ld	s1,8(sp)
 9aa:	6902                	ld	s2,0(sp)
 9ac:	6105                	add	sp,sp,32
 9ae:	8082                	ret
            rcureadunlock();
 9b0:	00000097          	auipc	ra,0x0
 9b4:	a1a080e7          	jalr	-1510(ra) # 3ca <rcureadunlock>
            return current; // Node found
 9b8:	8526                	mv	a0,s1
 9ba:	b7ed                	j	9a4 <search+0x2e>

00000000000009bc <updateNode>:

// Function to update the value of a node with a given key in the linked list
void updateNode(struct Node *head, int key, int new_data) {
 9bc:	1101                	add	sp,sp,-32
 9be:	ec06                	sd	ra,24(sp)
 9c0:	e822                	sd	s0,16(sp)
 9c2:	e426                	sd	s1,8(sp)
 9c4:	e04a                	sd	s2,0(sp)
 9c6:	1000                	add	s0,sp,32
 9c8:	892e                	mv	s2,a1
 9ca:	84b2                	mv	s1,a2
    struct Node *nodeToUpdate = search(head, key);
 9cc:	00000097          	auipc	ra,0x0
 9d0:	faa080e7          	jalr	-86(ra) # 976 <search>

    if (nodeToUpdate != 0) {
 9d4:	c901                	beqz	a0,9e4 <updateNode+0x28>
        nodeToUpdate->data = new_data; // Update the node's data
 9d6:	c104                	sw	s1,0(a0)
    } else {
        printf("Node with key %d not found.\n", key);
    }
}
 9d8:	60e2                	ld	ra,24(sp)
 9da:	6442                	ld	s0,16(sp)
 9dc:	64a2                	ld	s1,8(sp)
 9de:	6902                	ld	s2,0(sp)
 9e0:	6105                	add	sp,sp,32
 9e2:	8082                	ret
        printf("Node with key %d not found.\n", key);
 9e4:	85ca                	mv	a1,s2
 9e6:	00000517          	auipc	a0,0x0
 9ea:	0c250513          	add	a0,a0,194 # aa8 <digits+0x18>
 9ee:	00000097          	auipc	ra,0x0
 9f2:	cec080e7          	jalr	-788(ra) # 6da <printf>
}
 9f6:	b7cd                	j	9d8 <updateNode+0x1c>
