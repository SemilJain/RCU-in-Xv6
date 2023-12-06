
user/_testrcu:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <rcu_test>:
#define IS_RCU 0
#define READTHREADS 1
#define DELETETHREADS 1


void rcu_test() {
   0:	7179                	add	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	add	s0,sp,48

    
    klist_insert(INSERT_COUNT, IS_RCU);
   e:	4581                	li	a1,0
  10:	3e800513          	li	a0,1000
  14:	00000097          	auipc	ra,0x0
  18:	472080e7          	jalr	1138(ra) # 486 <klist_insert>
    klist_print();
  1c:	00000097          	auipc	ra,0x0
  20:	482080e7          	jalr	1154(ra) # 49e <klist_print>
    int pid = fork();
  24:	00000097          	auipc	ra,0x0
  28:	38a080e7          	jalr	906(ra) # 3ae <fork>
            }
            
        }        
        exit(0);
    }else{
        for (int i = 1; i <= DELETE_COUNT; i++)
  2c:	4485                	li	s1,1
        {
           klist_delete(i,IS_RCU);
           if(i%12){
  2e:	49b1                	li	s3,12
        for (int i = 1; i <= DELETE_COUNT; i++)
  30:	0c900913          	li	s2,201
    if (pid == 0)
  34:	ed1d                	bnez	a0,72 <rcu_test+0x72>
            if (i%10)
  36:	49a9                	li	s3,10
        for (int i = 1; i <= QUERY_COUNT; i++)
  38:	12d00913          	li	s2,301
  3c:	a021                	j	44 <rcu_test+0x44>
  3e:	2485                	addw	s1,s1,1
  40:	03248163          	beq	s1,s2,62 <rcu_test+0x62>
            klist_query(i,IS_RCU);
  44:	4581                	li	a1,0
  46:	8526                	mv	a0,s1
  48:	00000097          	auipc	ra,0x0
  4c:	44e080e7          	jalr	1102(ra) # 496 <klist_query>
            if (i%10)
  50:	0334e7bb          	remw	a5,s1,s3
  54:	d7ed                	beqz	a5,3e <rcu_test+0x3e>
                sleep(1);
  56:	4505                	li	a0,1
  58:	00000097          	auipc	ra,0x0
  5c:	3ee080e7          	jalr	1006(ra) # 446 <sleep>
  60:	bff9                	j	3e <rcu_test+0x3e>
        exit(0);
  62:	4501                	li	a0,0
  64:	00000097          	auipc	ra,0x0
  68:	352080e7          	jalr	850(ra) # 3b6 <exit>
        for (int i = 1; i <= DELETE_COUNT; i++)
  6c:	2485                	addw	s1,s1,1
  6e:	03248163          	beq	s1,s2,90 <rcu_test+0x90>
           klist_delete(i,IS_RCU);
  72:	4581                	li	a1,0
  74:	8526                	mv	a0,s1
  76:	00000097          	auipc	ra,0x0
  7a:	418080e7          	jalr	1048(ra) # 48e <klist_delete>
           if(i%12){
  7e:	0334e7bb          	remw	a5,s1,s3
  82:	d7ed                	beqz	a5,6c <rcu_test+0x6c>
                sleep(1);
  84:	4505                	li	a0,1
  86:	00000097          	auipc	ra,0x0
  8a:	3c0080e7          	jalr	960(ra) # 446 <sleep>
  8e:	bff9                	j	6c <rcu_test+0x6c>
            }   
        }
    }
    wait((int *)0);
  90:	4501                	li	a0,0
  92:	00000097          	auipc	ra,0x0
  96:	32c080e7          	jalr	812(ra) # 3be <wait>
    klist_print();
  9a:	00000097          	auipc	ra,0x0
  9e:	404080e7          	jalr	1028(ra) # 49e <klist_print>
}
  a2:	70a2                	ld	ra,40(sp)
  a4:	7402                	ld	s0,32(sp)
  a6:	64e2                	ld	s1,24(sp)
  a8:	6942                	ld	s2,16(sp)
  aa:	69a2                	ld	s3,8(sp)
  ac:	6145                	add	sp,sp,48
  ae:	8082                	ret

00000000000000b0 <main>:

int main() {
  b0:	1101                	add	sp,sp,-32
  b2:	ec06                	sd	ra,24(sp)
  b4:	e822                	sd	s0,16(sp)
  b6:	e426                	sd	s1,8(sp)
  b8:	1000                	add	s0,sp,32
    int start = uptime();
  ba:	00000097          	auipc	ra,0x0
  be:	394080e7          	jalr	916(ra) # 44e <uptime>
  c2:	84aa                	mv	s1,a0
    rcu_test();
  c4:	00000097          	auipc	ra,0x0
  c8:	f3c080e7          	jalr	-196(ra) # 0 <rcu_test>
    int end = uptime();
  cc:	00000097          	auipc	ra,0x0
  d0:	382080e7          	jalr	898(ra) # 44e <uptime>

    fprintf(1,"Total time: %d\n", end - start);
  d4:	4095063b          	subw	a2,a0,s1
  d8:	00001597          	auipc	a1,0x1
  dc:	9b858593          	add	a1,a1,-1608 # a90 <updateNode+0x40>
  e0:	4505                	li	a0,1
  e2:	00000097          	auipc	ra,0x0
  e6:	65e080e7          	jalr	1630(ra) # 740 <fprintf>
    exit(0);
  ea:	4501                	li	a0,0
  ec:	00000097          	auipc	ra,0x0
  f0:	2ca080e7          	jalr	714(ra) # 3b6 <exit>

00000000000000f4 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  f4:	1141                	add	sp,sp,-16
  f6:	e406                	sd	ra,8(sp)
  f8:	e022                	sd	s0,0(sp)
  fa:	0800                	add	s0,sp,16
  extern int main();
  main();
  fc:	00000097          	auipc	ra,0x0
 100:	fb4080e7          	jalr	-76(ra) # b0 <main>
  exit(0);
 104:	4501                	li	a0,0
 106:	00000097          	auipc	ra,0x0
 10a:	2b0080e7          	jalr	688(ra) # 3b6 <exit>

000000000000010e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 10e:	1141                	add	sp,sp,-16
 110:	e422                	sd	s0,8(sp)
 112:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 114:	87aa                	mv	a5,a0
 116:	0585                	add	a1,a1,1
 118:	0785                	add	a5,a5,1
 11a:	fff5c703          	lbu	a4,-1(a1)
 11e:	fee78fa3          	sb	a4,-1(a5)
 122:	fb75                	bnez	a4,116 <strcpy+0x8>
    ;
  return os;
}
 124:	6422                	ld	s0,8(sp)
 126:	0141                	add	sp,sp,16
 128:	8082                	ret

000000000000012a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 12a:	1141                	add	sp,sp,-16
 12c:	e422                	sd	s0,8(sp)
 12e:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 130:	00054783          	lbu	a5,0(a0)
 134:	cb91                	beqz	a5,148 <strcmp+0x1e>
 136:	0005c703          	lbu	a4,0(a1)
 13a:	00f71763          	bne	a4,a5,148 <strcmp+0x1e>
    p++, q++;
 13e:	0505                	add	a0,a0,1
 140:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 142:	00054783          	lbu	a5,0(a0)
 146:	fbe5                	bnez	a5,136 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 148:	0005c503          	lbu	a0,0(a1)
}
 14c:	40a7853b          	subw	a0,a5,a0
 150:	6422                	ld	s0,8(sp)
 152:	0141                	add	sp,sp,16
 154:	8082                	ret

0000000000000156 <strlen>:

uint
strlen(const char *s)
{
 156:	1141                	add	sp,sp,-16
 158:	e422                	sd	s0,8(sp)
 15a:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 15c:	00054783          	lbu	a5,0(a0)
 160:	cf91                	beqz	a5,17c <strlen+0x26>
 162:	0505                	add	a0,a0,1
 164:	87aa                	mv	a5,a0
 166:	86be                	mv	a3,a5
 168:	0785                	add	a5,a5,1
 16a:	fff7c703          	lbu	a4,-1(a5)
 16e:	ff65                	bnez	a4,166 <strlen+0x10>
 170:	40a6853b          	subw	a0,a3,a0
 174:	2505                	addw	a0,a0,1
    ;
  return n;
}
 176:	6422                	ld	s0,8(sp)
 178:	0141                	add	sp,sp,16
 17a:	8082                	ret
  for(n = 0; s[n]; n++)
 17c:	4501                	li	a0,0
 17e:	bfe5                	j	176 <strlen+0x20>

0000000000000180 <memset>:

void*
memset(void *dst, int c, uint n)
{
 180:	1141                	add	sp,sp,-16
 182:	e422                	sd	s0,8(sp)
 184:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 186:	ca19                	beqz	a2,19c <memset+0x1c>
 188:	87aa                	mv	a5,a0
 18a:	1602                	sll	a2,a2,0x20
 18c:	9201                	srl	a2,a2,0x20
 18e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 192:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 196:	0785                	add	a5,a5,1
 198:	fee79de3          	bne	a5,a4,192 <memset+0x12>
  }
  return dst;
}
 19c:	6422                	ld	s0,8(sp)
 19e:	0141                	add	sp,sp,16
 1a0:	8082                	ret

00000000000001a2 <strchr>:

char*
strchr(const char *s, char c)
{
 1a2:	1141                	add	sp,sp,-16
 1a4:	e422                	sd	s0,8(sp)
 1a6:	0800                	add	s0,sp,16
  for(; *s; s++)
 1a8:	00054783          	lbu	a5,0(a0)
 1ac:	cb99                	beqz	a5,1c2 <strchr+0x20>
    if(*s == c)
 1ae:	00f58763          	beq	a1,a5,1bc <strchr+0x1a>
  for(; *s; s++)
 1b2:	0505                	add	a0,a0,1
 1b4:	00054783          	lbu	a5,0(a0)
 1b8:	fbfd                	bnez	a5,1ae <strchr+0xc>
      return (char*)s;
  return 0;
 1ba:	4501                	li	a0,0
}
 1bc:	6422                	ld	s0,8(sp)
 1be:	0141                	add	sp,sp,16
 1c0:	8082                	ret
  return 0;
 1c2:	4501                	li	a0,0
 1c4:	bfe5                	j	1bc <strchr+0x1a>

00000000000001c6 <gets>:

char*
gets(char *buf, int max)
{
 1c6:	711d                	add	sp,sp,-96
 1c8:	ec86                	sd	ra,88(sp)
 1ca:	e8a2                	sd	s0,80(sp)
 1cc:	e4a6                	sd	s1,72(sp)
 1ce:	e0ca                	sd	s2,64(sp)
 1d0:	fc4e                	sd	s3,56(sp)
 1d2:	f852                	sd	s4,48(sp)
 1d4:	f456                	sd	s5,40(sp)
 1d6:	f05a                	sd	s6,32(sp)
 1d8:	ec5e                	sd	s7,24(sp)
 1da:	1080                	add	s0,sp,96
 1dc:	8baa                	mv	s7,a0
 1de:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e0:	892a                	mv	s2,a0
 1e2:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1e4:	4aa9                	li	s5,10
 1e6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1e8:	89a6                	mv	s3,s1
 1ea:	2485                	addw	s1,s1,1
 1ec:	0344d863          	bge	s1,s4,21c <gets+0x56>
    cc = read(0, &c, 1);
 1f0:	4605                	li	a2,1
 1f2:	faf40593          	add	a1,s0,-81
 1f6:	4501                	li	a0,0
 1f8:	00000097          	auipc	ra,0x0
 1fc:	1d6080e7          	jalr	470(ra) # 3ce <read>
    if(cc < 1)
 200:	00a05e63          	blez	a0,21c <gets+0x56>
    buf[i++] = c;
 204:	faf44783          	lbu	a5,-81(s0)
 208:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 20c:	01578763          	beq	a5,s5,21a <gets+0x54>
 210:	0905                	add	s2,s2,1
 212:	fd679be3          	bne	a5,s6,1e8 <gets+0x22>
  for(i=0; i+1 < max; ){
 216:	89a6                	mv	s3,s1
 218:	a011                	j	21c <gets+0x56>
 21a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 21c:	99de                	add	s3,s3,s7
 21e:	00098023          	sb	zero,0(s3)
  return buf;
}
 222:	855e                	mv	a0,s7
 224:	60e6                	ld	ra,88(sp)
 226:	6446                	ld	s0,80(sp)
 228:	64a6                	ld	s1,72(sp)
 22a:	6906                	ld	s2,64(sp)
 22c:	79e2                	ld	s3,56(sp)
 22e:	7a42                	ld	s4,48(sp)
 230:	7aa2                	ld	s5,40(sp)
 232:	7b02                	ld	s6,32(sp)
 234:	6be2                	ld	s7,24(sp)
 236:	6125                	add	sp,sp,96
 238:	8082                	ret

000000000000023a <stat>:

int
stat(const char *n, struct stat *st)
{
 23a:	1101                	add	sp,sp,-32
 23c:	ec06                	sd	ra,24(sp)
 23e:	e822                	sd	s0,16(sp)
 240:	e426                	sd	s1,8(sp)
 242:	e04a                	sd	s2,0(sp)
 244:	1000                	add	s0,sp,32
 246:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 248:	4581                	li	a1,0
 24a:	00000097          	auipc	ra,0x0
 24e:	1ac080e7          	jalr	428(ra) # 3f6 <open>
  if(fd < 0)
 252:	02054563          	bltz	a0,27c <stat+0x42>
 256:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 258:	85ca                	mv	a1,s2
 25a:	00000097          	auipc	ra,0x0
 25e:	1b4080e7          	jalr	436(ra) # 40e <fstat>
 262:	892a                	mv	s2,a0
  close(fd);
 264:	8526                	mv	a0,s1
 266:	00000097          	auipc	ra,0x0
 26a:	178080e7          	jalr	376(ra) # 3de <close>
  return r;
}
 26e:	854a                	mv	a0,s2
 270:	60e2                	ld	ra,24(sp)
 272:	6442                	ld	s0,16(sp)
 274:	64a2                	ld	s1,8(sp)
 276:	6902                	ld	s2,0(sp)
 278:	6105                	add	sp,sp,32
 27a:	8082                	ret
    return -1;
 27c:	597d                	li	s2,-1
 27e:	bfc5                	j	26e <stat+0x34>

0000000000000280 <atoi>:

int
atoi(const char *s)
{
 280:	1141                	add	sp,sp,-16
 282:	e422                	sd	s0,8(sp)
 284:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 286:	00054683          	lbu	a3,0(a0)
 28a:	fd06879b          	addw	a5,a3,-48
 28e:	0ff7f793          	zext.b	a5,a5
 292:	4625                	li	a2,9
 294:	02f66863          	bltu	a2,a5,2c4 <atoi+0x44>
 298:	872a                	mv	a4,a0
  n = 0;
 29a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 29c:	0705                	add	a4,a4,1
 29e:	0025179b          	sllw	a5,a0,0x2
 2a2:	9fa9                	addw	a5,a5,a0
 2a4:	0017979b          	sllw	a5,a5,0x1
 2a8:	9fb5                	addw	a5,a5,a3
 2aa:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2ae:	00074683          	lbu	a3,0(a4)
 2b2:	fd06879b          	addw	a5,a3,-48
 2b6:	0ff7f793          	zext.b	a5,a5
 2ba:	fef671e3          	bgeu	a2,a5,29c <atoi+0x1c>
  return n;
}
 2be:	6422                	ld	s0,8(sp)
 2c0:	0141                	add	sp,sp,16
 2c2:	8082                	ret
  n = 0;
 2c4:	4501                	li	a0,0
 2c6:	bfe5                	j	2be <atoi+0x3e>

00000000000002c8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2c8:	1141                	add	sp,sp,-16
 2ca:	e422                	sd	s0,8(sp)
 2cc:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2ce:	02b57463          	bgeu	a0,a1,2f6 <memmove+0x2e>
    while(n-- > 0)
 2d2:	00c05f63          	blez	a2,2f0 <memmove+0x28>
 2d6:	1602                	sll	a2,a2,0x20
 2d8:	9201                	srl	a2,a2,0x20
 2da:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2de:	872a                	mv	a4,a0
      *dst++ = *src++;
 2e0:	0585                	add	a1,a1,1
 2e2:	0705                	add	a4,a4,1
 2e4:	fff5c683          	lbu	a3,-1(a1)
 2e8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2ec:	fee79ae3          	bne	a5,a4,2e0 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2f0:	6422                	ld	s0,8(sp)
 2f2:	0141                	add	sp,sp,16
 2f4:	8082                	ret
    dst += n;
 2f6:	00c50733          	add	a4,a0,a2
    src += n;
 2fa:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2fc:	fec05ae3          	blez	a2,2f0 <memmove+0x28>
 300:	fff6079b          	addw	a5,a2,-1
 304:	1782                	sll	a5,a5,0x20
 306:	9381                	srl	a5,a5,0x20
 308:	fff7c793          	not	a5,a5
 30c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 30e:	15fd                	add	a1,a1,-1
 310:	177d                	add	a4,a4,-1
 312:	0005c683          	lbu	a3,0(a1)
 316:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 31a:	fee79ae3          	bne	a5,a4,30e <memmove+0x46>
 31e:	bfc9                	j	2f0 <memmove+0x28>

0000000000000320 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 320:	1141                	add	sp,sp,-16
 322:	e422                	sd	s0,8(sp)
 324:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 326:	ca05                	beqz	a2,356 <memcmp+0x36>
 328:	fff6069b          	addw	a3,a2,-1
 32c:	1682                	sll	a3,a3,0x20
 32e:	9281                	srl	a3,a3,0x20
 330:	0685                	add	a3,a3,1
 332:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 334:	00054783          	lbu	a5,0(a0)
 338:	0005c703          	lbu	a4,0(a1)
 33c:	00e79863          	bne	a5,a4,34c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 340:	0505                	add	a0,a0,1
    p2++;
 342:	0585                	add	a1,a1,1
  while (n-- > 0) {
 344:	fed518e3          	bne	a0,a3,334 <memcmp+0x14>
  }
  return 0;
 348:	4501                	li	a0,0
 34a:	a019                	j	350 <memcmp+0x30>
      return *p1 - *p2;
 34c:	40e7853b          	subw	a0,a5,a4
}
 350:	6422                	ld	s0,8(sp)
 352:	0141                	add	sp,sp,16
 354:	8082                	ret
  return 0;
 356:	4501                	li	a0,0
 358:	bfe5                	j	350 <memcmp+0x30>

000000000000035a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 35a:	1141                	add	sp,sp,-16
 35c:	e406                	sd	ra,8(sp)
 35e:	e022                	sd	s0,0(sp)
 360:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 362:	00000097          	auipc	ra,0x0
 366:	f66080e7          	jalr	-154(ra) # 2c8 <memmove>
}
 36a:	60a2                	ld	ra,8(sp)
 36c:	6402                	ld	s0,0(sp)
 36e:	0141                	add	sp,sp,16
 370:	8082                	ret

0000000000000372 <initlock>:

// Initialize the spinlock
void initlock(struct spinlock_u *lk) {
 372:	1141                	add	sp,sp,-16
 374:	e422                	sd	s0,8(sp)
 376:	0800                	add	s0,sp,16
  lk->locked = 0;
 378:	00052023          	sw	zero,0(a0)
}
 37c:	6422                	ld	s0,8(sp)
 37e:	0141                	add	sp,sp,16
 380:	8082                	ret

0000000000000382 <acquire>:

// Acquire the spinlock
void acquire(struct spinlock_u *lk) {
 382:	1141                	add	sp,sp,-16
 384:	e422                	sd	s0,8(sp)
 386:	0800                	add	s0,sp,16
  while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 388:	4705                	li	a4,1
 38a:	87ba                	mv	a5,a4
 38c:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
 390:	2781                	sext.w	a5,a5
 392:	ffe5                	bnez	a5,38a <acquire+0x8>
    ; // Spin until the lock is acquired
}
 394:	6422                	ld	s0,8(sp)
 396:	0141                	add	sp,sp,16
 398:	8082                	ret

000000000000039a <release>:

// Release the spinlock
void release(struct spinlock_u *lk) {
 39a:	1141                	add	sp,sp,-16
 39c:	e422                	sd	s0,8(sp)
 39e:	0800                	add	s0,sp,16
  __sync_lock_release(&lk->locked);
 3a0:	0f50000f          	fence	iorw,ow
 3a4:	0805202f          	amoswap.w	zero,zero,(a0)
}
 3a8:	6422                	ld	s0,8(sp)
 3aa:	0141                	add	sp,sp,16
 3ac:	8082                	ret

00000000000003ae <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3ae:	4885                	li	a7,1
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3b6:	4889                	li	a7,2
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <wait>:
.global wait
wait:
 li a7, SYS_wait
 3be:	488d                	li	a7,3
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3c6:	4891                	li	a7,4
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <read>:
.global read
read:
 li a7, SYS_read
 3ce:	4895                	li	a7,5
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <write>:
.global write
write:
 li a7, SYS_write
 3d6:	48c1                	li	a7,16
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <close>:
.global close
close:
 li a7, SYS_close
 3de:	48d5                	li	a7,21
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3e6:	4899                	li	a7,6
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <exec>:
.global exec
exec:
 li a7, SYS_exec
 3ee:	489d                	li	a7,7
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <open>:
.global open
open:
 li a7, SYS_open
 3f6:	48bd                	li	a7,15
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3fe:	48c5                	li	a7,17
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 406:	48c9                	li	a7,18
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 40e:	48a1                	li	a7,8
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <link>:
.global link
link:
 li a7, SYS_link
 416:	48cd                	li	a7,19
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 41e:	48d1                	li	a7,20
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 426:	48a5                	li	a7,9
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <dup>:
.global dup
dup:
 li a7, SYS_dup
 42e:	48a9                	li	a7,10
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 436:	48ad                	li	a7,11
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 43e:	48b1                	li	a7,12
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 446:	48b5                	li	a7,13
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 44e:	48b9                	li	a7,14
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <rcureadlock>:
.global rcureadlock
rcureadlock:
 li a7, SYS_rcureadlock
 456:	48dd                	li	a7,23
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <rcureadunlock>:
.global rcureadunlock
rcureadunlock:
 li a7, SYS_rcureadunlock
 45e:	48e1                	li	a7,24
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <rcusync>:
.global rcusync
rcusync:
 li a7, SYS_rcusync
 466:	48d9                	li	a7,22
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <thread_create>:
.global thread_create
thread_create:
 li a7, SYS_thread_create
 46e:	48e5                	li	a7,25
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <thread_join>:
.global thread_join
thread_join:
 li a7, SYS_thread_join
 476:	48e9                	li	a7,26
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <thread_exit>:
.global thread_exit
thread_exit:
 li a7, SYS_thread_exit
 47e:	48ed                	li	a7,27
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <klist_insert>:
.global klist_insert
klist_insert:
 li a7, SYS_klist_insert
 486:	48f1                	li	a7,28
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <klist_delete>:
.global klist_delete
klist_delete:
 li a7, SYS_klist_delete
 48e:	48f5                	li	a7,29
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <klist_query>:
.global klist_query
klist_query:
 li a7, SYS_klist_query
 496:	48f9                	li	a7,30
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <klist_print>:
.global klist_print
klist_print:
 li a7, SYS_klist_print
 49e:	48fd                	li	a7,31
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4a6:	1101                	add	sp,sp,-32
 4a8:	ec06                	sd	ra,24(sp)
 4aa:	e822                	sd	s0,16(sp)
 4ac:	1000                	add	s0,sp,32
 4ae:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4b2:	4605                	li	a2,1
 4b4:	fef40593          	add	a1,s0,-17
 4b8:	00000097          	auipc	ra,0x0
 4bc:	f1e080e7          	jalr	-226(ra) # 3d6 <write>
}
 4c0:	60e2                	ld	ra,24(sp)
 4c2:	6442                	ld	s0,16(sp)
 4c4:	6105                	add	sp,sp,32
 4c6:	8082                	ret

00000000000004c8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4c8:	7139                	add	sp,sp,-64
 4ca:	fc06                	sd	ra,56(sp)
 4cc:	f822                	sd	s0,48(sp)
 4ce:	f426                	sd	s1,40(sp)
 4d0:	f04a                	sd	s2,32(sp)
 4d2:	ec4e                	sd	s3,24(sp)
 4d4:	0080                	add	s0,sp,64
 4d6:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4d8:	c299                	beqz	a3,4de <printint+0x16>
 4da:	0805c963          	bltz	a1,56c <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4de:	2581                	sext.w	a1,a1
  neg = 0;
 4e0:	4881                	li	a7,0
 4e2:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 4e6:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4e8:	2601                	sext.w	a2,a2
 4ea:	00000517          	auipc	a0,0x0
 4ee:	61650513          	add	a0,a0,1558 # b00 <digits>
 4f2:	883a                	mv	a6,a4
 4f4:	2705                	addw	a4,a4,1
 4f6:	02c5f7bb          	remuw	a5,a1,a2
 4fa:	1782                	sll	a5,a5,0x20
 4fc:	9381                	srl	a5,a5,0x20
 4fe:	97aa                	add	a5,a5,a0
 500:	0007c783          	lbu	a5,0(a5)
 504:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 508:	0005879b          	sext.w	a5,a1
 50c:	02c5d5bb          	divuw	a1,a1,a2
 510:	0685                	add	a3,a3,1
 512:	fec7f0e3          	bgeu	a5,a2,4f2 <printint+0x2a>
  if(neg)
 516:	00088c63          	beqz	a7,52e <printint+0x66>
    buf[i++] = '-';
 51a:	fd070793          	add	a5,a4,-48
 51e:	00878733          	add	a4,a5,s0
 522:	02d00793          	li	a5,45
 526:	fef70823          	sb	a5,-16(a4)
 52a:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 52e:	02e05863          	blez	a4,55e <printint+0x96>
 532:	fc040793          	add	a5,s0,-64
 536:	00e78933          	add	s2,a5,a4
 53a:	fff78993          	add	s3,a5,-1
 53e:	99ba                	add	s3,s3,a4
 540:	377d                	addw	a4,a4,-1
 542:	1702                	sll	a4,a4,0x20
 544:	9301                	srl	a4,a4,0x20
 546:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 54a:	fff94583          	lbu	a1,-1(s2)
 54e:	8526                	mv	a0,s1
 550:	00000097          	auipc	ra,0x0
 554:	f56080e7          	jalr	-170(ra) # 4a6 <putc>
  while(--i >= 0)
 558:	197d                	add	s2,s2,-1
 55a:	ff3918e3          	bne	s2,s3,54a <printint+0x82>
}
 55e:	70e2                	ld	ra,56(sp)
 560:	7442                	ld	s0,48(sp)
 562:	74a2                	ld	s1,40(sp)
 564:	7902                	ld	s2,32(sp)
 566:	69e2                	ld	s3,24(sp)
 568:	6121                	add	sp,sp,64
 56a:	8082                	ret
    x = -xx;
 56c:	40b005bb          	negw	a1,a1
    neg = 1;
 570:	4885                	li	a7,1
    x = -xx;
 572:	bf85                	j	4e2 <printint+0x1a>

0000000000000574 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 574:	715d                	add	sp,sp,-80
 576:	e486                	sd	ra,72(sp)
 578:	e0a2                	sd	s0,64(sp)
 57a:	fc26                	sd	s1,56(sp)
 57c:	f84a                	sd	s2,48(sp)
 57e:	f44e                	sd	s3,40(sp)
 580:	f052                	sd	s4,32(sp)
 582:	ec56                	sd	s5,24(sp)
 584:	e85a                	sd	s6,16(sp)
 586:	e45e                	sd	s7,8(sp)
 588:	e062                	sd	s8,0(sp)
 58a:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 58c:	0005c903          	lbu	s2,0(a1)
 590:	18090c63          	beqz	s2,728 <vprintf+0x1b4>
 594:	8aaa                	mv	s5,a0
 596:	8bb2                	mv	s7,a2
 598:	00158493          	add	s1,a1,1
  state = 0;
 59c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 59e:	02500a13          	li	s4,37
 5a2:	4b55                	li	s6,21
 5a4:	a839                	j	5c2 <vprintf+0x4e>
        putc(fd, c);
 5a6:	85ca                	mv	a1,s2
 5a8:	8556                	mv	a0,s5
 5aa:	00000097          	auipc	ra,0x0
 5ae:	efc080e7          	jalr	-260(ra) # 4a6 <putc>
 5b2:	a019                	j	5b8 <vprintf+0x44>
    } else if(state == '%'){
 5b4:	01498d63          	beq	s3,s4,5ce <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 5b8:	0485                	add	s1,s1,1
 5ba:	fff4c903          	lbu	s2,-1(s1)
 5be:	16090563          	beqz	s2,728 <vprintf+0x1b4>
    if(state == 0){
 5c2:	fe0999e3          	bnez	s3,5b4 <vprintf+0x40>
      if(c == '%'){
 5c6:	ff4910e3          	bne	s2,s4,5a6 <vprintf+0x32>
        state = '%';
 5ca:	89d2                	mv	s3,s4
 5cc:	b7f5                	j	5b8 <vprintf+0x44>
      if(c == 'd'){
 5ce:	13490263          	beq	s2,s4,6f2 <vprintf+0x17e>
 5d2:	f9d9079b          	addw	a5,s2,-99
 5d6:	0ff7f793          	zext.b	a5,a5
 5da:	12fb6563          	bltu	s6,a5,704 <vprintf+0x190>
 5de:	f9d9079b          	addw	a5,s2,-99
 5e2:	0ff7f713          	zext.b	a4,a5
 5e6:	10eb6f63          	bltu	s6,a4,704 <vprintf+0x190>
 5ea:	00271793          	sll	a5,a4,0x2
 5ee:	00000717          	auipc	a4,0x0
 5f2:	4ba70713          	add	a4,a4,1210 # aa8 <updateNode+0x58>
 5f6:	97ba                	add	a5,a5,a4
 5f8:	439c                	lw	a5,0(a5)
 5fa:	97ba                	add	a5,a5,a4
 5fc:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 5fe:	008b8913          	add	s2,s7,8
 602:	4685                	li	a3,1
 604:	4629                	li	a2,10
 606:	000ba583          	lw	a1,0(s7)
 60a:	8556                	mv	a0,s5
 60c:	00000097          	auipc	ra,0x0
 610:	ebc080e7          	jalr	-324(ra) # 4c8 <printint>
 614:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 616:	4981                	li	s3,0
 618:	b745                	j	5b8 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 61a:	008b8913          	add	s2,s7,8
 61e:	4681                	li	a3,0
 620:	4629                	li	a2,10
 622:	000ba583          	lw	a1,0(s7)
 626:	8556                	mv	a0,s5
 628:	00000097          	auipc	ra,0x0
 62c:	ea0080e7          	jalr	-352(ra) # 4c8 <printint>
 630:	8bca                	mv	s7,s2
      state = 0;
 632:	4981                	li	s3,0
 634:	b751                	j	5b8 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 636:	008b8913          	add	s2,s7,8
 63a:	4681                	li	a3,0
 63c:	4641                	li	a2,16
 63e:	000ba583          	lw	a1,0(s7)
 642:	8556                	mv	a0,s5
 644:	00000097          	auipc	ra,0x0
 648:	e84080e7          	jalr	-380(ra) # 4c8 <printint>
 64c:	8bca                	mv	s7,s2
      state = 0;
 64e:	4981                	li	s3,0
 650:	b7a5                	j	5b8 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 652:	008b8c13          	add	s8,s7,8
 656:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 65a:	03000593          	li	a1,48
 65e:	8556                	mv	a0,s5
 660:	00000097          	auipc	ra,0x0
 664:	e46080e7          	jalr	-442(ra) # 4a6 <putc>
  putc(fd, 'x');
 668:	07800593          	li	a1,120
 66c:	8556                	mv	a0,s5
 66e:	00000097          	auipc	ra,0x0
 672:	e38080e7          	jalr	-456(ra) # 4a6 <putc>
 676:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 678:	00000b97          	auipc	s7,0x0
 67c:	488b8b93          	add	s7,s7,1160 # b00 <digits>
 680:	03c9d793          	srl	a5,s3,0x3c
 684:	97de                	add	a5,a5,s7
 686:	0007c583          	lbu	a1,0(a5)
 68a:	8556                	mv	a0,s5
 68c:	00000097          	auipc	ra,0x0
 690:	e1a080e7          	jalr	-486(ra) # 4a6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 694:	0992                	sll	s3,s3,0x4
 696:	397d                	addw	s2,s2,-1
 698:	fe0914e3          	bnez	s2,680 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 69c:	8be2                	mv	s7,s8
      state = 0;
 69e:	4981                	li	s3,0
 6a0:	bf21                	j	5b8 <vprintf+0x44>
        s = va_arg(ap, char*);
 6a2:	008b8993          	add	s3,s7,8
 6a6:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 6aa:	02090163          	beqz	s2,6cc <vprintf+0x158>
        while(*s != 0){
 6ae:	00094583          	lbu	a1,0(s2)
 6b2:	c9a5                	beqz	a1,722 <vprintf+0x1ae>
          putc(fd, *s);
 6b4:	8556                	mv	a0,s5
 6b6:	00000097          	auipc	ra,0x0
 6ba:	df0080e7          	jalr	-528(ra) # 4a6 <putc>
          s++;
 6be:	0905                	add	s2,s2,1
        while(*s != 0){
 6c0:	00094583          	lbu	a1,0(s2)
 6c4:	f9e5                	bnez	a1,6b4 <vprintf+0x140>
        s = va_arg(ap, char*);
 6c6:	8bce                	mv	s7,s3
      state = 0;
 6c8:	4981                	li	s3,0
 6ca:	b5fd                	j	5b8 <vprintf+0x44>
          s = "(null)";
 6cc:	00000917          	auipc	s2,0x0
 6d0:	3d490913          	add	s2,s2,980 # aa0 <updateNode+0x50>
        while(*s != 0){
 6d4:	02800593          	li	a1,40
 6d8:	bff1                	j	6b4 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 6da:	008b8913          	add	s2,s7,8
 6de:	000bc583          	lbu	a1,0(s7)
 6e2:	8556                	mv	a0,s5
 6e4:	00000097          	auipc	ra,0x0
 6e8:	dc2080e7          	jalr	-574(ra) # 4a6 <putc>
 6ec:	8bca                	mv	s7,s2
      state = 0;
 6ee:	4981                	li	s3,0
 6f0:	b5e1                	j	5b8 <vprintf+0x44>
        putc(fd, c);
 6f2:	02500593          	li	a1,37
 6f6:	8556                	mv	a0,s5
 6f8:	00000097          	auipc	ra,0x0
 6fc:	dae080e7          	jalr	-594(ra) # 4a6 <putc>
      state = 0;
 700:	4981                	li	s3,0
 702:	bd5d                	j	5b8 <vprintf+0x44>
        putc(fd, '%');
 704:	02500593          	li	a1,37
 708:	8556                	mv	a0,s5
 70a:	00000097          	auipc	ra,0x0
 70e:	d9c080e7          	jalr	-612(ra) # 4a6 <putc>
        putc(fd, c);
 712:	85ca                	mv	a1,s2
 714:	8556                	mv	a0,s5
 716:	00000097          	auipc	ra,0x0
 71a:	d90080e7          	jalr	-624(ra) # 4a6 <putc>
      state = 0;
 71e:	4981                	li	s3,0
 720:	bd61                	j	5b8 <vprintf+0x44>
        s = va_arg(ap, char*);
 722:	8bce                	mv	s7,s3
      state = 0;
 724:	4981                	li	s3,0
 726:	bd49                	j	5b8 <vprintf+0x44>
    }
  }
}
 728:	60a6                	ld	ra,72(sp)
 72a:	6406                	ld	s0,64(sp)
 72c:	74e2                	ld	s1,56(sp)
 72e:	7942                	ld	s2,48(sp)
 730:	79a2                	ld	s3,40(sp)
 732:	7a02                	ld	s4,32(sp)
 734:	6ae2                	ld	s5,24(sp)
 736:	6b42                	ld	s6,16(sp)
 738:	6ba2                	ld	s7,8(sp)
 73a:	6c02                	ld	s8,0(sp)
 73c:	6161                	add	sp,sp,80
 73e:	8082                	ret

0000000000000740 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 740:	715d                	add	sp,sp,-80
 742:	ec06                	sd	ra,24(sp)
 744:	e822                	sd	s0,16(sp)
 746:	1000                	add	s0,sp,32
 748:	e010                	sd	a2,0(s0)
 74a:	e414                	sd	a3,8(s0)
 74c:	e818                	sd	a4,16(s0)
 74e:	ec1c                	sd	a5,24(s0)
 750:	03043023          	sd	a6,32(s0)
 754:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 758:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 75c:	8622                	mv	a2,s0
 75e:	00000097          	auipc	ra,0x0
 762:	e16080e7          	jalr	-490(ra) # 574 <vprintf>
}
 766:	60e2                	ld	ra,24(sp)
 768:	6442                	ld	s0,16(sp)
 76a:	6161                	add	sp,sp,80
 76c:	8082                	ret

000000000000076e <printf>:

void
printf(const char *fmt, ...)
{
 76e:	711d                	add	sp,sp,-96
 770:	ec06                	sd	ra,24(sp)
 772:	e822                	sd	s0,16(sp)
 774:	1000                	add	s0,sp,32
 776:	e40c                	sd	a1,8(s0)
 778:	e810                	sd	a2,16(s0)
 77a:	ec14                	sd	a3,24(s0)
 77c:	f018                	sd	a4,32(s0)
 77e:	f41c                	sd	a5,40(s0)
 780:	03043823          	sd	a6,48(s0)
 784:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 788:	00840613          	add	a2,s0,8
 78c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 790:	85aa                	mv	a1,a0
 792:	4505                	li	a0,1
 794:	00000097          	auipc	ra,0x0
 798:	de0080e7          	jalr	-544(ra) # 574 <vprintf>
}
 79c:	60e2                	ld	ra,24(sp)
 79e:	6442                	ld	s0,16(sp)
 7a0:	6125                	add	sp,sp,96
 7a2:	8082                	ret

00000000000007a4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a4:	1141                	add	sp,sp,-16
 7a6:	e422                	sd	s0,8(sp)
 7a8:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7aa:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ae:	00001797          	auipc	a5,0x1
 7b2:	8527b783          	ld	a5,-1966(a5) # 1000 <freep>
 7b6:	a02d                	j	7e0 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7b8:	4618                	lw	a4,8(a2)
 7ba:	9f2d                	addw	a4,a4,a1
 7bc:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7c0:	6398                	ld	a4,0(a5)
 7c2:	6310                	ld	a2,0(a4)
 7c4:	a83d                	j	802 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7c6:	ff852703          	lw	a4,-8(a0)
 7ca:	9f31                	addw	a4,a4,a2
 7cc:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7ce:	ff053683          	ld	a3,-16(a0)
 7d2:	a091                	j	816 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d4:	6398                	ld	a4,0(a5)
 7d6:	00e7e463          	bltu	a5,a4,7de <free+0x3a>
 7da:	00e6ea63          	bltu	a3,a4,7ee <free+0x4a>
{
 7de:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e0:	fed7fae3          	bgeu	a5,a3,7d4 <free+0x30>
 7e4:	6398                	ld	a4,0(a5)
 7e6:	00e6e463          	bltu	a3,a4,7ee <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ea:	fee7eae3          	bltu	a5,a4,7de <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 7ee:	ff852583          	lw	a1,-8(a0)
 7f2:	6390                	ld	a2,0(a5)
 7f4:	02059813          	sll	a6,a1,0x20
 7f8:	01c85713          	srl	a4,a6,0x1c
 7fc:	9736                	add	a4,a4,a3
 7fe:	fae60de3          	beq	a2,a4,7b8 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 802:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 806:	4790                	lw	a2,8(a5)
 808:	02061593          	sll	a1,a2,0x20
 80c:	01c5d713          	srl	a4,a1,0x1c
 810:	973e                	add	a4,a4,a5
 812:	fae68ae3          	beq	a3,a4,7c6 <free+0x22>
    p->s.ptr = bp->s.ptr;
 816:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 818:	00000717          	auipc	a4,0x0
 81c:	7ef73423          	sd	a5,2024(a4) # 1000 <freep>
}
 820:	6422                	ld	s0,8(sp)
 822:	0141                	add	sp,sp,16
 824:	8082                	ret

0000000000000826 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 826:	7139                	add	sp,sp,-64
 828:	fc06                	sd	ra,56(sp)
 82a:	f822                	sd	s0,48(sp)
 82c:	f426                	sd	s1,40(sp)
 82e:	f04a                	sd	s2,32(sp)
 830:	ec4e                	sd	s3,24(sp)
 832:	e852                	sd	s4,16(sp)
 834:	e456                	sd	s5,8(sp)
 836:	e05a                	sd	s6,0(sp)
 838:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 83a:	02051493          	sll	s1,a0,0x20
 83e:	9081                	srl	s1,s1,0x20
 840:	04bd                	add	s1,s1,15
 842:	8091                	srl	s1,s1,0x4
 844:	0014899b          	addw	s3,s1,1
 848:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 84a:	00000517          	auipc	a0,0x0
 84e:	7b653503          	ld	a0,1974(a0) # 1000 <freep>
 852:	c515                	beqz	a0,87e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 854:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 856:	4798                	lw	a4,8(a5)
 858:	02977f63          	bgeu	a4,s1,896 <malloc+0x70>
  if(nu < 4096)
 85c:	8a4e                	mv	s4,s3
 85e:	0009871b          	sext.w	a4,s3
 862:	6685                	lui	a3,0x1
 864:	00d77363          	bgeu	a4,a3,86a <malloc+0x44>
 868:	6a05                	lui	s4,0x1
 86a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 86e:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 872:	00000917          	auipc	s2,0x0
 876:	78e90913          	add	s2,s2,1934 # 1000 <freep>
  if(p == (char*)-1)
 87a:	5afd                	li	s5,-1
 87c:	a895                	j	8f0 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 87e:	00000797          	auipc	a5,0x0
 882:	79278793          	add	a5,a5,1938 # 1010 <base>
 886:	00000717          	auipc	a4,0x0
 88a:	76f73d23          	sd	a5,1914(a4) # 1000 <freep>
 88e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 890:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 894:	b7e1                	j	85c <malloc+0x36>
      if(p->s.size == nunits)
 896:	02e48c63          	beq	s1,a4,8ce <malloc+0xa8>
        p->s.size -= nunits;
 89a:	4137073b          	subw	a4,a4,s3
 89e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8a0:	02071693          	sll	a3,a4,0x20
 8a4:	01c6d713          	srl	a4,a3,0x1c
 8a8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8aa:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8ae:	00000717          	auipc	a4,0x0
 8b2:	74a73923          	sd	a0,1874(a4) # 1000 <freep>
      return (void*)(p + 1);
 8b6:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8ba:	70e2                	ld	ra,56(sp)
 8bc:	7442                	ld	s0,48(sp)
 8be:	74a2                	ld	s1,40(sp)
 8c0:	7902                	ld	s2,32(sp)
 8c2:	69e2                	ld	s3,24(sp)
 8c4:	6a42                	ld	s4,16(sp)
 8c6:	6aa2                	ld	s5,8(sp)
 8c8:	6b02                	ld	s6,0(sp)
 8ca:	6121                	add	sp,sp,64
 8cc:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8ce:	6398                	ld	a4,0(a5)
 8d0:	e118                	sd	a4,0(a0)
 8d2:	bff1                	j	8ae <malloc+0x88>
  hp->s.size = nu;
 8d4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8d8:	0541                	add	a0,a0,16
 8da:	00000097          	auipc	ra,0x0
 8de:	eca080e7          	jalr	-310(ra) # 7a4 <free>
  return freep;
 8e2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8e6:	d971                	beqz	a0,8ba <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ea:	4798                	lw	a4,8(a5)
 8ec:	fa9775e3          	bgeu	a4,s1,896 <malloc+0x70>
    if(p == freep)
 8f0:	00093703          	ld	a4,0(s2)
 8f4:	853e                	mv	a0,a5
 8f6:	fef719e3          	bne	a4,a5,8e8 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 8fa:	8552                	mv	a0,s4
 8fc:	00000097          	auipc	ra,0x0
 900:	b42080e7          	jalr	-1214(ra) # 43e <sbrk>
  if(p == (char*)-1)
 904:	fd5518e3          	bne	a0,s5,8d4 <malloc+0xae>
        return 0;
 908:	4501                	li	a0,0
 90a:	bf45                	j	8ba <malloc+0x94>

000000000000090c <init_lock>:
#include "linkedlist.h"

// Define a node structure for the linked list
struct spinlock_u list_lock;

void init_lock(){
 90c:	1141                	add	sp,sp,-16
 90e:	e406                	sd	ra,8(sp)
 910:	e022                	sd	s0,0(sp)
 912:	0800                	add	s0,sp,16
    initlock(&list_lock);
 914:	00000517          	auipc	a0,0x0
 918:	6f450513          	add	a0,a0,1780 # 1008 <list_lock>
 91c:	00000097          	auipc	ra,0x0
 920:	a56080e7          	jalr	-1450(ra) # 372 <initlock>
}
 924:	60a2                	ld	ra,8(sp)
 926:	6402                	ld	s0,0(sp)
 928:	0141                	add	sp,sp,16
 92a:	8082                	ret

000000000000092c <insert>:

// Function to insert a node at the beginning of the linked list
void insert(struct Node **head_ref, int new_data) {
 92c:	1101                	add	sp,sp,-32
 92e:	ec06                	sd	ra,24(sp)
 930:	e822                	sd	s0,16(sp)
 932:	e426                	sd	s1,8(sp)
 934:	e04a                	sd	s2,0(sp)
 936:	1000                	add	s0,sp,32
 938:	84aa                	mv	s1,a0
 93a:	892e                	mv	s2,a1
    struct Node *new_node = malloc(sizeof(struct Node));
 93c:	4541                	li	a0,16
 93e:	00000097          	auipc	ra,0x0
 942:	ee8080e7          	jalr	-280(ra) # 826 <malloc>
    new_node->data = new_data;
 946:	01252023          	sw	s2,0(a0)
    new_node->next = *head_ref;
 94a:	609c                	ld	a5,0(s1)
 94c:	e51c                	sd	a5,8(a0)
    *head_ref = new_node;
 94e:	e088                	sd	a0,0(s1)
}
 950:	60e2                	ld	ra,24(sp)
 952:	6442                	ld	s0,16(sp)
 954:	64a2                	ld	s1,8(sp)
 956:	6902                	ld	s2,0(sp)
 958:	6105                	add	sp,sp,32
 95a:	8082                	ret

000000000000095c <deleteNode>:

// Function to delete a node with a given key from the linked list
void deleteNode(struct Node **head_ref, int key) {
 95c:	7179                	add	sp,sp,-48
 95e:	f406                	sd	ra,40(sp)
 960:	f022                	sd	s0,32(sp)
 962:	ec26                	sd	s1,24(sp)
 964:	e84a                	sd	s2,16(sp)
 966:	e44e                	sd	s3,8(sp)
 968:	1800                	add	s0,sp,48
 96a:	89aa                	mv	s3,a0
 96c:	892e                	mv	s2,a1
    struct Node *temp = *head_ref, *prev = 0;
 96e:	6104                	ld	s1,0(a0)

    acquire(&list_lock);
 970:	00000517          	auipc	a0,0x0
 974:	69850513          	add	a0,a0,1688 # 1008 <list_lock>
 978:	00000097          	auipc	ra,0x0
 97c:	a0a080e7          	jalr	-1526(ra) # 382 <acquire>
    if (temp != 0 && temp->data == key) {
 980:	c0b1                	beqz	s1,9c4 <deleteNode+0x68>
 982:	409c                	lw	a5,0(s1)
 984:	4701                	li	a4,0
 986:	01278a63          	beq	a5,s2,99a <deleteNode+0x3e>
        rcusync();
        free(temp);
        return;
    }

    while (temp != 0 && temp->data != key) {
 98a:	409c                	lw	a5,0(s1)
 98c:	05278563          	beq	a5,s2,9d6 <deleteNode+0x7a>
        prev = temp;
        temp = temp->next;
 990:	649c                	ld	a5,8(s1)
    while (temp != 0 && temp->data != key) {
 992:	8726                	mv	a4,s1
 994:	cb85                	beqz	a5,9c4 <deleteNode+0x68>
        temp = temp->next;
 996:	84be                	mv	s1,a5
 998:	bfcd                	j	98a <deleteNode+0x2e>
        *head_ref = temp->next;
 99a:	649c                	ld	a5,8(s1)
 99c:	00f9b023          	sd	a5,0(s3)
        release(&list_lock);
 9a0:	00000517          	auipc	a0,0x0
 9a4:	66850513          	add	a0,a0,1640 # 1008 <list_lock>
 9a8:	00000097          	auipc	ra,0x0
 9ac:	9f2080e7          	jalr	-1550(ra) # 39a <release>
        rcusync();
 9b0:	00000097          	auipc	ra,0x0
 9b4:	ab6080e7          	jalr	-1354(ra) # 466 <rcusync>
        free(temp);
 9b8:	8526                	mv	a0,s1
 9ba:	00000097          	auipc	ra,0x0
 9be:	dea080e7          	jalr	-534(ra) # 7a4 <free>
        return;
 9c2:	a82d                	j	9fc <deleteNode+0xa0>
    }

    if (temp == 0) {
        release(&list_lock);
 9c4:	00000517          	auipc	a0,0x0
 9c8:	64450513          	add	a0,a0,1604 # 1008 <list_lock>
 9cc:	00000097          	auipc	ra,0x0
 9d0:	9ce080e7          	jalr	-1586(ra) # 39a <release>
        return;
 9d4:	a025                	j	9fc <deleteNode+0xa0>
    }
    prev->next = temp->next;
 9d6:	649c                	ld	a5,8(s1)
 9d8:	e71c                	sd	a5,8(a4)
    release(&list_lock);
 9da:	00000517          	auipc	a0,0x0
 9de:	62e50513          	add	a0,a0,1582 # 1008 <list_lock>
 9e2:	00000097          	auipc	ra,0x0
 9e6:	9b8080e7          	jalr	-1608(ra) # 39a <release>
    rcusync();
 9ea:	00000097          	auipc	ra,0x0
 9ee:	a7c080e7          	jalr	-1412(ra) # 466 <rcusync>
    free(temp);
 9f2:	8526                	mv	a0,s1
 9f4:	00000097          	auipc	ra,0x0
 9f8:	db0080e7          	jalr	-592(ra) # 7a4 <free>
}
 9fc:	70a2                	ld	ra,40(sp)
 9fe:	7402                	ld	s0,32(sp)
 a00:	64e2                	ld	s1,24(sp)
 a02:	6942                	ld	s2,16(sp)
 a04:	69a2                	ld	s3,8(sp)
 a06:	6145                	add	sp,sp,48
 a08:	8082                	ret

0000000000000a0a <search>:

// Function to search for a node with a given key in the linked list
struct Node* search(struct Node *head, int key) {
 a0a:	1101                	add	sp,sp,-32
 a0c:	ec06                	sd	ra,24(sp)
 a0e:	e822                	sd	s0,16(sp)
 a10:	e426                	sd	s1,8(sp)
 a12:	e04a                	sd	s2,0(sp)
 a14:	1000                	add	s0,sp,32
 a16:	84aa                	mv	s1,a0
 a18:	892e                	mv	s2,a1

    struct Node *current = head;
    rcureadlock();
 a1a:	00000097          	auipc	ra,0x0
 a1e:	a3c080e7          	jalr	-1476(ra) # 456 <rcureadlock>
    while (current != 0) {
 a22:	c491                	beqz	s1,a2e <search+0x24>
        if (current->data == key) {
 a24:	409c                	lw	a5,0(s1)
 a26:	01278f63          	beq	a5,s2,a44 <search+0x3a>
            rcureadunlock();
            return current; // Node found
        }
        current = current->next;
 a2a:	6484                	ld	s1,8(s1)
    while (current != 0) {
 a2c:	fce5                	bnez	s1,a24 <search+0x1a>
    }
    rcureadunlock();
 a2e:	00000097          	auipc	ra,0x0
 a32:	a30080e7          	jalr	-1488(ra) # 45e <rcureadunlock>
    return 0; // Node not found
 a36:	4501                	li	a0,0
}
 a38:	60e2                	ld	ra,24(sp)
 a3a:	6442                	ld	s0,16(sp)
 a3c:	64a2                	ld	s1,8(sp)
 a3e:	6902                	ld	s2,0(sp)
 a40:	6105                	add	sp,sp,32
 a42:	8082                	ret
            rcureadunlock();
 a44:	00000097          	auipc	ra,0x0
 a48:	a1a080e7          	jalr	-1510(ra) # 45e <rcureadunlock>
            return current; // Node found
 a4c:	8526                	mv	a0,s1
 a4e:	b7ed                	j	a38 <search+0x2e>

0000000000000a50 <updateNode>:

// Function to update the value of a node with a given key in the linked list
void updateNode(struct Node *head, int key, int new_data) {
 a50:	1101                	add	sp,sp,-32
 a52:	ec06                	sd	ra,24(sp)
 a54:	e822                	sd	s0,16(sp)
 a56:	e426                	sd	s1,8(sp)
 a58:	e04a                	sd	s2,0(sp)
 a5a:	1000                	add	s0,sp,32
 a5c:	892e                	mv	s2,a1
 a5e:	84b2                	mv	s1,a2
    struct Node *nodeToUpdate = search(head, key);
 a60:	00000097          	auipc	ra,0x0
 a64:	faa080e7          	jalr	-86(ra) # a0a <search>

    if (nodeToUpdate != 0) {
 a68:	c901                	beqz	a0,a78 <updateNode+0x28>
        nodeToUpdate->data = new_data; // Update the node's data
 a6a:	c104                	sw	s1,0(a0)
    } else {
        printf("Node with key %d not found.\n", key);
    }
}
 a6c:	60e2                	ld	ra,24(sp)
 a6e:	6442                	ld	s0,16(sp)
 a70:	64a2                	ld	s1,8(sp)
 a72:	6902                	ld	s2,0(sp)
 a74:	6105                	add	sp,sp,32
 a76:	8082                	ret
        printf("Node with key %d not found.\n", key);
 a78:	85ca                	mv	a1,s2
 a7a:	00000517          	auipc	a0,0x0
 a7e:	09e50513          	add	a0,a0,158 # b18 <digits+0x18>
 a82:	00000097          	auipc	ra,0x0
 a86:	cec080e7          	jalr	-788(ra) # 76e <printf>
}
 a8a:	b7cd                	j	a6c <updateNode+0x1c>
