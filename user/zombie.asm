
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	add	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	add	s0,sp,16
  if(fork() > 0)
   8:	00000097          	auipc	ra,0x0
   c:	2dc080e7          	jalr	732(ra) # 2e4 <fork>
  10:	00a04763          	bgtz	a0,1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  exit(0);
  14:	4501                	li	a0,0
  16:	00000097          	auipc	ra,0x0
  1a:	2d6080e7          	jalr	726(ra) # 2ec <exit>
    sleep(5);  // Let child exit before parent.
  1e:	4515                	li	a0,5
  20:	00000097          	auipc	ra,0x0
  24:	35c080e7          	jalr	860(ra) # 37c <sleep>
  28:	b7f5                	j	14 <main+0x14>

000000000000002a <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  2a:	1141                	add	sp,sp,-16
  2c:	e406                	sd	ra,8(sp)
  2e:	e022                	sd	s0,0(sp)
  30:	0800                	add	s0,sp,16
  extern int main();
  main();
  32:	00000097          	auipc	ra,0x0
  36:	fce080e7          	jalr	-50(ra) # 0 <main>
  exit(0);
  3a:	4501                	li	a0,0
  3c:	00000097          	auipc	ra,0x0
  40:	2b0080e7          	jalr	688(ra) # 2ec <exit>

0000000000000044 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  44:	1141                	add	sp,sp,-16
  46:	e422                	sd	s0,8(sp)
  48:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  4a:	87aa                	mv	a5,a0
  4c:	0585                	add	a1,a1,1
  4e:	0785                	add	a5,a5,1
  50:	fff5c703          	lbu	a4,-1(a1)
  54:	fee78fa3          	sb	a4,-1(a5)
  58:	fb75                	bnez	a4,4c <strcpy+0x8>
    ;
  return os;
}
  5a:	6422                	ld	s0,8(sp)
  5c:	0141                	add	sp,sp,16
  5e:	8082                	ret

0000000000000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	1141                	add	sp,sp,-16
  62:	e422                	sd	s0,8(sp)
  64:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  66:	00054783          	lbu	a5,0(a0)
  6a:	cb91                	beqz	a5,7e <strcmp+0x1e>
  6c:	0005c703          	lbu	a4,0(a1)
  70:	00f71763          	bne	a4,a5,7e <strcmp+0x1e>
    p++, q++;
  74:	0505                	add	a0,a0,1
  76:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  78:	00054783          	lbu	a5,0(a0)
  7c:	fbe5                	bnez	a5,6c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  7e:	0005c503          	lbu	a0,0(a1)
}
  82:	40a7853b          	subw	a0,a5,a0
  86:	6422                	ld	s0,8(sp)
  88:	0141                	add	sp,sp,16
  8a:	8082                	ret

000000000000008c <strlen>:

uint
strlen(const char *s)
{
  8c:	1141                	add	sp,sp,-16
  8e:	e422                	sd	s0,8(sp)
  90:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  92:	00054783          	lbu	a5,0(a0)
  96:	cf91                	beqz	a5,b2 <strlen+0x26>
  98:	0505                	add	a0,a0,1
  9a:	87aa                	mv	a5,a0
  9c:	86be                	mv	a3,a5
  9e:	0785                	add	a5,a5,1
  a0:	fff7c703          	lbu	a4,-1(a5)
  a4:	ff65                	bnez	a4,9c <strlen+0x10>
  a6:	40a6853b          	subw	a0,a3,a0
  aa:	2505                	addw	a0,a0,1
    ;
  return n;
}
  ac:	6422                	ld	s0,8(sp)
  ae:	0141                	add	sp,sp,16
  b0:	8082                	ret
  for(n = 0; s[n]; n++)
  b2:	4501                	li	a0,0
  b4:	bfe5                	j	ac <strlen+0x20>

00000000000000b6 <memset>:

void*
memset(void *dst, int c, uint n)
{
  b6:	1141                	add	sp,sp,-16
  b8:	e422                	sd	s0,8(sp)
  ba:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  bc:	ca19                	beqz	a2,d2 <memset+0x1c>
  be:	87aa                	mv	a5,a0
  c0:	1602                	sll	a2,a2,0x20
  c2:	9201                	srl	a2,a2,0x20
  c4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  c8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  cc:	0785                	add	a5,a5,1
  ce:	fee79de3          	bne	a5,a4,c8 <memset+0x12>
  }
  return dst;
}
  d2:	6422                	ld	s0,8(sp)
  d4:	0141                	add	sp,sp,16
  d6:	8082                	ret

00000000000000d8 <strchr>:

char*
strchr(const char *s, char c)
{
  d8:	1141                	add	sp,sp,-16
  da:	e422                	sd	s0,8(sp)
  dc:	0800                	add	s0,sp,16
  for(; *s; s++)
  de:	00054783          	lbu	a5,0(a0)
  e2:	cb99                	beqz	a5,f8 <strchr+0x20>
    if(*s == c)
  e4:	00f58763          	beq	a1,a5,f2 <strchr+0x1a>
  for(; *s; s++)
  e8:	0505                	add	a0,a0,1
  ea:	00054783          	lbu	a5,0(a0)
  ee:	fbfd                	bnez	a5,e4 <strchr+0xc>
      return (char*)s;
  return 0;
  f0:	4501                	li	a0,0
}
  f2:	6422                	ld	s0,8(sp)
  f4:	0141                	add	sp,sp,16
  f6:	8082                	ret
  return 0;
  f8:	4501                	li	a0,0
  fa:	bfe5                	j	f2 <strchr+0x1a>

00000000000000fc <gets>:

char*
gets(char *buf, int max)
{
  fc:	711d                	add	sp,sp,-96
  fe:	ec86                	sd	ra,88(sp)
 100:	e8a2                	sd	s0,80(sp)
 102:	e4a6                	sd	s1,72(sp)
 104:	e0ca                	sd	s2,64(sp)
 106:	fc4e                	sd	s3,56(sp)
 108:	f852                	sd	s4,48(sp)
 10a:	f456                	sd	s5,40(sp)
 10c:	f05a                	sd	s6,32(sp)
 10e:	ec5e                	sd	s7,24(sp)
 110:	1080                	add	s0,sp,96
 112:	8baa                	mv	s7,a0
 114:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 116:	892a                	mv	s2,a0
 118:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 11a:	4aa9                	li	s5,10
 11c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 11e:	89a6                	mv	s3,s1
 120:	2485                	addw	s1,s1,1
 122:	0344d863          	bge	s1,s4,152 <gets+0x56>
    cc = read(0, &c, 1);
 126:	4605                	li	a2,1
 128:	faf40593          	add	a1,s0,-81
 12c:	4501                	li	a0,0
 12e:	00000097          	auipc	ra,0x0
 132:	1d6080e7          	jalr	470(ra) # 304 <read>
    if(cc < 1)
 136:	00a05e63          	blez	a0,152 <gets+0x56>
    buf[i++] = c;
 13a:	faf44783          	lbu	a5,-81(s0)
 13e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 142:	01578763          	beq	a5,s5,150 <gets+0x54>
 146:	0905                	add	s2,s2,1
 148:	fd679be3          	bne	a5,s6,11e <gets+0x22>
  for(i=0; i+1 < max; ){
 14c:	89a6                	mv	s3,s1
 14e:	a011                	j	152 <gets+0x56>
 150:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 152:	99de                	add	s3,s3,s7
 154:	00098023          	sb	zero,0(s3)
  return buf;
}
 158:	855e                	mv	a0,s7
 15a:	60e6                	ld	ra,88(sp)
 15c:	6446                	ld	s0,80(sp)
 15e:	64a6                	ld	s1,72(sp)
 160:	6906                	ld	s2,64(sp)
 162:	79e2                	ld	s3,56(sp)
 164:	7a42                	ld	s4,48(sp)
 166:	7aa2                	ld	s5,40(sp)
 168:	7b02                	ld	s6,32(sp)
 16a:	6be2                	ld	s7,24(sp)
 16c:	6125                	add	sp,sp,96
 16e:	8082                	ret

0000000000000170 <stat>:

int
stat(const char *n, struct stat *st)
{
 170:	1101                	add	sp,sp,-32
 172:	ec06                	sd	ra,24(sp)
 174:	e822                	sd	s0,16(sp)
 176:	e426                	sd	s1,8(sp)
 178:	e04a                	sd	s2,0(sp)
 17a:	1000                	add	s0,sp,32
 17c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 17e:	4581                	li	a1,0
 180:	00000097          	auipc	ra,0x0
 184:	1ac080e7          	jalr	428(ra) # 32c <open>
  if(fd < 0)
 188:	02054563          	bltz	a0,1b2 <stat+0x42>
 18c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 18e:	85ca                	mv	a1,s2
 190:	00000097          	auipc	ra,0x0
 194:	1b4080e7          	jalr	436(ra) # 344 <fstat>
 198:	892a                	mv	s2,a0
  close(fd);
 19a:	8526                	mv	a0,s1
 19c:	00000097          	auipc	ra,0x0
 1a0:	178080e7          	jalr	376(ra) # 314 <close>
  return r;
}
 1a4:	854a                	mv	a0,s2
 1a6:	60e2                	ld	ra,24(sp)
 1a8:	6442                	ld	s0,16(sp)
 1aa:	64a2                	ld	s1,8(sp)
 1ac:	6902                	ld	s2,0(sp)
 1ae:	6105                	add	sp,sp,32
 1b0:	8082                	ret
    return -1;
 1b2:	597d                	li	s2,-1
 1b4:	bfc5                	j	1a4 <stat+0x34>

00000000000001b6 <atoi>:

int
atoi(const char *s)
{
 1b6:	1141                	add	sp,sp,-16
 1b8:	e422                	sd	s0,8(sp)
 1ba:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1bc:	00054683          	lbu	a3,0(a0)
 1c0:	fd06879b          	addw	a5,a3,-48
 1c4:	0ff7f793          	zext.b	a5,a5
 1c8:	4625                	li	a2,9
 1ca:	02f66863          	bltu	a2,a5,1fa <atoi+0x44>
 1ce:	872a                	mv	a4,a0
  n = 0;
 1d0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1d2:	0705                	add	a4,a4,1
 1d4:	0025179b          	sllw	a5,a0,0x2
 1d8:	9fa9                	addw	a5,a5,a0
 1da:	0017979b          	sllw	a5,a5,0x1
 1de:	9fb5                	addw	a5,a5,a3
 1e0:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1e4:	00074683          	lbu	a3,0(a4)
 1e8:	fd06879b          	addw	a5,a3,-48
 1ec:	0ff7f793          	zext.b	a5,a5
 1f0:	fef671e3          	bgeu	a2,a5,1d2 <atoi+0x1c>
  return n;
}
 1f4:	6422                	ld	s0,8(sp)
 1f6:	0141                	add	sp,sp,16
 1f8:	8082                	ret
  n = 0;
 1fa:	4501                	li	a0,0
 1fc:	bfe5                	j	1f4 <atoi+0x3e>

00000000000001fe <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1fe:	1141                	add	sp,sp,-16
 200:	e422                	sd	s0,8(sp)
 202:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 204:	02b57463          	bgeu	a0,a1,22c <memmove+0x2e>
    while(n-- > 0)
 208:	00c05f63          	blez	a2,226 <memmove+0x28>
 20c:	1602                	sll	a2,a2,0x20
 20e:	9201                	srl	a2,a2,0x20
 210:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 214:	872a                	mv	a4,a0
      *dst++ = *src++;
 216:	0585                	add	a1,a1,1
 218:	0705                	add	a4,a4,1
 21a:	fff5c683          	lbu	a3,-1(a1)
 21e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 222:	fee79ae3          	bne	a5,a4,216 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 226:	6422                	ld	s0,8(sp)
 228:	0141                	add	sp,sp,16
 22a:	8082                	ret
    dst += n;
 22c:	00c50733          	add	a4,a0,a2
    src += n;
 230:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 232:	fec05ae3          	blez	a2,226 <memmove+0x28>
 236:	fff6079b          	addw	a5,a2,-1
 23a:	1782                	sll	a5,a5,0x20
 23c:	9381                	srl	a5,a5,0x20
 23e:	fff7c793          	not	a5,a5
 242:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 244:	15fd                	add	a1,a1,-1
 246:	177d                	add	a4,a4,-1
 248:	0005c683          	lbu	a3,0(a1)
 24c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 250:	fee79ae3          	bne	a5,a4,244 <memmove+0x46>
 254:	bfc9                	j	226 <memmove+0x28>

0000000000000256 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 256:	1141                	add	sp,sp,-16
 258:	e422                	sd	s0,8(sp)
 25a:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 25c:	ca05                	beqz	a2,28c <memcmp+0x36>
 25e:	fff6069b          	addw	a3,a2,-1
 262:	1682                	sll	a3,a3,0x20
 264:	9281                	srl	a3,a3,0x20
 266:	0685                	add	a3,a3,1
 268:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 26a:	00054783          	lbu	a5,0(a0)
 26e:	0005c703          	lbu	a4,0(a1)
 272:	00e79863          	bne	a5,a4,282 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 276:	0505                	add	a0,a0,1
    p2++;
 278:	0585                	add	a1,a1,1
  while (n-- > 0) {
 27a:	fed518e3          	bne	a0,a3,26a <memcmp+0x14>
  }
  return 0;
 27e:	4501                	li	a0,0
 280:	a019                	j	286 <memcmp+0x30>
      return *p1 - *p2;
 282:	40e7853b          	subw	a0,a5,a4
}
 286:	6422                	ld	s0,8(sp)
 288:	0141                	add	sp,sp,16
 28a:	8082                	ret
  return 0;
 28c:	4501                	li	a0,0
 28e:	bfe5                	j	286 <memcmp+0x30>

0000000000000290 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 290:	1141                	add	sp,sp,-16
 292:	e406                	sd	ra,8(sp)
 294:	e022                	sd	s0,0(sp)
 296:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 298:	00000097          	auipc	ra,0x0
 29c:	f66080e7          	jalr	-154(ra) # 1fe <memmove>
}
 2a0:	60a2                	ld	ra,8(sp)
 2a2:	6402                	ld	s0,0(sp)
 2a4:	0141                	add	sp,sp,16
 2a6:	8082                	ret

00000000000002a8 <initlock>:

// Initialize the spinlock
void initlock(struct spinlock_u *lk) {
 2a8:	1141                	add	sp,sp,-16
 2aa:	e422                	sd	s0,8(sp)
 2ac:	0800                	add	s0,sp,16
  lk->locked = 0;
 2ae:	00052023          	sw	zero,0(a0)
}
 2b2:	6422                	ld	s0,8(sp)
 2b4:	0141                	add	sp,sp,16
 2b6:	8082                	ret

00000000000002b8 <acquire>:

// Acquire the spinlock
void acquire(struct spinlock_u *lk) {
 2b8:	1141                	add	sp,sp,-16
 2ba:	e422                	sd	s0,8(sp)
 2bc:	0800                	add	s0,sp,16
  while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 2be:	4705                	li	a4,1
 2c0:	87ba                	mv	a5,a4
 2c2:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
 2c6:	2781                	sext.w	a5,a5
 2c8:	ffe5                	bnez	a5,2c0 <acquire+0x8>
    ; // Spin until the lock is acquired
}
 2ca:	6422                	ld	s0,8(sp)
 2cc:	0141                	add	sp,sp,16
 2ce:	8082                	ret

00000000000002d0 <release>:

// Release the spinlock
void release(struct spinlock_u *lk) {
 2d0:	1141                	add	sp,sp,-16
 2d2:	e422                	sd	s0,8(sp)
 2d4:	0800                	add	s0,sp,16
  __sync_lock_release(&lk->locked);
 2d6:	0f50000f          	fence	iorw,ow
 2da:	0805202f          	amoswap.w	zero,zero,(a0)
}
 2de:	6422                	ld	s0,8(sp)
 2e0:	0141                	add	sp,sp,16
 2e2:	8082                	ret

00000000000002e4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2e4:	4885                	li	a7,1
 ecall
 2e6:	00000073          	ecall
 ret
 2ea:	8082                	ret

00000000000002ec <exit>:
.global exit
exit:
 li a7, SYS_exit
 2ec:	4889                	li	a7,2
 ecall
 2ee:	00000073          	ecall
 ret
 2f2:	8082                	ret

00000000000002f4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 2f4:	488d                	li	a7,3
 ecall
 2f6:	00000073          	ecall
 ret
 2fa:	8082                	ret

00000000000002fc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2fc:	4891                	li	a7,4
 ecall
 2fe:	00000073          	ecall
 ret
 302:	8082                	ret

0000000000000304 <read>:
.global read
read:
 li a7, SYS_read
 304:	4895                	li	a7,5
 ecall
 306:	00000073          	ecall
 ret
 30a:	8082                	ret

000000000000030c <write>:
.global write
write:
 li a7, SYS_write
 30c:	48c1                	li	a7,16
 ecall
 30e:	00000073          	ecall
 ret
 312:	8082                	ret

0000000000000314 <close>:
.global close
close:
 li a7, SYS_close
 314:	48d5                	li	a7,21
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <kill>:
.global kill
kill:
 li a7, SYS_kill
 31c:	4899                	li	a7,6
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <exec>:
.global exec
exec:
 li a7, SYS_exec
 324:	489d                	li	a7,7
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <open>:
.global open
open:
 li a7, SYS_open
 32c:	48bd                	li	a7,15
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 334:	48c5                	li	a7,17
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 33c:	48c9                	li	a7,18
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 344:	48a1                	li	a7,8
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <link>:
.global link
link:
 li a7, SYS_link
 34c:	48cd                	li	a7,19
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 354:	48d1                	li	a7,20
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 35c:	48a5                	li	a7,9
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <dup>:
.global dup
dup:
 li a7, SYS_dup
 364:	48a9                	li	a7,10
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 36c:	48ad                	li	a7,11
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 374:	48b1                	li	a7,12
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 37c:	48b5                	li	a7,13
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 384:	48b9                	li	a7,14
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <rcureadlock>:
.global rcureadlock
rcureadlock:
 li a7, SYS_rcureadlock
 38c:	48dd                	li	a7,23
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <rcureadunlock>:
.global rcureadunlock
rcureadunlock:
 li a7, SYS_rcureadunlock
 394:	48e1                	li	a7,24
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <rcusync>:
.global rcusync
rcusync:
 li a7, SYS_rcusync
 39c:	48d9                	li	a7,22
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <thread_create>:
.global thread_create
thread_create:
 li a7, SYS_thread_create
 3a4:	48e5                	li	a7,25
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <thread_join>:
.global thread_join
thread_join:
 li a7, SYS_thread_join
 3ac:	48e9                	li	a7,26
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <thread_exit>:
.global thread_exit
thread_exit:
 li a7, SYS_thread_exit
 3b4:	48ed                	li	a7,27
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <klist_insert>:
.global klist_insert
klist_insert:
 li a7, SYS_klist_insert
 3bc:	48f1                	li	a7,28
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <klist_delete>:
.global klist_delete
klist_delete:
 li a7, SYS_klist_delete
 3c4:	48f5                	li	a7,29
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <klist_query>:
.global klist_query
klist_query:
 li a7, SYS_klist_query
 3cc:	48f9                	li	a7,30
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <klist_print>:
.global klist_print
klist_print:
 li a7, SYS_klist_print
 3d4:	48fd                	li	a7,31
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3dc:	1101                	add	sp,sp,-32
 3de:	ec06                	sd	ra,24(sp)
 3e0:	e822                	sd	s0,16(sp)
 3e2:	1000                	add	s0,sp,32
 3e4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3e8:	4605                	li	a2,1
 3ea:	fef40593          	add	a1,s0,-17
 3ee:	00000097          	auipc	ra,0x0
 3f2:	f1e080e7          	jalr	-226(ra) # 30c <write>
}
 3f6:	60e2                	ld	ra,24(sp)
 3f8:	6442                	ld	s0,16(sp)
 3fa:	6105                	add	sp,sp,32
 3fc:	8082                	ret

00000000000003fe <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3fe:	7139                	add	sp,sp,-64
 400:	fc06                	sd	ra,56(sp)
 402:	f822                	sd	s0,48(sp)
 404:	f426                	sd	s1,40(sp)
 406:	f04a                	sd	s2,32(sp)
 408:	ec4e                	sd	s3,24(sp)
 40a:	0080                	add	s0,sp,64
 40c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 40e:	c299                	beqz	a3,414 <printint+0x16>
 410:	0805c963          	bltz	a1,4a2 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 414:	2581                	sext.w	a1,a1
  neg = 0;
 416:	4881                	li	a7,0
 418:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 41c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 41e:	2601                	sext.w	a2,a2
 420:	00000517          	auipc	a0,0x0
 424:	61050513          	add	a0,a0,1552 # a30 <digits>
 428:	883a                	mv	a6,a4
 42a:	2705                	addw	a4,a4,1
 42c:	02c5f7bb          	remuw	a5,a1,a2
 430:	1782                	sll	a5,a5,0x20
 432:	9381                	srl	a5,a5,0x20
 434:	97aa                	add	a5,a5,a0
 436:	0007c783          	lbu	a5,0(a5)
 43a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 43e:	0005879b          	sext.w	a5,a1
 442:	02c5d5bb          	divuw	a1,a1,a2
 446:	0685                	add	a3,a3,1
 448:	fec7f0e3          	bgeu	a5,a2,428 <printint+0x2a>
  if(neg)
 44c:	00088c63          	beqz	a7,464 <printint+0x66>
    buf[i++] = '-';
 450:	fd070793          	add	a5,a4,-48
 454:	00878733          	add	a4,a5,s0
 458:	02d00793          	li	a5,45
 45c:	fef70823          	sb	a5,-16(a4)
 460:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 464:	02e05863          	blez	a4,494 <printint+0x96>
 468:	fc040793          	add	a5,s0,-64
 46c:	00e78933          	add	s2,a5,a4
 470:	fff78993          	add	s3,a5,-1
 474:	99ba                	add	s3,s3,a4
 476:	377d                	addw	a4,a4,-1
 478:	1702                	sll	a4,a4,0x20
 47a:	9301                	srl	a4,a4,0x20
 47c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 480:	fff94583          	lbu	a1,-1(s2)
 484:	8526                	mv	a0,s1
 486:	00000097          	auipc	ra,0x0
 48a:	f56080e7          	jalr	-170(ra) # 3dc <putc>
  while(--i >= 0)
 48e:	197d                	add	s2,s2,-1
 490:	ff3918e3          	bne	s2,s3,480 <printint+0x82>
}
 494:	70e2                	ld	ra,56(sp)
 496:	7442                	ld	s0,48(sp)
 498:	74a2                	ld	s1,40(sp)
 49a:	7902                	ld	s2,32(sp)
 49c:	69e2                	ld	s3,24(sp)
 49e:	6121                	add	sp,sp,64
 4a0:	8082                	ret
    x = -xx;
 4a2:	40b005bb          	negw	a1,a1
    neg = 1;
 4a6:	4885                	li	a7,1
    x = -xx;
 4a8:	bf85                	j	418 <printint+0x1a>

00000000000004aa <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4aa:	715d                	add	sp,sp,-80
 4ac:	e486                	sd	ra,72(sp)
 4ae:	e0a2                	sd	s0,64(sp)
 4b0:	fc26                	sd	s1,56(sp)
 4b2:	f84a                	sd	s2,48(sp)
 4b4:	f44e                	sd	s3,40(sp)
 4b6:	f052                	sd	s4,32(sp)
 4b8:	ec56                	sd	s5,24(sp)
 4ba:	e85a                	sd	s6,16(sp)
 4bc:	e45e                	sd	s7,8(sp)
 4be:	e062                	sd	s8,0(sp)
 4c0:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4c2:	0005c903          	lbu	s2,0(a1)
 4c6:	18090c63          	beqz	s2,65e <vprintf+0x1b4>
 4ca:	8aaa                	mv	s5,a0
 4cc:	8bb2                	mv	s7,a2
 4ce:	00158493          	add	s1,a1,1
  state = 0;
 4d2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4d4:	02500a13          	li	s4,37
 4d8:	4b55                	li	s6,21
 4da:	a839                	j	4f8 <vprintf+0x4e>
        putc(fd, c);
 4dc:	85ca                	mv	a1,s2
 4de:	8556                	mv	a0,s5
 4e0:	00000097          	auipc	ra,0x0
 4e4:	efc080e7          	jalr	-260(ra) # 3dc <putc>
 4e8:	a019                	j	4ee <vprintf+0x44>
    } else if(state == '%'){
 4ea:	01498d63          	beq	s3,s4,504 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 4ee:	0485                	add	s1,s1,1
 4f0:	fff4c903          	lbu	s2,-1(s1)
 4f4:	16090563          	beqz	s2,65e <vprintf+0x1b4>
    if(state == 0){
 4f8:	fe0999e3          	bnez	s3,4ea <vprintf+0x40>
      if(c == '%'){
 4fc:	ff4910e3          	bne	s2,s4,4dc <vprintf+0x32>
        state = '%';
 500:	89d2                	mv	s3,s4
 502:	b7f5                	j	4ee <vprintf+0x44>
      if(c == 'd'){
 504:	13490263          	beq	s2,s4,628 <vprintf+0x17e>
 508:	f9d9079b          	addw	a5,s2,-99
 50c:	0ff7f793          	zext.b	a5,a5
 510:	12fb6563          	bltu	s6,a5,63a <vprintf+0x190>
 514:	f9d9079b          	addw	a5,s2,-99
 518:	0ff7f713          	zext.b	a4,a5
 51c:	10eb6f63          	bltu	s6,a4,63a <vprintf+0x190>
 520:	00271793          	sll	a5,a4,0x2
 524:	00000717          	auipc	a4,0x0
 528:	4b470713          	add	a4,a4,1204 # 9d8 <updateNode+0x52>
 52c:	97ba                	add	a5,a5,a4
 52e:	439c                	lw	a5,0(a5)
 530:	97ba                	add	a5,a5,a4
 532:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 534:	008b8913          	add	s2,s7,8
 538:	4685                	li	a3,1
 53a:	4629                	li	a2,10
 53c:	000ba583          	lw	a1,0(s7)
 540:	8556                	mv	a0,s5
 542:	00000097          	auipc	ra,0x0
 546:	ebc080e7          	jalr	-324(ra) # 3fe <printint>
 54a:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 54c:	4981                	li	s3,0
 54e:	b745                	j	4ee <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 550:	008b8913          	add	s2,s7,8
 554:	4681                	li	a3,0
 556:	4629                	li	a2,10
 558:	000ba583          	lw	a1,0(s7)
 55c:	8556                	mv	a0,s5
 55e:	00000097          	auipc	ra,0x0
 562:	ea0080e7          	jalr	-352(ra) # 3fe <printint>
 566:	8bca                	mv	s7,s2
      state = 0;
 568:	4981                	li	s3,0
 56a:	b751                	j	4ee <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 56c:	008b8913          	add	s2,s7,8
 570:	4681                	li	a3,0
 572:	4641                	li	a2,16
 574:	000ba583          	lw	a1,0(s7)
 578:	8556                	mv	a0,s5
 57a:	00000097          	auipc	ra,0x0
 57e:	e84080e7          	jalr	-380(ra) # 3fe <printint>
 582:	8bca                	mv	s7,s2
      state = 0;
 584:	4981                	li	s3,0
 586:	b7a5                	j	4ee <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 588:	008b8c13          	add	s8,s7,8
 58c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 590:	03000593          	li	a1,48
 594:	8556                	mv	a0,s5
 596:	00000097          	auipc	ra,0x0
 59a:	e46080e7          	jalr	-442(ra) # 3dc <putc>
  putc(fd, 'x');
 59e:	07800593          	li	a1,120
 5a2:	8556                	mv	a0,s5
 5a4:	00000097          	auipc	ra,0x0
 5a8:	e38080e7          	jalr	-456(ra) # 3dc <putc>
 5ac:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5ae:	00000b97          	auipc	s7,0x0
 5b2:	482b8b93          	add	s7,s7,1154 # a30 <digits>
 5b6:	03c9d793          	srl	a5,s3,0x3c
 5ba:	97de                	add	a5,a5,s7
 5bc:	0007c583          	lbu	a1,0(a5)
 5c0:	8556                	mv	a0,s5
 5c2:	00000097          	auipc	ra,0x0
 5c6:	e1a080e7          	jalr	-486(ra) # 3dc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5ca:	0992                	sll	s3,s3,0x4
 5cc:	397d                	addw	s2,s2,-1
 5ce:	fe0914e3          	bnez	s2,5b6 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 5d2:	8be2                	mv	s7,s8
      state = 0;
 5d4:	4981                	li	s3,0
 5d6:	bf21                	j	4ee <vprintf+0x44>
        s = va_arg(ap, char*);
 5d8:	008b8993          	add	s3,s7,8
 5dc:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 5e0:	02090163          	beqz	s2,602 <vprintf+0x158>
        while(*s != 0){
 5e4:	00094583          	lbu	a1,0(s2)
 5e8:	c9a5                	beqz	a1,658 <vprintf+0x1ae>
          putc(fd, *s);
 5ea:	8556                	mv	a0,s5
 5ec:	00000097          	auipc	ra,0x0
 5f0:	df0080e7          	jalr	-528(ra) # 3dc <putc>
          s++;
 5f4:	0905                	add	s2,s2,1
        while(*s != 0){
 5f6:	00094583          	lbu	a1,0(s2)
 5fa:	f9e5                	bnez	a1,5ea <vprintf+0x140>
        s = va_arg(ap, char*);
 5fc:	8bce                	mv	s7,s3
      state = 0;
 5fe:	4981                	li	s3,0
 600:	b5fd                	j	4ee <vprintf+0x44>
          s = "(null)";
 602:	00000917          	auipc	s2,0x0
 606:	3ce90913          	add	s2,s2,974 # 9d0 <updateNode+0x4a>
        while(*s != 0){
 60a:	02800593          	li	a1,40
 60e:	bff1                	j	5ea <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 610:	008b8913          	add	s2,s7,8
 614:	000bc583          	lbu	a1,0(s7)
 618:	8556                	mv	a0,s5
 61a:	00000097          	auipc	ra,0x0
 61e:	dc2080e7          	jalr	-574(ra) # 3dc <putc>
 622:	8bca                	mv	s7,s2
      state = 0;
 624:	4981                	li	s3,0
 626:	b5e1                	j	4ee <vprintf+0x44>
        putc(fd, c);
 628:	02500593          	li	a1,37
 62c:	8556                	mv	a0,s5
 62e:	00000097          	auipc	ra,0x0
 632:	dae080e7          	jalr	-594(ra) # 3dc <putc>
      state = 0;
 636:	4981                	li	s3,0
 638:	bd5d                	j	4ee <vprintf+0x44>
        putc(fd, '%');
 63a:	02500593          	li	a1,37
 63e:	8556                	mv	a0,s5
 640:	00000097          	auipc	ra,0x0
 644:	d9c080e7          	jalr	-612(ra) # 3dc <putc>
        putc(fd, c);
 648:	85ca                	mv	a1,s2
 64a:	8556                	mv	a0,s5
 64c:	00000097          	auipc	ra,0x0
 650:	d90080e7          	jalr	-624(ra) # 3dc <putc>
      state = 0;
 654:	4981                	li	s3,0
 656:	bd61                	j	4ee <vprintf+0x44>
        s = va_arg(ap, char*);
 658:	8bce                	mv	s7,s3
      state = 0;
 65a:	4981                	li	s3,0
 65c:	bd49                	j	4ee <vprintf+0x44>
    }
  }
}
 65e:	60a6                	ld	ra,72(sp)
 660:	6406                	ld	s0,64(sp)
 662:	74e2                	ld	s1,56(sp)
 664:	7942                	ld	s2,48(sp)
 666:	79a2                	ld	s3,40(sp)
 668:	7a02                	ld	s4,32(sp)
 66a:	6ae2                	ld	s5,24(sp)
 66c:	6b42                	ld	s6,16(sp)
 66e:	6ba2                	ld	s7,8(sp)
 670:	6c02                	ld	s8,0(sp)
 672:	6161                	add	sp,sp,80
 674:	8082                	ret

0000000000000676 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 676:	715d                	add	sp,sp,-80
 678:	ec06                	sd	ra,24(sp)
 67a:	e822                	sd	s0,16(sp)
 67c:	1000                	add	s0,sp,32
 67e:	e010                	sd	a2,0(s0)
 680:	e414                	sd	a3,8(s0)
 682:	e818                	sd	a4,16(s0)
 684:	ec1c                	sd	a5,24(s0)
 686:	03043023          	sd	a6,32(s0)
 68a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 68e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 692:	8622                	mv	a2,s0
 694:	00000097          	auipc	ra,0x0
 698:	e16080e7          	jalr	-490(ra) # 4aa <vprintf>
}
 69c:	60e2                	ld	ra,24(sp)
 69e:	6442                	ld	s0,16(sp)
 6a0:	6161                	add	sp,sp,80
 6a2:	8082                	ret

00000000000006a4 <printf>:

void
printf(const char *fmt, ...)
{
 6a4:	711d                	add	sp,sp,-96
 6a6:	ec06                	sd	ra,24(sp)
 6a8:	e822                	sd	s0,16(sp)
 6aa:	1000                	add	s0,sp,32
 6ac:	e40c                	sd	a1,8(s0)
 6ae:	e810                	sd	a2,16(s0)
 6b0:	ec14                	sd	a3,24(s0)
 6b2:	f018                	sd	a4,32(s0)
 6b4:	f41c                	sd	a5,40(s0)
 6b6:	03043823          	sd	a6,48(s0)
 6ba:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6be:	00840613          	add	a2,s0,8
 6c2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6c6:	85aa                	mv	a1,a0
 6c8:	4505                	li	a0,1
 6ca:	00000097          	auipc	ra,0x0
 6ce:	de0080e7          	jalr	-544(ra) # 4aa <vprintf>
}
 6d2:	60e2                	ld	ra,24(sp)
 6d4:	6442                	ld	s0,16(sp)
 6d6:	6125                	add	sp,sp,96
 6d8:	8082                	ret

00000000000006da <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6da:	1141                	add	sp,sp,-16
 6dc:	e422                	sd	s0,8(sp)
 6de:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6e0:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e4:	00001797          	auipc	a5,0x1
 6e8:	91c7b783          	ld	a5,-1764(a5) # 1000 <freep>
 6ec:	a02d                	j	716 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6ee:	4618                	lw	a4,8(a2)
 6f0:	9f2d                	addw	a4,a4,a1
 6f2:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6f6:	6398                	ld	a4,0(a5)
 6f8:	6310                	ld	a2,0(a4)
 6fa:	a83d                	j	738 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6fc:	ff852703          	lw	a4,-8(a0)
 700:	9f31                	addw	a4,a4,a2
 702:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 704:	ff053683          	ld	a3,-16(a0)
 708:	a091                	j	74c <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 70a:	6398                	ld	a4,0(a5)
 70c:	00e7e463          	bltu	a5,a4,714 <free+0x3a>
 710:	00e6ea63          	bltu	a3,a4,724 <free+0x4a>
{
 714:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 716:	fed7fae3          	bgeu	a5,a3,70a <free+0x30>
 71a:	6398                	ld	a4,0(a5)
 71c:	00e6e463          	bltu	a3,a4,724 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 720:	fee7eae3          	bltu	a5,a4,714 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 724:	ff852583          	lw	a1,-8(a0)
 728:	6390                	ld	a2,0(a5)
 72a:	02059813          	sll	a6,a1,0x20
 72e:	01c85713          	srl	a4,a6,0x1c
 732:	9736                	add	a4,a4,a3
 734:	fae60de3          	beq	a2,a4,6ee <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 738:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 73c:	4790                	lw	a2,8(a5)
 73e:	02061593          	sll	a1,a2,0x20
 742:	01c5d713          	srl	a4,a1,0x1c
 746:	973e                	add	a4,a4,a5
 748:	fae68ae3          	beq	a3,a4,6fc <free+0x22>
    p->s.ptr = bp->s.ptr;
 74c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 74e:	00001717          	auipc	a4,0x1
 752:	8af73923          	sd	a5,-1870(a4) # 1000 <freep>
}
 756:	6422                	ld	s0,8(sp)
 758:	0141                	add	sp,sp,16
 75a:	8082                	ret

000000000000075c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 75c:	7139                	add	sp,sp,-64
 75e:	fc06                	sd	ra,56(sp)
 760:	f822                	sd	s0,48(sp)
 762:	f426                	sd	s1,40(sp)
 764:	f04a                	sd	s2,32(sp)
 766:	ec4e                	sd	s3,24(sp)
 768:	e852                	sd	s4,16(sp)
 76a:	e456                	sd	s5,8(sp)
 76c:	e05a                	sd	s6,0(sp)
 76e:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 770:	02051493          	sll	s1,a0,0x20
 774:	9081                	srl	s1,s1,0x20
 776:	04bd                	add	s1,s1,15
 778:	8091                	srl	s1,s1,0x4
 77a:	0014899b          	addw	s3,s1,1
 77e:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 780:	00001517          	auipc	a0,0x1
 784:	88053503          	ld	a0,-1920(a0) # 1000 <freep>
 788:	c515                	beqz	a0,7b4 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 78a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 78c:	4798                	lw	a4,8(a5)
 78e:	02977f63          	bgeu	a4,s1,7cc <malloc+0x70>
  if(nu < 4096)
 792:	8a4e                	mv	s4,s3
 794:	0009871b          	sext.w	a4,s3
 798:	6685                	lui	a3,0x1
 79a:	00d77363          	bgeu	a4,a3,7a0 <malloc+0x44>
 79e:	6a05                	lui	s4,0x1
 7a0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7a4:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7a8:	00001917          	auipc	s2,0x1
 7ac:	85890913          	add	s2,s2,-1960 # 1000 <freep>
  if(p == (char*)-1)
 7b0:	5afd                	li	s5,-1
 7b2:	a895                	j	826 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 7b4:	00001797          	auipc	a5,0x1
 7b8:	85c78793          	add	a5,a5,-1956 # 1010 <base>
 7bc:	00001717          	auipc	a4,0x1
 7c0:	84f73223          	sd	a5,-1980(a4) # 1000 <freep>
 7c4:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7c6:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7ca:	b7e1                	j	792 <malloc+0x36>
      if(p->s.size == nunits)
 7cc:	02e48c63          	beq	s1,a4,804 <malloc+0xa8>
        p->s.size -= nunits;
 7d0:	4137073b          	subw	a4,a4,s3
 7d4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7d6:	02071693          	sll	a3,a4,0x20
 7da:	01c6d713          	srl	a4,a3,0x1c
 7de:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7e0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7e4:	00001717          	auipc	a4,0x1
 7e8:	80a73e23          	sd	a0,-2020(a4) # 1000 <freep>
      return (void*)(p + 1);
 7ec:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7f0:	70e2                	ld	ra,56(sp)
 7f2:	7442                	ld	s0,48(sp)
 7f4:	74a2                	ld	s1,40(sp)
 7f6:	7902                	ld	s2,32(sp)
 7f8:	69e2                	ld	s3,24(sp)
 7fa:	6a42                	ld	s4,16(sp)
 7fc:	6aa2                	ld	s5,8(sp)
 7fe:	6b02                	ld	s6,0(sp)
 800:	6121                	add	sp,sp,64
 802:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 804:	6398                	ld	a4,0(a5)
 806:	e118                	sd	a4,0(a0)
 808:	bff1                	j	7e4 <malloc+0x88>
  hp->s.size = nu;
 80a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 80e:	0541                	add	a0,a0,16
 810:	00000097          	auipc	ra,0x0
 814:	eca080e7          	jalr	-310(ra) # 6da <free>
  return freep;
 818:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 81c:	d971                	beqz	a0,7f0 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 81e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 820:	4798                	lw	a4,8(a5)
 822:	fa9775e3          	bgeu	a4,s1,7cc <malloc+0x70>
    if(p == freep)
 826:	00093703          	ld	a4,0(s2)
 82a:	853e                	mv	a0,a5
 82c:	fef719e3          	bne	a4,a5,81e <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 830:	8552                	mv	a0,s4
 832:	00000097          	auipc	ra,0x0
 836:	b42080e7          	jalr	-1214(ra) # 374 <sbrk>
  if(p == (char*)-1)
 83a:	fd5518e3          	bne	a0,s5,80a <malloc+0xae>
        return 0;
 83e:	4501                	li	a0,0
 840:	bf45                	j	7f0 <malloc+0x94>

0000000000000842 <init_lock>:
#include "linkedlist.h"

// Define a node structure for the linked list
struct spinlock_u list_lock;

void init_lock(){
 842:	1141                	add	sp,sp,-16
 844:	e406                	sd	ra,8(sp)
 846:	e022                	sd	s0,0(sp)
 848:	0800                	add	s0,sp,16
    initlock(&list_lock);
 84a:	00000517          	auipc	a0,0x0
 84e:	7be50513          	add	a0,a0,1982 # 1008 <list_lock>
 852:	00000097          	auipc	ra,0x0
 856:	a56080e7          	jalr	-1450(ra) # 2a8 <initlock>
}
 85a:	60a2                	ld	ra,8(sp)
 85c:	6402                	ld	s0,0(sp)
 85e:	0141                	add	sp,sp,16
 860:	8082                	ret

0000000000000862 <insert>:

// Function to insert a node at the beginning of the linked list
void insert(struct Node **head_ref, int new_data) {
 862:	1101                	add	sp,sp,-32
 864:	ec06                	sd	ra,24(sp)
 866:	e822                	sd	s0,16(sp)
 868:	e426                	sd	s1,8(sp)
 86a:	e04a                	sd	s2,0(sp)
 86c:	1000                	add	s0,sp,32
 86e:	84aa                	mv	s1,a0
 870:	892e                	mv	s2,a1
    struct Node *new_node = malloc(sizeof(struct Node));
 872:	4541                	li	a0,16
 874:	00000097          	auipc	ra,0x0
 878:	ee8080e7          	jalr	-280(ra) # 75c <malloc>
    new_node->data = new_data;
 87c:	01252023          	sw	s2,0(a0)
    new_node->next = *head_ref;
 880:	609c                	ld	a5,0(s1)
 882:	e51c                	sd	a5,8(a0)
    *head_ref = new_node;
 884:	e088                	sd	a0,0(s1)
}
 886:	60e2                	ld	ra,24(sp)
 888:	6442                	ld	s0,16(sp)
 88a:	64a2                	ld	s1,8(sp)
 88c:	6902                	ld	s2,0(sp)
 88e:	6105                	add	sp,sp,32
 890:	8082                	ret

0000000000000892 <deleteNode>:

// Function to delete a node with a given key from the linked list
void deleteNode(struct Node **head_ref, int key) {
 892:	7179                	add	sp,sp,-48
 894:	f406                	sd	ra,40(sp)
 896:	f022                	sd	s0,32(sp)
 898:	ec26                	sd	s1,24(sp)
 89a:	e84a                	sd	s2,16(sp)
 89c:	e44e                	sd	s3,8(sp)
 89e:	1800                	add	s0,sp,48
 8a0:	89aa                	mv	s3,a0
 8a2:	892e                	mv	s2,a1
    struct Node *temp = *head_ref, *prev = 0;
 8a4:	6104                	ld	s1,0(a0)

    acquire(&list_lock);
 8a6:	00000517          	auipc	a0,0x0
 8aa:	76250513          	add	a0,a0,1890 # 1008 <list_lock>
 8ae:	00000097          	auipc	ra,0x0
 8b2:	a0a080e7          	jalr	-1526(ra) # 2b8 <acquire>
    if (temp != 0 && temp->data == key) {
 8b6:	c0b1                	beqz	s1,8fa <deleteNode+0x68>
 8b8:	409c                	lw	a5,0(s1)
 8ba:	4701                	li	a4,0
 8bc:	01278a63          	beq	a5,s2,8d0 <deleteNode+0x3e>
        rcusync();
        free(temp);
        return;
    }

    while (temp != 0 && temp->data != key) {
 8c0:	409c                	lw	a5,0(s1)
 8c2:	05278563          	beq	a5,s2,90c <deleteNode+0x7a>
        prev = temp;
        temp = temp->next;
 8c6:	649c                	ld	a5,8(s1)
    while (temp != 0 && temp->data != key) {
 8c8:	8726                	mv	a4,s1
 8ca:	cb85                	beqz	a5,8fa <deleteNode+0x68>
        temp = temp->next;
 8cc:	84be                	mv	s1,a5
 8ce:	bfcd                	j	8c0 <deleteNode+0x2e>
        *head_ref = temp->next;
 8d0:	649c                	ld	a5,8(s1)
 8d2:	00f9b023          	sd	a5,0(s3)
        release(&list_lock);
 8d6:	00000517          	auipc	a0,0x0
 8da:	73250513          	add	a0,a0,1842 # 1008 <list_lock>
 8de:	00000097          	auipc	ra,0x0
 8e2:	9f2080e7          	jalr	-1550(ra) # 2d0 <release>
        rcusync();
 8e6:	00000097          	auipc	ra,0x0
 8ea:	ab6080e7          	jalr	-1354(ra) # 39c <rcusync>
        free(temp);
 8ee:	8526                	mv	a0,s1
 8f0:	00000097          	auipc	ra,0x0
 8f4:	dea080e7          	jalr	-534(ra) # 6da <free>
        return;
 8f8:	a82d                	j	932 <deleteNode+0xa0>
    }

    if (temp == 0) {
        release(&list_lock);
 8fa:	00000517          	auipc	a0,0x0
 8fe:	70e50513          	add	a0,a0,1806 # 1008 <list_lock>
 902:	00000097          	auipc	ra,0x0
 906:	9ce080e7          	jalr	-1586(ra) # 2d0 <release>
        return;
 90a:	a025                	j	932 <deleteNode+0xa0>
    }
    prev->next = temp->next;
 90c:	649c                	ld	a5,8(s1)
 90e:	e71c                	sd	a5,8(a4)
    release(&list_lock);
 910:	00000517          	auipc	a0,0x0
 914:	6f850513          	add	a0,a0,1784 # 1008 <list_lock>
 918:	00000097          	auipc	ra,0x0
 91c:	9b8080e7          	jalr	-1608(ra) # 2d0 <release>
    rcusync();
 920:	00000097          	auipc	ra,0x0
 924:	a7c080e7          	jalr	-1412(ra) # 39c <rcusync>
    free(temp);
 928:	8526                	mv	a0,s1
 92a:	00000097          	auipc	ra,0x0
 92e:	db0080e7          	jalr	-592(ra) # 6da <free>
}
 932:	70a2                	ld	ra,40(sp)
 934:	7402                	ld	s0,32(sp)
 936:	64e2                	ld	s1,24(sp)
 938:	6942                	ld	s2,16(sp)
 93a:	69a2                	ld	s3,8(sp)
 93c:	6145                	add	sp,sp,48
 93e:	8082                	ret

0000000000000940 <search>:

// Function to search for a node with a given key in the linked list
struct Node* search(struct Node *head, int key) {
 940:	1101                	add	sp,sp,-32
 942:	ec06                	sd	ra,24(sp)
 944:	e822                	sd	s0,16(sp)
 946:	e426                	sd	s1,8(sp)
 948:	e04a                	sd	s2,0(sp)
 94a:	1000                	add	s0,sp,32
 94c:	84aa                	mv	s1,a0
 94e:	892e                	mv	s2,a1

    struct Node *current = head;
    rcureadlock();
 950:	00000097          	auipc	ra,0x0
 954:	a3c080e7          	jalr	-1476(ra) # 38c <rcureadlock>
    while (current != 0) {
 958:	c491                	beqz	s1,964 <search+0x24>
        if (current->data == key) {
 95a:	409c                	lw	a5,0(s1)
 95c:	01278f63          	beq	a5,s2,97a <search+0x3a>
            rcureadunlock();
            return current; // Node found
        }
        current = current->next;
 960:	6484                	ld	s1,8(s1)
    while (current != 0) {
 962:	fce5                	bnez	s1,95a <search+0x1a>
    }
    rcureadunlock();
 964:	00000097          	auipc	ra,0x0
 968:	a30080e7          	jalr	-1488(ra) # 394 <rcureadunlock>
    return 0; // Node not found
 96c:	4501                	li	a0,0
}
 96e:	60e2                	ld	ra,24(sp)
 970:	6442                	ld	s0,16(sp)
 972:	64a2                	ld	s1,8(sp)
 974:	6902                	ld	s2,0(sp)
 976:	6105                	add	sp,sp,32
 978:	8082                	ret
            rcureadunlock();
 97a:	00000097          	auipc	ra,0x0
 97e:	a1a080e7          	jalr	-1510(ra) # 394 <rcureadunlock>
            return current; // Node found
 982:	8526                	mv	a0,s1
 984:	b7ed                	j	96e <search+0x2e>

0000000000000986 <updateNode>:

// Function to update the value of a node with a given key in the linked list
void updateNode(struct Node *head, int key, int new_data) {
 986:	1101                	add	sp,sp,-32
 988:	ec06                	sd	ra,24(sp)
 98a:	e822                	sd	s0,16(sp)
 98c:	e426                	sd	s1,8(sp)
 98e:	e04a                	sd	s2,0(sp)
 990:	1000                	add	s0,sp,32
 992:	892e                	mv	s2,a1
 994:	84b2                	mv	s1,a2
    struct Node *nodeToUpdate = search(head, key);
 996:	00000097          	auipc	ra,0x0
 99a:	faa080e7          	jalr	-86(ra) # 940 <search>

    if (nodeToUpdate != 0) {
 99e:	c901                	beqz	a0,9ae <updateNode+0x28>
        nodeToUpdate->data = new_data; // Update the node's data
 9a0:	c104                	sw	s1,0(a0)
    } else {
        printf("Node with key %d not found.\n", key);
    }
}
 9a2:	60e2                	ld	ra,24(sp)
 9a4:	6442                	ld	s0,16(sp)
 9a6:	64a2                	ld	s1,8(sp)
 9a8:	6902                	ld	s2,0(sp)
 9aa:	6105                	add	sp,sp,32
 9ac:	8082                	ret
        printf("Node with key %d not found.\n", key);
 9ae:	85ca                	mv	a1,s2
 9b0:	00000517          	auipc	a0,0x0
 9b4:	09850513          	add	a0,a0,152 # a48 <digits+0x18>
 9b8:	00000097          	auipc	ra,0x0
 9bc:	cec080e7          	jalr	-788(ra) # 6a4 <printf>
}
 9c0:	b7cd                	j	9a2 <updateNode+0x1c>
