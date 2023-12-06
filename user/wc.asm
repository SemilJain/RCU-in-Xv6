
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	7119                	add	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	f4a6                	sd	s1,104(sp)
   8:	f0ca                	sd	s2,96(sp)
   a:	ecce                	sd	s3,88(sp)
   c:	e8d2                	sd	s4,80(sp)
   e:	e4d6                	sd	s5,72(sp)
  10:	e0da                	sd	s6,64(sp)
  12:	fc5e                	sd	s7,56(sp)
  14:	f862                	sd	s8,48(sp)
  16:	f466                	sd	s9,40(sp)
  18:	f06a                	sd	s10,32(sp)
  1a:	ec6e                	sd	s11,24(sp)
  1c:	0100                	add	s0,sp,128
  1e:	f8a43423          	sd	a0,-120(s0)
  22:	f8b43023          	sd	a1,-128(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  26:	4901                	li	s2,0
  l = w = c = 0;
  28:	4d01                	li	s10,0
  2a:	4c81                	li	s9,0
  2c:	4c01                	li	s8,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  2e:	00001d97          	auipc	s11,0x1
  32:	fe2d8d93          	add	s11,s11,-30 # 1010 <buf>
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  36:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  38:	00001a17          	auipc	s4,0x1
  3c:	af8a0a13          	add	s4,s4,-1288 # b30 <updateNode+0x4a>
        inword = 0;
  40:	4b81                	li	s7,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  42:	a805                	j	72 <wc+0x72>
      if(strchr(" \r\t\n\v", buf[i]))
  44:	8552                	mv	a0,s4
  46:	00000097          	auipc	ra,0x0
  4a:	1f2080e7          	jalr	498(ra) # 238 <strchr>
  4e:	c919                	beqz	a0,64 <wc+0x64>
        inword = 0;
  50:	895e                	mv	s2,s7
    for(i=0; i<n; i++){
  52:	0485                	add	s1,s1,1
  54:	00998d63          	beq	s3,s1,6e <wc+0x6e>
      if(buf[i] == '\n')
  58:	0004c583          	lbu	a1,0(s1)
  5c:	ff5594e3          	bne	a1,s5,44 <wc+0x44>
        l++;
  60:	2c05                	addw	s8,s8,1
  62:	b7cd                	j	44 <wc+0x44>
      else if(!inword){
  64:	fe0917e3          	bnez	s2,52 <wc+0x52>
        w++;
  68:	2c85                	addw	s9,s9,1
        inword = 1;
  6a:	4905                	li	s2,1
  6c:	b7dd                	j	52 <wc+0x52>
      c++;
  6e:	01ab0d3b          	addw	s10,s6,s10
  while((n = read(fd, buf, sizeof(buf))) > 0){
  72:	20000613          	li	a2,512
  76:	85ee                	mv	a1,s11
  78:	f8843503          	ld	a0,-120(s0)
  7c:	00000097          	auipc	ra,0x0
  80:	3e8080e7          	jalr	1000(ra) # 464 <read>
  84:	8b2a                	mv	s6,a0
  86:	00a05963          	blez	a0,98 <wc+0x98>
    for(i=0; i<n; i++){
  8a:	00001497          	auipc	s1,0x1
  8e:	f8648493          	add	s1,s1,-122 # 1010 <buf>
  92:	009509b3          	add	s3,a0,s1
  96:	b7c9                	j	58 <wc+0x58>
      }
    }
  }
  if(n < 0){
  98:	02054e63          	bltz	a0,d4 <wc+0xd4>
    printf("wc: read error\n");
    exit(1);
  }
  printf("%d %d %d %s\n", l, w, c, name);
  9c:	f8043703          	ld	a4,-128(s0)
  a0:	86ea                	mv	a3,s10
  a2:	8666                	mv	a2,s9
  a4:	85e2                	mv	a1,s8
  a6:	00001517          	auipc	a0,0x1
  aa:	aa250513          	add	a0,a0,-1374 # b48 <updateNode+0x62>
  ae:	00000097          	auipc	ra,0x0
  b2:	756080e7          	jalr	1878(ra) # 804 <printf>
}
  b6:	70e6                	ld	ra,120(sp)
  b8:	7446                	ld	s0,112(sp)
  ba:	74a6                	ld	s1,104(sp)
  bc:	7906                	ld	s2,96(sp)
  be:	69e6                	ld	s3,88(sp)
  c0:	6a46                	ld	s4,80(sp)
  c2:	6aa6                	ld	s5,72(sp)
  c4:	6b06                	ld	s6,64(sp)
  c6:	7be2                	ld	s7,56(sp)
  c8:	7c42                	ld	s8,48(sp)
  ca:	7ca2                	ld	s9,40(sp)
  cc:	7d02                	ld	s10,32(sp)
  ce:	6de2                	ld	s11,24(sp)
  d0:	6109                	add	sp,sp,128
  d2:	8082                	ret
    printf("wc: read error\n");
  d4:	00001517          	auipc	a0,0x1
  d8:	a6450513          	add	a0,a0,-1436 # b38 <updateNode+0x52>
  dc:	00000097          	auipc	ra,0x0
  e0:	728080e7          	jalr	1832(ra) # 804 <printf>
    exit(1);
  e4:	4505                	li	a0,1
  e6:	00000097          	auipc	ra,0x0
  ea:	366080e7          	jalr	870(ra) # 44c <exit>

00000000000000ee <main>:

int
main(int argc, char *argv[])
{
  ee:	7179                	add	sp,sp,-48
  f0:	f406                	sd	ra,40(sp)
  f2:	f022                	sd	s0,32(sp)
  f4:	ec26                	sd	s1,24(sp)
  f6:	e84a                	sd	s2,16(sp)
  f8:	e44e                	sd	s3,8(sp)
  fa:	1800                	add	s0,sp,48
  int fd, i;

  if(argc <= 1){
  fc:	4785                	li	a5,1
  fe:	04a7d963          	bge	a5,a0,150 <main+0x62>
 102:	00858913          	add	s2,a1,8
 106:	ffe5099b          	addw	s3,a0,-2
 10a:	02099793          	sll	a5,s3,0x20
 10e:	01d7d993          	srl	s3,a5,0x1d
 112:	05c1                	add	a1,a1,16
 114:	99ae                	add	s3,s3,a1
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
 116:	4581                	li	a1,0
 118:	00093503          	ld	a0,0(s2)
 11c:	00000097          	auipc	ra,0x0
 120:	370080e7          	jalr	880(ra) # 48c <open>
 124:	84aa                	mv	s1,a0
 126:	04054363          	bltz	a0,16c <main+0x7e>
      printf("wc: cannot open %s\n", argv[i]);
      exit(1);
    }
    wc(fd, argv[i]);
 12a:	00093583          	ld	a1,0(s2)
 12e:	00000097          	auipc	ra,0x0
 132:	ed2080e7          	jalr	-302(ra) # 0 <wc>
    close(fd);
 136:	8526                	mv	a0,s1
 138:	00000097          	auipc	ra,0x0
 13c:	33c080e7          	jalr	828(ra) # 474 <close>
  for(i = 1; i < argc; i++){
 140:	0921                	add	s2,s2,8
 142:	fd391ae3          	bne	s2,s3,116 <main+0x28>
  }
  exit(0);
 146:	4501                	li	a0,0
 148:	00000097          	auipc	ra,0x0
 14c:	304080e7          	jalr	772(ra) # 44c <exit>
    wc(0, "");
 150:	00001597          	auipc	a1,0x1
 154:	a0858593          	add	a1,a1,-1528 # b58 <updateNode+0x72>
 158:	4501                	li	a0,0
 15a:	00000097          	auipc	ra,0x0
 15e:	ea6080e7          	jalr	-346(ra) # 0 <wc>
    exit(0);
 162:	4501                	li	a0,0
 164:	00000097          	auipc	ra,0x0
 168:	2e8080e7          	jalr	744(ra) # 44c <exit>
      printf("wc: cannot open %s\n", argv[i]);
 16c:	00093583          	ld	a1,0(s2)
 170:	00001517          	auipc	a0,0x1
 174:	9f050513          	add	a0,a0,-1552 # b60 <updateNode+0x7a>
 178:	00000097          	auipc	ra,0x0
 17c:	68c080e7          	jalr	1676(ra) # 804 <printf>
      exit(1);
 180:	4505                	li	a0,1
 182:	00000097          	auipc	ra,0x0
 186:	2ca080e7          	jalr	714(ra) # 44c <exit>

000000000000018a <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 18a:	1141                	add	sp,sp,-16
 18c:	e406                	sd	ra,8(sp)
 18e:	e022                	sd	s0,0(sp)
 190:	0800                	add	s0,sp,16
  extern int main();
  main();
 192:	00000097          	auipc	ra,0x0
 196:	f5c080e7          	jalr	-164(ra) # ee <main>
  exit(0);
 19a:	4501                	li	a0,0
 19c:	00000097          	auipc	ra,0x0
 1a0:	2b0080e7          	jalr	688(ra) # 44c <exit>

00000000000001a4 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1a4:	1141                	add	sp,sp,-16
 1a6:	e422                	sd	s0,8(sp)
 1a8:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1aa:	87aa                	mv	a5,a0
 1ac:	0585                	add	a1,a1,1
 1ae:	0785                	add	a5,a5,1
 1b0:	fff5c703          	lbu	a4,-1(a1)
 1b4:	fee78fa3          	sb	a4,-1(a5)
 1b8:	fb75                	bnez	a4,1ac <strcpy+0x8>
    ;
  return os;
}
 1ba:	6422                	ld	s0,8(sp)
 1bc:	0141                	add	sp,sp,16
 1be:	8082                	ret

00000000000001c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1c0:	1141                	add	sp,sp,-16
 1c2:	e422                	sd	s0,8(sp)
 1c4:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 1c6:	00054783          	lbu	a5,0(a0)
 1ca:	cb91                	beqz	a5,1de <strcmp+0x1e>
 1cc:	0005c703          	lbu	a4,0(a1)
 1d0:	00f71763          	bne	a4,a5,1de <strcmp+0x1e>
    p++, q++;
 1d4:	0505                	add	a0,a0,1
 1d6:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 1d8:	00054783          	lbu	a5,0(a0)
 1dc:	fbe5                	bnez	a5,1cc <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1de:	0005c503          	lbu	a0,0(a1)
}
 1e2:	40a7853b          	subw	a0,a5,a0
 1e6:	6422                	ld	s0,8(sp)
 1e8:	0141                	add	sp,sp,16
 1ea:	8082                	ret

00000000000001ec <strlen>:

uint
strlen(const char *s)
{
 1ec:	1141                	add	sp,sp,-16
 1ee:	e422                	sd	s0,8(sp)
 1f0:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1f2:	00054783          	lbu	a5,0(a0)
 1f6:	cf91                	beqz	a5,212 <strlen+0x26>
 1f8:	0505                	add	a0,a0,1
 1fa:	87aa                	mv	a5,a0
 1fc:	86be                	mv	a3,a5
 1fe:	0785                	add	a5,a5,1
 200:	fff7c703          	lbu	a4,-1(a5)
 204:	ff65                	bnez	a4,1fc <strlen+0x10>
 206:	40a6853b          	subw	a0,a3,a0
 20a:	2505                	addw	a0,a0,1
    ;
  return n;
}
 20c:	6422                	ld	s0,8(sp)
 20e:	0141                	add	sp,sp,16
 210:	8082                	ret
  for(n = 0; s[n]; n++)
 212:	4501                	li	a0,0
 214:	bfe5                	j	20c <strlen+0x20>

0000000000000216 <memset>:

void*
memset(void *dst, int c, uint n)
{
 216:	1141                	add	sp,sp,-16
 218:	e422                	sd	s0,8(sp)
 21a:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 21c:	ca19                	beqz	a2,232 <memset+0x1c>
 21e:	87aa                	mv	a5,a0
 220:	1602                	sll	a2,a2,0x20
 222:	9201                	srl	a2,a2,0x20
 224:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 228:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 22c:	0785                	add	a5,a5,1
 22e:	fee79de3          	bne	a5,a4,228 <memset+0x12>
  }
  return dst;
}
 232:	6422                	ld	s0,8(sp)
 234:	0141                	add	sp,sp,16
 236:	8082                	ret

0000000000000238 <strchr>:

char*
strchr(const char *s, char c)
{
 238:	1141                	add	sp,sp,-16
 23a:	e422                	sd	s0,8(sp)
 23c:	0800                	add	s0,sp,16
  for(; *s; s++)
 23e:	00054783          	lbu	a5,0(a0)
 242:	cb99                	beqz	a5,258 <strchr+0x20>
    if(*s == c)
 244:	00f58763          	beq	a1,a5,252 <strchr+0x1a>
  for(; *s; s++)
 248:	0505                	add	a0,a0,1
 24a:	00054783          	lbu	a5,0(a0)
 24e:	fbfd                	bnez	a5,244 <strchr+0xc>
      return (char*)s;
  return 0;
 250:	4501                	li	a0,0
}
 252:	6422                	ld	s0,8(sp)
 254:	0141                	add	sp,sp,16
 256:	8082                	ret
  return 0;
 258:	4501                	li	a0,0
 25a:	bfe5                	j	252 <strchr+0x1a>

000000000000025c <gets>:

char*
gets(char *buf, int max)
{
 25c:	711d                	add	sp,sp,-96
 25e:	ec86                	sd	ra,88(sp)
 260:	e8a2                	sd	s0,80(sp)
 262:	e4a6                	sd	s1,72(sp)
 264:	e0ca                	sd	s2,64(sp)
 266:	fc4e                	sd	s3,56(sp)
 268:	f852                	sd	s4,48(sp)
 26a:	f456                	sd	s5,40(sp)
 26c:	f05a                	sd	s6,32(sp)
 26e:	ec5e                	sd	s7,24(sp)
 270:	1080                	add	s0,sp,96
 272:	8baa                	mv	s7,a0
 274:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 276:	892a                	mv	s2,a0
 278:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 27a:	4aa9                	li	s5,10
 27c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 27e:	89a6                	mv	s3,s1
 280:	2485                	addw	s1,s1,1
 282:	0344d863          	bge	s1,s4,2b2 <gets+0x56>
    cc = read(0, &c, 1);
 286:	4605                	li	a2,1
 288:	faf40593          	add	a1,s0,-81
 28c:	4501                	li	a0,0
 28e:	00000097          	auipc	ra,0x0
 292:	1d6080e7          	jalr	470(ra) # 464 <read>
    if(cc < 1)
 296:	00a05e63          	blez	a0,2b2 <gets+0x56>
    buf[i++] = c;
 29a:	faf44783          	lbu	a5,-81(s0)
 29e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2a2:	01578763          	beq	a5,s5,2b0 <gets+0x54>
 2a6:	0905                	add	s2,s2,1
 2a8:	fd679be3          	bne	a5,s6,27e <gets+0x22>
  for(i=0; i+1 < max; ){
 2ac:	89a6                	mv	s3,s1
 2ae:	a011                	j	2b2 <gets+0x56>
 2b0:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2b2:	99de                	add	s3,s3,s7
 2b4:	00098023          	sb	zero,0(s3)
  return buf;
}
 2b8:	855e                	mv	a0,s7
 2ba:	60e6                	ld	ra,88(sp)
 2bc:	6446                	ld	s0,80(sp)
 2be:	64a6                	ld	s1,72(sp)
 2c0:	6906                	ld	s2,64(sp)
 2c2:	79e2                	ld	s3,56(sp)
 2c4:	7a42                	ld	s4,48(sp)
 2c6:	7aa2                	ld	s5,40(sp)
 2c8:	7b02                	ld	s6,32(sp)
 2ca:	6be2                	ld	s7,24(sp)
 2cc:	6125                	add	sp,sp,96
 2ce:	8082                	ret

00000000000002d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2d0:	1101                	add	sp,sp,-32
 2d2:	ec06                	sd	ra,24(sp)
 2d4:	e822                	sd	s0,16(sp)
 2d6:	e426                	sd	s1,8(sp)
 2d8:	e04a                	sd	s2,0(sp)
 2da:	1000                	add	s0,sp,32
 2dc:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2de:	4581                	li	a1,0
 2e0:	00000097          	auipc	ra,0x0
 2e4:	1ac080e7          	jalr	428(ra) # 48c <open>
  if(fd < 0)
 2e8:	02054563          	bltz	a0,312 <stat+0x42>
 2ec:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2ee:	85ca                	mv	a1,s2
 2f0:	00000097          	auipc	ra,0x0
 2f4:	1b4080e7          	jalr	436(ra) # 4a4 <fstat>
 2f8:	892a                	mv	s2,a0
  close(fd);
 2fa:	8526                	mv	a0,s1
 2fc:	00000097          	auipc	ra,0x0
 300:	178080e7          	jalr	376(ra) # 474 <close>
  return r;
}
 304:	854a                	mv	a0,s2
 306:	60e2                	ld	ra,24(sp)
 308:	6442                	ld	s0,16(sp)
 30a:	64a2                	ld	s1,8(sp)
 30c:	6902                	ld	s2,0(sp)
 30e:	6105                	add	sp,sp,32
 310:	8082                	ret
    return -1;
 312:	597d                	li	s2,-1
 314:	bfc5                	j	304 <stat+0x34>

0000000000000316 <atoi>:

int
atoi(const char *s)
{
 316:	1141                	add	sp,sp,-16
 318:	e422                	sd	s0,8(sp)
 31a:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 31c:	00054683          	lbu	a3,0(a0)
 320:	fd06879b          	addw	a5,a3,-48
 324:	0ff7f793          	zext.b	a5,a5
 328:	4625                	li	a2,9
 32a:	02f66863          	bltu	a2,a5,35a <atoi+0x44>
 32e:	872a                	mv	a4,a0
  n = 0;
 330:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 332:	0705                	add	a4,a4,1
 334:	0025179b          	sllw	a5,a0,0x2
 338:	9fa9                	addw	a5,a5,a0
 33a:	0017979b          	sllw	a5,a5,0x1
 33e:	9fb5                	addw	a5,a5,a3
 340:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 344:	00074683          	lbu	a3,0(a4)
 348:	fd06879b          	addw	a5,a3,-48
 34c:	0ff7f793          	zext.b	a5,a5
 350:	fef671e3          	bgeu	a2,a5,332 <atoi+0x1c>
  return n;
}
 354:	6422                	ld	s0,8(sp)
 356:	0141                	add	sp,sp,16
 358:	8082                	ret
  n = 0;
 35a:	4501                	li	a0,0
 35c:	bfe5                	j	354 <atoi+0x3e>

000000000000035e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 35e:	1141                	add	sp,sp,-16
 360:	e422                	sd	s0,8(sp)
 362:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 364:	02b57463          	bgeu	a0,a1,38c <memmove+0x2e>
    while(n-- > 0)
 368:	00c05f63          	blez	a2,386 <memmove+0x28>
 36c:	1602                	sll	a2,a2,0x20
 36e:	9201                	srl	a2,a2,0x20
 370:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 374:	872a                	mv	a4,a0
      *dst++ = *src++;
 376:	0585                	add	a1,a1,1
 378:	0705                	add	a4,a4,1
 37a:	fff5c683          	lbu	a3,-1(a1)
 37e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 382:	fee79ae3          	bne	a5,a4,376 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 386:	6422                	ld	s0,8(sp)
 388:	0141                	add	sp,sp,16
 38a:	8082                	ret
    dst += n;
 38c:	00c50733          	add	a4,a0,a2
    src += n;
 390:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 392:	fec05ae3          	blez	a2,386 <memmove+0x28>
 396:	fff6079b          	addw	a5,a2,-1
 39a:	1782                	sll	a5,a5,0x20
 39c:	9381                	srl	a5,a5,0x20
 39e:	fff7c793          	not	a5,a5
 3a2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3a4:	15fd                	add	a1,a1,-1
 3a6:	177d                	add	a4,a4,-1
 3a8:	0005c683          	lbu	a3,0(a1)
 3ac:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3b0:	fee79ae3          	bne	a5,a4,3a4 <memmove+0x46>
 3b4:	bfc9                	j	386 <memmove+0x28>

00000000000003b6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3b6:	1141                	add	sp,sp,-16
 3b8:	e422                	sd	s0,8(sp)
 3ba:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3bc:	ca05                	beqz	a2,3ec <memcmp+0x36>
 3be:	fff6069b          	addw	a3,a2,-1
 3c2:	1682                	sll	a3,a3,0x20
 3c4:	9281                	srl	a3,a3,0x20
 3c6:	0685                	add	a3,a3,1
 3c8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3ca:	00054783          	lbu	a5,0(a0)
 3ce:	0005c703          	lbu	a4,0(a1)
 3d2:	00e79863          	bne	a5,a4,3e2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3d6:	0505                	add	a0,a0,1
    p2++;
 3d8:	0585                	add	a1,a1,1
  while (n-- > 0) {
 3da:	fed518e3          	bne	a0,a3,3ca <memcmp+0x14>
  }
  return 0;
 3de:	4501                	li	a0,0
 3e0:	a019                	j	3e6 <memcmp+0x30>
      return *p1 - *p2;
 3e2:	40e7853b          	subw	a0,a5,a4
}
 3e6:	6422                	ld	s0,8(sp)
 3e8:	0141                	add	sp,sp,16
 3ea:	8082                	ret
  return 0;
 3ec:	4501                	li	a0,0
 3ee:	bfe5                	j	3e6 <memcmp+0x30>

00000000000003f0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3f0:	1141                	add	sp,sp,-16
 3f2:	e406                	sd	ra,8(sp)
 3f4:	e022                	sd	s0,0(sp)
 3f6:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 3f8:	00000097          	auipc	ra,0x0
 3fc:	f66080e7          	jalr	-154(ra) # 35e <memmove>
}
 400:	60a2                	ld	ra,8(sp)
 402:	6402                	ld	s0,0(sp)
 404:	0141                	add	sp,sp,16
 406:	8082                	ret

0000000000000408 <initlock>:

// Initialize the spinlock
void initlock(struct spinlock_u *lk) {
 408:	1141                	add	sp,sp,-16
 40a:	e422                	sd	s0,8(sp)
 40c:	0800                	add	s0,sp,16
  lk->locked = 0;
 40e:	00052023          	sw	zero,0(a0)
}
 412:	6422                	ld	s0,8(sp)
 414:	0141                	add	sp,sp,16
 416:	8082                	ret

0000000000000418 <acquire>:

// Acquire the spinlock
void acquire(struct spinlock_u *lk) {
 418:	1141                	add	sp,sp,-16
 41a:	e422                	sd	s0,8(sp)
 41c:	0800                	add	s0,sp,16
  while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 41e:	4705                	li	a4,1
 420:	87ba                	mv	a5,a4
 422:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
 426:	2781                	sext.w	a5,a5
 428:	ffe5                	bnez	a5,420 <acquire+0x8>
    ; // Spin until the lock is acquired
}
 42a:	6422                	ld	s0,8(sp)
 42c:	0141                	add	sp,sp,16
 42e:	8082                	ret

0000000000000430 <release>:

// Release the spinlock
void release(struct spinlock_u *lk) {
 430:	1141                	add	sp,sp,-16
 432:	e422                	sd	s0,8(sp)
 434:	0800                	add	s0,sp,16
  __sync_lock_release(&lk->locked);
 436:	0f50000f          	fence	iorw,ow
 43a:	0805202f          	amoswap.w	zero,zero,(a0)
}
 43e:	6422                	ld	s0,8(sp)
 440:	0141                	add	sp,sp,16
 442:	8082                	ret

0000000000000444 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 444:	4885                	li	a7,1
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <exit>:
.global exit
exit:
 li a7, SYS_exit
 44c:	4889                	li	a7,2
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <wait>:
.global wait
wait:
 li a7, SYS_wait
 454:	488d                	li	a7,3
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 45c:	4891                	li	a7,4
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <read>:
.global read
read:
 li a7, SYS_read
 464:	4895                	li	a7,5
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <write>:
.global write
write:
 li a7, SYS_write
 46c:	48c1                	li	a7,16
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <close>:
.global close
close:
 li a7, SYS_close
 474:	48d5                	li	a7,21
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <kill>:
.global kill
kill:
 li a7, SYS_kill
 47c:	4899                	li	a7,6
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <exec>:
.global exec
exec:
 li a7, SYS_exec
 484:	489d                	li	a7,7
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <open>:
.global open
open:
 li a7, SYS_open
 48c:	48bd                	li	a7,15
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 494:	48c5                	li	a7,17
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 49c:	48c9                	li	a7,18
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4a4:	48a1                	li	a7,8
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <link>:
.global link
link:
 li a7, SYS_link
 4ac:	48cd                	li	a7,19
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4b4:	48d1                	li	a7,20
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4bc:	48a5                	li	a7,9
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4c4:	48a9                	li	a7,10
 ecall
 4c6:	00000073          	ecall
 ret
 4ca:	8082                	ret

00000000000004cc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4cc:	48ad                	li	a7,11
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4d4:	48b1                	li	a7,12
 ecall
 4d6:	00000073          	ecall
 ret
 4da:	8082                	ret

00000000000004dc <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4dc:	48b5                	li	a7,13
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4e4:	48b9                	li	a7,14
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <rcureadlock>:
.global rcureadlock
rcureadlock:
 li a7, SYS_rcureadlock
 4ec:	48dd                	li	a7,23
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <rcureadunlock>:
.global rcureadunlock
rcureadunlock:
 li a7, SYS_rcureadunlock
 4f4:	48e1                	li	a7,24
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <rcusync>:
.global rcusync
rcusync:
 li a7, SYS_rcusync
 4fc:	48d9                	li	a7,22
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <thread_create>:
.global thread_create
thread_create:
 li a7, SYS_thread_create
 504:	48e5                	li	a7,25
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <thread_join>:
.global thread_join
thread_join:
 li a7, SYS_thread_join
 50c:	48e9                	li	a7,26
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <thread_exit>:
.global thread_exit
thread_exit:
 li a7, SYS_thread_exit
 514:	48ed                	li	a7,27
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <klist_insert>:
.global klist_insert
klist_insert:
 li a7, SYS_klist_insert
 51c:	48f1                	li	a7,28
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <klist_delete>:
.global klist_delete
klist_delete:
 li a7, SYS_klist_delete
 524:	48f5                	li	a7,29
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <klist_query>:
.global klist_query
klist_query:
 li a7, SYS_klist_query
 52c:	48f9                	li	a7,30
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <klist_print>:
.global klist_print
klist_print:
 li a7, SYS_klist_print
 534:	48fd                	li	a7,31
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 53c:	1101                	add	sp,sp,-32
 53e:	ec06                	sd	ra,24(sp)
 540:	e822                	sd	s0,16(sp)
 542:	1000                	add	s0,sp,32
 544:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 548:	4605                	li	a2,1
 54a:	fef40593          	add	a1,s0,-17
 54e:	00000097          	auipc	ra,0x0
 552:	f1e080e7          	jalr	-226(ra) # 46c <write>
}
 556:	60e2                	ld	ra,24(sp)
 558:	6442                	ld	s0,16(sp)
 55a:	6105                	add	sp,sp,32
 55c:	8082                	ret

000000000000055e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 55e:	7139                	add	sp,sp,-64
 560:	fc06                	sd	ra,56(sp)
 562:	f822                	sd	s0,48(sp)
 564:	f426                	sd	s1,40(sp)
 566:	f04a                	sd	s2,32(sp)
 568:	ec4e                	sd	s3,24(sp)
 56a:	0080                	add	s0,sp,64
 56c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 56e:	c299                	beqz	a3,574 <printint+0x16>
 570:	0805c963          	bltz	a1,602 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 574:	2581                	sext.w	a1,a1
  neg = 0;
 576:	4881                	li	a7,0
 578:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 57c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 57e:	2601                	sext.w	a2,a2
 580:	00000517          	auipc	a0,0x0
 584:	65850513          	add	a0,a0,1624 # bd8 <digits>
 588:	883a                	mv	a6,a4
 58a:	2705                	addw	a4,a4,1
 58c:	02c5f7bb          	remuw	a5,a1,a2
 590:	1782                	sll	a5,a5,0x20
 592:	9381                	srl	a5,a5,0x20
 594:	97aa                	add	a5,a5,a0
 596:	0007c783          	lbu	a5,0(a5)
 59a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 59e:	0005879b          	sext.w	a5,a1
 5a2:	02c5d5bb          	divuw	a1,a1,a2
 5a6:	0685                	add	a3,a3,1
 5a8:	fec7f0e3          	bgeu	a5,a2,588 <printint+0x2a>
  if(neg)
 5ac:	00088c63          	beqz	a7,5c4 <printint+0x66>
    buf[i++] = '-';
 5b0:	fd070793          	add	a5,a4,-48
 5b4:	00878733          	add	a4,a5,s0
 5b8:	02d00793          	li	a5,45
 5bc:	fef70823          	sb	a5,-16(a4)
 5c0:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 5c4:	02e05863          	blez	a4,5f4 <printint+0x96>
 5c8:	fc040793          	add	a5,s0,-64
 5cc:	00e78933          	add	s2,a5,a4
 5d0:	fff78993          	add	s3,a5,-1
 5d4:	99ba                	add	s3,s3,a4
 5d6:	377d                	addw	a4,a4,-1
 5d8:	1702                	sll	a4,a4,0x20
 5da:	9301                	srl	a4,a4,0x20
 5dc:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5e0:	fff94583          	lbu	a1,-1(s2)
 5e4:	8526                	mv	a0,s1
 5e6:	00000097          	auipc	ra,0x0
 5ea:	f56080e7          	jalr	-170(ra) # 53c <putc>
  while(--i >= 0)
 5ee:	197d                	add	s2,s2,-1
 5f0:	ff3918e3          	bne	s2,s3,5e0 <printint+0x82>
}
 5f4:	70e2                	ld	ra,56(sp)
 5f6:	7442                	ld	s0,48(sp)
 5f8:	74a2                	ld	s1,40(sp)
 5fa:	7902                	ld	s2,32(sp)
 5fc:	69e2                	ld	s3,24(sp)
 5fe:	6121                	add	sp,sp,64
 600:	8082                	ret
    x = -xx;
 602:	40b005bb          	negw	a1,a1
    neg = 1;
 606:	4885                	li	a7,1
    x = -xx;
 608:	bf85                	j	578 <printint+0x1a>

000000000000060a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 60a:	715d                	add	sp,sp,-80
 60c:	e486                	sd	ra,72(sp)
 60e:	e0a2                	sd	s0,64(sp)
 610:	fc26                	sd	s1,56(sp)
 612:	f84a                	sd	s2,48(sp)
 614:	f44e                	sd	s3,40(sp)
 616:	f052                	sd	s4,32(sp)
 618:	ec56                	sd	s5,24(sp)
 61a:	e85a                	sd	s6,16(sp)
 61c:	e45e                	sd	s7,8(sp)
 61e:	e062                	sd	s8,0(sp)
 620:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 622:	0005c903          	lbu	s2,0(a1)
 626:	18090c63          	beqz	s2,7be <vprintf+0x1b4>
 62a:	8aaa                	mv	s5,a0
 62c:	8bb2                	mv	s7,a2
 62e:	00158493          	add	s1,a1,1
  state = 0;
 632:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 634:	02500a13          	li	s4,37
 638:	4b55                	li	s6,21
 63a:	a839                	j	658 <vprintf+0x4e>
        putc(fd, c);
 63c:	85ca                	mv	a1,s2
 63e:	8556                	mv	a0,s5
 640:	00000097          	auipc	ra,0x0
 644:	efc080e7          	jalr	-260(ra) # 53c <putc>
 648:	a019                	j	64e <vprintf+0x44>
    } else if(state == '%'){
 64a:	01498d63          	beq	s3,s4,664 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 64e:	0485                	add	s1,s1,1
 650:	fff4c903          	lbu	s2,-1(s1)
 654:	16090563          	beqz	s2,7be <vprintf+0x1b4>
    if(state == 0){
 658:	fe0999e3          	bnez	s3,64a <vprintf+0x40>
      if(c == '%'){
 65c:	ff4910e3          	bne	s2,s4,63c <vprintf+0x32>
        state = '%';
 660:	89d2                	mv	s3,s4
 662:	b7f5                	j	64e <vprintf+0x44>
      if(c == 'd'){
 664:	13490263          	beq	s2,s4,788 <vprintf+0x17e>
 668:	f9d9079b          	addw	a5,s2,-99
 66c:	0ff7f793          	zext.b	a5,a5
 670:	12fb6563          	bltu	s6,a5,79a <vprintf+0x190>
 674:	f9d9079b          	addw	a5,s2,-99
 678:	0ff7f713          	zext.b	a4,a5
 67c:	10eb6f63          	bltu	s6,a4,79a <vprintf+0x190>
 680:	00271793          	sll	a5,a4,0x2
 684:	00000717          	auipc	a4,0x0
 688:	4fc70713          	add	a4,a4,1276 # b80 <updateNode+0x9a>
 68c:	97ba                	add	a5,a5,a4
 68e:	439c                	lw	a5,0(a5)
 690:	97ba                	add	a5,a5,a4
 692:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 694:	008b8913          	add	s2,s7,8
 698:	4685                	li	a3,1
 69a:	4629                	li	a2,10
 69c:	000ba583          	lw	a1,0(s7)
 6a0:	8556                	mv	a0,s5
 6a2:	00000097          	auipc	ra,0x0
 6a6:	ebc080e7          	jalr	-324(ra) # 55e <printint>
 6aa:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6ac:	4981                	li	s3,0
 6ae:	b745                	j	64e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6b0:	008b8913          	add	s2,s7,8
 6b4:	4681                	li	a3,0
 6b6:	4629                	li	a2,10
 6b8:	000ba583          	lw	a1,0(s7)
 6bc:	8556                	mv	a0,s5
 6be:	00000097          	auipc	ra,0x0
 6c2:	ea0080e7          	jalr	-352(ra) # 55e <printint>
 6c6:	8bca                	mv	s7,s2
      state = 0;
 6c8:	4981                	li	s3,0
 6ca:	b751                	j	64e <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 6cc:	008b8913          	add	s2,s7,8
 6d0:	4681                	li	a3,0
 6d2:	4641                	li	a2,16
 6d4:	000ba583          	lw	a1,0(s7)
 6d8:	8556                	mv	a0,s5
 6da:	00000097          	auipc	ra,0x0
 6de:	e84080e7          	jalr	-380(ra) # 55e <printint>
 6e2:	8bca                	mv	s7,s2
      state = 0;
 6e4:	4981                	li	s3,0
 6e6:	b7a5                	j	64e <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 6e8:	008b8c13          	add	s8,s7,8
 6ec:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6f0:	03000593          	li	a1,48
 6f4:	8556                	mv	a0,s5
 6f6:	00000097          	auipc	ra,0x0
 6fa:	e46080e7          	jalr	-442(ra) # 53c <putc>
  putc(fd, 'x');
 6fe:	07800593          	li	a1,120
 702:	8556                	mv	a0,s5
 704:	00000097          	auipc	ra,0x0
 708:	e38080e7          	jalr	-456(ra) # 53c <putc>
 70c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 70e:	00000b97          	auipc	s7,0x0
 712:	4cab8b93          	add	s7,s7,1226 # bd8 <digits>
 716:	03c9d793          	srl	a5,s3,0x3c
 71a:	97de                	add	a5,a5,s7
 71c:	0007c583          	lbu	a1,0(a5)
 720:	8556                	mv	a0,s5
 722:	00000097          	auipc	ra,0x0
 726:	e1a080e7          	jalr	-486(ra) # 53c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 72a:	0992                	sll	s3,s3,0x4
 72c:	397d                	addw	s2,s2,-1
 72e:	fe0914e3          	bnez	s2,716 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 732:	8be2                	mv	s7,s8
      state = 0;
 734:	4981                	li	s3,0
 736:	bf21                	j	64e <vprintf+0x44>
        s = va_arg(ap, char*);
 738:	008b8993          	add	s3,s7,8
 73c:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 740:	02090163          	beqz	s2,762 <vprintf+0x158>
        while(*s != 0){
 744:	00094583          	lbu	a1,0(s2)
 748:	c9a5                	beqz	a1,7b8 <vprintf+0x1ae>
          putc(fd, *s);
 74a:	8556                	mv	a0,s5
 74c:	00000097          	auipc	ra,0x0
 750:	df0080e7          	jalr	-528(ra) # 53c <putc>
          s++;
 754:	0905                	add	s2,s2,1
        while(*s != 0){
 756:	00094583          	lbu	a1,0(s2)
 75a:	f9e5                	bnez	a1,74a <vprintf+0x140>
        s = va_arg(ap, char*);
 75c:	8bce                	mv	s7,s3
      state = 0;
 75e:	4981                	li	s3,0
 760:	b5fd                	j	64e <vprintf+0x44>
          s = "(null)";
 762:	00000917          	auipc	s2,0x0
 766:	41690913          	add	s2,s2,1046 # b78 <updateNode+0x92>
        while(*s != 0){
 76a:	02800593          	li	a1,40
 76e:	bff1                	j	74a <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 770:	008b8913          	add	s2,s7,8
 774:	000bc583          	lbu	a1,0(s7)
 778:	8556                	mv	a0,s5
 77a:	00000097          	auipc	ra,0x0
 77e:	dc2080e7          	jalr	-574(ra) # 53c <putc>
 782:	8bca                	mv	s7,s2
      state = 0;
 784:	4981                	li	s3,0
 786:	b5e1                	j	64e <vprintf+0x44>
        putc(fd, c);
 788:	02500593          	li	a1,37
 78c:	8556                	mv	a0,s5
 78e:	00000097          	auipc	ra,0x0
 792:	dae080e7          	jalr	-594(ra) # 53c <putc>
      state = 0;
 796:	4981                	li	s3,0
 798:	bd5d                	j	64e <vprintf+0x44>
        putc(fd, '%');
 79a:	02500593          	li	a1,37
 79e:	8556                	mv	a0,s5
 7a0:	00000097          	auipc	ra,0x0
 7a4:	d9c080e7          	jalr	-612(ra) # 53c <putc>
        putc(fd, c);
 7a8:	85ca                	mv	a1,s2
 7aa:	8556                	mv	a0,s5
 7ac:	00000097          	auipc	ra,0x0
 7b0:	d90080e7          	jalr	-624(ra) # 53c <putc>
      state = 0;
 7b4:	4981                	li	s3,0
 7b6:	bd61                	j	64e <vprintf+0x44>
        s = va_arg(ap, char*);
 7b8:	8bce                	mv	s7,s3
      state = 0;
 7ba:	4981                	li	s3,0
 7bc:	bd49                	j	64e <vprintf+0x44>
    }
  }
}
 7be:	60a6                	ld	ra,72(sp)
 7c0:	6406                	ld	s0,64(sp)
 7c2:	74e2                	ld	s1,56(sp)
 7c4:	7942                	ld	s2,48(sp)
 7c6:	79a2                	ld	s3,40(sp)
 7c8:	7a02                	ld	s4,32(sp)
 7ca:	6ae2                	ld	s5,24(sp)
 7cc:	6b42                	ld	s6,16(sp)
 7ce:	6ba2                	ld	s7,8(sp)
 7d0:	6c02                	ld	s8,0(sp)
 7d2:	6161                	add	sp,sp,80
 7d4:	8082                	ret

00000000000007d6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7d6:	715d                	add	sp,sp,-80
 7d8:	ec06                	sd	ra,24(sp)
 7da:	e822                	sd	s0,16(sp)
 7dc:	1000                	add	s0,sp,32
 7de:	e010                	sd	a2,0(s0)
 7e0:	e414                	sd	a3,8(s0)
 7e2:	e818                	sd	a4,16(s0)
 7e4:	ec1c                	sd	a5,24(s0)
 7e6:	03043023          	sd	a6,32(s0)
 7ea:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7ee:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7f2:	8622                	mv	a2,s0
 7f4:	00000097          	auipc	ra,0x0
 7f8:	e16080e7          	jalr	-490(ra) # 60a <vprintf>
}
 7fc:	60e2                	ld	ra,24(sp)
 7fe:	6442                	ld	s0,16(sp)
 800:	6161                	add	sp,sp,80
 802:	8082                	ret

0000000000000804 <printf>:

void
printf(const char *fmt, ...)
{
 804:	711d                	add	sp,sp,-96
 806:	ec06                	sd	ra,24(sp)
 808:	e822                	sd	s0,16(sp)
 80a:	1000                	add	s0,sp,32
 80c:	e40c                	sd	a1,8(s0)
 80e:	e810                	sd	a2,16(s0)
 810:	ec14                	sd	a3,24(s0)
 812:	f018                	sd	a4,32(s0)
 814:	f41c                	sd	a5,40(s0)
 816:	03043823          	sd	a6,48(s0)
 81a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 81e:	00840613          	add	a2,s0,8
 822:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 826:	85aa                	mv	a1,a0
 828:	4505                	li	a0,1
 82a:	00000097          	auipc	ra,0x0
 82e:	de0080e7          	jalr	-544(ra) # 60a <vprintf>
}
 832:	60e2                	ld	ra,24(sp)
 834:	6442                	ld	s0,16(sp)
 836:	6125                	add	sp,sp,96
 838:	8082                	ret

000000000000083a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 83a:	1141                	add	sp,sp,-16
 83c:	e422                	sd	s0,8(sp)
 83e:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 840:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 844:	00000797          	auipc	a5,0x0
 848:	7bc7b783          	ld	a5,1980(a5) # 1000 <freep>
 84c:	a02d                	j	876 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 84e:	4618                	lw	a4,8(a2)
 850:	9f2d                	addw	a4,a4,a1
 852:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 856:	6398                	ld	a4,0(a5)
 858:	6310                	ld	a2,0(a4)
 85a:	a83d                	j	898 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 85c:	ff852703          	lw	a4,-8(a0)
 860:	9f31                	addw	a4,a4,a2
 862:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 864:	ff053683          	ld	a3,-16(a0)
 868:	a091                	j	8ac <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 86a:	6398                	ld	a4,0(a5)
 86c:	00e7e463          	bltu	a5,a4,874 <free+0x3a>
 870:	00e6ea63          	bltu	a3,a4,884 <free+0x4a>
{
 874:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 876:	fed7fae3          	bgeu	a5,a3,86a <free+0x30>
 87a:	6398                	ld	a4,0(a5)
 87c:	00e6e463          	bltu	a3,a4,884 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 880:	fee7eae3          	bltu	a5,a4,874 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 884:	ff852583          	lw	a1,-8(a0)
 888:	6390                	ld	a2,0(a5)
 88a:	02059813          	sll	a6,a1,0x20
 88e:	01c85713          	srl	a4,a6,0x1c
 892:	9736                	add	a4,a4,a3
 894:	fae60de3          	beq	a2,a4,84e <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 898:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 89c:	4790                	lw	a2,8(a5)
 89e:	02061593          	sll	a1,a2,0x20
 8a2:	01c5d713          	srl	a4,a1,0x1c
 8a6:	973e                	add	a4,a4,a5
 8a8:	fae68ae3          	beq	a3,a4,85c <free+0x22>
    p->s.ptr = bp->s.ptr;
 8ac:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8ae:	00000717          	auipc	a4,0x0
 8b2:	74f73923          	sd	a5,1874(a4) # 1000 <freep>
}
 8b6:	6422                	ld	s0,8(sp)
 8b8:	0141                	add	sp,sp,16
 8ba:	8082                	ret

00000000000008bc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8bc:	7139                	add	sp,sp,-64
 8be:	fc06                	sd	ra,56(sp)
 8c0:	f822                	sd	s0,48(sp)
 8c2:	f426                	sd	s1,40(sp)
 8c4:	f04a                	sd	s2,32(sp)
 8c6:	ec4e                	sd	s3,24(sp)
 8c8:	e852                	sd	s4,16(sp)
 8ca:	e456                	sd	s5,8(sp)
 8cc:	e05a                	sd	s6,0(sp)
 8ce:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8d0:	02051493          	sll	s1,a0,0x20
 8d4:	9081                	srl	s1,s1,0x20
 8d6:	04bd                	add	s1,s1,15
 8d8:	8091                	srl	s1,s1,0x4
 8da:	0014899b          	addw	s3,s1,1
 8de:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 8e0:	00000517          	auipc	a0,0x0
 8e4:	72053503          	ld	a0,1824(a0) # 1000 <freep>
 8e8:	c515                	beqz	a0,914 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ea:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ec:	4798                	lw	a4,8(a5)
 8ee:	02977f63          	bgeu	a4,s1,92c <malloc+0x70>
  if(nu < 4096)
 8f2:	8a4e                	mv	s4,s3
 8f4:	0009871b          	sext.w	a4,s3
 8f8:	6685                	lui	a3,0x1
 8fa:	00d77363          	bgeu	a4,a3,900 <malloc+0x44>
 8fe:	6a05                	lui	s4,0x1
 900:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 904:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 908:	00000917          	auipc	s2,0x0
 90c:	6f890913          	add	s2,s2,1784 # 1000 <freep>
  if(p == (char*)-1)
 910:	5afd                	li	s5,-1
 912:	a895                	j	986 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 914:	00001797          	auipc	a5,0x1
 918:	8fc78793          	add	a5,a5,-1796 # 1210 <base>
 91c:	00000717          	auipc	a4,0x0
 920:	6ef73223          	sd	a5,1764(a4) # 1000 <freep>
 924:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 926:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 92a:	b7e1                	j	8f2 <malloc+0x36>
      if(p->s.size == nunits)
 92c:	02e48c63          	beq	s1,a4,964 <malloc+0xa8>
        p->s.size -= nunits;
 930:	4137073b          	subw	a4,a4,s3
 934:	c798                	sw	a4,8(a5)
        p += p->s.size;
 936:	02071693          	sll	a3,a4,0x20
 93a:	01c6d713          	srl	a4,a3,0x1c
 93e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 940:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 944:	00000717          	auipc	a4,0x0
 948:	6aa73e23          	sd	a0,1724(a4) # 1000 <freep>
      return (void*)(p + 1);
 94c:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 950:	70e2                	ld	ra,56(sp)
 952:	7442                	ld	s0,48(sp)
 954:	74a2                	ld	s1,40(sp)
 956:	7902                	ld	s2,32(sp)
 958:	69e2                	ld	s3,24(sp)
 95a:	6a42                	ld	s4,16(sp)
 95c:	6aa2                	ld	s5,8(sp)
 95e:	6b02                	ld	s6,0(sp)
 960:	6121                	add	sp,sp,64
 962:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 964:	6398                	ld	a4,0(a5)
 966:	e118                	sd	a4,0(a0)
 968:	bff1                	j	944 <malloc+0x88>
  hp->s.size = nu;
 96a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 96e:	0541                	add	a0,a0,16
 970:	00000097          	auipc	ra,0x0
 974:	eca080e7          	jalr	-310(ra) # 83a <free>
  return freep;
 978:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 97c:	d971                	beqz	a0,950 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 97e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 980:	4798                	lw	a4,8(a5)
 982:	fa9775e3          	bgeu	a4,s1,92c <malloc+0x70>
    if(p == freep)
 986:	00093703          	ld	a4,0(s2)
 98a:	853e                	mv	a0,a5
 98c:	fef719e3          	bne	a4,a5,97e <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 990:	8552                	mv	a0,s4
 992:	00000097          	auipc	ra,0x0
 996:	b42080e7          	jalr	-1214(ra) # 4d4 <sbrk>
  if(p == (char*)-1)
 99a:	fd5518e3          	bne	a0,s5,96a <malloc+0xae>
        return 0;
 99e:	4501                	li	a0,0
 9a0:	bf45                	j	950 <malloc+0x94>

00000000000009a2 <init_lock>:
#include "linkedlist.h"

// Define a node structure for the linked list
struct spinlock_u list_lock;

void init_lock(){
 9a2:	1141                	add	sp,sp,-16
 9a4:	e406                	sd	ra,8(sp)
 9a6:	e022                	sd	s0,0(sp)
 9a8:	0800                	add	s0,sp,16
    initlock(&list_lock);
 9aa:	00000517          	auipc	a0,0x0
 9ae:	65e50513          	add	a0,a0,1630 # 1008 <list_lock>
 9b2:	00000097          	auipc	ra,0x0
 9b6:	a56080e7          	jalr	-1450(ra) # 408 <initlock>
}
 9ba:	60a2                	ld	ra,8(sp)
 9bc:	6402                	ld	s0,0(sp)
 9be:	0141                	add	sp,sp,16
 9c0:	8082                	ret

00000000000009c2 <insert>:

// Function to insert a node at the beginning of the linked list
void insert(struct Node **head_ref, int new_data) {
 9c2:	1101                	add	sp,sp,-32
 9c4:	ec06                	sd	ra,24(sp)
 9c6:	e822                	sd	s0,16(sp)
 9c8:	e426                	sd	s1,8(sp)
 9ca:	e04a                	sd	s2,0(sp)
 9cc:	1000                	add	s0,sp,32
 9ce:	84aa                	mv	s1,a0
 9d0:	892e                	mv	s2,a1
    struct Node *new_node = malloc(sizeof(struct Node));
 9d2:	4541                	li	a0,16
 9d4:	00000097          	auipc	ra,0x0
 9d8:	ee8080e7          	jalr	-280(ra) # 8bc <malloc>
    new_node->data = new_data;
 9dc:	01252023          	sw	s2,0(a0)
    new_node->next = *head_ref;
 9e0:	609c                	ld	a5,0(s1)
 9e2:	e51c                	sd	a5,8(a0)
    *head_ref = new_node;
 9e4:	e088                	sd	a0,0(s1)
}
 9e6:	60e2                	ld	ra,24(sp)
 9e8:	6442                	ld	s0,16(sp)
 9ea:	64a2                	ld	s1,8(sp)
 9ec:	6902                	ld	s2,0(sp)
 9ee:	6105                	add	sp,sp,32
 9f0:	8082                	ret

00000000000009f2 <deleteNode>:

// Function to delete a node with a given key from the linked list
void deleteNode(struct Node **head_ref, int key) {
 9f2:	7179                	add	sp,sp,-48
 9f4:	f406                	sd	ra,40(sp)
 9f6:	f022                	sd	s0,32(sp)
 9f8:	ec26                	sd	s1,24(sp)
 9fa:	e84a                	sd	s2,16(sp)
 9fc:	e44e                	sd	s3,8(sp)
 9fe:	1800                	add	s0,sp,48
 a00:	89aa                	mv	s3,a0
 a02:	892e                	mv	s2,a1
    struct Node *temp = *head_ref, *prev = 0;
 a04:	6104                	ld	s1,0(a0)

    acquire(&list_lock);
 a06:	00000517          	auipc	a0,0x0
 a0a:	60250513          	add	a0,a0,1538 # 1008 <list_lock>
 a0e:	00000097          	auipc	ra,0x0
 a12:	a0a080e7          	jalr	-1526(ra) # 418 <acquire>
    if (temp != 0 && temp->data == key) {
 a16:	c0b1                	beqz	s1,a5a <deleteNode+0x68>
 a18:	409c                	lw	a5,0(s1)
 a1a:	4701                	li	a4,0
 a1c:	01278a63          	beq	a5,s2,a30 <deleteNode+0x3e>
        rcusync();
        free(temp);
        return;
    }

    while (temp != 0 && temp->data != key) {
 a20:	409c                	lw	a5,0(s1)
 a22:	05278563          	beq	a5,s2,a6c <deleteNode+0x7a>
        prev = temp;
        temp = temp->next;
 a26:	649c                	ld	a5,8(s1)
    while (temp != 0 && temp->data != key) {
 a28:	8726                	mv	a4,s1
 a2a:	cb85                	beqz	a5,a5a <deleteNode+0x68>
        temp = temp->next;
 a2c:	84be                	mv	s1,a5
 a2e:	bfcd                	j	a20 <deleteNode+0x2e>
        *head_ref = temp->next;
 a30:	649c                	ld	a5,8(s1)
 a32:	00f9b023          	sd	a5,0(s3)
        release(&list_lock);
 a36:	00000517          	auipc	a0,0x0
 a3a:	5d250513          	add	a0,a0,1490 # 1008 <list_lock>
 a3e:	00000097          	auipc	ra,0x0
 a42:	9f2080e7          	jalr	-1550(ra) # 430 <release>
        rcusync();
 a46:	00000097          	auipc	ra,0x0
 a4a:	ab6080e7          	jalr	-1354(ra) # 4fc <rcusync>
        free(temp);
 a4e:	8526                	mv	a0,s1
 a50:	00000097          	auipc	ra,0x0
 a54:	dea080e7          	jalr	-534(ra) # 83a <free>
        return;
 a58:	a82d                	j	a92 <deleteNode+0xa0>
    }

    if (temp == 0) {
        release(&list_lock);
 a5a:	00000517          	auipc	a0,0x0
 a5e:	5ae50513          	add	a0,a0,1454 # 1008 <list_lock>
 a62:	00000097          	auipc	ra,0x0
 a66:	9ce080e7          	jalr	-1586(ra) # 430 <release>
        return;
 a6a:	a025                	j	a92 <deleteNode+0xa0>
    }
    prev->next = temp->next;
 a6c:	649c                	ld	a5,8(s1)
 a6e:	e71c                	sd	a5,8(a4)
    release(&list_lock);
 a70:	00000517          	auipc	a0,0x0
 a74:	59850513          	add	a0,a0,1432 # 1008 <list_lock>
 a78:	00000097          	auipc	ra,0x0
 a7c:	9b8080e7          	jalr	-1608(ra) # 430 <release>
    rcusync();
 a80:	00000097          	auipc	ra,0x0
 a84:	a7c080e7          	jalr	-1412(ra) # 4fc <rcusync>
    free(temp);
 a88:	8526                	mv	a0,s1
 a8a:	00000097          	auipc	ra,0x0
 a8e:	db0080e7          	jalr	-592(ra) # 83a <free>
}
 a92:	70a2                	ld	ra,40(sp)
 a94:	7402                	ld	s0,32(sp)
 a96:	64e2                	ld	s1,24(sp)
 a98:	6942                	ld	s2,16(sp)
 a9a:	69a2                	ld	s3,8(sp)
 a9c:	6145                	add	sp,sp,48
 a9e:	8082                	ret

0000000000000aa0 <search>:

// Function to search for a node with a given key in the linked list
struct Node* search(struct Node *head, int key) {
 aa0:	1101                	add	sp,sp,-32
 aa2:	ec06                	sd	ra,24(sp)
 aa4:	e822                	sd	s0,16(sp)
 aa6:	e426                	sd	s1,8(sp)
 aa8:	e04a                	sd	s2,0(sp)
 aaa:	1000                	add	s0,sp,32
 aac:	84aa                	mv	s1,a0
 aae:	892e                	mv	s2,a1

    struct Node *current = head;
    rcureadlock();
 ab0:	00000097          	auipc	ra,0x0
 ab4:	a3c080e7          	jalr	-1476(ra) # 4ec <rcureadlock>
    while (current != 0) {
 ab8:	c491                	beqz	s1,ac4 <search+0x24>
        if (current->data == key) {
 aba:	409c                	lw	a5,0(s1)
 abc:	01278f63          	beq	a5,s2,ada <search+0x3a>
            rcureadunlock();
            return current; // Node found
        }
        current = current->next;
 ac0:	6484                	ld	s1,8(s1)
    while (current != 0) {
 ac2:	fce5                	bnez	s1,aba <search+0x1a>
    }
    rcureadunlock();
 ac4:	00000097          	auipc	ra,0x0
 ac8:	a30080e7          	jalr	-1488(ra) # 4f4 <rcureadunlock>
    return 0; // Node not found
 acc:	4501                	li	a0,0
}
 ace:	60e2                	ld	ra,24(sp)
 ad0:	6442                	ld	s0,16(sp)
 ad2:	64a2                	ld	s1,8(sp)
 ad4:	6902                	ld	s2,0(sp)
 ad6:	6105                	add	sp,sp,32
 ad8:	8082                	ret
            rcureadunlock();
 ada:	00000097          	auipc	ra,0x0
 ade:	a1a080e7          	jalr	-1510(ra) # 4f4 <rcureadunlock>
            return current; // Node found
 ae2:	8526                	mv	a0,s1
 ae4:	b7ed                	j	ace <search+0x2e>

0000000000000ae6 <updateNode>:

// Function to update the value of a node with a given key in the linked list
void updateNode(struct Node *head, int key, int new_data) {
 ae6:	1101                	add	sp,sp,-32
 ae8:	ec06                	sd	ra,24(sp)
 aea:	e822                	sd	s0,16(sp)
 aec:	e426                	sd	s1,8(sp)
 aee:	e04a                	sd	s2,0(sp)
 af0:	1000                	add	s0,sp,32
 af2:	892e                	mv	s2,a1
 af4:	84b2                	mv	s1,a2
    struct Node *nodeToUpdate = search(head, key);
 af6:	00000097          	auipc	ra,0x0
 afa:	faa080e7          	jalr	-86(ra) # aa0 <search>

    if (nodeToUpdate != 0) {
 afe:	c901                	beqz	a0,b0e <updateNode+0x28>
        nodeToUpdate->data = new_data; // Update the node's data
 b00:	c104                	sw	s1,0(a0)
    } else {
        printf("Node with key %d not found.\n", key);
    }
}
 b02:	60e2                	ld	ra,24(sp)
 b04:	6442                	ld	s0,16(sp)
 b06:	64a2                	ld	s1,8(sp)
 b08:	6902                	ld	s2,0(sp)
 b0a:	6105                	add	sp,sp,32
 b0c:	8082                	ret
        printf("Node with key %d not found.\n", key);
 b0e:	85ca                	mv	a1,s2
 b10:	00000517          	auipc	a0,0x0
 b14:	0e050513          	add	a0,a0,224 # bf0 <digits+0x18>
 b18:	00000097          	auipc	ra,0x0
 b1c:	cec080e7          	jalr	-788(ra) # 804 <printf>
}
 b20:	b7cd                	j	b02 <updateNode+0x1c>
