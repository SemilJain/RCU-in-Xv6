
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
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
   e:	02a7dd63          	bge	a5,a0,48 <main+0x48>
  12:	00858493          	add	s1,a1,8
  16:	ffe5091b          	addw	s2,a0,-2
  1a:	02091793          	sll	a5,s2,0x20
  1e:	01d7d913          	srl	s2,a5,0x1d
  22:	05c1                	add	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "usage: kill pid...\n");
    exit(1);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  26:	6088                	ld	a0,0(s1)
  28:	00000097          	auipc	ra,0x0
  2c:	1c8080e7          	jalr	456(ra) # 1f0 <atoi>
  30:	00000097          	auipc	ra,0x0
  34:	326080e7          	jalr	806(ra) # 356 <kill>
  for(i=1; i<argc; i++)
  38:	04a1                	add	s1,s1,8
  3a:	ff2496e3          	bne	s1,s2,26 <main+0x26>
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	2e6080e7          	jalr	742(ra) # 326 <exit>
    fprintf(2, "usage: kill pid...\n");
  48:	00001597          	auipc	a1,0x1
  4c:	9b858593          	add	a1,a1,-1608 # a00 <updateNode+0x40>
  50:	4509                	li	a0,2
  52:	00000097          	auipc	ra,0x0
  56:	65e080e7          	jalr	1630(ra) # 6b0 <fprintf>
    exit(1);
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	2ca080e7          	jalr	714(ra) # 326 <exit>

0000000000000064 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  64:	1141                	add	sp,sp,-16
  66:	e406                	sd	ra,8(sp)
  68:	e022                	sd	s0,0(sp)
  6a:	0800                	add	s0,sp,16
  extern int main();
  main();
  6c:	00000097          	auipc	ra,0x0
  70:	f94080e7          	jalr	-108(ra) # 0 <main>
  exit(0);
  74:	4501                	li	a0,0
  76:	00000097          	auipc	ra,0x0
  7a:	2b0080e7          	jalr	688(ra) # 326 <exit>

000000000000007e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  7e:	1141                	add	sp,sp,-16
  80:	e422                	sd	s0,8(sp)
  82:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  84:	87aa                	mv	a5,a0
  86:	0585                	add	a1,a1,1
  88:	0785                	add	a5,a5,1
  8a:	fff5c703          	lbu	a4,-1(a1)
  8e:	fee78fa3          	sb	a4,-1(a5)
  92:	fb75                	bnez	a4,86 <strcpy+0x8>
    ;
  return os;
}
  94:	6422                	ld	s0,8(sp)
  96:	0141                	add	sp,sp,16
  98:	8082                	ret

000000000000009a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  9a:	1141                	add	sp,sp,-16
  9c:	e422                	sd	s0,8(sp)
  9e:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  a0:	00054783          	lbu	a5,0(a0)
  a4:	cb91                	beqz	a5,b8 <strcmp+0x1e>
  a6:	0005c703          	lbu	a4,0(a1)
  aa:	00f71763          	bne	a4,a5,b8 <strcmp+0x1e>
    p++, q++;
  ae:	0505                	add	a0,a0,1
  b0:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  b2:	00054783          	lbu	a5,0(a0)
  b6:	fbe5                	bnez	a5,a6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  b8:	0005c503          	lbu	a0,0(a1)
}
  bc:	40a7853b          	subw	a0,a5,a0
  c0:	6422                	ld	s0,8(sp)
  c2:	0141                	add	sp,sp,16
  c4:	8082                	ret

00000000000000c6 <strlen>:

uint
strlen(const char *s)
{
  c6:	1141                	add	sp,sp,-16
  c8:	e422                	sd	s0,8(sp)
  ca:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  cc:	00054783          	lbu	a5,0(a0)
  d0:	cf91                	beqz	a5,ec <strlen+0x26>
  d2:	0505                	add	a0,a0,1
  d4:	87aa                	mv	a5,a0
  d6:	86be                	mv	a3,a5
  d8:	0785                	add	a5,a5,1
  da:	fff7c703          	lbu	a4,-1(a5)
  de:	ff65                	bnez	a4,d6 <strlen+0x10>
  e0:	40a6853b          	subw	a0,a3,a0
  e4:	2505                	addw	a0,a0,1
    ;
  return n;
}
  e6:	6422                	ld	s0,8(sp)
  e8:	0141                	add	sp,sp,16
  ea:	8082                	ret
  for(n = 0; s[n]; n++)
  ec:	4501                	li	a0,0
  ee:	bfe5                	j	e6 <strlen+0x20>

00000000000000f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f0:	1141                	add	sp,sp,-16
  f2:	e422                	sd	s0,8(sp)
  f4:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  f6:	ca19                	beqz	a2,10c <memset+0x1c>
  f8:	87aa                	mv	a5,a0
  fa:	1602                	sll	a2,a2,0x20
  fc:	9201                	srl	a2,a2,0x20
  fe:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 102:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 106:	0785                	add	a5,a5,1
 108:	fee79de3          	bne	a5,a4,102 <memset+0x12>
  }
  return dst;
}
 10c:	6422                	ld	s0,8(sp)
 10e:	0141                	add	sp,sp,16
 110:	8082                	ret

0000000000000112 <strchr>:

char*
strchr(const char *s, char c)
{
 112:	1141                	add	sp,sp,-16
 114:	e422                	sd	s0,8(sp)
 116:	0800                	add	s0,sp,16
  for(; *s; s++)
 118:	00054783          	lbu	a5,0(a0)
 11c:	cb99                	beqz	a5,132 <strchr+0x20>
    if(*s == c)
 11e:	00f58763          	beq	a1,a5,12c <strchr+0x1a>
  for(; *s; s++)
 122:	0505                	add	a0,a0,1
 124:	00054783          	lbu	a5,0(a0)
 128:	fbfd                	bnez	a5,11e <strchr+0xc>
      return (char*)s;
  return 0;
 12a:	4501                	li	a0,0
}
 12c:	6422                	ld	s0,8(sp)
 12e:	0141                	add	sp,sp,16
 130:	8082                	ret
  return 0;
 132:	4501                	li	a0,0
 134:	bfe5                	j	12c <strchr+0x1a>

0000000000000136 <gets>:

char*
gets(char *buf, int max)
{
 136:	711d                	add	sp,sp,-96
 138:	ec86                	sd	ra,88(sp)
 13a:	e8a2                	sd	s0,80(sp)
 13c:	e4a6                	sd	s1,72(sp)
 13e:	e0ca                	sd	s2,64(sp)
 140:	fc4e                	sd	s3,56(sp)
 142:	f852                	sd	s4,48(sp)
 144:	f456                	sd	s5,40(sp)
 146:	f05a                	sd	s6,32(sp)
 148:	ec5e                	sd	s7,24(sp)
 14a:	1080                	add	s0,sp,96
 14c:	8baa                	mv	s7,a0
 14e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 150:	892a                	mv	s2,a0
 152:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 154:	4aa9                	li	s5,10
 156:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 158:	89a6                	mv	s3,s1
 15a:	2485                	addw	s1,s1,1
 15c:	0344d863          	bge	s1,s4,18c <gets+0x56>
    cc = read(0, &c, 1);
 160:	4605                	li	a2,1
 162:	faf40593          	add	a1,s0,-81
 166:	4501                	li	a0,0
 168:	00000097          	auipc	ra,0x0
 16c:	1d6080e7          	jalr	470(ra) # 33e <read>
    if(cc < 1)
 170:	00a05e63          	blez	a0,18c <gets+0x56>
    buf[i++] = c;
 174:	faf44783          	lbu	a5,-81(s0)
 178:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 17c:	01578763          	beq	a5,s5,18a <gets+0x54>
 180:	0905                	add	s2,s2,1
 182:	fd679be3          	bne	a5,s6,158 <gets+0x22>
  for(i=0; i+1 < max; ){
 186:	89a6                	mv	s3,s1
 188:	a011                	j	18c <gets+0x56>
 18a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 18c:	99de                	add	s3,s3,s7
 18e:	00098023          	sb	zero,0(s3)
  return buf;
}
 192:	855e                	mv	a0,s7
 194:	60e6                	ld	ra,88(sp)
 196:	6446                	ld	s0,80(sp)
 198:	64a6                	ld	s1,72(sp)
 19a:	6906                	ld	s2,64(sp)
 19c:	79e2                	ld	s3,56(sp)
 19e:	7a42                	ld	s4,48(sp)
 1a0:	7aa2                	ld	s5,40(sp)
 1a2:	7b02                	ld	s6,32(sp)
 1a4:	6be2                	ld	s7,24(sp)
 1a6:	6125                	add	sp,sp,96
 1a8:	8082                	ret

00000000000001aa <stat>:

int
stat(const char *n, struct stat *st)
{
 1aa:	1101                	add	sp,sp,-32
 1ac:	ec06                	sd	ra,24(sp)
 1ae:	e822                	sd	s0,16(sp)
 1b0:	e426                	sd	s1,8(sp)
 1b2:	e04a                	sd	s2,0(sp)
 1b4:	1000                	add	s0,sp,32
 1b6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b8:	4581                	li	a1,0
 1ba:	00000097          	auipc	ra,0x0
 1be:	1ac080e7          	jalr	428(ra) # 366 <open>
  if(fd < 0)
 1c2:	02054563          	bltz	a0,1ec <stat+0x42>
 1c6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1c8:	85ca                	mv	a1,s2
 1ca:	00000097          	auipc	ra,0x0
 1ce:	1b4080e7          	jalr	436(ra) # 37e <fstat>
 1d2:	892a                	mv	s2,a0
  close(fd);
 1d4:	8526                	mv	a0,s1
 1d6:	00000097          	auipc	ra,0x0
 1da:	178080e7          	jalr	376(ra) # 34e <close>
  return r;
}
 1de:	854a                	mv	a0,s2
 1e0:	60e2                	ld	ra,24(sp)
 1e2:	6442                	ld	s0,16(sp)
 1e4:	64a2                	ld	s1,8(sp)
 1e6:	6902                	ld	s2,0(sp)
 1e8:	6105                	add	sp,sp,32
 1ea:	8082                	ret
    return -1;
 1ec:	597d                	li	s2,-1
 1ee:	bfc5                	j	1de <stat+0x34>

00000000000001f0 <atoi>:

int
atoi(const char *s)
{
 1f0:	1141                	add	sp,sp,-16
 1f2:	e422                	sd	s0,8(sp)
 1f4:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1f6:	00054683          	lbu	a3,0(a0)
 1fa:	fd06879b          	addw	a5,a3,-48
 1fe:	0ff7f793          	zext.b	a5,a5
 202:	4625                	li	a2,9
 204:	02f66863          	bltu	a2,a5,234 <atoi+0x44>
 208:	872a                	mv	a4,a0
  n = 0;
 20a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 20c:	0705                	add	a4,a4,1
 20e:	0025179b          	sllw	a5,a0,0x2
 212:	9fa9                	addw	a5,a5,a0
 214:	0017979b          	sllw	a5,a5,0x1
 218:	9fb5                	addw	a5,a5,a3
 21a:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 21e:	00074683          	lbu	a3,0(a4)
 222:	fd06879b          	addw	a5,a3,-48
 226:	0ff7f793          	zext.b	a5,a5
 22a:	fef671e3          	bgeu	a2,a5,20c <atoi+0x1c>
  return n;
}
 22e:	6422                	ld	s0,8(sp)
 230:	0141                	add	sp,sp,16
 232:	8082                	ret
  n = 0;
 234:	4501                	li	a0,0
 236:	bfe5                	j	22e <atoi+0x3e>

0000000000000238 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 238:	1141                	add	sp,sp,-16
 23a:	e422                	sd	s0,8(sp)
 23c:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 23e:	02b57463          	bgeu	a0,a1,266 <memmove+0x2e>
    while(n-- > 0)
 242:	00c05f63          	blez	a2,260 <memmove+0x28>
 246:	1602                	sll	a2,a2,0x20
 248:	9201                	srl	a2,a2,0x20
 24a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 24e:	872a                	mv	a4,a0
      *dst++ = *src++;
 250:	0585                	add	a1,a1,1
 252:	0705                	add	a4,a4,1
 254:	fff5c683          	lbu	a3,-1(a1)
 258:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 25c:	fee79ae3          	bne	a5,a4,250 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 260:	6422                	ld	s0,8(sp)
 262:	0141                	add	sp,sp,16
 264:	8082                	ret
    dst += n;
 266:	00c50733          	add	a4,a0,a2
    src += n;
 26a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 26c:	fec05ae3          	blez	a2,260 <memmove+0x28>
 270:	fff6079b          	addw	a5,a2,-1
 274:	1782                	sll	a5,a5,0x20
 276:	9381                	srl	a5,a5,0x20
 278:	fff7c793          	not	a5,a5
 27c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 27e:	15fd                	add	a1,a1,-1
 280:	177d                	add	a4,a4,-1
 282:	0005c683          	lbu	a3,0(a1)
 286:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 28a:	fee79ae3          	bne	a5,a4,27e <memmove+0x46>
 28e:	bfc9                	j	260 <memmove+0x28>

0000000000000290 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 290:	1141                	add	sp,sp,-16
 292:	e422                	sd	s0,8(sp)
 294:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 296:	ca05                	beqz	a2,2c6 <memcmp+0x36>
 298:	fff6069b          	addw	a3,a2,-1
 29c:	1682                	sll	a3,a3,0x20
 29e:	9281                	srl	a3,a3,0x20
 2a0:	0685                	add	a3,a3,1
 2a2:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2a4:	00054783          	lbu	a5,0(a0)
 2a8:	0005c703          	lbu	a4,0(a1)
 2ac:	00e79863          	bne	a5,a4,2bc <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2b0:	0505                	add	a0,a0,1
    p2++;
 2b2:	0585                	add	a1,a1,1
  while (n-- > 0) {
 2b4:	fed518e3          	bne	a0,a3,2a4 <memcmp+0x14>
  }
  return 0;
 2b8:	4501                	li	a0,0
 2ba:	a019                	j	2c0 <memcmp+0x30>
      return *p1 - *p2;
 2bc:	40e7853b          	subw	a0,a5,a4
}
 2c0:	6422                	ld	s0,8(sp)
 2c2:	0141                	add	sp,sp,16
 2c4:	8082                	ret
  return 0;
 2c6:	4501                	li	a0,0
 2c8:	bfe5                	j	2c0 <memcmp+0x30>

00000000000002ca <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2ca:	1141                	add	sp,sp,-16
 2cc:	e406                	sd	ra,8(sp)
 2ce:	e022                	sd	s0,0(sp)
 2d0:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 2d2:	00000097          	auipc	ra,0x0
 2d6:	f66080e7          	jalr	-154(ra) # 238 <memmove>
}
 2da:	60a2                	ld	ra,8(sp)
 2dc:	6402                	ld	s0,0(sp)
 2de:	0141                	add	sp,sp,16
 2e0:	8082                	ret

00000000000002e2 <initlock>:

// Initialize the spinlock
void initlock(struct spinlock_u *lk) {
 2e2:	1141                	add	sp,sp,-16
 2e4:	e422                	sd	s0,8(sp)
 2e6:	0800                	add	s0,sp,16
  lk->locked = 0;
 2e8:	00052023          	sw	zero,0(a0)
}
 2ec:	6422                	ld	s0,8(sp)
 2ee:	0141                	add	sp,sp,16
 2f0:	8082                	ret

00000000000002f2 <acquire>:

// Acquire the spinlock
void acquire(struct spinlock_u *lk) {
 2f2:	1141                	add	sp,sp,-16
 2f4:	e422                	sd	s0,8(sp)
 2f6:	0800                	add	s0,sp,16
  while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 2f8:	4705                	li	a4,1
 2fa:	87ba                	mv	a5,a4
 2fc:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
 300:	2781                	sext.w	a5,a5
 302:	ffe5                	bnez	a5,2fa <acquire+0x8>
    ; // Spin until the lock is acquired
}
 304:	6422                	ld	s0,8(sp)
 306:	0141                	add	sp,sp,16
 308:	8082                	ret

000000000000030a <release>:

// Release the spinlock
void release(struct spinlock_u *lk) {
 30a:	1141                	add	sp,sp,-16
 30c:	e422                	sd	s0,8(sp)
 30e:	0800                	add	s0,sp,16
  __sync_lock_release(&lk->locked);
 310:	0f50000f          	fence	iorw,ow
 314:	0805202f          	amoswap.w	zero,zero,(a0)
}
 318:	6422                	ld	s0,8(sp)
 31a:	0141                	add	sp,sp,16
 31c:	8082                	ret

000000000000031e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 31e:	4885                	li	a7,1
 ecall
 320:	00000073          	ecall
 ret
 324:	8082                	ret

0000000000000326 <exit>:
.global exit
exit:
 li a7, SYS_exit
 326:	4889                	li	a7,2
 ecall
 328:	00000073          	ecall
 ret
 32c:	8082                	ret

000000000000032e <wait>:
.global wait
wait:
 li a7, SYS_wait
 32e:	488d                	li	a7,3
 ecall
 330:	00000073          	ecall
 ret
 334:	8082                	ret

0000000000000336 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 336:	4891                	li	a7,4
 ecall
 338:	00000073          	ecall
 ret
 33c:	8082                	ret

000000000000033e <read>:
.global read
read:
 li a7, SYS_read
 33e:	4895                	li	a7,5
 ecall
 340:	00000073          	ecall
 ret
 344:	8082                	ret

0000000000000346 <write>:
.global write
write:
 li a7, SYS_write
 346:	48c1                	li	a7,16
 ecall
 348:	00000073          	ecall
 ret
 34c:	8082                	ret

000000000000034e <close>:
.global close
close:
 li a7, SYS_close
 34e:	48d5                	li	a7,21
 ecall
 350:	00000073          	ecall
 ret
 354:	8082                	ret

0000000000000356 <kill>:
.global kill
kill:
 li a7, SYS_kill
 356:	4899                	li	a7,6
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <exec>:
.global exec
exec:
 li a7, SYS_exec
 35e:	489d                	li	a7,7
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <open>:
.global open
open:
 li a7, SYS_open
 366:	48bd                	li	a7,15
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 36e:	48c5                	li	a7,17
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 376:	48c9                	li	a7,18
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 37e:	48a1                	li	a7,8
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <link>:
.global link
link:
 li a7, SYS_link
 386:	48cd                	li	a7,19
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 38e:	48d1                	li	a7,20
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 396:	48a5                	li	a7,9
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <dup>:
.global dup
dup:
 li a7, SYS_dup
 39e:	48a9                	li	a7,10
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3a6:	48ad                	li	a7,11
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3ae:	48b1                	li	a7,12
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3b6:	48b5                	li	a7,13
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3be:	48b9                	li	a7,14
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <rcureadlock>:
.global rcureadlock
rcureadlock:
 li a7, SYS_rcureadlock
 3c6:	48dd                	li	a7,23
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <rcureadunlock>:
.global rcureadunlock
rcureadunlock:
 li a7, SYS_rcureadunlock
 3ce:	48e1                	li	a7,24
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <rcusync>:
.global rcusync
rcusync:
 li a7, SYS_rcusync
 3d6:	48d9                	li	a7,22
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <thread_create>:
.global thread_create
thread_create:
 li a7, SYS_thread_create
 3de:	48e5                	li	a7,25
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <thread_join>:
.global thread_join
thread_join:
 li a7, SYS_thread_join
 3e6:	48e9                	li	a7,26
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <thread_exit>:
.global thread_exit
thread_exit:
 li a7, SYS_thread_exit
 3ee:	48ed                	li	a7,27
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <klist_insert>:
.global klist_insert
klist_insert:
 li a7, SYS_klist_insert
 3f6:	48f1                	li	a7,28
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <klist_delete>:
.global klist_delete
klist_delete:
 li a7, SYS_klist_delete
 3fe:	48f5                	li	a7,29
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <klist_query>:
.global klist_query
klist_query:
 li a7, SYS_klist_query
 406:	48f9                	li	a7,30
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <klist_print>:
.global klist_print
klist_print:
 li a7, SYS_klist_print
 40e:	48fd                	li	a7,31
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 416:	1101                	add	sp,sp,-32
 418:	ec06                	sd	ra,24(sp)
 41a:	e822                	sd	s0,16(sp)
 41c:	1000                	add	s0,sp,32
 41e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 422:	4605                	li	a2,1
 424:	fef40593          	add	a1,s0,-17
 428:	00000097          	auipc	ra,0x0
 42c:	f1e080e7          	jalr	-226(ra) # 346 <write>
}
 430:	60e2                	ld	ra,24(sp)
 432:	6442                	ld	s0,16(sp)
 434:	6105                	add	sp,sp,32
 436:	8082                	ret

0000000000000438 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 438:	7139                	add	sp,sp,-64
 43a:	fc06                	sd	ra,56(sp)
 43c:	f822                	sd	s0,48(sp)
 43e:	f426                	sd	s1,40(sp)
 440:	f04a                	sd	s2,32(sp)
 442:	ec4e                	sd	s3,24(sp)
 444:	0080                	add	s0,sp,64
 446:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 448:	c299                	beqz	a3,44e <printint+0x16>
 44a:	0805c963          	bltz	a1,4dc <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 44e:	2581                	sext.w	a1,a1
  neg = 0;
 450:	4881                	li	a7,0
 452:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 456:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 458:	2601                	sext.w	a2,a2
 45a:	00000517          	auipc	a0,0x0
 45e:	61e50513          	add	a0,a0,1566 # a78 <digits>
 462:	883a                	mv	a6,a4
 464:	2705                	addw	a4,a4,1
 466:	02c5f7bb          	remuw	a5,a1,a2
 46a:	1782                	sll	a5,a5,0x20
 46c:	9381                	srl	a5,a5,0x20
 46e:	97aa                	add	a5,a5,a0
 470:	0007c783          	lbu	a5,0(a5)
 474:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 478:	0005879b          	sext.w	a5,a1
 47c:	02c5d5bb          	divuw	a1,a1,a2
 480:	0685                	add	a3,a3,1
 482:	fec7f0e3          	bgeu	a5,a2,462 <printint+0x2a>
  if(neg)
 486:	00088c63          	beqz	a7,49e <printint+0x66>
    buf[i++] = '-';
 48a:	fd070793          	add	a5,a4,-48
 48e:	00878733          	add	a4,a5,s0
 492:	02d00793          	li	a5,45
 496:	fef70823          	sb	a5,-16(a4)
 49a:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 49e:	02e05863          	blez	a4,4ce <printint+0x96>
 4a2:	fc040793          	add	a5,s0,-64
 4a6:	00e78933          	add	s2,a5,a4
 4aa:	fff78993          	add	s3,a5,-1
 4ae:	99ba                	add	s3,s3,a4
 4b0:	377d                	addw	a4,a4,-1
 4b2:	1702                	sll	a4,a4,0x20
 4b4:	9301                	srl	a4,a4,0x20
 4b6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4ba:	fff94583          	lbu	a1,-1(s2)
 4be:	8526                	mv	a0,s1
 4c0:	00000097          	auipc	ra,0x0
 4c4:	f56080e7          	jalr	-170(ra) # 416 <putc>
  while(--i >= 0)
 4c8:	197d                	add	s2,s2,-1
 4ca:	ff3918e3          	bne	s2,s3,4ba <printint+0x82>
}
 4ce:	70e2                	ld	ra,56(sp)
 4d0:	7442                	ld	s0,48(sp)
 4d2:	74a2                	ld	s1,40(sp)
 4d4:	7902                	ld	s2,32(sp)
 4d6:	69e2                	ld	s3,24(sp)
 4d8:	6121                	add	sp,sp,64
 4da:	8082                	ret
    x = -xx;
 4dc:	40b005bb          	negw	a1,a1
    neg = 1;
 4e0:	4885                	li	a7,1
    x = -xx;
 4e2:	bf85                	j	452 <printint+0x1a>

00000000000004e4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4e4:	715d                	add	sp,sp,-80
 4e6:	e486                	sd	ra,72(sp)
 4e8:	e0a2                	sd	s0,64(sp)
 4ea:	fc26                	sd	s1,56(sp)
 4ec:	f84a                	sd	s2,48(sp)
 4ee:	f44e                	sd	s3,40(sp)
 4f0:	f052                	sd	s4,32(sp)
 4f2:	ec56                	sd	s5,24(sp)
 4f4:	e85a                	sd	s6,16(sp)
 4f6:	e45e                	sd	s7,8(sp)
 4f8:	e062                	sd	s8,0(sp)
 4fa:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4fc:	0005c903          	lbu	s2,0(a1)
 500:	18090c63          	beqz	s2,698 <vprintf+0x1b4>
 504:	8aaa                	mv	s5,a0
 506:	8bb2                	mv	s7,a2
 508:	00158493          	add	s1,a1,1
  state = 0;
 50c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 50e:	02500a13          	li	s4,37
 512:	4b55                	li	s6,21
 514:	a839                	j	532 <vprintf+0x4e>
        putc(fd, c);
 516:	85ca                	mv	a1,s2
 518:	8556                	mv	a0,s5
 51a:	00000097          	auipc	ra,0x0
 51e:	efc080e7          	jalr	-260(ra) # 416 <putc>
 522:	a019                	j	528 <vprintf+0x44>
    } else if(state == '%'){
 524:	01498d63          	beq	s3,s4,53e <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 528:	0485                	add	s1,s1,1
 52a:	fff4c903          	lbu	s2,-1(s1)
 52e:	16090563          	beqz	s2,698 <vprintf+0x1b4>
    if(state == 0){
 532:	fe0999e3          	bnez	s3,524 <vprintf+0x40>
      if(c == '%'){
 536:	ff4910e3          	bne	s2,s4,516 <vprintf+0x32>
        state = '%';
 53a:	89d2                	mv	s3,s4
 53c:	b7f5                	j	528 <vprintf+0x44>
      if(c == 'd'){
 53e:	13490263          	beq	s2,s4,662 <vprintf+0x17e>
 542:	f9d9079b          	addw	a5,s2,-99
 546:	0ff7f793          	zext.b	a5,a5
 54a:	12fb6563          	bltu	s6,a5,674 <vprintf+0x190>
 54e:	f9d9079b          	addw	a5,s2,-99
 552:	0ff7f713          	zext.b	a4,a5
 556:	10eb6f63          	bltu	s6,a4,674 <vprintf+0x190>
 55a:	00271793          	sll	a5,a4,0x2
 55e:	00000717          	auipc	a4,0x0
 562:	4c270713          	add	a4,a4,1218 # a20 <updateNode+0x60>
 566:	97ba                	add	a5,a5,a4
 568:	439c                	lw	a5,0(a5)
 56a:	97ba                	add	a5,a5,a4
 56c:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 56e:	008b8913          	add	s2,s7,8
 572:	4685                	li	a3,1
 574:	4629                	li	a2,10
 576:	000ba583          	lw	a1,0(s7)
 57a:	8556                	mv	a0,s5
 57c:	00000097          	auipc	ra,0x0
 580:	ebc080e7          	jalr	-324(ra) # 438 <printint>
 584:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 586:	4981                	li	s3,0
 588:	b745                	j	528 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 58a:	008b8913          	add	s2,s7,8
 58e:	4681                	li	a3,0
 590:	4629                	li	a2,10
 592:	000ba583          	lw	a1,0(s7)
 596:	8556                	mv	a0,s5
 598:	00000097          	auipc	ra,0x0
 59c:	ea0080e7          	jalr	-352(ra) # 438 <printint>
 5a0:	8bca                	mv	s7,s2
      state = 0;
 5a2:	4981                	li	s3,0
 5a4:	b751                	j	528 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 5a6:	008b8913          	add	s2,s7,8
 5aa:	4681                	li	a3,0
 5ac:	4641                	li	a2,16
 5ae:	000ba583          	lw	a1,0(s7)
 5b2:	8556                	mv	a0,s5
 5b4:	00000097          	auipc	ra,0x0
 5b8:	e84080e7          	jalr	-380(ra) # 438 <printint>
 5bc:	8bca                	mv	s7,s2
      state = 0;
 5be:	4981                	li	s3,0
 5c0:	b7a5                	j	528 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 5c2:	008b8c13          	add	s8,s7,8
 5c6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 5ca:	03000593          	li	a1,48
 5ce:	8556                	mv	a0,s5
 5d0:	00000097          	auipc	ra,0x0
 5d4:	e46080e7          	jalr	-442(ra) # 416 <putc>
  putc(fd, 'x');
 5d8:	07800593          	li	a1,120
 5dc:	8556                	mv	a0,s5
 5de:	00000097          	auipc	ra,0x0
 5e2:	e38080e7          	jalr	-456(ra) # 416 <putc>
 5e6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5e8:	00000b97          	auipc	s7,0x0
 5ec:	490b8b93          	add	s7,s7,1168 # a78 <digits>
 5f0:	03c9d793          	srl	a5,s3,0x3c
 5f4:	97de                	add	a5,a5,s7
 5f6:	0007c583          	lbu	a1,0(a5)
 5fa:	8556                	mv	a0,s5
 5fc:	00000097          	auipc	ra,0x0
 600:	e1a080e7          	jalr	-486(ra) # 416 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 604:	0992                	sll	s3,s3,0x4
 606:	397d                	addw	s2,s2,-1
 608:	fe0914e3          	bnez	s2,5f0 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 60c:	8be2                	mv	s7,s8
      state = 0;
 60e:	4981                	li	s3,0
 610:	bf21                	j	528 <vprintf+0x44>
        s = va_arg(ap, char*);
 612:	008b8993          	add	s3,s7,8
 616:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 61a:	02090163          	beqz	s2,63c <vprintf+0x158>
        while(*s != 0){
 61e:	00094583          	lbu	a1,0(s2)
 622:	c9a5                	beqz	a1,692 <vprintf+0x1ae>
          putc(fd, *s);
 624:	8556                	mv	a0,s5
 626:	00000097          	auipc	ra,0x0
 62a:	df0080e7          	jalr	-528(ra) # 416 <putc>
          s++;
 62e:	0905                	add	s2,s2,1
        while(*s != 0){
 630:	00094583          	lbu	a1,0(s2)
 634:	f9e5                	bnez	a1,624 <vprintf+0x140>
        s = va_arg(ap, char*);
 636:	8bce                	mv	s7,s3
      state = 0;
 638:	4981                	li	s3,0
 63a:	b5fd                	j	528 <vprintf+0x44>
          s = "(null)";
 63c:	00000917          	auipc	s2,0x0
 640:	3dc90913          	add	s2,s2,988 # a18 <updateNode+0x58>
        while(*s != 0){
 644:	02800593          	li	a1,40
 648:	bff1                	j	624 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 64a:	008b8913          	add	s2,s7,8
 64e:	000bc583          	lbu	a1,0(s7)
 652:	8556                	mv	a0,s5
 654:	00000097          	auipc	ra,0x0
 658:	dc2080e7          	jalr	-574(ra) # 416 <putc>
 65c:	8bca                	mv	s7,s2
      state = 0;
 65e:	4981                	li	s3,0
 660:	b5e1                	j	528 <vprintf+0x44>
        putc(fd, c);
 662:	02500593          	li	a1,37
 666:	8556                	mv	a0,s5
 668:	00000097          	auipc	ra,0x0
 66c:	dae080e7          	jalr	-594(ra) # 416 <putc>
      state = 0;
 670:	4981                	li	s3,0
 672:	bd5d                	j	528 <vprintf+0x44>
        putc(fd, '%');
 674:	02500593          	li	a1,37
 678:	8556                	mv	a0,s5
 67a:	00000097          	auipc	ra,0x0
 67e:	d9c080e7          	jalr	-612(ra) # 416 <putc>
        putc(fd, c);
 682:	85ca                	mv	a1,s2
 684:	8556                	mv	a0,s5
 686:	00000097          	auipc	ra,0x0
 68a:	d90080e7          	jalr	-624(ra) # 416 <putc>
      state = 0;
 68e:	4981                	li	s3,0
 690:	bd61                	j	528 <vprintf+0x44>
        s = va_arg(ap, char*);
 692:	8bce                	mv	s7,s3
      state = 0;
 694:	4981                	li	s3,0
 696:	bd49                	j	528 <vprintf+0x44>
    }
  }
}
 698:	60a6                	ld	ra,72(sp)
 69a:	6406                	ld	s0,64(sp)
 69c:	74e2                	ld	s1,56(sp)
 69e:	7942                	ld	s2,48(sp)
 6a0:	79a2                	ld	s3,40(sp)
 6a2:	7a02                	ld	s4,32(sp)
 6a4:	6ae2                	ld	s5,24(sp)
 6a6:	6b42                	ld	s6,16(sp)
 6a8:	6ba2                	ld	s7,8(sp)
 6aa:	6c02                	ld	s8,0(sp)
 6ac:	6161                	add	sp,sp,80
 6ae:	8082                	ret

00000000000006b0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6b0:	715d                	add	sp,sp,-80
 6b2:	ec06                	sd	ra,24(sp)
 6b4:	e822                	sd	s0,16(sp)
 6b6:	1000                	add	s0,sp,32
 6b8:	e010                	sd	a2,0(s0)
 6ba:	e414                	sd	a3,8(s0)
 6bc:	e818                	sd	a4,16(s0)
 6be:	ec1c                	sd	a5,24(s0)
 6c0:	03043023          	sd	a6,32(s0)
 6c4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6c8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6cc:	8622                	mv	a2,s0
 6ce:	00000097          	auipc	ra,0x0
 6d2:	e16080e7          	jalr	-490(ra) # 4e4 <vprintf>
}
 6d6:	60e2                	ld	ra,24(sp)
 6d8:	6442                	ld	s0,16(sp)
 6da:	6161                	add	sp,sp,80
 6dc:	8082                	ret

00000000000006de <printf>:

void
printf(const char *fmt, ...)
{
 6de:	711d                	add	sp,sp,-96
 6e0:	ec06                	sd	ra,24(sp)
 6e2:	e822                	sd	s0,16(sp)
 6e4:	1000                	add	s0,sp,32
 6e6:	e40c                	sd	a1,8(s0)
 6e8:	e810                	sd	a2,16(s0)
 6ea:	ec14                	sd	a3,24(s0)
 6ec:	f018                	sd	a4,32(s0)
 6ee:	f41c                	sd	a5,40(s0)
 6f0:	03043823          	sd	a6,48(s0)
 6f4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6f8:	00840613          	add	a2,s0,8
 6fc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 700:	85aa                	mv	a1,a0
 702:	4505                	li	a0,1
 704:	00000097          	auipc	ra,0x0
 708:	de0080e7          	jalr	-544(ra) # 4e4 <vprintf>
}
 70c:	60e2                	ld	ra,24(sp)
 70e:	6442                	ld	s0,16(sp)
 710:	6125                	add	sp,sp,96
 712:	8082                	ret

0000000000000714 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 714:	1141                	add	sp,sp,-16
 716:	e422                	sd	s0,8(sp)
 718:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 71a:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 71e:	00001797          	auipc	a5,0x1
 722:	8e27b783          	ld	a5,-1822(a5) # 1000 <freep>
 726:	a02d                	j	750 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 728:	4618                	lw	a4,8(a2)
 72a:	9f2d                	addw	a4,a4,a1
 72c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 730:	6398                	ld	a4,0(a5)
 732:	6310                	ld	a2,0(a4)
 734:	a83d                	j	772 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 736:	ff852703          	lw	a4,-8(a0)
 73a:	9f31                	addw	a4,a4,a2
 73c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 73e:	ff053683          	ld	a3,-16(a0)
 742:	a091                	j	786 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 744:	6398                	ld	a4,0(a5)
 746:	00e7e463          	bltu	a5,a4,74e <free+0x3a>
 74a:	00e6ea63          	bltu	a3,a4,75e <free+0x4a>
{
 74e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 750:	fed7fae3          	bgeu	a5,a3,744 <free+0x30>
 754:	6398                	ld	a4,0(a5)
 756:	00e6e463          	bltu	a3,a4,75e <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 75a:	fee7eae3          	bltu	a5,a4,74e <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 75e:	ff852583          	lw	a1,-8(a0)
 762:	6390                	ld	a2,0(a5)
 764:	02059813          	sll	a6,a1,0x20
 768:	01c85713          	srl	a4,a6,0x1c
 76c:	9736                	add	a4,a4,a3
 76e:	fae60de3          	beq	a2,a4,728 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 772:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 776:	4790                	lw	a2,8(a5)
 778:	02061593          	sll	a1,a2,0x20
 77c:	01c5d713          	srl	a4,a1,0x1c
 780:	973e                	add	a4,a4,a5
 782:	fae68ae3          	beq	a3,a4,736 <free+0x22>
    p->s.ptr = bp->s.ptr;
 786:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 788:	00001717          	auipc	a4,0x1
 78c:	86f73c23          	sd	a5,-1928(a4) # 1000 <freep>
}
 790:	6422                	ld	s0,8(sp)
 792:	0141                	add	sp,sp,16
 794:	8082                	ret

0000000000000796 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 796:	7139                	add	sp,sp,-64
 798:	fc06                	sd	ra,56(sp)
 79a:	f822                	sd	s0,48(sp)
 79c:	f426                	sd	s1,40(sp)
 79e:	f04a                	sd	s2,32(sp)
 7a0:	ec4e                	sd	s3,24(sp)
 7a2:	e852                	sd	s4,16(sp)
 7a4:	e456                	sd	s5,8(sp)
 7a6:	e05a                	sd	s6,0(sp)
 7a8:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7aa:	02051493          	sll	s1,a0,0x20
 7ae:	9081                	srl	s1,s1,0x20
 7b0:	04bd                	add	s1,s1,15
 7b2:	8091                	srl	s1,s1,0x4
 7b4:	0014899b          	addw	s3,s1,1
 7b8:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 7ba:	00001517          	auipc	a0,0x1
 7be:	84653503          	ld	a0,-1978(a0) # 1000 <freep>
 7c2:	c515                	beqz	a0,7ee <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7c6:	4798                	lw	a4,8(a5)
 7c8:	02977f63          	bgeu	a4,s1,806 <malloc+0x70>
  if(nu < 4096)
 7cc:	8a4e                	mv	s4,s3
 7ce:	0009871b          	sext.w	a4,s3
 7d2:	6685                	lui	a3,0x1
 7d4:	00d77363          	bgeu	a4,a3,7da <malloc+0x44>
 7d8:	6a05                	lui	s4,0x1
 7da:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7de:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7e2:	00001917          	auipc	s2,0x1
 7e6:	81e90913          	add	s2,s2,-2018 # 1000 <freep>
  if(p == (char*)-1)
 7ea:	5afd                	li	s5,-1
 7ec:	a895                	j	860 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 7ee:	00001797          	auipc	a5,0x1
 7f2:	82278793          	add	a5,a5,-2014 # 1010 <base>
 7f6:	00001717          	auipc	a4,0x1
 7fa:	80f73523          	sd	a5,-2038(a4) # 1000 <freep>
 7fe:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 800:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 804:	b7e1                	j	7cc <malloc+0x36>
      if(p->s.size == nunits)
 806:	02e48c63          	beq	s1,a4,83e <malloc+0xa8>
        p->s.size -= nunits;
 80a:	4137073b          	subw	a4,a4,s3
 80e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 810:	02071693          	sll	a3,a4,0x20
 814:	01c6d713          	srl	a4,a3,0x1c
 818:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 81a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 81e:	00000717          	auipc	a4,0x0
 822:	7ea73123          	sd	a0,2018(a4) # 1000 <freep>
      return (void*)(p + 1);
 826:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 82a:	70e2                	ld	ra,56(sp)
 82c:	7442                	ld	s0,48(sp)
 82e:	74a2                	ld	s1,40(sp)
 830:	7902                	ld	s2,32(sp)
 832:	69e2                	ld	s3,24(sp)
 834:	6a42                	ld	s4,16(sp)
 836:	6aa2                	ld	s5,8(sp)
 838:	6b02                	ld	s6,0(sp)
 83a:	6121                	add	sp,sp,64
 83c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 83e:	6398                	ld	a4,0(a5)
 840:	e118                	sd	a4,0(a0)
 842:	bff1                	j	81e <malloc+0x88>
  hp->s.size = nu;
 844:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 848:	0541                	add	a0,a0,16
 84a:	00000097          	auipc	ra,0x0
 84e:	eca080e7          	jalr	-310(ra) # 714 <free>
  return freep;
 852:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 856:	d971                	beqz	a0,82a <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 858:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 85a:	4798                	lw	a4,8(a5)
 85c:	fa9775e3          	bgeu	a4,s1,806 <malloc+0x70>
    if(p == freep)
 860:	00093703          	ld	a4,0(s2)
 864:	853e                	mv	a0,a5
 866:	fef719e3          	bne	a4,a5,858 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 86a:	8552                	mv	a0,s4
 86c:	00000097          	auipc	ra,0x0
 870:	b42080e7          	jalr	-1214(ra) # 3ae <sbrk>
  if(p == (char*)-1)
 874:	fd5518e3          	bne	a0,s5,844 <malloc+0xae>
        return 0;
 878:	4501                	li	a0,0
 87a:	bf45                	j	82a <malloc+0x94>

000000000000087c <init_lock>:
#include "linkedlist.h"

// Define a node structure for the linked list
struct spinlock_u list_lock;

void init_lock(){
 87c:	1141                	add	sp,sp,-16
 87e:	e406                	sd	ra,8(sp)
 880:	e022                	sd	s0,0(sp)
 882:	0800                	add	s0,sp,16
    initlock(&list_lock);
 884:	00000517          	auipc	a0,0x0
 888:	78450513          	add	a0,a0,1924 # 1008 <list_lock>
 88c:	00000097          	auipc	ra,0x0
 890:	a56080e7          	jalr	-1450(ra) # 2e2 <initlock>
}
 894:	60a2                	ld	ra,8(sp)
 896:	6402                	ld	s0,0(sp)
 898:	0141                	add	sp,sp,16
 89a:	8082                	ret

000000000000089c <insert>:

// Function to insert a node at the beginning of the linked list
void insert(struct Node **head_ref, int new_data) {
 89c:	1101                	add	sp,sp,-32
 89e:	ec06                	sd	ra,24(sp)
 8a0:	e822                	sd	s0,16(sp)
 8a2:	e426                	sd	s1,8(sp)
 8a4:	e04a                	sd	s2,0(sp)
 8a6:	1000                	add	s0,sp,32
 8a8:	84aa                	mv	s1,a0
 8aa:	892e                	mv	s2,a1
    struct Node *new_node = malloc(sizeof(struct Node));
 8ac:	4541                	li	a0,16
 8ae:	00000097          	auipc	ra,0x0
 8b2:	ee8080e7          	jalr	-280(ra) # 796 <malloc>
    new_node->data = new_data;
 8b6:	01252023          	sw	s2,0(a0)
    new_node->next = *head_ref;
 8ba:	609c                	ld	a5,0(s1)
 8bc:	e51c                	sd	a5,8(a0)
    *head_ref = new_node;
 8be:	e088                	sd	a0,0(s1)
}
 8c0:	60e2                	ld	ra,24(sp)
 8c2:	6442                	ld	s0,16(sp)
 8c4:	64a2                	ld	s1,8(sp)
 8c6:	6902                	ld	s2,0(sp)
 8c8:	6105                	add	sp,sp,32
 8ca:	8082                	ret

00000000000008cc <deleteNode>:

// Function to delete a node with a given key from the linked list
void deleteNode(struct Node **head_ref, int key) {
 8cc:	7179                	add	sp,sp,-48
 8ce:	f406                	sd	ra,40(sp)
 8d0:	f022                	sd	s0,32(sp)
 8d2:	ec26                	sd	s1,24(sp)
 8d4:	e84a                	sd	s2,16(sp)
 8d6:	e44e                	sd	s3,8(sp)
 8d8:	1800                	add	s0,sp,48
 8da:	89aa                	mv	s3,a0
 8dc:	892e                	mv	s2,a1
    struct Node *temp = *head_ref, *prev = 0;
 8de:	6104                	ld	s1,0(a0)

    acquire(&list_lock);
 8e0:	00000517          	auipc	a0,0x0
 8e4:	72850513          	add	a0,a0,1832 # 1008 <list_lock>
 8e8:	00000097          	auipc	ra,0x0
 8ec:	a0a080e7          	jalr	-1526(ra) # 2f2 <acquire>
    if (temp != 0 && temp->data == key) {
 8f0:	c0b1                	beqz	s1,934 <deleteNode+0x68>
 8f2:	409c                	lw	a5,0(s1)
 8f4:	4701                	li	a4,0
 8f6:	01278a63          	beq	a5,s2,90a <deleteNode+0x3e>
        rcusync();
        free(temp);
        return;
    }

    while (temp != 0 && temp->data != key) {
 8fa:	409c                	lw	a5,0(s1)
 8fc:	05278563          	beq	a5,s2,946 <deleteNode+0x7a>
        prev = temp;
        temp = temp->next;
 900:	649c                	ld	a5,8(s1)
    while (temp != 0 && temp->data != key) {
 902:	8726                	mv	a4,s1
 904:	cb85                	beqz	a5,934 <deleteNode+0x68>
        temp = temp->next;
 906:	84be                	mv	s1,a5
 908:	bfcd                	j	8fa <deleteNode+0x2e>
        *head_ref = temp->next;
 90a:	649c                	ld	a5,8(s1)
 90c:	00f9b023          	sd	a5,0(s3)
        release(&list_lock);
 910:	00000517          	auipc	a0,0x0
 914:	6f850513          	add	a0,a0,1784 # 1008 <list_lock>
 918:	00000097          	auipc	ra,0x0
 91c:	9f2080e7          	jalr	-1550(ra) # 30a <release>
        rcusync();
 920:	00000097          	auipc	ra,0x0
 924:	ab6080e7          	jalr	-1354(ra) # 3d6 <rcusync>
        free(temp);
 928:	8526                	mv	a0,s1
 92a:	00000097          	auipc	ra,0x0
 92e:	dea080e7          	jalr	-534(ra) # 714 <free>
        return;
 932:	a82d                	j	96c <deleteNode+0xa0>
    }

    if (temp == 0) {
        release(&list_lock);
 934:	00000517          	auipc	a0,0x0
 938:	6d450513          	add	a0,a0,1748 # 1008 <list_lock>
 93c:	00000097          	auipc	ra,0x0
 940:	9ce080e7          	jalr	-1586(ra) # 30a <release>
        return;
 944:	a025                	j	96c <deleteNode+0xa0>
    }
    prev->next = temp->next;
 946:	649c                	ld	a5,8(s1)
 948:	e71c                	sd	a5,8(a4)
    release(&list_lock);
 94a:	00000517          	auipc	a0,0x0
 94e:	6be50513          	add	a0,a0,1726 # 1008 <list_lock>
 952:	00000097          	auipc	ra,0x0
 956:	9b8080e7          	jalr	-1608(ra) # 30a <release>
    rcusync();
 95a:	00000097          	auipc	ra,0x0
 95e:	a7c080e7          	jalr	-1412(ra) # 3d6 <rcusync>
    free(temp);
 962:	8526                	mv	a0,s1
 964:	00000097          	auipc	ra,0x0
 968:	db0080e7          	jalr	-592(ra) # 714 <free>
}
 96c:	70a2                	ld	ra,40(sp)
 96e:	7402                	ld	s0,32(sp)
 970:	64e2                	ld	s1,24(sp)
 972:	6942                	ld	s2,16(sp)
 974:	69a2                	ld	s3,8(sp)
 976:	6145                	add	sp,sp,48
 978:	8082                	ret

000000000000097a <search>:

// Function to search for a node with a given key in the linked list
struct Node* search(struct Node *head, int key) {
 97a:	1101                	add	sp,sp,-32
 97c:	ec06                	sd	ra,24(sp)
 97e:	e822                	sd	s0,16(sp)
 980:	e426                	sd	s1,8(sp)
 982:	e04a                	sd	s2,0(sp)
 984:	1000                	add	s0,sp,32
 986:	84aa                	mv	s1,a0
 988:	892e                	mv	s2,a1

    struct Node *current = head;
    rcureadlock();
 98a:	00000097          	auipc	ra,0x0
 98e:	a3c080e7          	jalr	-1476(ra) # 3c6 <rcureadlock>
    while (current != 0) {
 992:	c491                	beqz	s1,99e <search+0x24>
        if (current->data == key) {
 994:	409c                	lw	a5,0(s1)
 996:	01278f63          	beq	a5,s2,9b4 <search+0x3a>
            rcureadunlock();
            return current; // Node found
        }
        current = current->next;
 99a:	6484                	ld	s1,8(s1)
    while (current != 0) {
 99c:	fce5                	bnez	s1,994 <search+0x1a>
    }
    rcureadunlock();
 99e:	00000097          	auipc	ra,0x0
 9a2:	a30080e7          	jalr	-1488(ra) # 3ce <rcureadunlock>
    return 0; // Node not found
 9a6:	4501                	li	a0,0
}
 9a8:	60e2                	ld	ra,24(sp)
 9aa:	6442                	ld	s0,16(sp)
 9ac:	64a2                	ld	s1,8(sp)
 9ae:	6902                	ld	s2,0(sp)
 9b0:	6105                	add	sp,sp,32
 9b2:	8082                	ret
            rcureadunlock();
 9b4:	00000097          	auipc	ra,0x0
 9b8:	a1a080e7          	jalr	-1510(ra) # 3ce <rcureadunlock>
            return current; // Node found
 9bc:	8526                	mv	a0,s1
 9be:	b7ed                	j	9a8 <search+0x2e>

00000000000009c0 <updateNode>:

// Function to update the value of a node with a given key in the linked list
void updateNode(struct Node *head, int key, int new_data) {
 9c0:	1101                	add	sp,sp,-32
 9c2:	ec06                	sd	ra,24(sp)
 9c4:	e822                	sd	s0,16(sp)
 9c6:	e426                	sd	s1,8(sp)
 9c8:	e04a                	sd	s2,0(sp)
 9ca:	1000                	add	s0,sp,32
 9cc:	892e                	mv	s2,a1
 9ce:	84b2                	mv	s1,a2
    struct Node *nodeToUpdate = search(head, key);
 9d0:	00000097          	auipc	ra,0x0
 9d4:	faa080e7          	jalr	-86(ra) # 97a <search>

    if (nodeToUpdate != 0) {
 9d8:	c901                	beqz	a0,9e8 <updateNode+0x28>
        nodeToUpdate->data = new_data; // Update the node's data
 9da:	c104                	sw	s1,0(a0)
    } else {
        printf("Node with key %d not found.\n", key);
    }
}
 9dc:	60e2                	ld	ra,24(sp)
 9de:	6442                	ld	s0,16(sp)
 9e0:	64a2                	ld	s1,8(sp)
 9e2:	6902                	ld	s2,0(sp)
 9e4:	6105                	add	sp,sp,32
 9e6:	8082                	ret
        printf("Node with key %d not found.\n", key);
 9e8:	85ca                	mv	a1,s2
 9ea:	00000517          	auipc	a0,0x0
 9ee:	0a650513          	add	a0,a0,166 # a90 <digits+0x18>
 9f2:	00000097          	auipc	ra,0x0
 9f6:	cec080e7          	jalr	-788(ra) # 6de <printf>
}
 9fa:	b7cd                	j	9dc <updateNode+0x1c>
