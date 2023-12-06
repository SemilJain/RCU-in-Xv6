
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	7179                	add	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	add	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  16:	02e00a13          	li	s4,46
    if(matchhere(re, text))
  1a:	85a6                	mv	a1,s1
  1c:	854e                	mv	a0,s3
  1e:	00000097          	auipc	ra,0x0
  22:	030080e7          	jalr	48(ra) # 4e <matchhere>
  26:	e919                	bnez	a0,3c <matchstar+0x3c>
  }while(*text!='\0' && (*text++==c || c=='.'));
  28:	0004c783          	lbu	a5,0(s1)
  2c:	cb89                	beqz	a5,3e <matchstar+0x3e>
  2e:	0485                	add	s1,s1,1
  30:	2781                	sext.w	a5,a5
  32:	ff2784e3          	beq	a5,s2,1a <matchstar+0x1a>
  36:	ff4902e3          	beq	s2,s4,1a <matchstar+0x1a>
  3a:	a011                	j	3e <matchstar+0x3e>
      return 1;
  3c:	4505                	li	a0,1
  return 0;
}
  3e:	70a2                	ld	ra,40(sp)
  40:	7402                	ld	s0,32(sp)
  42:	64e2                	ld	s1,24(sp)
  44:	6942                	ld	s2,16(sp)
  46:	69a2                	ld	s3,8(sp)
  48:	6a02                	ld	s4,0(sp)
  4a:	6145                	add	sp,sp,48
  4c:	8082                	ret

000000000000004e <matchhere>:
  if(re[0] == '\0')
  4e:	00054703          	lbu	a4,0(a0)
  52:	cb3d                	beqz	a4,c8 <matchhere+0x7a>
{
  54:	1141                	add	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	add	s0,sp,16
  5c:	87aa                	mv	a5,a0
  if(re[1] == '*')
  5e:	00154683          	lbu	a3,1(a0)
  62:	02a00613          	li	a2,42
  66:	02c68563          	beq	a3,a2,90 <matchhere+0x42>
  if(re[0] == '$' && re[1] == '\0')
  6a:	02400613          	li	a2,36
  6e:	02c70a63          	beq	a4,a2,a2 <matchhere+0x54>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  72:	0005c683          	lbu	a3,0(a1)
  return 0;
  76:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  78:	ca81                	beqz	a3,88 <matchhere+0x3a>
  7a:	02e00613          	li	a2,46
  7e:	02c70d63          	beq	a4,a2,b8 <matchhere+0x6a>
  return 0;
  82:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  84:	02d70a63          	beq	a4,a3,b8 <matchhere+0x6a>
}
  88:	60a2                	ld	ra,8(sp)
  8a:	6402                	ld	s0,0(sp)
  8c:	0141                	add	sp,sp,16
  8e:	8082                	ret
    return matchstar(re[0], re+2, text);
  90:	862e                	mv	a2,a1
  92:	00250593          	add	a1,a0,2
  96:	853a                	mv	a0,a4
  98:	00000097          	auipc	ra,0x0
  9c:	f68080e7          	jalr	-152(ra) # 0 <matchstar>
  a0:	b7e5                	j	88 <matchhere+0x3a>
  if(re[0] == '$' && re[1] == '\0')
  a2:	c691                	beqz	a3,ae <matchhere+0x60>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  a4:	0005c683          	lbu	a3,0(a1)
  a8:	fee9                	bnez	a3,82 <matchhere+0x34>
  return 0;
  aa:	4501                	li	a0,0
  ac:	bff1                	j	88 <matchhere+0x3a>
    return *text == '\0';
  ae:	0005c503          	lbu	a0,0(a1)
  b2:	00153513          	seqz	a0,a0
  b6:	bfc9                	j	88 <matchhere+0x3a>
    return matchhere(re+1, text+1);
  b8:	0585                	add	a1,a1,1
  ba:	00178513          	add	a0,a5,1
  be:	00000097          	auipc	ra,0x0
  c2:	f90080e7          	jalr	-112(ra) # 4e <matchhere>
  c6:	b7c9                	j	88 <matchhere+0x3a>
    return 1;
  c8:	4505                	li	a0,1
}
  ca:	8082                	ret

00000000000000cc <match>:
{
  cc:	1101                	add	sp,sp,-32
  ce:	ec06                	sd	ra,24(sp)
  d0:	e822                	sd	s0,16(sp)
  d2:	e426                	sd	s1,8(sp)
  d4:	e04a                	sd	s2,0(sp)
  d6:	1000                	add	s0,sp,32
  d8:	892a                	mv	s2,a0
  da:	84ae                	mv	s1,a1
  if(re[0] == '^')
  dc:	00054703          	lbu	a4,0(a0)
  e0:	05e00793          	li	a5,94
  e4:	00f70e63          	beq	a4,a5,100 <match+0x34>
    if(matchhere(re, text))
  e8:	85a6                	mv	a1,s1
  ea:	854a                	mv	a0,s2
  ec:	00000097          	auipc	ra,0x0
  f0:	f62080e7          	jalr	-158(ra) # 4e <matchhere>
  f4:	ed01                	bnez	a0,10c <match+0x40>
  }while(*text++ != '\0');
  f6:	0485                	add	s1,s1,1
  f8:	fff4c783          	lbu	a5,-1(s1)
  fc:	f7f5                	bnez	a5,e8 <match+0x1c>
  fe:	a801                	j	10e <match+0x42>
    return matchhere(re+1, text);
 100:	0505                	add	a0,a0,1
 102:	00000097          	auipc	ra,0x0
 106:	f4c080e7          	jalr	-180(ra) # 4e <matchhere>
 10a:	a011                	j	10e <match+0x42>
      return 1;
 10c:	4505                	li	a0,1
}
 10e:	60e2                	ld	ra,24(sp)
 110:	6442                	ld	s0,16(sp)
 112:	64a2                	ld	s1,8(sp)
 114:	6902                	ld	s2,0(sp)
 116:	6105                	add	sp,sp,32
 118:	8082                	ret

000000000000011a <grep>:
{
 11a:	715d                	add	sp,sp,-80
 11c:	e486                	sd	ra,72(sp)
 11e:	e0a2                	sd	s0,64(sp)
 120:	fc26                	sd	s1,56(sp)
 122:	f84a                	sd	s2,48(sp)
 124:	f44e                	sd	s3,40(sp)
 126:	f052                	sd	s4,32(sp)
 128:	ec56                	sd	s5,24(sp)
 12a:	e85a                	sd	s6,16(sp)
 12c:	e45e                	sd	s7,8(sp)
 12e:	e062                	sd	s8,0(sp)
 130:	0880                	add	s0,sp,80
 132:	89aa                	mv	s3,a0
 134:	8b2e                	mv	s6,a1
  m = 0;
 136:	4a01                	li	s4,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 138:	3ff00b93          	li	s7,1023
 13c:	00001a97          	auipc	s5,0x1
 140:	ed4a8a93          	add	s5,s5,-300 # 1010 <buf>
 144:	a0a1                	j	18c <grep+0x72>
      p = q+1;
 146:	00148913          	add	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 14a:	45a9                	li	a1,10
 14c:	854a                	mv	a0,s2
 14e:	00000097          	auipc	ra,0x0
 152:	20a080e7          	jalr	522(ra) # 358 <strchr>
 156:	84aa                	mv	s1,a0
 158:	c905                	beqz	a0,188 <grep+0x6e>
      *q = 0;
 15a:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
 15e:	85ca                	mv	a1,s2
 160:	854e                	mv	a0,s3
 162:	00000097          	auipc	ra,0x0
 166:	f6a080e7          	jalr	-150(ra) # cc <match>
 16a:	dd71                	beqz	a0,146 <grep+0x2c>
        *q = '\n';
 16c:	47a9                	li	a5,10
 16e:	00f48023          	sb	a5,0(s1)
        write(1, p, q+1 - p);
 172:	00148613          	add	a2,s1,1
 176:	4126063b          	subw	a2,a2,s2
 17a:	85ca                	mv	a1,s2
 17c:	4505                	li	a0,1
 17e:	00000097          	auipc	ra,0x0
 182:	40e080e7          	jalr	1038(ra) # 58c <write>
 186:	b7c1                	j	146 <grep+0x2c>
    if(m > 0){
 188:	03404763          	bgtz	s4,1b6 <grep+0x9c>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 18c:	414b863b          	subw	a2,s7,s4
 190:	014a85b3          	add	a1,s5,s4
 194:	855a                	mv	a0,s6
 196:	00000097          	auipc	ra,0x0
 19a:	3ee080e7          	jalr	1006(ra) # 584 <read>
 19e:	02a05b63          	blez	a0,1d4 <grep+0xba>
    m += n;
 1a2:	00aa0c3b          	addw	s8,s4,a0
 1a6:	000c0a1b          	sext.w	s4,s8
    buf[m] = '\0';
 1aa:	014a87b3          	add	a5,s5,s4
 1ae:	00078023          	sb	zero,0(a5)
    p = buf;
 1b2:	8956                	mv	s2,s5
    while((q = strchr(p, '\n')) != 0){
 1b4:	bf59                	j	14a <grep+0x30>
      m -= p - buf;
 1b6:	00001517          	auipc	a0,0x1
 1ba:	e5a50513          	add	a0,a0,-422 # 1010 <buf>
 1be:	40a90a33          	sub	s4,s2,a0
 1c2:	414c0a3b          	subw	s4,s8,s4
      memmove(buf, p, m);
 1c6:	8652                	mv	a2,s4
 1c8:	85ca                	mv	a1,s2
 1ca:	00000097          	auipc	ra,0x0
 1ce:	2b4080e7          	jalr	692(ra) # 47e <memmove>
 1d2:	bf6d                	j	18c <grep+0x72>
}
 1d4:	60a6                	ld	ra,72(sp)
 1d6:	6406                	ld	s0,64(sp)
 1d8:	74e2                	ld	s1,56(sp)
 1da:	7942                	ld	s2,48(sp)
 1dc:	79a2                	ld	s3,40(sp)
 1de:	7a02                	ld	s4,32(sp)
 1e0:	6ae2                	ld	s5,24(sp)
 1e2:	6b42                	ld	s6,16(sp)
 1e4:	6ba2                	ld	s7,8(sp)
 1e6:	6c02                	ld	s8,0(sp)
 1e8:	6161                	add	sp,sp,80
 1ea:	8082                	ret

00000000000001ec <main>:
{
 1ec:	7179                	add	sp,sp,-48
 1ee:	f406                	sd	ra,40(sp)
 1f0:	f022                	sd	s0,32(sp)
 1f2:	ec26                	sd	s1,24(sp)
 1f4:	e84a                	sd	s2,16(sp)
 1f6:	e44e                	sd	s3,8(sp)
 1f8:	e052                	sd	s4,0(sp)
 1fa:	1800                	add	s0,sp,48
  if(argc <= 1){
 1fc:	4785                	li	a5,1
 1fe:	04a7de63          	bge	a5,a0,25a <main+0x6e>
  pattern = argv[1];
 202:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
 206:	4789                	li	a5,2
 208:	06a7d763          	bge	a5,a0,276 <main+0x8a>
 20c:	01058913          	add	s2,a1,16
 210:	ffd5099b          	addw	s3,a0,-3
 214:	02099793          	sll	a5,s3,0x20
 218:	01d7d993          	srl	s3,a5,0x1d
 21c:	05e1                	add	a1,a1,24
 21e:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], 0)) < 0){
 220:	4581                	li	a1,0
 222:	00093503          	ld	a0,0(s2)
 226:	00000097          	auipc	ra,0x0
 22a:	386080e7          	jalr	902(ra) # 5ac <open>
 22e:	84aa                	mv	s1,a0
 230:	04054e63          	bltz	a0,28c <main+0xa0>
    grep(pattern, fd);
 234:	85aa                	mv	a1,a0
 236:	8552                	mv	a0,s4
 238:	00000097          	auipc	ra,0x0
 23c:	ee2080e7          	jalr	-286(ra) # 11a <grep>
    close(fd);
 240:	8526                	mv	a0,s1
 242:	00000097          	auipc	ra,0x0
 246:	352080e7          	jalr	850(ra) # 594 <close>
  for(i = 2; i < argc; i++){
 24a:	0921                	add	s2,s2,8
 24c:	fd391ae3          	bne	s2,s3,220 <main+0x34>
  exit(0);
 250:	4501                	li	a0,0
 252:	00000097          	auipc	ra,0x0
 256:	31a080e7          	jalr	794(ra) # 56c <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 25a:	00001597          	auipc	a1,0x1
 25e:	9f658593          	add	a1,a1,-1546 # c50 <updateNode+0x4a>
 262:	4509                	li	a0,2
 264:	00000097          	auipc	ra,0x0
 268:	692080e7          	jalr	1682(ra) # 8f6 <fprintf>
    exit(1);
 26c:	4505                	li	a0,1
 26e:	00000097          	auipc	ra,0x0
 272:	2fe080e7          	jalr	766(ra) # 56c <exit>
    grep(pattern, 0);
 276:	4581                	li	a1,0
 278:	8552                	mv	a0,s4
 27a:	00000097          	auipc	ra,0x0
 27e:	ea0080e7          	jalr	-352(ra) # 11a <grep>
    exit(0);
 282:	4501                	li	a0,0
 284:	00000097          	auipc	ra,0x0
 288:	2e8080e7          	jalr	744(ra) # 56c <exit>
      printf("grep: cannot open %s\n", argv[i]);
 28c:	00093583          	ld	a1,0(s2)
 290:	00001517          	auipc	a0,0x1
 294:	9e050513          	add	a0,a0,-1568 # c70 <updateNode+0x6a>
 298:	00000097          	auipc	ra,0x0
 29c:	68c080e7          	jalr	1676(ra) # 924 <printf>
      exit(1);
 2a0:	4505                	li	a0,1
 2a2:	00000097          	auipc	ra,0x0
 2a6:	2ca080e7          	jalr	714(ra) # 56c <exit>

00000000000002aa <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 2aa:	1141                	add	sp,sp,-16
 2ac:	e406                	sd	ra,8(sp)
 2ae:	e022                	sd	s0,0(sp)
 2b0:	0800                	add	s0,sp,16
  extern int main();
  main();
 2b2:	00000097          	auipc	ra,0x0
 2b6:	f3a080e7          	jalr	-198(ra) # 1ec <main>
  exit(0);
 2ba:	4501                	li	a0,0
 2bc:	00000097          	auipc	ra,0x0
 2c0:	2b0080e7          	jalr	688(ra) # 56c <exit>

00000000000002c4 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 2c4:	1141                	add	sp,sp,-16
 2c6:	e422                	sd	s0,8(sp)
 2c8:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2ca:	87aa                	mv	a5,a0
 2cc:	0585                	add	a1,a1,1
 2ce:	0785                	add	a5,a5,1
 2d0:	fff5c703          	lbu	a4,-1(a1)
 2d4:	fee78fa3          	sb	a4,-1(a5)
 2d8:	fb75                	bnez	a4,2cc <strcpy+0x8>
    ;
  return os;
}
 2da:	6422                	ld	s0,8(sp)
 2dc:	0141                	add	sp,sp,16
 2de:	8082                	ret

00000000000002e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2e0:	1141                	add	sp,sp,-16
 2e2:	e422                	sd	s0,8(sp)
 2e4:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 2e6:	00054783          	lbu	a5,0(a0)
 2ea:	cb91                	beqz	a5,2fe <strcmp+0x1e>
 2ec:	0005c703          	lbu	a4,0(a1)
 2f0:	00f71763          	bne	a4,a5,2fe <strcmp+0x1e>
    p++, q++;
 2f4:	0505                	add	a0,a0,1
 2f6:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 2f8:	00054783          	lbu	a5,0(a0)
 2fc:	fbe5                	bnez	a5,2ec <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2fe:	0005c503          	lbu	a0,0(a1)
}
 302:	40a7853b          	subw	a0,a5,a0
 306:	6422                	ld	s0,8(sp)
 308:	0141                	add	sp,sp,16
 30a:	8082                	ret

000000000000030c <strlen>:

uint
strlen(const char *s)
{
 30c:	1141                	add	sp,sp,-16
 30e:	e422                	sd	s0,8(sp)
 310:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 312:	00054783          	lbu	a5,0(a0)
 316:	cf91                	beqz	a5,332 <strlen+0x26>
 318:	0505                	add	a0,a0,1
 31a:	87aa                	mv	a5,a0
 31c:	86be                	mv	a3,a5
 31e:	0785                	add	a5,a5,1
 320:	fff7c703          	lbu	a4,-1(a5)
 324:	ff65                	bnez	a4,31c <strlen+0x10>
 326:	40a6853b          	subw	a0,a3,a0
 32a:	2505                	addw	a0,a0,1
    ;
  return n;
}
 32c:	6422                	ld	s0,8(sp)
 32e:	0141                	add	sp,sp,16
 330:	8082                	ret
  for(n = 0; s[n]; n++)
 332:	4501                	li	a0,0
 334:	bfe5                	j	32c <strlen+0x20>

0000000000000336 <memset>:

void*
memset(void *dst, int c, uint n)
{
 336:	1141                	add	sp,sp,-16
 338:	e422                	sd	s0,8(sp)
 33a:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 33c:	ca19                	beqz	a2,352 <memset+0x1c>
 33e:	87aa                	mv	a5,a0
 340:	1602                	sll	a2,a2,0x20
 342:	9201                	srl	a2,a2,0x20
 344:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 348:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 34c:	0785                	add	a5,a5,1
 34e:	fee79de3          	bne	a5,a4,348 <memset+0x12>
  }
  return dst;
}
 352:	6422                	ld	s0,8(sp)
 354:	0141                	add	sp,sp,16
 356:	8082                	ret

0000000000000358 <strchr>:

char*
strchr(const char *s, char c)
{
 358:	1141                	add	sp,sp,-16
 35a:	e422                	sd	s0,8(sp)
 35c:	0800                	add	s0,sp,16
  for(; *s; s++)
 35e:	00054783          	lbu	a5,0(a0)
 362:	cb99                	beqz	a5,378 <strchr+0x20>
    if(*s == c)
 364:	00f58763          	beq	a1,a5,372 <strchr+0x1a>
  for(; *s; s++)
 368:	0505                	add	a0,a0,1
 36a:	00054783          	lbu	a5,0(a0)
 36e:	fbfd                	bnez	a5,364 <strchr+0xc>
      return (char*)s;
  return 0;
 370:	4501                	li	a0,0
}
 372:	6422                	ld	s0,8(sp)
 374:	0141                	add	sp,sp,16
 376:	8082                	ret
  return 0;
 378:	4501                	li	a0,0
 37a:	bfe5                	j	372 <strchr+0x1a>

000000000000037c <gets>:

char*
gets(char *buf, int max)
{
 37c:	711d                	add	sp,sp,-96
 37e:	ec86                	sd	ra,88(sp)
 380:	e8a2                	sd	s0,80(sp)
 382:	e4a6                	sd	s1,72(sp)
 384:	e0ca                	sd	s2,64(sp)
 386:	fc4e                	sd	s3,56(sp)
 388:	f852                	sd	s4,48(sp)
 38a:	f456                	sd	s5,40(sp)
 38c:	f05a                	sd	s6,32(sp)
 38e:	ec5e                	sd	s7,24(sp)
 390:	1080                	add	s0,sp,96
 392:	8baa                	mv	s7,a0
 394:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 396:	892a                	mv	s2,a0
 398:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 39a:	4aa9                	li	s5,10
 39c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 39e:	89a6                	mv	s3,s1
 3a0:	2485                	addw	s1,s1,1
 3a2:	0344d863          	bge	s1,s4,3d2 <gets+0x56>
    cc = read(0, &c, 1);
 3a6:	4605                	li	a2,1
 3a8:	faf40593          	add	a1,s0,-81
 3ac:	4501                	li	a0,0
 3ae:	00000097          	auipc	ra,0x0
 3b2:	1d6080e7          	jalr	470(ra) # 584 <read>
    if(cc < 1)
 3b6:	00a05e63          	blez	a0,3d2 <gets+0x56>
    buf[i++] = c;
 3ba:	faf44783          	lbu	a5,-81(s0)
 3be:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3c2:	01578763          	beq	a5,s5,3d0 <gets+0x54>
 3c6:	0905                	add	s2,s2,1
 3c8:	fd679be3          	bne	a5,s6,39e <gets+0x22>
  for(i=0; i+1 < max; ){
 3cc:	89a6                	mv	s3,s1
 3ce:	a011                	j	3d2 <gets+0x56>
 3d0:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3d2:	99de                	add	s3,s3,s7
 3d4:	00098023          	sb	zero,0(s3)
  return buf;
}
 3d8:	855e                	mv	a0,s7
 3da:	60e6                	ld	ra,88(sp)
 3dc:	6446                	ld	s0,80(sp)
 3de:	64a6                	ld	s1,72(sp)
 3e0:	6906                	ld	s2,64(sp)
 3e2:	79e2                	ld	s3,56(sp)
 3e4:	7a42                	ld	s4,48(sp)
 3e6:	7aa2                	ld	s5,40(sp)
 3e8:	7b02                	ld	s6,32(sp)
 3ea:	6be2                	ld	s7,24(sp)
 3ec:	6125                	add	sp,sp,96
 3ee:	8082                	ret

00000000000003f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 3f0:	1101                	add	sp,sp,-32
 3f2:	ec06                	sd	ra,24(sp)
 3f4:	e822                	sd	s0,16(sp)
 3f6:	e426                	sd	s1,8(sp)
 3f8:	e04a                	sd	s2,0(sp)
 3fa:	1000                	add	s0,sp,32
 3fc:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3fe:	4581                	li	a1,0
 400:	00000097          	auipc	ra,0x0
 404:	1ac080e7          	jalr	428(ra) # 5ac <open>
  if(fd < 0)
 408:	02054563          	bltz	a0,432 <stat+0x42>
 40c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 40e:	85ca                	mv	a1,s2
 410:	00000097          	auipc	ra,0x0
 414:	1b4080e7          	jalr	436(ra) # 5c4 <fstat>
 418:	892a                	mv	s2,a0
  close(fd);
 41a:	8526                	mv	a0,s1
 41c:	00000097          	auipc	ra,0x0
 420:	178080e7          	jalr	376(ra) # 594 <close>
  return r;
}
 424:	854a                	mv	a0,s2
 426:	60e2                	ld	ra,24(sp)
 428:	6442                	ld	s0,16(sp)
 42a:	64a2                	ld	s1,8(sp)
 42c:	6902                	ld	s2,0(sp)
 42e:	6105                	add	sp,sp,32
 430:	8082                	ret
    return -1;
 432:	597d                	li	s2,-1
 434:	bfc5                	j	424 <stat+0x34>

0000000000000436 <atoi>:

int
atoi(const char *s)
{
 436:	1141                	add	sp,sp,-16
 438:	e422                	sd	s0,8(sp)
 43a:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 43c:	00054683          	lbu	a3,0(a0)
 440:	fd06879b          	addw	a5,a3,-48
 444:	0ff7f793          	zext.b	a5,a5
 448:	4625                	li	a2,9
 44a:	02f66863          	bltu	a2,a5,47a <atoi+0x44>
 44e:	872a                	mv	a4,a0
  n = 0;
 450:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 452:	0705                	add	a4,a4,1
 454:	0025179b          	sllw	a5,a0,0x2
 458:	9fa9                	addw	a5,a5,a0
 45a:	0017979b          	sllw	a5,a5,0x1
 45e:	9fb5                	addw	a5,a5,a3
 460:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 464:	00074683          	lbu	a3,0(a4)
 468:	fd06879b          	addw	a5,a3,-48
 46c:	0ff7f793          	zext.b	a5,a5
 470:	fef671e3          	bgeu	a2,a5,452 <atoi+0x1c>
  return n;
}
 474:	6422                	ld	s0,8(sp)
 476:	0141                	add	sp,sp,16
 478:	8082                	ret
  n = 0;
 47a:	4501                	li	a0,0
 47c:	bfe5                	j	474 <atoi+0x3e>

000000000000047e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 47e:	1141                	add	sp,sp,-16
 480:	e422                	sd	s0,8(sp)
 482:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 484:	02b57463          	bgeu	a0,a1,4ac <memmove+0x2e>
    while(n-- > 0)
 488:	00c05f63          	blez	a2,4a6 <memmove+0x28>
 48c:	1602                	sll	a2,a2,0x20
 48e:	9201                	srl	a2,a2,0x20
 490:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 494:	872a                	mv	a4,a0
      *dst++ = *src++;
 496:	0585                	add	a1,a1,1
 498:	0705                	add	a4,a4,1
 49a:	fff5c683          	lbu	a3,-1(a1)
 49e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4a2:	fee79ae3          	bne	a5,a4,496 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4a6:	6422                	ld	s0,8(sp)
 4a8:	0141                	add	sp,sp,16
 4aa:	8082                	ret
    dst += n;
 4ac:	00c50733          	add	a4,a0,a2
    src += n;
 4b0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4b2:	fec05ae3          	blez	a2,4a6 <memmove+0x28>
 4b6:	fff6079b          	addw	a5,a2,-1
 4ba:	1782                	sll	a5,a5,0x20
 4bc:	9381                	srl	a5,a5,0x20
 4be:	fff7c793          	not	a5,a5
 4c2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4c4:	15fd                	add	a1,a1,-1
 4c6:	177d                	add	a4,a4,-1
 4c8:	0005c683          	lbu	a3,0(a1)
 4cc:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4d0:	fee79ae3          	bne	a5,a4,4c4 <memmove+0x46>
 4d4:	bfc9                	j	4a6 <memmove+0x28>

00000000000004d6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4d6:	1141                	add	sp,sp,-16
 4d8:	e422                	sd	s0,8(sp)
 4da:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4dc:	ca05                	beqz	a2,50c <memcmp+0x36>
 4de:	fff6069b          	addw	a3,a2,-1
 4e2:	1682                	sll	a3,a3,0x20
 4e4:	9281                	srl	a3,a3,0x20
 4e6:	0685                	add	a3,a3,1
 4e8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4ea:	00054783          	lbu	a5,0(a0)
 4ee:	0005c703          	lbu	a4,0(a1)
 4f2:	00e79863          	bne	a5,a4,502 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4f6:	0505                	add	a0,a0,1
    p2++;
 4f8:	0585                	add	a1,a1,1
  while (n-- > 0) {
 4fa:	fed518e3          	bne	a0,a3,4ea <memcmp+0x14>
  }
  return 0;
 4fe:	4501                	li	a0,0
 500:	a019                	j	506 <memcmp+0x30>
      return *p1 - *p2;
 502:	40e7853b          	subw	a0,a5,a4
}
 506:	6422                	ld	s0,8(sp)
 508:	0141                	add	sp,sp,16
 50a:	8082                	ret
  return 0;
 50c:	4501                	li	a0,0
 50e:	bfe5                	j	506 <memcmp+0x30>

0000000000000510 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 510:	1141                	add	sp,sp,-16
 512:	e406                	sd	ra,8(sp)
 514:	e022                	sd	s0,0(sp)
 516:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 518:	00000097          	auipc	ra,0x0
 51c:	f66080e7          	jalr	-154(ra) # 47e <memmove>
}
 520:	60a2                	ld	ra,8(sp)
 522:	6402                	ld	s0,0(sp)
 524:	0141                	add	sp,sp,16
 526:	8082                	ret

0000000000000528 <initlock>:

// Initialize the spinlock
void initlock(struct spinlock_u *lk) {
 528:	1141                	add	sp,sp,-16
 52a:	e422                	sd	s0,8(sp)
 52c:	0800                	add	s0,sp,16
  lk->locked = 0;
 52e:	00052023          	sw	zero,0(a0)
}
 532:	6422                	ld	s0,8(sp)
 534:	0141                	add	sp,sp,16
 536:	8082                	ret

0000000000000538 <acquire>:

// Acquire the spinlock
void acquire(struct spinlock_u *lk) {
 538:	1141                	add	sp,sp,-16
 53a:	e422                	sd	s0,8(sp)
 53c:	0800                	add	s0,sp,16
  while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 53e:	4705                	li	a4,1
 540:	87ba                	mv	a5,a4
 542:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
 546:	2781                	sext.w	a5,a5
 548:	ffe5                	bnez	a5,540 <acquire+0x8>
    ; // Spin until the lock is acquired
}
 54a:	6422                	ld	s0,8(sp)
 54c:	0141                	add	sp,sp,16
 54e:	8082                	ret

0000000000000550 <release>:

// Release the spinlock
void release(struct spinlock_u *lk) {
 550:	1141                	add	sp,sp,-16
 552:	e422                	sd	s0,8(sp)
 554:	0800                	add	s0,sp,16
  __sync_lock_release(&lk->locked);
 556:	0f50000f          	fence	iorw,ow
 55a:	0805202f          	amoswap.w	zero,zero,(a0)
}
 55e:	6422                	ld	s0,8(sp)
 560:	0141                	add	sp,sp,16
 562:	8082                	ret

0000000000000564 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 564:	4885                	li	a7,1
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <exit>:
.global exit
exit:
 li a7, SYS_exit
 56c:	4889                	li	a7,2
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <wait>:
.global wait
wait:
 li a7, SYS_wait
 574:	488d                	li	a7,3
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 57c:	4891                	li	a7,4
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <read>:
.global read
read:
 li a7, SYS_read
 584:	4895                	li	a7,5
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <write>:
.global write
write:
 li a7, SYS_write
 58c:	48c1                	li	a7,16
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <close>:
.global close
close:
 li a7, SYS_close
 594:	48d5                	li	a7,21
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <kill>:
.global kill
kill:
 li a7, SYS_kill
 59c:	4899                	li	a7,6
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5a4:	489d                	li	a7,7
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <open>:
.global open
open:
 li a7, SYS_open
 5ac:	48bd                	li	a7,15
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5b4:	48c5                	li	a7,17
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5bc:	48c9                	li	a7,18
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5c4:	48a1                	li	a7,8
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <link>:
.global link
link:
 li a7, SYS_link
 5cc:	48cd                	li	a7,19
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5d4:	48d1                	li	a7,20
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5dc:	48a5                	li	a7,9
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5e4:	48a9                	li	a7,10
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5ec:	48ad                	li	a7,11
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5f4:	48b1                	li	a7,12
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5fc:	48b5                	li	a7,13
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 604:	48b9                	li	a7,14
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <rcureadlock>:
.global rcureadlock
rcureadlock:
 li a7, SYS_rcureadlock
 60c:	48dd                	li	a7,23
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <rcureadunlock>:
.global rcureadunlock
rcureadunlock:
 li a7, SYS_rcureadunlock
 614:	48e1                	li	a7,24
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <rcusync>:
.global rcusync
rcusync:
 li a7, SYS_rcusync
 61c:	48d9                	li	a7,22
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <thread_create>:
.global thread_create
thread_create:
 li a7, SYS_thread_create
 624:	48e5                	li	a7,25
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <thread_join>:
.global thread_join
thread_join:
 li a7, SYS_thread_join
 62c:	48e9                	li	a7,26
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <thread_exit>:
.global thread_exit
thread_exit:
 li a7, SYS_thread_exit
 634:	48ed                	li	a7,27
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <klist_insert>:
.global klist_insert
klist_insert:
 li a7, SYS_klist_insert
 63c:	48f1                	li	a7,28
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <klist_delete>:
.global klist_delete
klist_delete:
 li a7, SYS_klist_delete
 644:	48f5                	li	a7,29
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <klist_query>:
.global klist_query
klist_query:
 li a7, SYS_klist_query
 64c:	48f9                	li	a7,30
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <klist_print>:
.global klist_print
klist_print:
 li a7, SYS_klist_print
 654:	48fd                	li	a7,31
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 65c:	1101                	add	sp,sp,-32
 65e:	ec06                	sd	ra,24(sp)
 660:	e822                	sd	s0,16(sp)
 662:	1000                	add	s0,sp,32
 664:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 668:	4605                	li	a2,1
 66a:	fef40593          	add	a1,s0,-17
 66e:	00000097          	auipc	ra,0x0
 672:	f1e080e7          	jalr	-226(ra) # 58c <write>
}
 676:	60e2                	ld	ra,24(sp)
 678:	6442                	ld	s0,16(sp)
 67a:	6105                	add	sp,sp,32
 67c:	8082                	ret

000000000000067e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 67e:	7139                	add	sp,sp,-64
 680:	fc06                	sd	ra,56(sp)
 682:	f822                	sd	s0,48(sp)
 684:	f426                	sd	s1,40(sp)
 686:	f04a                	sd	s2,32(sp)
 688:	ec4e                	sd	s3,24(sp)
 68a:	0080                	add	s0,sp,64
 68c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 68e:	c299                	beqz	a3,694 <printint+0x16>
 690:	0805c963          	bltz	a1,722 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 694:	2581                	sext.w	a1,a1
  neg = 0;
 696:	4881                	li	a7,0
 698:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 69c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 69e:	2601                	sext.w	a2,a2
 6a0:	00000517          	auipc	a0,0x0
 6a4:	64850513          	add	a0,a0,1608 # ce8 <digits>
 6a8:	883a                	mv	a6,a4
 6aa:	2705                	addw	a4,a4,1
 6ac:	02c5f7bb          	remuw	a5,a1,a2
 6b0:	1782                	sll	a5,a5,0x20
 6b2:	9381                	srl	a5,a5,0x20
 6b4:	97aa                	add	a5,a5,a0
 6b6:	0007c783          	lbu	a5,0(a5)
 6ba:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6be:	0005879b          	sext.w	a5,a1
 6c2:	02c5d5bb          	divuw	a1,a1,a2
 6c6:	0685                	add	a3,a3,1
 6c8:	fec7f0e3          	bgeu	a5,a2,6a8 <printint+0x2a>
  if(neg)
 6cc:	00088c63          	beqz	a7,6e4 <printint+0x66>
    buf[i++] = '-';
 6d0:	fd070793          	add	a5,a4,-48
 6d4:	00878733          	add	a4,a5,s0
 6d8:	02d00793          	li	a5,45
 6dc:	fef70823          	sb	a5,-16(a4)
 6e0:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 6e4:	02e05863          	blez	a4,714 <printint+0x96>
 6e8:	fc040793          	add	a5,s0,-64
 6ec:	00e78933          	add	s2,a5,a4
 6f0:	fff78993          	add	s3,a5,-1
 6f4:	99ba                	add	s3,s3,a4
 6f6:	377d                	addw	a4,a4,-1
 6f8:	1702                	sll	a4,a4,0x20
 6fa:	9301                	srl	a4,a4,0x20
 6fc:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 700:	fff94583          	lbu	a1,-1(s2)
 704:	8526                	mv	a0,s1
 706:	00000097          	auipc	ra,0x0
 70a:	f56080e7          	jalr	-170(ra) # 65c <putc>
  while(--i >= 0)
 70e:	197d                	add	s2,s2,-1
 710:	ff3918e3          	bne	s2,s3,700 <printint+0x82>
}
 714:	70e2                	ld	ra,56(sp)
 716:	7442                	ld	s0,48(sp)
 718:	74a2                	ld	s1,40(sp)
 71a:	7902                	ld	s2,32(sp)
 71c:	69e2                	ld	s3,24(sp)
 71e:	6121                	add	sp,sp,64
 720:	8082                	ret
    x = -xx;
 722:	40b005bb          	negw	a1,a1
    neg = 1;
 726:	4885                	li	a7,1
    x = -xx;
 728:	bf85                	j	698 <printint+0x1a>

000000000000072a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 72a:	715d                	add	sp,sp,-80
 72c:	e486                	sd	ra,72(sp)
 72e:	e0a2                	sd	s0,64(sp)
 730:	fc26                	sd	s1,56(sp)
 732:	f84a                	sd	s2,48(sp)
 734:	f44e                	sd	s3,40(sp)
 736:	f052                	sd	s4,32(sp)
 738:	ec56                	sd	s5,24(sp)
 73a:	e85a                	sd	s6,16(sp)
 73c:	e45e                	sd	s7,8(sp)
 73e:	e062                	sd	s8,0(sp)
 740:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 742:	0005c903          	lbu	s2,0(a1)
 746:	18090c63          	beqz	s2,8de <vprintf+0x1b4>
 74a:	8aaa                	mv	s5,a0
 74c:	8bb2                	mv	s7,a2
 74e:	00158493          	add	s1,a1,1
  state = 0;
 752:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 754:	02500a13          	li	s4,37
 758:	4b55                	li	s6,21
 75a:	a839                	j	778 <vprintf+0x4e>
        putc(fd, c);
 75c:	85ca                	mv	a1,s2
 75e:	8556                	mv	a0,s5
 760:	00000097          	auipc	ra,0x0
 764:	efc080e7          	jalr	-260(ra) # 65c <putc>
 768:	a019                	j	76e <vprintf+0x44>
    } else if(state == '%'){
 76a:	01498d63          	beq	s3,s4,784 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 76e:	0485                	add	s1,s1,1
 770:	fff4c903          	lbu	s2,-1(s1)
 774:	16090563          	beqz	s2,8de <vprintf+0x1b4>
    if(state == 0){
 778:	fe0999e3          	bnez	s3,76a <vprintf+0x40>
      if(c == '%'){
 77c:	ff4910e3          	bne	s2,s4,75c <vprintf+0x32>
        state = '%';
 780:	89d2                	mv	s3,s4
 782:	b7f5                	j	76e <vprintf+0x44>
      if(c == 'd'){
 784:	13490263          	beq	s2,s4,8a8 <vprintf+0x17e>
 788:	f9d9079b          	addw	a5,s2,-99
 78c:	0ff7f793          	zext.b	a5,a5
 790:	12fb6563          	bltu	s6,a5,8ba <vprintf+0x190>
 794:	f9d9079b          	addw	a5,s2,-99
 798:	0ff7f713          	zext.b	a4,a5
 79c:	10eb6f63          	bltu	s6,a4,8ba <vprintf+0x190>
 7a0:	00271793          	sll	a5,a4,0x2
 7a4:	00000717          	auipc	a4,0x0
 7a8:	4ec70713          	add	a4,a4,1260 # c90 <updateNode+0x8a>
 7ac:	97ba                	add	a5,a5,a4
 7ae:	439c                	lw	a5,0(a5)
 7b0:	97ba                	add	a5,a5,a4
 7b2:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 7b4:	008b8913          	add	s2,s7,8
 7b8:	4685                	li	a3,1
 7ba:	4629                	li	a2,10
 7bc:	000ba583          	lw	a1,0(s7)
 7c0:	8556                	mv	a0,s5
 7c2:	00000097          	auipc	ra,0x0
 7c6:	ebc080e7          	jalr	-324(ra) # 67e <printint>
 7ca:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7cc:	4981                	li	s3,0
 7ce:	b745                	j	76e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7d0:	008b8913          	add	s2,s7,8
 7d4:	4681                	li	a3,0
 7d6:	4629                	li	a2,10
 7d8:	000ba583          	lw	a1,0(s7)
 7dc:	8556                	mv	a0,s5
 7de:	00000097          	auipc	ra,0x0
 7e2:	ea0080e7          	jalr	-352(ra) # 67e <printint>
 7e6:	8bca                	mv	s7,s2
      state = 0;
 7e8:	4981                	li	s3,0
 7ea:	b751                	j	76e <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 7ec:	008b8913          	add	s2,s7,8
 7f0:	4681                	li	a3,0
 7f2:	4641                	li	a2,16
 7f4:	000ba583          	lw	a1,0(s7)
 7f8:	8556                	mv	a0,s5
 7fa:	00000097          	auipc	ra,0x0
 7fe:	e84080e7          	jalr	-380(ra) # 67e <printint>
 802:	8bca                	mv	s7,s2
      state = 0;
 804:	4981                	li	s3,0
 806:	b7a5                	j	76e <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 808:	008b8c13          	add	s8,s7,8
 80c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 810:	03000593          	li	a1,48
 814:	8556                	mv	a0,s5
 816:	00000097          	auipc	ra,0x0
 81a:	e46080e7          	jalr	-442(ra) # 65c <putc>
  putc(fd, 'x');
 81e:	07800593          	li	a1,120
 822:	8556                	mv	a0,s5
 824:	00000097          	auipc	ra,0x0
 828:	e38080e7          	jalr	-456(ra) # 65c <putc>
 82c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 82e:	00000b97          	auipc	s7,0x0
 832:	4bab8b93          	add	s7,s7,1210 # ce8 <digits>
 836:	03c9d793          	srl	a5,s3,0x3c
 83a:	97de                	add	a5,a5,s7
 83c:	0007c583          	lbu	a1,0(a5)
 840:	8556                	mv	a0,s5
 842:	00000097          	auipc	ra,0x0
 846:	e1a080e7          	jalr	-486(ra) # 65c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 84a:	0992                	sll	s3,s3,0x4
 84c:	397d                	addw	s2,s2,-1
 84e:	fe0914e3          	bnez	s2,836 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 852:	8be2                	mv	s7,s8
      state = 0;
 854:	4981                	li	s3,0
 856:	bf21                	j	76e <vprintf+0x44>
        s = va_arg(ap, char*);
 858:	008b8993          	add	s3,s7,8
 85c:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 860:	02090163          	beqz	s2,882 <vprintf+0x158>
        while(*s != 0){
 864:	00094583          	lbu	a1,0(s2)
 868:	c9a5                	beqz	a1,8d8 <vprintf+0x1ae>
          putc(fd, *s);
 86a:	8556                	mv	a0,s5
 86c:	00000097          	auipc	ra,0x0
 870:	df0080e7          	jalr	-528(ra) # 65c <putc>
          s++;
 874:	0905                	add	s2,s2,1
        while(*s != 0){
 876:	00094583          	lbu	a1,0(s2)
 87a:	f9e5                	bnez	a1,86a <vprintf+0x140>
        s = va_arg(ap, char*);
 87c:	8bce                	mv	s7,s3
      state = 0;
 87e:	4981                	li	s3,0
 880:	b5fd                	j	76e <vprintf+0x44>
          s = "(null)";
 882:	00000917          	auipc	s2,0x0
 886:	40690913          	add	s2,s2,1030 # c88 <updateNode+0x82>
        while(*s != 0){
 88a:	02800593          	li	a1,40
 88e:	bff1                	j	86a <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 890:	008b8913          	add	s2,s7,8
 894:	000bc583          	lbu	a1,0(s7)
 898:	8556                	mv	a0,s5
 89a:	00000097          	auipc	ra,0x0
 89e:	dc2080e7          	jalr	-574(ra) # 65c <putc>
 8a2:	8bca                	mv	s7,s2
      state = 0;
 8a4:	4981                	li	s3,0
 8a6:	b5e1                	j	76e <vprintf+0x44>
        putc(fd, c);
 8a8:	02500593          	li	a1,37
 8ac:	8556                	mv	a0,s5
 8ae:	00000097          	auipc	ra,0x0
 8b2:	dae080e7          	jalr	-594(ra) # 65c <putc>
      state = 0;
 8b6:	4981                	li	s3,0
 8b8:	bd5d                	j	76e <vprintf+0x44>
        putc(fd, '%');
 8ba:	02500593          	li	a1,37
 8be:	8556                	mv	a0,s5
 8c0:	00000097          	auipc	ra,0x0
 8c4:	d9c080e7          	jalr	-612(ra) # 65c <putc>
        putc(fd, c);
 8c8:	85ca                	mv	a1,s2
 8ca:	8556                	mv	a0,s5
 8cc:	00000097          	auipc	ra,0x0
 8d0:	d90080e7          	jalr	-624(ra) # 65c <putc>
      state = 0;
 8d4:	4981                	li	s3,0
 8d6:	bd61                	j	76e <vprintf+0x44>
        s = va_arg(ap, char*);
 8d8:	8bce                	mv	s7,s3
      state = 0;
 8da:	4981                	li	s3,0
 8dc:	bd49                	j	76e <vprintf+0x44>
    }
  }
}
 8de:	60a6                	ld	ra,72(sp)
 8e0:	6406                	ld	s0,64(sp)
 8e2:	74e2                	ld	s1,56(sp)
 8e4:	7942                	ld	s2,48(sp)
 8e6:	79a2                	ld	s3,40(sp)
 8e8:	7a02                	ld	s4,32(sp)
 8ea:	6ae2                	ld	s5,24(sp)
 8ec:	6b42                	ld	s6,16(sp)
 8ee:	6ba2                	ld	s7,8(sp)
 8f0:	6c02                	ld	s8,0(sp)
 8f2:	6161                	add	sp,sp,80
 8f4:	8082                	ret

00000000000008f6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8f6:	715d                	add	sp,sp,-80
 8f8:	ec06                	sd	ra,24(sp)
 8fa:	e822                	sd	s0,16(sp)
 8fc:	1000                	add	s0,sp,32
 8fe:	e010                	sd	a2,0(s0)
 900:	e414                	sd	a3,8(s0)
 902:	e818                	sd	a4,16(s0)
 904:	ec1c                	sd	a5,24(s0)
 906:	03043023          	sd	a6,32(s0)
 90a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 90e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 912:	8622                	mv	a2,s0
 914:	00000097          	auipc	ra,0x0
 918:	e16080e7          	jalr	-490(ra) # 72a <vprintf>
}
 91c:	60e2                	ld	ra,24(sp)
 91e:	6442                	ld	s0,16(sp)
 920:	6161                	add	sp,sp,80
 922:	8082                	ret

0000000000000924 <printf>:

void
printf(const char *fmt, ...)
{
 924:	711d                	add	sp,sp,-96
 926:	ec06                	sd	ra,24(sp)
 928:	e822                	sd	s0,16(sp)
 92a:	1000                	add	s0,sp,32
 92c:	e40c                	sd	a1,8(s0)
 92e:	e810                	sd	a2,16(s0)
 930:	ec14                	sd	a3,24(s0)
 932:	f018                	sd	a4,32(s0)
 934:	f41c                	sd	a5,40(s0)
 936:	03043823          	sd	a6,48(s0)
 93a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 93e:	00840613          	add	a2,s0,8
 942:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 946:	85aa                	mv	a1,a0
 948:	4505                	li	a0,1
 94a:	00000097          	auipc	ra,0x0
 94e:	de0080e7          	jalr	-544(ra) # 72a <vprintf>
}
 952:	60e2                	ld	ra,24(sp)
 954:	6442                	ld	s0,16(sp)
 956:	6125                	add	sp,sp,96
 958:	8082                	ret

000000000000095a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 95a:	1141                	add	sp,sp,-16
 95c:	e422                	sd	s0,8(sp)
 95e:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 960:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 964:	00000797          	auipc	a5,0x0
 968:	69c7b783          	ld	a5,1692(a5) # 1000 <freep>
 96c:	a02d                	j	996 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 96e:	4618                	lw	a4,8(a2)
 970:	9f2d                	addw	a4,a4,a1
 972:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 976:	6398                	ld	a4,0(a5)
 978:	6310                	ld	a2,0(a4)
 97a:	a83d                	j	9b8 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 97c:	ff852703          	lw	a4,-8(a0)
 980:	9f31                	addw	a4,a4,a2
 982:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 984:	ff053683          	ld	a3,-16(a0)
 988:	a091                	j	9cc <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 98a:	6398                	ld	a4,0(a5)
 98c:	00e7e463          	bltu	a5,a4,994 <free+0x3a>
 990:	00e6ea63          	bltu	a3,a4,9a4 <free+0x4a>
{
 994:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 996:	fed7fae3          	bgeu	a5,a3,98a <free+0x30>
 99a:	6398                	ld	a4,0(a5)
 99c:	00e6e463          	bltu	a3,a4,9a4 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9a0:	fee7eae3          	bltu	a5,a4,994 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 9a4:	ff852583          	lw	a1,-8(a0)
 9a8:	6390                	ld	a2,0(a5)
 9aa:	02059813          	sll	a6,a1,0x20
 9ae:	01c85713          	srl	a4,a6,0x1c
 9b2:	9736                	add	a4,a4,a3
 9b4:	fae60de3          	beq	a2,a4,96e <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 9b8:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9bc:	4790                	lw	a2,8(a5)
 9be:	02061593          	sll	a1,a2,0x20
 9c2:	01c5d713          	srl	a4,a1,0x1c
 9c6:	973e                	add	a4,a4,a5
 9c8:	fae68ae3          	beq	a3,a4,97c <free+0x22>
    p->s.ptr = bp->s.ptr;
 9cc:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9ce:	00000717          	auipc	a4,0x0
 9d2:	62f73923          	sd	a5,1586(a4) # 1000 <freep>
}
 9d6:	6422                	ld	s0,8(sp)
 9d8:	0141                	add	sp,sp,16
 9da:	8082                	ret

00000000000009dc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9dc:	7139                	add	sp,sp,-64
 9de:	fc06                	sd	ra,56(sp)
 9e0:	f822                	sd	s0,48(sp)
 9e2:	f426                	sd	s1,40(sp)
 9e4:	f04a                	sd	s2,32(sp)
 9e6:	ec4e                	sd	s3,24(sp)
 9e8:	e852                	sd	s4,16(sp)
 9ea:	e456                	sd	s5,8(sp)
 9ec:	e05a                	sd	s6,0(sp)
 9ee:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9f0:	02051493          	sll	s1,a0,0x20
 9f4:	9081                	srl	s1,s1,0x20
 9f6:	04bd                	add	s1,s1,15
 9f8:	8091                	srl	s1,s1,0x4
 9fa:	0014899b          	addw	s3,s1,1
 9fe:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 a00:	00000517          	auipc	a0,0x0
 a04:	60053503          	ld	a0,1536(a0) # 1000 <freep>
 a08:	c515                	beqz	a0,a34 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a0a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a0c:	4798                	lw	a4,8(a5)
 a0e:	02977f63          	bgeu	a4,s1,a4c <malloc+0x70>
  if(nu < 4096)
 a12:	8a4e                	mv	s4,s3
 a14:	0009871b          	sext.w	a4,s3
 a18:	6685                	lui	a3,0x1
 a1a:	00d77363          	bgeu	a4,a3,a20 <malloc+0x44>
 a1e:	6a05                	lui	s4,0x1
 a20:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a24:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a28:	00000917          	auipc	s2,0x0
 a2c:	5d890913          	add	s2,s2,1496 # 1000 <freep>
  if(p == (char*)-1)
 a30:	5afd                	li	s5,-1
 a32:	a895                	j	aa6 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 a34:	00001797          	auipc	a5,0x1
 a38:	9dc78793          	add	a5,a5,-1572 # 1410 <base>
 a3c:	00000717          	auipc	a4,0x0
 a40:	5cf73223          	sd	a5,1476(a4) # 1000 <freep>
 a44:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a46:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a4a:	b7e1                	j	a12 <malloc+0x36>
      if(p->s.size == nunits)
 a4c:	02e48c63          	beq	s1,a4,a84 <malloc+0xa8>
        p->s.size -= nunits;
 a50:	4137073b          	subw	a4,a4,s3
 a54:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a56:	02071693          	sll	a3,a4,0x20
 a5a:	01c6d713          	srl	a4,a3,0x1c
 a5e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a60:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a64:	00000717          	auipc	a4,0x0
 a68:	58a73e23          	sd	a0,1436(a4) # 1000 <freep>
      return (void*)(p + 1);
 a6c:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a70:	70e2                	ld	ra,56(sp)
 a72:	7442                	ld	s0,48(sp)
 a74:	74a2                	ld	s1,40(sp)
 a76:	7902                	ld	s2,32(sp)
 a78:	69e2                	ld	s3,24(sp)
 a7a:	6a42                	ld	s4,16(sp)
 a7c:	6aa2                	ld	s5,8(sp)
 a7e:	6b02                	ld	s6,0(sp)
 a80:	6121                	add	sp,sp,64
 a82:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a84:	6398                	ld	a4,0(a5)
 a86:	e118                	sd	a4,0(a0)
 a88:	bff1                	j	a64 <malloc+0x88>
  hp->s.size = nu;
 a8a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a8e:	0541                	add	a0,a0,16
 a90:	00000097          	auipc	ra,0x0
 a94:	eca080e7          	jalr	-310(ra) # 95a <free>
  return freep;
 a98:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a9c:	d971                	beqz	a0,a70 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a9e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 aa0:	4798                	lw	a4,8(a5)
 aa2:	fa9775e3          	bgeu	a4,s1,a4c <malloc+0x70>
    if(p == freep)
 aa6:	00093703          	ld	a4,0(s2)
 aaa:	853e                	mv	a0,a5
 aac:	fef719e3          	bne	a4,a5,a9e <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 ab0:	8552                	mv	a0,s4
 ab2:	00000097          	auipc	ra,0x0
 ab6:	b42080e7          	jalr	-1214(ra) # 5f4 <sbrk>
  if(p == (char*)-1)
 aba:	fd5518e3          	bne	a0,s5,a8a <malloc+0xae>
        return 0;
 abe:	4501                	li	a0,0
 ac0:	bf45                	j	a70 <malloc+0x94>

0000000000000ac2 <init_lock>:
#include "linkedlist.h"

// Define a node structure for the linked list
struct spinlock_u list_lock;

void init_lock(){
 ac2:	1141                	add	sp,sp,-16
 ac4:	e406                	sd	ra,8(sp)
 ac6:	e022                	sd	s0,0(sp)
 ac8:	0800                	add	s0,sp,16
    initlock(&list_lock);
 aca:	00000517          	auipc	a0,0x0
 ace:	53e50513          	add	a0,a0,1342 # 1008 <list_lock>
 ad2:	00000097          	auipc	ra,0x0
 ad6:	a56080e7          	jalr	-1450(ra) # 528 <initlock>
}
 ada:	60a2                	ld	ra,8(sp)
 adc:	6402                	ld	s0,0(sp)
 ade:	0141                	add	sp,sp,16
 ae0:	8082                	ret

0000000000000ae2 <insert>:

// Function to insert a node at the beginning of the linked list
void insert(struct Node **head_ref, int new_data) {
 ae2:	1101                	add	sp,sp,-32
 ae4:	ec06                	sd	ra,24(sp)
 ae6:	e822                	sd	s0,16(sp)
 ae8:	e426                	sd	s1,8(sp)
 aea:	e04a                	sd	s2,0(sp)
 aec:	1000                	add	s0,sp,32
 aee:	84aa                	mv	s1,a0
 af0:	892e                	mv	s2,a1
    struct Node *new_node = malloc(sizeof(struct Node));
 af2:	4541                	li	a0,16
 af4:	00000097          	auipc	ra,0x0
 af8:	ee8080e7          	jalr	-280(ra) # 9dc <malloc>
    new_node->data = new_data;
 afc:	01252023          	sw	s2,0(a0)
    new_node->next = *head_ref;
 b00:	609c                	ld	a5,0(s1)
 b02:	e51c                	sd	a5,8(a0)
    *head_ref = new_node;
 b04:	e088                	sd	a0,0(s1)
}
 b06:	60e2                	ld	ra,24(sp)
 b08:	6442                	ld	s0,16(sp)
 b0a:	64a2                	ld	s1,8(sp)
 b0c:	6902                	ld	s2,0(sp)
 b0e:	6105                	add	sp,sp,32
 b10:	8082                	ret

0000000000000b12 <deleteNode>:

// Function to delete a node with a given key from the linked list
void deleteNode(struct Node **head_ref, int key) {
 b12:	7179                	add	sp,sp,-48
 b14:	f406                	sd	ra,40(sp)
 b16:	f022                	sd	s0,32(sp)
 b18:	ec26                	sd	s1,24(sp)
 b1a:	e84a                	sd	s2,16(sp)
 b1c:	e44e                	sd	s3,8(sp)
 b1e:	1800                	add	s0,sp,48
 b20:	89aa                	mv	s3,a0
 b22:	892e                	mv	s2,a1
    struct Node *temp = *head_ref, *prev = 0;
 b24:	6104                	ld	s1,0(a0)

    acquire(&list_lock);
 b26:	00000517          	auipc	a0,0x0
 b2a:	4e250513          	add	a0,a0,1250 # 1008 <list_lock>
 b2e:	00000097          	auipc	ra,0x0
 b32:	a0a080e7          	jalr	-1526(ra) # 538 <acquire>
    if (temp != 0 && temp->data == key) {
 b36:	c0b1                	beqz	s1,b7a <deleteNode+0x68>
 b38:	409c                	lw	a5,0(s1)
 b3a:	4701                	li	a4,0
 b3c:	01278a63          	beq	a5,s2,b50 <deleteNode+0x3e>
        rcusync();
        free(temp);
        return;
    }

    while (temp != 0 && temp->data != key) {
 b40:	409c                	lw	a5,0(s1)
 b42:	05278563          	beq	a5,s2,b8c <deleteNode+0x7a>
        prev = temp;
        temp = temp->next;
 b46:	649c                	ld	a5,8(s1)
    while (temp != 0 && temp->data != key) {
 b48:	8726                	mv	a4,s1
 b4a:	cb85                	beqz	a5,b7a <deleteNode+0x68>
        temp = temp->next;
 b4c:	84be                	mv	s1,a5
 b4e:	bfcd                	j	b40 <deleteNode+0x2e>
        *head_ref = temp->next;
 b50:	649c                	ld	a5,8(s1)
 b52:	00f9b023          	sd	a5,0(s3)
        release(&list_lock);
 b56:	00000517          	auipc	a0,0x0
 b5a:	4b250513          	add	a0,a0,1202 # 1008 <list_lock>
 b5e:	00000097          	auipc	ra,0x0
 b62:	9f2080e7          	jalr	-1550(ra) # 550 <release>
        rcusync();
 b66:	00000097          	auipc	ra,0x0
 b6a:	ab6080e7          	jalr	-1354(ra) # 61c <rcusync>
        free(temp);
 b6e:	8526                	mv	a0,s1
 b70:	00000097          	auipc	ra,0x0
 b74:	dea080e7          	jalr	-534(ra) # 95a <free>
        return;
 b78:	a82d                	j	bb2 <deleteNode+0xa0>
    }

    if (temp == 0) {
        release(&list_lock);
 b7a:	00000517          	auipc	a0,0x0
 b7e:	48e50513          	add	a0,a0,1166 # 1008 <list_lock>
 b82:	00000097          	auipc	ra,0x0
 b86:	9ce080e7          	jalr	-1586(ra) # 550 <release>
        return;
 b8a:	a025                	j	bb2 <deleteNode+0xa0>
    }
    prev->next = temp->next;
 b8c:	649c                	ld	a5,8(s1)
 b8e:	e71c                	sd	a5,8(a4)
    release(&list_lock);
 b90:	00000517          	auipc	a0,0x0
 b94:	47850513          	add	a0,a0,1144 # 1008 <list_lock>
 b98:	00000097          	auipc	ra,0x0
 b9c:	9b8080e7          	jalr	-1608(ra) # 550 <release>
    rcusync();
 ba0:	00000097          	auipc	ra,0x0
 ba4:	a7c080e7          	jalr	-1412(ra) # 61c <rcusync>
    free(temp);
 ba8:	8526                	mv	a0,s1
 baa:	00000097          	auipc	ra,0x0
 bae:	db0080e7          	jalr	-592(ra) # 95a <free>
}
 bb2:	70a2                	ld	ra,40(sp)
 bb4:	7402                	ld	s0,32(sp)
 bb6:	64e2                	ld	s1,24(sp)
 bb8:	6942                	ld	s2,16(sp)
 bba:	69a2                	ld	s3,8(sp)
 bbc:	6145                	add	sp,sp,48
 bbe:	8082                	ret

0000000000000bc0 <search>:

// Function to search for a node with a given key in the linked list
struct Node* search(struct Node *head, int key) {
 bc0:	1101                	add	sp,sp,-32
 bc2:	ec06                	sd	ra,24(sp)
 bc4:	e822                	sd	s0,16(sp)
 bc6:	e426                	sd	s1,8(sp)
 bc8:	e04a                	sd	s2,0(sp)
 bca:	1000                	add	s0,sp,32
 bcc:	84aa                	mv	s1,a0
 bce:	892e                	mv	s2,a1

    struct Node *current = head;
    rcureadlock();
 bd0:	00000097          	auipc	ra,0x0
 bd4:	a3c080e7          	jalr	-1476(ra) # 60c <rcureadlock>
    while (current != 0) {
 bd8:	c491                	beqz	s1,be4 <search+0x24>
        if (current->data == key) {
 bda:	409c                	lw	a5,0(s1)
 bdc:	01278f63          	beq	a5,s2,bfa <search+0x3a>
            rcureadunlock();
            return current; // Node found
        }
        current = current->next;
 be0:	6484                	ld	s1,8(s1)
    while (current != 0) {
 be2:	fce5                	bnez	s1,bda <search+0x1a>
    }
    rcureadunlock();
 be4:	00000097          	auipc	ra,0x0
 be8:	a30080e7          	jalr	-1488(ra) # 614 <rcureadunlock>
    return 0; // Node not found
 bec:	4501                	li	a0,0
}
 bee:	60e2                	ld	ra,24(sp)
 bf0:	6442                	ld	s0,16(sp)
 bf2:	64a2                	ld	s1,8(sp)
 bf4:	6902                	ld	s2,0(sp)
 bf6:	6105                	add	sp,sp,32
 bf8:	8082                	ret
            rcureadunlock();
 bfa:	00000097          	auipc	ra,0x0
 bfe:	a1a080e7          	jalr	-1510(ra) # 614 <rcureadunlock>
            return current; // Node found
 c02:	8526                	mv	a0,s1
 c04:	b7ed                	j	bee <search+0x2e>

0000000000000c06 <updateNode>:

// Function to update the value of a node with a given key in the linked list
void updateNode(struct Node *head, int key, int new_data) {
 c06:	1101                	add	sp,sp,-32
 c08:	ec06                	sd	ra,24(sp)
 c0a:	e822                	sd	s0,16(sp)
 c0c:	e426                	sd	s1,8(sp)
 c0e:	e04a                	sd	s2,0(sp)
 c10:	1000                	add	s0,sp,32
 c12:	892e                	mv	s2,a1
 c14:	84b2                	mv	s1,a2
    struct Node *nodeToUpdate = search(head, key);
 c16:	00000097          	auipc	ra,0x0
 c1a:	faa080e7          	jalr	-86(ra) # bc0 <search>

    if (nodeToUpdate != 0) {
 c1e:	c901                	beqz	a0,c2e <updateNode+0x28>
        nodeToUpdate->data = new_data; // Update the node's data
 c20:	c104                	sw	s1,0(a0)
    } else {
        printf("Node with key %d not found.\n", key);
    }
}
 c22:	60e2                	ld	ra,24(sp)
 c24:	6442                	ld	s0,16(sp)
 c26:	64a2                	ld	s1,8(sp)
 c28:	6902                	ld	s2,0(sp)
 c2a:	6105                	add	sp,sp,32
 c2c:	8082                	ret
        printf("Node with key %d not found.\n", key);
 c2e:	85ca                	mv	a1,s2
 c30:	00000517          	auipc	a0,0x0
 c34:	0d050513          	add	a0,a0,208 # d00 <digits+0x18>
 c38:	00000097          	auipc	ra,0x0
 c3c:	cec080e7          	jalr	-788(ra) # 924 <printf>
}
 c40:	b7cd                	j	c22 <updateNode+0x1c>
