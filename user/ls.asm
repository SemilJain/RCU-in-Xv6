
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
   0:	7179                	add	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	add	s0,sp,48
   e:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  10:	00000097          	auipc	ra,0x0
  14:	324080e7          	jalr	804(ra) # 334 <strlen>
  18:	02051793          	sll	a5,a0,0x20
  1c:	9381                	srl	a5,a5,0x20
  1e:	97a6                	add	a5,a5,s1
  20:	02f00693          	li	a3,47
  24:	0097e963          	bltu	a5,s1,36 <fmtname+0x36>
  28:	0007c703          	lbu	a4,0(a5)
  2c:	00d70563          	beq	a4,a3,36 <fmtname+0x36>
  30:	17fd                	add	a5,a5,-1
  32:	fe97fbe3          	bgeu	a5,s1,28 <fmtname+0x28>
    ;
  p++;
  36:	00178493          	add	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  3a:	8526                	mv	a0,s1
  3c:	00000097          	auipc	ra,0x0
  40:	2f8080e7          	jalr	760(ra) # 334 <strlen>
  44:	2501                	sext.w	a0,a0
  46:	47b5                	li	a5,13
  48:	00a7fa63          	bgeu	a5,a0,5c <fmtname+0x5c>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  4c:	8526                	mv	a0,s1
  4e:	70a2                	ld	ra,40(sp)
  50:	7402                	ld	s0,32(sp)
  52:	64e2                	ld	s1,24(sp)
  54:	6942                	ld	s2,16(sp)
  56:	69a2                	ld	s3,8(sp)
  58:	6145                	add	sp,sp,48
  5a:	8082                	ret
  memmove(buf, p, strlen(p));
  5c:	8526                	mv	a0,s1
  5e:	00000097          	auipc	ra,0x0
  62:	2d6080e7          	jalr	726(ra) # 334 <strlen>
  66:	00001997          	auipc	s3,0x1
  6a:	faa98993          	add	s3,s3,-86 # 1010 <buf.0>
  6e:	0005061b          	sext.w	a2,a0
  72:	85a6                	mv	a1,s1
  74:	854e                	mv	a0,s3
  76:	00000097          	auipc	ra,0x0
  7a:	430080e7          	jalr	1072(ra) # 4a6 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  7e:	8526                	mv	a0,s1
  80:	00000097          	auipc	ra,0x0
  84:	2b4080e7          	jalr	692(ra) # 334 <strlen>
  88:	0005091b          	sext.w	s2,a0
  8c:	8526                	mv	a0,s1
  8e:	00000097          	auipc	ra,0x0
  92:	2a6080e7          	jalr	678(ra) # 334 <strlen>
  96:	1902                	sll	s2,s2,0x20
  98:	02095913          	srl	s2,s2,0x20
  9c:	4639                	li	a2,14
  9e:	9e09                	subw	a2,a2,a0
  a0:	02000593          	li	a1,32
  a4:	01298533          	add	a0,s3,s2
  a8:	00000097          	auipc	ra,0x0
  ac:	2b6080e7          	jalr	694(ra) # 35e <memset>
  return buf;
  b0:	84ce                	mv	s1,s3
  b2:	bf69                	j	4c <fmtname+0x4c>

00000000000000b4 <ls>:

void
ls(char *path)
{
  b4:	d9010113          	add	sp,sp,-624
  b8:	26113423          	sd	ra,616(sp)
  bc:	26813023          	sd	s0,608(sp)
  c0:	24913c23          	sd	s1,600(sp)
  c4:	25213823          	sd	s2,592(sp)
  c8:	25313423          	sd	s3,584(sp)
  cc:	25413023          	sd	s4,576(sp)
  d0:	23513c23          	sd	s5,568(sp)
  d4:	1c80                	add	s0,sp,624
  d6:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  d8:	4581                	li	a1,0
  da:	00000097          	auipc	ra,0x0
  de:	4fa080e7          	jalr	1274(ra) # 5d4 <open>
  e2:	06054f63          	bltz	a0,160 <ls+0xac>
  e6:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  e8:	d9840593          	add	a1,s0,-616
  ec:	00000097          	auipc	ra,0x0
  f0:	500080e7          	jalr	1280(ra) # 5ec <fstat>
  f4:	08054163          	bltz	a0,176 <ls+0xc2>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  f8:	da041783          	lh	a5,-608(s0)
  fc:	4705                	li	a4,1
  fe:	08e78c63          	beq	a5,a4,196 <ls+0xe2>
 102:	37f9                	addw	a5,a5,-2
 104:	17c2                	sll	a5,a5,0x30
 106:	93c1                	srl	a5,a5,0x30
 108:	02f76663          	bltu	a4,a5,134 <ls+0x80>
  case T_DEVICE:
  case T_FILE:
    printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
 10c:	854a                	mv	a0,s2
 10e:	00000097          	auipc	ra,0x0
 112:	ef2080e7          	jalr	-270(ra) # 0 <fmtname>
 116:	85aa                	mv	a1,a0
 118:	da843703          	ld	a4,-600(s0)
 11c:	d9c42683          	lw	a3,-612(s0)
 120:	da041603          	lh	a2,-608(s0)
 124:	00001517          	auipc	a0,0x1
 128:	b7c50513          	add	a0,a0,-1156 # ca0 <updateNode+0x72>
 12c:	00001097          	auipc	ra,0x1
 130:	820080e7          	jalr	-2016(ra) # 94c <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 134:	8526                	mv	a0,s1
 136:	00000097          	auipc	ra,0x0
 13a:	486080e7          	jalr	1158(ra) # 5bc <close>
}
 13e:	26813083          	ld	ra,616(sp)
 142:	26013403          	ld	s0,608(sp)
 146:	25813483          	ld	s1,600(sp)
 14a:	25013903          	ld	s2,592(sp)
 14e:	24813983          	ld	s3,584(sp)
 152:	24013a03          	ld	s4,576(sp)
 156:	23813a83          	ld	s5,568(sp)
 15a:	27010113          	add	sp,sp,624
 15e:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
 160:	864a                	mv	a2,s2
 162:	00001597          	auipc	a1,0x1
 166:	b0e58593          	add	a1,a1,-1266 # c70 <updateNode+0x42>
 16a:	4509                	li	a0,2
 16c:	00000097          	auipc	ra,0x0
 170:	7b2080e7          	jalr	1970(ra) # 91e <fprintf>
    return;
 174:	b7e9                	j	13e <ls+0x8a>
    fprintf(2, "ls: cannot stat %s\n", path);
 176:	864a                	mv	a2,s2
 178:	00001597          	auipc	a1,0x1
 17c:	b1058593          	add	a1,a1,-1264 # c88 <updateNode+0x5a>
 180:	4509                	li	a0,2
 182:	00000097          	auipc	ra,0x0
 186:	79c080e7          	jalr	1948(ra) # 91e <fprintf>
    close(fd);
 18a:	8526                	mv	a0,s1
 18c:	00000097          	auipc	ra,0x0
 190:	430080e7          	jalr	1072(ra) # 5bc <close>
    return;
 194:	b76d                	j	13e <ls+0x8a>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 196:	854a                	mv	a0,s2
 198:	00000097          	auipc	ra,0x0
 19c:	19c080e7          	jalr	412(ra) # 334 <strlen>
 1a0:	2541                	addw	a0,a0,16
 1a2:	20000793          	li	a5,512
 1a6:	00a7fb63          	bgeu	a5,a0,1bc <ls+0x108>
      printf("ls: path too long\n");
 1aa:	00001517          	auipc	a0,0x1
 1ae:	b0650513          	add	a0,a0,-1274 # cb0 <updateNode+0x82>
 1b2:	00000097          	auipc	ra,0x0
 1b6:	79a080e7          	jalr	1946(ra) # 94c <printf>
      break;
 1ba:	bfad                	j	134 <ls+0x80>
    strcpy(buf, path);
 1bc:	85ca                	mv	a1,s2
 1be:	dc040513          	add	a0,s0,-576
 1c2:	00000097          	auipc	ra,0x0
 1c6:	12a080e7          	jalr	298(ra) # 2ec <strcpy>
    p = buf+strlen(buf);
 1ca:	dc040513          	add	a0,s0,-576
 1ce:	00000097          	auipc	ra,0x0
 1d2:	166080e7          	jalr	358(ra) # 334 <strlen>
 1d6:	1502                	sll	a0,a0,0x20
 1d8:	9101                	srl	a0,a0,0x20
 1da:	dc040793          	add	a5,s0,-576
 1de:	00a78933          	add	s2,a5,a0
    *p++ = '/';
 1e2:	00190993          	add	s3,s2,1
 1e6:	02f00793          	li	a5,47
 1ea:	00f90023          	sb	a5,0(s2)
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 1ee:	00001a17          	auipc	s4,0x1
 1f2:	adaa0a13          	add	s4,s4,-1318 # cc8 <updateNode+0x9a>
        printf("ls: cannot stat %s\n", buf);
 1f6:	00001a97          	auipc	s5,0x1
 1fa:	a92a8a93          	add	s5,s5,-1390 # c88 <updateNode+0x5a>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1fe:	a801                	j	20e <ls+0x15a>
        printf("ls: cannot stat %s\n", buf);
 200:	dc040593          	add	a1,s0,-576
 204:	8556                	mv	a0,s5
 206:	00000097          	auipc	ra,0x0
 20a:	746080e7          	jalr	1862(ra) # 94c <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 20e:	4641                	li	a2,16
 210:	db040593          	add	a1,s0,-592
 214:	8526                	mv	a0,s1
 216:	00000097          	auipc	ra,0x0
 21a:	396080e7          	jalr	918(ra) # 5ac <read>
 21e:	47c1                	li	a5,16
 220:	f0f51ae3          	bne	a0,a5,134 <ls+0x80>
      if(de.inum == 0)
 224:	db045783          	lhu	a5,-592(s0)
 228:	d3fd                	beqz	a5,20e <ls+0x15a>
      memmove(p, de.name, DIRSIZ);
 22a:	4639                	li	a2,14
 22c:	db240593          	add	a1,s0,-590
 230:	854e                	mv	a0,s3
 232:	00000097          	auipc	ra,0x0
 236:	274080e7          	jalr	628(ra) # 4a6 <memmove>
      p[DIRSIZ] = 0;
 23a:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 23e:	d9840593          	add	a1,s0,-616
 242:	dc040513          	add	a0,s0,-576
 246:	00000097          	auipc	ra,0x0
 24a:	1d2080e7          	jalr	466(ra) # 418 <stat>
 24e:	fa0549e3          	bltz	a0,200 <ls+0x14c>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 252:	dc040513          	add	a0,s0,-576
 256:	00000097          	auipc	ra,0x0
 25a:	daa080e7          	jalr	-598(ra) # 0 <fmtname>
 25e:	85aa                	mv	a1,a0
 260:	da843703          	ld	a4,-600(s0)
 264:	d9c42683          	lw	a3,-612(s0)
 268:	da041603          	lh	a2,-608(s0)
 26c:	8552                	mv	a0,s4
 26e:	00000097          	auipc	ra,0x0
 272:	6de080e7          	jalr	1758(ra) # 94c <printf>
 276:	bf61                	j	20e <ls+0x15a>

0000000000000278 <main>:

int
main(int argc, char *argv[])
{
 278:	1101                	add	sp,sp,-32
 27a:	ec06                	sd	ra,24(sp)
 27c:	e822                	sd	s0,16(sp)
 27e:	e426                	sd	s1,8(sp)
 280:	e04a                	sd	s2,0(sp)
 282:	1000                	add	s0,sp,32
  int i;

  if(argc < 2){
 284:	4785                	li	a5,1
 286:	02a7d963          	bge	a5,a0,2b8 <main+0x40>
 28a:	00858493          	add	s1,a1,8
 28e:	ffe5091b          	addw	s2,a0,-2
 292:	02091793          	sll	a5,s2,0x20
 296:	01d7d913          	srl	s2,a5,0x1d
 29a:	05c1                	add	a1,a1,16
 29c:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 29e:	6088                	ld	a0,0(s1)
 2a0:	00000097          	auipc	ra,0x0
 2a4:	e14080e7          	jalr	-492(ra) # b4 <ls>
  for(i=1; i<argc; i++)
 2a8:	04a1                	add	s1,s1,8
 2aa:	ff249ae3          	bne	s1,s2,29e <main+0x26>
  exit(0);
 2ae:	4501                	li	a0,0
 2b0:	00000097          	auipc	ra,0x0
 2b4:	2e4080e7          	jalr	740(ra) # 594 <exit>
    ls(".");
 2b8:	00001517          	auipc	a0,0x1
 2bc:	a2050513          	add	a0,a0,-1504 # cd8 <updateNode+0xaa>
 2c0:	00000097          	auipc	ra,0x0
 2c4:	df4080e7          	jalr	-524(ra) # b4 <ls>
    exit(0);
 2c8:	4501                	li	a0,0
 2ca:	00000097          	auipc	ra,0x0
 2ce:	2ca080e7          	jalr	714(ra) # 594 <exit>

00000000000002d2 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 2d2:	1141                	add	sp,sp,-16
 2d4:	e406                	sd	ra,8(sp)
 2d6:	e022                	sd	s0,0(sp)
 2d8:	0800                	add	s0,sp,16
  extern int main();
  main();
 2da:	00000097          	auipc	ra,0x0
 2de:	f9e080e7          	jalr	-98(ra) # 278 <main>
  exit(0);
 2e2:	4501                	li	a0,0
 2e4:	00000097          	auipc	ra,0x0
 2e8:	2b0080e7          	jalr	688(ra) # 594 <exit>

00000000000002ec <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 2ec:	1141                	add	sp,sp,-16
 2ee:	e422                	sd	s0,8(sp)
 2f0:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2f2:	87aa                	mv	a5,a0
 2f4:	0585                	add	a1,a1,1
 2f6:	0785                	add	a5,a5,1
 2f8:	fff5c703          	lbu	a4,-1(a1)
 2fc:	fee78fa3          	sb	a4,-1(a5)
 300:	fb75                	bnez	a4,2f4 <strcpy+0x8>
    ;
  return os;
}
 302:	6422                	ld	s0,8(sp)
 304:	0141                	add	sp,sp,16
 306:	8082                	ret

0000000000000308 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 308:	1141                	add	sp,sp,-16
 30a:	e422                	sd	s0,8(sp)
 30c:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 30e:	00054783          	lbu	a5,0(a0)
 312:	cb91                	beqz	a5,326 <strcmp+0x1e>
 314:	0005c703          	lbu	a4,0(a1)
 318:	00f71763          	bne	a4,a5,326 <strcmp+0x1e>
    p++, q++;
 31c:	0505                	add	a0,a0,1
 31e:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 320:	00054783          	lbu	a5,0(a0)
 324:	fbe5                	bnez	a5,314 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 326:	0005c503          	lbu	a0,0(a1)
}
 32a:	40a7853b          	subw	a0,a5,a0
 32e:	6422                	ld	s0,8(sp)
 330:	0141                	add	sp,sp,16
 332:	8082                	ret

0000000000000334 <strlen>:

uint
strlen(const char *s)
{
 334:	1141                	add	sp,sp,-16
 336:	e422                	sd	s0,8(sp)
 338:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 33a:	00054783          	lbu	a5,0(a0)
 33e:	cf91                	beqz	a5,35a <strlen+0x26>
 340:	0505                	add	a0,a0,1
 342:	87aa                	mv	a5,a0
 344:	86be                	mv	a3,a5
 346:	0785                	add	a5,a5,1
 348:	fff7c703          	lbu	a4,-1(a5)
 34c:	ff65                	bnez	a4,344 <strlen+0x10>
 34e:	40a6853b          	subw	a0,a3,a0
 352:	2505                	addw	a0,a0,1
    ;
  return n;
}
 354:	6422                	ld	s0,8(sp)
 356:	0141                	add	sp,sp,16
 358:	8082                	ret
  for(n = 0; s[n]; n++)
 35a:	4501                	li	a0,0
 35c:	bfe5                	j	354 <strlen+0x20>

000000000000035e <memset>:

void*
memset(void *dst, int c, uint n)
{
 35e:	1141                	add	sp,sp,-16
 360:	e422                	sd	s0,8(sp)
 362:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 364:	ca19                	beqz	a2,37a <memset+0x1c>
 366:	87aa                	mv	a5,a0
 368:	1602                	sll	a2,a2,0x20
 36a:	9201                	srl	a2,a2,0x20
 36c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 370:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 374:	0785                	add	a5,a5,1
 376:	fee79de3          	bne	a5,a4,370 <memset+0x12>
  }
  return dst;
}
 37a:	6422                	ld	s0,8(sp)
 37c:	0141                	add	sp,sp,16
 37e:	8082                	ret

0000000000000380 <strchr>:

char*
strchr(const char *s, char c)
{
 380:	1141                	add	sp,sp,-16
 382:	e422                	sd	s0,8(sp)
 384:	0800                	add	s0,sp,16
  for(; *s; s++)
 386:	00054783          	lbu	a5,0(a0)
 38a:	cb99                	beqz	a5,3a0 <strchr+0x20>
    if(*s == c)
 38c:	00f58763          	beq	a1,a5,39a <strchr+0x1a>
  for(; *s; s++)
 390:	0505                	add	a0,a0,1
 392:	00054783          	lbu	a5,0(a0)
 396:	fbfd                	bnez	a5,38c <strchr+0xc>
      return (char*)s;
  return 0;
 398:	4501                	li	a0,0
}
 39a:	6422                	ld	s0,8(sp)
 39c:	0141                	add	sp,sp,16
 39e:	8082                	ret
  return 0;
 3a0:	4501                	li	a0,0
 3a2:	bfe5                	j	39a <strchr+0x1a>

00000000000003a4 <gets>:

char*
gets(char *buf, int max)
{
 3a4:	711d                	add	sp,sp,-96
 3a6:	ec86                	sd	ra,88(sp)
 3a8:	e8a2                	sd	s0,80(sp)
 3aa:	e4a6                	sd	s1,72(sp)
 3ac:	e0ca                	sd	s2,64(sp)
 3ae:	fc4e                	sd	s3,56(sp)
 3b0:	f852                	sd	s4,48(sp)
 3b2:	f456                	sd	s5,40(sp)
 3b4:	f05a                	sd	s6,32(sp)
 3b6:	ec5e                	sd	s7,24(sp)
 3b8:	1080                	add	s0,sp,96
 3ba:	8baa                	mv	s7,a0
 3bc:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3be:	892a                	mv	s2,a0
 3c0:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3c2:	4aa9                	li	s5,10
 3c4:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3c6:	89a6                	mv	s3,s1
 3c8:	2485                	addw	s1,s1,1
 3ca:	0344d863          	bge	s1,s4,3fa <gets+0x56>
    cc = read(0, &c, 1);
 3ce:	4605                	li	a2,1
 3d0:	faf40593          	add	a1,s0,-81
 3d4:	4501                	li	a0,0
 3d6:	00000097          	auipc	ra,0x0
 3da:	1d6080e7          	jalr	470(ra) # 5ac <read>
    if(cc < 1)
 3de:	00a05e63          	blez	a0,3fa <gets+0x56>
    buf[i++] = c;
 3e2:	faf44783          	lbu	a5,-81(s0)
 3e6:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3ea:	01578763          	beq	a5,s5,3f8 <gets+0x54>
 3ee:	0905                	add	s2,s2,1
 3f0:	fd679be3          	bne	a5,s6,3c6 <gets+0x22>
  for(i=0; i+1 < max; ){
 3f4:	89a6                	mv	s3,s1
 3f6:	a011                	j	3fa <gets+0x56>
 3f8:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3fa:	99de                	add	s3,s3,s7
 3fc:	00098023          	sb	zero,0(s3)
  return buf;
}
 400:	855e                	mv	a0,s7
 402:	60e6                	ld	ra,88(sp)
 404:	6446                	ld	s0,80(sp)
 406:	64a6                	ld	s1,72(sp)
 408:	6906                	ld	s2,64(sp)
 40a:	79e2                	ld	s3,56(sp)
 40c:	7a42                	ld	s4,48(sp)
 40e:	7aa2                	ld	s5,40(sp)
 410:	7b02                	ld	s6,32(sp)
 412:	6be2                	ld	s7,24(sp)
 414:	6125                	add	sp,sp,96
 416:	8082                	ret

0000000000000418 <stat>:

int
stat(const char *n, struct stat *st)
{
 418:	1101                	add	sp,sp,-32
 41a:	ec06                	sd	ra,24(sp)
 41c:	e822                	sd	s0,16(sp)
 41e:	e426                	sd	s1,8(sp)
 420:	e04a                	sd	s2,0(sp)
 422:	1000                	add	s0,sp,32
 424:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 426:	4581                	li	a1,0
 428:	00000097          	auipc	ra,0x0
 42c:	1ac080e7          	jalr	428(ra) # 5d4 <open>
  if(fd < 0)
 430:	02054563          	bltz	a0,45a <stat+0x42>
 434:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 436:	85ca                	mv	a1,s2
 438:	00000097          	auipc	ra,0x0
 43c:	1b4080e7          	jalr	436(ra) # 5ec <fstat>
 440:	892a                	mv	s2,a0
  close(fd);
 442:	8526                	mv	a0,s1
 444:	00000097          	auipc	ra,0x0
 448:	178080e7          	jalr	376(ra) # 5bc <close>
  return r;
}
 44c:	854a                	mv	a0,s2
 44e:	60e2                	ld	ra,24(sp)
 450:	6442                	ld	s0,16(sp)
 452:	64a2                	ld	s1,8(sp)
 454:	6902                	ld	s2,0(sp)
 456:	6105                	add	sp,sp,32
 458:	8082                	ret
    return -1;
 45a:	597d                	li	s2,-1
 45c:	bfc5                	j	44c <stat+0x34>

000000000000045e <atoi>:

int
atoi(const char *s)
{
 45e:	1141                	add	sp,sp,-16
 460:	e422                	sd	s0,8(sp)
 462:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 464:	00054683          	lbu	a3,0(a0)
 468:	fd06879b          	addw	a5,a3,-48
 46c:	0ff7f793          	zext.b	a5,a5
 470:	4625                	li	a2,9
 472:	02f66863          	bltu	a2,a5,4a2 <atoi+0x44>
 476:	872a                	mv	a4,a0
  n = 0;
 478:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 47a:	0705                	add	a4,a4,1
 47c:	0025179b          	sllw	a5,a0,0x2
 480:	9fa9                	addw	a5,a5,a0
 482:	0017979b          	sllw	a5,a5,0x1
 486:	9fb5                	addw	a5,a5,a3
 488:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 48c:	00074683          	lbu	a3,0(a4)
 490:	fd06879b          	addw	a5,a3,-48
 494:	0ff7f793          	zext.b	a5,a5
 498:	fef671e3          	bgeu	a2,a5,47a <atoi+0x1c>
  return n;
}
 49c:	6422                	ld	s0,8(sp)
 49e:	0141                	add	sp,sp,16
 4a0:	8082                	ret
  n = 0;
 4a2:	4501                	li	a0,0
 4a4:	bfe5                	j	49c <atoi+0x3e>

00000000000004a6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4a6:	1141                	add	sp,sp,-16
 4a8:	e422                	sd	s0,8(sp)
 4aa:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4ac:	02b57463          	bgeu	a0,a1,4d4 <memmove+0x2e>
    while(n-- > 0)
 4b0:	00c05f63          	blez	a2,4ce <memmove+0x28>
 4b4:	1602                	sll	a2,a2,0x20
 4b6:	9201                	srl	a2,a2,0x20
 4b8:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4bc:	872a                	mv	a4,a0
      *dst++ = *src++;
 4be:	0585                	add	a1,a1,1
 4c0:	0705                	add	a4,a4,1
 4c2:	fff5c683          	lbu	a3,-1(a1)
 4c6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4ca:	fee79ae3          	bne	a5,a4,4be <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4ce:	6422                	ld	s0,8(sp)
 4d0:	0141                	add	sp,sp,16
 4d2:	8082                	ret
    dst += n;
 4d4:	00c50733          	add	a4,a0,a2
    src += n;
 4d8:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4da:	fec05ae3          	blez	a2,4ce <memmove+0x28>
 4de:	fff6079b          	addw	a5,a2,-1
 4e2:	1782                	sll	a5,a5,0x20
 4e4:	9381                	srl	a5,a5,0x20
 4e6:	fff7c793          	not	a5,a5
 4ea:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4ec:	15fd                	add	a1,a1,-1
 4ee:	177d                	add	a4,a4,-1
 4f0:	0005c683          	lbu	a3,0(a1)
 4f4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4f8:	fee79ae3          	bne	a5,a4,4ec <memmove+0x46>
 4fc:	bfc9                	j	4ce <memmove+0x28>

00000000000004fe <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4fe:	1141                	add	sp,sp,-16
 500:	e422                	sd	s0,8(sp)
 502:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 504:	ca05                	beqz	a2,534 <memcmp+0x36>
 506:	fff6069b          	addw	a3,a2,-1
 50a:	1682                	sll	a3,a3,0x20
 50c:	9281                	srl	a3,a3,0x20
 50e:	0685                	add	a3,a3,1
 510:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 512:	00054783          	lbu	a5,0(a0)
 516:	0005c703          	lbu	a4,0(a1)
 51a:	00e79863          	bne	a5,a4,52a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 51e:	0505                	add	a0,a0,1
    p2++;
 520:	0585                	add	a1,a1,1
  while (n-- > 0) {
 522:	fed518e3          	bne	a0,a3,512 <memcmp+0x14>
  }
  return 0;
 526:	4501                	li	a0,0
 528:	a019                	j	52e <memcmp+0x30>
      return *p1 - *p2;
 52a:	40e7853b          	subw	a0,a5,a4
}
 52e:	6422                	ld	s0,8(sp)
 530:	0141                	add	sp,sp,16
 532:	8082                	ret
  return 0;
 534:	4501                	li	a0,0
 536:	bfe5                	j	52e <memcmp+0x30>

0000000000000538 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 538:	1141                	add	sp,sp,-16
 53a:	e406                	sd	ra,8(sp)
 53c:	e022                	sd	s0,0(sp)
 53e:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 540:	00000097          	auipc	ra,0x0
 544:	f66080e7          	jalr	-154(ra) # 4a6 <memmove>
}
 548:	60a2                	ld	ra,8(sp)
 54a:	6402                	ld	s0,0(sp)
 54c:	0141                	add	sp,sp,16
 54e:	8082                	ret

0000000000000550 <initlock>:

// Initialize the spinlock
void initlock(struct spinlock_u *lk) {
 550:	1141                	add	sp,sp,-16
 552:	e422                	sd	s0,8(sp)
 554:	0800                	add	s0,sp,16
  lk->locked = 0;
 556:	00052023          	sw	zero,0(a0)
}
 55a:	6422                	ld	s0,8(sp)
 55c:	0141                	add	sp,sp,16
 55e:	8082                	ret

0000000000000560 <acquire>:

// Acquire the spinlock
void acquire(struct spinlock_u *lk) {
 560:	1141                	add	sp,sp,-16
 562:	e422                	sd	s0,8(sp)
 564:	0800                	add	s0,sp,16
  while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 566:	4705                	li	a4,1
 568:	87ba                	mv	a5,a4
 56a:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
 56e:	2781                	sext.w	a5,a5
 570:	ffe5                	bnez	a5,568 <acquire+0x8>
    ; // Spin until the lock is acquired
}
 572:	6422                	ld	s0,8(sp)
 574:	0141                	add	sp,sp,16
 576:	8082                	ret

0000000000000578 <release>:

// Release the spinlock
void release(struct spinlock_u *lk) {
 578:	1141                	add	sp,sp,-16
 57a:	e422                	sd	s0,8(sp)
 57c:	0800                	add	s0,sp,16
  __sync_lock_release(&lk->locked);
 57e:	0f50000f          	fence	iorw,ow
 582:	0805202f          	amoswap.w	zero,zero,(a0)
}
 586:	6422                	ld	s0,8(sp)
 588:	0141                	add	sp,sp,16
 58a:	8082                	ret

000000000000058c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 58c:	4885                	li	a7,1
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <exit>:
.global exit
exit:
 li a7, SYS_exit
 594:	4889                	li	a7,2
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <wait>:
.global wait
wait:
 li a7, SYS_wait
 59c:	488d                	li	a7,3
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5a4:	4891                	li	a7,4
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <read>:
.global read
read:
 li a7, SYS_read
 5ac:	4895                	li	a7,5
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <write>:
.global write
write:
 li a7, SYS_write
 5b4:	48c1                	li	a7,16
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <close>:
.global close
close:
 li a7, SYS_close
 5bc:	48d5                	li	a7,21
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5c4:	4899                	li	a7,6
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <exec>:
.global exec
exec:
 li a7, SYS_exec
 5cc:	489d                	li	a7,7
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <open>:
.global open
open:
 li a7, SYS_open
 5d4:	48bd                	li	a7,15
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5dc:	48c5                	li	a7,17
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5e4:	48c9                	li	a7,18
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5ec:	48a1                	li	a7,8
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <link>:
.global link
link:
 li a7, SYS_link
 5f4:	48cd                	li	a7,19
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5fc:	48d1                	li	a7,20
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 604:	48a5                	li	a7,9
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <dup>:
.global dup
dup:
 li a7, SYS_dup
 60c:	48a9                	li	a7,10
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 614:	48ad                	li	a7,11
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 61c:	48b1                	li	a7,12
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 624:	48b5                	li	a7,13
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 62c:	48b9                	li	a7,14
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <rcureadlock>:
.global rcureadlock
rcureadlock:
 li a7, SYS_rcureadlock
 634:	48dd                	li	a7,23
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <rcureadunlock>:
.global rcureadunlock
rcureadunlock:
 li a7, SYS_rcureadunlock
 63c:	48e1                	li	a7,24
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <rcusync>:
.global rcusync
rcusync:
 li a7, SYS_rcusync
 644:	48d9                	li	a7,22
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <thread_create>:
.global thread_create
thread_create:
 li a7, SYS_thread_create
 64c:	48e5                	li	a7,25
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <thread_join>:
.global thread_join
thread_join:
 li a7, SYS_thread_join
 654:	48e9                	li	a7,26
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <thread_exit>:
.global thread_exit
thread_exit:
 li a7, SYS_thread_exit
 65c:	48ed                	li	a7,27
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <klist_insert>:
.global klist_insert
klist_insert:
 li a7, SYS_klist_insert
 664:	48f1                	li	a7,28
 ecall
 666:	00000073          	ecall
 ret
 66a:	8082                	ret

000000000000066c <klist_delete>:
.global klist_delete
klist_delete:
 li a7, SYS_klist_delete
 66c:	48f5                	li	a7,29
 ecall
 66e:	00000073          	ecall
 ret
 672:	8082                	ret

0000000000000674 <klist_query>:
.global klist_query
klist_query:
 li a7, SYS_klist_query
 674:	48f9                	li	a7,30
 ecall
 676:	00000073          	ecall
 ret
 67a:	8082                	ret

000000000000067c <klist_print>:
.global klist_print
klist_print:
 li a7, SYS_klist_print
 67c:	48fd                	li	a7,31
 ecall
 67e:	00000073          	ecall
 ret
 682:	8082                	ret

0000000000000684 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 684:	1101                	add	sp,sp,-32
 686:	ec06                	sd	ra,24(sp)
 688:	e822                	sd	s0,16(sp)
 68a:	1000                	add	s0,sp,32
 68c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 690:	4605                	li	a2,1
 692:	fef40593          	add	a1,s0,-17
 696:	00000097          	auipc	ra,0x0
 69a:	f1e080e7          	jalr	-226(ra) # 5b4 <write>
}
 69e:	60e2                	ld	ra,24(sp)
 6a0:	6442                	ld	s0,16(sp)
 6a2:	6105                	add	sp,sp,32
 6a4:	8082                	ret

00000000000006a6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6a6:	7139                	add	sp,sp,-64
 6a8:	fc06                	sd	ra,56(sp)
 6aa:	f822                	sd	s0,48(sp)
 6ac:	f426                	sd	s1,40(sp)
 6ae:	f04a                	sd	s2,32(sp)
 6b0:	ec4e                	sd	s3,24(sp)
 6b2:	0080                	add	s0,sp,64
 6b4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6b6:	c299                	beqz	a3,6bc <printint+0x16>
 6b8:	0805c963          	bltz	a1,74a <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6bc:	2581                	sext.w	a1,a1
  neg = 0;
 6be:	4881                	li	a7,0
 6c0:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 6c4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6c6:	2601                	sext.w	a2,a2
 6c8:	00000517          	auipc	a0,0x0
 6cc:	67850513          	add	a0,a0,1656 # d40 <digits>
 6d0:	883a                	mv	a6,a4
 6d2:	2705                	addw	a4,a4,1
 6d4:	02c5f7bb          	remuw	a5,a1,a2
 6d8:	1782                	sll	a5,a5,0x20
 6da:	9381                	srl	a5,a5,0x20
 6dc:	97aa                	add	a5,a5,a0
 6de:	0007c783          	lbu	a5,0(a5)
 6e2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6e6:	0005879b          	sext.w	a5,a1
 6ea:	02c5d5bb          	divuw	a1,a1,a2
 6ee:	0685                	add	a3,a3,1
 6f0:	fec7f0e3          	bgeu	a5,a2,6d0 <printint+0x2a>
  if(neg)
 6f4:	00088c63          	beqz	a7,70c <printint+0x66>
    buf[i++] = '-';
 6f8:	fd070793          	add	a5,a4,-48
 6fc:	00878733          	add	a4,a5,s0
 700:	02d00793          	li	a5,45
 704:	fef70823          	sb	a5,-16(a4)
 708:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 70c:	02e05863          	blez	a4,73c <printint+0x96>
 710:	fc040793          	add	a5,s0,-64
 714:	00e78933          	add	s2,a5,a4
 718:	fff78993          	add	s3,a5,-1
 71c:	99ba                	add	s3,s3,a4
 71e:	377d                	addw	a4,a4,-1
 720:	1702                	sll	a4,a4,0x20
 722:	9301                	srl	a4,a4,0x20
 724:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 728:	fff94583          	lbu	a1,-1(s2)
 72c:	8526                	mv	a0,s1
 72e:	00000097          	auipc	ra,0x0
 732:	f56080e7          	jalr	-170(ra) # 684 <putc>
  while(--i >= 0)
 736:	197d                	add	s2,s2,-1
 738:	ff3918e3          	bne	s2,s3,728 <printint+0x82>
}
 73c:	70e2                	ld	ra,56(sp)
 73e:	7442                	ld	s0,48(sp)
 740:	74a2                	ld	s1,40(sp)
 742:	7902                	ld	s2,32(sp)
 744:	69e2                	ld	s3,24(sp)
 746:	6121                	add	sp,sp,64
 748:	8082                	ret
    x = -xx;
 74a:	40b005bb          	negw	a1,a1
    neg = 1;
 74e:	4885                	li	a7,1
    x = -xx;
 750:	bf85                	j	6c0 <printint+0x1a>

0000000000000752 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 752:	715d                	add	sp,sp,-80
 754:	e486                	sd	ra,72(sp)
 756:	e0a2                	sd	s0,64(sp)
 758:	fc26                	sd	s1,56(sp)
 75a:	f84a                	sd	s2,48(sp)
 75c:	f44e                	sd	s3,40(sp)
 75e:	f052                	sd	s4,32(sp)
 760:	ec56                	sd	s5,24(sp)
 762:	e85a                	sd	s6,16(sp)
 764:	e45e                	sd	s7,8(sp)
 766:	e062                	sd	s8,0(sp)
 768:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 76a:	0005c903          	lbu	s2,0(a1)
 76e:	18090c63          	beqz	s2,906 <vprintf+0x1b4>
 772:	8aaa                	mv	s5,a0
 774:	8bb2                	mv	s7,a2
 776:	00158493          	add	s1,a1,1
  state = 0;
 77a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 77c:	02500a13          	li	s4,37
 780:	4b55                	li	s6,21
 782:	a839                	j	7a0 <vprintf+0x4e>
        putc(fd, c);
 784:	85ca                	mv	a1,s2
 786:	8556                	mv	a0,s5
 788:	00000097          	auipc	ra,0x0
 78c:	efc080e7          	jalr	-260(ra) # 684 <putc>
 790:	a019                	j	796 <vprintf+0x44>
    } else if(state == '%'){
 792:	01498d63          	beq	s3,s4,7ac <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 796:	0485                	add	s1,s1,1
 798:	fff4c903          	lbu	s2,-1(s1)
 79c:	16090563          	beqz	s2,906 <vprintf+0x1b4>
    if(state == 0){
 7a0:	fe0999e3          	bnez	s3,792 <vprintf+0x40>
      if(c == '%'){
 7a4:	ff4910e3          	bne	s2,s4,784 <vprintf+0x32>
        state = '%';
 7a8:	89d2                	mv	s3,s4
 7aa:	b7f5                	j	796 <vprintf+0x44>
      if(c == 'd'){
 7ac:	13490263          	beq	s2,s4,8d0 <vprintf+0x17e>
 7b0:	f9d9079b          	addw	a5,s2,-99
 7b4:	0ff7f793          	zext.b	a5,a5
 7b8:	12fb6563          	bltu	s6,a5,8e2 <vprintf+0x190>
 7bc:	f9d9079b          	addw	a5,s2,-99
 7c0:	0ff7f713          	zext.b	a4,a5
 7c4:	10eb6f63          	bltu	s6,a4,8e2 <vprintf+0x190>
 7c8:	00271793          	sll	a5,a4,0x2
 7cc:	00000717          	auipc	a4,0x0
 7d0:	51c70713          	add	a4,a4,1308 # ce8 <updateNode+0xba>
 7d4:	97ba                	add	a5,a5,a4
 7d6:	439c                	lw	a5,0(a5)
 7d8:	97ba                	add	a5,a5,a4
 7da:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 7dc:	008b8913          	add	s2,s7,8
 7e0:	4685                	li	a3,1
 7e2:	4629                	li	a2,10
 7e4:	000ba583          	lw	a1,0(s7)
 7e8:	8556                	mv	a0,s5
 7ea:	00000097          	auipc	ra,0x0
 7ee:	ebc080e7          	jalr	-324(ra) # 6a6 <printint>
 7f2:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7f4:	4981                	li	s3,0
 7f6:	b745                	j	796 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7f8:	008b8913          	add	s2,s7,8
 7fc:	4681                	li	a3,0
 7fe:	4629                	li	a2,10
 800:	000ba583          	lw	a1,0(s7)
 804:	8556                	mv	a0,s5
 806:	00000097          	auipc	ra,0x0
 80a:	ea0080e7          	jalr	-352(ra) # 6a6 <printint>
 80e:	8bca                	mv	s7,s2
      state = 0;
 810:	4981                	li	s3,0
 812:	b751                	j	796 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 814:	008b8913          	add	s2,s7,8
 818:	4681                	li	a3,0
 81a:	4641                	li	a2,16
 81c:	000ba583          	lw	a1,0(s7)
 820:	8556                	mv	a0,s5
 822:	00000097          	auipc	ra,0x0
 826:	e84080e7          	jalr	-380(ra) # 6a6 <printint>
 82a:	8bca                	mv	s7,s2
      state = 0;
 82c:	4981                	li	s3,0
 82e:	b7a5                	j	796 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 830:	008b8c13          	add	s8,s7,8
 834:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 838:	03000593          	li	a1,48
 83c:	8556                	mv	a0,s5
 83e:	00000097          	auipc	ra,0x0
 842:	e46080e7          	jalr	-442(ra) # 684 <putc>
  putc(fd, 'x');
 846:	07800593          	li	a1,120
 84a:	8556                	mv	a0,s5
 84c:	00000097          	auipc	ra,0x0
 850:	e38080e7          	jalr	-456(ra) # 684 <putc>
 854:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 856:	00000b97          	auipc	s7,0x0
 85a:	4eab8b93          	add	s7,s7,1258 # d40 <digits>
 85e:	03c9d793          	srl	a5,s3,0x3c
 862:	97de                	add	a5,a5,s7
 864:	0007c583          	lbu	a1,0(a5)
 868:	8556                	mv	a0,s5
 86a:	00000097          	auipc	ra,0x0
 86e:	e1a080e7          	jalr	-486(ra) # 684 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 872:	0992                	sll	s3,s3,0x4
 874:	397d                	addw	s2,s2,-1
 876:	fe0914e3          	bnez	s2,85e <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 87a:	8be2                	mv	s7,s8
      state = 0;
 87c:	4981                	li	s3,0
 87e:	bf21                	j	796 <vprintf+0x44>
        s = va_arg(ap, char*);
 880:	008b8993          	add	s3,s7,8
 884:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 888:	02090163          	beqz	s2,8aa <vprintf+0x158>
        while(*s != 0){
 88c:	00094583          	lbu	a1,0(s2)
 890:	c9a5                	beqz	a1,900 <vprintf+0x1ae>
          putc(fd, *s);
 892:	8556                	mv	a0,s5
 894:	00000097          	auipc	ra,0x0
 898:	df0080e7          	jalr	-528(ra) # 684 <putc>
          s++;
 89c:	0905                	add	s2,s2,1
        while(*s != 0){
 89e:	00094583          	lbu	a1,0(s2)
 8a2:	f9e5                	bnez	a1,892 <vprintf+0x140>
        s = va_arg(ap, char*);
 8a4:	8bce                	mv	s7,s3
      state = 0;
 8a6:	4981                	li	s3,0
 8a8:	b5fd                	j	796 <vprintf+0x44>
          s = "(null)";
 8aa:	00000917          	auipc	s2,0x0
 8ae:	43690913          	add	s2,s2,1078 # ce0 <updateNode+0xb2>
        while(*s != 0){
 8b2:	02800593          	li	a1,40
 8b6:	bff1                	j	892 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 8b8:	008b8913          	add	s2,s7,8
 8bc:	000bc583          	lbu	a1,0(s7)
 8c0:	8556                	mv	a0,s5
 8c2:	00000097          	auipc	ra,0x0
 8c6:	dc2080e7          	jalr	-574(ra) # 684 <putc>
 8ca:	8bca                	mv	s7,s2
      state = 0;
 8cc:	4981                	li	s3,0
 8ce:	b5e1                	j	796 <vprintf+0x44>
        putc(fd, c);
 8d0:	02500593          	li	a1,37
 8d4:	8556                	mv	a0,s5
 8d6:	00000097          	auipc	ra,0x0
 8da:	dae080e7          	jalr	-594(ra) # 684 <putc>
      state = 0;
 8de:	4981                	li	s3,0
 8e0:	bd5d                	j	796 <vprintf+0x44>
        putc(fd, '%');
 8e2:	02500593          	li	a1,37
 8e6:	8556                	mv	a0,s5
 8e8:	00000097          	auipc	ra,0x0
 8ec:	d9c080e7          	jalr	-612(ra) # 684 <putc>
        putc(fd, c);
 8f0:	85ca                	mv	a1,s2
 8f2:	8556                	mv	a0,s5
 8f4:	00000097          	auipc	ra,0x0
 8f8:	d90080e7          	jalr	-624(ra) # 684 <putc>
      state = 0;
 8fc:	4981                	li	s3,0
 8fe:	bd61                	j	796 <vprintf+0x44>
        s = va_arg(ap, char*);
 900:	8bce                	mv	s7,s3
      state = 0;
 902:	4981                	li	s3,0
 904:	bd49                	j	796 <vprintf+0x44>
    }
  }
}
 906:	60a6                	ld	ra,72(sp)
 908:	6406                	ld	s0,64(sp)
 90a:	74e2                	ld	s1,56(sp)
 90c:	7942                	ld	s2,48(sp)
 90e:	79a2                	ld	s3,40(sp)
 910:	7a02                	ld	s4,32(sp)
 912:	6ae2                	ld	s5,24(sp)
 914:	6b42                	ld	s6,16(sp)
 916:	6ba2                	ld	s7,8(sp)
 918:	6c02                	ld	s8,0(sp)
 91a:	6161                	add	sp,sp,80
 91c:	8082                	ret

000000000000091e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 91e:	715d                	add	sp,sp,-80
 920:	ec06                	sd	ra,24(sp)
 922:	e822                	sd	s0,16(sp)
 924:	1000                	add	s0,sp,32
 926:	e010                	sd	a2,0(s0)
 928:	e414                	sd	a3,8(s0)
 92a:	e818                	sd	a4,16(s0)
 92c:	ec1c                	sd	a5,24(s0)
 92e:	03043023          	sd	a6,32(s0)
 932:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 936:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 93a:	8622                	mv	a2,s0
 93c:	00000097          	auipc	ra,0x0
 940:	e16080e7          	jalr	-490(ra) # 752 <vprintf>
}
 944:	60e2                	ld	ra,24(sp)
 946:	6442                	ld	s0,16(sp)
 948:	6161                	add	sp,sp,80
 94a:	8082                	ret

000000000000094c <printf>:

void
printf(const char *fmt, ...)
{
 94c:	711d                	add	sp,sp,-96
 94e:	ec06                	sd	ra,24(sp)
 950:	e822                	sd	s0,16(sp)
 952:	1000                	add	s0,sp,32
 954:	e40c                	sd	a1,8(s0)
 956:	e810                	sd	a2,16(s0)
 958:	ec14                	sd	a3,24(s0)
 95a:	f018                	sd	a4,32(s0)
 95c:	f41c                	sd	a5,40(s0)
 95e:	03043823          	sd	a6,48(s0)
 962:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 966:	00840613          	add	a2,s0,8
 96a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 96e:	85aa                	mv	a1,a0
 970:	4505                	li	a0,1
 972:	00000097          	auipc	ra,0x0
 976:	de0080e7          	jalr	-544(ra) # 752 <vprintf>
}
 97a:	60e2                	ld	ra,24(sp)
 97c:	6442                	ld	s0,16(sp)
 97e:	6125                	add	sp,sp,96
 980:	8082                	ret

0000000000000982 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 982:	1141                	add	sp,sp,-16
 984:	e422                	sd	s0,8(sp)
 986:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 988:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 98c:	00000797          	auipc	a5,0x0
 990:	6747b783          	ld	a5,1652(a5) # 1000 <freep>
 994:	a02d                	j	9be <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 996:	4618                	lw	a4,8(a2)
 998:	9f2d                	addw	a4,a4,a1
 99a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 99e:	6398                	ld	a4,0(a5)
 9a0:	6310                	ld	a2,0(a4)
 9a2:	a83d                	j	9e0 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9a4:	ff852703          	lw	a4,-8(a0)
 9a8:	9f31                	addw	a4,a4,a2
 9aa:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 9ac:	ff053683          	ld	a3,-16(a0)
 9b0:	a091                	j	9f4 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9b2:	6398                	ld	a4,0(a5)
 9b4:	00e7e463          	bltu	a5,a4,9bc <free+0x3a>
 9b8:	00e6ea63          	bltu	a3,a4,9cc <free+0x4a>
{
 9bc:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9be:	fed7fae3          	bgeu	a5,a3,9b2 <free+0x30>
 9c2:	6398                	ld	a4,0(a5)
 9c4:	00e6e463          	bltu	a3,a4,9cc <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9c8:	fee7eae3          	bltu	a5,a4,9bc <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 9cc:	ff852583          	lw	a1,-8(a0)
 9d0:	6390                	ld	a2,0(a5)
 9d2:	02059813          	sll	a6,a1,0x20
 9d6:	01c85713          	srl	a4,a6,0x1c
 9da:	9736                	add	a4,a4,a3
 9dc:	fae60de3          	beq	a2,a4,996 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 9e0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9e4:	4790                	lw	a2,8(a5)
 9e6:	02061593          	sll	a1,a2,0x20
 9ea:	01c5d713          	srl	a4,a1,0x1c
 9ee:	973e                	add	a4,a4,a5
 9f0:	fae68ae3          	beq	a3,a4,9a4 <free+0x22>
    p->s.ptr = bp->s.ptr;
 9f4:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9f6:	00000717          	auipc	a4,0x0
 9fa:	60f73523          	sd	a5,1546(a4) # 1000 <freep>
}
 9fe:	6422                	ld	s0,8(sp)
 a00:	0141                	add	sp,sp,16
 a02:	8082                	ret

0000000000000a04 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a04:	7139                	add	sp,sp,-64
 a06:	fc06                	sd	ra,56(sp)
 a08:	f822                	sd	s0,48(sp)
 a0a:	f426                	sd	s1,40(sp)
 a0c:	f04a                	sd	s2,32(sp)
 a0e:	ec4e                	sd	s3,24(sp)
 a10:	e852                	sd	s4,16(sp)
 a12:	e456                	sd	s5,8(sp)
 a14:	e05a                	sd	s6,0(sp)
 a16:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a18:	02051493          	sll	s1,a0,0x20
 a1c:	9081                	srl	s1,s1,0x20
 a1e:	04bd                	add	s1,s1,15
 a20:	8091                	srl	s1,s1,0x4
 a22:	0014899b          	addw	s3,s1,1
 a26:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 a28:	00000517          	auipc	a0,0x0
 a2c:	5d853503          	ld	a0,1496(a0) # 1000 <freep>
 a30:	c515                	beqz	a0,a5c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a32:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a34:	4798                	lw	a4,8(a5)
 a36:	02977f63          	bgeu	a4,s1,a74 <malloc+0x70>
  if(nu < 4096)
 a3a:	8a4e                	mv	s4,s3
 a3c:	0009871b          	sext.w	a4,s3
 a40:	6685                	lui	a3,0x1
 a42:	00d77363          	bgeu	a4,a3,a48 <malloc+0x44>
 a46:	6a05                	lui	s4,0x1
 a48:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a4c:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a50:	00000917          	auipc	s2,0x0
 a54:	5b090913          	add	s2,s2,1456 # 1000 <freep>
  if(p == (char*)-1)
 a58:	5afd                	li	s5,-1
 a5a:	a895                	j	ace <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 a5c:	00000797          	auipc	a5,0x0
 a60:	5c478793          	add	a5,a5,1476 # 1020 <base>
 a64:	00000717          	auipc	a4,0x0
 a68:	58f73e23          	sd	a5,1436(a4) # 1000 <freep>
 a6c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a6e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a72:	b7e1                	j	a3a <malloc+0x36>
      if(p->s.size == nunits)
 a74:	02e48c63          	beq	s1,a4,aac <malloc+0xa8>
        p->s.size -= nunits;
 a78:	4137073b          	subw	a4,a4,s3
 a7c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a7e:	02071693          	sll	a3,a4,0x20
 a82:	01c6d713          	srl	a4,a3,0x1c
 a86:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a88:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a8c:	00000717          	auipc	a4,0x0
 a90:	56a73a23          	sd	a0,1396(a4) # 1000 <freep>
      return (void*)(p + 1);
 a94:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a98:	70e2                	ld	ra,56(sp)
 a9a:	7442                	ld	s0,48(sp)
 a9c:	74a2                	ld	s1,40(sp)
 a9e:	7902                	ld	s2,32(sp)
 aa0:	69e2                	ld	s3,24(sp)
 aa2:	6a42                	ld	s4,16(sp)
 aa4:	6aa2                	ld	s5,8(sp)
 aa6:	6b02                	ld	s6,0(sp)
 aa8:	6121                	add	sp,sp,64
 aaa:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 aac:	6398                	ld	a4,0(a5)
 aae:	e118                	sd	a4,0(a0)
 ab0:	bff1                	j	a8c <malloc+0x88>
  hp->s.size = nu;
 ab2:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 ab6:	0541                	add	a0,a0,16
 ab8:	00000097          	auipc	ra,0x0
 abc:	eca080e7          	jalr	-310(ra) # 982 <free>
  return freep;
 ac0:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 ac4:	d971                	beqz	a0,a98 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ac6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ac8:	4798                	lw	a4,8(a5)
 aca:	fa9775e3          	bgeu	a4,s1,a74 <malloc+0x70>
    if(p == freep)
 ace:	00093703          	ld	a4,0(s2)
 ad2:	853e                	mv	a0,a5
 ad4:	fef719e3          	bne	a4,a5,ac6 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 ad8:	8552                	mv	a0,s4
 ada:	00000097          	auipc	ra,0x0
 ade:	b42080e7          	jalr	-1214(ra) # 61c <sbrk>
  if(p == (char*)-1)
 ae2:	fd5518e3          	bne	a0,s5,ab2 <malloc+0xae>
        return 0;
 ae6:	4501                	li	a0,0
 ae8:	bf45                	j	a98 <malloc+0x94>

0000000000000aea <init_lock>:
#include "linkedlist.h"

// Define a node structure for the linked list
struct spinlock_u list_lock;

void init_lock(){
 aea:	1141                	add	sp,sp,-16
 aec:	e406                	sd	ra,8(sp)
 aee:	e022                	sd	s0,0(sp)
 af0:	0800                	add	s0,sp,16
    initlock(&list_lock);
 af2:	00000517          	auipc	a0,0x0
 af6:	51650513          	add	a0,a0,1302 # 1008 <list_lock>
 afa:	00000097          	auipc	ra,0x0
 afe:	a56080e7          	jalr	-1450(ra) # 550 <initlock>
}
 b02:	60a2                	ld	ra,8(sp)
 b04:	6402                	ld	s0,0(sp)
 b06:	0141                	add	sp,sp,16
 b08:	8082                	ret

0000000000000b0a <insert>:

// Function to insert a node at the beginning of the linked list
void insert(struct Node **head_ref, int new_data) {
 b0a:	1101                	add	sp,sp,-32
 b0c:	ec06                	sd	ra,24(sp)
 b0e:	e822                	sd	s0,16(sp)
 b10:	e426                	sd	s1,8(sp)
 b12:	e04a                	sd	s2,0(sp)
 b14:	1000                	add	s0,sp,32
 b16:	84aa                	mv	s1,a0
 b18:	892e                	mv	s2,a1
    struct Node *new_node = malloc(sizeof(struct Node));
 b1a:	4541                	li	a0,16
 b1c:	00000097          	auipc	ra,0x0
 b20:	ee8080e7          	jalr	-280(ra) # a04 <malloc>
    new_node->data = new_data;
 b24:	01252023          	sw	s2,0(a0)
    new_node->next = *head_ref;
 b28:	609c                	ld	a5,0(s1)
 b2a:	e51c                	sd	a5,8(a0)
    *head_ref = new_node;
 b2c:	e088                	sd	a0,0(s1)
}
 b2e:	60e2                	ld	ra,24(sp)
 b30:	6442                	ld	s0,16(sp)
 b32:	64a2                	ld	s1,8(sp)
 b34:	6902                	ld	s2,0(sp)
 b36:	6105                	add	sp,sp,32
 b38:	8082                	ret

0000000000000b3a <deleteNode>:

// Function to delete a node with a given key from the linked list
void deleteNode(struct Node **head_ref, int key) {
 b3a:	7179                	add	sp,sp,-48
 b3c:	f406                	sd	ra,40(sp)
 b3e:	f022                	sd	s0,32(sp)
 b40:	ec26                	sd	s1,24(sp)
 b42:	e84a                	sd	s2,16(sp)
 b44:	e44e                	sd	s3,8(sp)
 b46:	1800                	add	s0,sp,48
 b48:	89aa                	mv	s3,a0
 b4a:	892e                	mv	s2,a1
    struct Node *temp = *head_ref, *prev = 0;
 b4c:	6104                	ld	s1,0(a0)

    acquire(&list_lock);
 b4e:	00000517          	auipc	a0,0x0
 b52:	4ba50513          	add	a0,a0,1210 # 1008 <list_lock>
 b56:	00000097          	auipc	ra,0x0
 b5a:	a0a080e7          	jalr	-1526(ra) # 560 <acquire>
    if (temp != 0 && temp->data == key) {
 b5e:	c0b1                	beqz	s1,ba2 <deleteNode+0x68>
 b60:	409c                	lw	a5,0(s1)
 b62:	4701                	li	a4,0
 b64:	01278a63          	beq	a5,s2,b78 <deleteNode+0x3e>
        rcusync();
        free(temp);
        return;
    }

    while (temp != 0 && temp->data != key) {
 b68:	409c                	lw	a5,0(s1)
 b6a:	05278563          	beq	a5,s2,bb4 <deleteNode+0x7a>
        prev = temp;
        temp = temp->next;
 b6e:	649c                	ld	a5,8(s1)
    while (temp != 0 && temp->data != key) {
 b70:	8726                	mv	a4,s1
 b72:	cb85                	beqz	a5,ba2 <deleteNode+0x68>
        temp = temp->next;
 b74:	84be                	mv	s1,a5
 b76:	bfcd                	j	b68 <deleteNode+0x2e>
        *head_ref = temp->next;
 b78:	649c                	ld	a5,8(s1)
 b7a:	00f9b023          	sd	a5,0(s3)
        release(&list_lock);
 b7e:	00000517          	auipc	a0,0x0
 b82:	48a50513          	add	a0,a0,1162 # 1008 <list_lock>
 b86:	00000097          	auipc	ra,0x0
 b8a:	9f2080e7          	jalr	-1550(ra) # 578 <release>
        rcusync();
 b8e:	00000097          	auipc	ra,0x0
 b92:	ab6080e7          	jalr	-1354(ra) # 644 <rcusync>
        free(temp);
 b96:	8526                	mv	a0,s1
 b98:	00000097          	auipc	ra,0x0
 b9c:	dea080e7          	jalr	-534(ra) # 982 <free>
        return;
 ba0:	a82d                	j	bda <deleteNode+0xa0>
    }

    if (temp == 0) {
        release(&list_lock);
 ba2:	00000517          	auipc	a0,0x0
 ba6:	46650513          	add	a0,a0,1126 # 1008 <list_lock>
 baa:	00000097          	auipc	ra,0x0
 bae:	9ce080e7          	jalr	-1586(ra) # 578 <release>
        return;
 bb2:	a025                	j	bda <deleteNode+0xa0>
    }
    prev->next = temp->next;
 bb4:	649c                	ld	a5,8(s1)
 bb6:	e71c                	sd	a5,8(a4)
    release(&list_lock);
 bb8:	00000517          	auipc	a0,0x0
 bbc:	45050513          	add	a0,a0,1104 # 1008 <list_lock>
 bc0:	00000097          	auipc	ra,0x0
 bc4:	9b8080e7          	jalr	-1608(ra) # 578 <release>
    rcusync();
 bc8:	00000097          	auipc	ra,0x0
 bcc:	a7c080e7          	jalr	-1412(ra) # 644 <rcusync>
    free(temp);
 bd0:	8526                	mv	a0,s1
 bd2:	00000097          	auipc	ra,0x0
 bd6:	db0080e7          	jalr	-592(ra) # 982 <free>
}
 bda:	70a2                	ld	ra,40(sp)
 bdc:	7402                	ld	s0,32(sp)
 bde:	64e2                	ld	s1,24(sp)
 be0:	6942                	ld	s2,16(sp)
 be2:	69a2                	ld	s3,8(sp)
 be4:	6145                	add	sp,sp,48
 be6:	8082                	ret

0000000000000be8 <search>:

// Function to search for a node with a given key in the linked list
struct Node* search(struct Node *head, int key) {
 be8:	1101                	add	sp,sp,-32
 bea:	ec06                	sd	ra,24(sp)
 bec:	e822                	sd	s0,16(sp)
 bee:	e426                	sd	s1,8(sp)
 bf0:	e04a                	sd	s2,0(sp)
 bf2:	1000                	add	s0,sp,32
 bf4:	84aa                	mv	s1,a0
 bf6:	892e                	mv	s2,a1

    struct Node *current = head;
    rcureadlock();
 bf8:	00000097          	auipc	ra,0x0
 bfc:	a3c080e7          	jalr	-1476(ra) # 634 <rcureadlock>
    while (current != 0) {
 c00:	c491                	beqz	s1,c0c <search+0x24>
        if (current->data == key) {
 c02:	409c                	lw	a5,0(s1)
 c04:	01278f63          	beq	a5,s2,c22 <search+0x3a>
            rcureadunlock();
            return current; // Node found
        }
        current = current->next;
 c08:	6484                	ld	s1,8(s1)
    while (current != 0) {
 c0a:	fce5                	bnez	s1,c02 <search+0x1a>
    }
    rcureadunlock();
 c0c:	00000097          	auipc	ra,0x0
 c10:	a30080e7          	jalr	-1488(ra) # 63c <rcureadunlock>
    return 0; // Node not found
 c14:	4501                	li	a0,0
}
 c16:	60e2                	ld	ra,24(sp)
 c18:	6442                	ld	s0,16(sp)
 c1a:	64a2                	ld	s1,8(sp)
 c1c:	6902                	ld	s2,0(sp)
 c1e:	6105                	add	sp,sp,32
 c20:	8082                	ret
            rcureadunlock();
 c22:	00000097          	auipc	ra,0x0
 c26:	a1a080e7          	jalr	-1510(ra) # 63c <rcureadunlock>
            return current; // Node found
 c2a:	8526                	mv	a0,s1
 c2c:	b7ed                	j	c16 <search+0x2e>

0000000000000c2e <updateNode>:

// Function to update the value of a node with a given key in the linked list
void updateNode(struct Node *head, int key, int new_data) {
 c2e:	1101                	add	sp,sp,-32
 c30:	ec06                	sd	ra,24(sp)
 c32:	e822                	sd	s0,16(sp)
 c34:	e426                	sd	s1,8(sp)
 c36:	e04a                	sd	s2,0(sp)
 c38:	1000                	add	s0,sp,32
 c3a:	892e                	mv	s2,a1
 c3c:	84b2                	mv	s1,a2
    struct Node *nodeToUpdate = search(head, key);
 c3e:	00000097          	auipc	ra,0x0
 c42:	faa080e7          	jalr	-86(ra) # be8 <search>

    if (nodeToUpdate != 0) {
 c46:	c901                	beqz	a0,c56 <updateNode+0x28>
        nodeToUpdate->data = new_data; // Update the node's data
 c48:	c104                	sw	s1,0(a0)
    } else {
        printf("Node with key %d not found.\n", key);
    }
}
 c4a:	60e2                	ld	ra,24(sp)
 c4c:	6442                	ld	s0,16(sp)
 c4e:	64a2                	ld	s1,8(sp)
 c50:	6902                	ld	s2,0(sp)
 c52:	6105                	add	sp,sp,32
 c54:	8082                	ret
        printf("Node with key %d not found.\n", key);
 c56:	85ca                	mv	a1,s2
 c58:	00000517          	auipc	a0,0x0
 c5c:	10050513          	add	a0,a0,256 # d58 <digits+0x18>
 c60:	00000097          	auipc	ra,0x0
 c64:	cec080e7          	jalr	-788(ra) # 94c <printf>
}
 c68:	b7cd                	j	c4a <updateNode+0x1c>
