
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	7179                	add	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	add	s0,sp,48
   e:	89aa                	mv	s3,a0
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  10:	00001917          	auipc	s2,0x1
  14:	00090913          	mv	s2,s2
  18:	20000613          	li	a2,512
  1c:	85ca                	mv	a1,s2
  1e:	854e                	mv	a0,s3
  20:	00000097          	auipc	ra,0x0
  24:	3d6080e7          	jalr	982(ra) # 3f6 <read>
  28:	84aa                	mv	s1,a0
  2a:	02a05963          	blez	a0,5c <cat+0x5c>
    if (write(1, buf, n) != n) {
  2e:	8626                	mv	a2,s1
  30:	85ca                	mv	a1,s2
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	3ca080e7          	jalr	970(ra) # 3fe <write>
  3c:	fc950ee3          	beq	a0,s1,18 <cat+0x18>
      fprintf(2, "cat: write error\n");
  40:	00001597          	auipc	a1,0x1
  44:	a8058593          	add	a1,a1,-1408 # ac0 <updateNode+0x48>
  48:	4509                	li	a0,2
  4a:	00000097          	auipc	ra,0x0
  4e:	71e080e7          	jalr	1822(ra) # 768 <fprintf>
      exit(1);
  52:	4505                	li	a0,1
  54:	00000097          	auipc	ra,0x0
  58:	38a080e7          	jalr	906(ra) # 3de <exit>
    }
  }
  if(n < 0){
  5c:	00054963          	bltz	a0,6e <cat+0x6e>
    fprintf(2, "cat: read error\n");
    exit(1);
  }
}
  60:	70a2                	ld	ra,40(sp)
  62:	7402                	ld	s0,32(sp)
  64:	64e2                	ld	s1,24(sp)
  66:	6942                	ld	s2,16(sp)
  68:	69a2                	ld	s3,8(sp)
  6a:	6145                	add	sp,sp,48
  6c:	8082                	ret
    fprintf(2, "cat: read error\n");
  6e:	00001597          	auipc	a1,0x1
  72:	a6a58593          	add	a1,a1,-1430 # ad8 <updateNode+0x60>
  76:	4509                	li	a0,2
  78:	00000097          	auipc	ra,0x0
  7c:	6f0080e7          	jalr	1776(ra) # 768 <fprintf>
    exit(1);
  80:	4505                	li	a0,1
  82:	00000097          	auipc	ra,0x0
  86:	35c080e7          	jalr	860(ra) # 3de <exit>

000000000000008a <main>:

int
main(int argc, char *argv[])
{
  8a:	7179                	add	sp,sp,-48
  8c:	f406                	sd	ra,40(sp)
  8e:	f022                	sd	s0,32(sp)
  90:	ec26                	sd	s1,24(sp)
  92:	e84a                	sd	s2,16(sp)
  94:	e44e                	sd	s3,8(sp)
  96:	1800                	add	s0,sp,48
  int fd, i;

  if(argc <= 1){
  98:	4785                	li	a5,1
  9a:	04a7d763          	bge	a5,a0,e8 <main+0x5e>
  9e:	00858913          	add	s2,a1,8
  a2:	ffe5099b          	addw	s3,a0,-2
  a6:	02099793          	sll	a5,s3,0x20
  aa:	01d7d993          	srl	s3,a5,0x1d
  ae:	05c1                	add	a1,a1,16
  b0:	99ae                	add	s3,s3,a1
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  b2:	4581                	li	a1,0
  b4:	00093503          	ld	a0,0(s2) # 1010 <buf>
  b8:	00000097          	auipc	ra,0x0
  bc:	366080e7          	jalr	870(ra) # 41e <open>
  c0:	84aa                	mv	s1,a0
  c2:	02054d63          	bltz	a0,fc <main+0x72>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
      exit(1);
    }
    cat(fd);
  c6:	00000097          	auipc	ra,0x0
  ca:	f3a080e7          	jalr	-198(ra) # 0 <cat>
    close(fd);
  ce:	8526                	mv	a0,s1
  d0:	00000097          	auipc	ra,0x0
  d4:	336080e7          	jalr	822(ra) # 406 <close>
  for(i = 1; i < argc; i++){
  d8:	0921                	add	s2,s2,8
  da:	fd391ce3          	bne	s2,s3,b2 <main+0x28>
  }
  exit(0);
  de:	4501                	li	a0,0
  e0:	00000097          	auipc	ra,0x0
  e4:	2fe080e7          	jalr	766(ra) # 3de <exit>
    cat(0);
  e8:	4501                	li	a0,0
  ea:	00000097          	auipc	ra,0x0
  ee:	f16080e7          	jalr	-234(ra) # 0 <cat>
    exit(0);
  f2:	4501                	li	a0,0
  f4:	00000097          	auipc	ra,0x0
  f8:	2ea080e7          	jalr	746(ra) # 3de <exit>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
  fc:	00093603          	ld	a2,0(s2)
 100:	00001597          	auipc	a1,0x1
 104:	9f058593          	add	a1,a1,-1552 # af0 <updateNode+0x78>
 108:	4509                	li	a0,2
 10a:	00000097          	auipc	ra,0x0
 10e:	65e080e7          	jalr	1630(ra) # 768 <fprintf>
      exit(1);
 112:	4505                	li	a0,1
 114:	00000097          	auipc	ra,0x0
 118:	2ca080e7          	jalr	714(ra) # 3de <exit>

000000000000011c <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 11c:	1141                	add	sp,sp,-16
 11e:	e406                	sd	ra,8(sp)
 120:	e022                	sd	s0,0(sp)
 122:	0800                	add	s0,sp,16
  extern int main();
  main();
 124:	00000097          	auipc	ra,0x0
 128:	f66080e7          	jalr	-154(ra) # 8a <main>
  exit(0);
 12c:	4501                	li	a0,0
 12e:	00000097          	auipc	ra,0x0
 132:	2b0080e7          	jalr	688(ra) # 3de <exit>

0000000000000136 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 136:	1141                	add	sp,sp,-16
 138:	e422                	sd	s0,8(sp)
 13a:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 13c:	87aa                	mv	a5,a0
 13e:	0585                	add	a1,a1,1
 140:	0785                	add	a5,a5,1
 142:	fff5c703          	lbu	a4,-1(a1)
 146:	fee78fa3          	sb	a4,-1(a5)
 14a:	fb75                	bnez	a4,13e <strcpy+0x8>
    ;
  return os;
}
 14c:	6422                	ld	s0,8(sp)
 14e:	0141                	add	sp,sp,16
 150:	8082                	ret

0000000000000152 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 152:	1141                	add	sp,sp,-16
 154:	e422                	sd	s0,8(sp)
 156:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 158:	00054783          	lbu	a5,0(a0)
 15c:	cb91                	beqz	a5,170 <strcmp+0x1e>
 15e:	0005c703          	lbu	a4,0(a1)
 162:	00f71763          	bne	a4,a5,170 <strcmp+0x1e>
    p++, q++;
 166:	0505                	add	a0,a0,1
 168:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 16a:	00054783          	lbu	a5,0(a0)
 16e:	fbe5                	bnez	a5,15e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 170:	0005c503          	lbu	a0,0(a1)
}
 174:	40a7853b          	subw	a0,a5,a0
 178:	6422                	ld	s0,8(sp)
 17a:	0141                	add	sp,sp,16
 17c:	8082                	ret

000000000000017e <strlen>:

uint
strlen(const char *s)
{
 17e:	1141                	add	sp,sp,-16
 180:	e422                	sd	s0,8(sp)
 182:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 184:	00054783          	lbu	a5,0(a0)
 188:	cf91                	beqz	a5,1a4 <strlen+0x26>
 18a:	0505                	add	a0,a0,1
 18c:	87aa                	mv	a5,a0
 18e:	86be                	mv	a3,a5
 190:	0785                	add	a5,a5,1
 192:	fff7c703          	lbu	a4,-1(a5)
 196:	ff65                	bnez	a4,18e <strlen+0x10>
 198:	40a6853b          	subw	a0,a3,a0
 19c:	2505                	addw	a0,a0,1
    ;
  return n;
}
 19e:	6422                	ld	s0,8(sp)
 1a0:	0141                	add	sp,sp,16
 1a2:	8082                	ret
  for(n = 0; s[n]; n++)
 1a4:	4501                	li	a0,0
 1a6:	bfe5                	j	19e <strlen+0x20>

00000000000001a8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1a8:	1141                	add	sp,sp,-16
 1aa:	e422                	sd	s0,8(sp)
 1ac:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1ae:	ca19                	beqz	a2,1c4 <memset+0x1c>
 1b0:	87aa                	mv	a5,a0
 1b2:	1602                	sll	a2,a2,0x20
 1b4:	9201                	srl	a2,a2,0x20
 1b6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1ba:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1be:	0785                	add	a5,a5,1
 1c0:	fee79de3          	bne	a5,a4,1ba <memset+0x12>
  }
  return dst;
}
 1c4:	6422                	ld	s0,8(sp)
 1c6:	0141                	add	sp,sp,16
 1c8:	8082                	ret

00000000000001ca <strchr>:

char*
strchr(const char *s, char c)
{
 1ca:	1141                	add	sp,sp,-16
 1cc:	e422                	sd	s0,8(sp)
 1ce:	0800                	add	s0,sp,16
  for(; *s; s++)
 1d0:	00054783          	lbu	a5,0(a0)
 1d4:	cb99                	beqz	a5,1ea <strchr+0x20>
    if(*s == c)
 1d6:	00f58763          	beq	a1,a5,1e4 <strchr+0x1a>
  for(; *s; s++)
 1da:	0505                	add	a0,a0,1
 1dc:	00054783          	lbu	a5,0(a0)
 1e0:	fbfd                	bnez	a5,1d6 <strchr+0xc>
      return (char*)s;
  return 0;
 1e2:	4501                	li	a0,0
}
 1e4:	6422                	ld	s0,8(sp)
 1e6:	0141                	add	sp,sp,16
 1e8:	8082                	ret
  return 0;
 1ea:	4501                	li	a0,0
 1ec:	bfe5                	j	1e4 <strchr+0x1a>

00000000000001ee <gets>:

char*
gets(char *buf, int max)
{
 1ee:	711d                	add	sp,sp,-96
 1f0:	ec86                	sd	ra,88(sp)
 1f2:	e8a2                	sd	s0,80(sp)
 1f4:	e4a6                	sd	s1,72(sp)
 1f6:	e0ca                	sd	s2,64(sp)
 1f8:	fc4e                	sd	s3,56(sp)
 1fa:	f852                	sd	s4,48(sp)
 1fc:	f456                	sd	s5,40(sp)
 1fe:	f05a                	sd	s6,32(sp)
 200:	ec5e                	sd	s7,24(sp)
 202:	1080                	add	s0,sp,96
 204:	8baa                	mv	s7,a0
 206:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 208:	892a                	mv	s2,a0
 20a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 20c:	4aa9                	li	s5,10
 20e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 210:	89a6                	mv	s3,s1
 212:	2485                	addw	s1,s1,1
 214:	0344d863          	bge	s1,s4,244 <gets+0x56>
    cc = read(0, &c, 1);
 218:	4605                	li	a2,1
 21a:	faf40593          	add	a1,s0,-81
 21e:	4501                	li	a0,0
 220:	00000097          	auipc	ra,0x0
 224:	1d6080e7          	jalr	470(ra) # 3f6 <read>
    if(cc < 1)
 228:	00a05e63          	blez	a0,244 <gets+0x56>
    buf[i++] = c;
 22c:	faf44783          	lbu	a5,-81(s0)
 230:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 234:	01578763          	beq	a5,s5,242 <gets+0x54>
 238:	0905                	add	s2,s2,1
 23a:	fd679be3          	bne	a5,s6,210 <gets+0x22>
  for(i=0; i+1 < max; ){
 23e:	89a6                	mv	s3,s1
 240:	a011                	j	244 <gets+0x56>
 242:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 244:	99de                	add	s3,s3,s7
 246:	00098023          	sb	zero,0(s3)
  return buf;
}
 24a:	855e                	mv	a0,s7
 24c:	60e6                	ld	ra,88(sp)
 24e:	6446                	ld	s0,80(sp)
 250:	64a6                	ld	s1,72(sp)
 252:	6906                	ld	s2,64(sp)
 254:	79e2                	ld	s3,56(sp)
 256:	7a42                	ld	s4,48(sp)
 258:	7aa2                	ld	s5,40(sp)
 25a:	7b02                	ld	s6,32(sp)
 25c:	6be2                	ld	s7,24(sp)
 25e:	6125                	add	sp,sp,96
 260:	8082                	ret

0000000000000262 <stat>:

int
stat(const char *n, struct stat *st)
{
 262:	1101                	add	sp,sp,-32
 264:	ec06                	sd	ra,24(sp)
 266:	e822                	sd	s0,16(sp)
 268:	e426                	sd	s1,8(sp)
 26a:	e04a                	sd	s2,0(sp)
 26c:	1000                	add	s0,sp,32
 26e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 270:	4581                	li	a1,0
 272:	00000097          	auipc	ra,0x0
 276:	1ac080e7          	jalr	428(ra) # 41e <open>
  if(fd < 0)
 27a:	02054563          	bltz	a0,2a4 <stat+0x42>
 27e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 280:	85ca                	mv	a1,s2
 282:	00000097          	auipc	ra,0x0
 286:	1b4080e7          	jalr	436(ra) # 436 <fstat>
 28a:	892a                	mv	s2,a0
  close(fd);
 28c:	8526                	mv	a0,s1
 28e:	00000097          	auipc	ra,0x0
 292:	178080e7          	jalr	376(ra) # 406 <close>
  return r;
}
 296:	854a                	mv	a0,s2
 298:	60e2                	ld	ra,24(sp)
 29a:	6442                	ld	s0,16(sp)
 29c:	64a2                	ld	s1,8(sp)
 29e:	6902                	ld	s2,0(sp)
 2a0:	6105                	add	sp,sp,32
 2a2:	8082                	ret
    return -1;
 2a4:	597d                	li	s2,-1
 2a6:	bfc5                	j	296 <stat+0x34>

00000000000002a8 <atoi>:

int
atoi(const char *s)
{
 2a8:	1141                	add	sp,sp,-16
 2aa:	e422                	sd	s0,8(sp)
 2ac:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2ae:	00054683          	lbu	a3,0(a0)
 2b2:	fd06879b          	addw	a5,a3,-48
 2b6:	0ff7f793          	zext.b	a5,a5
 2ba:	4625                	li	a2,9
 2bc:	02f66863          	bltu	a2,a5,2ec <atoi+0x44>
 2c0:	872a                	mv	a4,a0
  n = 0;
 2c2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2c4:	0705                	add	a4,a4,1
 2c6:	0025179b          	sllw	a5,a0,0x2
 2ca:	9fa9                	addw	a5,a5,a0
 2cc:	0017979b          	sllw	a5,a5,0x1
 2d0:	9fb5                	addw	a5,a5,a3
 2d2:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2d6:	00074683          	lbu	a3,0(a4)
 2da:	fd06879b          	addw	a5,a3,-48
 2de:	0ff7f793          	zext.b	a5,a5
 2e2:	fef671e3          	bgeu	a2,a5,2c4 <atoi+0x1c>
  return n;
}
 2e6:	6422                	ld	s0,8(sp)
 2e8:	0141                	add	sp,sp,16
 2ea:	8082                	ret
  n = 0;
 2ec:	4501                	li	a0,0
 2ee:	bfe5                	j	2e6 <atoi+0x3e>

00000000000002f0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2f0:	1141                	add	sp,sp,-16
 2f2:	e422                	sd	s0,8(sp)
 2f4:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2f6:	02b57463          	bgeu	a0,a1,31e <memmove+0x2e>
    while(n-- > 0)
 2fa:	00c05f63          	blez	a2,318 <memmove+0x28>
 2fe:	1602                	sll	a2,a2,0x20
 300:	9201                	srl	a2,a2,0x20
 302:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 306:	872a                	mv	a4,a0
      *dst++ = *src++;
 308:	0585                	add	a1,a1,1
 30a:	0705                	add	a4,a4,1
 30c:	fff5c683          	lbu	a3,-1(a1)
 310:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 314:	fee79ae3          	bne	a5,a4,308 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 318:	6422                	ld	s0,8(sp)
 31a:	0141                	add	sp,sp,16
 31c:	8082                	ret
    dst += n;
 31e:	00c50733          	add	a4,a0,a2
    src += n;
 322:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 324:	fec05ae3          	blez	a2,318 <memmove+0x28>
 328:	fff6079b          	addw	a5,a2,-1
 32c:	1782                	sll	a5,a5,0x20
 32e:	9381                	srl	a5,a5,0x20
 330:	fff7c793          	not	a5,a5
 334:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 336:	15fd                	add	a1,a1,-1
 338:	177d                	add	a4,a4,-1
 33a:	0005c683          	lbu	a3,0(a1)
 33e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 342:	fee79ae3          	bne	a5,a4,336 <memmove+0x46>
 346:	bfc9                	j	318 <memmove+0x28>

0000000000000348 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 348:	1141                	add	sp,sp,-16
 34a:	e422                	sd	s0,8(sp)
 34c:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 34e:	ca05                	beqz	a2,37e <memcmp+0x36>
 350:	fff6069b          	addw	a3,a2,-1
 354:	1682                	sll	a3,a3,0x20
 356:	9281                	srl	a3,a3,0x20
 358:	0685                	add	a3,a3,1
 35a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 35c:	00054783          	lbu	a5,0(a0)
 360:	0005c703          	lbu	a4,0(a1)
 364:	00e79863          	bne	a5,a4,374 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 368:	0505                	add	a0,a0,1
    p2++;
 36a:	0585                	add	a1,a1,1
  while (n-- > 0) {
 36c:	fed518e3          	bne	a0,a3,35c <memcmp+0x14>
  }
  return 0;
 370:	4501                	li	a0,0
 372:	a019                	j	378 <memcmp+0x30>
      return *p1 - *p2;
 374:	40e7853b          	subw	a0,a5,a4
}
 378:	6422                	ld	s0,8(sp)
 37a:	0141                	add	sp,sp,16
 37c:	8082                	ret
  return 0;
 37e:	4501                	li	a0,0
 380:	bfe5                	j	378 <memcmp+0x30>

0000000000000382 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 382:	1141                	add	sp,sp,-16
 384:	e406                	sd	ra,8(sp)
 386:	e022                	sd	s0,0(sp)
 388:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 38a:	00000097          	auipc	ra,0x0
 38e:	f66080e7          	jalr	-154(ra) # 2f0 <memmove>
}
 392:	60a2                	ld	ra,8(sp)
 394:	6402                	ld	s0,0(sp)
 396:	0141                	add	sp,sp,16
 398:	8082                	ret

000000000000039a <initlock>:

// Initialize the spinlock
void initlock(struct spinlock_u *lk) {
 39a:	1141                	add	sp,sp,-16
 39c:	e422                	sd	s0,8(sp)
 39e:	0800                	add	s0,sp,16
  lk->locked = 0;
 3a0:	00052023          	sw	zero,0(a0)
}
 3a4:	6422                	ld	s0,8(sp)
 3a6:	0141                	add	sp,sp,16
 3a8:	8082                	ret

00000000000003aa <acquire>:

// Acquire the spinlock
void acquire(struct spinlock_u *lk) {
 3aa:	1141                	add	sp,sp,-16
 3ac:	e422                	sd	s0,8(sp)
 3ae:	0800                	add	s0,sp,16
  while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 3b0:	4705                	li	a4,1
 3b2:	87ba                	mv	a5,a4
 3b4:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
 3b8:	2781                	sext.w	a5,a5
 3ba:	ffe5                	bnez	a5,3b2 <acquire+0x8>
    ; // Spin until the lock is acquired
}
 3bc:	6422                	ld	s0,8(sp)
 3be:	0141                	add	sp,sp,16
 3c0:	8082                	ret

00000000000003c2 <release>:

// Release the spinlock
void release(struct spinlock_u *lk) {
 3c2:	1141                	add	sp,sp,-16
 3c4:	e422                	sd	s0,8(sp)
 3c6:	0800                	add	s0,sp,16
  __sync_lock_release(&lk->locked);
 3c8:	0f50000f          	fence	iorw,ow
 3cc:	0805202f          	amoswap.w	zero,zero,(a0)
}
 3d0:	6422                	ld	s0,8(sp)
 3d2:	0141                	add	sp,sp,16
 3d4:	8082                	ret

00000000000003d6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3d6:	4885                	li	a7,1
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <exit>:
.global exit
exit:
 li a7, SYS_exit
 3de:	4889                	li	a7,2
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3e6:	488d                	li	a7,3
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3ee:	4891                	li	a7,4
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <read>:
.global read
read:
 li a7, SYS_read
 3f6:	4895                	li	a7,5
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <write>:
.global write
write:
 li a7, SYS_write
 3fe:	48c1                	li	a7,16
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <close>:
.global close
close:
 li a7, SYS_close
 406:	48d5                	li	a7,21
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <kill>:
.global kill
kill:
 li a7, SYS_kill
 40e:	4899                	li	a7,6
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <exec>:
.global exec
exec:
 li a7, SYS_exec
 416:	489d                	li	a7,7
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <open>:
.global open
open:
 li a7, SYS_open
 41e:	48bd                	li	a7,15
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 426:	48c5                	li	a7,17
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 42e:	48c9                	li	a7,18
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 436:	48a1                	li	a7,8
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <link>:
.global link
link:
 li a7, SYS_link
 43e:	48cd                	li	a7,19
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 446:	48d1                	li	a7,20
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 44e:	48a5                	li	a7,9
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <dup>:
.global dup
dup:
 li a7, SYS_dup
 456:	48a9                	li	a7,10
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 45e:	48ad                	li	a7,11
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 466:	48b1                	li	a7,12
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 46e:	48b5                	li	a7,13
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 476:	48b9                	li	a7,14
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <rcureadlock>:
.global rcureadlock
rcureadlock:
 li a7, SYS_rcureadlock
 47e:	48dd                	li	a7,23
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <rcureadunlock>:
.global rcureadunlock
rcureadunlock:
 li a7, SYS_rcureadunlock
 486:	48e1                	li	a7,24
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <rcusync>:
.global rcusync
rcusync:
 li a7, SYS_rcusync
 48e:	48d9                	li	a7,22
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <thread_create>:
.global thread_create
thread_create:
 li a7, SYS_thread_create
 496:	48e5                	li	a7,25
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <thread_join>:
.global thread_join
thread_join:
 li a7, SYS_thread_join
 49e:	48e9                	li	a7,26
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <thread_exit>:
.global thread_exit
thread_exit:
 li a7, SYS_thread_exit
 4a6:	48ed                	li	a7,27
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <klist_insert>:
.global klist_insert
klist_insert:
 li a7, SYS_klist_insert
 4ae:	48f1                	li	a7,28
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <klist_delete>:
.global klist_delete
klist_delete:
 li a7, SYS_klist_delete
 4b6:	48f5                	li	a7,29
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <klist_query>:
.global klist_query
klist_query:
 li a7, SYS_klist_query
 4be:	48f9                	li	a7,30
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <klist_print>:
.global klist_print
klist_print:
 li a7, SYS_klist_print
 4c6:	48fd                	li	a7,31
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4ce:	1101                	add	sp,sp,-32
 4d0:	ec06                	sd	ra,24(sp)
 4d2:	e822                	sd	s0,16(sp)
 4d4:	1000                	add	s0,sp,32
 4d6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4da:	4605                	li	a2,1
 4dc:	fef40593          	add	a1,s0,-17
 4e0:	00000097          	auipc	ra,0x0
 4e4:	f1e080e7          	jalr	-226(ra) # 3fe <write>
}
 4e8:	60e2                	ld	ra,24(sp)
 4ea:	6442                	ld	s0,16(sp)
 4ec:	6105                	add	sp,sp,32
 4ee:	8082                	ret

00000000000004f0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4f0:	7139                	add	sp,sp,-64
 4f2:	fc06                	sd	ra,56(sp)
 4f4:	f822                	sd	s0,48(sp)
 4f6:	f426                	sd	s1,40(sp)
 4f8:	f04a                	sd	s2,32(sp)
 4fa:	ec4e                	sd	s3,24(sp)
 4fc:	0080                	add	s0,sp,64
 4fe:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 500:	c299                	beqz	a3,506 <printint+0x16>
 502:	0805c963          	bltz	a1,594 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 506:	2581                	sext.w	a1,a1
  neg = 0;
 508:	4881                	li	a7,0
 50a:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 50e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 510:	2601                	sext.w	a2,a2
 512:	00000517          	auipc	a0,0x0
 516:	65650513          	add	a0,a0,1622 # b68 <digits>
 51a:	883a                	mv	a6,a4
 51c:	2705                	addw	a4,a4,1
 51e:	02c5f7bb          	remuw	a5,a1,a2
 522:	1782                	sll	a5,a5,0x20
 524:	9381                	srl	a5,a5,0x20
 526:	97aa                	add	a5,a5,a0
 528:	0007c783          	lbu	a5,0(a5)
 52c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 530:	0005879b          	sext.w	a5,a1
 534:	02c5d5bb          	divuw	a1,a1,a2
 538:	0685                	add	a3,a3,1
 53a:	fec7f0e3          	bgeu	a5,a2,51a <printint+0x2a>
  if(neg)
 53e:	00088c63          	beqz	a7,556 <printint+0x66>
    buf[i++] = '-';
 542:	fd070793          	add	a5,a4,-48
 546:	00878733          	add	a4,a5,s0
 54a:	02d00793          	li	a5,45
 54e:	fef70823          	sb	a5,-16(a4)
 552:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 556:	02e05863          	blez	a4,586 <printint+0x96>
 55a:	fc040793          	add	a5,s0,-64
 55e:	00e78933          	add	s2,a5,a4
 562:	fff78993          	add	s3,a5,-1
 566:	99ba                	add	s3,s3,a4
 568:	377d                	addw	a4,a4,-1
 56a:	1702                	sll	a4,a4,0x20
 56c:	9301                	srl	a4,a4,0x20
 56e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 572:	fff94583          	lbu	a1,-1(s2)
 576:	8526                	mv	a0,s1
 578:	00000097          	auipc	ra,0x0
 57c:	f56080e7          	jalr	-170(ra) # 4ce <putc>
  while(--i >= 0)
 580:	197d                	add	s2,s2,-1
 582:	ff3918e3          	bne	s2,s3,572 <printint+0x82>
}
 586:	70e2                	ld	ra,56(sp)
 588:	7442                	ld	s0,48(sp)
 58a:	74a2                	ld	s1,40(sp)
 58c:	7902                	ld	s2,32(sp)
 58e:	69e2                	ld	s3,24(sp)
 590:	6121                	add	sp,sp,64
 592:	8082                	ret
    x = -xx;
 594:	40b005bb          	negw	a1,a1
    neg = 1;
 598:	4885                	li	a7,1
    x = -xx;
 59a:	bf85                	j	50a <printint+0x1a>

000000000000059c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 59c:	715d                	add	sp,sp,-80
 59e:	e486                	sd	ra,72(sp)
 5a0:	e0a2                	sd	s0,64(sp)
 5a2:	fc26                	sd	s1,56(sp)
 5a4:	f84a                	sd	s2,48(sp)
 5a6:	f44e                	sd	s3,40(sp)
 5a8:	f052                	sd	s4,32(sp)
 5aa:	ec56                	sd	s5,24(sp)
 5ac:	e85a                	sd	s6,16(sp)
 5ae:	e45e                	sd	s7,8(sp)
 5b0:	e062                	sd	s8,0(sp)
 5b2:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5b4:	0005c903          	lbu	s2,0(a1)
 5b8:	18090c63          	beqz	s2,750 <vprintf+0x1b4>
 5bc:	8aaa                	mv	s5,a0
 5be:	8bb2                	mv	s7,a2
 5c0:	00158493          	add	s1,a1,1
  state = 0;
 5c4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5c6:	02500a13          	li	s4,37
 5ca:	4b55                	li	s6,21
 5cc:	a839                	j	5ea <vprintf+0x4e>
        putc(fd, c);
 5ce:	85ca                	mv	a1,s2
 5d0:	8556                	mv	a0,s5
 5d2:	00000097          	auipc	ra,0x0
 5d6:	efc080e7          	jalr	-260(ra) # 4ce <putc>
 5da:	a019                	j	5e0 <vprintf+0x44>
    } else if(state == '%'){
 5dc:	01498d63          	beq	s3,s4,5f6 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 5e0:	0485                	add	s1,s1,1
 5e2:	fff4c903          	lbu	s2,-1(s1)
 5e6:	16090563          	beqz	s2,750 <vprintf+0x1b4>
    if(state == 0){
 5ea:	fe0999e3          	bnez	s3,5dc <vprintf+0x40>
      if(c == '%'){
 5ee:	ff4910e3          	bne	s2,s4,5ce <vprintf+0x32>
        state = '%';
 5f2:	89d2                	mv	s3,s4
 5f4:	b7f5                	j	5e0 <vprintf+0x44>
      if(c == 'd'){
 5f6:	13490263          	beq	s2,s4,71a <vprintf+0x17e>
 5fa:	f9d9079b          	addw	a5,s2,-99
 5fe:	0ff7f793          	zext.b	a5,a5
 602:	12fb6563          	bltu	s6,a5,72c <vprintf+0x190>
 606:	f9d9079b          	addw	a5,s2,-99
 60a:	0ff7f713          	zext.b	a4,a5
 60e:	10eb6f63          	bltu	s6,a4,72c <vprintf+0x190>
 612:	00271793          	sll	a5,a4,0x2
 616:	00000717          	auipc	a4,0x0
 61a:	4fa70713          	add	a4,a4,1274 # b10 <updateNode+0x98>
 61e:	97ba                	add	a5,a5,a4
 620:	439c                	lw	a5,0(a5)
 622:	97ba                	add	a5,a5,a4
 624:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 626:	008b8913          	add	s2,s7,8
 62a:	4685                	li	a3,1
 62c:	4629                	li	a2,10
 62e:	000ba583          	lw	a1,0(s7)
 632:	8556                	mv	a0,s5
 634:	00000097          	auipc	ra,0x0
 638:	ebc080e7          	jalr	-324(ra) # 4f0 <printint>
 63c:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 63e:	4981                	li	s3,0
 640:	b745                	j	5e0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 642:	008b8913          	add	s2,s7,8
 646:	4681                	li	a3,0
 648:	4629                	li	a2,10
 64a:	000ba583          	lw	a1,0(s7)
 64e:	8556                	mv	a0,s5
 650:	00000097          	auipc	ra,0x0
 654:	ea0080e7          	jalr	-352(ra) # 4f0 <printint>
 658:	8bca                	mv	s7,s2
      state = 0;
 65a:	4981                	li	s3,0
 65c:	b751                	j	5e0 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 65e:	008b8913          	add	s2,s7,8
 662:	4681                	li	a3,0
 664:	4641                	li	a2,16
 666:	000ba583          	lw	a1,0(s7)
 66a:	8556                	mv	a0,s5
 66c:	00000097          	auipc	ra,0x0
 670:	e84080e7          	jalr	-380(ra) # 4f0 <printint>
 674:	8bca                	mv	s7,s2
      state = 0;
 676:	4981                	li	s3,0
 678:	b7a5                	j	5e0 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 67a:	008b8c13          	add	s8,s7,8
 67e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 682:	03000593          	li	a1,48
 686:	8556                	mv	a0,s5
 688:	00000097          	auipc	ra,0x0
 68c:	e46080e7          	jalr	-442(ra) # 4ce <putc>
  putc(fd, 'x');
 690:	07800593          	li	a1,120
 694:	8556                	mv	a0,s5
 696:	00000097          	auipc	ra,0x0
 69a:	e38080e7          	jalr	-456(ra) # 4ce <putc>
 69e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6a0:	00000b97          	auipc	s7,0x0
 6a4:	4c8b8b93          	add	s7,s7,1224 # b68 <digits>
 6a8:	03c9d793          	srl	a5,s3,0x3c
 6ac:	97de                	add	a5,a5,s7
 6ae:	0007c583          	lbu	a1,0(a5)
 6b2:	8556                	mv	a0,s5
 6b4:	00000097          	auipc	ra,0x0
 6b8:	e1a080e7          	jalr	-486(ra) # 4ce <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6bc:	0992                	sll	s3,s3,0x4
 6be:	397d                	addw	s2,s2,-1
 6c0:	fe0914e3          	bnez	s2,6a8 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 6c4:	8be2                	mv	s7,s8
      state = 0;
 6c6:	4981                	li	s3,0
 6c8:	bf21                	j	5e0 <vprintf+0x44>
        s = va_arg(ap, char*);
 6ca:	008b8993          	add	s3,s7,8
 6ce:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 6d2:	02090163          	beqz	s2,6f4 <vprintf+0x158>
        while(*s != 0){
 6d6:	00094583          	lbu	a1,0(s2)
 6da:	c9a5                	beqz	a1,74a <vprintf+0x1ae>
          putc(fd, *s);
 6dc:	8556                	mv	a0,s5
 6de:	00000097          	auipc	ra,0x0
 6e2:	df0080e7          	jalr	-528(ra) # 4ce <putc>
          s++;
 6e6:	0905                	add	s2,s2,1
        while(*s != 0){
 6e8:	00094583          	lbu	a1,0(s2)
 6ec:	f9e5                	bnez	a1,6dc <vprintf+0x140>
        s = va_arg(ap, char*);
 6ee:	8bce                	mv	s7,s3
      state = 0;
 6f0:	4981                	li	s3,0
 6f2:	b5fd                	j	5e0 <vprintf+0x44>
          s = "(null)";
 6f4:	00000917          	auipc	s2,0x0
 6f8:	41490913          	add	s2,s2,1044 # b08 <updateNode+0x90>
        while(*s != 0){
 6fc:	02800593          	li	a1,40
 700:	bff1                	j	6dc <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 702:	008b8913          	add	s2,s7,8
 706:	000bc583          	lbu	a1,0(s7)
 70a:	8556                	mv	a0,s5
 70c:	00000097          	auipc	ra,0x0
 710:	dc2080e7          	jalr	-574(ra) # 4ce <putc>
 714:	8bca                	mv	s7,s2
      state = 0;
 716:	4981                	li	s3,0
 718:	b5e1                	j	5e0 <vprintf+0x44>
        putc(fd, c);
 71a:	02500593          	li	a1,37
 71e:	8556                	mv	a0,s5
 720:	00000097          	auipc	ra,0x0
 724:	dae080e7          	jalr	-594(ra) # 4ce <putc>
      state = 0;
 728:	4981                	li	s3,0
 72a:	bd5d                	j	5e0 <vprintf+0x44>
        putc(fd, '%');
 72c:	02500593          	li	a1,37
 730:	8556                	mv	a0,s5
 732:	00000097          	auipc	ra,0x0
 736:	d9c080e7          	jalr	-612(ra) # 4ce <putc>
        putc(fd, c);
 73a:	85ca                	mv	a1,s2
 73c:	8556                	mv	a0,s5
 73e:	00000097          	auipc	ra,0x0
 742:	d90080e7          	jalr	-624(ra) # 4ce <putc>
      state = 0;
 746:	4981                	li	s3,0
 748:	bd61                	j	5e0 <vprintf+0x44>
        s = va_arg(ap, char*);
 74a:	8bce                	mv	s7,s3
      state = 0;
 74c:	4981                	li	s3,0
 74e:	bd49                	j	5e0 <vprintf+0x44>
    }
  }
}
 750:	60a6                	ld	ra,72(sp)
 752:	6406                	ld	s0,64(sp)
 754:	74e2                	ld	s1,56(sp)
 756:	7942                	ld	s2,48(sp)
 758:	79a2                	ld	s3,40(sp)
 75a:	7a02                	ld	s4,32(sp)
 75c:	6ae2                	ld	s5,24(sp)
 75e:	6b42                	ld	s6,16(sp)
 760:	6ba2                	ld	s7,8(sp)
 762:	6c02                	ld	s8,0(sp)
 764:	6161                	add	sp,sp,80
 766:	8082                	ret

0000000000000768 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 768:	715d                	add	sp,sp,-80
 76a:	ec06                	sd	ra,24(sp)
 76c:	e822                	sd	s0,16(sp)
 76e:	1000                	add	s0,sp,32
 770:	e010                	sd	a2,0(s0)
 772:	e414                	sd	a3,8(s0)
 774:	e818                	sd	a4,16(s0)
 776:	ec1c                	sd	a5,24(s0)
 778:	03043023          	sd	a6,32(s0)
 77c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 780:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 784:	8622                	mv	a2,s0
 786:	00000097          	auipc	ra,0x0
 78a:	e16080e7          	jalr	-490(ra) # 59c <vprintf>
}
 78e:	60e2                	ld	ra,24(sp)
 790:	6442                	ld	s0,16(sp)
 792:	6161                	add	sp,sp,80
 794:	8082                	ret

0000000000000796 <printf>:

void
printf(const char *fmt, ...)
{
 796:	711d                	add	sp,sp,-96
 798:	ec06                	sd	ra,24(sp)
 79a:	e822                	sd	s0,16(sp)
 79c:	1000                	add	s0,sp,32
 79e:	e40c                	sd	a1,8(s0)
 7a0:	e810                	sd	a2,16(s0)
 7a2:	ec14                	sd	a3,24(s0)
 7a4:	f018                	sd	a4,32(s0)
 7a6:	f41c                	sd	a5,40(s0)
 7a8:	03043823          	sd	a6,48(s0)
 7ac:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7b0:	00840613          	add	a2,s0,8
 7b4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7b8:	85aa                	mv	a1,a0
 7ba:	4505                	li	a0,1
 7bc:	00000097          	auipc	ra,0x0
 7c0:	de0080e7          	jalr	-544(ra) # 59c <vprintf>
}
 7c4:	60e2                	ld	ra,24(sp)
 7c6:	6442                	ld	s0,16(sp)
 7c8:	6125                	add	sp,sp,96
 7ca:	8082                	ret

00000000000007cc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7cc:	1141                	add	sp,sp,-16
 7ce:	e422                	sd	s0,8(sp)
 7d0:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7d2:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d6:	00001797          	auipc	a5,0x1
 7da:	82a7b783          	ld	a5,-2006(a5) # 1000 <freep>
 7de:	a02d                	j	808 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7e0:	4618                	lw	a4,8(a2)
 7e2:	9f2d                	addw	a4,a4,a1
 7e4:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7e8:	6398                	ld	a4,0(a5)
 7ea:	6310                	ld	a2,0(a4)
 7ec:	a83d                	j	82a <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7ee:	ff852703          	lw	a4,-8(a0)
 7f2:	9f31                	addw	a4,a4,a2
 7f4:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7f6:	ff053683          	ld	a3,-16(a0)
 7fa:	a091                	j	83e <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7fc:	6398                	ld	a4,0(a5)
 7fe:	00e7e463          	bltu	a5,a4,806 <free+0x3a>
 802:	00e6ea63          	bltu	a3,a4,816 <free+0x4a>
{
 806:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 808:	fed7fae3          	bgeu	a5,a3,7fc <free+0x30>
 80c:	6398                	ld	a4,0(a5)
 80e:	00e6e463          	bltu	a3,a4,816 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 812:	fee7eae3          	bltu	a5,a4,806 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 816:	ff852583          	lw	a1,-8(a0)
 81a:	6390                	ld	a2,0(a5)
 81c:	02059813          	sll	a6,a1,0x20
 820:	01c85713          	srl	a4,a6,0x1c
 824:	9736                	add	a4,a4,a3
 826:	fae60de3          	beq	a2,a4,7e0 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 82a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 82e:	4790                	lw	a2,8(a5)
 830:	02061593          	sll	a1,a2,0x20
 834:	01c5d713          	srl	a4,a1,0x1c
 838:	973e                	add	a4,a4,a5
 83a:	fae68ae3          	beq	a3,a4,7ee <free+0x22>
    p->s.ptr = bp->s.ptr;
 83e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 840:	00000717          	auipc	a4,0x0
 844:	7cf73023          	sd	a5,1984(a4) # 1000 <freep>
}
 848:	6422                	ld	s0,8(sp)
 84a:	0141                	add	sp,sp,16
 84c:	8082                	ret

000000000000084e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 84e:	7139                	add	sp,sp,-64
 850:	fc06                	sd	ra,56(sp)
 852:	f822                	sd	s0,48(sp)
 854:	f426                	sd	s1,40(sp)
 856:	f04a                	sd	s2,32(sp)
 858:	ec4e                	sd	s3,24(sp)
 85a:	e852                	sd	s4,16(sp)
 85c:	e456                	sd	s5,8(sp)
 85e:	e05a                	sd	s6,0(sp)
 860:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 862:	02051493          	sll	s1,a0,0x20
 866:	9081                	srl	s1,s1,0x20
 868:	04bd                	add	s1,s1,15
 86a:	8091                	srl	s1,s1,0x4
 86c:	0014899b          	addw	s3,s1,1
 870:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 872:	00000517          	auipc	a0,0x0
 876:	78e53503          	ld	a0,1934(a0) # 1000 <freep>
 87a:	c515                	beqz	a0,8a6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 87c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 87e:	4798                	lw	a4,8(a5)
 880:	02977f63          	bgeu	a4,s1,8be <malloc+0x70>
  if(nu < 4096)
 884:	8a4e                	mv	s4,s3
 886:	0009871b          	sext.w	a4,s3
 88a:	6685                	lui	a3,0x1
 88c:	00d77363          	bgeu	a4,a3,892 <malloc+0x44>
 890:	6a05                	lui	s4,0x1
 892:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 896:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 89a:	00000917          	auipc	s2,0x0
 89e:	76690913          	add	s2,s2,1894 # 1000 <freep>
  if(p == (char*)-1)
 8a2:	5afd                	li	s5,-1
 8a4:	a895                	j	918 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 8a6:	00001797          	auipc	a5,0x1
 8aa:	96a78793          	add	a5,a5,-1686 # 1210 <base>
 8ae:	00000717          	auipc	a4,0x0
 8b2:	74f73923          	sd	a5,1874(a4) # 1000 <freep>
 8b6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8b8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8bc:	b7e1                	j	884 <malloc+0x36>
      if(p->s.size == nunits)
 8be:	02e48c63          	beq	s1,a4,8f6 <malloc+0xa8>
        p->s.size -= nunits;
 8c2:	4137073b          	subw	a4,a4,s3
 8c6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8c8:	02071693          	sll	a3,a4,0x20
 8cc:	01c6d713          	srl	a4,a3,0x1c
 8d0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8d2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8d6:	00000717          	auipc	a4,0x0
 8da:	72a73523          	sd	a0,1834(a4) # 1000 <freep>
      return (void*)(p + 1);
 8de:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8e2:	70e2                	ld	ra,56(sp)
 8e4:	7442                	ld	s0,48(sp)
 8e6:	74a2                	ld	s1,40(sp)
 8e8:	7902                	ld	s2,32(sp)
 8ea:	69e2                	ld	s3,24(sp)
 8ec:	6a42                	ld	s4,16(sp)
 8ee:	6aa2                	ld	s5,8(sp)
 8f0:	6b02                	ld	s6,0(sp)
 8f2:	6121                	add	sp,sp,64
 8f4:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8f6:	6398                	ld	a4,0(a5)
 8f8:	e118                	sd	a4,0(a0)
 8fa:	bff1                	j	8d6 <malloc+0x88>
  hp->s.size = nu;
 8fc:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 900:	0541                	add	a0,a0,16
 902:	00000097          	auipc	ra,0x0
 906:	eca080e7          	jalr	-310(ra) # 7cc <free>
  return freep;
 90a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 90e:	d971                	beqz	a0,8e2 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 910:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 912:	4798                	lw	a4,8(a5)
 914:	fa9775e3          	bgeu	a4,s1,8be <malloc+0x70>
    if(p == freep)
 918:	00093703          	ld	a4,0(s2)
 91c:	853e                	mv	a0,a5
 91e:	fef719e3          	bne	a4,a5,910 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 922:	8552                	mv	a0,s4
 924:	00000097          	auipc	ra,0x0
 928:	b42080e7          	jalr	-1214(ra) # 466 <sbrk>
  if(p == (char*)-1)
 92c:	fd5518e3          	bne	a0,s5,8fc <malloc+0xae>
        return 0;
 930:	4501                	li	a0,0
 932:	bf45                	j	8e2 <malloc+0x94>

0000000000000934 <init_lock>:
#include "linkedlist.h"

// Define a node structure for the linked list
struct spinlock_u list_lock;

void init_lock(){
 934:	1141                	add	sp,sp,-16
 936:	e406                	sd	ra,8(sp)
 938:	e022                	sd	s0,0(sp)
 93a:	0800                	add	s0,sp,16
    initlock(&list_lock);
 93c:	00000517          	auipc	a0,0x0
 940:	6cc50513          	add	a0,a0,1740 # 1008 <list_lock>
 944:	00000097          	auipc	ra,0x0
 948:	a56080e7          	jalr	-1450(ra) # 39a <initlock>
}
 94c:	60a2                	ld	ra,8(sp)
 94e:	6402                	ld	s0,0(sp)
 950:	0141                	add	sp,sp,16
 952:	8082                	ret

0000000000000954 <insert>:

// Function to insert a node at the beginning of the linked list
void insert(struct Node **head_ref, int new_data) {
 954:	1101                	add	sp,sp,-32
 956:	ec06                	sd	ra,24(sp)
 958:	e822                	sd	s0,16(sp)
 95a:	e426                	sd	s1,8(sp)
 95c:	e04a                	sd	s2,0(sp)
 95e:	1000                	add	s0,sp,32
 960:	84aa                	mv	s1,a0
 962:	892e                	mv	s2,a1
    struct Node *new_node = malloc(sizeof(struct Node));
 964:	4541                	li	a0,16
 966:	00000097          	auipc	ra,0x0
 96a:	ee8080e7          	jalr	-280(ra) # 84e <malloc>
    new_node->data = new_data;
 96e:	01252023          	sw	s2,0(a0)
    new_node->next = *head_ref;
 972:	609c                	ld	a5,0(s1)
 974:	e51c                	sd	a5,8(a0)
    *head_ref = new_node;
 976:	e088                	sd	a0,0(s1)
}
 978:	60e2                	ld	ra,24(sp)
 97a:	6442                	ld	s0,16(sp)
 97c:	64a2                	ld	s1,8(sp)
 97e:	6902                	ld	s2,0(sp)
 980:	6105                	add	sp,sp,32
 982:	8082                	ret

0000000000000984 <deleteNode>:

// Function to delete a node with a given key from the linked list
void deleteNode(struct Node **head_ref, int key) {
 984:	7179                	add	sp,sp,-48
 986:	f406                	sd	ra,40(sp)
 988:	f022                	sd	s0,32(sp)
 98a:	ec26                	sd	s1,24(sp)
 98c:	e84a                	sd	s2,16(sp)
 98e:	e44e                	sd	s3,8(sp)
 990:	1800                	add	s0,sp,48
 992:	89aa                	mv	s3,a0
 994:	892e                	mv	s2,a1
    struct Node *temp = *head_ref, *prev = 0;
 996:	6104                	ld	s1,0(a0)

    acquire(&list_lock);
 998:	00000517          	auipc	a0,0x0
 99c:	67050513          	add	a0,a0,1648 # 1008 <list_lock>
 9a0:	00000097          	auipc	ra,0x0
 9a4:	a0a080e7          	jalr	-1526(ra) # 3aa <acquire>
    if (temp != 0 && temp->data == key) {
 9a8:	c0b1                	beqz	s1,9ec <deleteNode+0x68>
 9aa:	409c                	lw	a5,0(s1)
 9ac:	4701                	li	a4,0
 9ae:	01278a63          	beq	a5,s2,9c2 <deleteNode+0x3e>
        rcusync();
        free(temp);
        return;
    }

    while (temp != 0 && temp->data != key) {
 9b2:	409c                	lw	a5,0(s1)
 9b4:	05278563          	beq	a5,s2,9fe <deleteNode+0x7a>
        prev = temp;
        temp = temp->next;
 9b8:	649c                	ld	a5,8(s1)
    while (temp != 0 && temp->data != key) {
 9ba:	8726                	mv	a4,s1
 9bc:	cb85                	beqz	a5,9ec <deleteNode+0x68>
        temp = temp->next;
 9be:	84be                	mv	s1,a5
 9c0:	bfcd                	j	9b2 <deleteNode+0x2e>
        *head_ref = temp->next;
 9c2:	649c                	ld	a5,8(s1)
 9c4:	00f9b023          	sd	a5,0(s3)
        release(&list_lock);
 9c8:	00000517          	auipc	a0,0x0
 9cc:	64050513          	add	a0,a0,1600 # 1008 <list_lock>
 9d0:	00000097          	auipc	ra,0x0
 9d4:	9f2080e7          	jalr	-1550(ra) # 3c2 <release>
        rcusync();
 9d8:	00000097          	auipc	ra,0x0
 9dc:	ab6080e7          	jalr	-1354(ra) # 48e <rcusync>
        free(temp);
 9e0:	8526                	mv	a0,s1
 9e2:	00000097          	auipc	ra,0x0
 9e6:	dea080e7          	jalr	-534(ra) # 7cc <free>
        return;
 9ea:	a82d                	j	a24 <deleteNode+0xa0>
    }

    if (temp == 0) {
        release(&list_lock);
 9ec:	00000517          	auipc	a0,0x0
 9f0:	61c50513          	add	a0,a0,1564 # 1008 <list_lock>
 9f4:	00000097          	auipc	ra,0x0
 9f8:	9ce080e7          	jalr	-1586(ra) # 3c2 <release>
        return;
 9fc:	a025                	j	a24 <deleteNode+0xa0>
    }
    prev->next = temp->next;
 9fe:	649c                	ld	a5,8(s1)
 a00:	e71c                	sd	a5,8(a4)
    release(&list_lock);
 a02:	00000517          	auipc	a0,0x0
 a06:	60650513          	add	a0,a0,1542 # 1008 <list_lock>
 a0a:	00000097          	auipc	ra,0x0
 a0e:	9b8080e7          	jalr	-1608(ra) # 3c2 <release>
    rcusync();
 a12:	00000097          	auipc	ra,0x0
 a16:	a7c080e7          	jalr	-1412(ra) # 48e <rcusync>
    free(temp);
 a1a:	8526                	mv	a0,s1
 a1c:	00000097          	auipc	ra,0x0
 a20:	db0080e7          	jalr	-592(ra) # 7cc <free>
}
 a24:	70a2                	ld	ra,40(sp)
 a26:	7402                	ld	s0,32(sp)
 a28:	64e2                	ld	s1,24(sp)
 a2a:	6942                	ld	s2,16(sp)
 a2c:	69a2                	ld	s3,8(sp)
 a2e:	6145                	add	sp,sp,48
 a30:	8082                	ret

0000000000000a32 <search>:

// Function to search for a node with a given key in the linked list
struct Node* search(struct Node *head, int key) {
 a32:	1101                	add	sp,sp,-32
 a34:	ec06                	sd	ra,24(sp)
 a36:	e822                	sd	s0,16(sp)
 a38:	e426                	sd	s1,8(sp)
 a3a:	e04a                	sd	s2,0(sp)
 a3c:	1000                	add	s0,sp,32
 a3e:	84aa                	mv	s1,a0
 a40:	892e                	mv	s2,a1

    struct Node *current = head;
    rcureadlock();
 a42:	00000097          	auipc	ra,0x0
 a46:	a3c080e7          	jalr	-1476(ra) # 47e <rcureadlock>
    while (current != 0) {
 a4a:	c491                	beqz	s1,a56 <search+0x24>
        if (current->data == key) {
 a4c:	409c                	lw	a5,0(s1)
 a4e:	01278f63          	beq	a5,s2,a6c <search+0x3a>
            rcureadunlock();
            return current; // Node found
        }
        current = current->next;
 a52:	6484                	ld	s1,8(s1)
    while (current != 0) {
 a54:	fce5                	bnez	s1,a4c <search+0x1a>
    }
    rcureadunlock();
 a56:	00000097          	auipc	ra,0x0
 a5a:	a30080e7          	jalr	-1488(ra) # 486 <rcureadunlock>
    return 0; // Node not found
 a5e:	4501                	li	a0,0
}
 a60:	60e2                	ld	ra,24(sp)
 a62:	6442                	ld	s0,16(sp)
 a64:	64a2                	ld	s1,8(sp)
 a66:	6902                	ld	s2,0(sp)
 a68:	6105                	add	sp,sp,32
 a6a:	8082                	ret
            rcureadunlock();
 a6c:	00000097          	auipc	ra,0x0
 a70:	a1a080e7          	jalr	-1510(ra) # 486 <rcureadunlock>
            return current; // Node found
 a74:	8526                	mv	a0,s1
 a76:	b7ed                	j	a60 <search+0x2e>

0000000000000a78 <updateNode>:

// Function to update the value of a node with a given key in the linked list
void updateNode(struct Node *head, int key, int new_data) {
 a78:	1101                	add	sp,sp,-32
 a7a:	ec06                	sd	ra,24(sp)
 a7c:	e822                	sd	s0,16(sp)
 a7e:	e426                	sd	s1,8(sp)
 a80:	e04a                	sd	s2,0(sp)
 a82:	1000                	add	s0,sp,32
 a84:	892e                	mv	s2,a1
 a86:	84b2                	mv	s1,a2
    struct Node *nodeToUpdate = search(head, key);
 a88:	00000097          	auipc	ra,0x0
 a8c:	faa080e7          	jalr	-86(ra) # a32 <search>

    if (nodeToUpdate != 0) {
 a90:	c901                	beqz	a0,aa0 <updateNode+0x28>
        nodeToUpdate->data = new_data; // Update the node's data
 a92:	c104                	sw	s1,0(a0)
    } else {
        printf("Node with key %d not found.\n", key);
    }
}
 a94:	60e2                	ld	ra,24(sp)
 a96:	6442                	ld	s0,16(sp)
 a98:	64a2                	ld	s1,8(sp)
 a9a:	6902                	ld	s2,0(sp)
 a9c:	6105                	add	sp,sp,32
 a9e:	8082                	ret
        printf("Node with key %d not found.\n", key);
 aa0:	85ca                	mv	a1,s2
 aa2:	00000517          	auipc	a0,0x0
 aa6:	0de50513          	add	a0,a0,222 # b80 <digits+0x18>
 aaa:	00000097          	auipc	ra,0x0
 aae:	cec080e7          	jalr	-788(ra) # 796 <printf>
}
 ab2:	b7cd                	j	a94 <updateNode+0x1c>
