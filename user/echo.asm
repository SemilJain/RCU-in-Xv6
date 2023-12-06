
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7139                	add	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	0080                	add	s0,sp,64
  int i;

  for(i = 1; i < argc; i++){
  12:	4785                	li	a5,1
  14:	06a7d863          	bge	a5,a0,84 <main+0x84>
  18:	00858493          	add	s1,a1,8
  1c:	3579                	addw	a0,a0,-2
  1e:	02051793          	sll	a5,a0,0x20
  22:	01d7d513          	srl	a0,a5,0x1d
  26:	00a48a33          	add	s4,s1,a0
  2a:	05c1                	add	a1,a1,16
  2c:	00a589b3          	add	s3,a1,a0
    write(1, argv[i], strlen(argv[i]));
    if(i + 1 < argc){
      write(1, " ", 1);
  30:	00001a97          	auipc	s5,0x1
  34:	a00a8a93          	add	s5,s5,-1536 # a30 <updateNode+0x46>
  38:	a819                	j	4e <main+0x4e>
  3a:	4605                	li	a2,1
  3c:	85d6                	mv	a1,s5
  3e:	4505                	li	a0,1
  40:	00000097          	auipc	ra,0x0
  44:	330080e7          	jalr	816(ra) # 370 <write>
  for(i = 1; i < argc; i++){
  48:	04a1                	add	s1,s1,8
  4a:	03348d63          	beq	s1,s3,84 <main+0x84>
    write(1, argv[i], strlen(argv[i]));
  4e:	0004b903          	ld	s2,0(s1)
  52:	854a                	mv	a0,s2
  54:	00000097          	auipc	ra,0x0
  58:	09c080e7          	jalr	156(ra) # f0 <strlen>
  5c:	0005061b          	sext.w	a2,a0
  60:	85ca                	mv	a1,s2
  62:	4505                	li	a0,1
  64:	00000097          	auipc	ra,0x0
  68:	30c080e7          	jalr	780(ra) # 370 <write>
    if(i + 1 < argc){
  6c:	fd4497e3          	bne	s1,s4,3a <main+0x3a>
    } else {
      write(1, "\n", 1);
  70:	4605                	li	a2,1
  72:	00001597          	auipc	a1,0x1
  76:	9c658593          	add	a1,a1,-1594 # a38 <updateNode+0x4e>
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	2f4080e7          	jalr	756(ra) # 370 <write>
    }
  }
  exit(0);
  84:	4501                	li	a0,0
  86:	00000097          	auipc	ra,0x0
  8a:	2ca080e7          	jalr	714(ra) # 350 <exit>

000000000000008e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  8e:	1141                	add	sp,sp,-16
  90:	e406                	sd	ra,8(sp)
  92:	e022                	sd	s0,0(sp)
  94:	0800                	add	s0,sp,16
  extern int main();
  main();
  96:	00000097          	auipc	ra,0x0
  9a:	f6a080e7          	jalr	-150(ra) # 0 <main>
  exit(0);
  9e:	4501                	li	a0,0
  a0:	00000097          	auipc	ra,0x0
  a4:	2b0080e7          	jalr	688(ra) # 350 <exit>

00000000000000a8 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  a8:	1141                	add	sp,sp,-16
  aa:	e422                	sd	s0,8(sp)
  ac:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  ae:	87aa                	mv	a5,a0
  b0:	0585                	add	a1,a1,1
  b2:	0785                	add	a5,a5,1
  b4:	fff5c703          	lbu	a4,-1(a1)
  b8:	fee78fa3          	sb	a4,-1(a5)
  bc:	fb75                	bnez	a4,b0 <strcpy+0x8>
    ;
  return os;
}
  be:	6422                	ld	s0,8(sp)
  c0:	0141                	add	sp,sp,16
  c2:	8082                	ret

00000000000000c4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c4:	1141                	add	sp,sp,-16
  c6:	e422                	sd	s0,8(sp)
  c8:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  ca:	00054783          	lbu	a5,0(a0)
  ce:	cb91                	beqz	a5,e2 <strcmp+0x1e>
  d0:	0005c703          	lbu	a4,0(a1)
  d4:	00f71763          	bne	a4,a5,e2 <strcmp+0x1e>
    p++, q++;
  d8:	0505                	add	a0,a0,1
  da:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  dc:	00054783          	lbu	a5,0(a0)
  e0:	fbe5                	bnez	a5,d0 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  e2:	0005c503          	lbu	a0,0(a1)
}
  e6:	40a7853b          	subw	a0,a5,a0
  ea:	6422                	ld	s0,8(sp)
  ec:	0141                	add	sp,sp,16
  ee:	8082                	ret

00000000000000f0 <strlen>:

uint
strlen(const char *s)
{
  f0:	1141                	add	sp,sp,-16
  f2:	e422                	sd	s0,8(sp)
  f4:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  f6:	00054783          	lbu	a5,0(a0)
  fa:	cf91                	beqz	a5,116 <strlen+0x26>
  fc:	0505                	add	a0,a0,1
  fe:	87aa                	mv	a5,a0
 100:	86be                	mv	a3,a5
 102:	0785                	add	a5,a5,1
 104:	fff7c703          	lbu	a4,-1(a5)
 108:	ff65                	bnez	a4,100 <strlen+0x10>
 10a:	40a6853b          	subw	a0,a3,a0
 10e:	2505                	addw	a0,a0,1
    ;
  return n;
}
 110:	6422                	ld	s0,8(sp)
 112:	0141                	add	sp,sp,16
 114:	8082                	ret
  for(n = 0; s[n]; n++)
 116:	4501                	li	a0,0
 118:	bfe5                	j	110 <strlen+0x20>

000000000000011a <memset>:

void*
memset(void *dst, int c, uint n)
{
 11a:	1141                	add	sp,sp,-16
 11c:	e422                	sd	s0,8(sp)
 11e:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 120:	ca19                	beqz	a2,136 <memset+0x1c>
 122:	87aa                	mv	a5,a0
 124:	1602                	sll	a2,a2,0x20
 126:	9201                	srl	a2,a2,0x20
 128:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 12c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 130:	0785                	add	a5,a5,1
 132:	fee79de3          	bne	a5,a4,12c <memset+0x12>
  }
  return dst;
}
 136:	6422                	ld	s0,8(sp)
 138:	0141                	add	sp,sp,16
 13a:	8082                	ret

000000000000013c <strchr>:

char*
strchr(const char *s, char c)
{
 13c:	1141                	add	sp,sp,-16
 13e:	e422                	sd	s0,8(sp)
 140:	0800                	add	s0,sp,16
  for(; *s; s++)
 142:	00054783          	lbu	a5,0(a0)
 146:	cb99                	beqz	a5,15c <strchr+0x20>
    if(*s == c)
 148:	00f58763          	beq	a1,a5,156 <strchr+0x1a>
  for(; *s; s++)
 14c:	0505                	add	a0,a0,1
 14e:	00054783          	lbu	a5,0(a0)
 152:	fbfd                	bnez	a5,148 <strchr+0xc>
      return (char*)s;
  return 0;
 154:	4501                	li	a0,0
}
 156:	6422                	ld	s0,8(sp)
 158:	0141                	add	sp,sp,16
 15a:	8082                	ret
  return 0;
 15c:	4501                	li	a0,0
 15e:	bfe5                	j	156 <strchr+0x1a>

0000000000000160 <gets>:

char*
gets(char *buf, int max)
{
 160:	711d                	add	sp,sp,-96
 162:	ec86                	sd	ra,88(sp)
 164:	e8a2                	sd	s0,80(sp)
 166:	e4a6                	sd	s1,72(sp)
 168:	e0ca                	sd	s2,64(sp)
 16a:	fc4e                	sd	s3,56(sp)
 16c:	f852                	sd	s4,48(sp)
 16e:	f456                	sd	s5,40(sp)
 170:	f05a                	sd	s6,32(sp)
 172:	ec5e                	sd	s7,24(sp)
 174:	1080                	add	s0,sp,96
 176:	8baa                	mv	s7,a0
 178:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 17a:	892a                	mv	s2,a0
 17c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 17e:	4aa9                	li	s5,10
 180:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 182:	89a6                	mv	s3,s1
 184:	2485                	addw	s1,s1,1
 186:	0344d863          	bge	s1,s4,1b6 <gets+0x56>
    cc = read(0, &c, 1);
 18a:	4605                	li	a2,1
 18c:	faf40593          	add	a1,s0,-81
 190:	4501                	li	a0,0
 192:	00000097          	auipc	ra,0x0
 196:	1d6080e7          	jalr	470(ra) # 368 <read>
    if(cc < 1)
 19a:	00a05e63          	blez	a0,1b6 <gets+0x56>
    buf[i++] = c;
 19e:	faf44783          	lbu	a5,-81(s0)
 1a2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1a6:	01578763          	beq	a5,s5,1b4 <gets+0x54>
 1aa:	0905                	add	s2,s2,1
 1ac:	fd679be3          	bne	a5,s6,182 <gets+0x22>
  for(i=0; i+1 < max; ){
 1b0:	89a6                	mv	s3,s1
 1b2:	a011                	j	1b6 <gets+0x56>
 1b4:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1b6:	99de                	add	s3,s3,s7
 1b8:	00098023          	sb	zero,0(s3)
  return buf;
}
 1bc:	855e                	mv	a0,s7
 1be:	60e6                	ld	ra,88(sp)
 1c0:	6446                	ld	s0,80(sp)
 1c2:	64a6                	ld	s1,72(sp)
 1c4:	6906                	ld	s2,64(sp)
 1c6:	79e2                	ld	s3,56(sp)
 1c8:	7a42                	ld	s4,48(sp)
 1ca:	7aa2                	ld	s5,40(sp)
 1cc:	7b02                	ld	s6,32(sp)
 1ce:	6be2                	ld	s7,24(sp)
 1d0:	6125                	add	sp,sp,96
 1d2:	8082                	ret

00000000000001d4 <stat>:

int
stat(const char *n, struct stat *st)
{
 1d4:	1101                	add	sp,sp,-32
 1d6:	ec06                	sd	ra,24(sp)
 1d8:	e822                	sd	s0,16(sp)
 1da:	e426                	sd	s1,8(sp)
 1dc:	e04a                	sd	s2,0(sp)
 1de:	1000                	add	s0,sp,32
 1e0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e2:	4581                	li	a1,0
 1e4:	00000097          	auipc	ra,0x0
 1e8:	1ac080e7          	jalr	428(ra) # 390 <open>
  if(fd < 0)
 1ec:	02054563          	bltz	a0,216 <stat+0x42>
 1f0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1f2:	85ca                	mv	a1,s2
 1f4:	00000097          	auipc	ra,0x0
 1f8:	1b4080e7          	jalr	436(ra) # 3a8 <fstat>
 1fc:	892a                	mv	s2,a0
  close(fd);
 1fe:	8526                	mv	a0,s1
 200:	00000097          	auipc	ra,0x0
 204:	178080e7          	jalr	376(ra) # 378 <close>
  return r;
}
 208:	854a                	mv	a0,s2
 20a:	60e2                	ld	ra,24(sp)
 20c:	6442                	ld	s0,16(sp)
 20e:	64a2                	ld	s1,8(sp)
 210:	6902                	ld	s2,0(sp)
 212:	6105                	add	sp,sp,32
 214:	8082                	ret
    return -1;
 216:	597d                	li	s2,-1
 218:	bfc5                	j	208 <stat+0x34>

000000000000021a <atoi>:

int
atoi(const char *s)
{
 21a:	1141                	add	sp,sp,-16
 21c:	e422                	sd	s0,8(sp)
 21e:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 220:	00054683          	lbu	a3,0(a0)
 224:	fd06879b          	addw	a5,a3,-48
 228:	0ff7f793          	zext.b	a5,a5
 22c:	4625                	li	a2,9
 22e:	02f66863          	bltu	a2,a5,25e <atoi+0x44>
 232:	872a                	mv	a4,a0
  n = 0;
 234:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 236:	0705                	add	a4,a4,1
 238:	0025179b          	sllw	a5,a0,0x2
 23c:	9fa9                	addw	a5,a5,a0
 23e:	0017979b          	sllw	a5,a5,0x1
 242:	9fb5                	addw	a5,a5,a3
 244:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 248:	00074683          	lbu	a3,0(a4)
 24c:	fd06879b          	addw	a5,a3,-48
 250:	0ff7f793          	zext.b	a5,a5
 254:	fef671e3          	bgeu	a2,a5,236 <atoi+0x1c>
  return n;
}
 258:	6422                	ld	s0,8(sp)
 25a:	0141                	add	sp,sp,16
 25c:	8082                	ret
  n = 0;
 25e:	4501                	li	a0,0
 260:	bfe5                	j	258 <atoi+0x3e>

0000000000000262 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 262:	1141                	add	sp,sp,-16
 264:	e422                	sd	s0,8(sp)
 266:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 268:	02b57463          	bgeu	a0,a1,290 <memmove+0x2e>
    while(n-- > 0)
 26c:	00c05f63          	blez	a2,28a <memmove+0x28>
 270:	1602                	sll	a2,a2,0x20
 272:	9201                	srl	a2,a2,0x20
 274:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 278:	872a                	mv	a4,a0
      *dst++ = *src++;
 27a:	0585                	add	a1,a1,1
 27c:	0705                	add	a4,a4,1
 27e:	fff5c683          	lbu	a3,-1(a1)
 282:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 286:	fee79ae3          	bne	a5,a4,27a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 28a:	6422                	ld	s0,8(sp)
 28c:	0141                	add	sp,sp,16
 28e:	8082                	ret
    dst += n;
 290:	00c50733          	add	a4,a0,a2
    src += n;
 294:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 296:	fec05ae3          	blez	a2,28a <memmove+0x28>
 29a:	fff6079b          	addw	a5,a2,-1
 29e:	1782                	sll	a5,a5,0x20
 2a0:	9381                	srl	a5,a5,0x20
 2a2:	fff7c793          	not	a5,a5
 2a6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2a8:	15fd                	add	a1,a1,-1
 2aa:	177d                	add	a4,a4,-1
 2ac:	0005c683          	lbu	a3,0(a1)
 2b0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2b4:	fee79ae3          	bne	a5,a4,2a8 <memmove+0x46>
 2b8:	bfc9                	j	28a <memmove+0x28>

00000000000002ba <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2ba:	1141                	add	sp,sp,-16
 2bc:	e422                	sd	s0,8(sp)
 2be:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2c0:	ca05                	beqz	a2,2f0 <memcmp+0x36>
 2c2:	fff6069b          	addw	a3,a2,-1
 2c6:	1682                	sll	a3,a3,0x20
 2c8:	9281                	srl	a3,a3,0x20
 2ca:	0685                	add	a3,a3,1
 2cc:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2ce:	00054783          	lbu	a5,0(a0)
 2d2:	0005c703          	lbu	a4,0(a1)
 2d6:	00e79863          	bne	a5,a4,2e6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2da:	0505                	add	a0,a0,1
    p2++;
 2dc:	0585                	add	a1,a1,1
  while (n-- > 0) {
 2de:	fed518e3          	bne	a0,a3,2ce <memcmp+0x14>
  }
  return 0;
 2e2:	4501                	li	a0,0
 2e4:	a019                	j	2ea <memcmp+0x30>
      return *p1 - *p2;
 2e6:	40e7853b          	subw	a0,a5,a4
}
 2ea:	6422                	ld	s0,8(sp)
 2ec:	0141                	add	sp,sp,16
 2ee:	8082                	ret
  return 0;
 2f0:	4501                	li	a0,0
 2f2:	bfe5                	j	2ea <memcmp+0x30>

00000000000002f4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2f4:	1141                	add	sp,sp,-16
 2f6:	e406                	sd	ra,8(sp)
 2f8:	e022                	sd	s0,0(sp)
 2fa:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 2fc:	00000097          	auipc	ra,0x0
 300:	f66080e7          	jalr	-154(ra) # 262 <memmove>
}
 304:	60a2                	ld	ra,8(sp)
 306:	6402                	ld	s0,0(sp)
 308:	0141                	add	sp,sp,16
 30a:	8082                	ret

000000000000030c <initlock>:

// Initialize the spinlock
void initlock(struct spinlock_u *lk) {
 30c:	1141                	add	sp,sp,-16
 30e:	e422                	sd	s0,8(sp)
 310:	0800                	add	s0,sp,16
  lk->locked = 0;
 312:	00052023          	sw	zero,0(a0)
}
 316:	6422                	ld	s0,8(sp)
 318:	0141                	add	sp,sp,16
 31a:	8082                	ret

000000000000031c <acquire>:

// Acquire the spinlock
void acquire(struct spinlock_u *lk) {
 31c:	1141                	add	sp,sp,-16
 31e:	e422                	sd	s0,8(sp)
 320:	0800                	add	s0,sp,16
  while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 322:	4705                	li	a4,1
 324:	87ba                	mv	a5,a4
 326:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
 32a:	2781                	sext.w	a5,a5
 32c:	ffe5                	bnez	a5,324 <acquire+0x8>
    ; // Spin until the lock is acquired
}
 32e:	6422                	ld	s0,8(sp)
 330:	0141                	add	sp,sp,16
 332:	8082                	ret

0000000000000334 <release>:

// Release the spinlock
void release(struct spinlock_u *lk) {
 334:	1141                	add	sp,sp,-16
 336:	e422                	sd	s0,8(sp)
 338:	0800                	add	s0,sp,16
  __sync_lock_release(&lk->locked);
 33a:	0f50000f          	fence	iorw,ow
 33e:	0805202f          	amoswap.w	zero,zero,(a0)
}
 342:	6422                	ld	s0,8(sp)
 344:	0141                	add	sp,sp,16
 346:	8082                	ret

0000000000000348 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 348:	4885                	li	a7,1
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <exit>:
.global exit
exit:
 li a7, SYS_exit
 350:	4889                	li	a7,2
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <wait>:
.global wait
wait:
 li a7, SYS_wait
 358:	488d                	li	a7,3
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 360:	4891                	li	a7,4
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <read>:
.global read
read:
 li a7, SYS_read
 368:	4895                	li	a7,5
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <write>:
.global write
write:
 li a7, SYS_write
 370:	48c1                	li	a7,16
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <close>:
.global close
close:
 li a7, SYS_close
 378:	48d5                	li	a7,21
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <kill>:
.global kill
kill:
 li a7, SYS_kill
 380:	4899                	li	a7,6
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <exec>:
.global exec
exec:
 li a7, SYS_exec
 388:	489d                	li	a7,7
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <open>:
.global open
open:
 li a7, SYS_open
 390:	48bd                	li	a7,15
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 398:	48c5                	li	a7,17
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3a0:	48c9                	li	a7,18
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3a8:	48a1                	li	a7,8
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <link>:
.global link
link:
 li a7, SYS_link
 3b0:	48cd                	li	a7,19
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3b8:	48d1                	li	a7,20
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3c0:	48a5                	li	a7,9
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3c8:	48a9                	li	a7,10
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3d0:	48ad                	li	a7,11
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3d8:	48b1                	li	a7,12
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3e0:	48b5                	li	a7,13
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3e8:	48b9                	li	a7,14
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <rcureadlock>:
.global rcureadlock
rcureadlock:
 li a7, SYS_rcureadlock
 3f0:	48dd                	li	a7,23
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <rcureadunlock>:
.global rcureadunlock
rcureadunlock:
 li a7, SYS_rcureadunlock
 3f8:	48e1                	li	a7,24
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <rcusync>:
.global rcusync
rcusync:
 li a7, SYS_rcusync
 400:	48d9                	li	a7,22
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <thread_create>:
.global thread_create
thread_create:
 li a7, SYS_thread_create
 408:	48e5                	li	a7,25
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <thread_join>:
.global thread_join
thread_join:
 li a7, SYS_thread_join
 410:	48e9                	li	a7,26
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <thread_exit>:
.global thread_exit
thread_exit:
 li a7, SYS_thread_exit
 418:	48ed                	li	a7,27
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <klist_insert>:
.global klist_insert
klist_insert:
 li a7, SYS_klist_insert
 420:	48f1                	li	a7,28
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <klist_delete>:
.global klist_delete
klist_delete:
 li a7, SYS_klist_delete
 428:	48f5                	li	a7,29
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <klist_query>:
.global klist_query
klist_query:
 li a7, SYS_klist_query
 430:	48f9                	li	a7,30
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <klist_print>:
.global klist_print
klist_print:
 li a7, SYS_klist_print
 438:	48fd                	li	a7,31
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 440:	1101                	add	sp,sp,-32
 442:	ec06                	sd	ra,24(sp)
 444:	e822                	sd	s0,16(sp)
 446:	1000                	add	s0,sp,32
 448:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 44c:	4605                	li	a2,1
 44e:	fef40593          	add	a1,s0,-17
 452:	00000097          	auipc	ra,0x0
 456:	f1e080e7          	jalr	-226(ra) # 370 <write>
}
 45a:	60e2                	ld	ra,24(sp)
 45c:	6442                	ld	s0,16(sp)
 45e:	6105                	add	sp,sp,32
 460:	8082                	ret

0000000000000462 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 462:	7139                	add	sp,sp,-64
 464:	fc06                	sd	ra,56(sp)
 466:	f822                	sd	s0,48(sp)
 468:	f426                	sd	s1,40(sp)
 46a:	f04a                	sd	s2,32(sp)
 46c:	ec4e                	sd	s3,24(sp)
 46e:	0080                	add	s0,sp,64
 470:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 472:	c299                	beqz	a3,478 <printint+0x16>
 474:	0805c963          	bltz	a1,506 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 478:	2581                	sext.w	a1,a1
  neg = 0;
 47a:	4881                	li	a7,0
 47c:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 480:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 482:	2601                	sext.w	a2,a2
 484:	00000517          	auipc	a0,0x0
 488:	61c50513          	add	a0,a0,1564 # aa0 <digits>
 48c:	883a                	mv	a6,a4
 48e:	2705                	addw	a4,a4,1
 490:	02c5f7bb          	remuw	a5,a1,a2
 494:	1782                	sll	a5,a5,0x20
 496:	9381                	srl	a5,a5,0x20
 498:	97aa                	add	a5,a5,a0
 49a:	0007c783          	lbu	a5,0(a5)
 49e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4a2:	0005879b          	sext.w	a5,a1
 4a6:	02c5d5bb          	divuw	a1,a1,a2
 4aa:	0685                	add	a3,a3,1
 4ac:	fec7f0e3          	bgeu	a5,a2,48c <printint+0x2a>
  if(neg)
 4b0:	00088c63          	beqz	a7,4c8 <printint+0x66>
    buf[i++] = '-';
 4b4:	fd070793          	add	a5,a4,-48
 4b8:	00878733          	add	a4,a5,s0
 4bc:	02d00793          	li	a5,45
 4c0:	fef70823          	sb	a5,-16(a4)
 4c4:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 4c8:	02e05863          	blez	a4,4f8 <printint+0x96>
 4cc:	fc040793          	add	a5,s0,-64
 4d0:	00e78933          	add	s2,a5,a4
 4d4:	fff78993          	add	s3,a5,-1
 4d8:	99ba                	add	s3,s3,a4
 4da:	377d                	addw	a4,a4,-1
 4dc:	1702                	sll	a4,a4,0x20
 4de:	9301                	srl	a4,a4,0x20
 4e0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4e4:	fff94583          	lbu	a1,-1(s2)
 4e8:	8526                	mv	a0,s1
 4ea:	00000097          	auipc	ra,0x0
 4ee:	f56080e7          	jalr	-170(ra) # 440 <putc>
  while(--i >= 0)
 4f2:	197d                	add	s2,s2,-1
 4f4:	ff3918e3          	bne	s2,s3,4e4 <printint+0x82>
}
 4f8:	70e2                	ld	ra,56(sp)
 4fa:	7442                	ld	s0,48(sp)
 4fc:	74a2                	ld	s1,40(sp)
 4fe:	7902                	ld	s2,32(sp)
 500:	69e2                	ld	s3,24(sp)
 502:	6121                	add	sp,sp,64
 504:	8082                	ret
    x = -xx;
 506:	40b005bb          	negw	a1,a1
    neg = 1;
 50a:	4885                	li	a7,1
    x = -xx;
 50c:	bf85                	j	47c <printint+0x1a>

000000000000050e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 50e:	715d                	add	sp,sp,-80
 510:	e486                	sd	ra,72(sp)
 512:	e0a2                	sd	s0,64(sp)
 514:	fc26                	sd	s1,56(sp)
 516:	f84a                	sd	s2,48(sp)
 518:	f44e                	sd	s3,40(sp)
 51a:	f052                	sd	s4,32(sp)
 51c:	ec56                	sd	s5,24(sp)
 51e:	e85a                	sd	s6,16(sp)
 520:	e45e                	sd	s7,8(sp)
 522:	e062                	sd	s8,0(sp)
 524:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 526:	0005c903          	lbu	s2,0(a1)
 52a:	18090c63          	beqz	s2,6c2 <vprintf+0x1b4>
 52e:	8aaa                	mv	s5,a0
 530:	8bb2                	mv	s7,a2
 532:	00158493          	add	s1,a1,1
  state = 0;
 536:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 538:	02500a13          	li	s4,37
 53c:	4b55                	li	s6,21
 53e:	a839                	j	55c <vprintf+0x4e>
        putc(fd, c);
 540:	85ca                	mv	a1,s2
 542:	8556                	mv	a0,s5
 544:	00000097          	auipc	ra,0x0
 548:	efc080e7          	jalr	-260(ra) # 440 <putc>
 54c:	a019                	j	552 <vprintf+0x44>
    } else if(state == '%'){
 54e:	01498d63          	beq	s3,s4,568 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 552:	0485                	add	s1,s1,1
 554:	fff4c903          	lbu	s2,-1(s1)
 558:	16090563          	beqz	s2,6c2 <vprintf+0x1b4>
    if(state == 0){
 55c:	fe0999e3          	bnez	s3,54e <vprintf+0x40>
      if(c == '%'){
 560:	ff4910e3          	bne	s2,s4,540 <vprintf+0x32>
        state = '%';
 564:	89d2                	mv	s3,s4
 566:	b7f5                	j	552 <vprintf+0x44>
      if(c == 'd'){
 568:	13490263          	beq	s2,s4,68c <vprintf+0x17e>
 56c:	f9d9079b          	addw	a5,s2,-99
 570:	0ff7f793          	zext.b	a5,a5
 574:	12fb6563          	bltu	s6,a5,69e <vprintf+0x190>
 578:	f9d9079b          	addw	a5,s2,-99
 57c:	0ff7f713          	zext.b	a4,a5
 580:	10eb6f63          	bltu	s6,a4,69e <vprintf+0x190>
 584:	00271793          	sll	a5,a4,0x2
 588:	00000717          	auipc	a4,0x0
 58c:	4c070713          	add	a4,a4,1216 # a48 <updateNode+0x5e>
 590:	97ba                	add	a5,a5,a4
 592:	439c                	lw	a5,0(a5)
 594:	97ba                	add	a5,a5,a4
 596:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 598:	008b8913          	add	s2,s7,8
 59c:	4685                	li	a3,1
 59e:	4629                	li	a2,10
 5a0:	000ba583          	lw	a1,0(s7)
 5a4:	8556                	mv	a0,s5
 5a6:	00000097          	auipc	ra,0x0
 5aa:	ebc080e7          	jalr	-324(ra) # 462 <printint>
 5ae:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5b0:	4981                	li	s3,0
 5b2:	b745                	j	552 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5b4:	008b8913          	add	s2,s7,8
 5b8:	4681                	li	a3,0
 5ba:	4629                	li	a2,10
 5bc:	000ba583          	lw	a1,0(s7)
 5c0:	8556                	mv	a0,s5
 5c2:	00000097          	auipc	ra,0x0
 5c6:	ea0080e7          	jalr	-352(ra) # 462 <printint>
 5ca:	8bca                	mv	s7,s2
      state = 0;
 5cc:	4981                	li	s3,0
 5ce:	b751                	j	552 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 5d0:	008b8913          	add	s2,s7,8
 5d4:	4681                	li	a3,0
 5d6:	4641                	li	a2,16
 5d8:	000ba583          	lw	a1,0(s7)
 5dc:	8556                	mv	a0,s5
 5de:	00000097          	auipc	ra,0x0
 5e2:	e84080e7          	jalr	-380(ra) # 462 <printint>
 5e6:	8bca                	mv	s7,s2
      state = 0;
 5e8:	4981                	li	s3,0
 5ea:	b7a5                	j	552 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 5ec:	008b8c13          	add	s8,s7,8
 5f0:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 5f4:	03000593          	li	a1,48
 5f8:	8556                	mv	a0,s5
 5fa:	00000097          	auipc	ra,0x0
 5fe:	e46080e7          	jalr	-442(ra) # 440 <putc>
  putc(fd, 'x');
 602:	07800593          	li	a1,120
 606:	8556                	mv	a0,s5
 608:	00000097          	auipc	ra,0x0
 60c:	e38080e7          	jalr	-456(ra) # 440 <putc>
 610:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 612:	00000b97          	auipc	s7,0x0
 616:	48eb8b93          	add	s7,s7,1166 # aa0 <digits>
 61a:	03c9d793          	srl	a5,s3,0x3c
 61e:	97de                	add	a5,a5,s7
 620:	0007c583          	lbu	a1,0(a5)
 624:	8556                	mv	a0,s5
 626:	00000097          	auipc	ra,0x0
 62a:	e1a080e7          	jalr	-486(ra) # 440 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 62e:	0992                	sll	s3,s3,0x4
 630:	397d                	addw	s2,s2,-1
 632:	fe0914e3          	bnez	s2,61a <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 636:	8be2                	mv	s7,s8
      state = 0;
 638:	4981                	li	s3,0
 63a:	bf21                	j	552 <vprintf+0x44>
        s = va_arg(ap, char*);
 63c:	008b8993          	add	s3,s7,8
 640:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 644:	02090163          	beqz	s2,666 <vprintf+0x158>
        while(*s != 0){
 648:	00094583          	lbu	a1,0(s2)
 64c:	c9a5                	beqz	a1,6bc <vprintf+0x1ae>
          putc(fd, *s);
 64e:	8556                	mv	a0,s5
 650:	00000097          	auipc	ra,0x0
 654:	df0080e7          	jalr	-528(ra) # 440 <putc>
          s++;
 658:	0905                	add	s2,s2,1
        while(*s != 0){
 65a:	00094583          	lbu	a1,0(s2)
 65e:	f9e5                	bnez	a1,64e <vprintf+0x140>
        s = va_arg(ap, char*);
 660:	8bce                	mv	s7,s3
      state = 0;
 662:	4981                	li	s3,0
 664:	b5fd                	j	552 <vprintf+0x44>
          s = "(null)";
 666:	00000917          	auipc	s2,0x0
 66a:	3da90913          	add	s2,s2,986 # a40 <updateNode+0x56>
        while(*s != 0){
 66e:	02800593          	li	a1,40
 672:	bff1                	j	64e <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 674:	008b8913          	add	s2,s7,8
 678:	000bc583          	lbu	a1,0(s7)
 67c:	8556                	mv	a0,s5
 67e:	00000097          	auipc	ra,0x0
 682:	dc2080e7          	jalr	-574(ra) # 440 <putc>
 686:	8bca                	mv	s7,s2
      state = 0;
 688:	4981                	li	s3,0
 68a:	b5e1                	j	552 <vprintf+0x44>
        putc(fd, c);
 68c:	02500593          	li	a1,37
 690:	8556                	mv	a0,s5
 692:	00000097          	auipc	ra,0x0
 696:	dae080e7          	jalr	-594(ra) # 440 <putc>
      state = 0;
 69a:	4981                	li	s3,0
 69c:	bd5d                	j	552 <vprintf+0x44>
        putc(fd, '%');
 69e:	02500593          	li	a1,37
 6a2:	8556                	mv	a0,s5
 6a4:	00000097          	auipc	ra,0x0
 6a8:	d9c080e7          	jalr	-612(ra) # 440 <putc>
        putc(fd, c);
 6ac:	85ca                	mv	a1,s2
 6ae:	8556                	mv	a0,s5
 6b0:	00000097          	auipc	ra,0x0
 6b4:	d90080e7          	jalr	-624(ra) # 440 <putc>
      state = 0;
 6b8:	4981                	li	s3,0
 6ba:	bd61                	j	552 <vprintf+0x44>
        s = va_arg(ap, char*);
 6bc:	8bce                	mv	s7,s3
      state = 0;
 6be:	4981                	li	s3,0
 6c0:	bd49                	j	552 <vprintf+0x44>
    }
  }
}
 6c2:	60a6                	ld	ra,72(sp)
 6c4:	6406                	ld	s0,64(sp)
 6c6:	74e2                	ld	s1,56(sp)
 6c8:	7942                	ld	s2,48(sp)
 6ca:	79a2                	ld	s3,40(sp)
 6cc:	7a02                	ld	s4,32(sp)
 6ce:	6ae2                	ld	s5,24(sp)
 6d0:	6b42                	ld	s6,16(sp)
 6d2:	6ba2                	ld	s7,8(sp)
 6d4:	6c02                	ld	s8,0(sp)
 6d6:	6161                	add	sp,sp,80
 6d8:	8082                	ret

00000000000006da <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6da:	715d                	add	sp,sp,-80
 6dc:	ec06                	sd	ra,24(sp)
 6de:	e822                	sd	s0,16(sp)
 6e0:	1000                	add	s0,sp,32
 6e2:	e010                	sd	a2,0(s0)
 6e4:	e414                	sd	a3,8(s0)
 6e6:	e818                	sd	a4,16(s0)
 6e8:	ec1c                	sd	a5,24(s0)
 6ea:	03043023          	sd	a6,32(s0)
 6ee:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6f2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6f6:	8622                	mv	a2,s0
 6f8:	00000097          	auipc	ra,0x0
 6fc:	e16080e7          	jalr	-490(ra) # 50e <vprintf>
}
 700:	60e2                	ld	ra,24(sp)
 702:	6442                	ld	s0,16(sp)
 704:	6161                	add	sp,sp,80
 706:	8082                	ret

0000000000000708 <printf>:

void
printf(const char *fmt, ...)
{
 708:	711d                	add	sp,sp,-96
 70a:	ec06                	sd	ra,24(sp)
 70c:	e822                	sd	s0,16(sp)
 70e:	1000                	add	s0,sp,32
 710:	e40c                	sd	a1,8(s0)
 712:	e810                	sd	a2,16(s0)
 714:	ec14                	sd	a3,24(s0)
 716:	f018                	sd	a4,32(s0)
 718:	f41c                	sd	a5,40(s0)
 71a:	03043823          	sd	a6,48(s0)
 71e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 722:	00840613          	add	a2,s0,8
 726:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 72a:	85aa                	mv	a1,a0
 72c:	4505                	li	a0,1
 72e:	00000097          	auipc	ra,0x0
 732:	de0080e7          	jalr	-544(ra) # 50e <vprintf>
}
 736:	60e2                	ld	ra,24(sp)
 738:	6442                	ld	s0,16(sp)
 73a:	6125                	add	sp,sp,96
 73c:	8082                	ret

000000000000073e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 73e:	1141                	add	sp,sp,-16
 740:	e422                	sd	s0,8(sp)
 742:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 744:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 748:	00001797          	auipc	a5,0x1
 74c:	8b87b783          	ld	a5,-1864(a5) # 1000 <freep>
 750:	a02d                	j	77a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 752:	4618                	lw	a4,8(a2)
 754:	9f2d                	addw	a4,a4,a1
 756:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 75a:	6398                	ld	a4,0(a5)
 75c:	6310                	ld	a2,0(a4)
 75e:	a83d                	j	79c <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 760:	ff852703          	lw	a4,-8(a0)
 764:	9f31                	addw	a4,a4,a2
 766:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 768:	ff053683          	ld	a3,-16(a0)
 76c:	a091                	j	7b0 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 76e:	6398                	ld	a4,0(a5)
 770:	00e7e463          	bltu	a5,a4,778 <free+0x3a>
 774:	00e6ea63          	bltu	a3,a4,788 <free+0x4a>
{
 778:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 77a:	fed7fae3          	bgeu	a5,a3,76e <free+0x30>
 77e:	6398                	ld	a4,0(a5)
 780:	00e6e463          	bltu	a3,a4,788 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 784:	fee7eae3          	bltu	a5,a4,778 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 788:	ff852583          	lw	a1,-8(a0)
 78c:	6390                	ld	a2,0(a5)
 78e:	02059813          	sll	a6,a1,0x20
 792:	01c85713          	srl	a4,a6,0x1c
 796:	9736                	add	a4,a4,a3
 798:	fae60de3          	beq	a2,a4,752 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 79c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7a0:	4790                	lw	a2,8(a5)
 7a2:	02061593          	sll	a1,a2,0x20
 7a6:	01c5d713          	srl	a4,a1,0x1c
 7aa:	973e                	add	a4,a4,a5
 7ac:	fae68ae3          	beq	a3,a4,760 <free+0x22>
    p->s.ptr = bp->s.ptr;
 7b0:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7b2:	00001717          	auipc	a4,0x1
 7b6:	84f73723          	sd	a5,-1970(a4) # 1000 <freep>
}
 7ba:	6422                	ld	s0,8(sp)
 7bc:	0141                	add	sp,sp,16
 7be:	8082                	ret

00000000000007c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7c0:	7139                	add	sp,sp,-64
 7c2:	fc06                	sd	ra,56(sp)
 7c4:	f822                	sd	s0,48(sp)
 7c6:	f426                	sd	s1,40(sp)
 7c8:	f04a                	sd	s2,32(sp)
 7ca:	ec4e                	sd	s3,24(sp)
 7cc:	e852                	sd	s4,16(sp)
 7ce:	e456                	sd	s5,8(sp)
 7d0:	e05a                	sd	s6,0(sp)
 7d2:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d4:	02051493          	sll	s1,a0,0x20
 7d8:	9081                	srl	s1,s1,0x20
 7da:	04bd                	add	s1,s1,15
 7dc:	8091                	srl	s1,s1,0x4
 7de:	0014899b          	addw	s3,s1,1
 7e2:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 7e4:	00001517          	auipc	a0,0x1
 7e8:	81c53503          	ld	a0,-2020(a0) # 1000 <freep>
 7ec:	c515                	beqz	a0,818 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ee:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7f0:	4798                	lw	a4,8(a5)
 7f2:	02977f63          	bgeu	a4,s1,830 <malloc+0x70>
  if(nu < 4096)
 7f6:	8a4e                	mv	s4,s3
 7f8:	0009871b          	sext.w	a4,s3
 7fc:	6685                	lui	a3,0x1
 7fe:	00d77363          	bgeu	a4,a3,804 <malloc+0x44>
 802:	6a05                	lui	s4,0x1
 804:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 808:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 80c:	00000917          	auipc	s2,0x0
 810:	7f490913          	add	s2,s2,2036 # 1000 <freep>
  if(p == (char*)-1)
 814:	5afd                	li	s5,-1
 816:	a895                	j	88a <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 818:	00000797          	auipc	a5,0x0
 81c:	7f878793          	add	a5,a5,2040 # 1010 <base>
 820:	00000717          	auipc	a4,0x0
 824:	7ef73023          	sd	a5,2016(a4) # 1000 <freep>
 828:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 82a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 82e:	b7e1                	j	7f6 <malloc+0x36>
      if(p->s.size == nunits)
 830:	02e48c63          	beq	s1,a4,868 <malloc+0xa8>
        p->s.size -= nunits;
 834:	4137073b          	subw	a4,a4,s3
 838:	c798                	sw	a4,8(a5)
        p += p->s.size;
 83a:	02071693          	sll	a3,a4,0x20
 83e:	01c6d713          	srl	a4,a3,0x1c
 842:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 844:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 848:	00000717          	auipc	a4,0x0
 84c:	7aa73c23          	sd	a0,1976(a4) # 1000 <freep>
      return (void*)(p + 1);
 850:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 854:	70e2                	ld	ra,56(sp)
 856:	7442                	ld	s0,48(sp)
 858:	74a2                	ld	s1,40(sp)
 85a:	7902                	ld	s2,32(sp)
 85c:	69e2                	ld	s3,24(sp)
 85e:	6a42                	ld	s4,16(sp)
 860:	6aa2                	ld	s5,8(sp)
 862:	6b02                	ld	s6,0(sp)
 864:	6121                	add	sp,sp,64
 866:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 868:	6398                	ld	a4,0(a5)
 86a:	e118                	sd	a4,0(a0)
 86c:	bff1                	j	848 <malloc+0x88>
  hp->s.size = nu;
 86e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 872:	0541                	add	a0,a0,16
 874:	00000097          	auipc	ra,0x0
 878:	eca080e7          	jalr	-310(ra) # 73e <free>
  return freep;
 87c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 880:	d971                	beqz	a0,854 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 882:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 884:	4798                	lw	a4,8(a5)
 886:	fa9775e3          	bgeu	a4,s1,830 <malloc+0x70>
    if(p == freep)
 88a:	00093703          	ld	a4,0(s2)
 88e:	853e                	mv	a0,a5
 890:	fef719e3          	bne	a4,a5,882 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 894:	8552                	mv	a0,s4
 896:	00000097          	auipc	ra,0x0
 89a:	b42080e7          	jalr	-1214(ra) # 3d8 <sbrk>
  if(p == (char*)-1)
 89e:	fd5518e3          	bne	a0,s5,86e <malloc+0xae>
        return 0;
 8a2:	4501                	li	a0,0
 8a4:	bf45                	j	854 <malloc+0x94>

00000000000008a6 <init_lock>:
#include "linkedlist.h"

// Define a node structure for the linked list
struct spinlock_u list_lock;

void init_lock(){
 8a6:	1141                	add	sp,sp,-16
 8a8:	e406                	sd	ra,8(sp)
 8aa:	e022                	sd	s0,0(sp)
 8ac:	0800                	add	s0,sp,16
    initlock(&list_lock);
 8ae:	00000517          	auipc	a0,0x0
 8b2:	75a50513          	add	a0,a0,1882 # 1008 <list_lock>
 8b6:	00000097          	auipc	ra,0x0
 8ba:	a56080e7          	jalr	-1450(ra) # 30c <initlock>
}
 8be:	60a2                	ld	ra,8(sp)
 8c0:	6402                	ld	s0,0(sp)
 8c2:	0141                	add	sp,sp,16
 8c4:	8082                	ret

00000000000008c6 <insert>:

// Function to insert a node at the beginning of the linked list
void insert(struct Node **head_ref, int new_data) {
 8c6:	1101                	add	sp,sp,-32
 8c8:	ec06                	sd	ra,24(sp)
 8ca:	e822                	sd	s0,16(sp)
 8cc:	e426                	sd	s1,8(sp)
 8ce:	e04a                	sd	s2,0(sp)
 8d0:	1000                	add	s0,sp,32
 8d2:	84aa                	mv	s1,a0
 8d4:	892e                	mv	s2,a1
    struct Node *new_node = malloc(sizeof(struct Node));
 8d6:	4541                	li	a0,16
 8d8:	00000097          	auipc	ra,0x0
 8dc:	ee8080e7          	jalr	-280(ra) # 7c0 <malloc>
    new_node->data = new_data;
 8e0:	01252023          	sw	s2,0(a0)
    new_node->next = *head_ref;
 8e4:	609c                	ld	a5,0(s1)
 8e6:	e51c                	sd	a5,8(a0)
    *head_ref = new_node;
 8e8:	e088                	sd	a0,0(s1)
}
 8ea:	60e2                	ld	ra,24(sp)
 8ec:	6442                	ld	s0,16(sp)
 8ee:	64a2                	ld	s1,8(sp)
 8f0:	6902                	ld	s2,0(sp)
 8f2:	6105                	add	sp,sp,32
 8f4:	8082                	ret

00000000000008f6 <deleteNode>:

// Function to delete a node with a given key from the linked list
void deleteNode(struct Node **head_ref, int key) {
 8f6:	7179                	add	sp,sp,-48
 8f8:	f406                	sd	ra,40(sp)
 8fa:	f022                	sd	s0,32(sp)
 8fc:	ec26                	sd	s1,24(sp)
 8fe:	e84a                	sd	s2,16(sp)
 900:	e44e                	sd	s3,8(sp)
 902:	1800                	add	s0,sp,48
 904:	89aa                	mv	s3,a0
 906:	892e                	mv	s2,a1
    struct Node *temp = *head_ref, *prev = 0;
 908:	6104                	ld	s1,0(a0)

    acquire(&list_lock);
 90a:	00000517          	auipc	a0,0x0
 90e:	6fe50513          	add	a0,a0,1790 # 1008 <list_lock>
 912:	00000097          	auipc	ra,0x0
 916:	a0a080e7          	jalr	-1526(ra) # 31c <acquire>
    if (temp != 0 && temp->data == key) {
 91a:	c0b1                	beqz	s1,95e <deleteNode+0x68>
 91c:	409c                	lw	a5,0(s1)
 91e:	4701                	li	a4,0
 920:	01278a63          	beq	a5,s2,934 <deleteNode+0x3e>
        rcusync();
        free(temp);
        return;
    }

    while (temp != 0 && temp->data != key) {
 924:	409c                	lw	a5,0(s1)
 926:	05278563          	beq	a5,s2,970 <deleteNode+0x7a>
        prev = temp;
        temp = temp->next;
 92a:	649c                	ld	a5,8(s1)
    while (temp != 0 && temp->data != key) {
 92c:	8726                	mv	a4,s1
 92e:	cb85                	beqz	a5,95e <deleteNode+0x68>
        temp = temp->next;
 930:	84be                	mv	s1,a5
 932:	bfcd                	j	924 <deleteNode+0x2e>
        *head_ref = temp->next;
 934:	649c                	ld	a5,8(s1)
 936:	00f9b023          	sd	a5,0(s3)
        release(&list_lock);
 93a:	00000517          	auipc	a0,0x0
 93e:	6ce50513          	add	a0,a0,1742 # 1008 <list_lock>
 942:	00000097          	auipc	ra,0x0
 946:	9f2080e7          	jalr	-1550(ra) # 334 <release>
        rcusync();
 94a:	00000097          	auipc	ra,0x0
 94e:	ab6080e7          	jalr	-1354(ra) # 400 <rcusync>
        free(temp);
 952:	8526                	mv	a0,s1
 954:	00000097          	auipc	ra,0x0
 958:	dea080e7          	jalr	-534(ra) # 73e <free>
        return;
 95c:	a82d                	j	996 <deleteNode+0xa0>
    }

    if (temp == 0) {
        release(&list_lock);
 95e:	00000517          	auipc	a0,0x0
 962:	6aa50513          	add	a0,a0,1706 # 1008 <list_lock>
 966:	00000097          	auipc	ra,0x0
 96a:	9ce080e7          	jalr	-1586(ra) # 334 <release>
        return;
 96e:	a025                	j	996 <deleteNode+0xa0>
    }
    prev->next = temp->next;
 970:	649c                	ld	a5,8(s1)
 972:	e71c                	sd	a5,8(a4)
    release(&list_lock);
 974:	00000517          	auipc	a0,0x0
 978:	69450513          	add	a0,a0,1684 # 1008 <list_lock>
 97c:	00000097          	auipc	ra,0x0
 980:	9b8080e7          	jalr	-1608(ra) # 334 <release>
    rcusync();
 984:	00000097          	auipc	ra,0x0
 988:	a7c080e7          	jalr	-1412(ra) # 400 <rcusync>
    free(temp);
 98c:	8526                	mv	a0,s1
 98e:	00000097          	auipc	ra,0x0
 992:	db0080e7          	jalr	-592(ra) # 73e <free>
}
 996:	70a2                	ld	ra,40(sp)
 998:	7402                	ld	s0,32(sp)
 99a:	64e2                	ld	s1,24(sp)
 99c:	6942                	ld	s2,16(sp)
 99e:	69a2                	ld	s3,8(sp)
 9a0:	6145                	add	sp,sp,48
 9a2:	8082                	ret

00000000000009a4 <search>:

// Function to search for a node with a given key in the linked list
struct Node* search(struct Node *head, int key) {
 9a4:	1101                	add	sp,sp,-32
 9a6:	ec06                	sd	ra,24(sp)
 9a8:	e822                	sd	s0,16(sp)
 9aa:	e426                	sd	s1,8(sp)
 9ac:	e04a                	sd	s2,0(sp)
 9ae:	1000                	add	s0,sp,32
 9b0:	84aa                	mv	s1,a0
 9b2:	892e                	mv	s2,a1

    struct Node *current = head;
    rcureadlock();
 9b4:	00000097          	auipc	ra,0x0
 9b8:	a3c080e7          	jalr	-1476(ra) # 3f0 <rcureadlock>
    while (current != 0) {
 9bc:	c491                	beqz	s1,9c8 <search+0x24>
        if (current->data == key) {
 9be:	409c                	lw	a5,0(s1)
 9c0:	01278f63          	beq	a5,s2,9de <search+0x3a>
            rcureadunlock();
            return current; // Node found
        }
        current = current->next;
 9c4:	6484                	ld	s1,8(s1)
    while (current != 0) {
 9c6:	fce5                	bnez	s1,9be <search+0x1a>
    }
    rcureadunlock();
 9c8:	00000097          	auipc	ra,0x0
 9cc:	a30080e7          	jalr	-1488(ra) # 3f8 <rcureadunlock>
    return 0; // Node not found
 9d0:	4501                	li	a0,0
}
 9d2:	60e2                	ld	ra,24(sp)
 9d4:	6442                	ld	s0,16(sp)
 9d6:	64a2                	ld	s1,8(sp)
 9d8:	6902                	ld	s2,0(sp)
 9da:	6105                	add	sp,sp,32
 9dc:	8082                	ret
            rcureadunlock();
 9de:	00000097          	auipc	ra,0x0
 9e2:	a1a080e7          	jalr	-1510(ra) # 3f8 <rcureadunlock>
            return current; // Node found
 9e6:	8526                	mv	a0,s1
 9e8:	b7ed                	j	9d2 <search+0x2e>

00000000000009ea <updateNode>:

// Function to update the value of a node with a given key in the linked list
void updateNode(struct Node *head, int key, int new_data) {
 9ea:	1101                	add	sp,sp,-32
 9ec:	ec06                	sd	ra,24(sp)
 9ee:	e822                	sd	s0,16(sp)
 9f0:	e426                	sd	s1,8(sp)
 9f2:	e04a                	sd	s2,0(sp)
 9f4:	1000                	add	s0,sp,32
 9f6:	892e                	mv	s2,a1
 9f8:	84b2                	mv	s1,a2
    struct Node *nodeToUpdate = search(head, key);
 9fa:	00000097          	auipc	ra,0x0
 9fe:	faa080e7          	jalr	-86(ra) # 9a4 <search>

    if (nodeToUpdate != 0) {
 a02:	c901                	beqz	a0,a12 <updateNode+0x28>
        nodeToUpdate->data = new_data; // Update the node's data
 a04:	c104                	sw	s1,0(a0)
    } else {
        printf("Node with key %d not found.\n", key);
    }
}
 a06:	60e2                	ld	ra,24(sp)
 a08:	6442                	ld	s0,16(sp)
 a0a:	64a2                	ld	s1,8(sp)
 a0c:	6902                	ld	s2,0(sp)
 a0e:	6105                	add	sp,sp,32
 a10:	8082                	ret
        printf("Node with key %d not found.\n", key);
 a12:	85ca                	mv	a1,s2
 a14:	00000517          	auipc	a0,0x0
 a18:	0a450513          	add	a0,a0,164 # ab8 <digits+0x18>
 a1c:	00000097          	auipc	ra,0x0
 a20:	cec080e7          	jalr	-788(ra) # 708 <printf>
}
 a24:	b7cd                	j	a06 <updateNode+0x1c>
