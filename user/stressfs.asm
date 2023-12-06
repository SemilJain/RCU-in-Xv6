
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dd010113          	add	sp,sp,-560
   4:	22113423          	sd	ra,552(sp)
   8:	22813023          	sd	s0,544(sp)
   c:	20913c23          	sd	s1,536(sp)
  10:	21213823          	sd	s2,528(sp)
  14:	1c00                	add	s0,sp,560
  int fd, i;
  char path[] = "stressfs0";
  16:	00001797          	auipc	a5,0x1
  1a:	aca78793          	add	a5,a5,-1334 # ae0 <updateNode+0x78>
  1e:	6398                	ld	a4,0(a5)
  20:	fce43823          	sd	a4,-48(s0)
  24:	0087d783          	lhu	a5,8(a5)
  28:	fcf41c23          	sh	a5,-40(s0)
  char data[512];

  printf("stressfs starting\n");
  2c:	00001517          	auipc	a0,0x1
  30:	a8450513          	add	a0,a0,-1404 # ab0 <updateNode+0x48>
  34:	00000097          	auipc	ra,0x0
  38:	752080e7          	jalr	1874(ra) # 786 <printf>
  memset(data, 'a', sizeof(data));
  3c:	20000613          	li	a2,512
  40:	06100593          	li	a1,97
  44:	dd040513          	add	a0,s0,-560
  48:	00000097          	auipc	ra,0x0
  4c:	150080e7          	jalr	336(ra) # 198 <memset>

  for(i = 0; i < 4; i++)
  50:	4481                	li	s1,0
  52:	4911                	li	s2,4
    if(fork() > 0)
  54:	00000097          	auipc	ra,0x0
  58:	372080e7          	jalr	882(ra) # 3c6 <fork>
  5c:	00a04563          	bgtz	a0,66 <main+0x66>
  for(i = 0; i < 4; i++)
  60:	2485                	addw	s1,s1,1
  62:	ff2499e3          	bne	s1,s2,54 <main+0x54>
      break;

  printf("write %d\n", i);
  66:	85a6                	mv	a1,s1
  68:	00001517          	auipc	a0,0x1
  6c:	a6050513          	add	a0,a0,-1440 # ac8 <updateNode+0x60>
  70:	00000097          	auipc	ra,0x0
  74:	716080e7          	jalr	1814(ra) # 786 <printf>

  path[8] += i;
  78:	fd844783          	lbu	a5,-40(s0)
  7c:	9fa5                	addw	a5,a5,s1
  7e:	fcf40c23          	sb	a5,-40(s0)
  fd = open(path, O_CREATE | O_RDWR);
  82:	20200593          	li	a1,514
  86:	fd040513          	add	a0,s0,-48
  8a:	00000097          	auipc	ra,0x0
  8e:	384080e7          	jalr	900(ra) # 40e <open>
  92:	892a                	mv	s2,a0
  94:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  96:	20000613          	li	a2,512
  9a:	dd040593          	add	a1,s0,-560
  9e:	854a                	mv	a0,s2
  a0:	00000097          	auipc	ra,0x0
  a4:	34e080e7          	jalr	846(ra) # 3ee <write>
  for(i = 0; i < 20; i++)
  a8:	34fd                	addw	s1,s1,-1
  aa:	f4f5                	bnez	s1,96 <main+0x96>
  close(fd);
  ac:	854a                	mv	a0,s2
  ae:	00000097          	auipc	ra,0x0
  b2:	348080e7          	jalr	840(ra) # 3f6 <close>

  printf("read\n");
  b6:	00001517          	auipc	a0,0x1
  ba:	a2250513          	add	a0,a0,-1502 # ad8 <updateNode+0x70>
  be:	00000097          	auipc	ra,0x0
  c2:	6c8080e7          	jalr	1736(ra) # 786 <printf>

  fd = open(path, O_RDONLY);
  c6:	4581                	li	a1,0
  c8:	fd040513          	add	a0,s0,-48
  cc:	00000097          	auipc	ra,0x0
  d0:	342080e7          	jalr	834(ra) # 40e <open>
  d4:	892a                	mv	s2,a0
  d6:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  d8:	20000613          	li	a2,512
  dc:	dd040593          	add	a1,s0,-560
  e0:	854a                	mv	a0,s2
  e2:	00000097          	auipc	ra,0x0
  e6:	304080e7          	jalr	772(ra) # 3e6 <read>
  for (i = 0; i < 20; i++)
  ea:	34fd                	addw	s1,s1,-1
  ec:	f4f5                	bnez	s1,d8 <main+0xd8>
  close(fd);
  ee:	854a                	mv	a0,s2
  f0:	00000097          	auipc	ra,0x0
  f4:	306080e7          	jalr	774(ra) # 3f6 <close>

  wait(0);
  f8:	4501                	li	a0,0
  fa:	00000097          	auipc	ra,0x0
  fe:	2dc080e7          	jalr	732(ra) # 3d6 <wait>

  exit(0);
 102:	4501                	li	a0,0
 104:	00000097          	auipc	ra,0x0
 108:	2ca080e7          	jalr	714(ra) # 3ce <exit>

000000000000010c <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 10c:	1141                	add	sp,sp,-16
 10e:	e406                	sd	ra,8(sp)
 110:	e022                	sd	s0,0(sp)
 112:	0800                	add	s0,sp,16
  extern int main();
  main();
 114:	00000097          	auipc	ra,0x0
 118:	eec080e7          	jalr	-276(ra) # 0 <main>
  exit(0);
 11c:	4501                	li	a0,0
 11e:	00000097          	auipc	ra,0x0
 122:	2b0080e7          	jalr	688(ra) # 3ce <exit>

0000000000000126 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 126:	1141                	add	sp,sp,-16
 128:	e422                	sd	s0,8(sp)
 12a:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 12c:	87aa                	mv	a5,a0
 12e:	0585                	add	a1,a1,1
 130:	0785                	add	a5,a5,1
 132:	fff5c703          	lbu	a4,-1(a1)
 136:	fee78fa3          	sb	a4,-1(a5)
 13a:	fb75                	bnez	a4,12e <strcpy+0x8>
    ;
  return os;
}
 13c:	6422                	ld	s0,8(sp)
 13e:	0141                	add	sp,sp,16
 140:	8082                	ret

0000000000000142 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 142:	1141                	add	sp,sp,-16
 144:	e422                	sd	s0,8(sp)
 146:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 148:	00054783          	lbu	a5,0(a0)
 14c:	cb91                	beqz	a5,160 <strcmp+0x1e>
 14e:	0005c703          	lbu	a4,0(a1)
 152:	00f71763          	bne	a4,a5,160 <strcmp+0x1e>
    p++, q++;
 156:	0505                	add	a0,a0,1
 158:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 15a:	00054783          	lbu	a5,0(a0)
 15e:	fbe5                	bnez	a5,14e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 160:	0005c503          	lbu	a0,0(a1)
}
 164:	40a7853b          	subw	a0,a5,a0
 168:	6422                	ld	s0,8(sp)
 16a:	0141                	add	sp,sp,16
 16c:	8082                	ret

000000000000016e <strlen>:

uint
strlen(const char *s)
{
 16e:	1141                	add	sp,sp,-16
 170:	e422                	sd	s0,8(sp)
 172:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 174:	00054783          	lbu	a5,0(a0)
 178:	cf91                	beqz	a5,194 <strlen+0x26>
 17a:	0505                	add	a0,a0,1
 17c:	87aa                	mv	a5,a0
 17e:	86be                	mv	a3,a5
 180:	0785                	add	a5,a5,1
 182:	fff7c703          	lbu	a4,-1(a5)
 186:	ff65                	bnez	a4,17e <strlen+0x10>
 188:	40a6853b          	subw	a0,a3,a0
 18c:	2505                	addw	a0,a0,1
    ;
  return n;
}
 18e:	6422                	ld	s0,8(sp)
 190:	0141                	add	sp,sp,16
 192:	8082                	ret
  for(n = 0; s[n]; n++)
 194:	4501                	li	a0,0
 196:	bfe5                	j	18e <strlen+0x20>

0000000000000198 <memset>:

void*
memset(void *dst, int c, uint n)
{
 198:	1141                	add	sp,sp,-16
 19a:	e422                	sd	s0,8(sp)
 19c:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 19e:	ca19                	beqz	a2,1b4 <memset+0x1c>
 1a0:	87aa                	mv	a5,a0
 1a2:	1602                	sll	a2,a2,0x20
 1a4:	9201                	srl	a2,a2,0x20
 1a6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1aa:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1ae:	0785                	add	a5,a5,1
 1b0:	fee79de3          	bne	a5,a4,1aa <memset+0x12>
  }
  return dst;
}
 1b4:	6422                	ld	s0,8(sp)
 1b6:	0141                	add	sp,sp,16
 1b8:	8082                	ret

00000000000001ba <strchr>:

char*
strchr(const char *s, char c)
{
 1ba:	1141                	add	sp,sp,-16
 1bc:	e422                	sd	s0,8(sp)
 1be:	0800                	add	s0,sp,16
  for(; *s; s++)
 1c0:	00054783          	lbu	a5,0(a0)
 1c4:	cb99                	beqz	a5,1da <strchr+0x20>
    if(*s == c)
 1c6:	00f58763          	beq	a1,a5,1d4 <strchr+0x1a>
  for(; *s; s++)
 1ca:	0505                	add	a0,a0,1
 1cc:	00054783          	lbu	a5,0(a0)
 1d0:	fbfd                	bnez	a5,1c6 <strchr+0xc>
      return (char*)s;
  return 0;
 1d2:	4501                	li	a0,0
}
 1d4:	6422                	ld	s0,8(sp)
 1d6:	0141                	add	sp,sp,16
 1d8:	8082                	ret
  return 0;
 1da:	4501                	li	a0,0
 1dc:	bfe5                	j	1d4 <strchr+0x1a>

00000000000001de <gets>:

char*
gets(char *buf, int max)
{
 1de:	711d                	add	sp,sp,-96
 1e0:	ec86                	sd	ra,88(sp)
 1e2:	e8a2                	sd	s0,80(sp)
 1e4:	e4a6                	sd	s1,72(sp)
 1e6:	e0ca                	sd	s2,64(sp)
 1e8:	fc4e                	sd	s3,56(sp)
 1ea:	f852                	sd	s4,48(sp)
 1ec:	f456                	sd	s5,40(sp)
 1ee:	f05a                	sd	s6,32(sp)
 1f0:	ec5e                	sd	s7,24(sp)
 1f2:	1080                	add	s0,sp,96
 1f4:	8baa                	mv	s7,a0
 1f6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f8:	892a                	mv	s2,a0
 1fa:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1fc:	4aa9                	li	s5,10
 1fe:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 200:	89a6                	mv	s3,s1
 202:	2485                	addw	s1,s1,1
 204:	0344d863          	bge	s1,s4,234 <gets+0x56>
    cc = read(0, &c, 1);
 208:	4605                	li	a2,1
 20a:	faf40593          	add	a1,s0,-81
 20e:	4501                	li	a0,0
 210:	00000097          	auipc	ra,0x0
 214:	1d6080e7          	jalr	470(ra) # 3e6 <read>
    if(cc < 1)
 218:	00a05e63          	blez	a0,234 <gets+0x56>
    buf[i++] = c;
 21c:	faf44783          	lbu	a5,-81(s0)
 220:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 224:	01578763          	beq	a5,s5,232 <gets+0x54>
 228:	0905                	add	s2,s2,1
 22a:	fd679be3          	bne	a5,s6,200 <gets+0x22>
  for(i=0; i+1 < max; ){
 22e:	89a6                	mv	s3,s1
 230:	a011                	j	234 <gets+0x56>
 232:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 234:	99de                	add	s3,s3,s7
 236:	00098023          	sb	zero,0(s3)
  return buf;
}
 23a:	855e                	mv	a0,s7
 23c:	60e6                	ld	ra,88(sp)
 23e:	6446                	ld	s0,80(sp)
 240:	64a6                	ld	s1,72(sp)
 242:	6906                	ld	s2,64(sp)
 244:	79e2                	ld	s3,56(sp)
 246:	7a42                	ld	s4,48(sp)
 248:	7aa2                	ld	s5,40(sp)
 24a:	7b02                	ld	s6,32(sp)
 24c:	6be2                	ld	s7,24(sp)
 24e:	6125                	add	sp,sp,96
 250:	8082                	ret

0000000000000252 <stat>:

int
stat(const char *n, struct stat *st)
{
 252:	1101                	add	sp,sp,-32
 254:	ec06                	sd	ra,24(sp)
 256:	e822                	sd	s0,16(sp)
 258:	e426                	sd	s1,8(sp)
 25a:	e04a                	sd	s2,0(sp)
 25c:	1000                	add	s0,sp,32
 25e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 260:	4581                	li	a1,0
 262:	00000097          	auipc	ra,0x0
 266:	1ac080e7          	jalr	428(ra) # 40e <open>
  if(fd < 0)
 26a:	02054563          	bltz	a0,294 <stat+0x42>
 26e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 270:	85ca                	mv	a1,s2
 272:	00000097          	auipc	ra,0x0
 276:	1b4080e7          	jalr	436(ra) # 426 <fstat>
 27a:	892a                	mv	s2,a0
  close(fd);
 27c:	8526                	mv	a0,s1
 27e:	00000097          	auipc	ra,0x0
 282:	178080e7          	jalr	376(ra) # 3f6 <close>
  return r;
}
 286:	854a                	mv	a0,s2
 288:	60e2                	ld	ra,24(sp)
 28a:	6442                	ld	s0,16(sp)
 28c:	64a2                	ld	s1,8(sp)
 28e:	6902                	ld	s2,0(sp)
 290:	6105                	add	sp,sp,32
 292:	8082                	ret
    return -1;
 294:	597d                	li	s2,-1
 296:	bfc5                	j	286 <stat+0x34>

0000000000000298 <atoi>:

int
atoi(const char *s)
{
 298:	1141                	add	sp,sp,-16
 29a:	e422                	sd	s0,8(sp)
 29c:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 29e:	00054683          	lbu	a3,0(a0)
 2a2:	fd06879b          	addw	a5,a3,-48
 2a6:	0ff7f793          	zext.b	a5,a5
 2aa:	4625                	li	a2,9
 2ac:	02f66863          	bltu	a2,a5,2dc <atoi+0x44>
 2b0:	872a                	mv	a4,a0
  n = 0;
 2b2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2b4:	0705                	add	a4,a4,1
 2b6:	0025179b          	sllw	a5,a0,0x2
 2ba:	9fa9                	addw	a5,a5,a0
 2bc:	0017979b          	sllw	a5,a5,0x1
 2c0:	9fb5                	addw	a5,a5,a3
 2c2:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2c6:	00074683          	lbu	a3,0(a4)
 2ca:	fd06879b          	addw	a5,a3,-48
 2ce:	0ff7f793          	zext.b	a5,a5
 2d2:	fef671e3          	bgeu	a2,a5,2b4 <atoi+0x1c>
  return n;
}
 2d6:	6422                	ld	s0,8(sp)
 2d8:	0141                	add	sp,sp,16
 2da:	8082                	ret
  n = 0;
 2dc:	4501                	li	a0,0
 2de:	bfe5                	j	2d6 <atoi+0x3e>

00000000000002e0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2e0:	1141                	add	sp,sp,-16
 2e2:	e422                	sd	s0,8(sp)
 2e4:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2e6:	02b57463          	bgeu	a0,a1,30e <memmove+0x2e>
    while(n-- > 0)
 2ea:	00c05f63          	blez	a2,308 <memmove+0x28>
 2ee:	1602                	sll	a2,a2,0x20
 2f0:	9201                	srl	a2,a2,0x20
 2f2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2f6:	872a                	mv	a4,a0
      *dst++ = *src++;
 2f8:	0585                	add	a1,a1,1
 2fa:	0705                	add	a4,a4,1
 2fc:	fff5c683          	lbu	a3,-1(a1)
 300:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 304:	fee79ae3          	bne	a5,a4,2f8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 308:	6422                	ld	s0,8(sp)
 30a:	0141                	add	sp,sp,16
 30c:	8082                	ret
    dst += n;
 30e:	00c50733          	add	a4,a0,a2
    src += n;
 312:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 314:	fec05ae3          	blez	a2,308 <memmove+0x28>
 318:	fff6079b          	addw	a5,a2,-1
 31c:	1782                	sll	a5,a5,0x20
 31e:	9381                	srl	a5,a5,0x20
 320:	fff7c793          	not	a5,a5
 324:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 326:	15fd                	add	a1,a1,-1
 328:	177d                	add	a4,a4,-1
 32a:	0005c683          	lbu	a3,0(a1)
 32e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 332:	fee79ae3          	bne	a5,a4,326 <memmove+0x46>
 336:	bfc9                	j	308 <memmove+0x28>

0000000000000338 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 338:	1141                	add	sp,sp,-16
 33a:	e422                	sd	s0,8(sp)
 33c:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 33e:	ca05                	beqz	a2,36e <memcmp+0x36>
 340:	fff6069b          	addw	a3,a2,-1
 344:	1682                	sll	a3,a3,0x20
 346:	9281                	srl	a3,a3,0x20
 348:	0685                	add	a3,a3,1
 34a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 34c:	00054783          	lbu	a5,0(a0)
 350:	0005c703          	lbu	a4,0(a1)
 354:	00e79863          	bne	a5,a4,364 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 358:	0505                	add	a0,a0,1
    p2++;
 35a:	0585                	add	a1,a1,1
  while (n-- > 0) {
 35c:	fed518e3          	bne	a0,a3,34c <memcmp+0x14>
  }
  return 0;
 360:	4501                	li	a0,0
 362:	a019                	j	368 <memcmp+0x30>
      return *p1 - *p2;
 364:	40e7853b          	subw	a0,a5,a4
}
 368:	6422                	ld	s0,8(sp)
 36a:	0141                	add	sp,sp,16
 36c:	8082                	ret
  return 0;
 36e:	4501                	li	a0,0
 370:	bfe5                	j	368 <memcmp+0x30>

0000000000000372 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 372:	1141                	add	sp,sp,-16
 374:	e406                	sd	ra,8(sp)
 376:	e022                	sd	s0,0(sp)
 378:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 37a:	00000097          	auipc	ra,0x0
 37e:	f66080e7          	jalr	-154(ra) # 2e0 <memmove>
}
 382:	60a2                	ld	ra,8(sp)
 384:	6402                	ld	s0,0(sp)
 386:	0141                	add	sp,sp,16
 388:	8082                	ret

000000000000038a <initlock>:

// Initialize the spinlock
void initlock(struct spinlock_u *lk) {
 38a:	1141                	add	sp,sp,-16
 38c:	e422                	sd	s0,8(sp)
 38e:	0800                	add	s0,sp,16
  lk->locked = 0;
 390:	00052023          	sw	zero,0(a0)
}
 394:	6422                	ld	s0,8(sp)
 396:	0141                	add	sp,sp,16
 398:	8082                	ret

000000000000039a <acquire>:

// Acquire the spinlock
void acquire(struct spinlock_u *lk) {
 39a:	1141                	add	sp,sp,-16
 39c:	e422                	sd	s0,8(sp)
 39e:	0800                	add	s0,sp,16
  while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 3a0:	4705                	li	a4,1
 3a2:	87ba                	mv	a5,a4
 3a4:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
 3a8:	2781                	sext.w	a5,a5
 3aa:	ffe5                	bnez	a5,3a2 <acquire+0x8>
    ; // Spin until the lock is acquired
}
 3ac:	6422                	ld	s0,8(sp)
 3ae:	0141                	add	sp,sp,16
 3b0:	8082                	ret

00000000000003b2 <release>:

// Release the spinlock
void release(struct spinlock_u *lk) {
 3b2:	1141                	add	sp,sp,-16
 3b4:	e422                	sd	s0,8(sp)
 3b6:	0800                	add	s0,sp,16
  __sync_lock_release(&lk->locked);
 3b8:	0f50000f          	fence	iorw,ow
 3bc:	0805202f          	amoswap.w	zero,zero,(a0)
}
 3c0:	6422                	ld	s0,8(sp)
 3c2:	0141                	add	sp,sp,16
 3c4:	8082                	ret

00000000000003c6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3c6:	4885                	li	a7,1
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <exit>:
.global exit
exit:
 li a7, SYS_exit
 3ce:	4889                	li	a7,2
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3d6:	488d                	li	a7,3
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3de:	4891                	li	a7,4
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <read>:
.global read
read:
 li a7, SYS_read
 3e6:	4895                	li	a7,5
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <write>:
.global write
write:
 li a7, SYS_write
 3ee:	48c1                	li	a7,16
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <close>:
.global close
close:
 li a7, SYS_close
 3f6:	48d5                	li	a7,21
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <kill>:
.global kill
kill:
 li a7, SYS_kill
 3fe:	4899                	li	a7,6
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <exec>:
.global exec
exec:
 li a7, SYS_exec
 406:	489d                	li	a7,7
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <open>:
.global open
open:
 li a7, SYS_open
 40e:	48bd                	li	a7,15
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 416:	48c5                	li	a7,17
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 41e:	48c9                	li	a7,18
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 426:	48a1                	li	a7,8
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <link>:
.global link
link:
 li a7, SYS_link
 42e:	48cd                	li	a7,19
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 436:	48d1                	li	a7,20
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 43e:	48a5                	li	a7,9
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <dup>:
.global dup
dup:
 li a7, SYS_dup
 446:	48a9                	li	a7,10
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 44e:	48ad                	li	a7,11
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 456:	48b1                	li	a7,12
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 45e:	48b5                	li	a7,13
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 466:	48b9                	li	a7,14
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <rcureadlock>:
.global rcureadlock
rcureadlock:
 li a7, SYS_rcureadlock
 46e:	48dd                	li	a7,23
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <rcureadunlock>:
.global rcureadunlock
rcureadunlock:
 li a7, SYS_rcureadunlock
 476:	48e1                	li	a7,24
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <rcusync>:
.global rcusync
rcusync:
 li a7, SYS_rcusync
 47e:	48d9                	li	a7,22
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <thread_create>:
.global thread_create
thread_create:
 li a7, SYS_thread_create
 486:	48e5                	li	a7,25
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <thread_join>:
.global thread_join
thread_join:
 li a7, SYS_thread_join
 48e:	48e9                	li	a7,26
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <thread_exit>:
.global thread_exit
thread_exit:
 li a7, SYS_thread_exit
 496:	48ed                	li	a7,27
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <klist_insert>:
.global klist_insert
klist_insert:
 li a7, SYS_klist_insert
 49e:	48f1                	li	a7,28
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <klist_delete>:
.global klist_delete
klist_delete:
 li a7, SYS_klist_delete
 4a6:	48f5                	li	a7,29
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <klist_query>:
.global klist_query
klist_query:
 li a7, SYS_klist_query
 4ae:	48f9                	li	a7,30
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <klist_print>:
.global klist_print
klist_print:
 li a7, SYS_klist_print
 4b6:	48fd                	li	a7,31
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4be:	1101                	add	sp,sp,-32
 4c0:	ec06                	sd	ra,24(sp)
 4c2:	e822                	sd	s0,16(sp)
 4c4:	1000                	add	s0,sp,32
 4c6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4ca:	4605                	li	a2,1
 4cc:	fef40593          	add	a1,s0,-17
 4d0:	00000097          	auipc	ra,0x0
 4d4:	f1e080e7          	jalr	-226(ra) # 3ee <write>
}
 4d8:	60e2                	ld	ra,24(sp)
 4da:	6442                	ld	s0,16(sp)
 4dc:	6105                	add	sp,sp,32
 4de:	8082                	ret

00000000000004e0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4e0:	7139                	add	sp,sp,-64
 4e2:	fc06                	sd	ra,56(sp)
 4e4:	f822                	sd	s0,48(sp)
 4e6:	f426                	sd	s1,40(sp)
 4e8:	f04a                	sd	s2,32(sp)
 4ea:	ec4e                	sd	s3,24(sp)
 4ec:	0080                	add	s0,sp,64
 4ee:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4f0:	c299                	beqz	a3,4f6 <printint+0x16>
 4f2:	0805c963          	bltz	a1,584 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4f6:	2581                	sext.w	a1,a1
  neg = 0;
 4f8:	4881                	li	a7,0
 4fa:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 4fe:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 500:	2601                	sext.w	a2,a2
 502:	00000517          	auipc	a0,0x0
 506:	64e50513          	add	a0,a0,1614 # b50 <digits>
 50a:	883a                	mv	a6,a4
 50c:	2705                	addw	a4,a4,1
 50e:	02c5f7bb          	remuw	a5,a1,a2
 512:	1782                	sll	a5,a5,0x20
 514:	9381                	srl	a5,a5,0x20
 516:	97aa                	add	a5,a5,a0
 518:	0007c783          	lbu	a5,0(a5)
 51c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 520:	0005879b          	sext.w	a5,a1
 524:	02c5d5bb          	divuw	a1,a1,a2
 528:	0685                	add	a3,a3,1
 52a:	fec7f0e3          	bgeu	a5,a2,50a <printint+0x2a>
  if(neg)
 52e:	00088c63          	beqz	a7,546 <printint+0x66>
    buf[i++] = '-';
 532:	fd070793          	add	a5,a4,-48
 536:	00878733          	add	a4,a5,s0
 53a:	02d00793          	li	a5,45
 53e:	fef70823          	sb	a5,-16(a4)
 542:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 546:	02e05863          	blez	a4,576 <printint+0x96>
 54a:	fc040793          	add	a5,s0,-64
 54e:	00e78933          	add	s2,a5,a4
 552:	fff78993          	add	s3,a5,-1
 556:	99ba                	add	s3,s3,a4
 558:	377d                	addw	a4,a4,-1
 55a:	1702                	sll	a4,a4,0x20
 55c:	9301                	srl	a4,a4,0x20
 55e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 562:	fff94583          	lbu	a1,-1(s2)
 566:	8526                	mv	a0,s1
 568:	00000097          	auipc	ra,0x0
 56c:	f56080e7          	jalr	-170(ra) # 4be <putc>
  while(--i >= 0)
 570:	197d                	add	s2,s2,-1
 572:	ff3918e3          	bne	s2,s3,562 <printint+0x82>
}
 576:	70e2                	ld	ra,56(sp)
 578:	7442                	ld	s0,48(sp)
 57a:	74a2                	ld	s1,40(sp)
 57c:	7902                	ld	s2,32(sp)
 57e:	69e2                	ld	s3,24(sp)
 580:	6121                	add	sp,sp,64
 582:	8082                	ret
    x = -xx;
 584:	40b005bb          	negw	a1,a1
    neg = 1;
 588:	4885                	li	a7,1
    x = -xx;
 58a:	bf85                	j	4fa <printint+0x1a>

000000000000058c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 58c:	715d                	add	sp,sp,-80
 58e:	e486                	sd	ra,72(sp)
 590:	e0a2                	sd	s0,64(sp)
 592:	fc26                	sd	s1,56(sp)
 594:	f84a                	sd	s2,48(sp)
 596:	f44e                	sd	s3,40(sp)
 598:	f052                	sd	s4,32(sp)
 59a:	ec56                	sd	s5,24(sp)
 59c:	e85a                	sd	s6,16(sp)
 59e:	e45e                	sd	s7,8(sp)
 5a0:	e062                	sd	s8,0(sp)
 5a2:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5a4:	0005c903          	lbu	s2,0(a1)
 5a8:	18090c63          	beqz	s2,740 <vprintf+0x1b4>
 5ac:	8aaa                	mv	s5,a0
 5ae:	8bb2                	mv	s7,a2
 5b0:	00158493          	add	s1,a1,1
  state = 0;
 5b4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5b6:	02500a13          	li	s4,37
 5ba:	4b55                	li	s6,21
 5bc:	a839                	j	5da <vprintf+0x4e>
        putc(fd, c);
 5be:	85ca                	mv	a1,s2
 5c0:	8556                	mv	a0,s5
 5c2:	00000097          	auipc	ra,0x0
 5c6:	efc080e7          	jalr	-260(ra) # 4be <putc>
 5ca:	a019                	j	5d0 <vprintf+0x44>
    } else if(state == '%'){
 5cc:	01498d63          	beq	s3,s4,5e6 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 5d0:	0485                	add	s1,s1,1
 5d2:	fff4c903          	lbu	s2,-1(s1)
 5d6:	16090563          	beqz	s2,740 <vprintf+0x1b4>
    if(state == 0){
 5da:	fe0999e3          	bnez	s3,5cc <vprintf+0x40>
      if(c == '%'){
 5de:	ff4910e3          	bne	s2,s4,5be <vprintf+0x32>
        state = '%';
 5e2:	89d2                	mv	s3,s4
 5e4:	b7f5                	j	5d0 <vprintf+0x44>
      if(c == 'd'){
 5e6:	13490263          	beq	s2,s4,70a <vprintf+0x17e>
 5ea:	f9d9079b          	addw	a5,s2,-99
 5ee:	0ff7f793          	zext.b	a5,a5
 5f2:	12fb6563          	bltu	s6,a5,71c <vprintf+0x190>
 5f6:	f9d9079b          	addw	a5,s2,-99
 5fa:	0ff7f713          	zext.b	a4,a5
 5fe:	10eb6f63          	bltu	s6,a4,71c <vprintf+0x190>
 602:	00271793          	sll	a5,a4,0x2
 606:	00000717          	auipc	a4,0x0
 60a:	4f270713          	add	a4,a4,1266 # af8 <updateNode+0x90>
 60e:	97ba                	add	a5,a5,a4
 610:	439c                	lw	a5,0(a5)
 612:	97ba                	add	a5,a5,a4
 614:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 616:	008b8913          	add	s2,s7,8
 61a:	4685                	li	a3,1
 61c:	4629                	li	a2,10
 61e:	000ba583          	lw	a1,0(s7)
 622:	8556                	mv	a0,s5
 624:	00000097          	auipc	ra,0x0
 628:	ebc080e7          	jalr	-324(ra) # 4e0 <printint>
 62c:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 62e:	4981                	li	s3,0
 630:	b745                	j	5d0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 632:	008b8913          	add	s2,s7,8
 636:	4681                	li	a3,0
 638:	4629                	li	a2,10
 63a:	000ba583          	lw	a1,0(s7)
 63e:	8556                	mv	a0,s5
 640:	00000097          	auipc	ra,0x0
 644:	ea0080e7          	jalr	-352(ra) # 4e0 <printint>
 648:	8bca                	mv	s7,s2
      state = 0;
 64a:	4981                	li	s3,0
 64c:	b751                	j	5d0 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 64e:	008b8913          	add	s2,s7,8
 652:	4681                	li	a3,0
 654:	4641                	li	a2,16
 656:	000ba583          	lw	a1,0(s7)
 65a:	8556                	mv	a0,s5
 65c:	00000097          	auipc	ra,0x0
 660:	e84080e7          	jalr	-380(ra) # 4e0 <printint>
 664:	8bca                	mv	s7,s2
      state = 0;
 666:	4981                	li	s3,0
 668:	b7a5                	j	5d0 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 66a:	008b8c13          	add	s8,s7,8
 66e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 672:	03000593          	li	a1,48
 676:	8556                	mv	a0,s5
 678:	00000097          	auipc	ra,0x0
 67c:	e46080e7          	jalr	-442(ra) # 4be <putc>
  putc(fd, 'x');
 680:	07800593          	li	a1,120
 684:	8556                	mv	a0,s5
 686:	00000097          	auipc	ra,0x0
 68a:	e38080e7          	jalr	-456(ra) # 4be <putc>
 68e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 690:	00000b97          	auipc	s7,0x0
 694:	4c0b8b93          	add	s7,s7,1216 # b50 <digits>
 698:	03c9d793          	srl	a5,s3,0x3c
 69c:	97de                	add	a5,a5,s7
 69e:	0007c583          	lbu	a1,0(a5)
 6a2:	8556                	mv	a0,s5
 6a4:	00000097          	auipc	ra,0x0
 6a8:	e1a080e7          	jalr	-486(ra) # 4be <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6ac:	0992                	sll	s3,s3,0x4
 6ae:	397d                	addw	s2,s2,-1
 6b0:	fe0914e3          	bnez	s2,698 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 6b4:	8be2                	mv	s7,s8
      state = 0;
 6b6:	4981                	li	s3,0
 6b8:	bf21                	j	5d0 <vprintf+0x44>
        s = va_arg(ap, char*);
 6ba:	008b8993          	add	s3,s7,8
 6be:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 6c2:	02090163          	beqz	s2,6e4 <vprintf+0x158>
        while(*s != 0){
 6c6:	00094583          	lbu	a1,0(s2)
 6ca:	c9a5                	beqz	a1,73a <vprintf+0x1ae>
          putc(fd, *s);
 6cc:	8556                	mv	a0,s5
 6ce:	00000097          	auipc	ra,0x0
 6d2:	df0080e7          	jalr	-528(ra) # 4be <putc>
          s++;
 6d6:	0905                	add	s2,s2,1
        while(*s != 0){
 6d8:	00094583          	lbu	a1,0(s2)
 6dc:	f9e5                	bnez	a1,6cc <vprintf+0x140>
        s = va_arg(ap, char*);
 6de:	8bce                	mv	s7,s3
      state = 0;
 6e0:	4981                	li	s3,0
 6e2:	b5fd                	j	5d0 <vprintf+0x44>
          s = "(null)";
 6e4:	00000917          	auipc	s2,0x0
 6e8:	40c90913          	add	s2,s2,1036 # af0 <updateNode+0x88>
        while(*s != 0){
 6ec:	02800593          	li	a1,40
 6f0:	bff1                	j	6cc <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 6f2:	008b8913          	add	s2,s7,8
 6f6:	000bc583          	lbu	a1,0(s7)
 6fa:	8556                	mv	a0,s5
 6fc:	00000097          	auipc	ra,0x0
 700:	dc2080e7          	jalr	-574(ra) # 4be <putc>
 704:	8bca                	mv	s7,s2
      state = 0;
 706:	4981                	li	s3,0
 708:	b5e1                	j	5d0 <vprintf+0x44>
        putc(fd, c);
 70a:	02500593          	li	a1,37
 70e:	8556                	mv	a0,s5
 710:	00000097          	auipc	ra,0x0
 714:	dae080e7          	jalr	-594(ra) # 4be <putc>
      state = 0;
 718:	4981                	li	s3,0
 71a:	bd5d                	j	5d0 <vprintf+0x44>
        putc(fd, '%');
 71c:	02500593          	li	a1,37
 720:	8556                	mv	a0,s5
 722:	00000097          	auipc	ra,0x0
 726:	d9c080e7          	jalr	-612(ra) # 4be <putc>
        putc(fd, c);
 72a:	85ca                	mv	a1,s2
 72c:	8556                	mv	a0,s5
 72e:	00000097          	auipc	ra,0x0
 732:	d90080e7          	jalr	-624(ra) # 4be <putc>
      state = 0;
 736:	4981                	li	s3,0
 738:	bd61                	j	5d0 <vprintf+0x44>
        s = va_arg(ap, char*);
 73a:	8bce                	mv	s7,s3
      state = 0;
 73c:	4981                	li	s3,0
 73e:	bd49                	j	5d0 <vprintf+0x44>
    }
  }
}
 740:	60a6                	ld	ra,72(sp)
 742:	6406                	ld	s0,64(sp)
 744:	74e2                	ld	s1,56(sp)
 746:	7942                	ld	s2,48(sp)
 748:	79a2                	ld	s3,40(sp)
 74a:	7a02                	ld	s4,32(sp)
 74c:	6ae2                	ld	s5,24(sp)
 74e:	6b42                	ld	s6,16(sp)
 750:	6ba2                	ld	s7,8(sp)
 752:	6c02                	ld	s8,0(sp)
 754:	6161                	add	sp,sp,80
 756:	8082                	ret

0000000000000758 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 758:	715d                	add	sp,sp,-80
 75a:	ec06                	sd	ra,24(sp)
 75c:	e822                	sd	s0,16(sp)
 75e:	1000                	add	s0,sp,32
 760:	e010                	sd	a2,0(s0)
 762:	e414                	sd	a3,8(s0)
 764:	e818                	sd	a4,16(s0)
 766:	ec1c                	sd	a5,24(s0)
 768:	03043023          	sd	a6,32(s0)
 76c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 770:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 774:	8622                	mv	a2,s0
 776:	00000097          	auipc	ra,0x0
 77a:	e16080e7          	jalr	-490(ra) # 58c <vprintf>
}
 77e:	60e2                	ld	ra,24(sp)
 780:	6442                	ld	s0,16(sp)
 782:	6161                	add	sp,sp,80
 784:	8082                	ret

0000000000000786 <printf>:

void
printf(const char *fmt, ...)
{
 786:	711d                	add	sp,sp,-96
 788:	ec06                	sd	ra,24(sp)
 78a:	e822                	sd	s0,16(sp)
 78c:	1000                	add	s0,sp,32
 78e:	e40c                	sd	a1,8(s0)
 790:	e810                	sd	a2,16(s0)
 792:	ec14                	sd	a3,24(s0)
 794:	f018                	sd	a4,32(s0)
 796:	f41c                	sd	a5,40(s0)
 798:	03043823          	sd	a6,48(s0)
 79c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7a0:	00840613          	add	a2,s0,8
 7a4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7a8:	85aa                	mv	a1,a0
 7aa:	4505                	li	a0,1
 7ac:	00000097          	auipc	ra,0x0
 7b0:	de0080e7          	jalr	-544(ra) # 58c <vprintf>
}
 7b4:	60e2                	ld	ra,24(sp)
 7b6:	6442                	ld	s0,16(sp)
 7b8:	6125                	add	sp,sp,96
 7ba:	8082                	ret

00000000000007bc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7bc:	1141                	add	sp,sp,-16
 7be:	e422                	sd	s0,8(sp)
 7c0:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7c2:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c6:	00001797          	auipc	a5,0x1
 7ca:	83a7b783          	ld	a5,-1990(a5) # 1000 <freep>
 7ce:	a02d                	j	7f8 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7d0:	4618                	lw	a4,8(a2)
 7d2:	9f2d                	addw	a4,a4,a1
 7d4:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7d8:	6398                	ld	a4,0(a5)
 7da:	6310                	ld	a2,0(a4)
 7dc:	a83d                	j	81a <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7de:	ff852703          	lw	a4,-8(a0)
 7e2:	9f31                	addw	a4,a4,a2
 7e4:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7e6:	ff053683          	ld	a3,-16(a0)
 7ea:	a091                	j	82e <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ec:	6398                	ld	a4,0(a5)
 7ee:	00e7e463          	bltu	a5,a4,7f6 <free+0x3a>
 7f2:	00e6ea63          	bltu	a3,a4,806 <free+0x4a>
{
 7f6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f8:	fed7fae3          	bgeu	a5,a3,7ec <free+0x30>
 7fc:	6398                	ld	a4,0(a5)
 7fe:	00e6e463          	bltu	a3,a4,806 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 802:	fee7eae3          	bltu	a5,a4,7f6 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 806:	ff852583          	lw	a1,-8(a0)
 80a:	6390                	ld	a2,0(a5)
 80c:	02059813          	sll	a6,a1,0x20
 810:	01c85713          	srl	a4,a6,0x1c
 814:	9736                	add	a4,a4,a3
 816:	fae60de3          	beq	a2,a4,7d0 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 81a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 81e:	4790                	lw	a2,8(a5)
 820:	02061593          	sll	a1,a2,0x20
 824:	01c5d713          	srl	a4,a1,0x1c
 828:	973e                	add	a4,a4,a5
 82a:	fae68ae3          	beq	a3,a4,7de <free+0x22>
    p->s.ptr = bp->s.ptr;
 82e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 830:	00000717          	auipc	a4,0x0
 834:	7cf73823          	sd	a5,2000(a4) # 1000 <freep>
}
 838:	6422                	ld	s0,8(sp)
 83a:	0141                	add	sp,sp,16
 83c:	8082                	ret

000000000000083e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 83e:	7139                	add	sp,sp,-64
 840:	fc06                	sd	ra,56(sp)
 842:	f822                	sd	s0,48(sp)
 844:	f426                	sd	s1,40(sp)
 846:	f04a                	sd	s2,32(sp)
 848:	ec4e                	sd	s3,24(sp)
 84a:	e852                	sd	s4,16(sp)
 84c:	e456                	sd	s5,8(sp)
 84e:	e05a                	sd	s6,0(sp)
 850:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 852:	02051493          	sll	s1,a0,0x20
 856:	9081                	srl	s1,s1,0x20
 858:	04bd                	add	s1,s1,15
 85a:	8091                	srl	s1,s1,0x4
 85c:	0014899b          	addw	s3,s1,1
 860:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 862:	00000517          	auipc	a0,0x0
 866:	79e53503          	ld	a0,1950(a0) # 1000 <freep>
 86a:	c515                	beqz	a0,896 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 86c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 86e:	4798                	lw	a4,8(a5)
 870:	02977f63          	bgeu	a4,s1,8ae <malloc+0x70>
  if(nu < 4096)
 874:	8a4e                	mv	s4,s3
 876:	0009871b          	sext.w	a4,s3
 87a:	6685                	lui	a3,0x1
 87c:	00d77363          	bgeu	a4,a3,882 <malloc+0x44>
 880:	6a05                	lui	s4,0x1
 882:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 886:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 88a:	00000917          	auipc	s2,0x0
 88e:	77690913          	add	s2,s2,1910 # 1000 <freep>
  if(p == (char*)-1)
 892:	5afd                	li	s5,-1
 894:	a895                	j	908 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 896:	00000797          	auipc	a5,0x0
 89a:	77a78793          	add	a5,a5,1914 # 1010 <base>
 89e:	00000717          	auipc	a4,0x0
 8a2:	76f73123          	sd	a5,1890(a4) # 1000 <freep>
 8a6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8a8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8ac:	b7e1                	j	874 <malloc+0x36>
      if(p->s.size == nunits)
 8ae:	02e48c63          	beq	s1,a4,8e6 <malloc+0xa8>
        p->s.size -= nunits;
 8b2:	4137073b          	subw	a4,a4,s3
 8b6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8b8:	02071693          	sll	a3,a4,0x20
 8bc:	01c6d713          	srl	a4,a3,0x1c
 8c0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8c2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8c6:	00000717          	auipc	a4,0x0
 8ca:	72a73d23          	sd	a0,1850(a4) # 1000 <freep>
      return (void*)(p + 1);
 8ce:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8d2:	70e2                	ld	ra,56(sp)
 8d4:	7442                	ld	s0,48(sp)
 8d6:	74a2                	ld	s1,40(sp)
 8d8:	7902                	ld	s2,32(sp)
 8da:	69e2                	ld	s3,24(sp)
 8dc:	6a42                	ld	s4,16(sp)
 8de:	6aa2                	ld	s5,8(sp)
 8e0:	6b02                	ld	s6,0(sp)
 8e2:	6121                	add	sp,sp,64
 8e4:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8e6:	6398                	ld	a4,0(a5)
 8e8:	e118                	sd	a4,0(a0)
 8ea:	bff1                	j	8c6 <malloc+0x88>
  hp->s.size = nu;
 8ec:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8f0:	0541                	add	a0,a0,16
 8f2:	00000097          	auipc	ra,0x0
 8f6:	eca080e7          	jalr	-310(ra) # 7bc <free>
  return freep;
 8fa:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8fe:	d971                	beqz	a0,8d2 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 900:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 902:	4798                	lw	a4,8(a5)
 904:	fa9775e3          	bgeu	a4,s1,8ae <malloc+0x70>
    if(p == freep)
 908:	00093703          	ld	a4,0(s2)
 90c:	853e                	mv	a0,a5
 90e:	fef719e3          	bne	a4,a5,900 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 912:	8552                	mv	a0,s4
 914:	00000097          	auipc	ra,0x0
 918:	b42080e7          	jalr	-1214(ra) # 456 <sbrk>
  if(p == (char*)-1)
 91c:	fd5518e3          	bne	a0,s5,8ec <malloc+0xae>
        return 0;
 920:	4501                	li	a0,0
 922:	bf45                	j	8d2 <malloc+0x94>

0000000000000924 <init_lock>:
#include "linkedlist.h"

// Define a node structure for the linked list
struct spinlock_u list_lock;

void init_lock(){
 924:	1141                	add	sp,sp,-16
 926:	e406                	sd	ra,8(sp)
 928:	e022                	sd	s0,0(sp)
 92a:	0800                	add	s0,sp,16
    initlock(&list_lock);
 92c:	00000517          	auipc	a0,0x0
 930:	6dc50513          	add	a0,a0,1756 # 1008 <list_lock>
 934:	00000097          	auipc	ra,0x0
 938:	a56080e7          	jalr	-1450(ra) # 38a <initlock>
}
 93c:	60a2                	ld	ra,8(sp)
 93e:	6402                	ld	s0,0(sp)
 940:	0141                	add	sp,sp,16
 942:	8082                	ret

0000000000000944 <insert>:

// Function to insert a node at the beginning of the linked list
void insert(struct Node **head_ref, int new_data) {
 944:	1101                	add	sp,sp,-32
 946:	ec06                	sd	ra,24(sp)
 948:	e822                	sd	s0,16(sp)
 94a:	e426                	sd	s1,8(sp)
 94c:	e04a                	sd	s2,0(sp)
 94e:	1000                	add	s0,sp,32
 950:	84aa                	mv	s1,a0
 952:	892e                	mv	s2,a1
    struct Node *new_node = malloc(sizeof(struct Node));
 954:	4541                	li	a0,16
 956:	00000097          	auipc	ra,0x0
 95a:	ee8080e7          	jalr	-280(ra) # 83e <malloc>
    new_node->data = new_data;
 95e:	01252023          	sw	s2,0(a0)
    new_node->next = *head_ref;
 962:	609c                	ld	a5,0(s1)
 964:	e51c                	sd	a5,8(a0)
    *head_ref = new_node;
 966:	e088                	sd	a0,0(s1)
}
 968:	60e2                	ld	ra,24(sp)
 96a:	6442                	ld	s0,16(sp)
 96c:	64a2                	ld	s1,8(sp)
 96e:	6902                	ld	s2,0(sp)
 970:	6105                	add	sp,sp,32
 972:	8082                	ret

0000000000000974 <deleteNode>:

// Function to delete a node with a given key from the linked list
void deleteNode(struct Node **head_ref, int key) {
 974:	7179                	add	sp,sp,-48
 976:	f406                	sd	ra,40(sp)
 978:	f022                	sd	s0,32(sp)
 97a:	ec26                	sd	s1,24(sp)
 97c:	e84a                	sd	s2,16(sp)
 97e:	e44e                	sd	s3,8(sp)
 980:	1800                	add	s0,sp,48
 982:	89aa                	mv	s3,a0
 984:	892e                	mv	s2,a1
    struct Node *temp = *head_ref, *prev = 0;
 986:	6104                	ld	s1,0(a0)

    acquire(&list_lock);
 988:	00000517          	auipc	a0,0x0
 98c:	68050513          	add	a0,a0,1664 # 1008 <list_lock>
 990:	00000097          	auipc	ra,0x0
 994:	a0a080e7          	jalr	-1526(ra) # 39a <acquire>
    if (temp != 0 && temp->data == key) {
 998:	c0b1                	beqz	s1,9dc <deleteNode+0x68>
 99a:	409c                	lw	a5,0(s1)
 99c:	4701                	li	a4,0
 99e:	01278a63          	beq	a5,s2,9b2 <deleteNode+0x3e>
        rcusync();
        free(temp);
        return;
    }

    while (temp != 0 && temp->data != key) {
 9a2:	409c                	lw	a5,0(s1)
 9a4:	05278563          	beq	a5,s2,9ee <deleteNode+0x7a>
        prev = temp;
        temp = temp->next;
 9a8:	649c                	ld	a5,8(s1)
    while (temp != 0 && temp->data != key) {
 9aa:	8726                	mv	a4,s1
 9ac:	cb85                	beqz	a5,9dc <deleteNode+0x68>
        temp = temp->next;
 9ae:	84be                	mv	s1,a5
 9b0:	bfcd                	j	9a2 <deleteNode+0x2e>
        *head_ref = temp->next;
 9b2:	649c                	ld	a5,8(s1)
 9b4:	00f9b023          	sd	a5,0(s3)
        release(&list_lock);
 9b8:	00000517          	auipc	a0,0x0
 9bc:	65050513          	add	a0,a0,1616 # 1008 <list_lock>
 9c0:	00000097          	auipc	ra,0x0
 9c4:	9f2080e7          	jalr	-1550(ra) # 3b2 <release>
        rcusync();
 9c8:	00000097          	auipc	ra,0x0
 9cc:	ab6080e7          	jalr	-1354(ra) # 47e <rcusync>
        free(temp);
 9d0:	8526                	mv	a0,s1
 9d2:	00000097          	auipc	ra,0x0
 9d6:	dea080e7          	jalr	-534(ra) # 7bc <free>
        return;
 9da:	a82d                	j	a14 <deleteNode+0xa0>
    }

    if (temp == 0) {
        release(&list_lock);
 9dc:	00000517          	auipc	a0,0x0
 9e0:	62c50513          	add	a0,a0,1580 # 1008 <list_lock>
 9e4:	00000097          	auipc	ra,0x0
 9e8:	9ce080e7          	jalr	-1586(ra) # 3b2 <release>
        return;
 9ec:	a025                	j	a14 <deleteNode+0xa0>
    }
    prev->next = temp->next;
 9ee:	649c                	ld	a5,8(s1)
 9f0:	e71c                	sd	a5,8(a4)
    release(&list_lock);
 9f2:	00000517          	auipc	a0,0x0
 9f6:	61650513          	add	a0,a0,1558 # 1008 <list_lock>
 9fa:	00000097          	auipc	ra,0x0
 9fe:	9b8080e7          	jalr	-1608(ra) # 3b2 <release>
    rcusync();
 a02:	00000097          	auipc	ra,0x0
 a06:	a7c080e7          	jalr	-1412(ra) # 47e <rcusync>
    free(temp);
 a0a:	8526                	mv	a0,s1
 a0c:	00000097          	auipc	ra,0x0
 a10:	db0080e7          	jalr	-592(ra) # 7bc <free>
}
 a14:	70a2                	ld	ra,40(sp)
 a16:	7402                	ld	s0,32(sp)
 a18:	64e2                	ld	s1,24(sp)
 a1a:	6942                	ld	s2,16(sp)
 a1c:	69a2                	ld	s3,8(sp)
 a1e:	6145                	add	sp,sp,48
 a20:	8082                	ret

0000000000000a22 <search>:

// Function to search for a node with a given key in the linked list
struct Node* search(struct Node *head, int key) {
 a22:	1101                	add	sp,sp,-32
 a24:	ec06                	sd	ra,24(sp)
 a26:	e822                	sd	s0,16(sp)
 a28:	e426                	sd	s1,8(sp)
 a2a:	e04a                	sd	s2,0(sp)
 a2c:	1000                	add	s0,sp,32
 a2e:	84aa                	mv	s1,a0
 a30:	892e                	mv	s2,a1

    struct Node *current = head;
    rcureadlock();
 a32:	00000097          	auipc	ra,0x0
 a36:	a3c080e7          	jalr	-1476(ra) # 46e <rcureadlock>
    while (current != 0) {
 a3a:	c491                	beqz	s1,a46 <search+0x24>
        if (current->data == key) {
 a3c:	409c                	lw	a5,0(s1)
 a3e:	01278f63          	beq	a5,s2,a5c <search+0x3a>
            rcureadunlock();
            return current; // Node found
        }
        current = current->next;
 a42:	6484                	ld	s1,8(s1)
    while (current != 0) {
 a44:	fce5                	bnez	s1,a3c <search+0x1a>
    }
    rcureadunlock();
 a46:	00000097          	auipc	ra,0x0
 a4a:	a30080e7          	jalr	-1488(ra) # 476 <rcureadunlock>
    return 0; // Node not found
 a4e:	4501                	li	a0,0
}
 a50:	60e2                	ld	ra,24(sp)
 a52:	6442                	ld	s0,16(sp)
 a54:	64a2                	ld	s1,8(sp)
 a56:	6902                	ld	s2,0(sp)
 a58:	6105                	add	sp,sp,32
 a5a:	8082                	ret
            rcureadunlock();
 a5c:	00000097          	auipc	ra,0x0
 a60:	a1a080e7          	jalr	-1510(ra) # 476 <rcureadunlock>
            return current; // Node found
 a64:	8526                	mv	a0,s1
 a66:	b7ed                	j	a50 <search+0x2e>

0000000000000a68 <updateNode>:

// Function to update the value of a node with a given key in the linked list
void updateNode(struct Node *head, int key, int new_data) {
 a68:	1101                	add	sp,sp,-32
 a6a:	ec06                	sd	ra,24(sp)
 a6c:	e822                	sd	s0,16(sp)
 a6e:	e426                	sd	s1,8(sp)
 a70:	e04a                	sd	s2,0(sp)
 a72:	1000                	add	s0,sp,32
 a74:	892e                	mv	s2,a1
 a76:	84b2                	mv	s1,a2
    struct Node *nodeToUpdate = search(head, key);
 a78:	00000097          	auipc	ra,0x0
 a7c:	faa080e7          	jalr	-86(ra) # a22 <search>

    if (nodeToUpdate != 0) {
 a80:	c901                	beqz	a0,a90 <updateNode+0x28>
        nodeToUpdate->data = new_data; // Update the node's data
 a82:	c104                	sw	s1,0(a0)
    } else {
        printf("Node with key %d not found.\n", key);
    }
}
 a84:	60e2                	ld	ra,24(sp)
 a86:	6442                	ld	s0,16(sp)
 a88:	64a2                	ld	s1,8(sp)
 a8a:	6902                	ld	s2,0(sp)
 a8c:	6105                	add	sp,sp,32
 a8e:	8082                	ret
        printf("Node with key %d not found.\n", key);
 a90:	85ca                	mv	a1,s2
 a92:	00000517          	auipc	a0,0x0
 a96:	0d650513          	add	a0,a0,214 # b68 <digits+0x18>
 a9a:	00000097          	auipc	ra,0x0
 a9e:	cec080e7          	jalr	-788(ra) # 786 <printf>
}
 aa2:	b7cd                	j	a84 <updateNode+0x1c>
