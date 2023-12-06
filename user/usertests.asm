
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	1141                	add	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	add	s0,sp,16
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };

  for(int ai = 0; ai < 2; ai++){
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
       8:	20100593          	li	a1,513
       c:	4505                	li	a0,1
       e:	057e                	sll	a0,a0,0x1f
      10:	00006097          	auipc	ra,0x6
      14:	bfa080e7          	jalr	-1030(ra) # 5c0a <open>
    if(fd >= 0){
      18:	02055063          	bgez	a0,38 <copyinstr1+0x38>
    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      1c:	20100593          	li	a1,513
      20:	557d                	li	a0,-1
      22:	00006097          	auipc	ra,0x6
      26:	be8080e7          	jalr	-1048(ra) # 5c0a <open>
    uint64 addr = addrs[ai];
      2a:	55fd                	li	a1,-1
    if(fd >= 0){
      2c:	00055863          	bgez	a0,3c <copyinstr1+0x3c>
      printf("open(%p) returned %d, not -1\n", addr, fd);
      exit(1);
    }
  }
}
      30:	60a2                	ld	ra,8(sp)
      32:	6402                	ld	s0,0(sp)
      34:	0141                	add	sp,sp,16
      36:	8082                	ret
    uint64 addr = addrs[ai];
      38:	4585                	li	a1,1
      3a:	05fe                	sll	a1,a1,0x1f
      printf("open(%p) returned %d, not -1\n", addr, fd);
      3c:	862a                	mv	a2,a0
      3e:	00006517          	auipc	a0,0x6
      42:	26250513          	add	a0,a0,610 # 62a0 <updateNode+0x3c>
      46:	00006097          	auipc	ra,0x6
      4a:	f3c080e7          	jalr	-196(ra) # 5f82 <printf>
      exit(1);
      4e:	4505                	li	a0,1
      50:	00006097          	auipc	ra,0x6
      54:	b7a080e7          	jalr	-1158(ra) # 5bca <exit>

0000000000000058 <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
      58:	0000a797          	auipc	a5,0xa
      5c:	51078793          	add	a5,a5,1296 # a568 <uninit>
      60:	0000d697          	auipc	a3,0xd
      64:	c1868693          	add	a3,a3,-1000 # cc78 <buf>
    if(uninit[i] != '\0'){
      68:	0007c703          	lbu	a4,0(a5)
      6c:	e709                	bnez	a4,76 <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      6e:	0785                	add	a5,a5,1
      70:	fed79ce3          	bne	a5,a3,68 <bsstest+0x10>
      74:	8082                	ret
{
      76:	1141                	add	sp,sp,-16
      78:	e406                	sd	ra,8(sp)
      7a:	e022                	sd	s0,0(sp)
      7c:	0800                	add	s0,sp,16
      printf("%s: bss test failed\n", s);
      7e:	85aa                	mv	a1,a0
      80:	00006517          	auipc	a0,0x6
      84:	24050513          	add	a0,a0,576 # 62c0 <updateNode+0x5c>
      88:	00006097          	auipc	ra,0x6
      8c:	efa080e7          	jalr	-262(ra) # 5f82 <printf>
      exit(1);
      90:	4505                	li	a0,1
      92:	00006097          	auipc	ra,0x6
      96:	b38080e7          	jalr	-1224(ra) # 5bca <exit>

000000000000009a <opentest>:
{
      9a:	1101                	add	sp,sp,-32
      9c:	ec06                	sd	ra,24(sp)
      9e:	e822                	sd	s0,16(sp)
      a0:	e426                	sd	s1,8(sp)
      a2:	1000                	add	s0,sp,32
      a4:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      a6:	4581                	li	a1,0
      a8:	00006517          	auipc	a0,0x6
      ac:	23050513          	add	a0,a0,560 # 62d8 <updateNode+0x74>
      b0:	00006097          	auipc	ra,0x6
      b4:	b5a080e7          	jalr	-1190(ra) # 5c0a <open>
  if(fd < 0){
      b8:	02054663          	bltz	a0,e4 <opentest+0x4a>
  close(fd);
      bc:	00006097          	auipc	ra,0x6
      c0:	b36080e7          	jalr	-1226(ra) # 5bf2 <close>
  fd = open("doesnotexist", 0);
      c4:	4581                	li	a1,0
      c6:	00006517          	auipc	a0,0x6
      ca:	23250513          	add	a0,a0,562 # 62f8 <updateNode+0x94>
      ce:	00006097          	auipc	ra,0x6
      d2:	b3c080e7          	jalr	-1220(ra) # 5c0a <open>
  if(fd >= 0){
      d6:	02055563          	bgez	a0,100 <opentest+0x66>
}
      da:	60e2                	ld	ra,24(sp)
      dc:	6442                	ld	s0,16(sp)
      de:	64a2                	ld	s1,8(sp)
      e0:	6105                	add	sp,sp,32
      e2:	8082                	ret
    printf("%s: open echo failed!\n", s);
      e4:	85a6                	mv	a1,s1
      e6:	00006517          	auipc	a0,0x6
      ea:	1fa50513          	add	a0,a0,506 # 62e0 <updateNode+0x7c>
      ee:	00006097          	auipc	ra,0x6
      f2:	e94080e7          	jalr	-364(ra) # 5f82 <printf>
    exit(1);
      f6:	4505                	li	a0,1
      f8:	00006097          	auipc	ra,0x6
      fc:	ad2080e7          	jalr	-1326(ra) # 5bca <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     100:	85a6                	mv	a1,s1
     102:	00006517          	auipc	a0,0x6
     106:	20650513          	add	a0,a0,518 # 6308 <updateNode+0xa4>
     10a:	00006097          	auipc	ra,0x6
     10e:	e78080e7          	jalr	-392(ra) # 5f82 <printf>
    exit(1);
     112:	4505                	li	a0,1
     114:	00006097          	auipc	ra,0x6
     118:	ab6080e7          	jalr	-1354(ra) # 5bca <exit>

000000000000011c <truncate2>:
{
     11c:	7179                	add	sp,sp,-48
     11e:	f406                	sd	ra,40(sp)
     120:	f022                	sd	s0,32(sp)
     122:	ec26                	sd	s1,24(sp)
     124:	e84a                	sd	s2,16(sp)
     126:	e44e                	sd	s3,8(sp)
     128:	1800                	add	s0,sp,48
     12a:	89aa                	mv	s3,a0
  unlink("truncfile");
     12c:	00006517          	auipc	a0,0x6
     130:	20450513          	add	a0,a0,516 # 6330 <updateNode+0xcc>
     134:	00006097          	auipc	ra,0x6
     138:	ae6080e7          	jalr	-1306(ra) # 5c1a <unlink>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     13c:	60100593          	li	a1,1537
     140:	00006517          	auipc	a0,0x6
     144:	1f050513          	add	a0,a0,496 # 6330 <updateNode+0xcc>
     148:	00006097          	auipc	ra,0x6
     14c:	ac2080e7          	jalr	-1342(ra) # 5c0a <open>
     150:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     152:	4611                	li	a2,4
     154:	00006597          	auipc	a1,0x6
     158:	1ec58593          	add	a1,a1,492 # 6340 <updateNode+0xdc>
     15c:	00006097          	auipc	ra,0x6
     160:	a8e080e7          	jalr	-1394(ra) # 5bea <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     164:	40100593          	li	a1,1025
     168:	00006517          	auipc	a0,0x6
     16c:	1c850513          	add	a0,a0,456 # 6330 <updateNode+0xcc>
     170:	00006097          	auipc	ra,0x6
     174:	a9a080e7          	jalr	-1382(ra) # 5c0a <open>
     178:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     17a:	4605                	li	a2,1
     17c:	00006597          	auipc	a1,0x6
     180:	1cc58593          	add	a1,a1,460 # 6348 <updateNode+0xe4>
     184:	8526                	mv	a0,s1
     186:	00006097          	auipc	ra,0x6
     18a:	a64080e7          	jalr	-1436(ra) # 5bea <write>
  if(n != -1){
     18e:	57fd                	li	a5,-1
     190:	02f51b63          	bne	a0,a5,1c6 <truncate2+0xaa>
  unlink("truncfile");
     194:	00006517          	auipc	a0,0x6
     198:	19c50513          	add	a0,a0,412 # 6330 <updateNode+0xcc>
     19c:	00006097          	auipc	ra,0x6
     1a0:	a7e080e7          	jalr	-1410(ra) # 5c1a <unlink>
  close(fd1);
     1a4:	8526                	mv	a0,s1
     1a6:	00006097          	auipc	ra,0x6
     1aa:	a4c080e7          	jalr	-1460(ra) # 5bf2 <close>
  close(fd2);
     1ae:	854a                	mv	a0,s2
     1b0:	00006097          	auipc	ra,0x6
     1b4:	a42080e7          	jalr	-1470(ra) # 5bf2 <close>
}
     1b8:	70a2                	ld	ra,40(sp)
     1ba:	7402                	ld	s0,32(sp)
     1bc:	64e2                	ld	s1,24(sp)
     1be:	6942                	ld	s2,16(sp)
     1c0:	69a2                	ld	s3,8(sp)
     1c2:	6145                	add	sp,sp,48
     1c4:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1c6:	862a                	mv	a2,a0
     1c8:	85ce                	mv	a1,s3
     1ca:	00006517          	auipc	a0,0x6
     1ce:	18650513          	add	a0,a0,390 # 6350 <updateNode+0xec>
     1d2:	00006097          	auipc	ra,0x6
     1d6:	db0080e7          	jalr	-592(ra) # 5f82 <printf>
    exit(1);
     1da:	4505                	li	a0,1
     1dc:	00006097          	auipc	ra,0x6
     1e0:	9ee080e7          	jalr	-1554(ra) # 5bca <exit>

00000000000001e4 <createtest>:
{
     1e4:	7179                	add	sp,sp,-48
     1e6:	f406                	sd	ra,40(sp)
     1e8:	f022                	sd	s0,32(sp)
     1ea:	ec26                	sd	s1,24(sp)
     1ec:	e84a                	sd	s2,16(sp)
     1ee:	1800                	add	s0,sp,48
  name[0] = 'a';
     1f0:	06100793          	li	a5,97
     1f4:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     1f8:	fc040d23          	sb	zero,-38(s0)
     1fc:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     200:	06400913          	li	s2,100
    name[1] = '0' + i;
     204:	fc940ca3          	sb	s1,-39(s0)
    fd = open(name, O_CREATE|O_RDWR);
     208:	20200593          	li	a1,514
     20c:	fd840513          	add	a0,s0,-40
     210:	00006097          	auipc	ra,0x6
     214:	9fa080e7          	jalr	-1542(ra) # 5c0a <open>
    close(fd);
     218:	00006097          	auipc	ra,0x6
     21c:	9da080e7          	jalr	-1574(ra) # 5bf2 <close>
  for(i = 0; i < N; i++){
     220:	2485                	addw	s1,s1,1
     222:	0ff4f493          	zext.b	s1,s1
     226:	fd249fe3          	bne	s1,s2,204 <createtest+0x20>
  name[0] = 'a';
     22a:	06100793          	li	a5,97
     22e:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     232:	fc040d23          	sb	zero,-38(s0)
     236:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     23a:	06400913          	li	s2,100
    name[1] = '0' + i;
     23e:	fc940ca3          	sb	s1,-39(s0)
    unlink(name);
     242:	fd840513          	add	a0,s0,-40
     246:	00006097          	auipc	ra,0x6
     24a:	9d4080e7          	jalr	-1580(ra) # 5c1a <unlink>
  for(i = 0; i < N; i++){
     24e:	2485                	addw	s1,s1,1
     250:	0ff4f493          	zext.b	s1,s1
     254:	ff2495e3          	bne	s1,s2,23e <createtest+0x5a>
}
     258:	70a2                	ld	ra,40(sp)
     25a:	7402                	ld	s0,32(sp)
     25c:	64e2                	ld	s1,24(sp)
     25e:	6942                	ld	s2,16(sp)
     260:	6145                	add	sp,sp,48
     262:	8082                	ret

0000000000000264 <bigwrite>:
{
     264:	715d                	add	sp,sp,-80
     266:	e486                	sd	ra,72(sp)
     268:	e0a2                	sd	s0,64(sp)
     26a:	fc26                	sd	s1,56(sp)
     26c:	f84a                	sd	s2,48(sp)
     26e:	f44e                	sd	s3,40(sp)
     270:	f052                	sd	s4,32(sp)
     272:	ec56                	sd	s5,24(sp)
     274:	e85a                	sd	s6,16(sp)
     276:	e45e                	sd	s7,8(sp)
     278:	0880                	add	s0,sp,80
     27a:	8baa                	mv	s7,a0
  unlink("bigwrite");
     27c:	00006517          	auipc	a0,0x6
     280:	0fc50513          	add	a0,a0,252 # 6378 <updateNode+0x114>
     284:	00006097          	auipc	ra,0x6
     288:	996080e7          	jalr	-1642(ra) # 5c1a <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     28c:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     290:	00006a97          	auipc	s5,0x6
     294:	0e8a8a93          	add	s5,s5,232 # 6378 <updateNode+0x114>
      int cc = write(fd, buf, sz);
     298:	0000da17          	auipc	s4,0xd
     29c:	9e0a0a13          	add	s4,s4,-1568 # cc78 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2a0:	6b0d                	lui	s6,0x3
     2a2:	1c9b0b13          	add	s6,s6,457 # 31c9 <diskfull+0x7>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     2a6:	20200593          	li	a1,514
     2aa:	8556                	mv	a0,s5
     2ac:	00006097          	auipc	ra,0x6
     2b0:	95e080e7          	jalr	-1698(ra) # 5c0a <open>
     2b4:	892a                	mv	s2,a0
    if(fd < 0){
     2b6:	04054d63          	bltz	a0,310 <bigwrite+0xac>
      int cc = write(fd, buf, sz);
     2ba:	8626                	mv	a2,s1
     2bc:	85d2                	mv	a1,s4
     2be:	00006097          	auipc	ra,0x6
     2c2:	92c080e7          	jalr	-1748(ra) # 5bea <write>
     2c6:	89aa                	mv	s3,a0
      if(cc != sz){
     2c8:	06a49263          	bne	s1,a0,32c <bigwrite+0xc8>
      int cc = write(fd, buf, sz);
     2cc:	8626                	mv	a2,s1
     2ce:	85d2                	mv	a1,s4
     2d0:	854a                	mv	a0,s2
     2d2:	00006097          	auipc	ra,0x6
     2d6:	918080e7          	jalr	-1768(ra) # 5bea <write>
      if(cc != sz){
     2da:	04951a63          	bne	a0,s1,32e <bigwrite+0xca>
    close(fd);
     2de:	854a                	mv	a0,s2
     2e0:	00006097          	auipc	ra,0x6
     2e4:	912080e7          	jalr	-1774(ra) # 5bf2 <close>
    unlink("bigwrite");
     2e8:	8556                	mv	a0,s5
     2ea:	00006097          	auipc	ra,0x6
     2ee:	930080e7          	jalr	-1744(ra) # 5c1a <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2f2:	1d74849b          	addw	s1,s1,471
     2f6:	fb6498e3          	bne	s1,s6,2a6 <bigwrite+0x42>
}
     2fa:	60a6                	ld	ra,72(sp)
     2fc:	6406                	ld	s0,64(sp)
     2fe:	74e2                	ld	s1,56(sp)
     300:	7942                	ld	s2,48(sp)
     302:	79a2                	ld	s3,40(sp)
     304:	7a02                	ld	s4,32(sp)
     306:	6ae2                	ld	s5,24(sp)
     308:	6b42                	ld	s6,16(sp)
     30a:	6ba2                	ld	s7,8(sp)
     30c:	6161                	add	sp,sp,80
     30e:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     310:	85de                	mv	a1,s7
     312:	00006517          	auipc	a0,0x6
     316:	07650513          	add	a0,a0,118 # 6388 <updateNode+0x124>
     31a:	00006097          	auipc	ra,0x6
     31e:	c68080e7          	jalr	-920(ra) # 5f82 <printf>
      exit(1);
     322:	4505                	li	a0,1
     324:	00006097          	auipc	ra,0x6
     328:	8a6080e7          	jalr	-1882(ra) # 5bca <exit>
      if(cc != sz){
     32c:	89a6                	mv	s3,s1
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     32e:	86aa                	mv	a3,a0
     330:	864e                	mv	a2,s3
     332:	85de                	mv	a1,s7
     334:	00006517          	auipc	a0,0x6
     338:	07450513          	add	a0,a0,116 # 63a8 <updateNode+0x144>
     33c:	00006097          	auipc	ra,0x6
     340:	c46080e7          	jalr	-954(ra) # 5f82 <printf>
        exit(1);
     344:	4505                	li	a0,1
     346:	00006097          	auipc	ra,0x6
     34a:	884080e7          	jalr	-1916(ra) # 5bca <exit>

000000000000034e <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
     34e:	7179                	add	sp,sp,-48
     350:	f406                	sd	ra,40(sp)
     352:	f022                	sd	s0,32(sp)
     354:	ec26                	sd	s1,24(sp)
     356:	e84a                	sd	s2,16(sp)
     358:	e44e                	sd	s3,8(sp)
     35a:	e052                	sd	s4,0(sp)
     35c:	1800                	add	s0,sp,48
  int assumed_free = 600;
  
  unlink("junk");
     35e:	00006517          	auipc	a0,0x6
     362:	06250513          	add	a0,a0,98 # 63c0 <updateNode+0x15c>
     366:	00006097          	auipc	ra,0x6
     36a:	8b4080e7          	jalr	-1868(ra) # 5c1a <unlink>
     36e:	25800913          	li	s2,600
  for(int i = 0; i < assumed_free; i++){
    int fd = open("junk", O_CREATE|O_WRONLY);
     372:	00006997          	auipc	s3,0x6
     376:	04e98993          	add	s3,s3,78 # 63c0 <updateNode+0x15c>
    if(fd < 0){
      printf("open junk failed\n");
      exit(1);
    }
    write(fd, (char*)0xffffffffffL, 1);
     37a:	5a7d                	li	s4,-1
     37c:	018a5a13          	srl	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
     380:	20100593          	li	a1,513
     384:	854e                	mv	a0,s3
     386:	00006097          	auipc	ra,0x6
     38a:	884080e7          	jalr	-1916(ra) # 5c0a <open>
     38e:	84aa                	mv	s1,a0
    if(fd < 0){
     390:	06054b63          	bltz	a0,406 <badwrite+0xb8>
    write(fd, (char*)0xffffffffffL, 1);
     394:	4605                	li	a2,1
     396:	85d2                	mv	a1,s4
     398:	00006097          	auipc	ra,0x6
     39c:	852080e7          	jalr	-1966(ra) # 5bea <write>
    close(fd);
     3a0:	8526                	mv	a0,s1
     3a2:	00006097          	auipc	ra,0x6
     3a6:	850080e7          	jalr	-1968(ra) # 5bf2 <close>
    unlink("junk");
     3aa:	854e                	mv	a0,s3
     3ac:	00006097          	auipc	ra,0x6
     3b0:	86e080e7          	jalr	-1938(ra) # 5c1a <unlink>
  for(int i = 0; i < assumed_free; i++){
     3b4:	397d                	addw	s2,s2,-1
     3b6:	fc0915e3          	bnez	s2,380 <badwrite+0x32>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
     3ba:	20100593          	li	a1,513
     3be:	00006517          	auipc	a0,0x6
     3c2:	00250513          	add	a0,a0,2 # 63c0 <updateNode+0x15c>
     3c6:	00006097          	auipc	ra,0x6
     3ca:	844080e7          	jalr	-1980(ra) # 5c0a <open>
     3ce:	84aa                	mv	s1,a0
  if(fd < 0){
     3d0:	04054863          	bltz	a0,420 <badwrite+0xd2>
    printf("open junk failed\n");
    exit(1);
  }
  if(write(fd, "x", 1) != 1){
     3d4:	4605                	li	a2,1
     3d6:	00006597          	auipc	a1,0x6
     3da:	f7258593          	add	a1,a1,-142 # 6348 <updateNode+0xe4>
     3de:	00006097          	auipc	ra,0x6
     3e2:	80c080e7          	jalr	-2036(ra) # 5bea <write>
     3e6:	4785                	li	a5,1
     3e8:	04f50963          	beq	a0,a5,43a <badwrite+0xec>
    printf("write failed\n");
     3ec:	00006517          	auipc	a0,0x6
     3f0:	ff450513          	add	a0,a0,-12 # 63e0 <updateNode+0x17c>
     3f4:	00006097          	auipc	ra,0x6
     3f8:	b8e080e7          	jalr	-1138(ra) # 5f82 <printf>
    exit(1);
     3fc:	4505                	li	a0,1
     3fe:	00005097          	auipc	ra,0x5
     402:	7cc080e7          	jalr	1996(ra) # 5bca <exit>
      printf("open junk failed\n");
     406:	00006517          	auipc	a0,0x6
     40a:	fc250513          	add	a0,a0,-62 # 63c8 <updateNode+0x164>
     40e:	00006097          	auipc	ra,0x6
     412:	b74080e7          	jalr	-1164(ra) # 5f82 <printf>
      exit(1);
     416:	4505                	li	a0,1
     418:	00005097          	auipc	ra,0x5
     41c:	7b2080e7          	jalr	1970(ra) # 5bca <exit>
    printf("open junk failed\n");
     420:	00006517          	auipc	a0,0x6
     424:	fa850513          	add	a0,a0,-88 # 63c8 <updateNode+0x164>
     428:	00006097          	auipc	ra,0x6
     42c:	b5a080e7          	jalr	-1190(ra) # 5f82 <printf>
    exit(1);
     430:	4505                	li	a0,1
     432:	00005097          	auipc	ra,0x5
     436:	798080e7          	jalr	1944(ra) # 5bca <exit>
  }
  close(fd);
     43a:	8526                	mv	a0,s1
     43c:	00005097          	auipc	ra,0x5
     440:	7b6080e7          	jalr	1974(ra) # 5bf2 <close>
  unlink("junk");
     444:	00006517          	auipc	a0,0x6
     448:	f7c50513          	add	a0,a0,-132 # 63c0 <updateNode+0x15c>
     44c:	00005097          	auipc	ra,0x5
     450:	7ce080e7          	jalr	1998(ra) # 5c1a <unlink>

  exit(0);
     454:	4501                	li	a0,0
     456:	00005097          	auipc	ra,0x5
     45a:	774080e7          	jalr	1908(ra) # 5bca <exit>

000000000000045e <outofinodes>:
  }
}

void
outofinodes(char *s)
{
     45e:	715d                	add	sp,sp,-80
     460:	e486                	sd	ra,72(sp)
     462:	e0a2                	sd	s0,64(sp)
     464:	fc26                	sd	s1,56(sp)
     466:	f84a                	sd	s2,48(sp)
     468:	f44e                	sd	s3,40(sp)
     46a:	0880                	add	s0,sp,80
  int nzz = 32*32;
  for(int i = 0; i < nzz; i++){
     46c:	4481                	li	s1,0
    char name[32];
    name[0] = 'z';
     46e:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
     472:	40000993          	li	s3,1024
    name[0] = 'z';
     476:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     47a:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     47e:	41f4d71b          	sraw	a4,s1,0x1f
     482:	01b7571b          	srlw	a4,a4,0x1b
     486:	009707bb          	addw	a5,a4,s1
     48a:	4057d69b          	sraw	a3,a5,0x5
     48e:	0306869b          	addw	a3,a3,48
     492:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     496:	8bfd                	and	a5,a5,31
     498:	9f99                	subw	a5,a5,a4
     49a:	0307879b          	addw	a5,a5,48
     49e:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     4a2:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     4a6:	fb040513          	add	a0,s0,-80
     4aa:	00005097          	auipc	ra,0x5
     4ae:	770080e7          	jalr	1904(ra) # 5c1a <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
     4b2:	60200593          	li	a1,1538
     4b6:	fb040513          	add	a0,s0,-80
     4ba:	00005097          	auipc	ra,0x5
     4be:	750080e7          	jalr	1872(ra) # 5c0a <open>
    if(fd < 0){
     4c2:	00054963          	bltz	a0,4d4 <outofinodes+0x76>
      // failure is eventually expected.
      break;
    }
    close(fd);
     4c6:	00005097          	auipc	ra,0x5
     4ca:	72c080e7          	jalr	1836(ra) # 5bf2 <close>
  for(int i = 0; i < nzz; i++){
     4ce:	2485                	addw	s1,s1,1
     4d0:	fb3493e3          	bne	s1,s3,476 <outofinodes+0x18>
     4d4:	4481                	li	s1,0
  }

  for(int i = 0; i < nzz; i++){
    char name[32];
    name[0] = 'z';
     4d6:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
     4da:	40000993          	li	s3,1024
    name[0] = 'z';
     4de:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     4e2:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     4e6:	41f4d71b          	sraw	a4,s1,0x1f
     4ea:	01b7571b          	srlw	a4,a4,0x1b
     4ee:	009707bb          	addw	a5,a4,s1
     4f2:	4057d69b          	sraw	a3,a5,0x5
     4f6:	0306869b          	addw	a3,a3,48
     4fa:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     4fe:	8bfd                	and	a5,a5,31
     500:	9f99                	subw	a5,a5,a4
     502:	0307879b          	addw	a5,a5,48
     506:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     50a:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     50e:	fb040513          	add	a0,s0,-80
     512:	00005097          	auipc	ra,0x5
     516:	708080e7          	jalr	1800(ra) # 5c1a <unlink>
  for(int i = 0; i < nzz; i++){
     51a:	2485                	addw	s1,s1,1
     51c:	fd3491e3          	bne	s1,s3,4de <outofinodes+0x80>
  }
}
     520:	60a6                	ld	ra,72(sp)
     522:	6406                	ld	s0,64(sp)
     524:	74e2                	ld	s1,56(sp)
     526:	7942                	ld	s2,48(sp)
     528:	79a2                	ld	s3,40(sp)
     52a:	6161                	add	sp,sp,80
     52c:	8082                	ret

000000000000052e <copyin>:
{
     52e:	715d                	add	sp,sp,-80
     530:	e486                	sd	ra,72(sp)
     532:	e0a2                	sd	s0,64(sp)
     534:	fc26                	sd	s1,56(sp)
     536:	f84a                	sd	s2,48(sp)
     538:	f44e                	sd	s3,40(sp)
     53a:	f052                	sd	s4,32(sp)
     53c:	0880                	add	s0,sp,80
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     53e:	4785                	li	a5,1
     540:	07fe                	sll	a5,a5,0x1f
     542:	fcf43023          	sd	a5,-64(s0)
     546:	57fd                	li	a5,-1
     548:	fcf43423          	sd	a5,-56(s0)
  for(int ai = 0; ai < 2; ai++){
     54c:	fc040913          	add	s2,s0,-64
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     550:	00006a17          	auipc	s4,0x6
     554:	ea0a0a13          	add	s4,s4,-352 # 63f0 <updateNode+0x18c>
    uint64 addr = addrs[ai];
     558:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     55c:	20100593          	li	a1,513
     560:	8552                	mv	a0,s4
     562:	00005097          	auipc	ra,0x5
     566:	6a8080e7          	jalr	1704(ra) # 5c0a <open>
     56a:	84aa                	mv	s1,a0
    if(fd < 0){
     56c:	08054863          	bltz	a0,5fc <copyin+0xce>
    int n = write(fd, (void*)addr, 8192);
     570:	6609                	lui	a2,0x2
     572:	85ce                	mv	a1,s3
     574:	00005097          	auipc	ra,0x5
     578:	676080e7          	jalr	1654(ra) # 5bea <write>
    if(n >= 0){
     57c:	08055d63          	bgez	a0,616 <copyin+0xe8>
    close(fd);
     580:	8526                	mv	a0,s1
     582:	00005097          	auipc	ra,0x5
     586:	670080e7          	jalr	1648(ra) # 5bf2 <close>
    unlink("copyin1");
     58a:	8552                	mv	a0,s4
     58c:	00005097          	auipc	ra,0x5
     590:	68e080e7          	jalr	1678(ra) # 5c1a <unlink>
    n = write(1, (char*)addr, 8192);
     594:	6609                	lui	a2,0x2
     596:	85ce                	mv	a1,s3
     598:	4505                	li	a0,1
     59a:	00005097          	auipc	ra,0x5
     59e:	650080e7          	jalr	1616(ra) # 5bea <write>
    if(n > 0){
     5a2:	08a04963          	bgtz	a0,634 <copyin+0x106>
    if(pipe(fds) < 0){
     5a6:	fb840513          	add	a0,s0,-72
     5aa:	00005097          	auipc	ra,0x5
     5ae:	630080e7          	jalr	1584(ra) # 5bda <pipe>
     5b2:	0a054063          	bltz	a0,652 <copyin+0x124>
    n = write(fds[1], (char*)addr, 8192);
     5b6:	6609                	lui	a2,0x2
     5b8:	85ce                	mv	a1,s3
     5ba:	fbc42503          	lw	a0,-68(s0)
     5be:	00005097          	auipc	ra,0x5
     5c2:	62c080e7          	jalr	1580(ra) # 5bea <write>
    if(n > 0){
     5c6:	0aa04363          	bgtz	a0,66c <copyin+0x13e>
    close(fds[0]);
     5ca:	fb842503          	lw	a0,-72(s0)
     5ce:	00005097          	auipc	ra,0x5
     5d2:	624080e7          	jalr	1572(ra) # 5bf2 <close>
    close(fds[1]);
     5d6:	fbc42503          	lw	a0,-68(s0)
     5da:	00005097          	auipc	ra,0x5
     5de:	618080e7          	jalr	1560(ra) # 5bf2 <close>
  for(int ai = 0; ai < 2; ai++){
     5e2:	0921                	add	s2,s2,8
     5e4:	fd040793          	add	a5,s0,-48
     5e8:	f6f918e3          	bne	s2,a5,558 <copyin+0x2a>
}
     5ec:	60a6                	ld	ra,72(sp)
     5ee:	6406                	ld	s0,64(sp)
     5f0:	74e2                	ld	s1,56(sp)
     5f2:	7942                	ld	s2,48(sp)
     5f4:	79a2                	ld	s3,40(sp)
     5f6:	7a02                	ld	s4,32(sp)
     5f8:	6161                	add	sp,sp,80
     5fa:	8082                	ret
      printf("open(copyin1) failed\n");
     5fc:	00006517          	auipc	a0,0x6
     600:	dfc50513          	add	a0,a0,-516 # 63f8 <updateNode+0x194>
     604:	00006097          	auipc	ra,0x6
     608:	97e080e7          	jalr	-1666(ra) # 5f82 <printf>
      exit(1);
     60c:	4505                	li	a0,1
     60e:	00005097          	auipc	ra,0x5
     612:	5bc080e7          	jalr	1468(ra) # 5bca <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
     616:	862a                	mv	a2,a0
     618:	85ce                	mv	a1,s3
     61a:	00006517          	auipc	a0,0x6
     61e:	df650513          	add	a0,a0,-522 # 6410 <updateNode+0x1ac>
     622:	00006097          	auipc	ra,0x6
     626:	960080e7          	jalr	-1696(ra) # 5f82 <printf>
      exit(1);
     62a:	4505                	li	a0,1
     62c:	00005097          	auipc	ra,0x5
     630:	59e080e7          	jalr	1438(ra) # 5bca <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     634:	862a                	mv	a2,a0
     636:	85ce                	mv	a1,s3
     638:	00006517          	auipc	a0,0x6
     63c:	e0850513          	add	a0,a0,-504 # 6440 <updateNode+0x1dc>
     640:	00006097          	auipc	ra,0x6
     644:	942080e7          	jalr	-1726(ra) # 5f82 <printf>
      exit(1);
     648:	4505                	li	a0,1
     64a:	00005097          	auipc	ra,0x5
     64e:	580080e7          	jalr	1408(ra) # 5bca <exit>
      printf("pipe() failed\n");
     652:	00006517          	auipc	a0,0x6
     656:	e1e50513          	add	a0,a0,-482 # 6470 <updateNode+0x20c>
     65a:	00006097          	auipc	ra,0x6
     65e:	928080e7          	jalr	-1752(ra) # 5f82 <printf>
      exit(1);
     662:	4505                	li	a0,1
     664:	00005097          	auipc	ra,0x5
     668:	566080e7          	jalr	1382(ra) # 5bca <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     66c:	862a                	mv	a2,a0
     66e:	85ce                	mv	a1,s3
     670:	00006517          	auipc	a0,0x6
     674:	e1050513          	add	a0,a0,-496 # 6480 <updateNode+0x21c>
     678:	00006097          	auipc	ra,0x6
     67c:	90a080e7          	jalr	-1782(ra) # 5f82 <printf>
      exit(1);
     680:	4505                	li	a0,1
     682:	00005097          	auipc	ra,0x5
     686:	548080e7          	jalr	1352(ra) # 5bca <exit>

000000000000068a <copyout>:
{
     68a:	711d                	add	sp,sp,-96
     68c:	ec86                	sd	ra,88(sp)
     68e:	e8a2                	sd	s0,80(sp)
     690:	e4a6                	sd	s1,72(sp)
     692:	e0ca                	sd	s2,64(sp)
     694:	fc4e                	sd	s3,56(sp)
     696:	f852                	sd	s4,48(sp)
     698:	f456                	sd	s5,40(sp)
     69a:	1080                	add	s0,sp,96
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     69c:	4785                	li	a5,1
     69e:	07fe                	sll	a5,a5,0x1f
     6a0:	faf43823          	sd	a5,-80(s0)
     6a4:	57fd                	li	a5,-1
     6a6:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < 2; ai++){
     6aa:	fb040913          	add	s2,s0,-80
    int fd = open("README", 0);
     6ae:	00006a17          	auipc	s4,0x6
     6b2:	e02a0a13          	add	s4,s4,-510 # 64b0 <updateNode+0x24c>
    n = write(fds[1], "x", 1);
     6b6:	00006a97          	auipc	s5,0x6
     6ba:	c92a8a93          	add	s5,s5,-878 # 6348 <updateNode+0xe4>
    uint64 addr = addrs[ai];
     6be:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     6c2:	4581                	li	a1,0
     6c4:	8552                	mv	a0,s4
     6c6:	00005097          	auipc	ra,0x5
     6ca:	544080e7          	jalr	1348(ra) # 5c0a <open>
     6ce:	84aa                	mv	s1,a0
    if(fd < 0){
     6d0:	08054663          	bltz	a0,75c <copyout+0xd2>
    int n = read(fd, (void*)addr, 8192);
     6d4:	6609                	lui	a2,0x2
     6d6:	85ce                	mv	a1,s3
     6d8:	00005097          	auipc	ra,0x5
     6dc:	50a080e7          	jalr	1290(ra) # 5be2 <read>
    if(n > 0){
     6e0:	08a04b63          	bgtz	a0,776 <copyout+0xec>
    close(fd);
     6e4:	8526                	mv	a0,s1
     6e6:	00005097          	auipc	ra,0x5
     6ea:	50c080e7          	jalr	1292(ra) # 5bf2 <close>
    if(pipe(fds) < 0){
     6ee:	fa840513          	add	a0,s0,-88
     6f2:	00005097          	auipc	ra,0x5
     6f6:	4e8080e7          	jalr	1256(ra) # 5bda <pipe>
     6fa:	08054d63          	bltz	a0,794 <copyout+0x10a>
    n = write(fds[1], "x", 1);
     6fe:	4605                	li	a2,1
     700:	85d6                	mv	a1,s5
     702:	fac42503          	lw	a0,-84(s0)
     706:	00005097          	auipc	ra,0x5
     70a:	4e4080e7          	jalr	1252(ra) # 5bea <write>
    if(n != 1){
     70e:	4785                	li	a5,1
     710:	08f51f63          	bne	a0,a5,7ae <copyout+0x124>
    n = read(fds[0], (void*)addr, 8192);
     714:	6609                	lui	a2,0x2
     716:	85ce                	mv	a1,s3
     718:	fa842503          	lw	a0,-88(s0)
     71c:	00005097          	auipc	ra,0x5
     720:	4c6080e7          	jalr	1222(ra) # 5be2 <read>
    if(n > 0){
     724:	0aa04263          	bgtz	a0,7c8 <copyout+0x13e>
    close(fds[0]);
     728:	fa842503          	lw	a0,-88(s0)
     72c:	00005097          	auipc	ra,0x5
     730:	4c6080e7          	jalr	1222(ra) # 5bf2 <close>
    close(fds[1]);
     734:	fac42503          	lw	a0,-84(s0)
     738:	00005097          	auipc	ra,0x5
     73c:	4ba080e7          	jalr	1210(ra) # 5bf2 <close>
  for(int ai = 0; ai < 2; ai++){
     740:	0921                	add	s2,s2,8
     742:	fc040793          	add	a5,s0,-64
     746:	f6f91ce3          	bne	s2,a5,6be <copyout+0x34>
}
     74a:	60e6                	ld	ra,88(sp)
     74c:	6446                	ld	s0,80(sp)
     74e:	64a6                	ld	s1,72(sp)
     750:	6906                	ld	s2,64(sp)
     752:	79e2                	ld	s3,56(sp)
     754:	7a42                	ld	s4,48(sp)
     756:	7aa2                	ld	s5,40(sp)
     758:	6125                	add	sp,sp,96
     75a:	8082                	ret
      printf("open(README) failed\n");
     75c:	00006517          	auipc	a0,0x6
     760:	d5c50513          	add	a0,a0,-676 # 64b8 <updateNode+0x254>
     764:	00006097          	auipc	ra,0x6
     768:	81e080e7          	jalr	-2018(ra) # 5f82 <printf>
      exit(1);
     76c:	4505                	li	a0,1
     76e:	00005097          	auipc	ra,0x5
     772:	45c080e7          	jalr	1116(ra) # 5bca <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     776:	862a                	mv	a2,a0
     778:	85ce                	mv	a1,s3
     77a:	00006517          	auipc	a0,0x6
     77e:	d5650513          	add	a0,a0,-682 # 64d0 <updateNode+0x26c>
     782:	00006097          	auipc	ra,0x6
     786:	800080e7          	jalr	-2048(ra) # 5f82 <printf>
      exit(1);
     78a:	4505                	li	a0,1
     78c:	00005097          	auipc	ra,0x5
     790:	43e080e7          	jalr	1086(ra) # 5bca <exit>
      printf("pipe() failed\n");
     794:	00006517          	auipc	a0,0x6
     798:	cdc50513          	add	a0,a0,-804 # 6470 <updateNode+0x20c>
     79c:	00005097          	auipc	ra,0x5
     7a0:	7e6080e7          	jalr	2022(ra) # 5f82 <printf>
      exit(1);
     7a4:	4505                	li	a0,1
     7a6:	00005097          	auipc	ra,0x5
     7aa:	424080e7          	jalr	1060(ra) # 5bca <exit>
      printf("pipe write failed\n");
     7ae:	00006517          	auipc	a0,0x6
     7b2:	d5250513          	add	a0,a0,-686 # 6500 <updateNode+0x29c>
     7b6:	00005097          	auipc	ra,0x5
     7ba:	7cc080e7          	jalr	1996(ra) # 5f82 <printf>
      exit(1);
     7be:	4505                	li	a0,1
     7c0:	00005097          	auipc	ra,0x5
     7c4:	40a080e7          	jalr	1034(ra) # 5bca <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     7c8:	862a                	mv	a2,a0
     7ca:	85ce                	mv	a1,s3
     7cc:	00006517          	auipc	a0,0x6
     7d0:	d4c50513          	add	a0,a0,-692 # 6518 <updateNode+0x2b4>
     7d4:	00005097          	auipc	ra,0x5
     7d8:	7ae080e7          	jalr	1966(ra) # 5f82 <printf>
      exit(1);
     7dc:	4505                	li	a0,1
     7de:	00005097          	auipc	ra,0x5
     7e2:	3ec080e7          	jalr	1004(ra) # 5bca <exit>

00000000000007e6 <truncate1>:
{
     7e6:	711d                	add	sp,sp,-96
     7e8:	ec86                	sd	ra,88(sp)
     7ea:	e8a2                	sd	s0,80(sp)
     7ec:	e4a6                	sd	s1,72(sp)
     7ee:	e0ca                	sd	s2,64(sp)
     7f0:	fc4e                	sd	s3,56(sp)
     7f2:	f852                	sd	s4,48(sp)
     7f4:	f456                	sd	s5,40(sp)
     7f6:	1080                	add	s0,sp,96
     7f8:	8aaa                	mv	s5,a0
  unlink("truncfile");
     7fa:	00006517          	auipc	a0,0x6
     7fe:	b3650513          	add	a0,a0,-1226 # 6330 <updateNode+0xcc>
     802:	00005097          	auipc	ra,0x5
     806:	418080e7          	jalr	1048(ra) # 5c1a <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     80a:	60100593          	li	a1,1537
     80e:	00006517          	auipc	a0,0x6
     812:	b2250513          	add	a0,a0,-1246 # 6330 <updateNode+0xcc>
     816:	00005097          	auipc	ra,0x5
     81a:	3f4080e7          	jalr	1012(ra) # 5c0a <open>
     81e:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     820:	4611                	li	a2,4
     822:	00006597          	auipc	a1,0x6
     826:	b1e58593          	add	a1,a1,-1250 # 6340 <updateNode+0xdc>
     82a:	00005097          	auipc	ra,0x5
     82e:	3c0080e7          	jalr	960(ra) # 5bea <write>
  close(fd1);
     832:	8526                	mv	a0,s1
     834:	00005097          	auipc	ra,0x5
     838:	3be080e7          	jalr	958(ra) # 5bf2 <close>
  int fd2 = open("truncfile", O_RDONLY);
     83c:	4581                	li	a1,0
     83e:	00006517          	auipc	a0,0x6
     842:	af250513          	add	a0,a0,-1294 # 6330 <updateNode+0xcc>
     846:	00005097          	auipc	ra,0x5
     84a:	3c4080e7          	jalr	964(ra) # 5c0a <open>
     84e:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     850:	02000613          	li	a2,32
     854:	fa040593          	add	a1,s0,-96
     858:	00005097          	auipc	ra,0x5
     85c:	38a080e7          	jalr	906(ra) # 5be2 <read>
  if(n != 4){
     860:	4791                	li	a5,4
     862:	0cf51e63          	bne	a0,a5,93e <truncate1+0x158>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     866:	40100593          	li	a1,1025
     86a:	00006517          	auipc	a0,0x6
     86e:	ac650513          	add	a0,a0,-1338 # 6330 <updateNode+0xcc>
     872:	00005097          	auipc	ra,0x5
     876:	398080e7          	jalr	920(ra) # 5c0a <open>
     87a:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     87c:	4581                	li	a1,0
     87e:	00006517          	auipc	a0,0x6
     882:	ab250513          	add	a0,a0,-1358 # 6330 <updateNode+0xcc>
     886:	00005097          	auipc	ra,0x5
     88a:	384080e7          	jalr	900(ra) # 5c0a <open>
     88e:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     890:	02000613          	li	a2,32
     894:	fa040593          	add	a1,s0,-96
     898:	00005097          	auipc	ra,0x5
     89c:	34a080e7          	jalr	842(ra) # 5be2 <read>
     8a0:	8a2a                	mv	s4,a0
  if(n != 0){
     8a2:	ed4d                	bnez	a0,95c <truncate1+0x176>
  n = read(fd2, buf, sizeof(buf));
     8a4:	02000613          	li	a2,32
     8a8:	fa040593          	add	a1,s0,-96
     8ac:	8526                	mv	a0,s1
     8ae:	00005097          	auipc	ra,0x5
     8b2:	334080e7          	jalr	820(ra) # 5be2 <read>
     8b6:	8a2a                	mv	s4,a0
  if(n != 0){
     8b8:	e971                	bnez	a0,98c <truncate1+0x1a6>
  write(fd1, "abcdef", 6);
     8ba:	4619                	li	a2,6
     8bc:	00006597          	auipc	a1,0x6
     8c0:	cec58593          	add	a1,a1,-788 # 65a8 <updateNode+0x344>
     8c4:	854e                	mv	a0,s3
     8c6:	00005097          	auipc	ra,0x5
     8ca:	324080e7          	jalr	804(ra) # 5bea <write>
  n = read(fd3, buf, sizeof(buf));
     8ce:	02000613          	li	a2,32
     8d2:	fa040593          	add	a1,s0,-96
     8d6:	854a                	mv	a0,s2
     8d8:	00005097          	auipc	ra,0x5
     8dc:	30a080e7          	jalr	778(ra) # 5be2 <read>
  if(n != 6){
     8e0:	4799                	li	a5,6
     8e2:	0cf51d63          	bne	a0,a5,9bc <truncate1+0x1d6>
  n = read(fd2, buf, sizeof(buf));
     8e6:	02000613          	li	a2,32
     8ea:	fa040593          	add	a1,s0,-96
     8ee:	8526                	mv	a0,s1
     8f0:	00005097          	auipc	ra,0x5
     8f4:	2f2080e7          	jalr	754(ra) # 5be2 <read>
  if(n != 2){
     8f8:	4789                	li	a5,2
     8fa:	0ef51063          	bne	a0,a5,9da <truncate1+0x1f4>
  unlink("truncfile");
     8fe:	00006517          	auipc	a0,0x6
     902:	a3250513          	add	a0,a0,-1486 # 6330 <updateNode+0xcc>
     906:	00005097          	auipc	ra,0x5
     90a:	314080e7          	jalr	788(ra) # 5c1a <unlink>
  close(fd1);
     90e:	854e                	mv	a0,s3
     910:	00005097          	auipc	ra,0x5
     914:	2e2080e7          	jalr	738(ra) # 5bf2 <close>
  close(fd2);
     918:	8526                	mv	a0,s1
     91a:	00005097          	auipc	ra,0x5
     91e:	2d8080e7          	jalr	728(ra) # 5bf2 <close>
  close(fd3);
     922:	854a                	mv	a0,s2
     924:	00005097          	auipc	ra,0x5
     928:	2ce080e7          	jalr	718(ra) # 5bf2 <close>
}
     92c:	60e6                	ld	ra,88(sp)
     92e:	6446                	ld	s0,80(sp)
     930:	64a6                	ld	s1,72(sp)
     932:	6906                	ld	s2,64(sp)
     934:	79e2                	ld	s3,56(sp)
     936:	7a42                	ld	s4,48(sp)
     938:	7aa2                	ld	s5,40(sp)
     93a:	6125                	add	sp,sp,96
     93c:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     93e:	862a                	mv	a2,a0
     940:	85d6                	mv	a1,s5
     942:	00006517          	auipc	a0,0x6
     946:	c0650513          	add	a0,a0,-1018 # 6548 <updateNode+0x2e4>
     94a:	00005097          	auipc	ra,0x5
     94e:	638080e7          	jalr	1592(ra) # 5f82 <printf>
    exit(1);
     952:	4505                	li	a0,1
     954:	00005097          	auipc	ra,0x5
     958:	276080e7          	jalr	630(ra) # 5bca <exit>
    printf("aaa fd3=%d\n", fd3);
     95c:	85ca                	mv	a1,s2
     95e:	00006517          	auipc	a0,0x6
     962:	c0a50513          	add	a0,a0,-1014 # 6568 <updateNode+0x304>
     966:	00005097          	auipc	ra,0x5
     96a:	61c080e7          	jalr	1564(ra) # 5f82 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     96e:	8652                	mv	a2,s4
     970:	85d6                	mv	a1,s5
     972:	00006517          	auipc	a0,0x6
     976:	c0650513          	add	a0,a0,-1018 # 6578 <updateNode+0x314>
     97a:	00005097          	auipc	ra,0x5
     97e:	608080e7          	jalr	1544(ra) # 5f82 <printf>
    exit(1);
     982:	4505                	li	a0,1
     984:	00005097          	auipc	ra,0x5
     988:	246080e7          	jalr	582(ra) # 5bca <exit>
    printf("bbb fd2=%d\n", fd2);
     98c:	85a6                	mv	a1,s1
     98e:	00006517          	auipc	a0,0x6
     992:	c0a50513          	add	a0,a0,-1014 # 6598 <updateNode+0x334>
     996:	00005097          	auipc	ra,0x5
     99a:	5ec080e7          	jalr	1516(ra) # 5f82 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     99e:	8652                	mv	a2,s4
     9a0:	85d6                	mv	a1,s5
     9a2:	00006517          	auipc	a0,0x6
     9a6:	bd650513          	add	a0,a0,-1066 # 6578 <updateNode+0x314>
     9aa:	00005097          	auipc	ra,0x5
     9ae:	5d8080e7          	jalr	1496(ra) # 5f82 <printf>
    exit(1);
     9b2:	4505                	li	a0,1
     9b4:	00005097          	auipc	ra,0x5
     9b8:	216080e7          	jalr	534(ra) # 5bca <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     9bc:	862a                	mv	a2,a0
     9be:	85d6                	mv	a1,s5
     9c0:	00006517          	auipc	a0,0x6
     9c4:	bf050513          	add	a0,a0,-1040 # 65b0 <updateNode+0x34c>
     9c8:	00005097          	auipc	ra,0x5
     9cc:	5ba080e7          	jalr	1466(ra) # 5f82 <printf>
    exit(1);
     9d0:	4505                	li	a0,1
     9d2:	00005097          	auipc	ra,0x5
     9d6:	1f8080e7          	jalr	504(ra) # 5bca <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     9da:	862a                	mv	a2,a0
     9dc:	85d6                	mv	a1,s5
     9de:	00006517          	auipc	a0,0x6
     9e2:	bf250513          	add	a0,a0,-1038 # 65d0 <updateNode+0x36c>
     9e6:	00005097          	auipc	ra,0x5
     9ea:	59c080e7          	jalr	1436(ra) # 5f82 <printf>
    exit(1);
     9ee:	4505                	li	a0,1
     9f0:	00005097          	auipc	ra,0x5
     9f4:	1da080e7          	jalr	474(ra) # 5bca <exit>

00000000000009f8 <writetest>:
{
     9f8:	7139                	add	sp,sp,-64
     9fa:	fc06                	sd	ra,56(sp)
     9fc:	f822                	sd	s0,48(sp)
     9fe:	f426                	sd	s1,40(sp)
     a00:	f04a                	sd	s2,32(sp)
     a02:	ec4e                	sd	s3,24(sp)
     a04:	e852                	sd	s4,16(sp)
     a06:	e456                	sd	s5,8(sp)
     a08:	e05a                	sd	s6,0(sp)
     a0a:	0080                	add	s0,sp,64
     a0c:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE|O_RDWR);
     a0e:	20200593          	li	a1,514
     a12:	00006517          	auipc	a0,0x6
     a16:	bde50513          	add	a0,a0,-1058 # 65f0 <updateNode+0x38c>
     a1a:	00005097          	auipc	ra,0x5
     a1e:	1f0080e7          	jalr	496(ra) # 5c0a <open>
  if(fd < 0){
     a22:	0a054d63          	bltz	a0,adc <writetest+0xe4>
     a26:	892a                	mv	s2,a0
     a28:	4481                	li	s1,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     a2a:	00006997          	auipc	s3,0x6
     a2e:	bee98993          	add	s3,s3,-1042 # 6618 <updateNode+0x3b4>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     a32:	00006a97          	auipc	s5,0x6
     a36:	c1ea8a93          	add	s5,s5,-994 # 6650 <updateNode+0x3ec>
  for(i = 0; i < N; i++){
     a3a:	06400a13          	li	s4,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     a3e:	4629                	li	a2,10
     a40:	85ce                	mv	a1,s3
     a42:	854a                	mv	a0,s2
     a44:	00005097          	auipc	ra,0x5
     a48:	1a6080e7          	jalr	422(ra) # 5bea <write>
     a4c:	47a9                	li	a5,10
     a4e:	0af51563          	bne	a0,a5,af8 <writetest+0x100>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     a52:	4629                	li	a2,10
     a54:	85d6                	mv	a1,s5
     a56:	854a                	mv	a0,s2
     a58:	00005097          	auipc	ra,0x5
     a5c:	192080e7          	jalr	402(ra) # 5bea <write>
     a60:	47a9                	li	a5,10
     a62:	0af51a63          	bne	a0,a5,b16 <writetest+0x11e>
  for(i = 0; i < N; i++){
     a66:	2485                	addw	s1,s1,1
     a68:	fd449be3          	bne	s1,s4,a3e <writetest+0x46>
  close(fd);
     a6c:	854a                	mv	a0,s2
     a6e:	00005097          	auipc	ra,0x5
     a72:	184080e7          	jalr	388(ra) # 5bf2 <close>
  fd = open("small", O_RDONLY);
     a76:	4581                	li	a1,0
     a78:	00006517          	auipc	a0,0x6
     a7c:	b7850513          	add	a0,a0,-1160 # 65f0 <updateNode+0x38c>
     a80:	00005097          	auipc	ra,0x5
     a84:	18a080e7          	jalr	394(ra) # 5c0a <open>
     a88:	84aa                	mv	s1,a0
  if(fd < 0){
     a8a:	0a054563          	bltz	a0,b34 <writetest+0x13c>
  i = read(fd, buf, N*SZ*2);
     a8e:	7d000613          	li	a2,2000
     a92:	0000c597          	auipc	a1,0xc
     a96:	1e658593          	add	a1,a1,486 # cc78 <buf>
     a9a:	00005097          	auipc	ra,0x5
     a9e:	148080e7          	jalr	328(ra) # 5be2 <read>
  if(i != N*SZ*2){
     aa2:	7d000793          	li	a5,2000
     aa6:	0af51563          	bne	a0,a5,b50 <writetest+0x158>
  close(fd);
     aaa:	8526                	mv	a0,s1
     aac:	00005097          	auipc	ra,0x5
     ab0:	146080e7          	jalr	326(ra) # 5bf2 <close>
  if(unlink("small") < 0){
     ab4:	00006517          	auipc	a0,0x6
     ab8:	b3c50513          	add	a0,a0,-1220 # 65f0 <updateNode+0x38c>
     abc:	00005097          	auipc	ra,0x5
     ac0:	15e080e7          	jalr	350(ra) # 5c1a <unlink>
     ac4:	0a054463          	bltz	a0,b6c <writetest+0x174>
}
     ac8:	70e2                	ld	ra,56(sp)
     aca:	7442                	ld	s0,48(sp)
     acc:	74a2                	ld	s1,40(sp)
     ace:	7902                	ld	s2,32(sp)
     ad0:	69e2                	ld	s3,24(sp)
     ad2:	6a42                	ld	s4,16(sp)
     ad4:	6aa2                	ld	s5,8(sp)
     ad6:	6b02                	ld	s6,0(sp)
     ad8:	6121                	add	sp,sp,64
     ada:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     adc:	85da                	mv	a1,s6
     ade:	00006517          	auipc	a0,0x6
     ae2:	b1a50513          	add	a0,a0,-1254 # 65f8 <updateNode+0x394>
     ae6:	00005097          	auipc	ra,0x5
     aea:	49c080e7          	jalr	1180(ra) # 5f82 <printf>
    exit(1);
     aee:	4505                	li	a0,1
     af0:	00005097          	auipc	ra,0x5
     af4:	0da080e7          	jalr	218(ra) # 5bca <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     af8:	8626                	mv	a2,s1
     afa:	85da                	mv	a1,s6
     afc:	00006517          	auipc	a0,0x6
     b00:	b2c50513          	add	a0,a0,-1236 # 6628 <updateNode+0x3c4>
     b04:	00005097          	auipc	ra,0x5
     b08:	47e080e7          	jalr	1150(ra) # 5f82 <printf>
      exit(1);
     b0c:	4505                	li	a0,1
     b0e:	00005097          	auipc	ra,0x5
     b12:	0bc080e7          	jalr	188(ra) # 5bca <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     b16:	8626                	mv	a2,s1
     b18:	85da                	mv	a1,s6
     b1a:	00006517          	auipc	a0,0x6
     b1e:	b4650513          	add	a0,a0,-1210 # 6660 <updateNode+0x3fc>
     b22:	00005097          	auipc	ra,0x5
     b26:	460080e7          	jalr	1120(ra) # 5f82 <printf>
      exit(1);
     b2a:	4505                	li	a0,1
     b2c:	00005097          	auipc	ra,0x5
     b30:	09e080e7          	jalr	158(ra) # 5bca <exit>
    printf("%s: error: open small failed!\n", s);
     b34:	85da                	mv	a1,s6
     b36:	00006517          	auipc	a0,0x6
     b3a:	b5250513          	add	a0,a0,-1198 # 6688 <updateNode+0x424>
     b3e:	00005097          	auipc	ra,0x5
     b42:	444080e7          	jalr	1092(ra) # 5f82 <printf>
    exit(1);
     b46:	4505                	li	a0,1
     b48:	00005097          	auipc	ra,0x5
     b4c:	082080e7          	jalr	130(ra) # 5bca <exit>
    printf("%s: read failed\n", s);
     b50:	85da                	mv	a1,s6
     b52:	00006517          	auipc	a0,0x6
     b56:	b5650513          	add	a0,a0,-1194 # 66a8 <updateNode+0x444>
     b5a:	00005097          	auipc	ra,0x5
     b5e:	428080e7          	jalr	1064(ra) # 5f82 <printf>
    exit(1);
     b62:	4505                	li	a0,1
     b64:	00005097          	auipc	ra,0x5
     b68:	066080e7          	jalr	102(ra) # 5bca <exit>
    printf("%s: unlink small failed\n", s);
     b6c:	85da                	mv	a1,s6
     b6e:	00006517          	auipc	a0,0x6
     b72:	b5250513          	add	a0,a0,-1198 # 66c0 <updateNode+0x45c>
     b76:	00005097          	auipc	ra,0x5
     b7a:	40c080e7          	jalr	1036(ra) # 5f82 <printf>
    exit(1);
     b7e:	4505                	li	a0,1
     b80:	00005097          	auipc	ra,0x5
     b84:	04a080e7          	jalr	74(ra) # 5bca <exit>

0000000000000b88 <writebig>:
{
     b88:	7139                	add	sp,sp,-64
     b8a:	fc06                	sd	ra,56(sp)
     b8c:	f822                	sd	s0,48(sp)
     b8e:	f426                	sd	s1,40(sp)
     b90:	f04a                	sd	s2,32(sp)
     b92:	ec4e                	sd	s3,24(sp)
     b94:	e852                	sd	s4,16(sp)
     b96:	e456                	sd	s5,8(sp)
     b98:	0080                	add	s0,sp,64
     b9a:	8aaa                	mv	s5,a0
  fd = open("big", O_CREATE|O_RDWR);
     b9c:	20200593          	li	a1,514
     ba0:	00006517          	auipc	a0,0x6
     ba4:	b4050513          	add	a0,a0,-1216 # 66e0 <updateNode+0x47c>
     ba8:	00005097          	auipc	ra,0x5
     bac:	062080e7          	jalr	98(ra) # 5c0a <open>
     bb0:	89aa                	mv	s3,a0
  for(i = 0; i < MAXFILE; i++){
     bb2:	4481                	li	s1,0
    ((int*)buf)[0] = i;
     bb4:	0000c917          	auipc	s2,0xc
     bb8:	0c490913          	add	s2,s2,196 # cc78 <buf>
  for(i = 0; i < MAXFILE; i++){
     bbc:	10c00a13          	li	s4,268
  if(fd < 0){
     bc0:	06054c63          	bltz	a0,c38 <writebig+0xb0>
    ((int*)buf)[0] = i;
     bc4:	00992023          	sw	s1,0(s2)
    if(write(fd, buf, BSIZE) != BSIZE){
     bc8:	40000613          	li	a2,1024
     bcc:	85ca                	mv	a1,s2
     bce:	854e                	mv	a0,s3
     bd0:	00005097          	auipc	ra,0x5
     bd4:	01a080e7          	jalr	26(ra) # 5bea <write>
     bd8:	40000793          	li	a5,1024
     bdc:	06f51c63          	bne	a0,a5,c54 <writebig+0xcc>
  for(i = 0; i < MAXFILE; i++){
     be0:	2485                	addw	s1,s1,1
     be2:	ff4491e3          	bne	s1,s4,bc4 <writebig+0x3c>
  close(fd);
     be6:	854e                	mv	a0,s3
     be8:	00005097          	auipc	ra,0x5
     bec:	00a080e7          	jalr	10(ra) # 5bf2 <close>
  fd = open("big", O_RDONLY);
     bf0:	4581                	li	a1,0
     bf2:	00006517          	auipc	a0,0x6
     bf6:	aee50513          	add	a0,a0,-1298 # 66e0 <updateNode+0x47c>
     bfa:	00005097          	auipc	ra,0x5
     bfe:	010080e7          	jalr	16(ra) # 5c0a <open>
     c02:	89aa                	mv	s3,a0
  n = 0;
     c04:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     c06:	0000c917          	auipc	s2,0xc
     c0a:	07290913          	add	s2,s2,114 # cc78 <buf>
  if(fd < 0){
     c0e:	06054263          	bltz	a0,c72 <writebig+0xea>
    i = read(fd, buf, BSIZE);
     c12:	40000613          	li	a2,1024
     c16:	85ca                	mv	a1,s2
     c18:	854e                	mv	a0,s3
     c1a:	00005097          	auipc	ra,0x5
     c1e:	fc8080e7          	jalr	-56(ra) # 5be2 <read>
    if(i == 0){
     c22:	c535                	beqz	a0,c8e <writebig+0x106>
    } else if(i != BSIZE){
     c24:	40000793          	li	a5,1024
     c28:	0af51f63          	bne	a0,a5,ce6 <writebig+0x15e>
    if(((int*)buf)[0] != n){
     c2c:	00092683          	lw	a3,0(s2)
     c30:	0c969a63          	bne	a3,s1,d04 <writebig+0x17c>
    n++;
     c34:	2485                	addw	s1,s1,1
    i = read(fd, buf, BSIZE);
     c36:	bff1                	j	c12 <writebig+0x8a>
    printf("%s: error: creat big failed!\n", s);
     c38:	85d6                	mv	a1,s5
     c3a:	00006517          	auipc	a0,0x6
     c3e:	aae50513          	add	a0,a0,-1362 # 66e8 <updateNode+0x484>
     c42:	00005097          	auipc	ra,0x5
     c46:	340080e7          	jalr	832(ra) # 5f82 <printf>
    exit(1);
     c4a:	4505                	li	a0,1
     c4c:	00005097          	auipc	ra,0x5
     c50:	f7e080e7          	jalr	-130(ra) # 5bca <exit>
      printf("%s: error: write big file failed\n", s, i);
     c54:	8626                	mv	a2,s1
     c56:	85d6                	mv	a1,s5
     c58:	00006517          	auipc	a0,0x6
     c5c:	ab050513          	add	a0,a0,-1360 # 6708 <updateNode+0x4a4>
     c60:	00005097          	auipc	ra,0x5
     c64:	322080e7          	jalr	802(ra) # 5f82 <printf>
      exit(1);
     c68:	4505                	li	a0,1
     c6a:	00005097          	auipc	ra,0x5
     c6e:	f60080e7          	jalr	-160(ra) # 5bca <exit>
    printf("%s: error: open big failed!\n", s);
     c72:	85d6                	mv	a1,s5
     c74:	00006517          	auipc	a0,0x6
     c78:	abc50513          	add	a0,a0,-1348 # 6730 <updateNode+0x4cc>
     c7c:	00005097          	auipc	ra,0x5
     c80:	306080e7          	jalr	774(ra) # 5f82 <printf>
    exit(1);
     c84:	4505                	li	a0,1
     c86:	00005097          	auipc	ra,0x5
     c8a:	f44080e7          	jalr	-188(ra) # 5bca <exit>
      if(n == MAXFILE - 1){
     c8e:	10b00793          	li	a5,267
     c92:	02f48a63          	beq	s1,a5,cc6 <writebig+0x13e>
  close(fd);
     c96:	854e                	mv	a0,s3
     c98:	00005097          	auipc	ra,0x5
     c9c:	f5a080e7          	jalr	-166(ra) # 5bf2 <close>
  if(unlink("big") < 0){
     ca0:	00006517          	auipc	a0,0x6
     ca4:	a4050513          	add	a0,a0,-1472 # 66e0 <updateNode+0x47c>
     ca8:	00005097          	auipc	ra,0x5
     cac:	f72080e7          	jalr	-142(ra) # 5c1a <unlink>
     cb0:	06054963          	bltz	a0,d22 <writebig+0x19a>
}
     cb4:	70e2                	ld	ra,56(sp)
     cb6:	7442                	ld	s0,48(sp)
     cb8:	74a2                	ld	s1,40(sp)
     cba:	7902                	ld	s2,32(sp)
     cbc:	69e2                	ld	s3,24(sp)
     cbe:	6a42                	ld	s4,16(sp)
     cc0:	6aa2                	ld	s5,8(sp)
     cc2:	6121                	add	sp,sp,64
     cc4:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     cc6:	10b00613          	li	a2,267
     cca:	85d6                	mv	a1,s5
     ccc:	00006517          	auipc	a0,0x6
     cd0:	a8450513          	add	a0,a0,-1404 # 6750 <updateNode+0x4ec>
     cd4:	00005097          	auipc	ra,0x5
     cd8:	2ae080e7          	jalr	686(ra) # 5f82 <printf>
        exit(1);
     cdc:	4505                	li	a0,1
     cde:	00005097          	auipc	ra,0x5
     ce2:	eec080e7          	jalr	-276(ra) # 5bca <exit>
      printf("%s: read failed %d\n", s, i);
     ce6:	862a                	mv	a2,a0
     ce8:	85d6                	mv	a1,s5
     cea:	00006517          	auipc	a0,0x6
     cee:	a8e50513          	add	a0,a0,-1394 # 6778 <updateNode+0x514>
     cf2:	00005097          	auipc	ra,0x5
     cf6:	290080e7          	jalr	656(ra) # 5f82 <printf>
      exit(1);
     cfa:	4505                	li	a0,1
     cfc:	00005097          	auipc	ra,0x5
     d00:	ece080e7          	jalr	-306(ra) # 5bca <exit>
      printf("%s: read content of block %d is %d\n", s,
     d04:	8626                	mv	a2,s1
     d06:	85d6                	mv	a1,s5
     d08:	00006517          	auipc	a0,0x6
     d0c:	a8850513          	add	a0,a0,-1400 # 6790 <updateNode+0x52c>
     d10:	00005097          	auipc	ra,0x5
     d14:	272080e7          	jalr	626(ra) # 5f82 <printf>
      exit(1);
     d18:	4505                	li	a0,1
     d1a:	00005097          	auipc	ra,0x5
     d1e:	eb0080e7          	jalr	-336(ra) # 5bca <exit>
    printf("%s: unlink big failed\n", s);
     d22:	85d6                	mv	a1,s5
     d24:	00006517          	auipc	a0,0x6
     d28:	a9450513          	add	a0,a0,-1388 # 67b8 <updateNode+0x554>
     d2c:	00005097          	auipc	ra,0x5
     d30:	256080e7          	jalr	598(ra) # 5f82 <printf>
    exit(1);
     d34:	4505                	li	a0,1
     d36:	00005097          	auipc	ra,0x5
     d3a:	e94080e7          	jalr	-364(ra) # 5bca <exit>

0000000000000d3e <unlinkread>:
{
     d3e:	7179                	add	sp,sp,-48
     d40:	f406                	sd	ra,40(sp)
     d42:	f022                	sd	s0,32(sp)
     d44:	ec26                	sd	s1,24(sp)
     d46:	e84a                	sd	s2,16(sp)
     d48:	e44e                	sd	s3,8(sp)
     d4a:	1800                	add	s0,sp,48
     d4c:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     d4e:	20200593          	li	a1,514
     d52:	00006517          	auipc	a0,0x6
     d56:	a7e50513          	add	a0,a0,-1410 # 67d0 <updateNode+0x56c>
     d5a:	00005097          	auipc	ra,0x5
     d5e:	eb0080e7          	jalr	-336(ra) # 5c0a <open>
  if(fd < 0){
     d62:	0e054563          	bltz	a0,e4c <unlinkread+0x10e>
     d66:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     d68:	4615                	li	a2,5
     d6a:	00006597          	auipc	a1,0x6
     d6e:	a9658593          	add	a1,a1,-1386 # 6800 <updateNode+0x59c>
     d72:	00005097          	auipc	ra,0x5
     d76:	e78080e7          	jalr	-392(ra) # 5bea <write>
  close(fd);
     d7a:	8526                	mv	a0,s1
     d7c:	00005097          	auipc	ra,0x5
     d80:	e76080e7          	jalr	-394(ra) # 5bf2 <close>
  fd = open("unlinkread", O_RDWR);
     d84:	4589                	li	a1,2
     d86:	00006517          	auipc	a0,0x6
     d8a:	a4a50513          	add	a0,a0,-1462 # 67d0 <updateNode+0x56c>
     d8e:	00005097          	auipc	ra,0x5
     d92:	e7c080e7          	jalr	-388(ra) # 5c0a <open>
     d96:	84aa                	mv	s1,a0
  if(fd < 0){
     d98:	0c054863          	bltz	a0,e68 <unlinkread+0x12a>
  if(unlink("unlinkread") != 0){
     d9c:	00006517          	auipc	a0,0x6
     da0:	a3450513          	add	a0,a0,-1484 # 67d0 <updateNode+0x56c>
     da4:	00005097          	auipc	ra,0x5
     da8:	e76080e7          	jalr	-394(ra) # 5c1a <unlink>
     dac:	ed61                	bnez	a0,e84 <unlinkread+0x146>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     dae:	20200593          	li	a1,514
     db2:	00006517          	auipc	a0,0x6
     db6:	a1e50513          	add	a0,a0,-1506 # 67d0 <updateNode+0x56c>
     dba:	00005097          	auipc	ra,0x5
     dbe:	e50080e7          	jalr	-432(ra) # 5c0a <open>
     dc2:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     dc4:	460d                	li	a2,3
     dc6:	00006597          	auipc	a1,0x6
     dca:	a8258593          	add	a1,a1,-1406 # 6848 <updateNode+0x5e4>
     dce:	00005097          	auipc	ra,0x5
     dd2:	e1c080e7          	jalr	-484(ra) # 5bea <write>
  close(fd1);
     dd6:	854a                	mv	a0,s2
     dd8:	00005097          	auipc	ra,0x5
     ddc:	e1a080e7          	jalr	-486(ra) # 5bf2 <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     de0:	660d                	lui	a2,0x3
     de2:	0000c597          	auipc	a1,0xc
     de6:	e9658593          	add	a1,a1,-362 # cc78 <buf>
     dea:	8526                	mv	a0,s1
     dec:	00005097          	auipc	ra,0x5
     df0:	df6080e7          	jalr	-522(ra) # 5be2 <read>
     df4:	4795                	li	a5,5
     df6:	0af51563          	bne	a0,a5,ea0 <unlinkread+0x162>
  if(buf[0] != 'h'){
     dfa:	0000c717          	auipc	a4,0xc
     dfe:	e7e74703          	lbu	a4,-386(a4) # cc78 <buf>
     e02:	06800793          	li	a5,104
     e06:	0af71b63          	bne	a4,a5,ebc <unlinkread+0x17e>
  if(write(fd, buf, 10) != 10){
     e0a:	4629                	li	a2,10
     e0c:	0000c597          	auipc	a1,0xc
     e10:	e6c58593          	add	a1,a1,-404 # cc78 <buf>
     e14:	8526                	mv	a0,s1
     e16:	00005097          	auipc	ra,0x5
     e1a:	dd4080e7          	jalr	-556(ra) # 5bea <write>
     e1e:	47a9                	li	a5,10
     e20:	0af51c63          	bne	a0,a5,ed8 <unlinkread+0x19a>
  close(fd);
     e24:	8526                	mv	a0,s1
     e26:	00005097          	auipc	ra,0x5
     e2a:	dcc080e7          	jalr	-564(ra) # 5bf2 <close>
  unlink("unlinkread");
     e2e:	00006517          	auipc	a0,0x6
     e32:	9a250513          	add	a0,a0,-1630 # 67d0 <updateNode+0x56c>
     e36:	00005097          	auipc	ra,0x5
     e3a:	de4080e7          	jalr	-540(ra) # 5c1a <unlink>
}
     e3e:	70a2                	ld	ra,40(sp)
     e40:	7402                	ld	s0,32(sp)
     e42:	64e2                	ld	s1,24(sp)
     e44:	6942                	ld	s2,16(sp)
     e46:	69a2                	ld	s3,8(sp)
     e48:	6145                	add	sp,sp,48
     e4a:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     e4c:	85ce                	mv	a1,s3
     e4e:	00006517          	auipc	a0,0x6
     e52:	99250513          	add	a0,a0,-1646 # 67e0 <updateNode+0x57c>
     e56:	00005097          	auipc	ra,0x5
     e5a:	12c080e7          	jalr	300(ra) # 5f82 <printf>
    exit(1);
     e5e:	4505                	li	a0,1
     e60:	00005097          	auipc	ra,0x5
     e64:	d6a080e7          	jalr	-662(ra) # 5bca <exit>
    printf("%s: open unlinkread failed\n", s);
     e68:	85ce                	mv	a1,s3
     e6a:	00006517          	auipc	a0,0x6
     e6e:	99e50513          	add	a0,a0,-1634 # 6808 <updateNode+0x5a4>
     e72:	00005097          	auipc	ra,0x5
     e76:	110080e7          	jalr	272(ra) # 5f82 <printf>
    exit(1);
     e7a:	4505                	li	a0,1
     e7c:	00005097          	auipc	ra,0x5
     e80:	d4e080e7          	jalr	-690(ra) # 5bca <exit>
    printf("%s: unlink unlinkread failed\n", s);
     e84:	85ce                	mv	a1,s3
     e86:	00006517          	auipc	a0,0x6
     e8a:	9a250513          	add	a0,a0,-1630 # 6828 <updateNode+0x5c4>
     e8e:	00005097          	auipc	ra,0x5
     e92:	0f4080e7          	jalr	244(ra) # 5f82 <printf>
    exit(1);
     e96:	4505                	li	a0,1
     e98:	00005097          	auipc	ra,0x5
     e9c:	d32080e7          	jalr	-718(ra) # 5bca <exit>
    printf("%s: unlinkread read failed", s);
     ea0:	85ce                	mv	a1,s3
     ea2:	00006517          	auipc	a0,0x6
     ea6:	9ae50513          	add	a0,a0,-1618 # 6850 <updateNode+0x5ec>
     eaa:	00005097          	auipc	ra,0x5
     eae:	0d8080e7          	jalr	216(ra) # 5f82 <printf>
    exit(1);
     eb2:	4505                	li	a0,1
     eb4:	00005097          	auipc	ra,0x5
     eb8:	d16080e7          	jalr	-746(ra) # 5bca <exit>
    printf("%s: unlinkread wrong data\n", s);
     ebc:	85ce                	mv	a1,s3
     ebe:	00006517          	auipc	a0,0x6
     ec2:	9b250513          	add	a0,a0,-1614 # 6870 <updateNode+0x60c>
     ec6:	00005097          	auipc	ra,0x5
     eca:	0bc080e7          	jalr	188(ra) # 5f82 <printf>
    exit(1);
     ece:	4505                	li	a0,1
     ed0:	00005097          	auipc	ra,0x5
     ed4:	cfa080e7          	jalr	-774(ra) # 5bca <exit>
    printf("%s: unlinkread write failed\n", s);
     ed8:	85ce                	mv	a1,s3
     eda:	00006517          	auipc	a0,0x6
     ede:	9b650513          	add	a0,a0,-1610 # 6890 <updateNode+0x62c>
     ee2:	00005097          	auipc	ra,0x5
     ee6:	0a0080e7          	jalr	160(ra) # 5f82 <printf>
    exit(1);
     eea:	4505                	li	a0,1
     eec:	00005097          	auipc	ra,0x5
     ef0:	cde080e7          	jalr	-802(ra) # 5bca <exit>

0000000000000ef4 <linktest>:
{
     ef4:	1101                	add	sp,sp,-32
     ef6:	ec06                	sd	ra,24(sp)
     ef8:	e822                	sd	s0,16(sp)
     efa:	e426                	sd	s1,8(sp)
     efc:	e04a                	sd	s2,0(sp)
     efe:	1000                	add	s0,sp,32
     f00:	892a                	mv	s2,a0
  unlink("lf1");
     f02:	00006517          	auipc	a0,0x6
     f06:	9ae50513          	add	a0,a0,-1618 # 68b0 <updateNode+0x64c>
     f0a:	00005097          	auipc	ra,0x5
     f0e:	d10080e7          	jalr	-752(ra) # 5c1a <unlink>
  unlink("lf2");
     f12:	00006517          	auipc	a0,0x6
     f16:	9a650513          	add	a0,a0,-1626 # 68b8 <updateNode+0x654>
     f1a:	00005097          	auipc	ra,0x5
     f1e:	d00080e7          	jalr	-768(ra) # 5c1a <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
     f22:	20200593          	li	a1,514
     f26:	00006517          	auipc	a0,0x6
     f2a:	98a50513          	add	a0,a0,-1654 # 68b0 <updateNode+0x64c>
     f2e:	00005097          	auipc	ra,0x5
     f32:	cdc080e7          	jalr	-804(ra) # 5c0a <open>
  if(fd < 0){
     f36:	10054763          	bltz	a0,1044 <linktest+0x150>
     f3a:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
     f3c:	4615                	li	a2,5
     f3e:	00006597          	auipc	a1,0x6
     f42:	8c258593          	add	a1,a1,-1854 # 6800 <updateNode+0x59c>
     f46:	00005097          	auipc	ra,0x5
     f4a:	ca4080e7          	jalr	-860(ra) # 5bea <write>
     f4e:	4795                	li	a5,5
     f50:	10f51863          	bne	a0,a5,1060 <linktest+0x16c>
  close(fd);
     f54:	8526                	mv	a0,s1
     f56:	00005097          	auipc	ra,0x5
     f5a:	c9c080e7          	jalr	-868(ra) # 5bf2 <close>
  if(link("lf1", "lf2") < 0){
     f5e:	00006597          	auipc	a1,0x6
     f62:	95a58593          	add	a1,a1,-1702 # 68b8 <updateNode+0x654>
     f66:	00006517          	auipc	a0,0x6
     f6a:	94a50513          	add	a0,a0,-1718 # 68b0 <updateNode+0x64c>
     f6e:	00005097          	auipc	ra,0x5
     f72:	cbc080e7          	jalr	-836(ra) # 5c2a <link>
     f76:	10054363          	bltz	a0,107c <linktest+0x188>
  unlink("lf1");
     f7a:	00006517          	auipc	a0,0x6
     f7e:	93650513          	add	a0,a0,-1738 # 68b0 <updateNode+0x64c>
     f82:	00005097          	auipc	ra,0x5
     f86:	c98080e7          	jalr	-872(ra) # 5c1a <unlink>
  if(open("lf1", 0) >= 0){
     f8a:	4581                	li	a1,0
     f8c:	00006517          	auipc	a0,0x6
     f90:	92450513          	add	a0,a0,-1756 # 68b0 <updateNode+0x64c>
     f94:	00005097          	auipc	ra,0x5
     f98:	c76080e7          	jalr	-906(ra) # 5c0a <open>
     f9c:	0e055e63          	bgez	a0,1098 <linktest+0x1a4>
  fd = open("lf2", 0);
     fa0:	4581                	li	a1,0
     fa2:	00006517          	auipc	a0,0x6
     fa6:	91650513          	add	a0,a0,-1770 # 68b8 <updateNode+0x654>
     faa:	00005097          	auipc	ra,0x5
     fae:	c60080e7          	jalr	-928(ra) # 5c0a <open>
     fb2:	84aa                	mv	s1,a0
  if(fd < 0){
     fb4:	10054063          	bltz	a0,10b4 <linktest+0x1c0>
  if(read(fd, buf, sizeof(buf)) != SZ){
     fb8:	660d                	lui	a2,0x3
     fba:	0000c597          	auipc	a1,0xc
     fbe:	cbe58593          	add	a1,a1,-834 # cc78 <buf>
     fc2:	00005097          	auipc	ra,0x5
     fc6:	c20080e7          	jalr	-992(ra) # 5be2 <read>
     fca:	4795                	li	a5,5
     fcc:	10f51263          	bne	a0,a5,10d0 <linktest+0x1dc>
  close(fd);
     fd0:	8526                	mv	a0,s1
     fd2:	00005097          	auipc	ra,0x5
     fd6:	c20080e7          	jalr	-992(ra) # 5bf2 <close>
  if(link("lf2", "lf2") >= 0){
     fda:	00006597          	auipc	a1,0x6
     fde:	8de58593          	add	a1,a1,-1826 # 68b8 <updateNode+0x654>
     fe2:	852e                	mv	a0,a1
     fe4:	00005097          	auipc	ra,0x5
     fe8:	c46080e7          	jalr	-954(ra) # 5c2a <link>
     fec:	10055063          	bgez	a0,10ec <linktest+0x1f8>
  unlink("lf2");
     ff0:	00006517          	auipc	a0,0x6
     ff4:	8c850513          	add	a0,a0,-1848 # 68b8 <updateNode+0x654>
     ff8:	00005097          	auipc	ra,0x5
     ffc:	c22080e7          	jalr	-990(ra) # 5c1a <unlink>
  if(link("lf2", "lf1") >= 0){
    1000:	00006597          	auipc	a1,0x6
    1004:	8b058593          	add	a1,a1,-1872 # 68b0 <updateNode+0x64c>
    1008:	00006517          	auipc	a0,0x6
    100c:	8b050513          	add	a0,a0,-1872 # 68b8 <updateNode+0x654>
    1010:	00005097          	auipc	ra,0x5
    1014:	c1a080e7          	jalr	-998(ra) # 5c2a <link>
    1018:	0e055863          	bgez	a0,1108 <linktest+0x214>
  if(link(".", "lf1") >= 0){
    101c:	00006597          	auipc	a1,0x6
    1020:	89458593          	add	a1,a1,-1900 # 68b0 <updateNode+0x64c>
    1024:	00006517          	auipc	a0,0x6
    1028:	99c50513          	add	a0,a0,-1636 # 69c0 <updateNode+0x75c>
    102c:	00005097          	auipc	ra,0x5
    1030:	bfe080e7          	jalr	-1026(ra) # 5c2a <link>
    1034:	0e055863          	bgez	a0,1124 <linktest+0x230>
}
    1038:	60e2                	ld	ra,24(sp)
    103a:	6442                	ld	s0,16(sp)
    103c:	64a2                	ld	s1,8(sp)
    103e:	6902                	ld	s2,0(sp)
    1040:	6105                	add	sp,sp,32
    1042:	8082                	ret
    printf("%s: create lf1 failed\n", s);
    1044:	85ca                	mv	a1,s2
    1046:	00006517          	auipc	a0,0x6
    104a:	87a50513          	add	a0,a0,-1926 # 68c0 <updateNode+0x65c>
    104e:	00005097          	auipc	ra,0x5
    1052:	f34080e7          	jalr	-204(ra) # 5f82 <printf>
    exit(1);
    1056:	4505                	li	a0,1
    1058:	00005097          	auipc	ra,0x5
    105c:	b72080e7          	jalr	-1166(ra) # 5bca <exit>
    printf("%s: write lf1 failed\n", s);
    1060:	85ca                	mv	a1,s2
    1062:	00006517          	auipc	a0,0x6
    1066:	87650513          	add	a0,a0,-1930 # 68d8 <updateNode+0x674>
    106a:	00005097          	auipc	ra,0x5
    106e:	f18080e7          	jalr	-232(ra) # 5f82 <printf>
    exit(1);
    1072:	4505                	li	a0,1
    1074:	00005097          	auipc	ra,0x5
    1078:	b56080e7          	jalr	-1194(ra) # 5bca <exit>
    printf("%s: link lf1 lf2 failed\n", s);
    107c:	85ca                	mv	a1,s2
    107e:	00006517          	auipc	a0,0x6
    1082:	87250513          	add	a0,a0,-1934 # 68f0 <updateNode+0x68c>
    1086:	00005097          	auipc	ra,0x5
    108a:	efc080e7          	jalr	-260(ra) # 5f82 <printf>
    exit(1);
    108e:	4505                	li	a0,1
    1090:	00005097          	auipc	ra,0x5
    1094:	b3a080e7          	jalr	-1222(ra) # 5bca <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
    1098:	85ca                	mv	a1,s2
    109a:	00006517          	auipc	a0,0x6
    109e:	87650513          	add	a0,a0,-1930 # 6910 <updateNode+0x6ac>
    10a2:	00005097          	auipc	ra,0x5
    10a6:	ee0080e7          	jalr	-288(ra) # 5f82 <printf>
    exit(1);
    10aa:	4505                	li	a0,1
    10ac:	00005097          	auipc	ra,0x5
    10b0:	b1e080e7          	jalr	-1250(ra) # 5bca <exit>
    printf("%s: open lf2 failed\n", s);
    10b4:	85ca                	mv	a1,s2
    10b6:	00006517          	auipc	a0,0x6
    10ba:	88a50513          	add	a0,a0,-1910 # 6940 <updateNode+0x6dc>
    10be:	00005097          	auipc	ra,0x5
    10c2:	ec4080e7          	jalr	-316(ra) # 5f82 <printf>
    exit(1);
    10c6:	4505                	li	a0,1
    10c8:	00005097          	auipc	ra,0x5
    10cc:	b02080e7          	jalr	-1278(ra) # 5bca <exit>
    printf("%s: read lf2 failed\n", s);
    10d0:	85ca                	mv	a1,s2
    10d2:	00006517          	auipc	a0,0x6
    10d6:	88650513          	add	a0,a0,-1914 # 6958 <updateNode+0x6f4>
    10da:	00005097          	auipc	ra,0x5
    10de:	ea8080e7          	jalr	-344(ra) # 5f82 <printf>
    exit(1);
    10e2:	4505                	li	a0,1
    10e4:	00005097          	auipc	ra,0x5
    10e8:	ae6080e7          	jalr	-1306(ra) # 5bca <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
    10ec:	85ca                	mv	a1,s2
    10ee:	00006517          	auipc	a0,0x6
    10f2:	88250513          	add	a0,a0,-1918 # 6970 <updateNode+0x70c>
    10f6:	00005097          	auipc	ra,0x5
    10fa:	e8c080e7          	jalr	-372(ra) # 5f82 <printf>
    exit(1);
    10fe:	4505                	li	a0,1
    1100:	00005097          	auipc	ra,0x5
    1104:	aca080e7          	jalr	-1334(ra) # 5bca <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
    1108:	85ca                	mv	a1,s2
    110a:	00006517          	auipc	a0,0x6
    110e:	88e50513          	add	a0,a0,-1906 # 6998 <updateNode+0x734>
    1112:	00005097          	auipc	ra,0x5
    1116:	e70080e7          	jalr	-400(ra) # 5f82 <printf>
    exit(1);
    111a:	4505                	li	a0,1
    111c:	00005097          	auipc	ra,0x5
    1120:	aae080e7          	jalr	-1362(ra) # 5bca <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
    1124:	85ca                	mv	a1,s2
    1126:	00006517          	auipc	a0,0x6
    112a:	8a250513          	add	a0,a0,-1886 # 69c8 <updateNode+0x764>
    112e:	00005097          	auipc	ra,0x5
    1132:	e54080e7          	jalr	-428(ra) # 5f82 <printf>
    exit(1);
    1136:	4505                	li	a0,1
    1138:	00005097          	auipc	ra,0x5
    113c:	a92080e7          	jalr	-1390(ra) # 5bca <exit>

0000000000001140 <validatetest>:
{
    1140:	7139                	add	sp,sp,-64
    1142:	fc06                	sd	ra,56(sp)
    1144:	f822                	sd	s0,48(sp)
    1146:	f426                	sd	s1,40(sp)
    1148:	f04a                	sd	s2,32(sp)
    114a:	ec4e                	sd	s3,24(sp)
    114c:	e852                	sd	s4,16(sp)
    114e:	e456                	sd	s5,8(sp)
    1150:	e05a                	sd	s6,0(sp)
    1152:	0080                	add	s0,sp,64
    1154:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    1156:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
    1158:	00006997          	auipc	s3,0x6
    115c:	89098993          	add	s3,s3,-1904 # 69e8 <updateNode+0x784>
    1160:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    1162:	6a85                	lui	s5,0x1
    1164:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
    1168:	85a6                	mv	a1,s1
    116a:	854e                	mv	a0,s3
    116c:	00005097          	auipc	ra,0x5
    1170:	abe080e7          	jalr	-1346(ra) # 5c2a <link>
    1174:	01251f63          	bne	a0,s2,1192 <validatetest+0x52>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    1178:	94d6                	add	s1,s1,s5
    117a:	ff4497e3          	bne	s1,s4,1168 <validatetest+0x28>
}
    117e:	70e2                	ld	ra,56(sp)
    1180:	7442                	ld	s0,48(sp)
    1182:	74a2                	ld	s1,40(sp)
    1184:	7902                	ld	s2,32(sp)
    1186:	69e2                	ld	s3,24(sp)
    1188:	6a42                	ld	s4,16(sp)
    118a:	6aa2                	ld	s5,8(sp)
    118c:	6b02                	ld	s6,0(sp)
    118e:	6121                	add	sp,sp,64
    1190:	8082                	ret
      printf("%s: link should not succeed\n", s);
    1192:	85da                	mv	a1,s6
    1194:	00006517          	auipc	a0,0x6
    1198:	86450513          	add	a0,a0,-1948 # 69f8 <updateNode+0x794>
    119c:	00005097          	auipc	ra,0x5
    11a0:	de6080e7          	jalr	-538(ra) # 5f82 <printf>
      exit(1);
    11a4:	4505                	li	a0,1
    11a6:	00005097          	auipc	ra,0x5
    11aa:	a24080e7          	jalr	-1500(ra) # 5bca <exit>

00000000000011ae <bigdir>:
{
    11ae:	715d                	add	sp,sp,-80
    11b0:	e486                	sd	ra,72(sp)
    11b2:	e0a2                	sd	s0,64(sp)
    11b4:	fc26                	sd	s1,56(sp)
    11b6:	f84a                	sd	s2,48(sp)
    11b8:	f44e                	sd	s3,40(sp)
    11ba:	f052                	sd	s4,32(sp)
    11bc:	ec56                	sd	s5,24(sp)
    11be:	e85a                	sd	s6,16(sp)
    11c0:	0880                	add	s0,sp,80
    11c2:	89aa                	mv	s3,a0
  unlink("bd");
    11c4:	00006517          	auipc	a0,0x6
    11c8:	85450513          	add	a0,a0,-1964 # 6a18 <updateNode+0x7b4>
    11cc:	00005097          	auipc	ra,0x5
    11d0:	a4e080e7          	jalr	-1458(ra) # 5c1a <unlink>
  fd = open("bd", O_CREATE);
    11d4:	20000593          	li	a1,512
    11d8:	00006517          	auipc	a0,0x6
    11dc:	84050513          	add	a0,a0,-1984 # 6a18 <updateNode+0x7b4>
    11e0:	00005097          	auipc	ra,0x5
    11e4:	a2a080e7          	jalr	-1494(ra) # 5c0a <open>
  if(fd < 0){
    11e8:	0c054963          	bltz	a0,12ba <bigdir+0x10c>
  close(fd);
    11ec:	00005097          	auipc	ra,0x5
    11f0:	a06080e7          	jalr	-1530(ra) # 5bf2 <close>
  for(i = 0; i < N; i++){
    11f4:	4901                	li	s2,0
    name[0] = 'x';
    11f6:	07800a93          	li	s5,120
    if(link("bd", name) != 0){
    11fa:	00006a17          	auipc	s4,0x6
    11fe:	81ea0a13          	add	s4,s4,-2018 # 6a18 <updateNode+0x7b4>
  for(i = 0; i < N; i++){
    1202:	1f400b13          	li	s6,500
    name[0] = 'x';
    1206:	fb540823          	sb	s5,-80(s0)
    name[1] = '0' + (i / 64);
    120a:	41f9571b          	sraw	a4,s2,0x1f
    120e:	01a7571b          	srlw	a4,a4,0x1a
    1212:	012707bb          	addw	a5,a4,s2
    1216:	4067d69b          	sraw	a3,a5,0x6
    121a:	0306869b          	addw	a3,a3,48
    121e:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    1222:	03f7f793          	and	a5,a5,63
    1226:	9f99                	subw	a5,a5,a4
    1228:	0307879b          	addw	a5,a5,48
    122c:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    1230:	fa0409a3          	sb	zero,-77(s0)
    if(link("bd", name) != 0){
    1234:	fb040593          	add	a1,s0,-80
    1238:	8552                	mv	a0,s4
    123a:	00005097          	auipc	ra,0x5
    123e:	9f0080e7          	jalr	-1552(ra) # 5c2a <link>
    1242:	84aa                	mv	s1,a0
    1244:	e949                	bnez	a0,12d6 <bigdir+0x128>
  for(i = 0; i < N; i++){
    1246:	2905                	addw	s2,s2,1
    1248:	fb691fe3          	bne	s2,s6,1206 <bigdir+0x58>
  unlink("bd");
    124c:	00005517          	auipc	a0,0x5
    1250:	7cc50513          	add	a0,a0,1996 # 6a18 <updateNode+0x7b4>
    1254:	00005097          	auipc	ra,0x5
    1258:	9c6080e7          	jalr	-1594(ra) # 5c1a <unlink>
    name[0] = 'x';
    125c:	07800913          	li	s2,120
  for(i = 0; i < N; i++){
    1260:	1f400a13          	li	s4,500
    name[0] = 'x';
    1264:	fb240823          	sb	s2,-80(s0)
    name[1] = '0' + (i / 64);
    1268:	41f4d71b          	sraw	a4,s1,0x1f
    126c:	01a7571b          	srlw	a4,a4,0x1a
    1270:	009707bb          	addw	a5,a4,s1
    1274:	4067d69b          	sraw	a3,a5,0x6
    1278:	0306869b          	addw	a3,a3,48
    127c:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    1280:	03f7f793          	and	a5,a5,63
    1284:	9f99                	subw	a5,a5,a4
    1286:	0307879b          	addw	a5,a5,48
    128a:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    128e:	fa0409a3          	sb	zero,-77(s0)
    if(unlink(name) != 0){
    1292:	fb040513          	add	a0,s0,-80
    1296:	00005097          	auipc	ra,0x5
    129a:	984080e7          	jalr	-1660(ra) # 5c1a <unlink>
    129e:	ed21                	bnez	a0,12f6 <bigdir+0x148>
  for(i = 0; i < N; i++){
    12a0:	2485                	addw	s1,s1,1
    12a2:	fd4491e3          	bne	s1,s4,1264 <bigdir+0xb6>
}
    12a6:	60a6                	ld	ra,72(sp)
    12a8:	6406                	ld	s0,64(sp)
    12aa:	74e2                	ld	s1,56(sp)
    12ac:	7942                	ld	s2,48(sp)
    12ae:	79a2                	ld	s3,40(sp)
    12b0:	7a02                	ld	s4,32(sp)
    12b2:	6ae2                	ld	s5,24(sp)
    12b4:	6b42                	ld	s6,16(sp)
    12b6:	6161                	add	sp,sp,80
    12b8:	8082                	ret
    printf("%s: bigdir create failed\n", s);
    12ba:	85ce                	mv	a1,s3
    12bc:	00005517          	auipc	a0,0x5
    12c0:	76450513          	add	a0,a0,1892 # 6a20 <updateNode+0x7bc>
    12c4:	00005097          	auipc	ra,0x5
    12c8:	cbe080e7          	jalr	-834(ra) # 5f82 <printf>
    exit(1);
    12cc:	4505                	li	a0,1
    12ce:	00005097          	auipc	ra,0x5
    12d2:	8fc080e7          	jalr	-1796(ra) # 5bca <exit>
      printf("%s: bigdir link(bd, %s) failed\n", s, name);
    12d6:	fb040613          	add	a2,s0,-80
    12da:	85ce                	mv	a1,s3
    12dc:	00005517          	auipc	a0,0x5
    12e0:	76450513          	add	a0,a0,1892 # 6a40 <updateNode+0x7dc>
    12e4:	00005097          	auipc	ra,0x5
    12e8:	c9e080e7          	jalr	-866(ra) # 5f82 <printf>
      exit(1);
    12ec:	4505                	li	a0,1
    12ee:	00005097          	auipc	ra,0x5
    12f2:	8dc080e7          	jalr	-1828(ra) # 5bca <exit>
      printf("%s: bigdir unlink failed", s);
    12f6:	85ce                	mv	a1,s3
    12f8:	00005517          	auipc	a0,0x5
    12fc:	76850513          	add	a0,a0,1896 # 6a60 <updateNode+0x7fc>
    1300:	00005097          	auipc	ra,0x5
    1304:	c82080e7          	jalr	-894(ra) # 5f82 <printf>
      exit(1);
    1308:	4505                	li	a0,1
    130a:	00005097          	auipc	ra,0x5
    130e:	8c0080e7          	jalr	-1856(ra) # 5bca <exit>

0000000000001312 <pgbug>:
{
    1312:	7179                	add	sp,sp,-48
    1314:	f406                	sd	ra,40(sp)
    1316:	f022                	sd	s0,32(sp)
    1318:	ec26                	sd	s1,24(sp)
    131a:	1800                	add	s0,sp,48
  argv[0] = 0;
    131c:	fc043c23          	sd	zero,-40(s0)
  exec(big, argv);
    1320:	00008497          	auipc	s1,0x8
    1324:	ce048493          	add	s1,s1,-800 # 9000 <big>
    1328:	fd840593          	add	a1,s0,-40
    132c:	6088                	ld	a0,0(s1)
    132e:	00005097          	auipc	ra,0x5
    1332:	8d4080e7          	jalr	-1836(ra) # 5c02 <exec>
  pipe(big);
    1336:	6088                	ld	a0,0(s1)
    1338:	00005097          	auipc	ra,0x5
    133c:	8a2080e7          	jalr	-1886(ra) # 5bda <pipe>
  exit(0);
    1340:	4501                	li	a0,0
    1342:	00005097          	auipc	ra,0x5
    1346:	888080e7          	jalr	-1912(ra) # 5bca <exit>

000000000000134a <badarg>:
{
    134a:	7139                	add	sp,sp,-64
    134c:	fc06                	sd	ra,56(sp)
    134e:	f822                	sd	s0,48(sp)
    1350:	f426                	sd	s1,40(sp)
    1352:	f04a                	sd	s2,32(sp)
    1354:	ec4e                	sd	s3,24(sp)
    1356:	0080                	add	s0,sp,64
    1358:	64b1                	lui	s1,0xc
    135a:	35048493          	add	s1,s1,848 # c350 <uninit+0x1de8>
    argv[0] = (char*)0xffffffff;
    135e:	597d                	li	s2,-1
    1360:	02095913          	srl	s2,s2,0x20
    exec("echo", argv);
    1364:	00005997          	auipc	s3,0x5
    1368:	f7498993          	add	s3,s3,-140 # 62d8 <updateNode+0x74>
    argv[0] = (char*)0xffffffff;
    136c:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    1370:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    1374:	fc040593          	add	a1,s0,-64
    1378:	854e                	mv	a0,s3
    137a:	00005097          	auipc	ra,0x5
    137e:	888080e7          	jalr	-1912(ra) # 5c02 <exec>
  for(int i = 0; i < 50000; i++){
    1382:	34fd                	addw	s1,s1,-1
    1384:	f4e5                	bnez	s1,136c <badarg+0x22>
  exit(0);
    1386:	4501                	li	a0,0
    1388:	00005097          	auipc	ra,0x5
    138c:	842080e7          	jalr	-1982(ra) # 5bca <exit>

0000000000001390 <copyinstr2>:
{
    1390:	7155                	add	sp,sp,-208
    1392:	e586                	sd	ra,200(sp)
    1394:	e1a2                	sd	s0,192(sp)
    1396:	0980                	add	s0,sp,208
  for(int i = 0; i < MAXPATH; i++)
    1398:	f6840793          	add	a5,s0,-152
    139c:	fe840693          	add	a3,s0,-24
    b[i] = 'x';
    13a0:	07800713          	li	a4,120
    13a4:	00e78023          	sb	a4,0(a5)
  for(int i = 0; i < MAXPATH; i++)
    13a8:	0785                	add	a5,a5,1
    13aa:	fed79de3          	bne	a5,a3,13a4 <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    13ae:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    13b2:	f6840513          	add	a0,s0,-152
    13b6:	00005097          	auipc	ra,0x5
    13ba:	864080e7          	jalr	-1948(ra) # 5c1a <unlink>
  if(ret != -1){
    13be:	57fd                	li	a5,-1
    13c0:	0ef51063          	bne	a0,a5,14a0 <copyinstr2+0x110>
  int fd = open(b, O_CREATE | O_WRONLY);
    13c4:	20100593          	li	a1,513
    13c8:	f6840513          	add	a0,s0,-152
    13cc:	00005097          	auipc	ra,0x5
    13d0:	83e080e7          	jalr	-1986(ra) # 5c0a <open>
  if(fd != -1){
    13d4:	57fd                	li	a5,-1
    13d6:	0ef51563          	bne	a0,a5,14c0 <copyinstr2+0x130>
  ret = link(b, b);
    13da:	f6840593          	add	a1,s0,-152
    13de:	852e                	mv	a0,a1
    13e0:	00005097          	auipc	ra,0x5
    13e4:	84a080e7          	jalr	-1974(ra) # 5c2a <link>
  if(ret != -1){
    13e8:	57fd                	li	a5,-1
    13ea:	0ef51b63          	bne	a0,a5,14e0 <copyinstr2+0x150>
  char *args[] = { "xx", 0 };
    13ee:	00007797          	auipc	a5,0x7
    13f2:	8ca78793          	add	a5,a5,-1846 # 7cb8 <updateNode+0x1a54>
    13f6:	f4f43c23          	sd	a5,-168(s0)
    13fa:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    13fe:	f5840593          	add	a1,s0,-168
    1402:	f6840513          	add	a0,s0,-152
    1406:	00004097          	auipc	ra,0x4
    140a:	7fc080e7          	jalr	2044(ra) # 5c02 <exec>
  if(ret != -1){
    140e:	57fd                	li	a5,-1
    1410:	0ef51963          	bne	a0,a5,1502 <copyinstr2+0x172>
  int pid = fork();
    1414:	00004097          	auipc	ra,0x4
    1418:	7ae080e7          	jalr	1966(ra) # 5bc2 <fork>
  if(pid < 0){
    141c:	10054363          	bltz	a0,1522 <copyinstr2+0x192>
  if(pid == 0){
    1420:	12051463          	bnez	a0,1548 <copyinstr2+0x1b8>
    1424:	00008797          	auipc	a5,0x8
    1428:	13c78793          	add	a5,a5,316 # 9560 <big.0>
    142c:	00009697          	auipc	a3,0x9
    1430:	13468693          	add	a3,a3,308 # a560 <big.0+0x1000>
      big[i] = 'x';
    1434:	07800713          	li	a4,120
    1438:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
    143c:	0785                	add	a5,a5,1
    143e:	fed79de3          	bne	a5,a3,1438 <copyinstr2+0xa8>
    big[PGSIZE] = '\0';
    1442:	00009797          	auipc	a5,0x9
    1446:	10078f23          	sb	zero,286(a5) # a560 <big.0+0x1000>
    char *args2[] = { big, big, big, 0 };
    144a:	00007797          	auipc	a5,0x7
    144e:	2ae78793          	add	a5,a5,686 # 86f8 <updateNode+0x2494>
    1452:	6390                	ld	a2,0(a5)
    1454:	6794                	ld	a3,8(a5)
    1456:	6b98                	ld	a4,16(a5)
    1458:	6f9c                	ld	a5,24(a5)
    145a:	f2c43823          	sd	a2,-208(s0)
    145e:	f2d43c23          	sd	a3,-200(s0)
    1462:	f4e43023          	sd	a4,-192(s0)
    1466:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    146a:	f3040593          	add	a1,s0,-208
    146e:	00005517          	auipc	a0,0x5
    1472:	e6a50513          	add	a0,a0,-406 # 62d8 <updateNode+0x74>
    1476:	00004097          	auipc	ra,0x4
    147a:	78c080e7          	jalr	1932(ra) # 5c02 <exec>
    if(ret != -1){
    147e:	57fd                	li	a5,-1
    1480:	0af50e63          	beq	a0,a5,153c <copyinstr2+0x1ac>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    1484:	55fd                	li	a1,-1
    1486:	00005517          	auipc	a0,0x5
    148a:	68250513          	add	a0,a0,1666 # 6b08 <updateNode+0x8a4>
    148e:	00005097          	auipc	ra,0x5
    1492:	af4080e7          	jalr	-1292(ra) # 5f82 <printf>
      exit(1);
    1496:	4505                	li	a0,1
    1498:	00004097          	auipc	ra,0x4
    149c:	732080e7          	jalr	1842(ra) # 5bca <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    14a0:	862a                	mv	a2,a0
    14a2:	f6840593          	add	a1,s0,-152
    14a6:	00005517          	auipc	a0,0x5
    14aa:	5da50513          	add	a0,a0,1498 # 6a80 <updateNode+0x81c>
    14ae:	00005097          	auipc	ra,0x5
    14b2:	ad4080e7          	jalr	-1324(ra) # 5f82 <printf>
    exit(1);
    14b6:	4505                	li	a0,1
    14b8:	00004097          	auipc	ra,0x4
    14bc:	712080e7          	jalr	1810(ra) # 5bca <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    14c0:	862a                	mv	a2,a0
    14c2:	f6840593          	add	a1,s0,-152
    14c6:	00005517          	auipc	a0,0x5
    14ca:	5da50513          	add	a0,a0,1498 # 6aa0 <updateNode+0x83c>
    14ce:	00005097          	auipc	ra,0x5
    14d2:	ab4080e7          	jalr	-1356(ra) # 5f82 <printf>
    exit(1);
    14d6:	4505                	li	a0,1
    14d8:	00004097          	auipc	ra,0x4
    14dc:	6f2080e7          	jalr	1778(ra) # 5bca <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    14e0:	86aa                	mv	a3,a0
    14e2:	f6840613          	add	a2,s0,-152
    14e6:	85b2                	mv	a1,a2
    14e8:	00005517          	auipc	a0,0x5
    14ec:	5d850513          	add	a0,a0,1496 # 6ac0 <updateNode+0x85c>
    14f0:	00005097          	auipc	ra,0x5
    14f4:	a92080e7          	jalr	-1390(ra) # 5f82 <printf>
    exit(1);
    14f8:	4505                	li	a0,1
    14fa:	00004097          	auipc	ra,0x4
    14fe:	6d0080e7          	jalr	1744(ra) # 5bca <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    1502:	567d                	li	a2,-1
    1504:	f6840593          	add	a1,s0,-152
    1508:	00005517          	auipc	a0,0x5
    150c:	5e050513          	add	a0,a0,1504 # 6ae8 <updateNode+0x884>
    1510:	00005097          	auipc	ra,0x5
    1514:	a72080e7          	jalr	-1422(ra) # 5f82 <printf>
    exit(1);
    1518:	4505                	li	a0,1
    151a:	00004097          	auipc	ra,0x4
    151e:	6b0080e7          	jalr	1712(ra) # 5bca <exit>
    printf("fork failed\n");
    1522:	00006517          	auipc	a0,0x6
    1526:	a4650513          	add	a0,a0,-1466 # 6f68 <updateNode+0xd04>
    152a:	00005097          	auipc	ra,0x5
    152e:	a58080e7          	jalr	-1448(ra) # 5f82 <printf>
    exit(1);
    1532:	4505                	li	a0,1
    1534:	00004097          	auipc	ra,0x4
    1538:	696080e7          	jalr	1686(ra) # 5bca <exit>
    exit(747); // OK
    153c:	2eb00513          	li	a0,747
    1540:	00004097          	auipc	ra,0x4
    1544:	68a080e7          	jalr	1674(ra) # 5bca <exit>
  int st = 0;
    1548:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    154c:	f5440513          	add	a0,s0,-172
    1550:	00004097          	auipc	ra,0x4
    1554:	682080e7          	jalr	1666(ra) # 5bd2 <wait>
  if(st != 747){
    1558:	f5442703          	lw	a4,-172(s0)
    155c:	2eb00793          	li	a5,747
    1560:	00f71663          	bne	a4,a5,156c <copyinstr2+0x1dc>
}
    1564:	60ae                	ld	ra,200(sp)
    1566:	640e                	ld	s0,192(sp)
    1568:	6169                	add	sp,sp,208
    156a:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    156c:	00005517          	auipc	a0,0x5
    1570:	5c450513          	add	a0,a0,1476 # 6b30 <updateNode+0x8cc>
    1574:	00005097          	auipc	ra,0x5
    1578:	a0e080e7          	jalr	-1522(ra) # 5f82 <printf>
    exit(1);
    157c:	4505                	li	a0,1
    157e:	00004097          	auipc	ra,0x4
    1582:	64c080e7          	jalr	1612(ra) # 5bca <exit>

0000000000001586 <truncate3>:
{
    1586:	7159                	add	sp,sp,-112
    1588:	f486                	sd	ra,104(sp)
    158a:	f0a2                	sd	s0,96(sp)
    158c:	eca6                	sd	s1,88(sp)
    158e:	e8ca                	sd	s2,80(sp)
    1590:	e4ce                	sd	s3,72(sp)
    1592:	e0d2                	sd	s4,64(sp)
    1594:	fc56                	sd	s5,56(sp)
    1596:	1880                	add	s0,sp,112
    1598:	892a                	mv	s2,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    159a:	60100593          	li	a1,1537
    159e:	00005517          	auipc	a0,0x5
    15a2:	d9250513          	add	a0,a0,-622 # 6330 <updateNode+0xcc>
    15a6:	00004097          	auipc	ra,0x4
    15aa:	664080e7          	jalr	1636(ra) # 5c0a <open>
    15ae:	00004097          	auipc	ra,0x4
    15b2:	644080e7          	jalr	1604(ra) # 5bf2 <close>
  pid = fork();
    15b6:	00004097          	auipc	ra,0x4
    15ba:	60c080e7          	jalr	1548(ra) # 5bc2 <fork>
  if(pid < 0){
    15be:	08054063          	bltz	a0,163e <truncate3+0xb8>
  if(pid == 0){
    15c2:	e969                	bnez	a0,1694 <truncate3+0x10e>
    15c4:	06400993          	li	s3,100
      int fd = open("truncfile", O_WRONLY);
    15c8:	00005a17          	auipc	s4,0x5
    15cc:	d68a0a13          	add	s4,s4,-664 # 6330 <updateNode+0xcc>
      int n = write(fd, "1234567890", 10);
    15d0:	00005a97          	auipc	s5,0x5
    15d4:	5c0a8a93          	add	s5,s5,1472 # 6b90 <updateNode+0x92c>
      int fd = open("truncfile", O_WRONLY);
    15d8:	4585                	li	a1,1
    15da:	8552                	mv	a0,s4
    15dc:	00004097          	auipc	ra,0x4
    15e0:	62e080e7          	jalr	1582(ra) # 5c0a <open>
    15e4:	84aa                	mv	s1,a0
      if(fd < 0){
    15e6:	06054a63          	bltz	a0,165a <truncate3+0xd4>
      int n = write(fd, "1234567890", 10);
    15ea:	4629                	li	a2,10
    15ec:	85d6                	mv	a1,s5
    15ee:	00004097          	auipc	ra,0x4
    15f2:	5fc080e7          	jalr	1532(ra) # 5bea <write>
      if(n != 10){
    15f6:	47a9                	li	a5,10
    15f8:	06f51f63          	bne	a0,a5,1676 <truncate3+0xf0>
      close(fd);
    15fc:	8526                	mv	a0,s1
    15fe:	00004097          	auipc	ra,0x4
    1602:	5f4080e7          	jalr	1524(ra) # 5bf2 <close>
      fd = open("truncfile", O_RDONLY);
    1606:	4581                	li	a1,0
    1608:	8552                	mv	a0,s4
    160a:	00004097          	auipc	ra,0x4
    160e:	600080e7          	jalr	1536(ra) # 5c0a <open>
    1612:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    1614:	02000613          	li	a2,32
    1618:	f9840593          	add	a1,s0,-104
    161c:	00004097          	auipc	ra,0x4
    1620:	5c6080e7          	jalr	1478(ra) # 5be2 <read>
      close(fd);
    1624:	8526                	mv	a0,s1
    1626:	00004097          	auipc	ra,0x4
    162a:	5cc080e7          	jalr	1484(ra) # 5bf2 <close>
    for(int i = 0; i < 100; i++){
    162e:	39fd                	addw	s3,s3,-1
    1630:	fa0994e3          	bnez	s3,15d8 <truncate3+0x52>
    exit(0);
    1634:	4501                	li	a0,0
    1636:	00004097          	auipc	ra,0x4
    163a:	594080e7          	jalr	1428(ra) # 5bca <exit>
    printf("%s: fork failed\n", s);
    163e:	85ca                	mv	a1,s2
    1640:	00005517          	auipc	a0,0x5
    1644:	52050513          	add	a0,a0,1312 # 6b60 <updateNode+0x8fc>
    1648:	00005097          	auipc	ra,0x5
    164c:	93a080e7          	jalr	-1734(ra) # 5f82 <printf>
    exit(1);
    1650:	4505                	li	a0,1
    1652:	00004097          	auipc	ra,0x4
    1656:	578080e7          	jalr	1400(ra) # 5bca <exit>
        printf("%s: open failed\n", s);
    165a:	85ca                	mv	a1,s2
    165c:	00005517          	auipc	a0,0x5
    1660:	51c50513          	add	a0,a0,1308 # 6b78 <updateNode+0x914>
    1664:	00005097          	auipc	ra,0x5
    1668:	91e080e7          	jalr	-1762(ra) # 5f82 <printf>
        exit(1);
    166c:	4505                	li	a0,1
    166e:	00004097          	auipc	ra,0x4
    1672:	55c080e7          	jalr	1372(ra) # 5bca <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    1676:	862a                	mv	a2,a0
    1678:	85ca                	mv	a1,s2
    167a:	00005517          	auipc	a0,0x5
    167e:	52650513          	add	a0,a0,1318 # 6ba0 <updateNode+0x93c>
    1682:	00005097          	auipc	ra,0x5
    1686:	900080e7          	jalr	-1792(ra) # 5f82 <printf>
        exit(1);
    168a:	4505                	li	a0,1
    168c:	00004097          	auipc	ra,0x4
    1690:	53e080e7          	jalr	1342(ra) # 5bca <exit>
    1694:	09600993          	li	s3,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    1698:	00005a17          	auipc	s4,0x5
    169c:	c98a0a13          	add	s4,s4,-872 # 6330 <updateNode+0xcc>
    int n = write(fd, "xxx", 3);
    16a0:	00005a97          	auipc	s5,0x5
    16a4:	520a8a93          	add	s5,s5,1312 # 6bc0 <updateNode+0x95c>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    16a8:	60100593          	li	a1,1537
    16ac:	8552                	mv	a0,s4
    16ae:	00004097          	auipc	ra,0x4
    16b2:	55c080e7          	jalr	1372(ra) # 5c0a <open>
    16b6:	84aa                	mv	s1,a0
    if(fd < 0){
    16b8:	04054763          	bltz	a0,1706 <truncate3+0x180>
    int n = write(fd, "xxx", 3);
    16bc:	460d                	li	a2,3
    16be:	85d6                	mv	a1,s5
    16c0:	00004097          	auipc	ra,0x4
    16c4:	52a080e7          	jalr	1322(ra) # 5bea <write>
    if(n != 3){
    16c8:	478d                	li	a5,3
    16ca:	04f51c63          	bne	a0,a5,1722 <truncate3+0x19c>
    close(fd);
    16ce:	8526                	mv	a0,s1
    16d0:	00004097          	auipc	ra,0x4
    16d4:	522080e7          	jalr	1314(ra) # 5bf2 <close>
  for(int i = 0; i < 150; i++){
    16d8:	39fd                	addw	s3,s3,-1
    16da:	fc0997e3          	bnez	s3,16a8 <truncate3+0x122>
  wait(&xstatus);
    16de:	fbc40513          	add	a0,s0,-68
    16e2:	00004097          	auipc	ra,0x4
    16e6:	4f0080e7          	jalr	1264(ra) # 5bd2 <wait>
  unlink("truncfile");
    16ea:	00005517          	auipc	a0,0x5
    16ee:	c4650513          	add	a0,a0,-954 # 6330 <updateNode+0xcc>
    16f2:	00004097          	auipc	ra,0x4
    16f6:	528080e7          	jalr	1320(ra) # 5c1a <unlink>
  exit(xstatus);
    16fa:	fbc42503          	lw	a0,-68(s0)
    16fe:	00004097          	auipc	ra,0x4
    1702:	4cc080e7          	jalr	1228(ra) # 5bca <exit>
      printf("%s: open failed\n", s);
    1706:	85ca                	mv	a1,s2
    1708:	00005517          	auipc	a0,0x5
    170c:	47050513          	add	a0,a0,1136 # 6b78 <updateNode+0x914>
    1710:	00005097          	auipc	ra,0x5
    1714:	872080e7          	jalr	-1934(ra) # 5f82 <printf>
      exit(1);
    1718:	4505                	li	a0,1
    171a:	00004097          	auipc	ra,0x4
    171e:	4b0080e7          	jalr	1200(ra) # 5bca <exit>
      printf("%s: write got %d, expected 3\n", s, n);
    1722:	862a                	mv	a2,a0
    1724:	85ca                	mv	a1,s2
    1726:	00005517          	auipc	a0,0x5
    172a:	4a250513          	add	a0,a0,1186 # 6bc8 <updateNode+0x964>
    172e:	00005097          	auipc	ra,0x5
    1732:	854080e7          	jalr	-1964(ra) # 5f82 <printf>
      exit(1);
    1736:	4505                	li	a0,1
    1738:	00004097          	auipc	ra,0x4
    173c:	492080e7          	jalr	1170(ra) # 5bca <exit>

0000000000001740 <exectest>:
{
    1740:	715d                	add	sp,sp,-80
    1742:	e486                	sd	ra,72(sp)
    1744:	e0a2                	sd	s0,64(sp)
    1746:	fc26                	sd	s1,56(sp)
    1748:	f84a                	sd	s2,48(sp)
    174a:	0880                	add	s0,sp,80
    174c:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    174e:	00005797          	auipc	a5,0x5
    1752:	b8a78793          	add	a5,a5,-1142 # 62d8 <updateNode+0x74>
    1756:	fcf43023          	sd	a5,-64(s0)
    175a:	00005797          	auipc	a5,0x5
    175e:	48e78793          	add	a5,a5,1166 # 6be8 <updateNode+0x984>
    1762:	fcf43423          	sd	a5,-56(s0)
    1766:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    176a:	00005517          	auipc	a0,0x5
    176e:	48650513          	add	a0,a0,1158 # 6bf0 <updateNode+0x98c>
    1772:	00004097          	auipc	ra,0x4
    1776:	4a8080e7          	jalr	1192(ra) # 5c1a <unlink>
  pid = fork();
    177a:	00004097          	auipc	ra,0x4
    177e:	448080e7          	jalr	1096(ra) # 5bc2 <fork>
  if(pid < 0) {
    1782:	04054663          	bltz	a0,17ce <exectest+0x8e>
    1786:	84aa                	mv	s1,a0
  if(pid == 0) {
    1788:	e959                	bnez	a0,181e <exectest+0xde>
    close(1);
    178a:	4505                	li	a0,1
    178c:	00004097          	auipc	ra,0x4
    1790:	466080e7          	jalr	1126(ra) # 5bf2 <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    1794:	20100593          	li	a1,513
    1798:	00005517          	auipc	a0,0x5
    179c:	45850513          	add	a0,a0,1112 # 6bf0 <updateNode+0x98c>
    17a0:	00004097          	auipc	ra,0x4
    17a4:	46a080e7          	jalr	1130(ra) # 5c0a <open>
    if(fd < 0) {
    17a8:	04054163          	bltz	a0,17ea <exectest+0xaa>
    if(fd != 1) {
    17ac:	4785                	li	a5,1
    17ae:	04f50c63          	beq	a0,a5,1806 <exectest+0xc6>
      printf("%s: wrong fd\n", s);
    17b2:	85ca                	mv	a1,s2
    17b4:	00005517          	auipc	a0,0x5
    17b8:	45c50513          	add	a0,a0,1116 # 6c10 <updateNode+0x9ac>
    17bc:	00004097          	auipc	ra,0x4
    17c0:	7c6080e7          	jalr	1990(ra) # 5f82 <printf>
      exit(1);
    17c4:	4505                	li	a0,1
    17c6:	00004097          	auipc	ra,0x4
    17ca:	404080e7          	jalr	1028(ra) # 5bca <exit>
     printf("%s: fork failed\n", s);
    17ce:	85ca                	mv	a1,s2
    17d0:	00005517          	auipc	a0,0x5
    17d4:	39050513          	add	a0,a0,912 # 6b60 <updateNode+0x8fc>
    17d8:	00004097          	auipc	ra,0x4
    17dc:	7aa080e7          	jalr	1962(ra) # 5f82 <printf>
     exit(1);
    17e0:	4505                	li	a0,1
    17e2:	00004097          	auipc	ra,0x4
    17e6:	3e8080e7          	jalr	1000(ra) # 5bca <exit>
      printf("%s: create failed\n", s);
    17ea:	85ca                	mv	a1,s2
    17ec:	00005517          	auipc	a0,0x5
    17f0:	40c50513          	add	a0,a0,1036 # 6bf8 <updateNode+0x994>
    17f4:	00004097          	auipc	ra,0x4
    17f8:	78e080e7          	jalr	1934(ra) # 5f82 <printf>
      exit(1);
    17fc:	4505                	li	a0,1
    17fe:	00004097          	auipc	ra,0x4
    1802:	3cc080e7          	jalr	972(ra) # 5bca <exit>
    if(exec("echo", echoargv) < 0){
    1806:	fc040593          	add	a1,s0,-64
    180a:	00005517          	auipc	a0,0x5
    180e:	ace50513          	add	a0,a0,-1330 # 62d8 <updateNode+0x74>
    1812:	00004097          	auipc	ra,0x4
    1816:	3f0080e7          	jalr	1008(ra) # 5c02 <exec>
    181a:	02054163          	bltz	a0,183c <exectest+0xfc>
  if (wait(&xstatus) != pid) {
    181e:	fdc40513          	add	a0,s0,-36
    1822:	00004097          	auipc	ra,0x4
    1826:	3b0080e7          	jalr	944(ra) # 5bd2 <wait>
    182a:	02951763          	bne	a0,s1,1858 <exectest+0x118>
  if(xstatus != 0)
    182e:	fdc42503          	lw	a0,-36(s0)
    1832:	cd0d                	beqz	a0,186c <exectest+0x12c>
    exit(xstatus);
    1834:	00004097          	auipc	ra,0x4
    1838:	396080e7          	jalr	918(ra) # 5bca <exit>
      printf("%s: exec echo failed\n", s);
    183c:	85ca                	mv	a1,s2
    183e:	00005517          	auipc	a0,0x5
    1842:	3e250513          	add	a0,a0,994 # 6c20 <updateNode+0x9bc>
    1846:	00004097          	auipc	ra,0x4
    184a:	73c080e7          	jalr	1852(ra) # 5f82 <printf>
      exit(1);
    184e:	4505                	li	a0,1
    1850:	00004097          	auipc	ra,0x4
    1854:	37a080e7          	jalr	890(ra) # 5bca <exit>
    printf("%s: wait failed!\n", s);
    1858:	85ca                	mv	a1,s2
    185a:	00005517          	auipc	a0,0x5
    185e:	3de50513          	add	a0,a0,990 # 6c38 <updateNode+0x9d4>
    1862:	00004097          	auipc	ra,0x4
    1866:	720080e7          	jalr	1824(ra) # 5f82 <printf>
    186a:	b7d1                	j	182e <exectest+0xee>
  fd = open("echo-ok", O_RDONLY);
    186c:	4581                	li	a1,0
    186e:	00005517          	auipc	a0,0x5
    1872:	38250513          	add	a0,a0,898 # 6bf0 <updateNode+0x98c>
    1876:	00004097          	auipc	ra,0x4
    187a:	394080e7          	jalr	916(ra) # 5c0a <open>
  if(fd < 0) {
    187e:	02054a63          	bltz	a0,18b2 <exectest+0x172>
  if (read(fd, buf, 2) != 2) {
    1882:	4609                	li	a2,2
    1884:	fb840593          	add	a1,s0,-72
    1888:	00004097          	auipc	ra,0x4
    188c:	35a080e7          	jalr	858(ra) # 5be2 <read>
    1890:	4789                	li	a5,2
    1892:	02f50e63          	beq	a0,a5,18ce <exectest+0x18e>
    printf("%s: read failed\n", s);
    1896:	85ca                	mv	a1,s2
    1898:	00005517          	auipc	a0,0x5
    189c:	e1050513          	add	a0,a0,-496 # 66a8 <updateNode+0x444>
    18a0:	00004097          	auipc	ra,0x4
    18a4:	6e2080e7          	jalr	1762(ra) # 5f82 <printf>
    exit(1);
    18a8:	4505                	li	a0,1
    18aa:	00004097          	auipc	ra,0x4
    18ae:	320080e7          	jalr	800(ra) # 5bca <exit>
    printf("%s: open failed\n", s);
    18b2:	85ca                	mv	a1,s2
    18b4:	00005517          	auipc	a0,0x5
    18b8:	2c450513          	add	a0,a0,708 # 6b78 <updateNode+0x914>
    18bc:	00004097          	auipc	ra,0x4
    18c0:	6c6080e7          	jalr	1734(ra) # 5f82 <printf>
    exit(1);
    18c4:	4505                	li	a0,1
    18c6:	00004097          	auipc	ra,0x4
    18ca:	304080e7          	jalr	772(ra) # 5bca <exit>
  unlink("echo-ok");
    18ce:	00005517          	auipc	a0,0x5
    18d2:	32250513          	add	a0,a0,802 # 6bf0 <updateNode+0x98c>
    18d6:	00004097          	auipc	ra,0x4
    18da:	344080e7          	jalr	836(ra) # 5c1a <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    18de:	fb844703          	lbu	a4,-72(s0)
    18e2:	04f00793          	li	a5,79
    18e6:	00f71863          	bne	a4,a5,18f6 <exectest+0x1b6>
    18ea:	fb944703          	lbu	a4,-71(s0)
    18ee:	04b00793          	li	a5,75
    18f2:	02f70063          	beq	a4,a5,1912 <exectest+0x1d2>
    printf("%s: wrong output\n", s);
    18f6:	85ca                	mv	a1,s2
    18f8:	00005517          	auipc	a0,0x5
    18fc:	35850513          	add	a0,a0,856 # 6c50 <updateNode+0x9ec>
    1900:	00004097          	auipc	ra,0x4
    1904:	682080e7          	jalr	1666(ra) # 5f82 <printf>
    exit(1);
    1908:	4505                	li	a0,1
    190a:	00004097          	auipc	ra,0x4
    190e:	2c0080e7          	jalr	704(ra) # 5bca <exit>
    exit(0);
    1912:	4501                	li	a0,0
    1914:	00004097          	auipc	ra,0x4
    1918:	2b6080e7          	jalr	694(ra) # 5bca <exit>

000000000000191c <pipe1>:
{
    191c:	711d                	add	sp,sp,-96
    191e:	ec86                	sd	ra,88(sp)
    1920:	e8a2                	sd	s0,80(sp)
    1922:	e4a6                	sd	s1,72(sp)
    1924:	e0ca                	sd	s2,64(sp)
    1926:	fc4e                	sd	s3,56(sp)
    1928:	f852                	sd	s4,48(sp)
    192a:	f456                	sd	s5,40(sp)
    192c:	f05a                	sd	s6,32(sp)
    192e:	ec5e                	sd	s7,24(sp)
    1930:	1080                	add	s0,sp,96
    1932:	892a                	mv	s2,a0
  if(pipe(fds) != 0){
    1934:	fa840513          	add	a0,s0,-88
    1938:	00004097          	auipc	ra,0x4
    193c:	2a2080e7          	jalr	674(ra) # 5bda <pipe>
    1940:	e93d                	bnez	a0,19b6 <pipe1+0x9a>
    1942:	84aa                	mv	s1,a0
  pid = fork();
    1944:	00004097          	auipc	ra,0x4
    1948:	27e080e7          	jalr	638(ra) # 5bc2 <fork>
    194c:	8a2a                	mv	s4,a0
  if(pid == 0){
    194e:	c151                	beqz	a0,19d2 <pipe1+0xb6>
  } else if(pid > 0){
    1950:	16a05d63          	blez	a0,1aca <pipe1+0x1ae>
    close(fds[1]);
    1954:	fac42503          	lw	a0,-84(s0)
    1958:	00004097          	auipc	ra,0x4
    195c:	29a080e7          	jalr	666(ra) # 5bf2 <close>
    total = 0;
    1960:	8a26                	mv	s4,s1
    cc = 1;
    1962:	4985                	li	s3,1
    while((n = read(fds[0], buf, cc)) > 0){
    1964:	0000ba97          	auipc	s5,0xb
    1968:	314a8a93          	add	s5,s5,788 # cc78 <buf>
    196c:	864e                	mv	a2,s3
    196e:	85d6                	mv	a1,s5
    1970:	fa842503          	lw	a0,-88(s0)
    1974:	00004097          	auipc	ra,0x4
    1978:	26e080e7          	jalr	622(ra) # 5be2 <read>
    197c:	10a05263          	blez	a0,1a80 <pipe1+0x164>
      for(i = 0; i < n; i++){
    1980:	0000b717          	auipc	a4,0xb
    1984:	2f870713          	add	a4,a4,760 # cc78 <buf>
    1988:	00a4863b          	addw	a2,s1,a0
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    198c:	00074683          	lbu	a3,0(a4)
    1990:	0ff4f793          	zext.b	a5,s1
    1994:	2485                	addw	s1,s1,1
    1996:	0cf69163          	bne	a3,a5,1a58 <pipe1+0x13c>
      for(i = 0; i < n; i++){
    199a:	0705                	add	a4,a4,1
    199c:	fec498e3          	bne	s1,a2,198c <pipe1+0x70>
      total += n;
    19a0:	00aa0a3b          	addw	s4,s4,a0
      cc = cc * 2;
    19a4:	0019979b          	sllw	a5,s3,0x1
    19a8:	0007899b          	sext.w	s3,a5
      if(cc > sizeof(buf))
    19ac:	670d                	lui	a4,0x3
    19ae:	fb377fe3          	bgeu	a4,s3,196c <pipe1+0x50>
        cc = sizeof(buf);
    19b2:	698d                	lui	s3,0x3
    19b4:	bf65                	j	196c <pipe1+0x50>
    printf("%s: pipe() failed\n", s);
    19b6:	85ca                	mv	a1,s2
    19b8:	00005517          	auipc	a0,0x5
    19bc:	2b050513          	add	a0,a0,688 # 6c68 <updateNode+0xa04>
    19c0:	00004097          	auipc	ra,0x4
    19c4:	5c2080e7          	jalr	1474(ra) # 5f82 <printf>
    exit(1);
    19c8:	4505                	li	a0,1
    19ca:	00004097          	auipc	ra,0x4
    19ce:	200080e7          	jalr	512(ra) # 5bca <exit>
    close(fds[0]);
    19d2:	fa842503          	lw	a0,-88(s0)
    19d6:	00004097          	auipc	ra,0x4
    19da:	21c080e7          	jalr	540(ra) # 5bf2 <close>
    for(n = 0; n < N; n++){
    19de:	0000bb17          	auipc	s6,0xb
    19e2:	29ab0b13          	add	s6,s6,666 # cc78 <buf>
    19e6:	416004bb          	negw	s1,s6
    19ea:	0ff4f493          	zext.b	s1,s1
    19ee:	409b0993          	add	s3,s6,1033
      if(write(fds[1], buf, SZ) != SZ){
    19f2:	8bda                	mv	s7,s6
    for(n = 0; n < N; n++){
    19f4:	6a85                	lui	s5,0x1
    19f6:	42da8a93          	add	s5,s5,1069 # 142d <copyinstr2+0x9d>
{
    19fa:	87da                	mv	a5,s6
        buf[i] = seq++;
    19fc:	0097873b          	addw	a4,a5,s1
    1a00:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    1a04:	0785                	add	a5,a5,1
    1a06:	fef99be3          	bne	s3,a5,19fc <pipe1+0xe0>
        buf[i] = seq++;
    1a0a:	409a0a1b          	addw	s4,s4,1033
      if(write(fds[1], buf, SZ) != SZ){
    1a0e:	40900613          	li	a2,1033
    1a12:	85de                	mv	a1,s7
    1a14:	fac42503          	lw	a0,-84(s0)
    1a18:	00004097          	auipc	ra,0x4
    1a1c:	1d2080e7          	jalr	466(ra) # 5bea <write>
    1a20:	40900793          	li	a5,1033
    1a24:	00f51c63          	bne	a0,a5,1a3c <pipe1+0x120>
    for(n = 0; n < N; n++){
    1a28:	24a5                	addw	s1,s1,9
    1a2a:	0ff4f493          	zext.b	s1,s1
    1a2e:	fd5a16e3          	bne	s4,s5,19fa <pipe1+0xde>
    exit(0);
    1a32:	4501                	li	a0,0
    1a34:	00004097          	auipc	ra,0x4
    1a38:	196080e7          	jalr	406(ra) # 5bca <exit>
        printf("%s: pipe1 oops 1\n", s);
    1a3c:	85ca                	mv	a1,s2
    1a3e:	00005517          	auipc	a0,0x5
    1a42:	24250513          	add	a0,a0,578 # 6c80 <updateNode+0xa1c>
    1a46:	00004097          	auipc	ra,0x4
    1a4a:	53c080e7          	jalr	1340(ra) # 5f82 <printf>
        exit(1);
    1a4e:	4505                	li	a0,1
    1a50:	00004097          	auipc	ra,0x4
    1a54:	17a080e7          	jalr	378(ra) # 5bca <exit>
          printf("%s: pipe1 oops 2\n", s);
    1a58:	85ca                	mv	a1,s2
    1a5a:	00005517          	auipc	a0,0x5
    1a5e:	23e50513          	add	a0,a0,574 # 6c98 <updateNode+0xa34>
    1a62:	00004097          	auipc	ra,0x4
    1a66:	520080e7          	jalr	1312(ra) # 5f82 <printf>
}
    1a6a:	60e6                	ld	ra,88(sp)
    1a6c:	6446                	ld	s0,80(sp)
    1a6e:	64a6                	ld	s1,72(sp)
    1a70:	6906                	ld	s2,64(sp)
    1a72:	79e2                	ld	s3,56(sp)
    1a74:	7a42                	ld	s4,48(sp)
    1a76:	7aa2                	ld	s5,40(sp)
    1a78:	7b02                	ld	s6,32(sp)
    1a7a:	6be2                	ld	s7,24(sp)
    1a7c:	6125                	add	sp,sp,96
    1a7e:	8082                	ret
    if(total != N * SZ){
    1a80:	6785                	lui	a5,0x1
    1a82:	42d78793          	add	a5,a5,1069 # 142d <copyinstr2+0x9d>
    1a86:	02fa0063          	beq	s4,a5,1aa6 <pipe1+0x18a>
      printf("%s: pipe1 oops 3 total %d\n", total);
    1a8a:	85d2                	mv	a1,s4
    1a8c:	00005517          	auipc	a0,0x5
    1a90:	22450513          	add	a0,a0,548 # 6cb0 <updateNode+0xa4c>
    1a94:	00004097          	auipc	ra,0x4
    1a98:	4ee080e7          	jalr	1262(ra) # 5f82 <printf>
      exit(1);
    1a9c:	4505                	li	a0,1
    1a9e:	00004097          	auipc	ra,0x4
    1aa2:	12c080e7          	jalr	300(ra) # 5bca <exit>
    close(fds[0]);
    1aa6:	fa842503          	lw	a0,-88(s0)
    1aaa:	00004097          	auipc	ra,0x4
    1aae:	148080e7          	jalr	328(ra) # 5bf2 <close>
    wait(&xstatus);
    1ab2:	fa440513          	add	a0,s0,-92
    1ab6:	00004097          	auipc	ra,0x4
    1aba:	11c080e7          	jalr	284(ra) # 5bd2 <wait>
    exit(xstatus);
    1abe:	fa442503          	lw	a0,-92(s0)
    1ac2:	00004097          	auipc	ra,0x4
    1ac6:	108080e7          	jalr	264(ra) # 5bca <exit>
    printf("%s: fork() failed\n", s);
    1aca:	85ca                	mv	a1,s2
    1acc:	00005517          	auipc	a0,0x5
    1ad0:	20450513          	add	a0,a0,516 # 6cd0 <updateNode+0xa6c>
    1ad4:	00004097          	auipc	ra,0x4
    1ad8:	4ae080e7          	jalr	1198(ra) # 5f82 <printf>
    exit(1);
    1adc:	4505                	li	a0,1
    1ade:	00004097          	auipc	ra,0x4
    1ae2:	0ec080e7          	jalr	236(ra) # 5bca <exit>

0000000000001ae6 <exitwait>:
{
    1ae6:	7139                	add	sp,sp,-64
    1ae8:	fc06                	sd	ra,56(sp)
    1aea:	f822                	sd	s0,48(sp)
    1aec:	f426                	sd	s1,40(sp)
    1aee:	f04a                	sd	s2,32(sp)
    1af0:	ec4e                	sd	s3,24(sp)
    1af2:	e852                	sd	s4,16(sp)
    1af4:	0080                	add	s0,sp,64
    1af6:	8a2a                	mv	s4,a0
  for(i = 0; i < 100; i++){
    1af8:	4901                	li	s2,0
    1afa:	06400993          	li	s3,100
    pid = fork();
    1afe:	00004097          	auipc	ra,0x4
    1b02:	0c4080e7          	jalr	196(ra) # 5bc2 <fork>
    1b06:	84aa                	mv	s1,a0
    if(pid < 0){
    1b08:	02054a63          	bltz	a0,1b3c <exitwait+0x56>
    if(pid){
    1b0c:	c151                	beqz	a0,1b90 <exitwait+0xaa>
      if(wait(&xstate) != pid){
    1b0e:	fcc40513          	add	a0,s0,-52
    1b12:	00004097          	auipc	ra,0x4
    1b16:	0c0080e7          	jalr	192(ra) # 5bd2 <wait>
    1b1a:	02951f63          	bne	a0,s1,1b58 <exitwait+0x72>
      if(i != xstate) {
    1b1e:	fcc42783          	lw	a5,-52(s0)
    1b22:	05279963          	bne	a5,s2,1b74 <exitwait+0x8e>
  for(i = 0; i < 100; i++){
    1b26:	2905                	addw	s2,s2,1
    1b28:	fd391be3          	bne	s2,s3,1afe <exitwait+0x18>
}
    1b2c:	70e2                	ld	ra,56(sp)
    1b2e:	7442                	ld	s0,48(sp)
    1b30:	74a2                	ld	s1,40(sp)
    1b32:	7902                	ld	s2,32(sp)
    1b34:	69e2                	ld	s3,24(sp)
    1b36:	6a42                	ld	s4,16(sp)
    1b38:	6121                	add	sp,sp,64
    1b3a:	8082                	ret
      printf("%s: fork failed\n", s);
    1b3c:	85d2                	mv	a1,s4
    1b3e:	00005517          	auipc	a0,0x5
    1b42:	02250513          	add	a0,a0,34 # 6b60 <updateNode+0x8fc>
    1b46:	00004097          	auipc	ra,0x4
    1b4a:	43c080e7          	jalr	1084(ra) # 5f82 <printf>
      exit(1);
    1b4e:	4505                	li	a0,1
    1b50:	00004097          	auipc	ra,0x4
    1b54:	07a080e7          	jalr	122(ra) # 5bca <exit>
        printf("%s: wait wrong pid\n", s);
    1b58:	85d2                	mv	a1,s4
    1b5a:	00005517          	auipc	a0,0x5
    1b5e:	18e50513          	add	a0,a0,398 # 6ce8 <updateNode+0xa84>
    1b62:	00004097          	auipc	ra,0x4
    1b66:	420080e7          	jalr	1056(ra) # 5f82 <printf>
        exit(1);
    1b6a:	4505                	li	a0,1
    1b6c:	00004097          	auipc	ra,0x4
    1b70:	05e080e7          	jalr	94(ra) # 5bca <exit>
        printf("%s: wait wrong exit status\n", s);
    1b74:	85d2                	mv	a1,s4
    1b76:	00005517          	auipc	a0,0x5
    1b7a:	18a50513          	add	a0,a0,394 # 6d00 <updateNode+0xa9c>
    1b7e:	00004097          	auipc	ra,0x4
    1b82:	404080e7          	jalr	1028(ra) # 5f82 <printf>
        exit(1);
    1b86:	4505                	li	a0,1
    1b88:	00004097          	auipc	ra,0x4
    1b8c:	042080e7          	jalr	66(ra) # 5bca <exit>
      exit(i);
    1b90:	854a                	mv	a0,s2
    1b92:	00004097          	auipc	ra,0x4
    1b96:	038080e7          	jalr	56(ra) # 5bca <exit>

0000000000001b9a <twochildren>:
{
    1b9a:	1101                	add	sp,sp,-32
    1b9c:	ec06                	sd	ra,24(sp)
    1b9e:	e822                	sd	s0,16(sp)
    1ba0:	e426                	sd	s1,8(sp)
    1ba2:	e04a                	sd	s2,0(sp)
    1ba4:	1000                	add	s0,sp,32
    1ba6:	892a                	mv	s2,a0
    1ba8:	3e800493          	li	s1,1000
    int pid1 = fork();
    1bac:	00004097          	auipc	ra,0x4
    1bb0:	016080e7          	jalr	22(ra) # 5bc2 <fork>
    if(pid1 < 0){
    1bb4:	02054c63          	bltz	a0,1bec <twochildren+0x52>
    if(pid1 == 0){
    1bb8:	c921                	beqz	a0,1c08 <twochildren+0x6e>
      int pid2 = fork();
    1bba:	00004097          	auipc	ra,0x4
    1bbe:	008080e7          	jalr	8(ra) # 5bc2 <fork>
      if(pid2 < 0){
    1bc2:	04054763          	bltz	a0,1c10 <twochildren+0x76>
      if(pid2 == 0){
    1bc6:	c13d                	beqz	a0,1c2c <twochildren+0x92>
        wait(0);
    1bc8:	4501                	li	a0,0
    1bca:	00004097          	auipc	ra,0x4
    1bce:	008080e7          	jalr	8(ra) # 5bd2 <wait>
        wait(0);
    1bd2:	4501                	li	a0,0
    1bd4:	00004097          	auipc	ra,0x4
    1bd8:	ffe080e7          	jalr	-2(ra) # 5bd2 <wait>
  for(int i = 0; i < 1000; i++){
    1bdc:	34fd                	addw	s1,s1,-1
    1bde:	f4f9                	bnez	s1,1bac <twochildren+0x12>
}
    1be0:	60e2                	ld	ra,24(sp)
    1be2:	6442                	ld	s0,16(sp)
    1be4:	64a2                	ld	s1,8(sp)
    1be6:	6902                	ld	s2,0(sp)
    1be8:	6105                	add	sp,sp,32
    1bea:	8082                	ret
      printf("%s: fork failed\n", s);
    1bec:	85ca                	mv	a1,s2
    1bee:	00005517          	auipc	a0,0x5
    1bf2:	f7250513          	add	a0,a0,-142 # 6b60 <updateNode+0x8fc>
    1bf6:	00004097          	auipc	ra,0x4
    1bfa:	38c080e7          	jalr	908(ra) # 5f82 <printf>
      exit(1);
    1bfe:	4505                	li	a0,1
    1c00:	00004097          	auipc	ra,0x4
    1c04:	fca080e7          	jalr	-54(ra) # 5bca <exit>
      exit(0);
    1c08:	00004097          	auipc	ra,0x4
    1c0c:	fc2080e7          	jalr	-62(ra) # 5bca <exit>
        printf("%s: fork failed\n", s);
    1c10:	85ca                	mv	a1,s2
    1c12:	00005517          	auipc	a0,0x5
    1c16:	f4e50513          	add	a0,a0,-178 # 6b60 <updateNode+0x8fc>
    1c1a:	00004097          	auipc	ra,0x4
    1c1e:	368080e7          	jalr	872(ra) # 5f82 <printf>
        exit(1);
    1c22:	4505                	li	a0,1
    1c24:	00004097          	auipc	ra,0x4
    1c28:	fa6080e7          	jalr	-90(ra) # 5bca <exit>
        exit(0);
    1c2c:	00004097          	auipc	ra,0x4
    1c30:	f9e080e7          	jalr	-98(ra) # 5bca <exit>

0000000000001c34 <forkfork>:
{
    1c34:	7179                	add	sp,sp,-48
    1c36:	f406                	sd	ra,40(sp)
    1c38:	f022                	sd	s0,32(sp)
    1c3a:	ec26                	sd	s1,24(sp)
    1c3c:	1800                	add	s0,sp,48
    1c3e:	84aa                	mv	s1,a0
    int pid = fork();
    1c40:	00004097          	auipc	ra,0x4
    1c44:	f82080e7          	jalr	-126(ra) # 5bc2 <fork>
    if(pid < 0){
    1c48:	04054163          	bltz	a0,1c8a <forkfork+0x56>
    if(pid == 0){
    1c4c:	cd29                	beqz	a0,1ca6 <forkfork+0x72>
    int pid = fork();
    1c4e:	00004097          	auipc	ra,0x4
    1c52:	f74080e7          	jalr	-140(ra) # 5bc2 <fork>
    if(pid < 0){
    1c56:	02054a63          	bltz	a0,1c8a <forkfork+0x56>
    if(pid == 0){
    1c5a:	c531                	beqz	a0,1ca6 <forkfork+0x72>
    wait(&xstatus);
    1c5c:	fdc40513          	add	a0,s0,-36
    1c60:	00004097          	auipc	ra,0x4
    1c64:	f72080e7          	jalr	-142(ra) # 5bd2 <wait>
    if(xstatus != 0) {
    1c68:	fdc42783          	lw	a5,-36(s0)
    1c6c:	ebbd                	bnez	a5,1ce2 <forkfork+0xae>
    wait(&xstatus);
    1c6e:	fdc40513          	add	a0,s0,-36
    1c72:	00004097          	auipc	ra,0x4
    1c76:	f60080e7          	jalr	-160(ra) # 5bd2 <wait>
    if(xstatus != 0) {
    1c7a:	fdc42783          	lw	a5,-36(s0)
    1c7e:	e3b5                	bnez	a5,1ce2 <forkfork+0xae>
}
    1c80:	70a2                	ld	ra,40(sp)
    1c82:	7402                	ld	s0,32(sp)
    1c84:	64e2                	ld	s1,24(sp)
    1c86:	6145                	add	sp,sp,48
    1c88:	8082                	ret
      printf("%s: fork failed", s);
    1c8a:	85a6                	mv	a1,s1
    1c8c:	00005517          	auipc	a0,0x5
    1c90:	09450513          	add	a0,a0,148 # 6d20 <updateNode+0xabc>
    1c94:	00004097          	auipc	ra,0x4
    1c98:	2ee080e7          	jalr	750(ra) # 5f82 <printf>
      exit(1);
    1c9c:	4505                	li	a0,1
    1c9e:	00004097          	auipc	ra,0x4
    1ca2:	f2c080e7          	jalr	-212(ra) # 5bca <exit>
{
    1ca6:	0c800493          	li	s1,200
        int pid1 = fork();
    1caa:	00004097          	auipc	ra,0x4
    1cae:	f18080e7          	jalr	-232(ra) # 5bc2 <fork>
        if(pid1 < 0){
    1cb2:	00054f63          	bltz	a0,1cd0 <forkfork+0x9c>
        if(pid1 == 0){
    1cb6:	c115                	beqz	a0,1cda <forkfork+0xa6>
        wait(0);
    1cb8:	4501                	li	a0,0
    1cba:	00004097          	auipc	ra,0x4
    1cbe:	f18080e7          	jalr	-232(ra) # 5bd2 <wait>
      for(int j = 0; j < 200; j++){
    1cc2:	34fd                	addw	s1,s1,-1
    1cc4:	f0fd                	bnez	s1,1caa <forkfork+0x76>
      exit(0);
    1cc6:	4501                	li	a0,0
    1cc8:	00004097          	auipc	ra,0x4
    1ccc:	f02080e7          	jalr	-254(ra) # 5bca <exit>
          exit(1);
    1cd0:	4505                	li	a0,1
    1cd2:	00004097          	auipc	ra,0x4
    1cd6:	ef8080e7          	jalr	-264(ra) # 5bca <exit>
          exit(0);
    1cda:	00004097          	auipc	ra,0x4
    1cde:	ef0080e7          	jalr	-272(ra) # 5bca <exit>
      printf("%s: fork in child failed", s);
    1ce2:	85a6                	mv	a1,s1
    1ce4:	00005517          	auipc	a0,0x5
    1ce8:	04c50513          	add	a0,a0,76 # 6d30 <updateNode+0xacc>
    1cec:	00004097          	auipc	ra,0x4
    1cf0:	296080e7          	jalr	662(ra) # 5f82 <printf>
      exit(1);
    1cf4:	4505                	li	a0,1
    1cf6:	00004097          	auipc	ra,0x4
    1cfa:	ed4080e7          	jalr	-300(ra) # 5bca <exit>

0000000000001cfe <reparent2>:
{
    1cfe:	1101                	add	sp,sp,-32
    1d00:	ec06                	sd	ra,24(sp)
    1d02:	e822                	sd	s0,16(sp)
    1d04:	e426                	sd	s1,8(sp)
    1d06:	1000                	add	s0,sp,32
    1d08:	32000493          	li	s1,800
    int pid1 = fork();
    1d0c:	00004097          	auipc	ra,0x4
    1d10:	eb6080e7          	jalr	-330(ra) # 5bc2 <fork>
    if(pid1 < 0){
    1d14:	00054f63          	bltz	a0,1d32 <reparent2+0x34>
    if(pid1 == 0){
    1d18:	c915                	beqz	a0,1d4c <reparent2+0x4e>
    wait(0);
    1d1a:	4501                	li	a0,0
    1d1c:	00004097          	auipc	ra,0x4
    1d20:	eb6080e7          	jalr	-330(ra) # 5bd2 <wait>
  for(int i = 0; i < 800; i++){
    1d24:	34fd                	addw	s1,s1,-1
    1d26:	f0fd                	bnez	s1,1d0c <reparent2+0xe>
  exit(0);
    1d28:	4501                	li	a0,0
    1d2a:	00004097          	auipc	ra,0x4
    1d2e:	ea0080e7          	jalr	-352(ra) # 5bca <exit>
      printf("fork failed\n");
    1d32:	00005517          	auipc	a0,0x5
    1d36:	23650513          	add	a0,a0,566 # 6f68 <updateNode+0xd04>
    1d3a:	00004097          	auipc	ra,0x4
    1d3e:	248080e7          	jalr	584(ra) # 5f82 <printf>
      exit(1);
    1d42:	4505                	li	a0,1
    1d44:	00004097          	auipc	ra,0x4
    1d48:	e86080e7          	jalr	-378(ra) # 5bca <exit>
      fork();
    1d4c:	00004097          	auipc	ra,0x4
    1d50:	e76080e7          	jalr	-394(ra) # 5bc2 <fork>
      fork();
    1d54:	00004097          	auipc	ra,0x4
    1d58:	e6e080e7          	jalr	-402(ra) # 5bc2 <fork>
      exit(0);
    1d5c:	4501                	li	a0,0
    1d5e:	00004097          	auipc	ra,0x4
    1d62:	e6c080e7          	jalr	-404(ra) # 5bca <exit>

0000000000001d66 <createdelete>:
{
    1d66:	7175                	add	sp,sp,-144
    1d68:	e506                	sd	ra,136(sp)
    1d6a:	e122                	sd	s0,128(sp)
    1d6c:	fca6                	sd	s1,120(sp)
    1d6e:	f8ca                	sd	s2,112(sp)
    1d70:	f4ce                	sd	s3,104(sp)
    1d72:	f0d2                	sd	s4,96(sp)
    1d74:	ecd6                	sd	s5,88(sp)
    1d76:	e8da                	sd	s6,80(sp)
    1d78:	e4de                	sd	s7,72(sp)
    1d7a:	e0e2                	sd	s8,64(sp)
    1d7c:	fc66                	sd	s9,56(sp)
    1d7e:	0900                	add	s0,sp,144
    1d80:	8caa                	mv	s9,a0
  for(pi = 0; pi < NCHILD; pi++){
    1d82:	4901                	li	s2,0
    1d84:	4991                	li	s3,4
    pid = fork();
    1d86:	00004097          	auipc	ra,0x4
    1d8a:	e3c080e7          	jalr	-452(ra) # 5bc2 <fork>
    1d8e:	84aa                	mv	s1,a0
    if(pid < 0){
    1d90:	02054f63          	bltz	a0,1dce <createdelete+0x68>
    if(pid == 0){
    1d94:	c939                	beqz	a0,1dea <createdelete+0x84>
  for(pi = 0; pi < NCHILD; pi++){
    1d96:	2905                	addw	s2,s2,1
    1d98:	ff3917e3          	bne	s2,s3,1d86 <createdelete+0x20>
    1d9c:	4491                	li	s1,4
    wait(&xstatus);
    1d9e:	f7c40513          	add	a0,s0,-132
    1da2:	00004097          	auipc	ra,0x4
    1da6:	e30080e7          	jalr	-464(ra) # 5bd2 <wait>
    if(xstatus != 0)
    1daa:	f7c42903          	lw	s2,-132(s0)
    1dae:	0e091263          	bnez	s2,1e92 <createdelete+0x12c>
  for(pi = 0; pi < NCHILD; pi++){
    1db2:	34fd                	addw	s1,s1,-1
    1db4:	f4ed                	bnez	s1,1d9e <createdelete+0x38>
  name[0] = name[1] = name[2] = 0;
    1db6:	f8040123          	sb	zero,-126(s0)
    1dba:	03000993          	li	s3,48
    1dbe:	5a7d                	li	s4,-1
    1dc0:	07000c13          	li	s8,112
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1dc4:	4b21                	li	s6,8
      if((i == 0 || i >= N/2) && fd < 0){
    1dc6:	4ba5                	li	s7,9
    for(pi = 0; pi < NCHILD; pi++){
    1dc8:	07400a93          	li	s5,116
    1dcc:	a29d                	j	1f32 <createdelete+0x1cc>
      printf("fork failed\n", s);
    1dce:	85e6                	mv	a1,s9
    1dd0:	00005517          	auipc	a0,0x5
    1dd4:	19850513          	add	a0,a0,408 # 6f68 <updateNode+0xd04>
    1dd8:	00004097          	auipc	ra,0x4
    1ddc:	1aa080e7          	jalr	426(ra) # 5f82 <printf>
      exit(1);
    1de0:	4505                	li	a0,1
    1de2:	00004097          	auipc	ra,0x4
    1de6:	de8080e7          	jalr	-536(ra) # 5bca <exit>
      name[0] = 'p' + pi;
    1dea:	0709091b          	addw	s2,s2,112
    1dee:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
    1df2:	f8040123          	sb	zero,-126(s0)
      for(i = 0; i < N; i++){
    1df6:	4951                	li	s2,20
    1df8:	a015                	j	1e1c <createdelete+0xb6>
          printf("%s: create failed\n", s);
    1dfa:	85e6                	mv	a1,s9
    1dfc:	00005517          	auipc	a0,0x5
    1e00:	dfc50513          	add	a0,a0,-516 # 6bf8 <updateNode+0x994>
    1e04:	00004097          	auipc	ra,0x4
    1e08:	17e080e7          	jalr	382(ra) # 5f82 <printf>
          exit(1);
    1e0c:	4505                	li	a0,1
    1e0e:	00004097          	auipc	ra,0x4
    1e12:	dbc080e7          	jalr	-580(ra) # 5bca <exit>
      for(i = 0; i < N; i++){
    1e16:	2485                	addw	s1,s1,1
    1e18:	07248863          	beq	s1,s2,1e88 <createdelete+0x122>
        name[1] = '0' + i;
    1e1c:	0304879b          	addw	a5,s1,48
    1e20:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1e24:	20200593          	li	a1,514
    1e28:	f8040513          	add	a0,s0,-128
    1e2c:	00004097          	auipc	ra,0x4
    1e30:	dde080e7          	jalr	-546(ra) # 5c0a <open>
        if(fd < 0){
    1e34:	fc0543e3          	bltz	a0,1dfa <createdelete+0x94>
        close(fd);
    1e38:	00004097          	auipc	ra,0x4
    1e3c:	dba080e7          	jalr	-582(ra) # 5bf2 <close>
        if(i > 0 && (i % 2 ) == 0){
    1e40:	fc905be3          	blez	s1,1e16 <createdelete+0xb0>
    1e44:	0014f793          	and	a5,s1,1
    1e48:	f7f9                	bnez	a5,1e16 <createdelete+0xb0>
          name[1] = '0' + (i / 2);
    1e4a:	01f4d79b          	srlw	a5,s1,0x1f
    1e4e:	9fa5                	addw	a5,a5,s1
    1e50:	4017d79b          	sraw	a5,a5,0x1
    1e54:	0307879b          	addw	a5,a5,48
    1e58:	f8f400a3          	sb	a5,-127(s0)
          if(unlink(name) < 0){
    1e5c:	f8040513          	add	a0,s0,-128
    1e60:	00004097          	auipc	ra,0x4
    1e64:	dba080e7          	jalr	-582(ra) # 5c1a <unlink>
    1e68:	fa0557e3          	bgez	a0,1e16 <createdelete+0xb0>
            printf("%s: unlink failed\n", s);
    1e6c:	85e6                	mv	a1,s9
    1e6e:	00005517          	auipc	a0,0x5
    1e72:	ee250513          	add	a0,a0,-286 # 6d50 <updateNode+0xaec>
    1e76:	00004097          	auipc	ra,0x4
    1e7a:	10c080e7          	jalr	268(ra) # 5f82 <printf>
            exit(1);
    1e7e:	4505                	li	a0,1
    1e80:	00004097          	auipc	ra,0x4
    1e84:	d4a080e7          	jalr	-694(ra) # 5bca <exit>
      exit(0);
    1e88:	4501                	li	a0,0
    1e8a:	00004097          	auipc	ra,0x4
    1e8e:	d40080e7          	jalr	-704(ra) # 5bca <exit>
      exit(1);
    1e92:	4505                	li	a0,1
    1e94:	00004097          	auipc	ra,0x4
    1e98:	d36080e7          	jalr	-714(ra) # 5bca <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    1e9c:	f8040613          	add	a2,s0,-128
    1ea0:	85e6                	mv	a1,s9
    1ea2:	00005517          	auipc	a0,0x5
    1ea6:	ec650513          	add	a0,a0,-314 # 6d68 <updateNode+0xb04>
    1eaa:	00004097          	auipc	ra,0x4
    1eae:	0d8080e7          	jalr	216(ra) # 5f82 <printf>
        exit(1);
    1eb2:	4505                	li	a0,1
    1eb4:	00004097          	auipc	ra,0x4
    1eb8:	d16080e7          	jalr	-746(ra) # 5bca <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1ebc:	054b7163          	bgeu	s6,s4,1efe <createdelete+0x198>
      if(fd >= 0)
    1ec0:	02055a63          	bgez	a0,1ef4 <createdelete+0x18e>
    for(pi = 0; pi < NCHILD; pi++){
    1ec4:	2485                	addw	s1,s1,1
    1ec6:	0ff4f493          	zext.b	s1,s1
    1eca:	05548c63          	beq	s1,s5,1f22 <createdelete+0x1bc>
      name[0] = 'p' + pi;
    1ece:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    1ed2:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
    1ed6:	4581                	li	a1,0
    1ed8:	f8040513          	add	a0,s0,-128
    1edc:	00004097          	auipc	ra,0x4
    1ee0:	d2e080e7          	jalr	-722(ra) # 5c0a <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1ee4:	00090463          	beqz	s2,1eec <createdelete+0x186>
    1ee8:	fd2bdae3          	bge	s7,s2,1ebc <createdelete+0x156>
    1eec:	fa0548e3          	bltz	a0,1e9c <createdelete+0x136>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1ef0:	014b7963          	bgeu	s6,s4,1f02 <createdelete+0x19c>
        close(fd);
    1ef4:	00004097          	auipc	ra,0x4
    1ef8:	cfe080e7          	jalr	-770(ra) # 5bf2 <close>
    1efc:	b7e1                	j	1ec4 <createdelete+0x15e>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1efe:	fc0543e3          	bltz	a0,1ec4 <createdelete+0x15e>
        printf("%s: oops createdelete %s did exist\n", s, name);
    1f02:	f8040613          	add	a2,s0,-128
    1f06:	85e6                	mv	a1,s9
    1f08:	00005517          	auipc	a0,0x5
    1f0c:	e8850513          	add	a0,a0,-376 # 6d90 <updateNode+0xb2c>
    1f10:	00004097          	auipc	ra,0x4
    1f14:	072080e7          	jalr	114(ra) # 5f82 <printf>
        exit(1);
    1f18:	4505                	li	a0,1
    1f1a:	00004097          	auipc	ra,0x4
    1f1e:	cb0080e7          	jalr	-848(ra) # 5bca <exit>
  for(i = 0; i < N; i++){
    1f22:	2905                	addw	s2,s2,1
    1f24:	2a05                	addw	s4,s4,1
    1f26:	2985                	addw	s3,s3,1 # 3001 <execout+0xa7>
    1f28:	0ff9f993          	zext.b	s3,s3
    1f2c:	47d1                	li	a5,20
    1f2e:	02f90a63          	beq	s2,a5,1f62 <createdelete+0x1fc>
    for(pi = 0; pi < NCHILD; pi++){
    1f32:	84e2                	mv	s1,s8
    1f34:	bf69                	j	1ece <createdelete+0x168>
  for(i = 0; i < N; i++){
    1f36:	2905                	addw	s2,s2,1
    1f38:	0ff97913          	zext.b	s2,s2
    1f3c:	2985                	addw	s3,s3,1
    1f3e:	0ff9f993          	zext.b	s3,s3
    1f42:	03490863          	beq	s2,s4,1f72 <createdelete+0x20c>
  name[0] = name[1] = name[2] = 0;
    1f46:	84d6                	mv	s1,s5
      name[0] = 'p' + i;
    1f48:	f9240023          	sb	s2,-128(s0)
      name[1] = '0' + i;
    1f4c:	f93400a3          	sb	s3,-127(s0)
      unlink(name);
    1f50:	f8040513          	add	a0,s0,-128
    1f54:	00004097          	auipc	ra,0x4
    1f58:	cc6080e7          	jalr	-826(ra) # 5c1a <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    1f5c:	34fd                	addw	s1,s1,-1
    1f5e:	f4ed                	bnez	s1,1f48 <createdelete+0x1e2>
    1f60:	bfd9                	j	1f36 <createdelete+0x1d0>
    1f62:	03000993          	li	s3,48
    1f66:	07000913          	li	s2,112
  name[0] = name[1] = name[2] = 0;
    1f6a:	4a91                	li	s5,4
  for(i = 0; i < N; i++){
    1f6c:	08400a13          	li	s4,132
    1f70:	bfd9                	j	1f46 <createdelete+0x1e0>
}
    1f72:	60aa                	ld	ra,136(sp)
    1f74:	640a                	ld	s0,128(sp)
    1f76:	74e6                	ld	s1,120(sp)
    1f78:	7946                	ld	s2,112(sp)
    1f7a:	79a6                	ld	s3,104(sp)
    1f7c:	7a06                	ld	s4,96(sp)
    1f7e:	6ae6                	ld	s5,88(sp)
    1f80:	6b46                	ld	s6,80(sp)
    1f82:	6ba6                	ld	s7,72(sp)
    1f84:	6c06                	ld	s8,64(sp)
    1f86:	7ce2                	ld	s9,56(sp)
    1f88:	6149                	add	sp,sp,144
    1f8a:	8082                	ret

0000000000001f8c <linkunlink>:
{
    1f8c:	711d                	add	sp,sp,-96
    1f8e:	ec86                	sd	ra,88(sp)
    1f90:	e8a2                	sd	s0,80(sp)
    1f92:	e4a6                	sd	s1,72(sp)
    1f94:	e0ca                	sd	s2,64(sp)
    1f96:	fc4e                	sd	s3,56(sp)
    1f98:	f852                	sd	s4,48(sp)
    1f9a:	f456                	sd	s5,40(sp)
    1f9c:	f05a                	sd	s6,32(sp)
    1f9e:	ec5e                	sd	s7,24(sp)
    1fa0:	e862                	sd	s8,16(sp)
    1fa2:	e466                	sd	s9,8(sp)
    1fa4:	1080                	add	s0,sp,96
    1fa6:	84aa                	mv	s1,a0
  unlink("x");
    1fa8:	00004517          	auipc	a0,0x4
    1fac:	3a050513          	add	a0,a0,928 # 6348 <updateNode+0xe4>
    1fb0:	00004097          	auipc	ra,0x4
    1fb4:	c6a080e7          	jalr	-918(ra) # 5c1a <unlink>
  pid = fork();
    1fb8:	00004097          	auipc	ra,0x4
    1fbc:	c0a080e7          	jalr	-1014(ra) # 5bc2 <fork>
  if(pid < 0){
    1fc0:	02054b63          	bltz	a0,1ff6 <linkunlink+0x6a>
    1fc4:	8c2a                	mv	s8,a0
  unsigned int x = (pid ? 1 : 97);
    1fc6:	06100c93          	li	s9,97
    1fca:	c111                	beqz	a0,1fce <linkunlink+0x42>
    1fcc:	4c85                	li	s9,1
    1fce:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    1fd2:	41c659b7          	lui	s3,0x41c65
    1fd6:	e6d9899b          	addw	s3,s3,-403 # 41c64e6d <base+0x41c551f5>
    1fda:	690d                	lui	s2,0x3
    1fdc:	0399091b          	addw	s2,s2,57 # 3039 <fourteen+0x1b>
    if((x % 3) == 0){
    1fe0:	4a0d                	li	s4,3
    } else if((x % 3) == 1){
    1fe2:	4b05                	li	s6,1
      unlink("x");
    1fe4:	00004a97          	auipc	s5,0x4
    1fe8:	364a8a93          	add	s5,s5,868 # 6348 <updateNode+0xe4>
      link("cat", "x");
    1fec:	00005b97          	auipc	s7,0x5
    1ff0:	dccb8b93          	add	s7,s7,-564 # 6db8 <updateNode+0xb54>
    1ff4:	a825                	j	202c <linkunlink+0xa0>
    printf("%s: fork failed\n", s);
    1ff6:	85a6                	mv	a1,s1
    1ff8:	00005517          	auipc	a0,0x5
    1ffc:	b6850513          	add	a0,a0,-1176 # 6b60 <updateNode+0x8fc>
    2000:	00004097          	auipc	ra,0x4
    2004:	f82080e7          	jalr	-126(ra) # 5f82 <printf>
    exit(1);
    2008:	4505                	li	a0,1
    200a:	00004097          	auipc	ra,0x4
    200e:	bc0080e7          	jalr	-1088(ra) # 5bca <exit>
      close(open("x", O_RDWR | O_CREATE));
    2012:	20200593          	li	a1,514
    2016:	8556                	mv	a0,s5
    2018:	00004097          	auipc	ra,0x4
    201c:	bf2080e7          	jalr	-1038(ra) # 5c0a <open>
    2020:	00004097          	auipc	ra,0x4
    2024:	bd2080e7          	jalr	-1070(ra) # 5bf2 <close>
  for(i = 0; i < 100; i++){
    2028:	34fd                	addw	s1,s1,-1
    202a:	c88d                	beqz	s1,205c <linkunlink+0xd0>
    x = x * 1103515245 + 12345;
    202c:	033c87bb          	mulw	a5,s9,s3
    2030:	012787bb          	addw	a5,a5,s2
    2034:	00078c9b          	sext.w	s9,a5
    if((x % 3) == 0){
    2038:	0347f7bb          	remuw	a5,a5,s4
    203c:	dbf9                	beqz	a5,2012 <linkunlink+0x86>
    } else if((x % 3) == 1){
    203e:	01678863          	beq	a5,s6,204e <linkunlink+0xc2>
      unlink("x");
    2042:	8556                	mv	a0,s5
    2044:	00004097          	auipc	ra,0x4
    2048:	bd6080e7          	jalr	-1066(ra) # 5c1a <unlink>
    204c:	bff1                	j	2028 <linkunlink+0x9c>
      link("cat", "x");
    204e:	85d6                	mv	a1,s5
    2050:	855e                	mv	a0,s7
    2052:	00004097          	auipc	ra,0x4
    2056:	bd8080e7          	jalr	-1064(ra) # 5c2a <link>
    205a:	b7f9                	j	2028 <linkunlink+0x9c>
  if(pid)
    205c:	020c0463          	beqz	s8,2084 <linkunlink+0xf8>
    wait(0);
    2060:	4501                	li	a0,0
    2062:	00004097          	auipc	ra,0x4
    2066:	b70080e7          	jalr	-1168(ra) # 5bd2 <wait>
}
    206a:	60e6                	ld	ra,88(sp)
    206c:	6446                	ld	s0,80(sp)
    206e:	64a6                	ld	s1,72(sp)
    2070:	6906                	ld	s2,64(sp)
    2072:	79e2                	ld	s3,56(sp)
    2074:	7a42                	ld	s4,48(sp)
    2076:	7aa2                	ld	s5,40(sp)
    2078:	7b02                	ld	s6,32(sp)
    207a:	6be2                	ld	s7,24(sp)
    207c:	6c42                	ld	s8,16(sp)
    207e:	6ca2                	ld	s9,8(sp)
    2080:	6125                	add	sp,sp,96
    2082:	8082                	ret
    exit(0);
    2084:	4501                	li	a0,0
    2086:	00004097          	auipc	ra,0x4
    208a:	b44080e7          	jalr	-1212(ra) # 5bca <exit>

000000000000208e <forktest>:
{
    208e:	7179                	add	sp,sp,-48
    2090:	f406                	sd	ra,40(sp)
    2092:	f022                	sd	s0,32(sp)
    2094:	ec26                	sd	s1,24(sp)
    2096:	e84a                	sd	s2,16(sp)
    2098:	e44e                	sd	s3,8(sp)
    209a:	1800                	add	s0,sp,48
    209c:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    209e:	4481                	li	s1,0
    20a0:	3e800913          	li	s2,1000
    pid = fork();
    20a4:	00004097          	auipc	ra,0x4
    20a8:	b1e080e7          	jalr	-1250(ra) # 5bc2 <fork>
    if(pid < 0)
    20ac:	02054863          	bltz	a0,20dc <forktest+0x4e>
    if(pid == 0)
    20b0:	c115                	beqz	a0,20d4 <forktest+0x46>
  for(n=0; n<N; n++){
    20b2:	2485                	addw	s1,s1,1
    20b4:	ff2498e3          	bne	s1,s2,20a4 <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    20b8:	85ce                	mv	a1,s3
    20ba:	00005517          	auipc	a0,0x5
    20be:	d1e50513          	add	a0,a0,-738 # 6dd8 <updateNode+0xb74>
    20c2:	00004097          	auipc	ra,0x4
    20c6:	ec0080e7          	jalr	-320(ra) # 5f82 <printf>
    exit(1);
    20ca:	4505                	li	a0,1
    20cc:	00004097          	auipc	ra,0x4
    20d0:	afe080e7          	jalr	-1282(ra) # 5bca <exit>
      exit(0);
    20d4:	00004097          	auipc	ra,0x4
    20d8:	af6080e7          	jalr	-1290(ra) # 5bca <exit>
  if (n == 0) {
    20dc:	cc9d                	beqz	s1,211a <forktest+0x8c>
  if(n == N){
    20de:	3e800793          	li	a5,1000
    20e2:	fcf48be3          	beq	s1,a5,20b8 <forktest+0x2a>
  for(; n > 0; n--){
    20e6:	00905b63          	blez	s1,20fc <forktest+0x6e>
    if(wait(0) < 0){
    20ea:	4501                	li	a0,0
    20ec:	00004097          	auipc	ra,0x4
    20f0:	ae6080e7          	jalr	-1306(ra) # 5bd2 <wait>
    20f4:	04054163          	bltz	a0,2136 <forktest+0xa8>
  for(; n > 0; n--){
    20f8:	34fd                	addw	s1,s1,-1
    20fa:	f8e5                	bnez	s1,20ea <forktest+0x5c>
  if(wait(0) != -1){
    20fc:	4501                	li	a0,0
    20fe:	00004097          	auipc	ra,0x4
    2102:	ad4080e7          	jalr	-1324(ra) # 5bd2 <wait>
    2106:	57fd                	li	a5,-1
    2108:	04f51563          	bne	a0,a5,2152 <forktest+0xc4>
}
    210c:	70a2                	ld	ra,40(sp)
    210e:	7402                	ld	s0,32(sp)
    2110:	64e2                	ld	s1,24(sp)
    2112:	6942                	ld	s2,16(sp)
    2114:	69a2                	ld	s3,8(sp)
    2116:	6145                	add	sp,sp,48
    2118:	8082                	ret
    printf("%s: no fork at all!\n", s);
    211a:	85ce                	mv	a1,s3
    211c:	00005517          	auipc	a0,0x5
    2120:	ca450513          	add	a0,a0,-860 # 6dc0 <updateNode+0xb5c>
    2124:	00004097          	auipc	ra,0x4
    2128:	e5e080e7          	jalr	-418(ra) # 5f82 <printf>
    exit(1);
    212c:	4505                	li	a0,1
    212e:	00004097          	auipc	ra,0x4
    2132:	a9c080e7          	jalr	-1380(ra) # 5bca <exit>
      printf("%s: wait stopped early\n", s);
    2136:	85ce                	mv	a1,s3
    2138:	00005517          	auipc	a0,0x5
    213c:	cc850513          	add	a0,a0,-824 # 6e00 <updateNode+0xb9c>
    2140:	00004097          	auipc	ra,0x4
    2144:	e42080e7          	jalr	-446(ra) # 5f82 <printf>
      exit(1);
    2148:	4505                	li	a0,1
    214a:	00004097          	auipc	ra,0x4
    214e:	a80080e7          	jalr	-1408(ra) # 5bca <exit>
    printf("%s: wait got too many\n", s);
    2152:	85ce                	mv	a1,s3
    2154:	00005517          	auipc	a0,0x5
    2158:	cc450513          	add	a0,a0,-828 # 6e18 <updateNode+0xbb4>
    215c:	00004097          	auipc	ra,0x4
    2160:	e26080e7          	jalr	-474(ra) # 5f82 <printf>
    exit(1);
    2164:	4505                	li	a0,1
    2166:	00004097          	auipc	ra,0x4
    216a:	a64080e7          	jalr	-1436(ra) # 5bca <exit>

000000000000216e <kernmem>:
{
    216e:	715d                	add	sp,sp,-80
    2170:	e486                	sd	ra,72(sp)
    2172:	e0a2                	sd	s0,64(sp)
    2174:	fc26                	sd	s1,56(sp)
    2176:	f84a                	sd	s2,48(sp)
    2178:	f44e                	sd	s3,40(sp)
    217a:	f052                	sd	s4,32(sp)
    217c:	ec56                	sd	s5,24(sp)
    217e:	0880                	add	s0,sp,80
    2180:	8a2a                	mv	s4,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2182:	4485                	li	s1,1
    2184:	04fe                	sll	s1,s1,0x1f
    if(xstatus != -1)  // did kernel kill child?
    2186:	5afd                	li	s5,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2188:	69b1                	lui	s3,0xc
    218a:	35098993          	add	s3,s3,848 # c350 <uninit+0x1de8>
    218e:	1003d937          	lui	s2,0x1003d
    2192:	090e                	sll	s2,s2,0x3
    2194:	48090913          	add	s2,s2,1152 # 1003d480 <base+0x1002d808>
    pid = fork();
    2198:	00004097          	auipc	ra,0x4
    219c:	a2a080e7          	jalr	-1494(ra) # 5bc2 <fork>
    if(pid < 0){
    21a0:	02054963          	bltz	a0,21d2 <kernmem+0x64>
    if(pid == 0){
    21a4:	c529                	beqz	a0,21ee <kernmem+0x80>
    wait(&xstatus);
    21a6:	fbc40513          	add	a0,s0,-68
    21aa:	00004097          	auipc	ra,0x4
    21ae:	a28080e7          	jalr	-1496(ra) # 5bd2 <wait>
    if(xstatus != -1)  // did kernel kill child?
    21b2:	fbc42783          	lw	a5,-68(s0)
    21b6:	05579d63          	bne	a5,s5,2210 <kernmem+0xa2>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    21ba:	94ce                	add	s1,s1,s3
    21bc:	fd249ee3          	bne	s1,s2,2198 <kernmem+0x2a>
}
    21c0:	60a6                	ld	ra,72(sp)
    21c2:	6406                	ld	s0,64(sp)
    21c4:	74e2                	ld	s1,56(sp)
    21c6:	7942                	ld	s2,48(sp)
    21c8:	79a2                	ld	s3,40(sp)
    21ca:	7a02                	ld	s4,32(sp)
    21cc:	6ae2                	ld	s5,24(sp)
    21ce:	6161                	add	sp,sp,80
    21d0:	8082                	ret
      printf("%s: fork failed\n", s);
    21d2:	85d2                	mv	a1,s4
    21d4:	00005517          	auipc	a0,0x5
    21d8:	98c50513          	add	a0,a0,-1652 # 6b60 <updateNode+0x8fc>
    21dc:	00004097          	auipc	ra,0x4
    21e0:	da6080e7          	jalr	-602(ra) # 5f82 <printf>
      exit(1);
    21e4:	4505                	li	a0,1
    21e6:	00004097          	auipc	ra,0x4
    21ea:	9e4080e7          	jalr	-1564(ra) # 5bca <exit>
      printf("%s: oops could read %x = %x\n", s, a, *a);
    21ee:	0004c683          	lbu	a3,0(s1)
    21f2:	8626                	mv	a2,s1
    21f4:	85d2                	mv	a1,s4
    21f6:	00005517          	auipc	a0,0x5
    21fa:	c3a50513          	add	a0,a0,-966 # 6e30 <updateNode+0xbcc>
    21fe:	00004097          	auipc	ra,0x4
    2202:	d84080e7          	jalr	-636(ra) # 5f82 <printf>
      exit(1);
    2206:	4505                	li	a0,1
    2208:	00004097          	auipc	ra,0x4
    220c:	9c2080e7          	jalr	-1598(ra) # 5bca <exit>
      exit(1);
    2210:	4505                	li	a0,1
    2212:	00004097          	auipc	ra,0x4
    2216:	9b8080e7          	jalr	-1608(ra) # 5bca <exit>

000000000000221a <MAXVAplus>:
{
    221a:	7179                	add	sp,sp,-48
    221c:	f406                	sd	ra,40(sp)
    221e:	f022                	sd	s0,32(sp)
    2220:	ec26                	sd	s1,24(sp)
    2222:	e84a                	sd	s2,16(sp)
    2224:	1800                	add	s0,sp,48
  volatile uint64 a = MAXVA;
    2226:	4785                	li	a5,1
    2228:	179a                	sll	a5,a5,0x26
    222a:	fcf43c23          	sd	a5,-40(s0)
  for( ; a != 0; a <<= 1){
    222e:	fd843783          	ld	a5,-40(s0)
    2232:	cf85                	beqz	a5,226a <MAXVAplus+0x50>
    2234:	892a                	mv	s2,a0
    if(xstatus != -1)  // did kernel kill child?
    2236:	54fd                	li	s1,-1
    pid = fork();
    2238:	00004097          	auipc	ra,0x4
    223c:	98a080e7          	jalr	-1654(ra) # 5bc2 <fork>
    if(pid < 0){
    2240:	02054b63          	bltz	a0,2276 <MAXVAplus+0x5c>
    if(pid == 0){
    2244:	c539                	beqz	a0,2292 <MAXVAplus+0x78>
    wait(&xstatus);
    2246:	fd440513          	add	a0,s0,-44
    224a:	00004097          	auipc	ra,0x4
    224e:	988080e7          	jalr	-1656(ra) # 5bd2 <wait>
    if(xstatus != -1)  // did kernel kill child?
    2252:	fd442783          	lw	a5,-44(s0)
    2256:	06979463          	bne	a5,s1,22be <MAXVAplus+0xa4>
  for( ; a != 0; a <<= 1){
    225a:	fd843783          	ld	a5,-40(s0)
    225e:	0786                	sll	a5,a5,0x1
    2260:	fcf43c23          	sd	a5,-40(s0)
    2264:	fd843783          	ld	a5,-40(s0)
    2268:	fbe1                	bnez	a5,2238 <MAXVAplus+0x1e>
}
    226a:	70a2                	ld	ra,40(sp)
    226c:	7402                	ld	s0,32(sp)
    226e:	64e2                	ld	s1,24(sp)
    2270:	6942                	ld	s2,16(sp)
    2272:	6145                	add	sp,sp,48
    2274:	8082                	ret
      printf("%s: fork failed\n", s);
    2276:	85ca                	mv	a1,s2
    2278:	00005517          	auipc	a0,0x5
    227c:	8e850513          	add	a0,a0,-1816 # 6b60 <updateNode+0x8fc>
    2280:	00004097          	auipc	ra,0x4
    2284:	d02080e7          	jalr	-766(ra) # 5f82 <printf>
      exit(1);
    2288:	4505                	li	a0,1
    228a:	00004097          	auipc	ra,0x4
    228e:	940080e7          	jalr	-1728(ra) # 5bca <exit>
      *(char*)a = 99;
    2292:	fd843783          	ld	a5,-40(s0)
    2296:	06300713          	li	a4,99
    229a:	00e78023          	sb	a4,0(a5)
      printf("%s: oops wrote %x\n", s, a);
    229e:	fd843603          	ld	a2,-40(s0)
    22a2:	85ca                	mv	a1,s2
    22a4:	00005517          	auipc	a0,0x5
    22a8:	bac50513          	add	a0,a0,-1108 # 6e50 <updateNode+0xbec>
    22ac:	00004097          	auipc	ra,0x4
    22b0:	cd6080e7          	jalr	-810(ra) # 5f82 <printf>
      exit(1);
    22b4:	4505                	li	a0,1
    22b6:	00004097          	auipc	ra,0x4
    22ba:	914080e7          	jalr	-1772(ra) # 5bca <exit>
      exit(1);
    22be:	4505                	li	a0,1
    22c0:	00004097          	auipc	ra,0x4
    22c4:	90a080e7          	jalr	-1782(ra) # 5bca <exit>

00000000000022c8 <bigargtest>:
{
    22c8:	7179                	add	sp,sp,-48
    22ca:	f406                	sd	ra,40(sp)
    22cc:	f022                	sd	s0,32(sp)
    22ce:	ec26                	sd	s1,24(sp)
    22d0:	1800                	add	s0,sp,48
    22d2:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    22d4:	00005517          	auipc	a0,0x5
    22d8:	b9450513          	add	a0,a0,-1132 # 6e68 <updateNode+0xc04>
    22dc:	00004097          	auipc	ra,0x4
    22e0:	93e080e7          	jalr	-1730(ra) # 5c1a <unlink>
  pid = fork();
    22e4:	00004097          	auipc	ra,0x4
    22e8:	8de080e7          	jalr	-1826(ra) # 5bc2 <fork>
  if(pid == 0){
    22ec:	c121                	beqz	a0,232c <bigargtest+0x64>
  } else if(pid < 0){
    22ee:	0a054063          	bltz	a0,238e <bigargtest+0xc6>
  wait(&xstatus);
    22f2:	fdc40513          	add	a0,s0,-36
    22f6:	00004097          	auipc	ra,0x4
    22fa:	8dc080e7          	jalr	-1828(ra) # 5bd2 <wait>
  if(xstatus != 0)
    22fe:	fdc42503          	lw	a0,-36(s0)
    2302:	e545                	bnez	a0,23aa <bigargtest+0xe2>
  fd = open("bigarg-ok", 0);
    2304:	4581                	li	a1,0
    2306:	00005517          	auipc	a0,0x5
    230a:	b6250513          	add	a0,a0,-1182 # 6e68 <updateNode+0xc04>
    230e:	00004097          	auipc	ra,0x4
    2312:	8fc080e7          	jalr	-1796(ra) # 5c0a <open>
  if(fd < 0){
    2316:	08054e63          	bltz	a0,23b2 <bigargtest+0xea>
  close(fd);
    231a:	00004097          	auipc	ra,0x4
    231e:	8d8080e7          	jalr	-1832(ra) # 5bf2 <close>
}
    2322:	70a2                	ld	ra,40(sp)
    2324:	7402                	ld	s0,32(sp)
    2326:	64e2                	ld	s1,24(sp)
    2328:	6145                	add	sp,sp,48
    232a:	8082                	ret
    232c:	00007797          	auipc	a5,0x7
    2330:	13478793          	add	a5,a5,308 # 9460 <args.1>
    2334:	00007697          	auipc	a3,0x7
    2338:	22468693          	add	a3,a3,548 # 9558 <args.1+0xf8>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    233c:	00005717          	auipc	a4,0x5
    2340:	b3c70713          	add	a4,a4,-1220 # 6e78 <updateNode+0xc14>
    2344:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    2346:	07a1                	add	a5,a5,8
    2348:	fed79ee3          	bne	a5,a3,2344 <bigargtest+0x7c>
    args[MAXARG-1] = 0;
    234c:	00007597          	auipc	a1,0x7
    2350:	11458593          	add	a1,a1,276 # 9460 <args.1>
    2354:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    2358:	00004517          	auipc	a0,0x4
    235c:	f8050513          	add	a0,a0,-128 # 62d8 <updateNode+0x74>
    2360:	00004097          	auipc	ra,0x4
    2364:	8a2080e7          	jalr	-1886(ra) # 5c02 <exec>
    fd = open("bigarg-ok", O_CREATE);
    2368:	20000593          	li	a1,512
    236c:	00005517          	auipc	a0,0x5
    2370:	afc50513          	add	a0,a0,-1284 # 6e68 <updateNode+0xc04>
    2374:	00004097          	auipc	ra,0x4
    2378:	896080e7          	jalr	-1898(ra) # 5c0a <open>
    close(fd);
    237c:	00004097          	auipc	ra,0x4
    2380:	876080e7          	jalr	-1930(ra) # 5bf2 <close>
    exit(0);
    2384:	4501                	li	a0,0
    2386:	00004097          	auipc	ra,0x4
    238a:	844080e7          	jalr	-1980(ra) # 5bca <exit>
    printf("%s: bigargtest: fork failed\n", s);
    238e:	85a6                	mv	a1,s1
    2390:	00005517          	auipc	a0,0x5
    2394:	bc850513          	add	a0,a0,-1080 # 6f58 <updateNode+0xcf4>
    2398:	00004097          	auipc	ra,0x4
    239c:	bea080e7          	jalr	-1046(ra) # 5f82 <printf>
    exit(1);
    23a0:	4505                	li	a0,1
    23a2:	00004097          	auipc	ra,0x4
    23a6:	828080e7          	jalr	-2008(ra) # 5bca <exit>
    exit(xstatus);
    23aa:	00004097          	auipc	ra,0x4
    23ae:	820080e7          	jalr	-2016(ra) # 5bca <exit>
    printf("%s: bigarg test failed!\n", s);
    23b2:	85a6                	mv	a1,s1
    23b4:	00005517          	auipc	a0,0x5
    23b8:	bc450513          	add	a0,a0,-1084 # 6f78 <updateNode+0xd14>
    23bc:	00004097          	auipc	ra,0x4
    23c0:	bc6080e7          	jalr	-1082(ra) # 5f82 <printf>
    exit(1);
    23c4:	4505                	li	a0,1
    23c6:	00004097          	auipc	ra,0x4
    23ca:	804080e7          	jalr	-2044(ra) # 5bca <exit>

00000000000023ce <stacktest>:
{
    23ce:	7179                	add	sp,sp,-48
    23d0:	f406                	sd	ra,40(sp)
    23d2:	f022                	sd	s0,32(sp)
    23d4:	ec26                	sd	s1,24(sp)
    23d6:	1800                	add	s0,sp,48
    23d8:	84aa                	mv	s1,a0
  pid = fork();
    23da:	00003097          	auipc	ra,0x3
    23de:	7e8080e7          	jalr	2024(ra) # 5bc2 <fork>
  if(pid == 0) {
    23e2:	c115                	beqz	a0,2406 <stacktest+0x38>
  } else if(pid < 0){
    23e4:	04054463          	bltz	a0,242c <stacktest+0x5e>
  wait(&xstatus);
    23e8:	fdc40513          	add	a0,s0,-36
    23ec:	00003097          	auipc	ra,0x3
    23f0:	7e6080e7          	jalr	2022(ra) # 5bd2 <wait>
  if(xstatus == -1)  // kernel killed child?
    23f4:	fdc42503          	lw	a0,-36(s0)
    23f8:	57fd                	li	a5,-1
    23fa:	04f50763          	beq	a0,a5,2448 <stacktest+0x7a>
    exit(xstatus);
    23fe:	00003097          	auipc	ra,0x3
    2402:	7cc080e7          	jalr	1996(ra) # 5bca <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    2406:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %p\n", s, *sp);
    2408:	77fd                	lui	a5,0xfffff
    240a:	97ba                	add	a5,a5,a4
    240c:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <base+0xfffffffffffef388>
    2410:	85a6                	mv	a1,s1
    2412:	00005517          	auipc	a0,0x5
    2416:	b8650513          	add	a0,a0,-1146 # 6f98 <updateNode+0xd34>
    241a:	00004097          	auipc	ra,0x4
    241e:	b68080e7          	jalr	-1176(ra) # 5f82 <printf>
    exit(1);
    2422:	4505                	li	a0,1
    2424:	00003097          	auipc	ra,0x3
    2428:	7a6080e7          	jalr	1958(ra) # 5bca <exit>
    printf("%s: fork failed\n", s);
    242c:	85a6                	mv	a1,s1
    242e:	00004517          	auipc	a0,0x4
    2432:	73250513          	add	a0,a0,1842 # 6b60 <updateNode+0x8fc>
    2436:	00004097          	auipc	ra,0x4
    243a:	b4c080e7          	jalr	-1204(ra) # 5f82 <printf>
    exit(1);
    243e:	4505                	li	a0,1
    2440:	00003097          	auipc	ra,0x3
    2444:	78a080e7          	jalr	1930(ra) # 5bca <exit>
    exit(0);
    2448:	4501                	li	a0,0
    244a:	00003097          	auipc	ra,0x3
    244e:	780080e7          	jalr	1920(ra) # 5bca <exit>

0000000000002452 <textwrite>:
{
    2452:	7179                	add	sp,sp,-48
    2454:	f406                	sd	ra,40(sp)
    2456:	f022                	sd	s0,32(sp)
    2458:	ec26                	sd	s1,24(sp)
    245a:	1800                	add	s0,sp,48
    245c:	84aa                	mv	s1,a0
  pid = fork();
    245e:	00003097          	auipc	ra,0x3
    2462:	764080e7          	jalr	1892(ra) # 5bc2 <fork>
  if(pid == 0) {
    2466:	c115                	beqz	a0,248a <textwrite+0x38>
  } else if(pid < 0){
    2468:	02054963          	bltz	a0,249a <textwrite+0x48>
  wait(&xstatus);
    246c:	fdc40513          	add	a0,s0,-36
    2470:	00003097          	auipc	ra,0x3
    2474:	762080e7          	jalr	1890(ra) # 5bd2 <wait>
  if(xstatus == -1)  // kernel killed child?
    2478:	fdc42503          	lw	a0,-36(s0)
    247c:	57fd                	li	a5,-1
    247e:	02f50c63          	beq	a0,a5,24b6 <textwrite+0x64>
    exit(xstatus);
    2482:	00003097          	auipc	ra,0x3
    2486:	748080e7          	jalr	1864(ra) # 5bca <exit>
    *addr = 10;
    248a:	47a9                	li	a5,10
    248c:	00f02023          	sw	a5,0(zero) # 0 <copyinstr1>
    exit(1);
    2490:	4505                	li	a0,1
    2492:	00003097          	auipc	ra,0x3
    2496:	738080e7          	jalr	1848(ra) # 5bca <exit>
    printf("%s: fork failed\n", s);
    249a:	85a6                	mv	a1,s1
    249c:	00004517          	auipc	a0,0x4
    24a0:	6c450513          	add	a0,a0,1732 # 6b60 <updateNode+0x8fc>
    24a4:	00004097          	auipc	ra,0x4
    24a8:	ade080e7          	jalr	-1314(ra) # 5f82 <printf>
    exit(1);
    24ac:	4505                	li	a0,1
    24ae:	00003097          	auipc	ra,0x3
    24b2:	71c080e7          	jalr	1820(ra) # 5bca <exit>
    exit(0);
    24b6:	4501                	li	a0,0
    24b8:	00003097          	auipc	ra,0x3
    24bc:	712080e7          	jalr	1810(ra) # 5bca <exit>

00000000000024c0 <manywrites>:
{
    24c0:	711d                	add	sp,sp,-96
    24c2:	ec86                	sd	ra,88(sp)
    24c4:	e8a2                	sd	s0,80(sp)
    24c6:	e4a6                	sd	s1,72(sp)
    24c8:	e0ca                	sd	s2,64(sp)
    24ca:	fc4e                	sd	s3,56(sp)
    24cc:	f852                	sd	s4,48(sp)
    24ce:	f456                	sd	s5,40(sp)
    24d0:	f05a                	sd	s6,32(sp)
    24d2:	ec5e                	sd	s7,24(sp)
    24d4:	1080                	add	s0,sp,96
    24d6:	8aaa                	mv	s5,a0
  for(int ci = 0; ci < nchildren; ci++){
    24d8:	4981                	li	s3,0
    24da:	4911                	li	s2,4
    int pid = fork();
    24dc:	00003097          	auipc	ra,0x3
    24e0:	6e6080e7          	jalr	1766(ra) # 5bc2 <fork>
    24e4:	84aa                	mv	s1,a0
    if(pid < 0){
    24e6:	02054963          	bltz	a0,2518 <manywrites+0x58>
    if(pid == 0){
    24ea:	c521                	beqz	a0,2532 <manywrites+0x72>
  for(int ci = 0; ci < nchildren; ci++){
    24ec:	2985                	addw	s3,s3,1
    24ee:	ff2997e3          	bne	s3,s2,24dc <manywrites+0x1c>
    24f2:	4491                	li	s1,4
    int st = 0;
    24f4:	fa042423          	sw	zero,-88(s0)
    wait(&st);
    24f8:	fa840513          	add	a0,s0,-88
    24fc:	00003097          	auipc	ra,0x3
    2500:	6d6080e7          	jalr	1750(ra) # 5bd2 <wait>
    if(st != 0)
    2504:	fa842503          	lw	a0,-88(s0)
    2508:	ed6d                	bnez	a0,2602 <manywrites+0x142>
  for(int ci = 0; ci < nchildren; ci++){
    250a:	34fd                	addw	s1,s1,-1
    250c:	f4e5                	bnez	s1,24f4 <manywrites+0x34>
  exit(0);
    250e:	4501                	li	a0,0
    2510:	00003097          	auipc	ra,0x3
    2514:	6ba080e7          	jalr	1722(ra) # 5bca <exit>
      printf("fork failed\n");
    2518:	00005517          	auipc	a0,0x5
    251c:	a5050513          	add	a0,a0,-1456 # 6f68 <updateNode+0xd04>
    2520:	00004097          	auipc	ra,0x4
    2524:	a62080e7          	jalr	-1438(ra) # 5f82 <printf>
      exit(1);
    2528:	4505                	li	a0,1
    252a:	00003097          	auipc	ra,0x3
    252e:	6a0080e7          	jalr	1696(ra) # 5bca <exit>
      name[0] = 'b';
    2532:	06200793          	li	a5,98
    2536:	faf40423          	sb	a5,-88(s0)
      name[1] = 'a' + ci;
    253a:	0619879b          	addw	a5,s3,97
    253e:	faf404a3          	sb	a5,-87(s0)
      name[2] = '\0';
    2542:	fa040523          	sb	zero,-86(s0)
      unlink(name);
    2546:	fa840513          	add	a0,s0,-88
    254a:	00003097          	auipc	ra,0x3
    254e:	6d0080e7          	jalr	1744(ra) # 5c1a <unlink>
    2552:	4bf9                	li	s7,30
          int cc = write(fd, buf, sz);
    2554:	0000ab17          	auipc	s6,0xa
    2558:	724b0b13          	add	s6,s6,1828 # cc78 <buf>
        for(int i = 0; i < ci+1; i++){
    255c:	8a26                	mv	s4,s1
    255e:	0209ce63          	bltz	s3,259a <manywrites+0xda>
          int fd = open(name, O_CREATE | O_RDWR);
    2562:	20200593          	li	a1,514
    2566:	fa840513          	add	a0,s0,-88
    256a:	00003097          	auipc	ra,0x3
    256e:	6a0080e7          	jalr	1696(ra) # 5c0a <open>
    2572:	892a                	mv	s2,a0
          if(fd < 0){
    2574:	04054763          	bltz	a0,25c2 <manywrites+0x102>
          int cc = write(fd, buf, sz);
    2578:	660d                	lui	a2,0x3
    257a:	85da                	mv	a1,s6
    257c:	00003097          	auipc	ra,0x3
    2580:	66e080e7          	jalr	1646(ra) # 5bea <write>
          if(cc != sz){
    2584:	678d                	lui	a5,0x3
    2586:	04f51e63          	bne	a0,a5,25e2 <manywrites+0x122>
          close(fd);
    258a:	854a                	mv	a0,s2
    258c:	00003097          	auipc	ra,0x3
    2590:	666080e7          	jalr	1638(ra) # 5bf2 <close>
        for(int i = 0; i < ci+1; i++){
    2594:	2a05                	addw	s4,s4,1
    2596:	fd49d6e3          	bge	s3,s4,2562 <manywrites+0xa2>
        unlink(name);
    259a:	fa840513          	add	a0,s0,-88
    259e:	00003097          	auipc	ra,0x3
    25a2:	67c080e7          	jalr	1660(ra) # 5c1a <unlink>
      for(int iters = 0; iters < howmany; iters++){
    25a6:	3bfd                	addw	s7,s7,-1
    25a8:	fa0b9ae3          	bnez	s7,255c <manywrites+0x9c>
      unlink(name);
    25ac:	fa840513          	add	a0,s0,-88
    25b0:	00003097          	auipc	ra,0x3
    25b4:	66a080e7          	jalr	1642(ra) # 5c1a <unlink>
      exit(0);
    25b8:	4501                	li	a0,0
    25ba:	00003097          	auipc	ra,0x3
    25be:	610080e7          	jalr	1552(ra) # 5bca <exit>
            printf("%s: cannot create %s\n", s, name);
    25c2:	fa840613          	add	a2,s0,-88
    25c6:	85d6                	mv	a1,s5
    25c8:	00005517          	auipc	a0,0x5
    25cc:	9f850513          	add	a0,a0,-1544 # 6fc0 <updateNode+0xd5c>
    25d0:	00004097          	auipc	ra,0x4
    25d4:	9b2080e7          	jalr	-1614(ra) # 5f82 <printf>
            exit(1);
    25d8:	4505                	li	a0,1
    25da:	00003097          	auipc	ra,0x3
    25de:	5f0080e7          	jalr	1520(ra) # 5bca <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    25e2:	86aa                	mv	a3,a0
    25e4:	660d                	lui	a2,0x3
    25e6:	85d6                	mv	a1,s5
    25e8:	00004517          	auipc	a0,0x4
    25ec:	dc050513          	add	a0,a0,-576 # 63a8 <updateNode+0x144>
    25f0:	00004097          	auipc	ra,0x4
    25f4:	992080e7          	jalr	-1646(ra) # 5f82 <printf>
            exit(1);
    25f8:	4505                	li	a0,1
    25fa:	00003097          	auipc	ra,0x3
    25fe:	5d0080e7          	jalr	1488(ra) # 5bca <exit>
      exit(st);
    2602:	00003097          	auipc	ra,0x3
    2606:	5c8080e7          	jalr	1480(ra) # 5bca <exit>

000000000000260a <copyinstr3>:
{
    260a:	7179                	add	sp,sp,-48
    260c:	f406                	sd	ra,40(sp)
    260e:	f022                	sd	s0,32(sp)
    2610:	ec26                	sd	s1,24(sp)
    2612:	1800                	add	s0,sp,48
  sbrk(8192);
    2614:	6509                	lui	a0,0x2
    2616:	00003097          	auipc	ra,0x3
    261a:	63c080e7          	jalr	1596(ra) # 5c52 <sbrk>
  uint64 top = (uint64) sbrk(0);
    261e:	4501                	li	a0,0
    2620:	00003097          	auipc	ra,0x3
    2624:	632080e7          	jalr	1586(ra) # 5c52 <sbrk>
  if((top % PGSIZE) != 0){
    2628:	03451793          	sll	a5,a0,0x34
    262c:	e3c9                	bnez	a5,26ae <copyinstr3+0xa4>
  top = (uint64) sbrk(0);
    262e:	4501                	li	a0,0
    2630:	00003097          	auipc	ra,0x3
    2634:	622080e7          	jalr	1570(ra) # 5c52 <sbrk>
  if(top % PGSIZE){
    2638:	03451793          	sll	a5,a0,0x34
    263c:	e3d9                	bnez	a5,26c2 <copyinstr3+0xb8>
  char *b = (char *) (top - 1);
    263e:	fff50493          	add	s1,a0,-1 # 1fff <linkunlink+0x73>
  *b = 'x';
    2642:	07800793          	li	a5,120
    2646:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    264a:	8526                	mv	a0,s1
    264c:	00003097          	auipc	ra,0x3
    2650:	5ce080e7          	jalr	1486(ra) # 5c1a <unlink>
  if(ret != -1){
    2654:	57fd                	li	a5,-1
    2656:	08f51363          	bne	a0,a5,26dc <copyinstr3+0xd2>
  int fd = open(b, O_CREATE | O_WRONLY);
    265a:	20100593          	li	a1,513
    265e:	8526                	mv	a0,s1
    2660:	00003097          	auipc	ra,0x3
    2664:	5aa080e7          	jalr	1450(ra) # 5c0a <open>
  if(fd != -1){
    2668:	57fd                	li	a5,-1
    266a:	08f51863          	bne	a0,a5,26fa <copyinstr3+0xf0>
  ret = link(b, b);
    266e:	85a6                	mv	a1,s1
    2670:	8526                	mv	a0,s1
    2672:	00003097          	auipc	ra,0x3
    2676:	5b8080e7          	jalr	1464(ra) # 5c2a <link>
  if(ret != -1){
    267a:	57fd                	li	a5,-1
    267c:	08f51e63          	bne	a0,a5,2718 <copyinstr3+0x10e>
  char *args[] = { "xx", 0 };
    2680:	00005797          	auipc	a5,0x5
    2684:	63878793          	add	a5,a5,1592 # 7cb8 <updateNode+0x1a54>
    2688:	fcf43823          	sd	a5,-48(s0)
    268c:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    2690:	fd040593          	add	a1,s0,-48
    2694:	8526                	mv	a0,s1
    2696:	00003097          	auipc	ra,0x3
    269a:	56c080e7          	jalr	1388(ra) # 5c02 <exec>
  if(ret != -1){
    269e:	57fd                	li	a5,-1
    26a0:	08f51c63          	bne	a0,a5,2738 <copyinstr3+0x12e>
}
    26a4:	70a2                	ld	ra,40(sp)
    26a6:	7402                	ld	s0,32(sp)
    26a8:	64e2                	ld	s1,24(sp)
    26aa:	6145                	add	sp,sp,48
    26ac:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    26ae:	0347d513          	srl	a0,a5,0x34
    26b2:	6785                	lui	a5,0x1
    26b4:	40a7853b          	subw	a0,a5,a0
    26b8:	00003097          	auipc	ra,0x3
    26bc:	59a080e7          	jalr	1434(ra) # 5c52 <sbrk>
    26c0:	b7bd                	j	262e <copyinstr3+0x24>
    printf("oops\n");
    26c2:	00005517          	auipc	a0,0x5
    26c6:	91650513          	add	a0,a0,-1770 # 6fd8 <updateNode+0xd74>
    26ca:	00004097          	auipc	ra,0x4
    26ce:	8b8080e7          	jalr	-1864(ra) # 5f82 <printf>
    exit(1);
    26d2:	4505                	li	a0,1
    26d4:	00003097          	auipc	ra,0x3
    26d8:	4f6080e7          	jalr	1270(ra) # 5bca <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    26dc:	862a                	mv	a2,a0
    26de:	85a6                	mv	a1,s1
    26e0:	00004517          	auipc	a0,0x4
    26e4:	3a050513          	add	a0,a0,928 # 6a80 <updateNode+0x81c>
    26e8:	00004097          	auipc	ra,0x4
    26ec:	89a080e7          	jalr	-1894(ra) # 5f82 <printf>
    exit(1);
    26f0:	4505                	li	a0,1
    26f2:	00003097          	auipc	ra,0x3
    26f6:	4d8080e7          	jalr	1240(ra) # 5bca <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    26fa:	862a                	mv	a2,a0
    26fc:	85a6                	mv	a1,s1
    26fe:	00004517          	auipc	a0,0x4
    2702:	3a250513          	add	a0,a0,930 # 6aa0 <updateNode+0x83c>
    2706:	00004097          	auipc	ra,0x4
    270a:	87c080e7          	jalr	-1924(ra) # 5f82 <printf>
    exit(1);
    270e:	4505                	li	a0,1
    2710:	00003097          	auipc	ra,0x3
    2714:	4ba080e7          	jalr	1210(ra) # 5bca <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    2718:	86aa                	mv	a3,a0
    271a:	8626                	mv	a2,s1
    271c:	85a6                	mv	a1,s1
    271e:	00004517          	auipc	a0,0x4
    2722:	3a250513          	add	a0,a0,930 # 6ac0 <updateNode+0x85c>
    2726:	00004097          	auipc	ra,0x4
    272a:	85c080e7          	jalr	-1956(ra) # 5f82 <printf>
    exit(1);
    272e:	4505                	li	a0,1
    2730:	00003097          	auipc	ra,0x3
    2734:	49a080e7          	jalr	1178(ra) # 5bca <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    2738:	567d                	li	a2,-1
    273a:	85a6                	mv	a1,s1
    273c:	00004517          	auipc	a0,0x4
    2740:	3ac50513          	add	a0,a0,940 # 6ae8 <updateNode+0x884>
    2744:	00004097          	auipc	ra,0x4
    2748:	83e080e7          	jalr	-1986(ra) # 5f82 <printf>
    exit(1);
    274c:	4505                	li	a0,1
    274e:	00003097          	auipc	ra,0x3
    2752:	47c080e7          	jalr	1148(ra) # 5bca <exit>

0000000000002756 <rwsbrk>:
{
    2756:	1101                	add	sp,sp,-32
    2758:	ec06                	sd	ra,24(sp)
    275a:	e822                	sd	s0,16(sp)
    275c:	e426                	sd	s1,8(sp)
    275e:	e04a                	sd	s2,0(sp)
    2760:	1000                	add	s0,sp,32
  uint64 a = (uint64) sbrk(8192);
    2762:	6509                	lui	a0,0x2
    2764:	00003097          	auipc	ra,0x3
    2768:	4ee080e7          	jalr	1262(ra) # 5c52 <sbrk>
  if(a == 0xffffffffffffffffLL) {
    276c:	57fd                	li	a5,-1
    276e:	06f50263          	beq	a0,a5,27d2 <rwsbrk+0x7c>
    2772:	84aa                	mv	s1,a0
  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
    2774:	7579                	lui	a0,0xffffe
    2776:	00003097          	auipc	ra,0x3
    277a:	4dc080e7          	jalr	1244(ra) # 5c52 <sbrk>
    277e:	57fd                	li	a5,-1
    2780:	06f50663          	beq	a0,a5,27ec <rwsbrk+0x96>
  fd = open("rwsbrk", O_CREATE|O_WRONLY);
    2784:	20100593          	li	a1,513
    2788:	00005517          	auipc	a0,0x5
    278c:	89050513          	add	a0,a0,-1904 # 7018 <updateNode+0xdb4>
    2790:	00003097          	auipc	ra,0x3
    2794:	47a080e7          	jalr	1146(ra) # 5c0a <open>
    2798:	892a                	mv	s2,a0
  if(fd < 0){
    279a:	06054663          	bltz	a0,2806 <rwsbrk+0xb0>
  n = write(fd, (void*)(a+4096), 1024);
    279e:	6785                	lui	a5,0x1
    27a0:	94be                	add	s1,s1,a5
    27a2:	40000613          	li	a2,1024
    27a6:	85a6                	mv	a1,s1
    27a8:	00003097          	auipc	ra,0x3
    27ac:	442080e7          	jalr	1090(ra) # 5bea <write>
    27b0:	862a                	mv	a2,a0
  if(n >= 0){
    27b2:	06054763          	bltz	a0,2820 <rwsbrk+0xca>
    printf("write(fd, %p, 1024) returned %d, not -1\n", a+4096, n);
    27b6:	85a6                	mv	a1,s1
    27b8:	00005517          	auipc	a0,0x5
    27bc:	88050513          	add	a0,a0,-1920 # 7038 <updateNode+0xdd4>
    27c0:	00003097          	auipc	ra,0x3
    27c4:	7c2080e7          	jalr	1986(ra) # 5f82 <printf>
    exit(1);
    27c8:	4505                	li	a0,1
    27ca:	00003097          	auipc	ra,0x3
    27ce:	400080e7          	jalr	1024(ra) # 5bca <exit>
    printf("sbrk(rwsbrk) failed\n");
    27d2:	00005517          	auipc	a0,0x5
    27d6:	80e50513          	add	a0,a0,-2034 # 6fe0 <updateNode+0xd7c>
    27da:	00003097          	auipc	ra,0x3
    27de:	7a8080e7          	jalr	1960(ra) # 5f82 <printf>
    exit(1);
    27e2:	4505                	li	a0,1
    27e4:	00003097          	auipc	ra,0x3
    27e8:	3e6080e7          	jalr	998(ra) # 5bca <exit>
    printf("sbrk(rwsbrk) shrink failed\n");
    27ec:	00005517          	auipc	a0,0x5
    27f0:	80c50513          	add	a0,a0,-2036 # 6ff8 <updateNode+0xd94>
    27f4:	00003097          	auipc	ra,0x3
    27f8:	78e080e7          	jalr	1934(ra) # 5f82 <printf>
    exit(1);
    27fc:	4505                	li	a0,1
    27fe:	00003097          	auipc	ra,0x3
    2802:	3cc080e7          	jalr	972(ra) # 5bca <exit>
    printf("open(rwsbrk) failed\n");
    2806:	00005517          	auipc	a0,0x5
    280a:	81a50513          	add	a0,a0,-2022 # 7020 <updateNode+0xdbc>
    280e:	00003097          	auipc	ra,0x3
    2812:	774080e7          	jalr	1908(ra) # 5f82 <printf>
    exit(1);
    2816:	4505                	li	a0,1
    2818:	00003097          	auipc	ra,0x3
    281c:	3b2080e7          	jalr	946(ra) # 5bca <exit>
  close(fd);
    2820:	854a                	mv	a0,s2
    2822:	00003097          	auipc	ra,0x3
    2826:	3d0080e7          	jalr	976(ra) # 5bf2 <close>
  unlink("rwsbrk");
    282a:	00004517          	auipc	a0,0x4
    282e:	7ee50513          	add	a0,a0,2030 # 7018 <updateNode+0xdb4>
    2832:	00003097          	auipc	ra,0x3
    2836:	3e8080e7          	jalr	1000(ra) # 5c1a <unlink>
  fd = open("README", O_RDONLY);
    283a:	4581                	li	a1,0
    283c:	00004517          	auipc	a0,0x4
    2840:	c7450513          	add	a0,a0,-908 # 64b0 <updateNode+0x24c>
    2844:	00003097          	auipc	ra,0x3
    2848:	3c6080e7          	jalr	966(ra) # 5c0a <open>
    284c:	892a                	mv	s2,a0
  if(fd < 0){
    284e:	02054963          	bltz	a0,2880 <rwsbrk+0x12a>
  n = read(fd, (void*)(a+4096), 10);
    2852:	4629                	li	a2,10
    2854:	85a6                	mv	a1,s1
    2856:	00003097          	auipc	ra,0x3
    285a:	38c080e7          	jalr	908(ra) # 5be2 <read>
    285e:	862a                	mv	a2,a0
  if(n >= 0){
    2860:	02054d63          	bltz	a0,289a <rwsbrk+0x144>
    printf("read(fd, %p, 10) returned %d, not -1\n", a+4096, n);
    2864:	85a6                	mv	a1,s1
    2866:	00005517          	auipc	a0,0x5
    286a:	80250513          	add	a0,a0,-2046 # 7068 <updateNode+0xe04>
    286e:	00003097          	auipc	ra,0x3
    2872:	714080e7          	jalr	1812(ra) # 5f82 <printf>
    exit(1);
    2876:	4505                	li	a0,1
    2878:	00003097          	auipc	ra,0x3
    287c:	352080e7          	jalr	850(ra) # 5bca <exit>
    printf("open(rwsbrk) failed\n");
    2880:	00004517          	auipc	a0,0x4
    2884:	7a050513          	add	a0,a0,1952 # 7020 <updateNode+0xdbc>
    2888:	00003097          	auipc	ra,0x3
    288c:	6fa080e7          	jalr	1786(ra) # 5f82 <printf>
    exit(1);
    2890:	4505                	li	a0,1
    2892:	00003097          	auipc	ra,0x3
    2896:	338080e7          	jalr	824(ra) # 5bca <exit>
  close(fd);
    289a:	854a                	mv	a0,s2
    289c:	00003097          	auipc	ra,0x3
    28a0:	356080e7          	jalr	854(ra) # 5bf2 <close>
  exit(0);
    28a4:	4501                	li	a0,0
    28a6:	00003097          	auipc	ra,0x3
    28aa:	324080e7          	jalr	804(ra) # 5bca <exit>

00000000000028ae <sbrkbasic>:
{
    28ae:	7139                	add	sp,sp,-64
    28b0:	fc06                	sd	ra,56(sp)
    28b2:	f822                	sd	s0,48(sp)
    28b4:	f426                	sd	s1,40(sp)
    28b6:	f04a                	sd	s2,32(sp)
    28b8:	ec4e                	sd	s3,24(sp)
    28ba:	e852                	sd	s4,16(sp)
    28bc:	0080                	add	s0,sp,64
    28be:	8a2a                	mv	s4,a0
  pid = fork();
    28c0:	00003097          	auipc	ra,0x3
    28c4:	302080e7          	jalr	770(ra) # 5bc2 <fork>
  if(pid < 0){
    28c8:	02054c63          	bltz	a0,2900 <sbrkbasic+0x52>
  if(pid == 0){
    28cc:	ed21                	bnez	a0,2924 <sbrkbasic+0x76>
    a = sbrk(TOOMUCH);
    28ce:	40000537          	lui	a0,0x40000
    28d2:	00003097          	auipc	ra,0x3
    28d6:	380080e7          	jalr	896(ra) # 5c52 <sbrk>
    if(a == (char*)0xffffffffffffffffL){
    28da:	57fd                	li	a5,-1
    28dc:	02f50f63          	beq	a0,a5,291a <sbrkbasic+0x6c>
    for(b = a; b < a+TOOMUCH; b += 4096){
    28e0:	400007b7          	lui	a5,0x40000
    28e4:	97aa                	add	a5,a5,a0
      *b = 99;
    28e6:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += 4096){
    28ea:	6705                	lui	a4,0x1
      *b = 99;
    28ec:	00d50023          	sb	a3,0(a0) # 40000000 <base+0x3fff0388>
    for(b = a; b < a+TOOMUCH; b += 4096){
    28f0:	953a                	add	a0,a0,a4
    28f2:	fef51de3          	bne	a0,a5,28ec <sbrkbasic+0x3e>
    exit(1);
    28f6:	4505                	li	a0,1
    28f8:	00003097          	auipc	ra,0x3
    28fc:	2d2080e7          	jalr	722(ra) # 5bca <exit>
    printf("fork failed in sbrkbasic\n");
    2900:	00004517          	auipc	a0,0x4
    2904:	79050513          	add	a0,a0,1936 # 7090 <updateNode+0xe2c>
    2908:	00003097          	auipc	ra,0x3
    290c:	67a080e7          	jalr	1658(ra) # 5f82 <printf>
    exit(1);
    2910:	4505                	li	a0,1
    2912:	00003097          	auipc	ra,0x3
    2916:	2b8080e7          	jalr	696(ra) # 5bca <exit>
      exit(0);
    291a:	4501                	li	a0,0
    291c:	00003097          	auipc	ra,0x3
    2920:	2ae080e7          	jalr	686(ra) # 5bca <exit>
  wait(&xstatus);
    2924:	fcc40513          	add	a0,s0,-52
    2928:	00003097          	auipc	ra,0x3
    292c:	2aa080e7          	jalr	682(ra) # 5bd2 <wait>
  if(xstatus == 1){
    2930:	fcc42703          	lw	a4,-52(s0)
    2934:	4785                	li	a5,1
    2936:	00f70d63          	beq	a4,a5,2950 <sbrkbasic+0xa2>
  a = sbrk(0);
    293a:	4501                	li	a0,0
    293c:	00003097          	auipc	ra,0x3
    2940:	316080e7          	jalr	790(ra) # 5c52 <sbrk>
    2944:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    2946:	4901                	li	s2,0
    2948:	6985                	lui	s3,0x1
    294a:	38898993          	add	s3,s3,904 # 1388 <badarg+0x3e>
    294e:	a005                	j	296e <sbrkbasic+0xc0>
    printf("%s: too much memory allocated!\n", s);
    2950:	85d2                	mv	a1,s4
    2952:	00004517          	auipc	a0,0x4
    2956:	75e50513          	add	a0,a0,1886 # 70b0 <updateNode+0xe4c>
    295a:	00003097          	auipc	ra,0x3
    295e:	628080e7          	jalr	1576(ra) # 5f82 <printf>
    exit(1);
    2962:	4505                	li	a0,1
    2964:	00003097          	auipc	ra,0x3
    2968:	266080e7          	jalr	614(ra) # 5bca <exit>
    a = b + 1;
    296c:	84be                	mv	s1,a5
    b = sbrk(1);
    296e:	4505                	li	a0,1
    2970:	00003097          	auipc	ra,0x3
    2974:	2e2080e7          	jalr	738(ra) # 5c52 <sbrk>
    if(b != a){
    2978:	04951c63          	bne	a0,s1,29d0 <sbrkbasic+0x122>
    *b = 1;
    297c:	4785                	li	a5,1
    297e:	00f48023          	sb	a5,0(s1)
    a = b + 1;
    2982:	00148793          	add	a5,s1,1
  for(i = 0; i < 5000; i++){
    2986:	2905                	addw	s2,s2,1
    2988:	ff3912e3          	bne	s2,s3,296c <sbrkbasic+0xbe>
  pid = fork();
    298c:	00003097          	auipc	ra,0x3
    2990:	236080e7          	jalr	566(ra) # 5bc2 <fork>
    2994:	892a                	mv	s2,a0
  if(pid < 0){
    2996:	04054e63          	bltz	a0,29f2 <sbrkbasic+0x144>
  c = sbrk(1);
    299a:	4505                	li	a0,1
    299c:	00003097          	auipc	ra,0x3
    29a0:	2b6080e7          	jalr	694(ra) # 5c52 <sbrk>
  c = sbrk(1);
    29a4:	4505                	li	a0,1
    29a6:	00003097          	auipc	ra,0x3
    29aa:	2ac080e7          	jalr	684(ra) # 5c52 <sbrk>
  if(c != a + 1){
    29ae:	0489                	add	s1,s1,2
    29b0:	04a48f63          	beq	s1,a0,2a0e <sbrkbasic+0x160>
    printf("%s: sbrk test failed post-fork\n", s);
    29b4:	85d2                	mv	a1,s4
    29b6:	00004517          	auipc	a0,0x4
    29ba:	75a50513          	add	a0,a0,1882 # 7110 <updateNode+0xeac>
    29be:	00003097          	auipc	ra,0x3
    29c2:	5c4080e7          	jalr	1476(ra) # 5f82 <printf>
    exit(1);
    29c6:	4505                	li	a0,1
    29c8:	00003097          	auipc	ra,0x3
    29cc:	202080e7          	jalr	514(ra) # 5bca <exit>
      printf("%s: sbrk test failed %d %x %x\n", s, i, a, b);
    29d0:	872a                	mv	a4,a0
    29d2:	86a6                	mv	a3,s1
    29d4:	864a                	mv	a2,s2
    29d6:	85d2                	mv	a1,s4
    29d8:	00004517          	auipc	a0,0x4
    29dc:	6f850513          	add	a0,a0,1784 # 70d0 <updateNode+0xe6c>
    29e0:	00003097          	auipc	ra,0x3
    29e4:	5a2080e7          	jalr	1442(ra) # 5f82 <printf>
      exit(1);
    29e8:	4505                	li	a0,1
    29ea:	00003097          	auipc	ra,0x3
    29ee:	1e0080e7          	jalr	480(ra) # 5bca <exit>
    printf("%s: sbrk test fork failed\n", s);
    29f2:	85d2                	mv	a1,s4
    29f4:	00004517          	auipc	a0,0x4
    29f8:	6fc50513          	add	a0,a0,1788 # 70f0 <updateNode+0xe8c>
    29fc:	00003097          	auipc	ra,0x3
    2a00:	586080e7          	jalr	1414(ra) # 5f82 <printf>
    exit(1);
    2a04:	4505                	li	a0,1
    2a06:	00003097          	auipc	ra,0x3
    2a0a:	1c4080e7          	jalr	452(ra) # 5bca <exit>
  if(pid == 0)
    2a0e:	00091763          	bnez	s2,2a1c <sbrkbasic+0x16e>
    exit(0);
    2a12:	4501                	li	a0,0
    2a14:	00003097          	auipc	ra,0x3
    2a18:	1b6080e7          	jalr	438(ra) # 5bca <exit>
  wait(&xstatus);
    2a1c:	fcc40513          	add	a0,s0,-52
    2a20:	00003097          	auipc	ra,0x3
    2a24:	1b2080e7          	jalr	434(ra) # 5bd2 <wait>
  exit(xstatus);
    2a28:	fcc42503          	lw	a0,-52(s0)
    2a2c:	00003097          	auipc	ra,0x3
    2a30:	19e080e7          	jalr	414(ra) # 5bca <exit>

0000000000002a34 <sbrkmuch>:
{
    2a34:	7179                	add	sp,sp,-48
    2a36:	f406                	sd	ra,40(sp)
    2a38:	f022                	sd	s0,32(sp)
    2a3a:	ec26                	sd	s1,24(sp)
    2a3c:	e84a                	sd	s2,16(sp)
    2a3e:	e44e                	sd	s3,8(sp)
    2a40:	e052                	sd	s4,0(sp)
    2a42:	1800                	add	s0,sp,48
    2a44:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    2a46:	4501                	li	a0,0
    2a48:	00003097          	auipc	ra,0x3
    2a4c:	20a080e7          	jalr	522(ra) # 5c52 <sbrk>
    2a50:	892a                	mv	s2,a0
  a = sbrk(0);
    2a52:	4501                	li	a0,0
    2a54:	00003097          	auipc	ra,0x3
    2a58:	1fe080e7          	jalr	510(ra) # 5c52 <sbrk>
    2a5c:	84aa                	mv	s1,a0
  p = sbrk(amt);
    2a5e:	06400537          	lui	a0,0x6400
    2a62:	9d05                	subw	a0,a0,s1
    2a64:	00003097          	auipc	ra,0x3
    2a68:	1ee080e7          	jalr	494(ra) # 5c52 <sbrk>
  if (p != a) {
    2a6c:	0ca49863          	bne	s1,a0,2b3c <sbrkmuch+0x108>
  char *eee = sbrk(0);
    2a70:	4501                	li	a0,0
    2a72:	00003097          	auipc	ra,0x3
    2a76:	1e0080e7          	jalr	480(ra) # 5c52 <sbrk>
    2a7a:	87aa                	mv	a5,a0
  for(char *pp = a; pp < eee; pp += 4096)
    2a7c:	00a4f963          	bgeu	s1,a0,2a8e <sbrkmuch+0x5a>
    *pp = 1;
    2a80:	4685                	li	a3,1
  for(char *pp = a; pp < eee; pp += 4096)
    2a82:	6705                	lui	a4,0x1
    *pp = 1;
    2a84:	00d48023          	sb	a3,0(s1)
  for(char *pp = a; pp < eee; pp += 4096)
    2a88:	94ba                	add	s1,s1,a4
    2a8a:	fef4ede3          	bltu	s1,a5,2a84 <sbrkmuch+0x50>
  *lastaddr = 99;
    2a8e:	064007b7          	lui	a5,0x6400
    2a92:	06300713          	li	a4,99
    2a96:	fee78fa3          	sb	a4,-1(a5) # 63fffff <base+0x63f0387>
  a = sbrk(0);
    2a9a:	4501                	li	a0,0
    2a9c:	00003097          	auipc	ra,0x3
    2aa0:	1b6080e7          	jalr	438(ra) # 5c52 <sbrk>
    2aa4:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    2aa6:	757d                	lui	a0,0xfffff
    2aa8:	00003097          	auipc	ra,0x3
    2aac:	1aa080e7          	jalr	426(ra) # 5c52 <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    2ab0:	57fd                	li	a5,-1
    2ab2:	0af50363          	beq	a0,a5,2b58 <sbrkmuch+0x124>
  c = sbrk(0);
    2ab6:	4501                	li	a0,0
    2ab8:	00003097          	auipc	ra,0x3
    2abc:	19a080e7          	jalr	410(ra) # 5c52 <sbrk>
  if(c != a - PGSIZE){
    2ac0:	77fd                	lui	a5,0xfffff
    2ac2:	97a6                	add	a5,a5,s1
    2ac4:	0af51863          	bne	a0,a5,2b74 <sbrkmuch+0x140>
  a = sbrk(0);
    2ac8:	4501                	li	a0,0
    2aca:	00003097          	auipc	ra,0x3
    2ace:	188080e7          	jalr	392(ra) # 5c52 <sbrk>
    2ad2:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    2ad4:	6505                	lui	a0,0x1
    2ad6:	00003097          	auipc	ra,0x3
    2ada:	17c080e7          	jalr	380(ra) # 5c52 <sbrk>
    2ade:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    2ae0:	0aa49a63          	bne	s1,a0,2b94 <sbrkmuch+0x160>
    2ae4:	4501                	li	a0,0
    2ae6:	00003097          	auipc	ra,0x3
    2aea:	16c080e7          	jalr	364(ra) # 5c52 <sbrk>
    2aee:	6785                	lui	a5,0x1
    2af0:	97a6                	add	a5,a5,s1
    2af2:	0af51163          	bne	a0,a5,2b94 <sbrkmuch+0x160>
  if(*lastaddr == 99){
    2af6:	064007b7          	lui	a5,0x6400
    2afa:	fff7c703          	lbu	a4,-1(a5) # 63fffff <base+0x63f0387>
    2afe:	06300793          	li	a5,99
    2b02:	0af70963          	beq	a4,a5,2bb4 <sbrkmuch+0x180>
  a = sbrk(0);
    2b06:	4501                	li	a0,0
    2b08:	00003097          	auipc	ra,0x3
    2b0c:	14a080e7          	jalr	330(ra) # 5c52 <sbrk>
    2b10:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    2b12:	4501                	li	a0,0
    2b14:	00003097          	auipc	ra,0x3
    2b18:	13e080e7          	jalr	318(ra) # 5c52 <sbrk>
    2b1c:	40a9053b          	subw	a0,s2,a0
    2b20:	00003097          	auipc	ra,0x3
    2b24:	132080e7          	jalr	306(ra) # 5c52 <sbrk>
  if(c != a){
    2b28:	0aa49463          	bne	s1,a0,2bd0 <sbrkmuch+0x19c>
}
    2b2c:	70a2                	ld	ra,40(sp)
    2b2e:	7402                	ld	s0,32(sp)
    2b30:	64e2                	ld	s1,24(sp)
    2b32:	6942                	ld	s2,16(sp)
    2b34:	69a2                	ld	s3,8(sp)
    2b36:	6a02                	ld	s4,0(sp)
    2b38:	6145                	add	sp,sp,48
    2b3a:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    2b3c:	85ce                	mv	a1,s3
    2b3e:	00004517          	auipc	a0,0x4
    2b42:	5f250513          	add	a0,a0,1522 # 7130 <updateNode+0xecc>
    2b46:	00003097          	auipc	ra,0x3
    2b4a:	43c080e7          	jalr	1084(ra) # 5f82 <printf>
    exit(1);
    2b4e:	4505                	li	a0,1
    2b50:	00003097          	auipc	ra,0x3
    2b54:	07a080e7          	jalr	122(ra) # 5bca <exit>
    printf("%s: sbrk could not deallocate\n", s);
    2b58:	85ce                	mv	a1,s3
    2b5a:	00004517          	auipc	a0,0x4
    2b5e:	61e50513          	add	a0,a0,1566 # 7178 <updateNode+0xf14>
    2b62:	00003097          	auipc	ra,0x3
    2b66:	420080e7          	jalr	1056(ra) # 5f82 <printf>
    exit(1);
    2b6a:	4505                	li	a0,1
    2b6c:	00003097          	auipc	ra,0x3
    2b70:	05e080e7          	jalr	94(ra) # 5bca <exit>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", s, a, c);
    2b74:	86aa                	mv	a3,a0
    2b76:	8626                	mv	a2,s1
    2b78:	85ce                	mv	a1,s3
    2b7a:	00004517          	auipc	a0,0x4
    2b7e:	61e50513          	add	a0,a0,1566 # 7198 <updateNode+0xf34>
    2b82:	00003097          	auipc	ra,0x3
    2b86:	400080e7          	jalr	1024(ra) # 5f82 <printf>
    exit(1);
    2b8a:	4505                	li	a0,1
    2b8c:	00003097          	auipc	ra,0x3
    2b90:	03e080e7          	jalr	62(ra) # 5bca <exit>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", s, a, c);
    2b94:	86d2                	mv	a3,s4
    2b96:	8626                	mv	a2,s1
    2b98:	85ce                	mv	a1,s3
    2b9a:	00004517          	auipc	a0,0x4
    2b9e:	63e50513          	add	a0,a0,1598 # 71d8 <updateNode+0xf74>
    2ba2:	00003097          	auipc	ra,0x3
    2ba6:	3e0080e7          	jalr	992(ra) # 5f82 <printf>
    exit(1);
    2baa:	4505                	li	a0,1
    2bac:	00003097          	auipc	ra,0x3
    2bb0:	01e080e7          	jalr	30(ra) # 5bca <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    2bb4:	85ce                	mv	a1,s3
    2bb6:	00004517          	auipc	a0,0x4
    2bba:	65250513          	add	a0,a0,1618 # 7208 <updateNode+0xfa4>
    2bbe:	00003097          	auipc	ra,0x3
    2bc2:	3c4080e7          	jalr	964(ra) # 5f82 <printf>
    exit(1);
    2bc6:	4505                	li	a0,1
    2bc8:	00003097          	auipc	ra,0x3
    2bcc:	002080e7          	jalr	2(ra) # 5bca <exit>
    printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
    2bd0:	86aa                	mv	a3,a0
    2bd2:	8626                	mv	a2,s1
    2bd4:	85ce                	mv	a1,s3
    2bd6:	00004517          	auipc	a0,0x4
    2bda:	66a50513          	add	a0,a0,1642 # 7240 <updateNode+0xfdc>
    2bde:	00003097          	auipc	ra,0x3
    2be2:	3a4080e7          	jalr	932(ra) # 5f82 <printf>
    exit(1);
    2be6:	4505                	li	a0,1
    2be8:	00003097          	auipc	ra,0x3
    2bec:	fe2080e7          	jalr	-30(ra) # 5bca <exit>

0000000000002bf0 <sbrkarg>:
{
    2bf0:	7179                	add	sp,sp,-48
    2bf2:	f406                	sd	ra,40(sp)
    2bf4:	f022                	sd	s0,32(sp)
    2bf6:	ec26                	sd	s1,24(sp)
    2bf8:	e84a                	sd	s2,16(sp)
    2bfa:	e44e                	sd	s3,8(sp)
    2bfc:	1800                	add	s0,sp,48
    2bfe:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    2c00:	6505                	lui	a0,0x1
    2c02:	00003097          	auipc	ra,0x3
    2c06:	050080e7          	jalr	80(ra) # 5c52 <sbrk>
    2c0a:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    2c0c:	20100593          	li	a1,513
    2c10:	00004517          	auipc	a0,0x4
    2c14:	65850513          	add	a0,a0,1624 # 7268 <updateNode+0x1004>
    2c18:	00003097          	auipc	ra,0x3
    2c1c:	ff2080e7          	jalr	-14(ra) # 5c0a <open>
    2c20:	84aa                	mv	s1,a0
  unlink("sbrk");
    2c22:	00004517          	auipc	a0,0x4
    2c26:	64650513          	add	a0,a0,1606 # 7268 <updateNode+0x1004>
    2c2a:	00003097          	auipc	ra,0x3
    2c2e:	ff0080e7          	jalr	-16(ra) # 5c1a <unlink>
  if(fd < 0)  {
    2c32:	0404c163          	bltz	s1,2c74 <sbrkarg+0x84>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    2c36:	6605                	lui	a2,0x1
    2c38:	85ca                	mv	a1,s2
    2c3a:	8526                	mv	a0,s1
    2c3c:	00003097          	auipc	ra,0x3
    2c40:	fae080e7          	jalr	-82(ra) # 5bea <write>
    2c44:	04054663          	bltz	a0,2c90 <sbrkarg+0xa0>
  close(fd);
    2c48:	8526                	mv	a0,s1
    2c4a:	00003097          	auipc	ra,0x3
    2c4e:	fa8080e7          	jalr	-88(ra) # 5bf2 <close>
  a = sbrk(PGSIZE);
    2c52:	6505                	lui	a0,0x1
    2c54:	00003097          	auipc	ra,0x3
    2c58:	ffe080e7          	jalr	-2(ra) # 5c52 <sbrk>
  if(pipe((int *) a) != 0){
    2c5c:	00003097          	auipc	ra,0x3
    2c60:	f7e080e7          	jalr	-130(ra) # 5bda <pipe>
    2c64:	e521                	bnez	a0,2cac <sbrkarg+0xbc>
}
    2c66:	70a2                	ld	ra,40(sp)
    2c68:	7402                	ld	s0,32(sp)
    2c6a:	64e2                	ld	s1,24(sp)
    2c6c:	6942                	ld	s2,16(sp)
    2c6e:	69a2                	ld	s3,8(sp)
    2c70:	6145                	add	sp,sp,48
    2c72:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    2c74:	85ce                	mv	a1,s3
    2c76:	00004517          	auipc	a0,0x4
    2c7a:	5fa50513          	add	a0,a0,1530 # 7270 <updateNode+0x100c>
    2c7e:	00003097          	auipc	ra,0x3
    2c82:	304080e7          	jalr	772(ra) # 5f82 <printf>
    exit(1);
    2c86:	4505                	li	a0,1
    2c88:	00003097          	auipc	ra,0x3
    2c8c:	f42080e7          	jalr	-190(ra) # 5bca <exit>
    printf("%s: write sbrk failed\n", s);
    2c90:	85ce                	mv	a1,s3
    2c92:	00004517          	auipc	a0,0x4
    2c96:	5f650513          	add	a0,a0,1526 # 7288 <updateNode+0x1024>
    2c9a:	00003097          	auipc	ra,0x3
    2c9e:	2e8080e7          	jalr	744(ra) # 5f82 <printf>
    exit(1);
    2ca2:	4505                	li	a0,1
    2ca4:	00003097          	auipc	ra,0x3
    2ca8:	f26080e7          	jalr	-218(ra) # 5bca <exit>
    printf("%s: pipe() failed\n", s);
    2cac:	85ce                	mv	a1,s3
    2cae:	00004517          	auipc	a0,0x4
    2cb2:	fba50513          	add	a0,a0,-70 # 6c68 <updateNode+0xa04>
    2cb6:	00003097          	auipc	ra,0x3
    2cba:	2cc080e7          	jalr	716(ra) # 5f82 <printf>
    exit(1);
    2cbe:	4505                	li	a0,1
    2cc0:	00003097          	auipc	ra,0x3
    2cc4:	f0a080e7          	jalr	-246(ra) # 5bca <exit>

0000000000002cc8 <argptest>:
{
    2cc8:	1101                	add	sp,sp,-32
    2cca:	ec06                	sd	ra,24(sp)
    2ccc:	e822                	sd	s0,16(sp)
    2cce:	e426                	sd	s1,8(sp)
    2cd0:	e04a                	sd	s2,0(sp)
    2cd2:	1000                	add	s0,sp,32
    2cd4:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    2cd6:	4581                	li	a1,0
    2cd8:	00004517          	auipc	a0,0x4
    2cdc:	5c850513          	add	a0,a0,1480 # 72a0 <updateNode+0x103c>
    2ce0:	00003097          	auipc	ra,0x3
    2ce4:	f2a080e7          	jalr	-214(ra) # 5c0a <open>
  if (fd < 0) {
    2ce8:	02054b63          	bltz	a0,2d1e <argptest+0x56>
    2cec:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    2cee:	4501                	li	a0,0
    2cf0:	00003097          	auipc	ra,0x3
    2cf4:	f62080e7          	jalr	-158(ra) # 5c52 <sbrk>
    2cf8:	567d                	li	a2,-1
    2cfa:	fff50593          	add	a1,a0,-1
    2cfe:	8526                	mv	a0,s1
    2d00:	00003097          	auipc	ra,0x3
    2d04:	ee2080e7          	jalr	-286(ra) # 5be2 <read>
  close(fd);
    2d08:	8526                	mv	a0,s1
    2d0a:	00003097          	auipc	ra,0x3
    2d0e:	ee8080e7          	jalr	-280(ra) # 5bf2 <close>
}
    2d12:	60e2                	ld	ra,24(sp)
    2d14:	6442                	ld	s0,16(sp)
    2d16:	64a2                	ld	s1,8(sp)
    2d18:	6902                	ld	s2,0(sp)
    2d1a:	6105                	add	sp,sp,32
    2d1c:	8082                	ret
    printf("%s: open failed\n", s);
    2d1e:	85ca                	mv	a1,s2
    2d20:	00004517          	auipc	a0,0x4
    2d24:	e5850513          	add	a0,a0,-424 # 6b78 <updateNode+0x914>
    2d28:	00003097          	auipc	ra,0x3
    2d2c:	25a080e7          	jalr	602(ra) # 5f82 <printf>
    exit(1);
    2d30:	4505                	li	a0,1
    2d32:	00003097          	auipc	ra,0x3
    2d36:	e98080e7          	jalr	-360(ra) # 5bca <exit>

0000000000002d3a <sbrkbugs>:
{
    2d3a:	1141                	add	sp,sp,-16
    2d3c:	e406                	sd	ra,8(sp)
    2d3e:	e022                	sd	s0,0(sp)
    2d40:	0800                	add	s0,sp,16
  int pid = fork();
    2d42:	00003097          	auipc	ra,0x3
    2d46:	e80080e7          	jalr	-384(ra) # 5bc2 <fork>
  if(pid < 0){
    2d4a:	02054263          	bltz	a0,2d6e <sbrkbugs+0x34>
  if(pid == 0){
    2d4e:	ed0d                	bnez	a0,2d88 <sbrkbugs+0x4e>
    int sz = (uint64) sbrk(0);
    2d50:	00003097          	auipc	ra,0x3
    2d54:	f02080e7          	jalr	-254(ra) # 5c52 <sbrk>
    sbrk(-sz);
    2d58:	40a0053b          	negw	a0,a0
    2d5c:	00003097          	auipc	ra,0x3
    2d60:	ef6080e7          	jalr	-266(ra) # 5c52 <sbrk>
    exit(0);
    2d64:	4501                	li	a0,0
    2d66:	00003097          	auipc	ra,0x3
    2d6a:	e64080e7          	jalr	-412(ra) # 5bca <exit>
    printf("fork failed\n");
    2d6e:	00004517          	auipc	a0,0x4
    2d72:	1fa50513          	add	a0,a0,506 # 6f68 <updateNode+0xd04>
    2d76:	00003097          	auipc	ra,0x3
    2d7a:	20c080e7          	jalr	524(ra) # 5f82 <printf>
    exit(1);
    2d7e:	4505                	li	a0,1
    2d80:	00003097          	auipc	ra,0x3
    2d84:	e4a080e7          	jalr	-438(ra) # 5bca <exit>
  wait(0);
    2d88:	4501                	li	a0,0
    2d8a:	00003097          	auipc	ra,0x3
    2d8e:	e48080e7          	jalr	-440(ra) # 5bd2 <wait>
  pid = fork();
    2d92:	00003097          	auipc	ra,0x3
    2d96:	e30080e7          	jalr	-464(ra) # 5bc2 <fork>
  if(pid < 0){
    2d9a:	02054563          	bltz	a0,2dc4 <sbrkbugs+0x8a>
  if(pid == 0){
    2d9e:	e121                	bnez	a0,2dde <sbrkbugs+0xa4>
    int sz = (uint64) sbrk(0);
    2da0:	00003097          	auipc	ra,0x3
    2da4:	eb2080e7          	jalr	-334(ra) # 5c52 <sbrk>
    sbrk(-(sz - 3500));
    2da8:	6785                	lui	a5,0x1
    2daa:	dac7879b          	addw	a5,a5,-596 # dac <unlinkread+0x6e>
    2dae:	40a7853b          	subw	a0,a5,a0
    2db2:	00003097          	auipc	ra,0x3
    2db6:	ea0080e7          	jalr	-352(ra) # 5c52 <sbrk>
    exit(0);
    2dba:	4501                	li	a0,0
    2dbc:	00003097          	auipc	ra,0x3
    2dc0:	e0e080e7          	jalr	-498(ra) # 5bca <exit>
    printf("fork failed\n");
    2dc4:	00004517          	auipc	a0,0x4
    2dc8:	1a450513          	add	a0,a0,420 # 6f68 <updateNode+0xd04>
    2dcc:	00003097          	auipc	ra,0x3
    2dd0:	1b6080e7          	jalr	438(ra) # 5f82 <printf>
    exit(1);
    2dd4:	4505                	li	a0,1
    2dd6:	00003097          	auipc	ra,0x3
    2dda:	df4080e7          	jalr	-524(ra) # 5bca <exit>
  wait(0);
    2dde:	4501                	li	a0,0
    2de0:	00003097          	auipc	ra,0x3
    2de4:	df2080e7          	jalr	-526(ra) # 5bd2 <wait>
  pid = fork();
    2de8:	00003097          	auipc	ra,0x3
    2dec:	dda080e7          	jalr	-550(ra) # 5bc2 <fork>
  if(pid < 0){
    2df0:	02054a63          	bltz	a0,2e24 <sbrkbugs+0xea>
  if(pid == 0){
    2df4:	e529                	bnez	a0,2e3e <sbrkbugs+0x104>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    2df6:	00003097          	auipc	ra,0x3
    2dfa:	e5c080e7          	jalr	-420(ra) # 5c52 <sbrk>
    2dfe:	67ad                	lui	a5,0xb
    2e00:	8007879b          	addw	a5,a5,-2048 # a800 <uninit+0x298>
    2e04:	40a7853b          	subw	a0,a5,a0
    2e08:	00003097          	auipc	ra,0x3
    2e0c:	e4a080e7          	jalr	-438(ra) # 5c52 <sbrk>
    sbrk(-10);
    2e10:	5559                	li	a0,-10
    2e12:	00003097          	auipc	ra,0x3
    2e16:	e40080e7          	jalr	-448(ra) # 5c52 <sbrk>
    exit(0);
    2e1a:	4501                	li	a0,0
    2e1c:	00003097          	auipc	ra,0x3
    2e20:	dae080e7          	jalr	-594(ra) # 5bca <exit>
    printf("fork failed\n");
    2e24:	00004517          	auipc	a0,0x4
    2e28:	14450513          	add	a0,a0,324 # 6f68 <updateNode+0xd04>
    2e2c:	00003097          	auipc	ra,0x3
    2e30:	156080e7          	jalr	342(ra) # 5f82 <printf>
    exit(1);
    2e34:	4505                	li	a0,1
    2e36:	00003097          	auipc	ra,0x3
    2e3a:	d94080e7          	jalr	-620(ra) # 5bca <exit>
  wait(0);
    2e3e:	4501                	li	a0,0
    2e40:	00003097          	auipc	ra,0x3
    2e44:	d92080e7          	jalr	-622(ra) # 5bd2 <wait>
  exit(0);
    2e48:	4501                	li	a0,0
    2e4a:	00003097          	auipc	ra,0x3
    2e4e:	d80080e7          	jalr	-640(ra) # 5bca <exit>

0000000000002e52 <sbrklast>:
{
    2e52:	7179                	add	sp,sp,-48
    2e54:	f406                	sd	ra,40(sp)
    2e56:	f022                	sd	s0,32(sp)
    2e58:	ec26                	sd	s1,24(sp)
    2e5a:	e84a                	sd	s2,16(sp)
    2e5c:	e44e                	sd	s3,8(sp)
    2e5e:	e052                	sd	s4,0(sp)
    2e60:	1800                	add	s0,sp,48
  uint64 top = (uint64) sbrk(0);
    2e62:	4501                	li	a0,0
    2e64:	00003097          	auipc	ra,0x3
    2e68:	dee080e7          	jalr	-530(ra) # 5c52 <sbrk>
  if((top % 4096) != 0)
    2e6c:	03451793          	sll	a5,a0,0x34
    2e70:	ebd9                	bnez	a5,2f06 <sbrklast+0xb4>
  sbrk(4096);
    2e72:	6505                	lui	a0,0x1
    2e74:	00003097          	auipc	ra,0x3
    2e78:	dde080e7          	jalr	-546(ra) # 5c52 <sbrk>
  sbrk(10);
    2e7c:	4529                	li	a0,10
    2e7e:	00003097          	auipc	ra,0x3
    2e82:	dd4080e7          	jalr	-556(ra) # 5c52 <sbrk>
  sbrk(-20);
    2e86:	5531                	li	a0,-20
    2e88:	00003097          	auipc	ra,0x3
    2e8c:	dca080e7          	jalr	-566(ra) # 5c52 <sbrk>
  top = (uint64) sbrk(0);
    2e90:	4501                	li	a0,0
    2e92:	00003097          	auipc	ra,0x3
    2e96:	dc0080e7          	jalr	-576(ra) # 5c52 <sbrk>
    2e9a:	84aa                	mv	s1,a0
  char *p = (char *) (top - 64);
    2e9c:	fc050913          	add	s2,a0,-64 # fc0 <linktest+0xcc>
  p[0] = 'x';
    2ea0:	07800a13          	li	s4,120
    2ea4:	fd450023          	sb	s4,-64(a0)
  p[1] = '\0';
    2ea8:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR|O_CREATE);
    2eac:	20200593          	li	a1,514
    2eb0:	854a                	mv	a0,s2
    2eb2:	00003097          	auipc	ra,0x3
    2eb6:	d58080e7          	jalr	-680(ra) # 5c0a <open>
    2eba:	89aa                	mv	s3,a0
  write(fd, p, 1);
    2ebc:	4605                	li	a2,1
    2ebe:	85ca                	mv	a1,s2
    2ec0:	00003097          	auipc	ra,0x3
    2ec4:	d2a080e7          	jalr	-726(ra) # 5bea <write>
  close(fd);
    2ec8:	854e                	mv	a0,s3
    2eca:	00003097          	auipc	ra,0x3
    2ece:	d28080e7          	jalr	-728(ra) # 5bf2 <close>
  fd = open(p, O_RDWR);
    2ed2:	4589                	li	a1,2
    2ed4:	854a                	mv	a0,s2
    2ed6:	00003097          	auipc	ra,0x3
    2eda:	d34080e7          	jalr	-716(ra) # 5c0a <open>
  p[0] = '\0';
    2ede:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    2ee2:	4605                	li	a2,1
    2ee4:	85ca                	mv	a1,s2
    2ee6:	00003097          	auipc	ra,0x3
    2eea:	cfc080e7          	jalr	-772(ra) # 5be2 <read>
  if(p[0] != 'x')
    2eee:	fc04c783          	lbu	a5,-64(s1)
    2ef2:	03479463          	bne	a5,s4,2f1a <sbrklast+0xc8>
}
    2ef6:	70a2                	ld	ra,40(sp)
    2ef8:	7402                	ld	s0,32(sp)
    2efa:	64e2                	ld	s1,24(sp)
    2efc:	6942                	ld	s2,16(sp)
    2efe:	69a2                	ld	s3,8(sp)
    2f00:	6a02                	ld	s4,0(sp)
    2f02:	6145                	add	sp,sp,48
    2f04:	8082                	ret
    sbrk(4096 - (top % 4096));
    2f06:	0347d513          	srl	a0,a5,0x34
    2f0a:	6785                	lui	a5,0x1
    2f0c:	40a7853b          	subw	a0,a5,a0
    2f10:	00003097          	auipc	ra,0x3
    2f14:	d42080e7          	jalr	-702(ra) # 5c52 <sbrk>
    2f18:	bfa9                	j	2e72 <sbrklast+0x20>
    exit(1);
    2f1a:	4505                	li	a0,1
    2f1c:	00003097          	auipc	ra,0x3
    2f20:	cae080e7          	jalr	-850(ra) # 5bca <exit>

0000000000002f24 <sbrk8000>:
{
    2f24:	1141                	add	sp,sp,-16
    2f26:	e406                	sd	ra,8(sp)
    2f28:	e022                	sd	s0,0(sp)
    2f2a:	0800                	add	s0,sp,16
  sbrk(0x80000004);
    2f2c:	80000537          	lui	a0,0x80000
    2f30:	0511                	add	a0,a0,4 # ffffffff80000004 <base+0xffffffff7fff038c>
    2f32:	00003097          	auipc	ra,0x3
    2f36:	d20080e7          	jalr	-736(ra) # 5c52 <sbrk>
  volatile char *top = sbrk(0);
    2f3a:	4501                	li	a0,0
    2f3c:	00003097          	auipc	ra,0x3
    2f40:	d16080e7          	jalr	-746(ra) # 5c52 <sbrk>
  *(top-1) = *(top-1) + 1;
    2f44:	fff54783          	lbu	a5,-1(a0)
    2f48:	2785                	addw	a5,a5,1 # 1001 <linktest+0x10d>
    2f4a:	0ff7f793          	zext.b	a5,a5
    2f4e:	fef50fa3          	sb	a5,-1(a0)
}
    2f52:	60a2                	ld	ra,8(sp)
    2f54:	6402                	ld	s0,0(sp)
    2f56:	0141                	add	sp,sp,16
    2f58:	8082                	ret

0000000000002f5a <execout>:
{
    2f5a:	715d                	add	sp,sp,-80
    2f5c:	e486                	sd	ra,72(sp)
    2f5e:	e0a2                	sd	s0,64(sp)
    2f60:	fc26                	sd	s1,56(sp)
    2f62:	f84a                	sd	s2,48(sp)
    2f64:	f44e                	sd	s3,40(sp)
    2f66:	f052                	sd	s4,32(sp)
    2f68:	0880                	add	s0,sp,80
  for(int avail = 0; avail < 15; avail++){
    2f6a:	4901                	li	s2,0
    2f6c:	49bd                	li	s3,15
    int pid = fork();
    2f6e:	00003097          	auipc	ra,0x3
    2f72:	c54080e7          	jalr	-940(ra) # 5bc2 <fork>
    2f76:	84aa                	mv	s1,a0
    if(pid < 0){
    2f78:	02054063          	bltz	a0,2f98 <execout+0x3e>
    } else if(pid == 0){
    2f7c:	c91d                	beqz	a0,2fb2 <execout+0x58>
      wait((int*)0);
    2f7e:	4501                	li	a0,0
    2f80:	00003097          	auipc	ra,0x3
    2f84:	c52080e7          	jalr	-942(ra) # 5bd2 <wait>
  for(int avail = 0; avail < 15; avail++){
    2f88:	2905                	addw	s2,s2,1
    2f8a:	ff3912e3          	bne	s2,s3,2f6e <execout+0x14>
  exit(0);
    2f8e:	4501                	li	a0,0
    2f90:	00003097          	auipc	ra,0x3
    2f94:	c3a080e7          	jalr	-966(ra) # 5bca <exit>
      printf("fork failed\n");
    2f98:	00004517          	auipc	a0,0x4
    2f9c:	fd050513          	add	a0,a0,-48 # 6f68 <updateNode+0xd04>
    2fa0:	00003097          	auipc	ra,0x3
    2fa4:	fe2080e7          	jalr	-30(ra) # 5f82 <printf>
      exit(1);
    2fa8:	4505                	li	a0,1
    2faa:	00003097          	auipc	ra,0x3
    2fae:	c20080e7          	jalr	-992(ra) # 5bca <exit>
        if(a == 0xffffffffffffffffLL)
    2fb2:	59fd                	li	s3,-1
        *(char*)(a + 4096 - 1) = 1;
    2fb4:	4a05                	li	s4,1
        uint64 a = (uint64) sbrk(4096);
    2fb6:	6505                	lui	a0,0x1
    2fb8:	00003097          	auipc	ra,0x3
    2fbc:	c9a080e7          	jalr	-870(ra) # 5c52 <sbrk>
        if(a == 0xffffffffffffffffLL)
    2fc0:	01350763          	beq	a0,s3,2fce <execout+0x74>
        *(char*)(a + 4096 - 1) = 1;
    2fc4:	6785                	lui	a5,0x1
    2fc6:	97aa                	add	a5,a5,a0
    2fc8:	ff478fa3          	sb	s4,-1(a5) # fff <linktest+0x10b>
      while(1){
    2fcc:	b7ed                	j	2fb6 <execout+0x5c>
      for(int i = 0; i < avail; i++)
    2fce:	01205a63          	blez	s2,2fe2 <execout+0x88>
        sbrk(-4096);
    2fd2:	757d                	lui	a0,0xfffff
    2fd4:	00003097          	auipc	ra,0x3
    2fd8:	c7e080e7          	jalr	-898(ra) # 5c52 <sbrk>
      for(int i = 0; i < avail; i++)
    2fdc:	2485                	addw	s1,s1,1
    2fde:	ff249ae3          	bne	s1,s2,2fd2 <execout+0x78>
      close(1);
    2fe2:	4505                	li	a0,1
    2fe4:	00003097          	auipc	ra,0x3
    2fe8:	c0e080e7          	jalr	-1010(ra) # 5bf2 <close>
      char *args[] = { "echo", "x", 0 };
    2fec:	00003517          	auipc	a0,0x3
    2ff0:	2ec50513          	add	a0,a0,748 # 62d8 <updateNode+0x74>
    2ff4:	faa43c23          	sd	a0,-72(s0)
    2ff8:	00003797          	auipc	a5,0x3
    2ffc:	35078793          	add	a5,a5,848 # 6348 <updateNode+0xe4>
    3000:	fcf43023          	sd	a5,-64(s0)
    3004:	fc043423          	sd	zero,-56(s0)
      exec("echo", args);
    3008:	fb840593          	add	a1,s0,-72
    300c:	00003097          	auipc	ra,0x3
    3010:	bf6080e7          	jalr	-1034(ra) # 5c02 <exec>
      exit(0);
    3014:	4501                	li	a0,0
    3016:	00003097          	auipc	ra,0x3
    301a:	bb4080e7          	jalr	-1100(ra) # 5bca <exit>

000000000000301e <fourteen>:
{
    301e:	1101                	add	sp,sp,-32
    3020:	ec06                	sd	ra,24(sp)
    3022:	e822                	sd	s0,16(sp)
    3024:	e426                	sd	s1,8(sp)
    3026:	1000                	add	s0,sp,32
    3028:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    302a:	00004517          	auipc	a0,0x4
    302e:	44e50513          	add	a0,a0,1102 # 7478 <updateNode+0x1214>
    3032:	00003097          	auipc	ra,0x3
    3036:	c00080e7          	jalr	-1024(ra) # 5c32 <mkdir>
    303a:	e165                	bnez	a0,311a <fourteen+0xfc>
  if(mkdir("12345678901234/123456789012345") != 0){
    303c:	00004517          	auipc	a0,0x4
    3040:	29450513          	add	a0,a0,660 # 72d0 <updateNode+0x106c>
    3044:	00003097          	auipc	ra,0x3
    3048:	bee080e7          	jalr	-1042(ra) # 5c32 <mkdir>
    304c:	e56d                	bnez	a0,3136 <fourteen+0x118>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    304e:	20000593          	li	a1,512
    3052:	00004517          	auipc	a0,0x4
    3056:	2d650513          	add	a0,a0,726 # 7328 <updateNode+0x10c4>
    305a:	00003097          	auipc	ra,0x3
    305e:	bb0080e7          	jalr	-1104(ra) # 5c0a <open>
  if(fd < 0){
    3062:	0e054863          	bltz	a0,3152 <fourteen+0x134>
  close(fd);
    3066:	00003097          	auipc	ra,0x3
    306a:	b8c080e7          	jalr	-1140(ra) # 5bf2 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    306e:	4581                	li	a1,0
    3070:	00004517          	auipc	a0,0x4
    3074:	33050513          	add	a0,a0,816 # 73a0 <updateNode+0x113c>
    3078:	00003097          	auipc	ra,0x3
    307c:	b92080e7          	jalr	-1134(ra) # 5c0a <open>
  if(fd < 0){
    3080:	0e054763          	bltz	a0,316e <fourteen+0x150>
  close(fd);
    3084:	00003097          	auipc	ra,0x3
    3088:	b6e080e7          	jalr	-1170(ra) # 5bf2 <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    308c:	00004517          	auipc	a0,0x4
    3090:	38450513          	add	a0,a0,900 # 7410 <updateNode+0x11ac>
    3094:	00003097          	auipc	ra,0x3
    3098:	b9e080e7          	jalr	-1122(ra) # 5c32 <mkdir>
    309c:	c57d                	beqz	a0,318a <fourteen+0x16c>
  if(mkdir("123456789012345/12345678901234") == 0){
    309e:	00004517          	auipc	a0,0x4
    30a2:	3ca50513          	add	a0,a0,970 # 7468 <updateNode+0x1204>
    30a6:	00003097          	auipc	ra,0x3
    30aa:	b8c080e7          	jalr	-1140(ra) # 5c32 <mkdir>
    30ae:	cd65                	beqz	a0,31a6 <fourteen+0x188>
  unlink("123456789012345/12345678901234");
    30b0:	00004517          	auipc	a0,0x4
    30b4:	3b850513          	add	a0,a0,952 # 7468 <updateNode+0x1204>
    30b8:	00003097          	auipc	ra,0x3
    30bc:	b62080e7          	jalr	-1182(ra) # 5c1a <unlink>
  unlink("12345678901234/12345678901234");
    30c0:	00004517          	auipc	a0,0x4
    30c4:	35050513          	add	a0,a0,848 # 7410 <updateNode+0x11ac>
    30c8:	00003097          	auipc	ra,0x3
    30cc:	b52080e7          	jalr	-1198(ra) # 5c1a <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    30d0:	00004517          	auipc	a0,0x4
    30d4:	2d050513          	add	a0,a0,720 # 73a0 <updateNode+0x113c>
    30d8:	00003097          	auipc	ra,0x3
    30dc:	b42080e7          	jalr	-1214(ra) # 5c1a <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    30e0:	00004517          	auipc	a0,0x4
    30e4:	24850513          	add	a0,a0,584 # 7328 <updateNode+0x10c4>
    30e8:	00003097          	auipc	ra,0x3
    30ec:	b32080e7          	jalr	-1230(ra) # 5c1a <unlink>
  unlink("12345678901234/123456789012345");
    30f0:	00004517          	auipc	a0,0x4
    30f4:	1e050513          	add	a0,a0,480 # 72d0 <updateNode+0x106c>
    30f8:	00003097          	auipc	ra,0x3
    30fc:	b22080e7          	jalr	-1246(ra) # 5c1a <unlink>
  unlink("12345678901234");
    3100:	00004517          	auipc	a0,0x4
    3104:	37850513          	add	a0,a0,888 # 7478 <updateNode+0x1214>
    3108:	00003097          	auipc	ra,0x3
    310c:	b12080e7          	jalr	-1262(ra) # 5c1a <unlink>
}
    3110:	60e2                	ld	ra,24(sp)
    3112:	6442                	ld	s0,16(sp)
    3114:	64a2                	ld	s1,8(sp)
    3116:	6105                	add	sp,sp,32
    3118:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    311a:	85a6                	mv	a1,s1
    311c:	00004517          	auipc	a0,0x4
    3120:	18c50513          	add	a0,a0,396 # 72a8 <updateNode+0x1044>
    3124:	00003097          	auipc	ra,0x3
    3128:	e5e080e7          	jalr	-418(ra) # 5f82 <printf>
    exit(1);
    312c:	4505                	li	a0,1
    312e:	00003097          	auipc	ra,0x3
    3132:	a9c080e7          	jalr	-1380(ra) # 5bca <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    3136:	85a6                	mv	a1,s1
    3138:	00004517          	auipc	a0,0x4
    313c:	1b850513          	add	a0,a0,440 # 72f0 <updateNode+0x108c>
    3140:	00003097          	auipc	ra,0x3
    3144:	e42080e7          	jalr	-446(ra) # 5f82 <printf>
    exit(1);
    3148:	4505                	li	a0,1
    314a:	00003097          	auipc	ra,0x3
    314e:	a80080e7          	jalr	-1408(ra) # 5bca <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    3152:	85a6                	mv	a1,s1
    3154:	00004517          	auipc	a0,0x4
    3158:	20450513          	add	a0,a0,516 # 7358 <updateNode+0x10f4>
    315c:	00003097          	auipc	ra,0x3
    3160:	e26080e7          	jalr	-474(ra) # 5f82 <printf>
    exit(1);
    3164:	4505                	li	a0,1
    3166:	00003097          	auipc	ra,0x3
    316a:	a64080e7          	jalr	-1436(ra) # 5bca <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    316e:	85a6                	mv	a1,s1
    3170:	00004517          	auipc	a0,0x4
    3174:	26050513          	add	a0,a0,608 # 73d0 <updateNode+0x116c>
    3178:	00003097          	auipc	ra,0x3
    317c:	e0a080e7          	jalr	-502(ra) # 5f82 <printf>
    exit(1);
    3180:	4505                	li	a0,1
    3182:	00003097          	auipc	ra,0x3
    3186:	a48080e7          	jalr	-1464(ra) # 5bca <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    318a:	85a6                	mv	a1,s1
    318c:	00004517          	auipc	a0,0x4
    3190:	2a450513          	add	a0,a0,676 # 7430 <updateNode+0x11cc>
    3194:	00003097          	auipc	ra,0x3
    3198:	dee080e7          	jalr	-530(ra) # 5f82 <printf>
    exit(1);
    319c:	4505                	li	a0,1
    319e:	00003097          	auipc	ra,0x3
    31a2:	a2c080e7          	jalr	-1492(ra) # 5bca <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    31a6:	85a6                	mv	a1,s1
    31a8:	00004517          	auipc	a0,0x4
    31ac:	2e050513          	add	a0,a0,736 # 7488 <updateNode+0x1224>
    31b0:	00003097          	auipc	ra,0x3
    31b4:	dd2080e7          	jalr	-558(ra) # 5f82 <printf>
    exit(1);
    31b8:	4505                	li	a0,1
    31ba:	00003097          	auipc	ra,0x3
    31be:	a10080e7          	jalr	-1520(ra) # 5bca <exit>

00000000000031c2 <diskfull>:
{
    31c2:	b9010113          	add	sp,sp,-1136
    31c6:	46113423          	sd	ra,1128(sp)
    31ca:	46813023          	sd	s0,1120(sp)
    31ce:	44913c23          	sd	s1,1112(sp)
    31d2:	45213823          	sd	s2,1104(sp)
    31d6:	45313423          	sd	s3,1096(sp)
    31da:	45413023          	sd	s4,1088(sp)
    31de:	43513c23          	sd	s5,1080(sp)
    31e2:	43613823          	sd	s6,1072(sp)
    31e6:	43713423          	sd	s7,1064(sp)
    31ea:	43813023          	sd	s8,1056(sp)
    31ee:	47010413          	add	s0,sp,1136
    31f2:	8c2a                	mv	s8,a0
  unlink("diskfulldir");
    31f4:	00004517          	auipc	a0,0x4
    31f8:	2cc50513          	add	a0,a0,716 # 74c0 <updateNode+0x125c>
    31fc:	00003097          	auipc	ra,0x3
    3200:	a1e080e7          	jalr	-1506(ra) # 5c1a <unlink>
  for(fi = 0; done == 0; fi++){
    3204:	4a01                	li	s4,0
    name[0] = 'b';
    3206:	06200b13          	li	s6,98
    name[1] = 'i';
    320a:	06900a93          	li	s5,105
    name[2] = 'g';
    320e:	06700993          	li	s3,103
    3212:	10c00b93          	li	s7,268
    3216:	aabd                	j	3394 <diskfull+0x1d2>
      printf("%s: could not create file %s\n", s, name);
    3218:	b9040613          	add	a2,s0,-1136
    321c:	85e2                	mv	a1,s8
    321e:	00004517          	auipc	a0,0x4
    3222:	2b250513          	add	a0,a0,690 # 74d0 <updateNode+0x126c>
    3226:	00003097          	auipc	ra,0x3
    322a:	d5c080e7          	jalr	-676(ra) # 5f82 <printf>
      break;
    322e:	a821                	j	3246 <diskfull+0x84>
        close(fd);
    3230:	854a                	mv	a0,s2
    3232:	00003097          	auipc	ra,0x3
    3236:	9c0080e7          	jalr	-1600(ra) # 5bf2 <close>
    close(fd);
    323a:	854a                	mv	a0,s2
    323c:	00003097          	auipc	ra,0x3
    3240:	9b6080e7          	jalr	-1610(ra) # 5bf2 <close>
  for(fi = 0; done == 0; fi++){
    3244:	2a05                	addw	s4,s4,1
  for(int i = 0; i < nzz; i++){
    3246:	4481                	li	s1,0
    name[0] = 'z';
    3248:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    324c:	08000993          	li	s3,128
    name[0] = 'z';
    3250:	bb240823          	sb	s2,-1104(s0)
    name[1] = 'z';
    3254:	bb2408a3          	sb	s2,-1103(s0)
    name[2] = '0' + (i / 32);
    3258:	41f4d71b          	sraw	a4,s1,0x1f
    325c:	01b7571b          	srlw	a4,a4,0x1b
    3260:	009707bb          	addw	a5,a4,s1
    3264:	4057d69b          	sraw	a3,a5,0x5
    3268:	0306869b          	addw	a3,a3,48
    326c:	bad40923          	sb	a3,-1102(s0)
    name[3] = '0' + (i % 32);
    3270:	8bfd                	and	a5,a5,31
    3272:	9f99                	subw	a5,a5,a4
    3274:	0307879b          	addw	a5,a5,48
    3278:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    327c:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    3280:	bb040513          	add	a0,s0,-1104
    3284:	00003097          	auipc	ra,0x3
    3288:	996080e7          	jalr	-1642(ra) # 5c1a <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    328c:	60200593          	li	a1,1538
    3290:	bb040513          	add	a0,s0,-1104
    3294:	00003097          	auipc	ra,0x3
    3298:	976080e7          	jalr	-1674(ra) # 5c0a <open>
    if(fd < 0)
    329c:	00054963          	bltz	a0,32ae <diskfull+0xec>
    close(fd);
    32a0:	00003097          	auipc	ra,0x3
    32a4:	952080e7          	jalr	-1710(ra) # 5bf2 <close>
  for(int i = 0; i < nzz; i++){
    32a8:	2485                	addw	s1,s1,1
    32aa:	fb3493e3          	bne	s1,s3,3250 <diskfull+0x8e>
  if(mkdir("diskfulldir") == 0)
    32ae:	00004517          	auipc	a0,0x4
    32b2:	21250513          	add	a0,a0,530 # 74c0 <updateNode+0x125c>
    32b6:	00003097          	auipc	ra,0x3
    32ba:	97c080e7          	jalr	-1668(ra) # 5c32 <mkdir>
    32be:	12050963          	beqz	a0,33f0 <diskfull+0x22e>
  unlink("diskfulldir");
    32c2:	00004517          	auipc	a0,0x4
    32c6:	1fe50513          	add	a0,a0,510 # 74c0 <updateNode+0x125c>
    32ca:	00003097          	auipc	ra,0x3
    32ce:	950080e7          	jalr	-1712(ra) # 5c1a <unlink>
  for(int i = 0; i < nzz; i++){
    32d2:	4481                	li	s1,0
    name[0] = 'z';
    32d4:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    32d8:	08000993          	li	s3,128
    name[0] = 'z';
    32dc:	bb240823          	sb	s2,-1104(s0)
    name[1] = 'z';
    32e0:	bb2408a3          	sb	s2,-1103(s0)
    name[2] = '0' + (i / 32);
    32e4:	41f4d71b          	sraw	a4,s1,0x1f
    32e8:	01b7571b          	srlw	a4,a4,0x1b
    32ec:	009707bb          	addw	a5,a4,s1
    32f0:	4057d69b          	sraw	a3,a5,0x5
    32f4:	0306869b          	addw	a3,a3,48
    32f8:	bad40923          	sb	a3,-1102(s0)
    name[3] = '0' + (i % 32);
    32fc:	8bfd                	and	a5,a5,31
    32fe:	9f99                	subw	a5,a5,a4
    3300:	0307879b          	addw	a5,a5,48
    3304:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    3308:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    330c:	bb040513          	add	a0,s0,-1104
    3310:	00003097          	auipc	ra,0x3
    3314:	90a080e7          	jalr	-1782(ra) # 5c1a <unlink>
  for(int i = 0; i < nzz; i++){
    3318:	2485                	addw	s1,s1,1
    331a:	fd3491e3          	bne	s1,s3,32dc <diskfull+0x11a>
  for(int i = 0; i < fi; i++){
    331e:	03405e63          	blez	s4,335a <diskfull+0x198>
    3322:	4481                	li	s1,0
    name[0] = 'b';
    3324:	06200a93          	li	s5,98
    name[1] = 'i';
    3328:	06900993          	li	s3,105
    name[2] = 'g';
    332c:	06700913          	li	s2,103
    name[0] = 'b';
    3330:	bb540823          	sb	s5,-1104(s0)
    name[1] = 'i';
    3334:	bb3408a3          	sb	s3,-1103(s0)
    name[2] = 'g';
    3338:	bb240923          	sb	s2,-1102(s0)
    name[3] = '0' + i;
    333c:	0304879b          	addw	a5,s1,48
    3340:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    3344:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    3348:	bb040513          	add	a0,s0,-1104
    334c:	00003097          	auipc	ra,0x3
    3350:	8ce080e7          	jalr	-1842(ra) # 5c1a <unlink>
  for(int i = 0; i < fi; i++){
    3354:	2485                	addw	s1,s1,1
    3356:	fd449de3          	bne	s1,s4,3330 <diskfull+0x16e>
}
    335a:	46813083          	ld	ra,1128(sp)
    335e:	46013403          	ld	s0,1120(sp)
    3362:	45813483          	ld	s1,1112(sp)
    3366:	45013903          	ld	s2,1104(sp)
    336a:	44813983          	ld	s3,1096(sp)
    336e:	44013a03          	ld	s4,1088(sp)
    3372:	43813a83          	ld	s5,1080(sp)
    3376:	43013b03          	ld	s6,1072(sp)
    337a:	42813b83          	ld	s7,1064(sp)
    337e:	42013c03          	ld	s8,1056(sp)
    3382:	47010113          	add	sp,sp,1136
    3386:	8082                	ret
    close(fd);
    3388:	854a                	mv	a0,s2
    338a:	00003097          	auipc	ra,0x3
    338e:	868080e7          	jalr	-1944(ra) # 5bf2 <close>
  for(fi = 0; done == 0; fi++){
    3392:	2a05                	addw	s4,s4,1
    name[0] = 'b';
    3394:	b9640823          	sb	s6,-1136(s0)
    name[1] = 'i';
    3398:	b95408a3          	sb	s5,-1135(s0)
    name[2] = 'g';
    339c:	b9340923          	sb	s3,-1134(s0)
    name[3] = '0' + fi;
    33a0:	030a079b          	addw	a5,s4,48
    33a4:	b8f409a3          	sb	a5,-1133(s0)
    name[4] = '\0';
    33a8:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    33ac:	b9040513          	add	a0,s0,-1136
    33b0:	00003097          	auipc	ra,0x3
    33b4:	86a080e7          	jalr	-1942(ra) # 5c1a <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    33b8:	60200593          	li	a1,1538
    33bc:	b9040513          	add	a0,s0,-1136
    33c0:	00003097          	auipc	ra,0x3
    33c4:	84a080e7          	jalr	-1974(ra) # 5c0a <open>
    33c8:	892a                	mv	s2,a0
    if(fd < 0){
    33ca:	e40547e3          	bltz	a0,3218 <diskfull+0x56>
    33ce:	84de                	mv	s1,s7
      if(write(fd, buf, BSIZE) != BSIZE){
    33d0:	40000613          	li	a2,1024
    33d4:	bb040593          	add	a1,s0,-1104
    33d8:	854a                	mv	a0,s2
    33da:	00003097          	auipc	ra,0x3
    33de:	810080e7          	jalr	-2032(ra) # 5bea <write>
    33e2:	40000793          	li	a5,1024
    33e6:	e4f515e3          	bne	a0,a5,3230 <diskfull+0x6e>
    for(int i = 0; i < MAXFILE; i++){
    33ea:	34fd                	addw	s1,s1,-1
    33ec:	f0f5                	bnez	s1,33d0 <diskfull+0x20e>
    33ee:	bf69                	j	3388 <diskfull+0x1c6>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n");
    33f0:	00004517          	auipc	a0,0x4
    33f4:	10050513          	add	a0,a0,256 # 74f0 <updateNode+0x128c>
    33f8:	00003097          	auipc	ra,0x3
    33fc:	b8a080e7          	jalr	-1142(ra) # 5f82 <printf>
    3400:	b5c9                	j	32c2 <diskfull+0x100>

0000000000003402 <iputtest>:
{
    3402:	1101                	add	sp,sp,-32
    3404:	ec06                	sd	ra,24(sp)
    3406:	e822                	sd	s0,16(sp)
    3408:	e426                	sd	s1,8(sp)
    340a:	1000                	add	s0,sp,32
    340c:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    340e:	00004517          	auipc	a0,0x4
    3412:	11250513          	add	a0,a0,274 # 7520 <updateNode+0x12bc>
    3416:	00003097          	auipc	ra,0x3
    341a:	81c080e7          	jalr	-2020(ra) # 5c32 <mkdir>
    341e:	04054563          	bltz	a0,3468 <iputtest+0x66>
  if(chdir("iputdir") < 0){
    3422:	00004517          	auipc	a0,0x4
    3426:	0fe50513          	add	a0,a0,254 # 7520 <updateNode+0x12bc>
    342a:	00003097          	auipc	ra,0x3
    342e:	810080e7          	jalr	-2032(ra) # 5c3a <chdir>
    3432:	04054963          	bltz	a0,3484 <iputtest+0x82>
  if(unlink("../iputdir") < 0){
    3436:	00004517          	auipc	a0,0x4
    343a:	12a50513          	add	a0,a0,298 # 7560 <updateNode+0x12fc>
    343e:	00002097          	auipc	ra,0x2
    3442:	7dc080e7          	jalr	2012(ra) # 5c1a <unlink>
    3446:	04054d63          	bltz	a0,34a0 <iputtest+0x9e>
  if(chdir("/") < 0){
    344a:	00004517          	auipc	a0,0x4
    344e:	14650513          	add	a0,a0,326 # 7590 <updateNode+0x132c>
    3452:	00002097          	auipc	ra,0x2
    3456:	7e8080e7          	jalr	2024(ra) # 5c3a <chdir>
    345a:	06054163          	bltz	a0,34bc <iputtest+0xba>
}
    345e:	60e2                	ld	ra,24(sp)
    3460:	6442                	ld	s0,16(sp)
    3462:	64a2                	ld	s1,8(sp)
    3464:	6105                	add	sp,sp,32
    3466:	8082                	ret
    printf("%s: mkdir failed\n", s);
    3468:	85a6                	mv	a1,s1
    346a:	00004517          	auipc	a0,0x4
    346e:	0be50513          	add	a0,a0,190 # 7528 <updateNode+0x12c4>
    3472:	00003097          	auipc	ra,0x3
    3476:	b10080e7          	jalr	-1264(ra) # 5f82 <printf>
    exit(1);
    347a:	4505                	li	a0,1
    347c:	00002097          	auipc	ra,0x2
    3480:	74e080e7          	jalr	1870(ra) # 5bca <exit>
    printf("%s: chdir iputdir failed\n", s);
    3484:	85a6                	mv	a1,s1
    3486:	00004517          	auipc	a0,0x4
    348a:	0ba50513          	add	a0,a0,186 # 7540 <updateNode+0x12dc>
    348e:	00003097          	auipc	ra,0x3
    3492:	af4080e7          	jalr	-1292(ra) # 5f82 <printf>
    exit(1);
    3496:	4505                	li	a0,1
    3498:	00002097          	auipc	ra,0x2
    349c:	732080e7          	jalr	1842(ra) # 5bca <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    34a0:	85a6                	mv	a1,s1
    34a2:	00004517          	auipc	a0,0x4
    34a6:	0ce50513          	add	a0,a0,206 # 7570 <updateNode+0x130c>
    34aa:	00003097          	auipc	ra,0x3
    34ae:	ad8080e7          	jalr	-1320(ra) # 5f82 <printf>
    exit(1);
    34b2:	4505                	li	a0,1
    34b4:	00002097          	auipc	ra,0x2
    34b8:	716080e7          	jalr	1814(ra) # 5bca <exit>
    printf("%s: chdir / failed\n", s);
    34bc:	85a6                	mv	a1,s1
    34be:	00004517          	auipc	a0,0x4
    34c2:	0da50513          	add	a0,a0,218 # 7598 <updateNode+0x1334>
    34c6:	00003097          	auipc	ra,0x3
    34ca:	abc080e7          	jalr	-1348(ra) # 5f82 <printf>
    exit(1);
    34ce:	4505                	li	a0,1
    34d0:	00002097          	auipc	ra,0x2
    34d4:	6fa080e7          	jalr	1786(ra) # 5bca <exit>

00000000000034d8 <exitiputtest>:
{
    34d8:	7179                	add	sp,sp,-48
    34da:	f406                	sd	ra,40(sp)
    34dc:	f022                	sd	s0,32(sp)
    34de:	ec26                	sd	s1,24(sp)
    34e0:	1800                	add	s0,sp,48
    34e2:	84aa                	mv	s1,a0
  pid = fork();
    34e4:	00002097          	auipc	ra,0x2
    34e8:	6de080e7          	jalr	1758(ra) # 5bc2 <fork>
  if(pid < 0){
    34ec:	04054663          	bltz	a0,3538 <exitiputtest+0x60>
  if(pid == 0){
    34f0:	ed45                	bnez	a0,35a8 <exitiputtest+0xd0>
    if(mkdir("iputdir") < 0){
    34f2:	00004517          	auipc	a0,0x4
    34f6:	02e50513          	add	a0,a0,46 # 7520 <updateNode+0x12bc>
    34fa:	00002097          	auipc	ra,0x2
    34fe:	738080e7          	jalr	1848(ra) # 5c32 <mkdir>
    3502:	04054963          	bltz	a0,3554 <exitiputtest+0x7c>
    if(chdir("iputdir") < 0){
    3506:	00004517          	auipc	a0,0x4
    350a:	01a50513          	add	a0,a0,26 # 7520 <updateNode+0x12bc>
    350e:	00002097          	auipc	ra,0x2
    3512:	72c080e7          	jalr	1836(ra) # 5c3a <chdir>
    3516:	04054d63          	bltz	a0,3570 <exitiputtest+0x98>
    if(unlink("../iputdir") < 0){
    351a:	00004517          	auipc	a0,0x4
    351e:	04650513          	add	a0,a0,70 # 7560 <updateNode+0x12fc>
    3522:	00002097          	auipc	ra,0x2
    3526:	6f8080e7          	jalr	1784(ra) # 5c1a <unlink>
    352a:	06054163          	bltz	a0,358c <exitiputtest+0xb4>
    exit(0);
    352e:	4501                	li	a0,0
    3530:	00002097          	auipc	ra,0x2
    3534:	69a080e7          	jalr	1690(ra) # 5bca <exit>
    printf("%s: fork failed\n", s);
    3538:	85a6                	mv	a1,s1
    353a:	00003517          	auipc	a0,0x3
    353e:	62650513          	add	a0,a0,1574 # 6b60 <updateNode+0x8fc>
    3542:	00003097          	auipc	ra,0x3
    3546:	a40080e7          	jalr	-1472(ra) # 5f82 <printf>
    exit(1);
    354a:	4505                	li	a0,1
    354c:	00002097          	auipc	ra,0x2
    3550:	67e080e7          	jalr	1662(ra) # 5bca <exit>
      printf("%s: mkdir failed\n", s);
    3554:	85a6                	mv	a1,s1
    3556:	00004517          	auipc	a0,0x4
    355a:	fd250513          	add	a0,a0,-46 # 7528 <updateNode+0x12c4>
    355e:	00003097          	auipc	ra,0x3
    3562:	a24080e7          	jalr	-1500(ra) # 5f82 <printf>
      exit(1);
    3566:	4505                	li	a0,1
    3568:	00002097          	auipc	ra,0x2
    356c:	662080e7          	jalr	1634(ra) # 5bca <exit>
      printf("%s: child chdir failed\n", s);
    3570:	85a6                	mv	a1,s1
    3572:	00004517          	auipc	a0,0x4
    3576:	03e50513          	add	a0,a0,62 # 75b0 <updateNode+0x134c>
    357a:	00003097          	auipc	ra,0x3
    357e:	a08080e7          	jalr	-1528(ra) # 5f82 <printf>
      exit(1);
    3582:	4505                	li	a0,1
    3584:	00002097          	auipc	ra,0x2
    3588:	646080e7          	jalr	1606(ra) # 5bca <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    358c:	85a6                	mv	a1,s1
    358e:	00004517          	auipc	a0,0x4
    3592:	fe250513          	add	a0,a0,-30 # 7570 <updateNode+0x130c>
    3596:	00003097          	auipc	ra,0x3
    359a:	9ec080e7          	jalr	-1556(ra) # 5f82 <printf>
      exit(1);
    359e:	4505                	li	a0,1
    35a0:	00002097          	auipc	ra,0x2
    35a4:	62a080e7          	jalr	1578(ra) # 5bca <exit>
  wait(&xstatus);
    35a8:	fdc40513          	add	a0,s0,-36
    35ac:	00002097          	auipc	ra,0x2
    35b0:	626080e7          	jalr	1574(ra) # 5bd2 <wait>
  exit(xstatus);
    35b4:	fdc42503          	lw	a0,-36(s0)
    35b8:	00002097          	auipc	ra,0x2
    35bc:	612080e7          	jalr	1554(ra) # 5bca <exit>

00000000000035c0 <dirtest>:
{
    35c0:	1101                	add	sp,sp,-32
    35c2:	ec06                	sd	ra,24(sp)
    35c4:	e822                	sd	s0,16(sp)
    35c6:	e426                	sd	s1,8(sp)
    35c8:	1000                	add	s0,sp,32
    35ca:	84aa                	mv	s1,a0
  if(mkdir("dir0") < 0){
    35cc:	00004517          	auipc	a0,0x4
    35d0:	ffc50513          	add	a0,a0,-4 # 75c8 <updateNode+0x1364>
    35d4:	00002097          	auipc	ra,0x2
    35d8:	65e080e7          	jalr	1630(ra) # 5c32 <mkdir>
    35dc:	04054563          	bltz	a0,3626 <dirtest+0x66>
  if(chdir("dir0") < 0){
    35e0:	00004517          	auipc	a0,0x4
    35e4:	fe850513          	add	a0,a0,-24 # 75c8 <updateNode+0x1364>
    35e8:	00002097          	auipc	ra,0x2
    35ec:	652080e7          	jalr	1618(ra) # 5c3a <chdir>
    35f0:	04054963          	bltz	a0,3642 <dirtest+0x82>
  if(chdir("..") < 0){
    35f4:	00004517          	auipc	a0,0x4
    35f8:	ff450513          	add	a0,a0,-12 # 75e8 <updateNode+0x1384>
    35fc:	00002097          	auipc	ra,0x2
    3600:	63e080e7          	jalr	1598(ra) # 5c3a <chdir>
    3604:	04054d63          	bltz	a0,365e <dirtest+0x9e>
  if(unlink("dir0") < 0){
    3608:	00004517          	auipc	a0,0x4
    360c:	fc050513          	add	a0,a0,-64 # 75c8 <updateNode+0x1364>
    3610:	00002097          	auipc	ra,0x2
    3614:	60a080e7          	jalr	1546(ra) # 5c1a <unlink>
    3618:	06054163          	bltz	a0,367a <dirtest+0xba>
}
    361c:	60e2                	ld	ra,24(sp)
    361e:	6442                	ld	s0,16(sp)
    3620:	64a2                	ld	s1,8(sp)
    3622:	6105                	add	sp,sp,32
    3624:	8082                	ret
    printf("%s: mkdir failed\n", s);
    3626:	85a6                	mv	a1,s1
    3628:	00004517          	auipc	a0,0x4
    362c:	f0050513          	add	a0,a0,-256 # 7528 <updateNode+0x12c4>
    3630:	00003097          	auipc	ra,0x3
    3634:	952080e7          	jalr	-1710(ra) # 5f82 <printf>
    exit(1);
    3638:	4505                	li	a0,1
    363a:	00002097          	auipc	ra,0x2
    363e:	590080e7          	jalr	1424(ra) # 5bca <exit>
    printf("%s: chdir dir0 failed\n", s);
    3642:	85a6                	mv	a1,s1
    3644:	00004517          	auipc	a0,0x4
    3648:	f8c50513          	add	a0,a0,-116 # 75d0 <updateNode+0x136c>
    364c:	00003097          	auipc	ra,0x3
    3650:	936080e7          	jalr	-1738(ra) # 5f82 <printf>
    exit(1);
    3654:	4505                	li	a0,1
    3656:	00002097          	auipc	ra,0x2
    365a:	574080e7          	jalr	1396(ra) # 5bca <exit>
    printf("%s: chdir .. failed\n", s);
    365e:	85a6                	mv	a1,s1
    3660:	00004517          	auipc	a0,0x4
    3664:	f9050513          	add	a0,a0,-112 # 75f0 <updateNode+0x138c>
    3668:	00003097          	auipc	ra,0x3
    366c:	91a080e7          	jalr	-1766(ra) # 5f82 <printf>
    exit(1);
    3670:	4505                	li	a0,1
    3672:	00002097          	auipc	ra,0x2
    3676:	558080e7          	jalr	1368(ra) # 5bca <exit>
    printf("%s: unlink dir0 failed\n", s);
    367a:	85a6                	mv	a1,s1
    367c:	00004517          	auipc	a0,0x4
    3680:	f8c50513          	add	a0,a0,-116 # 7608 <updateNode+0x13a4>
    3684:	00003097          	auipc	ra,0x3
    3688:	8fe080e7          	jalr	-1794(ra) # 5f82 <printf>
    exit(1);
    368c:	4505                	li	a0,1
    368e:	00002097          	auipc	ra,0x2
    3692:	53c080e7          	jalr	1340(ra) # 5bca <exit>

0000000000003696 <subdir>:
{
    3696:	1101                	add	sp,sp,-32
    3698:	ec06                	sd	ra,24(sp)
    369a:	e822                	sd	s0,16(sp)
    369c:	e426                	sd	s1,8(sp)
    369e:	e04a                	sd	s2,0(sp)
    36a0:	1000                	add	s0,sp,32
    36a2:	892a                	mv	s2,a0
  unlink("ff");
    36a4:	00004517          	auipc	a0,0x4
    36a8:	0ac50513          	add	a0,a0,172 # 7750 <updateNode+0x14ec>
    36ac:	00002097          	auipc	ra,0x2
    36b0:	56e080e7          	jalr	1390(ra) # 5c1a <unlink>
  if(mkdir("dd") != 0){
    36b4:	00004517          	auipc	a0,0x4
    36b8:	f6c50513          	add	a0,a0,-148 # 7620 <updateNode+0x13bc>
    36bc:	00002097          	auipc	ra,0x2
    36c0:	576080e7          	jalr	1398(ra) # 5c32 <mkdir>
    36c4:	38051663          	bnez	a0,3a50 <subdir+0x3ba>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    36c8:	20200593          	li	a1,514
    36cc:	00004517          	auipc	a0,0x4
    36d0:	f7450513          	add	a0,a0,-140 # 7640 <updateNode+0x13dc>
    36d4:	00002097          	auipc	ra,0x2
    36d8:	536080e7          	jalr	1334(ra) # 5c0a <open>
    36dc:	84aa                	mv	s1,a0
  if(fd < 0){
    36de:	38054763          	bltz	a0,3a6c <subdir+0x3d6>
  write(fd, "ff", 2);
    36e2:	4609                	li	a2,2
    36e4:	00004597          	auipc	a1,0x4
    36e8:	06c58593          	add	a1,a1,108 # 7750 <updateNode+0x14ec>
    36ec:	00002097          	auipc	ra,0x2
    36f0:	4fe080e7          	jalr	1278(ra) # 5bea <write>
  close(fd);
    36f4:	8526                	mv	a0,s1
    36f6:	00002097          	auipc	ra,0x2
    36fa:	4fc080e7          	jalr	1276(ra) # 5bf2 <close>
  if(unlink("dd") >= 0){
    36fe:	00004517          	auipc	a0,0x4
    3702:	f2250513          	add	a0,a0,-222 # 7620 <updateNode+0x13bc>
    3706:	00002097          	auipc	ra,0x2
    370a:	514080e7          	jalr	1300(ra) # 5c1a <unlink>
    370e:	36055d63          	bgez	a0,3a88 <subdir+0x3f2>
  if(mkdir("/dd/dd") != 0){
    3712:	00004517          	auipc	a0,0x4
    3716:	f8650513          	add	a0,a0,-122 # 7698 <updateNode+0x1434>
    371a:	00002097          	auipc	ra,0x2
    371e:	518080e7          	jalr	1304(ra) # 5c32 <mkdir>
    3722:	38051163          	bnez	a0,3aa4 <subdir+0x40e>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    3726:	20200593          	li	a1,514
    372a:	00004517          	auipc	a0,0x4
    372e:	f9650513          	add	a0,a0,-106 # 76c0 <updateNode+0x145c>
    3732:	00002097          	auipc	ra,0x2
    3736:	4d8080e7          	jalr	1240(ra) # 5c0a <open>
    373a:	84aa                	mv	s1,a0
  if(fd < 0){
    373c:	38054263          	bltz	a0,3ac0 <subdir+0x42a>
  write(fd, "FF", 2);
    3740:	4609                	li	a2,2
    3742:	00004597          	auipc	a1,0x4
    3746:	fae58593          	add	a1,a1,-82 # 76f0 <updateNode+0x148c>
    374a:	00002097          	auipc	ra,0x2
    374e:	4a0080e7          	jalr	1184(ra) # 5bea <write>
  close(fd);
    3752:	8526                	mv	a0,s1
    3754:	00002097          	auipc	ra,0x2
    3758:	49e080e7          	jalr	1182(ra) # 5bf2 <close>
  fd = open("dd/dd/../ff", 0);
    375c:	4581                	li	a1,0
    375e:	00004517          	auipc	a0,0x4
    3762:	f9a50513          	add	a0,a0,-102 # 76f8 <updateNode+0x1494>
    3766:	00002097          	auipc	ra,0x2
    376a:	4a4080e7          	jalr	1188(ra) # 5c0a <open>
    376e:	84aa                	mv	s1,a0
  if(fd < 0){
    3770:	36054663          	bltz	a0,3adc <subdir+0x446>
  cc = read(fd, buf, sizeof(buf));
    3774:	660d                	lui	a2,0x3
    3776:	00009597          	auipc	a1,0x9
    377a:	50258593          	add	a1,a1,1282 # cc78 <buf>
    377e:	00002097          	auipc	ra,0x2
    3782:	464080e7          	jalr	1124(ra) # 5be2 <read>
  if(cc != 2 || buf[0] != 'f'){
    3786:	4789                	li	a5,2
    3788:	36f51863          	bne	a0,a5,3af8 <subdir+0x462>
    378c:	00009717          	auipc	a4,0x9
    3790:	4ec74703          	lbu	a4,1260(a4) # cc78 <buf>
    3794:	06600793          	li	a5,102
    3798:	36f71063          	bne	a4,a5,3af8 <subdir+0x462>
  close(fd);
    379c:	8526                	mv	a0,s1
    379e:	00002097          	auipc	ra,0x2
    37a2:	454080e7          	jalr	1108(ra) # 5bf2 <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    37a6:	00004597          	auipc	a1,0x4
    37aa:	fa258593          	add	a1,a1,-94 # 7748 <updateNode+0x14e4>
    37ae:	00004517          	auipc	a0,0x4
    37b2:	f1250513          	add	a0,a0,-238 # 76c0 <updateNode+0x145c>
    37b6:	00002097          	auipc	ra,0x2
    37ba:	474080e7          	jalr	1140(ra) # 5c2a <link>
    37be:	34051b63          	bnez	a0,3b14 <subdir+0x47e>
  if(unlink("dd/dd/ff") != 0){
    37c2:	00004517          	auipc	a0,0x4
    37c6:	efe50513          	add	a0,a0,-258 # 76c0 <updateNode+0x145c>
    37ca:	00002097          	auipc	ra,0x2
    37ce:	450080e7          	jalr	1104(ra) # 5c1a <unlink>
    37d2:	34051f63          	bnez	a0,3b30 <subdir+0x49a>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    37d6:	4581                	li	a1,0
    37d8:	00004517          	auipc	a0,0x4
    37dc:	ee850513          	add	a0,a0,-280 # 76c0 <updateNode+0x145c>
    37e0:	00002097          	auipc	ra,0x2
    37e4:	42a080e7          	jalr	1066(ra) # 5c0a <open>
    37e8:	36055263          	bgez	a0,3b4c <subdir+0x4b6>
  if(chdir("dd") != 0){
    37ec:	00004517          	auipc	a0,0x4
    37f0:	e3450513          	add	a0,a0,-460 # 7620 <updateNode+0x13bc>
    37f4:	00002097          	auipc	ra,0x2
    37f8:	446080e7          	jalr	1094(ra) # 5c3a <chdir>
    37fc:	36051663          	bnez	a0,3b68 <subdir+0x4d2>
  if(chdir("dd/../../dd") != 0){
    3800:	00004517          	auipc	a0,0x4
    3804:	fe050513          	add	a0,a0,-32 # 77e0 <updateNode+0x157c>
    3808:	00002097          	auipc	ra,0x2
    380c:	432080e7          	jalr	1074(ra) # 5c3a <chdir>
    3810:	36051a63          	bnez	a0,3b84 <subdir+0x4ee>
  if(chdir("dd/../../../dd") != 0){
    3814:	00004517          	auipc	a0,0x4
    3818:	ffc50513          	add	a0,a0,-4 # 7810 <updateNode+0x15ac>
    381c:	00002097          	auipc	ra,0x2
    3820:	41e080e7          	jalr	1054(ra) # 5c3a <chdir>
    3824:	36051e63          	bnez	a0,3ba0 <subdir+0x50a>
  if(chdir("./..") != 0){
    3828:	00004517          	auipc	a0,0x4
    382c:	01850513          	add	a0,a0,24 # 7840 <updateNode+0x15dc>
    3830:	00002097          	auipc	ra,0x2
    3834:	40a080e7          	jalr	1034(ra) # 5c3a <chdir>
    3838:	38051263          	bnez	a0,3bbc <subdir+0x526>
  fd = open("dd/dd/ffff", 0);
    383c:	4581                	li	a1,0
    383e:	00004517          	auipc	a0,0x4
    3842:	f0a50513          	add	a0,a0,-246 # 7748 <updateNode+0x14e4>
    3846:	00002097          	auipc	ra,0x2
    384a:	3c4080e7          	jalr	964(ra) # 5c0a <open>
    384e:	84aa                	mv	s1,a0
  if(fd < 0){
    3850:	38054463          	bltz	a0,3bd8 <subdir+0x542>
  if(read(fd, buf, sizeof(buf)) != 2){
    3854:	660d                	lui	a2,0x3
    3856:	00009597          	auipc	a1,0x9
    385a:	42258593          	add	a1,a1,1058 # cc78 <buf>
    385e:	00002097          	auipc	ra,0x2
    3862:	384080e7          	jalr	900(ra) # 5be2 <read>
    3866:	4789                	li	a5,2
    3868:	38f51663          	bne	a0,a5,3bf4 <subdir+0x55e>
  close(fd);
    386c:	8526                	mv	a0,s1
    386e:	00002097          	auipc	ra,0x2
    3872:	384080e7          	jalr	900(ra) # 5bf2 <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    3876:	4581                	li	a1,0
    3878:	00004517          	auipc	a0,0x4
    387c:	e4850513          	add	a0,a0,-440 # 76c0 <updateNode+0x145c>
    3880:	00002097          	auipc	ra,0x2
    3884:	38a080e7          	jalr	906(ra) # 5c0a <open>
    3888:	38055463          	bgez	a0,3c10 <subdir+0x57a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    388c:	20200593          	li	a1,514
    3890:	00004517          	auipc	a0,0x4
    3894:	04050513          	add	a0,a0,64 # 78d0 <updateNode+0x166c>
    3898:	00002097          	auipc	ra,0x2
    389c:	372080e7          	jalr	882(ra) # 5c0a <open>
    38a0:	38055663          	bgez	a0,3c2c <subdir+0x596>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    38a4:	20200593          	li	a1,514
    38a8:	00004517          	auipc	a0,0x4
    38ac:	05850513          	add	a0,a0,88 # 7900 <updateNode+0x169c>
    38b0:	00002097          	auipc	ra,0x2
    38b4:	35a080e7          	jalr	858(ra) # 5c0a <open>
    38b8:	38055863          	bgez	a0,3c48 <subdir+0x5b2>
  if(open("dd", O_CREATE) >= 0){
    38bc:	20000593          	li	a1,512
    38c0:	00004517          	auipc	a0,0x4
    38c4:	d6050513          	add	a0,a0,-672 # 7620 <updateNode+0x13bc>
    38c8:	00002097          	auipc	ra,0x2
    38cc:	342080e7          	jalr	834(ra) # 5c0a <open>
    38d0:	38055a63          	bgez	a0,3c64 <subdir+0x5ce>
  if(open("dd", O_RDWR) >= 0){
    38d4:	4589                	li	a1,2
    38d6:	00004517          	auipc	a0,0x4
    38da:	d4a50513          	add	a0,a0,-694 # 7620 <updateNode+0x13bc>
    38de:	00002097          	auipc	ra,0x2
    38e2:	32c080e7          	jalr	812(ra) # 5c0a <open>
    38e6:	38055d63          	bgez	a0,3c80 <subdir+0x5ea>
  if(open("dd", O_WRONLY) >= 0){
    38ea:	4585                	li	a1,1
    38ec:	00004517          	auipc	a0,0x4
    38f0:	d3450513          	add	a0,a0,-716 # 7620 <updateNode+0x13bc>
    38f4:	00002097          	auipc	ra,0x2
    38f8:	316080e7          	jalr	790(ra) # 5c0a <open>
    38fc:	3a055063          	bgez	a0,3c9c <subdir+0x606>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    3900:	00004597          	auipc	a1,0x4
    3904:	09058593          	add	a1,a1,144 # 7990 <updateNode+0x172c>
    3908:	00004517          	auipc	a0,0x4
    390c:	fc850513          	add	a0,a0,-56 # 78d0 <updateNode+0x166c>
    3910:	00002097          	auipc	ra,0x2
    3914:	31a080e7          	jalr	794(ra) # 5c2a <link>
    3918:	3a050063          	beqz	a0,3cb8 <subdir+0x622>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    391c:	00004597          	auipc	a1,0x4
    3920:	07458593          	add	a1,a1,116 # 7990 <updateNode+0x172c>
    3924:	00004517          	auipc	a0,0x4
    3928:	fdc50513          	add	a0,a0,-36 # 7900 <updateNode+0x169c>
    392c:	00002097          	auipc	ra,0x2
    3930:	2fe080e7          	jalr	766(ra) # 5c2a <link>
    3934:	3a050063          	beqz	a0,3cd4 <subdir+0x63e>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    3938:	00004597          	auipc	a1,0x4
    393c:	e1058593          	add	a1,a1,-496 # 7748 <updateNode+0x14e4>
    3940:	00004517          	auipc	a0,0x4
    3944:	d0050513          	add	a0,a0,-768 # 7640 <updateNode+0x13dc>
    3948:	00002097          	auipc	ra,0x2
    394c:	2e2080e7          	jalr	738(ra) # 5c2a <link>
    3950:	3a050063          	beqz	a0,3cf0 <subdir+0x65a>
  if(mkdir("dd/ff/ff") == 0){
    3954:	00004517          	auipc	a0,0x4
    3958:	f7c50513          	add	a0,a0,-132 # 78d0 <updateNode+0x166c>
    395c:	00002097          	auipc	ra,0x2
    3960:	2d6080e7          	jalr	726(ra) # 5c32 <mkdir>
    3964:	3a050463          	beqz	a0,3d0c <subdir+0x676>
  if(mkdir("dd/xx/ff") == 0){
    3968:	00004517          	auipc	a0,0x4
    396c:	f9850513          	add	a0,a0,-104 # 7900 <updateNode+0x169c>
    3970:	00002097          	auipc	ra,0x2
    3974:	2c2080e7          	jalr	706(ra) # 5c32 <mkdir>
    3978:	3a050863          	beqz	a0,3d28 <subdir+0x692>
  if(mkdir("dd/dd/ffff") == 0){
    397c:	00004517          	auipc	a0,0x4
    3980:	dcc50513          	add	a0,a0,-564 # 7748 <updateNode+0x14e4>
    3984:	00002097          	auipc	ra,0x2
    3988:	2ae080e7          	jalr	686(ra) # 5c32 <mkdir>
    398c:	3a050c63          	beqz	a0,3d44 <subdir+0x6ae>
  if(unlink("dd/xx/ff") == 0){
    3990:	00004517          	auipc	a0,0x4
    3994:	f7050513          	add	a0,a0,-144 # 7900 <updateNode+0x169c>
    3998:	00002097          	auipc	ra,0x2
    399c:	282080e7          	jalr	642(ra) # 5c1a <unlink>
    39a0:	3c050063          	beqz	a0,3d60 <subdir+0x6ca>
  if(unlink("dd/ff/ff") == 0){
    39a4:	00004517          	auipc	a0,0x4
    39a8:	f2c50513          	add	a0,a0,-212 # 78d0 <updateNode+0x166c>
    39ac:	00002097          	auipc	ra,0x2
    39b0:	26e080e7          	jalr	622(ra) # 5c1a <unlink>
    39b4:	3c050463          	beqz	a0,3d7c <subdir+0x6e6>
  if(chdir("dd/ff") == 0){
    39b8:	00004517          	auipc	a0,0x4
    39bc:	c8850513          	add	a0,a0,-888 # 7640 <updateNode+0x13dc>
    39c0:	00002097          	auipc	ra,0x2
    39c4:	27a080e7          	jalr	634(ra) # 5c3a <chdir>
    39c8:	3c050863          	beqz	a0,3d98 <subdir+0x702>
  if(chdir("dd/xx") == 0){
    39cc:	00004517          	auipc	a0,0x4
    39d0:	11450513          	add	a0,a0,276 # 7ae0 <updateNode+0x187c>
    39d4:	00002097          	auipc	ra,0x2
    39d8:	266080e7          	jalr	614(ra) # 5c3a <chdir>
    39dc:	3c050c63          	beqz	a0,3db4 <subdir+0x71e>
  if(unlink("dd/dd/ffff") != 0){
    39e0:	00004517          	auipc	a0,0x4
    39e4:	d6850513          	add	a0,a0,-664 # 7748 <updateNode+0x14e4>
    39e8:	00002097          	auipc	ra,0x2
    39ec:	232080e7          	jalr	562(ra) # 5c1a <unlink>
    39f0:	3e051063          	bnez	a0,3dd0 <subdir+0x73a>
  if(unlink("dd/ff") != 0){
    39f4:	00004517          	auipc	a0,0x4
    39f8:	c4c50513          	add	a0,a0,-948 # 7640 <updateNode+0x13dc>
    39fc:	00002097          	auipc	ra,0x2
    3a00:	21e080e7          	jalr	542(ra) # 5c1a <unlink>
    3a04:	3e051463          	bnez	a0,3dec <subdir+0x756>
  if(unlink("dd") == 0){
    3a08:	00004517          	auipc	a0,0x4
    3a0c:	c1850513          	add	a0,a0,-1000 # 7620 <updateNode+0x13bc>
    3a10:	00002097          	auipc	ra,0x2
    3a14:	20a080e7          	jalr	522(ra) # 5c1a <unlink>
    3a18:	3e050863          	beqz	a0,3e08 <subdir+0x772>
  if(unlink("dd/dd") < 0){
    3a1c:	00004517          	auipc	a0,0x4
    3a20:	13450513          	add	a0,a0,308 # 7b50 <updateNode+0x18ec>
    3a24:	00002097          	auipc	ra,0x2
    3a28:	1f6080e7          	jalr	502(ra) # 5c1a <unlink>
    3a2c:	3e054c63          	bltz	a0,3e24 <subdir+0x78e>
  if(unlink("dd") < 0){
    3a30:	00004517          	auipc	a0,0x4
    3a34:	bf050513          	add	a0,a0,-1040 # 7620 <updateNode+0x13bc>
    3a38:	00002097          	auipc	ra,0x2
    3a3c:	1e2080e7          	jalr	482(ra) # 5c1a <unlink>
    3a40:	40054063          	bltz	a0,3e40 <subdir+0x7aa>
}
    3a44:	60e2                	ld	ra,24(sp)
    3a46:	6442                	ld	s0,16(sp)
    3a48:	64a2                	ld	s1,8(sp)
    3a4a:	6902                	ld	s2,0(sp)
    3a4c:	6105                	add	sp,sp,32
    3a4e:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    3a50:	85ca                	mv	a1,s2
    3a52:	00004517          	auipc	a0,0x4
    3a56:	bd650513          	add	a0,a0,-1066 # 7628 <updateNode+0x13c4>
    3a5a:	00002097          	auipc	ra,0x2
    3a5e:	528080e7          	jalr	1320(ra) # 5f82 <printf>
    exit(1);
    3a62:	4505                	li	a0,1
    3a64:	00002097          	auipc	ra,0x2
    3a68:	166080e7          	jalr	358(ra) # 5bca <exit>
    printf("%s: create dd/ff failed\n", s);
    3a6c:	85ca                	mv	a1,s2
    3a6e:	00004517          	auipc	a0,0x4
    3a72:	bda50513          	add	a0,a0,-1062 # 7648 <updateNode+0x13e4>
    3a76:	00002097          	auipc	ra,0x2
    3a7a:	50c080e7          	jalr	1292(ra) # 5f82 <printf>
    exit(1);
    3a7e:	4505                	li	a0,1
    3a80:	00002097          	auipc	ra,0x2
    3a84:	14a080e7          	jalr	330(ra) # 5bca <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    3a88:	85ca                	mv	a1,s2
    3a8a:	00004517          	auipc	a0,0x4
    3a8e:	bde50513          	add	a0,a0,-1058 # 7668 <updateNode+0x1404>
    3a92:	00002097          	auipc	ra,0x2
    3a96:	4f0080e7          	jalr	1264(ra) # 5f82 <printf>
    exit(1);
    3a9a:	4505                	li	a0,1
    3a9c:	00002097          	auipc	ra,0x2
    3aa0:	12e080e7          	jalr	302(ra) # 5bca <exit>
    printf("subdir mkdir dd/dd failed\n", s);
    3aa4:	85ca                	mv	a1,s2
    3aa6:	00004517          	auipc	a0,0x4
    3aaa:	bfa50513          	add	a0,a0,-1030 # 76a0 <updateNode+0x143c>
    3aae:	00002097          	auipc	ra,0x2
    3ab2:	4d4080e7          	jalr	1236(ra) # 5f82 <printf>
    exit(1);
    3ab6:	4505                	li	a0,1
    3ab8:	00002097          	auipc	ra,0x2
    3abc:	112080e7          	jalr	274(ra) # 5bca <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    3ac0:	85ca                	mv	a1,s2
    3ac2:	00004517          	auipc	a0,0x4
    3ac6:	c0e50513          	add	a0,a0,-1010 # 76d0 <updateNode+0x146c>
    3aca:	00002097          	auipc	ra,0x2
    3ace:	4b8080e7          	jalr	1208(ra) # 5f82 <printf>
    exit(1);
    3ad2:	4505                	li	a0,1
    3ad4:	00002097          	auipc	ra,0x2
    3ad8:	0f6080e7          	jalr	246(ra) # 5bca <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    3adc:	85ca                	mv	a1,s2
    3ade:	00004517          	auipc	a0,0x4
    3ae2:	c2a50513          	add	a0,a0,-982 # 7708 <updateNode+0x14a4>
    3ae6:	00002097          	auipc	ra,0x2
    3aea:	49c080e7          	jalr	1180(ra) # 5f82 <printf>
    exit(1);
    3aee:	4505                	li	a0,1
    3af0:	00002097          	auipc	ra,0x2
    3af4:	0da080e7          	jalr	218(ra) # 5bca <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    3af8:	85ca                	mv	a1,s2
    3afa:	00004517          	auipc	a0,0x4
    3afe:	c2e50513          	add	a0,a0,-978 # 7728 <updateNode+0x14c4>
    3b02:	00002097          	auipc	ra,0x2
    3b06:	480080e7          	jalr	1152(ra) # 5f82 <printf>
    exit(1);
    3b0a:	4505                	li	a0,1
    3b0c:	00002097          	auipc	ra,0x2
    3b10:	0be080e7          	jalr	190(ra) # 5bca <exit>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    3b14:	85ca                	mv	a1,s2
    3b16:	00004517          	auipc	a0,0x4
    3b1a:	c4250513          	add	a0,a0,-958 # 7758 <updateNode+0x14f4>
    3b1e:	00002097          	auipc	ra,0x2
    3b22:	464080e7          	jalr	1124(ra) # 5f82 <printf>
    exit(1);
    3b26:	4505                	li	a0,1
    3b28:	00002097          	auipc	ra,0x2
    3b2c:	0a2080e7          	jalr	162(ra) # 5bca <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3b30:	85ca                	mv	a1,s2
    3b32:	00004517          	auipc	a0,0x4
    3b36:	c4e50513          	add	a0,a0,-946 # 7780 <updateNode+0x151c>
    3b3a:	00002097          	auipc	ra,0x2
    3b3e:	448080e7          	jalr	1096(ra) # 5f82 <printf>
    exit(1);
    3b42:	4505                	li	a0,1
    3b44:	00002097          	auipc	ra,0x2
    3b48:	086080e7          	jalr	134(ra) # 5bca <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    3b4c:	85ca                	mv	a1,s2
    3b4e:	00004517          	auipc	a0,0x4
    3b52:	c5250513          	add	a0,a0,-942 # 77a0 <updateNode+0x153c>
    3b56:	00002097          	auipc	ra,0x2
    3b5a:	42c080e7          	jalr	1068(ra) # 5f82 <printf>
    exit(1);
    3b5e:	4505                	li	a0,1
    3b60:	00002097          	auipc	ra,0x2
    3b64:	06a080e7          	jalr	106(ra) # 5bca <exit>
    printf("%s: chdir dd failed\n", s);
    3b68:	85ca                	mv	a1,s2
    3b6a:	00004517          	auipc	a0,0x4
    3b6e:	c5e50513          	add	a0,a0,-930 # 77c8 <updateNode+0x1564>
    3b72:	00002097          	auipc	ra,0x2
    3b76:	410080e7          	jalr	1040(ra) # 5f82 <printf>
    exit(1);
    3b7a:	4505                	li	a0,1
    3b7c:	00002097          	auipc	ra,0x2
    3b80:	04e080e7          	jalr	78(ra) # 5bca <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    3b84:	85ca                	mv	a1,s2
    3b86:	00004517          	auipc	a0,0x4
    3b8a:	c6a50513          	add	a0,a0,-918 # 77f0 <updateNode+0x158c>
    3b8e:	00002097          	auipc	ra,0x2
    3b92:	3f4080e7          	jalr	1012(ra) # 5f82 <printf>
    exit(1);
    3b96:	4505                	li	a0,1
    3b98:	00002097          	auipc	ra,0x2
    3b9c:	032080e7          	jalr	50(ra) # 5bca <exit>
    printf("chdir dd/../../dd failed\n", s);
    3ba0:	85ca                	mv	a1,s2
    3ba2:	00004517          	auipc	a0,0x4
    3ba6:	c7e50513          	add	a0,a0,-898 # 7820 <updateNode+0x15bc>
    3baa:	00002097          	auipc	ra,0x2
    3bae:	3d8080e7          	jalr	984(ra) # 5f82 <printf>
    exit(1);
    3bb2:	4505                	li	a0,1
    3bb4:	00002097          	auipc	ra,0x2
    3bb8:	016080e7          	jalr	22(ra) # 5bca <exit>
    printf("%s: chdir ./.. failed\n", s);
    3bbc:	85ca                	mv	a1,s2
    3bbe:	00004517          	auipc	a0,0x4
    3bc2:	c8a50513          	add	a0,a0,-886 # 7848 <updateNode+0x15e4>
    3bc6:	00002097          	auipc	ra,0x2
    3bca:	3bc080e7          	jalr	956(ra) # 5f82 <printf>
    exit(1);
    3bce:	4505                	li	a0,1
    3bd0:	00002097          	auipc	ra,0x2
    3bd4:	ffa080e7          	jalr	-6(ra) # 5bca <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    3bd8:	85ca                	mv	a1,s2
    3bda:	00004517          	auipc	a0,0x4
    3bde:	c8650513          	add	a0,a0,-890 # 7860 <updateNode+0x15fc>
    3be2:	00002097          	auipc	ra,0x2
    3be6:	3a0080e7          	jalr	928(ra) # 5f82 <printf>
    exit(1);
    3bea:	4505                	li	a0,1
    3bec:	00002097          	auipc	ra,0x2
    3bf0:	fde080e7          	jalr	-34(ra) # 5bca <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    3bf4:	85ca                	mv	a1,s2
    3bf6:	00004517          	auipc	a0,0x4
    3bfa:	c8a50513          	add	a0,a0,-886 # 7880 <updateNode+0x161c>
    3bfe:	00002097          	auipc	ra,0x2
    3c02:	384080e7          	jalr	900(ra) # 5f82 <printf>
    exit(1);
    3c06:	4505                	li	a0,1
    3c08:	00002097          	auipc	ra,0x2
    3c0c:	fc2080e7          	jalr	-62(ra) # 5bca <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    3c10:	85ca                	mv	a1,s2
    3c12:	00004517          	auipc	a0,0x4
    3c16:	c8e50513          	add	a0,a0,-882 # 78a0 <updateNode+0x163c>
    3c1a:	00002097          	auipc	ra,0x2
    3c1e:	368080e7          	jalr	872(ra) # 5f82 <printf>
    exit(1);
    3c22:	4505                	li	a0,1
    3c24:	00002097          	auipc	ra,0x2
    3c28:	fa6080e7          	jalr	-90(ra) # 5bca <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    3c2c:	85ca                	mv	a1,s2
    3c2e:	00004517          	auipc	a0,0x4
    3c32:	cb250513          	add	a0,a0,-846 # 78e0 <updateNode+0x167c>
    3c36:	00002097          	auipc	ra,0x2
    3c3a:	34c080e7          	jalr	844(ra) # 5f82 <printf>
    exit(1);
    3c3e:	4505                	li	a0,1
    3c40:	00002097          	auipc	ra,0x2
    3c44:	f8a080e7          	jalr	-118(ra) # 5bca <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    3c48:	85ca                	mv	a1,s2
    3c4a:	00004517          	auipc	a0,0x4
    3c4e:	cc650513          	add	a0,a0,-826 # 7910 <updateNode+0x16ac>
    3c52:	00002097          	auipc	ra,0x2
    3c56:	330080e7          	jalr	816(ra) # 5f82 <printf>
    exit(1);
    3c5a:	4505                	li	a0,1
    3c5c:	00002097          	auipc	ra,0x2
    3c60:	f6e080e7          	jalr	-146(ra) # 5bca <exit>
    printf("%s: create dd succeeded!\n", s);
    3c64:	85ca                	mv	a1,s2
    3c66:	00004517          	auipc	a0,0x4
    3c6a:	cca50513          	add	a0,a0,-822 # 7930 <updateNode+0x16cc>
    3c6e:	00002097          	auipc	ra,0x2
    3c72:	314080e7          	jalr	788(ra) # 5f82 <printf>
    exit(1);
    3c76:	4505                	li	a0,1
    3c78:	00002097          	auipc	ra,0x2
    3c7c:	f52080e7          	jalr	-174(ra) # 5bca <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    3c80:	85ca                	mv	a1,s2
    3c82:	00004517          	auipc	a0,0x4
    3c86:	cce50513          	add	a0,a0,-818 # 7950 <updateNode+0x16ec>
    3c8a:	00002097          	auipc	ra,0x2
    3c8e:	2f8080e7          	jalr	760(ra) # 5f82 <printf>
    exit(1);
    3c92:	4505                	li	a0,1
    3c94:	00002097          	auipc	ra,0x2
    3c98:	f36080e7          	jalr	-202(ra) # 5bca <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    3c9c:	85ca                	mv	a1,s2
    3c9e:	00004517          	auipc	a0,0x4
    3ca2:	cd250513          	add	a0,a0,-814 # 7970 <updateNode+0x170c>
    3ca6:	00002097          	auipc	ra,0x2
    3caa:	2dc080e7          	jalr	732(ra) # 5f82 <printf>
    exit(1);
    3cae:	4505                	li	a0,1
    3cb0:	00002097          	auipc	ra,0x2
    3cb4:	f1a080e7          	jalr	-230(ra) # 5bca <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    3cb8:	85ca                	mv	a1,s2
    3cba:	00004517          	auipc	a0,0x4
    3cbe:	ce650513          	add	a0,a0,-794 # 79a0 <updateNode+0x173c>
    3cc2:	00002097          	auipc	ra,0x2
    3cc6:	2c0080e7          	jalr	704(ra) # 5f82 <printf>
    exit(1);
    3cca:	4505                	li	a0,1
    3ccc:	00002097          	auipc	ra,0x2
    3cd0:	efe080e7          	jalr	-258(ra) # 5bca <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    3cd4:	85ca                	mv	a1,s2
    3cd6:	00004517          	auipc	a0,0x4
    3cda:	cf250513          	add	a0,a0,-782 # 79c8 <updateNode+0x1764>
    3cde:	00002097          	auipc	ra,0x2
    3ce2:	2a4080e7          	jalr	676(ra) # 5f82 <printf>
    exit(1);
    3ce6:	4505                	li	a0,1
    3ce8:	00002097          	auipc	ra,0x2
    3cec:	ee2080e7          	jalr	-286(ra) # 5bca <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    3cf0:	85ca                	mv	a1,s2
    3cf2:	00004517          	auipc	a0,0x4
    3cf6:	cfe50513          	add	a0,a0,-770 # 79f0 <updateNode+0x178c>
    3cfa:	00002097          	auipc	ra,0x2
    3cfe:	288080e7          	jalr	648(ra) # 5f82 <printf>
    exit(1);
    3d02:	4505                	li	a0,1
    3d04:	00002097          	auipc	ra,0x2
    3d08:	ec6080e7          	jalr	-314(ra) # 5bca <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    3d0c:	85ca                	mv	a1,s2
    3d0e:	00004517          	auipc	a0,0x4
    3d12:	d0a50513          	add	a0,a0,-758 # 7a18 <updateNode+0x17b4>
    3d16:	00002097          	auipc	ra,0x2
    3d1a:	26c080e7          	jalr	620(ra) # 5f82 <printf>
    exit(1);
    3d1e:	4505                	li	a0,1
    3d20:	00002097          	auipc	ra,0x2
    3d24:	eaa080e7          	jalr	-342(ra) # 5bca <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    3d28:	85ca                	mv	a1,s2
    3d2a:	00004517          	auipc	a0,0x4
    3d2e:	d0e50513          	add	a0,a0,-754 # 7a38 <updateNode+0x17d4>
    3d32:	00002097          	auipc	ra,0x2
    3d36:	250080e7          	jalr	592(ra) # 5f82 <printf>
    exit(1);
    3d3a:	4505                	li	a0,1
    3d3c:	00002097          	auipc	ra,0x2
    3d40:	e8e080e7          	jalr	-370(ra) # 5bca <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    3d44:	85ca                	mv	a1,s2
    3d46:	00004517          	auipc	a0,0x4
    3d4a:	d1250513          	add	a0,a0,-750 # 7a58 <updateNode+0x17f4>
    3d4e:	00002097          	auipc	ra,0x2
    3d52:	234080e7          	jalr	564(ra) # 5f82 <printf>
    exit(1);
    3d56:	4505                	li	a0,1
    3d58:	00002097          	auipc	ra,0x2
    3d5c:	e72080e7          	jalr	-398(ra) # 5bca <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    3d60:	85ca                	mv	a1,s2
    3d62:	00004517          	auipc	a0,0x4
    3d66:	d1e50513          	add	a0,a0,-738 # 7a80 <updateNode+0x181c>
    3d6a:	00002097          	auipc	ra,0x2
    3d6e:	218080e7          	jalr	536(ra) # 5f82 <printf>
    exit(1);
    3d72:	4505                	li	a0,1
    3d74:	00002097          	auipc	ra,0x2
    3d78:	e56080e7          	jalr	-426(ra) # 5bca <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    3d7c:	85ca                	mv	a1,s2
    3d7e:	00004517          	auipc	a0,0x4
    3d82:	d2250513          	add	a0,a0,-734 # 7aa0 <updateNode+0x183c>
    3d86:	00002097          	auipc	ra,0x2
    3d8a:	1fc080e7          	jalr	508(ra) # 5f82 <printf>
    exit(1);
    3d8e:	4505                	li	a0,1
    3d90:	00002097          	auipc	ra,0x2
    3d94:	e3a080e7          	jalr	-454(ra) # 5bca <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    3d98:	85ca                	mv	a1,s2
    3d9a:	00004517          	auipc	a0,0x4
    3d9e:	d2650513          	add	a0,a0,-730 # 7ac0 <updateNode+0x185c>
    3da2:	00002097          	auipc	ra,0x2
    3da6:	1e0080e7          	jalr	480(ra) # 5f82 <printf>
    exit(1);
    3daa:	4505                	li	a0,1
    3dac:	00002097          	auipc	ra,0x2
    3db0:	e1e080e7          	jalr	-482(ra) # 5bca <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    3db4:	85ca                	mv	a1,s2
    3db6:	00004517          	auipc	a0,0x4
    3dba:	d3250513          	add	a0,a0,-718 # 7ae8 <updateNode+0x1884>
    3dbe:	00002097          	auipc	ra,0x2
    3dc2:	1c4080e7          	jalr	452(ra) # 5f82 <printf>
    exit(1);
    3dc6:	4505                	li	a0,1
    3dc8:	00002097          	auipc	ra,0x2
    3dcc:	e02080e7          	jalr	-510(ra) # 5bca <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3dd0:	85ca                	mv	a1,s2
    3dd2:	00004517          	auipc	a0,0x4
    3dd6:	9ae50513          	add	a0,a0,-1618 # 7780 <updateNode+0x151c>
    3dda:	00002097          	auipc	ra,0x2
    3dde:	1a8080e7          	jalr	424(ra) # 5f82 <printf>
    exit(1);
    3de2:	4505                	li	a0,1
    3de4:	00002097          	auipc	ra,0x2
    3de8:	de6080e7          	jalr	-538(ra) # 5bca <exit>
    printf("%s: unlink dd/ff failed\n", s);
    3dec:	85ca                	mv	a1,s2
    3dee:	00004517          	auipc	a0,0x4
    3df2:	d1a50513          	add	a0,a0,-742 # 7b08 <updateNode+0x18a4>
    3df6:	00002097          	auipc	ra,0x2
    3dfa:	18c080e7          	jalr	396(ra) # 5f82 <printf>
    exit(1);
    3dfe:	4505                	li	a0,1
    3e00:	00002097          	auipc	ra,0x2
    3e04:	dca080e7          	jalr	-566(ra) # 5bca <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    3e08:	85ca                	mv	a1,s2
    3e0a:	00004517          	auipc	a0,0x4
    3e0e:	d1e50513          	add	a0,a0,-738 # 7b28 <updateNode+0x18c4>
    3e12:	00002097          	auipc	ra,0x2
    3e16:	170080e7          	jalr	368(ra) # 5f82 <printf>
    exit(1);
    3e1a:	4505                	li	a0,1
    3e1c:	00002097          	auipc	ra,0x2
    3e20:	dae080e7          	jalr	-594(ra) # 5bca <exit>
    printf("%s: unlink dd/dd failed\n", s);
    3e24:	85ca                	mv	a1,s2
    3e26:	00004517          	auipc	a0,0x4
    3e2a:	d3250513          	add	a0,a0,-718 # 7b58 <updateNode+0x18f4>
    3e2e:	00002097          	auipc	ra,0x2
    3e32:	154080e7          	jalr	340(ra) # 5f82 <printf>
    exit(1);
    3e36:	4505                	li	a0,1
    3e38:	00002097          	auipc	ra,0x2
    3e3c:	d92080e7          	jalr	-622(ra) # 5bca <exit>
    printf("%s: unlink dd failed\n", s);
    3e40:	85ca                	mv	a1,s2
    3e42:	00004517          	auipc	a0,0x4
    3e46:	d3650513          	add	a0,a0,-714 # 7b78 <updateNode+0x1914>
    3e4a:	00002097          	auipc	ra,0x2
    3e4e:	138080e7          	jalr	312(ra) # 5f82 <printf>
    exit(1);
    3e52:	4505                	li	a0,1
    3e54:	00002097          	auipc	ra,0x2
    3e58:	d76080e7          	jalr	-650(ra) # 5bca <exit>

0000000000003e5c <rmdot>:
{
    3e5c:	1101                	add	sp,sp,-32
    3e5e:	ec06                	sd	ra,24(sp)
    3e60:	e822                	sd	s0,16(sp)
    3e62:	e426                	sd	s1,8(sp)
    3e64:	1000                	add	s0,sp,32
    3e66:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    3e68:	00004517          	auipc	a0,0x4
    3e6c:	d2850513          	add	a0,a0,-728 # 7b90 <updateNode+0x192c>
    3e70:	00002097          	auipc	ra,0x2
    3e74:	dc2080e7          	jalr	-574(ra) # 5c32 <mkdir>
    3e78:	e549                	bnez	a0,3f02 <rmdot+0xa6>
  if(chdir("dots") != 0){
    3e7a:	00004517          	auipc	a0,0x4
    3e7e:	d1650513          	add	a0,a0,-746 # 7b90 <updateNode+0x192c>
    3e82:	00002097          	auipc	ra,0x2
    3e86:	db8080e7          	jalr	-584(ra) # 5c3a <chdir>
    3e8a:	e951                	bnez	a0,3f1e <rmdot+0xc2>
  if(unlink(".") == 0){
    3e8c:	00003517          	auipc	a0,0x3
    3e90:	b3450513          	add	a0,a0,-1228 # 69c0 <updateNode+0x75c>
    3e94:	00002097          	auipc	ra,0x2
    3e98:	d86080e7          	jalr	-634(ra) # 5c1a <unlink>
    3e9c:	cd59                	beqz	a0,3f3a <rmdot+0xde>
  if(unlink("..") == 0){
    3e9e:	00003517          	auipc	a0,0x3
    3ea2:	74a50513          	add	a0,a0,1866 # 75e8 <updateNode+0x1384>
    3ea6:	00002097          	auipc	ra,0x2
    3eaa:	d74080e7          	jalr	-652(ra) # 5c1a <unlink>
    3eae:	c545                	beqz	a0,3f56 <rmdot+0xfa>
  if(chdir("/") != 0){
    3eb0:	00003517          	auipc	a0,0x3
    3eb4:	6e050513          	add	a0,a0,1760 # 7590 <updateNode+0x132c>
    3eb8:	00002097          	auipc	ra,0x2
    3ebc:	d82080e7          	jalr	-638(ra) # 5c3a <chdir>
    3ec0:	e94d                	bnez	a0,3f72 <rmdot+0x116>
  if(unlink("dots/.") == 0){
    3ec2:	00004517          	auipc	a0,0x4
    3ec6:	d3650513          	add	a0,a0,-714 # 7bf8 <updateNode+0x1994>
    3eca:	00002097          	auipc	ra,0x2
    3ece:	d50080e7          	jalr	-688(ra) # 5c1a <unlink>
    3ed2:	cd55                	beqz	a0,3f8e <rmdot+0x132>
  if(unlink("dots/..") == 0){
    3ed4:	00004517          	auipc	a0,0x4
    3ed8:	d4c50513          	add	a0,a0,-692 # 7c20 <updateNode+0x19bc>
    3edc:	00002097          	auipc	ra,0x2
    3ee0:	d3e080e7          	jalr	-706(ra) # 5c1a <unlink>
    3ee4:	c179                	beqz	a0,3faa <rmdot+0x14e>
  if(unlink("dots") != 0){
    3ee6:	00004517          	auipc	a0,0x4
    3eea:	caa50513          	add	a0,a0,-854 # 7b90 <updateNode+0x192c>
    3eee:	00002097          	auipc	ra,0x2
    3ef2:	d2c080e7          	jalr	-724(ra) # 5c1a <unlink>
    3ef6:	e961                	bnez	a0,3fc6 <rmdot+0x16a>
}
    3ef8:	60e2                	ld	ra,24(sp)
    3efa:	6442                	ld	s0,16(sp)
    3efc:	64a2                	ld	s1,8(sp)
    3efe:	6105                	add	sp,sp,32
    3f00:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    3f02:	85a6                	mv	a1,s1
    3f04:	00004517          	auipc	a0,0x4
    3f08:	c9450513          	add	a0,a0,-876 # 7b98 <updateNode+0x1934>
    3f0c:	00002097          	auipc	ra,0x2
    3f10:	076080e7          	jalr	118(ra) # 5f82 <printf>
    exit(1);
    3f14:	4505                	li	a0,1
    3f16:	00002097          	auipc	ra,0x2
    3f1a:	cb4080e7          	jalr	-844(ra) # 5bca <exit>
    printf("%s: chdir dots failed\n", s);
    3f1e:	85a6                	mv	a1,s1
    3f20:	00004517          	auipc	a0,0x4
    3f24:	c9050513          	add	a0,a0,-880 # 7bb0 <updateNode+0x194c>
    3f28:	00002097          	auipc	ra,0x2
    3f2c:	05a080e7          	jalr	90(ra) # 5f82 <printf>
    exit(1);
    3f30:	4505                	li	a0,1
    3f32:	00002097          	auipc	ra,0x2
    3f36:	c98080e7          	jalr	-872(ra) # 5bca <exit>
    printf("%s: rm . worked!\n", s);
    3f3a:	85a6                	mv	a1,s1
    3f3c:	00004517          	auipc	a0,0x4
    3f40:	c8c50513          	add	a0,a0,-884 # 7bc8 <updateNode+0x1964>
    3f44:	00002097          	auipc	ra,0x2
    3f48:	03e080e7          	jalr	62(ra) # 5f82 <printf>
    exit(1);
    3f4c:	4505                	li	a0,1
    3f4e:	00002097          	auipc	ra,0x2
    3f52:	c7c080e7          	jalr	-900(ra) # 5bca <exit>
    printf("%s: rm .. worked!\n", s);
    3f56:	85a6                	mv	a1,s1
    3f58:	00004517          	auipc	a0,0x4
    3f5c:	c8850513          	add	a0,a0,-888 # 7be0 <updateNode+0x197c>
    3f60:	00002097          	auipc	ra,0x2
    3f64:	022080e7          	jalr	34(ra) # 5f82 <printf>
    exit(1);
    3f68:	4505                	li	a0,1
    3f6a:	00002097          	auipc	ra,0x2
    3f6e:	c60080e7          	jalr	-928(ra) # 5bca <exit>
    printf("%s: chdir / failed\n", s);
    3f72:	85a6                	mv	a1,s1
    3f74:	00003517          	auipc	a0,0x3
    3f78:	62450513          	add	a0,a0,1572 # 7598 <updateNode+0x1334>
    3f7c:	00002097          	auipc	ra,0x2
    3f80:	006080e7          	jalr	6(ra) # 5f82 <printf>
    exit(1);
    3f84:	4505                	li	a0,1
    3f86:	00002097          	auipc	ra,0x2
    3f8a:	c44080e7          	jalr	-956(ra) # 5bca <exit>
    printf("%s: unlink dots/. worked!\n", s);
    3f8e:	85a6                	mv	a1,s1
    3f90:	00004517          	auipc	a0,0x4
    3f94:	c7050513          	add	a0,a0,-912 # 7c00 <updateNode+0x199c>
    3f98:	00002097          	auipc	ra,0x2
    3f9c:	fea080e7          	jalr	-22(ra) # 5f82 <printf>
    exit(1);
    3fa0:	4505                	li	a0,1
    3fa2:	00002097          	auipc	ra,0x2
    3fa6:	c28080e7          	jalr	-984(ra) # 5bca <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    3faa:	85a6                	mv	a1,s1
    3fac:	00004517          	auipc	a0,0x4
    3fb0:	c7c50513          	add	a0,a0,-900 # 7c28 <updateNode+0x19c4>
    3fb4:	00002097          	auipc	ra,0x2
    3fb8:	fce080e7          	jalr	-50(ra) # 5f82 <printf>
    exit(1);
    3fbc:	4505                	li	a0,1
    3fbe:	00002097          	auipc	ra,0x2
    3fc2:	c0c080e7          	jalr	-1012(ra) # 5bca <exit>
    printf("%s: unlink dots failed!\n", s);
    3fc6:	85a6                	mv	a1,s1
    3fc8:	00004517          	auipc	a0,0x4
    3fcc:	c8050513          	add	a0,a0,-896 # 7c48 <updateNode+0x19e4>
    3fd0:	00002097          	auipc	ra,0x2
    3fd4:	fb2080e7          	jalr	-78(ra) # 5f82 <printf>
    exit(1);
    3fd8:	4505                	li	a0,1
    3fda:	00002097          	auipc	ra,0x2
    3fde:	bf0080e7          	jalr	-1040(ra) # 5bca <exit>

0000000000003fe2 <dirfile>:
{
    3fe2:	1101                	add	sp,sp,-32
    3fe4:	ec06                	sd	ra,24(sp)
    3fe6:	e822                	sd	s0,16(sp)
    3fe8:	e426                	sd	s1,8(sp)
    3fea:	e04a                	sd	s2,0(sp)
    3fec:	1000                	add	s0,sp,32
    3fee:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    3ff0:	20000593          	li	a1,512
    3ff4:	00004517          	auipc	a0,0x4
    3ff8:	c7450513          	add	a0,a0,-908 # 7c68 <updateNode+0x1a04>
    3ffc:	00002097          	auipc	ra,0x2
    4000:	c0e080e7          	jalr	-1010(ra) # 5c0a <open>
  if(fd < 0){
    4004:	0e054d63          	bltz	a0,40fe <dirfile+0x11c>
  close(fd);
    4008:	00002097          	auipc	ra,0x2
    400c:	bea080e7          	jalr	-1046(ra) # 5bf2 <close>
  if(chdir("dirfile") == 0){
    4010:	00004517          	auipc	a0,0x4
    4014:	c5850513          	add	a0,a0,-936 # 7c68 <updateNode+0x1a04>
    4018:	00002097          	auipc	ra,0x2
    401c:	c22080e7          	jalr	-990(ra) # 5c3a <chdir>
    4020:	cd6d                	beqz	a0,411a <dirfile+0x138>
  fd = open("dirfile/xx", 0);
    4022:	4581                	li	a1,0
    4024:	00004517          	auipc	a0,0x4
    4028:	c8c50513          	add	a0,a0,-884 # 7cb0 <updateNode+0x1a4c>
    402c:	00002097          	auipc	ra,0x2
    4030:	bde080e7          	jalr	-1058(ra) # 5c0a <open>
  if(fd >= 0){
    4034:	10055163          	bgez	a0,4136 <dirfile+0x154>
  fd = open("dirfile/xx", O_CREATE);
    4038:	20000593          	li	a1,512
    403c:	00004517          	auipc	a0,0x4
    4040:	c7450513          	add	a0,a0,-908 # 7cb0 <updateNode+0x1a4c>
    4044:	00002097          	auipc	ra,0x2
    4048:	bc6080e7          	jalr	-1082(ra) # 5c0a <open>
  if(fd >= 0){
    404c:	10055363          	bgez	a0,4152 <dirfile+0x170>
  if(mkdir("dirfile/xx") == 0){
    4050:	00004517          	auipc	a0,0x4
    4054:	c6050513          	add	a0,a0,-928 # 7cb0 <updateNode+0x1a4c>
    4058:	00002097          	auipc	ra,0x2
    405c:	bda080e7          	jalr	-1062(ra) # 5c32 <mkdir>
    4060:	10050763          	beqz	a0,416e <dirfile+0x18c>
  if(unlink("dirfile/xx") == 0){
    4064:	00004517          	auipc	a0,0x4
    4068:	c4c50513          	add	a0,a0,-948 # 7cb0 <updateNode+0x1a4c>
    406c:	00002097          	auipc	ra,0x2
    4070:	bae080e7          	jalr	-1106(ra) # 5c1a <unlink>
    4074:	10050b63          	beqz	a0,418a <dirfile+0x1a8>
  if(link("README", "dirfile/xx") == 0){
    4078:	00004597          	auipc	a1,0x4
    407c:	c3858593          	add	a1,a1,-968 # 7cb0 <updateNode+0x1a4c>
    4080:	00002517          	auipc	a0,0x2
    4084:	43050513          	add	a0,a0,1072 # 64b0 <updateNode+0x24c>
    4088:	00002097          	auipc	ra,0x2
    408c:	ba2080e7          	jalr	-1118(ra) # 5c2a <link>
    4090:	10050b63          	beqz	a0,41a6 <dirfile+0x1c4>
  if(unlink("dirfile") != 0){
    4094:	00004517          	auipc	a0,0x4
    4098:	bd450513          	add	a0,a0,-1068 # 7c68 <updateNode+0x1a04>
    409c:	00002097          	auipc	ra,0x2
    40a0:	b7e080e7          	jalr	-1154(ra) # 5c1a <unlink>
    40a4:	10051f63          	bnez	a0,41c2 <dirfile+0x1e0>
  fd = open(".", O_RDWR);
    40a8:	4589                	li	a1,2
    40aa:	00003517          	auipc	a0,0x3
    40ae:	91650513          	add	a0,a0,-1770 # 69c0 <updateNode+0x75c>
    40b2:	00002097          	auipc	ra,0x2
    40b6:	b58080e7          	jalr	-1192(ra) # 5c0a <open>
  if(fd >= 0){
    40ba:	12055263          	bgez	a0,41de <dirfile+0x1fc>
  fd = open(".", 0);
    40be:	4581                	li	a1,0
    40c0:	00003517          	auipc	a0,0x3
    40c4:	90050513          	add	a0,a0,-1792 # 69c0 <updateNode+0x75c>
    40c8:	00002097          	auipc	ra,0x2
    40cc:	b42080e7          	jalr	-1214(ra) # 5c0a <open>
    40d0:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    40d2:	4605                	li	a2,1
    40d4:	00002597          	auipc	a1,0x2
    40d8:	27458593          	add	a1,a1,628 # 6348 <updateNode+0xe4>
    40dc:	00002097          	auipc	ra,0x2
    40e0:	b0e080e7          	jalr	-1266(ra) # 5bea <write>
    40e4:	10a04b63          	bgtz	a0,41fa <dirfile+0x218>
  close(fd);
    40e8:	8526                	mv	a0,s1
    40ea:	00002097          	auipc	ra,0x2
    40ee:	b08080e7          	jalr	-1272(ra) # 5bf2 <close>
}
    40f2:	60e2                	ld	ra,24(sp)
    40f4:	6442                	ld	s0,16(sp)
    40f6:	64a2                	ld	s1,8(sp)
    40f8:	6902                	ld	s2,0(sp)
    40fa:	6105                	add	sp,sp,32
    40fc:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    40fe:	85ca                	mv	a1,s2
    4100:	00004517          	auipc	a0,0x4
    4104:	b7050513          	add	a0,a0,-1168 # 7c70 <updateNode+0x1a0c>
    4108:	00002097          	auipc	ra,0x2
    410c:	e7a080e7          	jalr	-390(ra) # 5f82 <printf>
    exit(1);
    4110:	4505                	li	a0,1
    4112:	00002097          	auipc	ra,0x2
    4116:	ab8080e7          	jalr	-1352(ra) # 5bca <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    411a:	85ca                	mv	a1,s2
    411c:	00004517          	auipc	a0,0x4
    4120:	b7450513          	add	a0,a0,-1164 # 7c90 <updateNode+0x1a2c>
    4124:	00002097          	auipc	ra,0x2
    4128:	e5e080e7          	jalr	-418(ra) # 5f82 <printf>
    exit(1);
    412c:	4505                	li	a0,1
    412e:	00002097          	auipc	ra,0x2
    4132:	a9c080e7          	jalr	-1380(ra) # 5bca <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4136:	85ca                	mv	a1,s2
    4138:	00004517          	auipc	a0,0x4
    413c:	b8850513          	add	a0,a0,-1144 # 7cc0 <updateNode+0x1a5c>
    4140:	00002097          	auipc	ra,0x2
    4144:	e42080e7          	jalr	-446(ra) # 5f82 <printf>
    exit(1);
    4148:	4505                	li	a0,1
    414a:	00002097          	auipc	ra,0x2
    414e:	a80080e7          	jalr	-1408(ra) # 5bca <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4152:	85ca                	mv	a1,s2
    4154:	00004517          	auipc	a0,0x4
    4158:	b6c50513          	add	a0,a0,-1172 # 7cc0 <updateNode+0x1a5c>
    415c:	00002097          	auipc	ra,0x2
    4160:	e26080e7          	jalr	-474(ra) # 5f82 <printf>
    exit(1);
    4164:	4505                	li	a0,1
    4166:	00002097          	auipc	ra,0x2
    416a:	a64080e7          	jalr	-1436(ra) # 5bca <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    416e:	85ca                	mv	a1,s2
    4170:	00004517          	auipc	a0,0x4
    4174:	b7850513          	add	a0,a0,-1160 # 7ce8 <updateNode+0x1a84>
    4178:	00002097          	auipc	ra,0x2
    417c:	e0a080e7          	jalr	-502(ra) # 5f82 <printf>
    exit(1);
    4180:	4505                	li	a0,1
    4182:	00002097          	auipc	ra,0x2
    4186:	a48080e7          	jalr	-1464(ra) # 5bca <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    418a:	85ca                	mv	a1,s2
    418c:	00004517          	auipc	a0,0x4
    4190:	b8450513          	add	a0,a0,-1148 # 7d10 <updateNode+0x1aac>
    4194:	00002097          	auipc	ra,0x2
    4198:	dee080e7          	jalr	-530(ra) # 5f82 <printf>
    exit(1);
    419c:	4505                	li	a0,1
    419e:	00002097          	auipc	ra,0x2
    41a2:	a2c080e7          	jalr	-1492(ra) # 5bca <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    41a6:	85ca                	mv	a1,s2
    41a8:	00004517          	auipc	a0,0x4
    41ac:	b9050513          	add	a0,a0,-1136 # 7d38 <updateNode+0x1ad4>
    41b0:	00002097          	auipc	ra,0x2
    41b4:	dd2080e7          	jalr	-558(ra) # 5f82 <printf>
    exit(1);
    41b8:	4505                	li	a0,1
    41ba:	00002097          	auipc	ra,0x2
    41be:	a10080e7          	jalr	-1520(ra) # 5bca <exit>
    printf("%s: unlink dirfile failed!\n", s);
    41c2:	85ca                	mv	a1,s2
    41c4:	00004517          	auipc	a0,0x4
    41c8:	b9c50513          	add	a0,a0,-1124 # 7d60 <updateNode+0x1afc>
    41cc:	00002097          	auipc	ra,0x2
    41d0:	db6080e7          	jalr	-586(ra) # 5f82 <printf>
    exit(1);
    41d4:	4505                	li	a0,1
    41d6:	00002097          	auipc	ra,0x2
    41da:	9f4080e7          	jalr	-1548(ra) # 5bca <exit>
    printf("%s: open . for writing succeeded!\n", s);
    41de:	85ca                	mv	a1,s2
    41e0:	00004517          	auipc	a0,0x4
    41e4:	ba050513          	add	a0,a0,-1120 # 7d80 <updateNode+0x1b1c>
    41e8:	00002097          	auipc	ra,0x2
    41ec:	d9a080e7          	jalr	-614(ra) # 5f82 <printf>
    exit(1);
    41f0:	4505                	li	a0,1
    41f2:	00002097          	auipc	ra,0x2
    41f6:	9d8080e7          	jalr	-1576(ra) # 5bca <exit>
    printf("%s: write . succeeded!\n", s);
    41fa:	85ca                	mv	a1,s2
    41fc:	00004517          	auipc	a0,0x4
    4200:	bac50513          	add	a0,a0,-1108 # 7da8 <updateNode+0x1b44>
    4204:	00002097          	auipc	ra,0x2
    4208:	d7e080e7          	jalr	-642(ra) # 5f82 <printf>
    exit(1);
    420c:	4505                	li	a0,1
    420e:	00002097          	auipc	ra,0x2
    4212:	9bc080e7          	jalr	-1604(ra) # 5bca <exit>

0000000000004216 <iref>:
{
    4216:	7139                	add	sp,sp,-64
    4218:	fc06                	sd	ra,56(sp)
    421a:	f822                	sd	s0,48(sp)
    421c:	f426                	sd	s1,40(sp)
    421e:	f04a                	sd	s2,32(sp)
    4220:	ec4e                	sd	s3,24(sp)
    4222:	e852                	sd	s4,16(sp)
    4224:	e456                	sd	s5,8(sp)
    4226:	e05a                	sd	s6,0(sp)
    4228:	0080                	add	s0,sp,64
    422a:	8b2a                	mv	s6,a0
    422c:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    4230:	00004a17          	auipc	s4,0x4
    4234:	b90a0a13          	add	s4,s4,-1136 # 7dc0 <updateNode+0x1b5c>
    mkdir("");
    4238:	00003497          	auipc	s1,0x3
    423c:	69048493          	add	s1,s1,1680 # 78c8 <updateNode+0x1664>
    link("README", "");
    4240:	00002a97          	auipc	s5,0x2
    4244:	270a8a93          	add	s5,s5,624 # 64b0 <updateNode+0x24c>
    fd = open("xx", O_CREATE);
    4248:	00004997          	auipc	s3,0x4
    424c:	a7098993          	add	s3,s3,-1424 # 7cb8 <updateNode+0x1a54>
    4250:	a891                	j	42a4 <iref+0x8e>
      printf("%s: mkdir irefd failed\n", s);
    4252:	85da                	mv	a1,s6
    4254:	00004517          	auipc	a0,0x4
    4258:	b7450513          	add	a0,a0,-1164 # 7dc8 <updateNode+0x1b64>
    425c:	00002097          	auipc	ra,0x2
    4260:	d26080e7          	jalr	-730(ra) # 5f82 <printf>
      exit(1);
    4264:	4505                	li	a0,1
    4266:	00002097          	auipc	ra,0x2
    426a:	964080e7          	jalr	-1692(ra) # 5bca <exit>
      printf("%s: chdir irefd failed\n", s);
    426e:	85da                	mv	a1,s6
    4270:	00004517          	auipc	a0,0x4
    4274:	b7050513          	add	a0,a0,-1168 # 7de0 <updateNode+0x1b7c>
    4278:	00002097          	auipc	ra,0x2
    427c:	d0a080e7          	jalr	-758(ra) # 5f82 <printf>
      exit(1);
    4280:	4505                	li	a0,1
    4282:	00002097          	auipc	ra,0x2
    4286:	948080e7          	jalr	-1720(ra) # 5bca <exit>
      close(fd);
    428a:	00002097          	auipc	ra,0x2
    428e:	968080e7          	jalr	-1688(ra) # 5bf2 <close>
    4292:	a889                	j	42e4 <iref+0xce>
    unlink("xx");
    4294:	854e                	mv	a0,s3
    4296:	00002097          	auipc	ra,0x2
    429a:	984080e7          	jalr	-1660(ra) # 5c1a <unlink>
  for(i = 0; i < NINODE + 1; i++){
    429e:	397d                	addw	s2,s2,-1
    42a0:	06090063          	beqz	s2,4300 <iref+0xea>
    if(mkdir("irefd") != 0){
    42a4:	8552                	mv	a0,s4
    42a6:	00002097          	auipc	ra,0x2
    42aa:	98c080e7          	jalr	-1652(ra) # 5c32 <mkdir>
    42ae:	f155                	bnez	a0,4252 <iref+0x3c>
    if(chdir("irefd") != 0){
    42b0:	8552                	mv	a0,s4
    42b2:	00002097          	auipc	ra,0x2
    42b6:	988080e7          	jalr	-1656(ra) # 5c3a <chdir>
    42ba:	f955                	bnez	a0,426e <iref+0x58>
    mkdir("");
    42bc:	8526                	mv	a0,s1
    42be:	00002097          	auipc	ra,0x2
    42c2:	974080e7          	jalr	-1676(ra) # 5c32 <mkdir>
    link("README", "");
    42c6:	85a6                	mv	a1,s1
    42c8:	8556                	mv	a0,s5
    42ca:	00002097          	auipc	ra,0x2
    42ce:	960080e7          	jalr	-1696(ra) # 5c2a <link>
    fd = open("", O_CREATE);
    42d2:	20000593          	li	a1,512
    42d6:	8526                	mv	a0,s1
    42d8:	00002097          	auipc	ra,0x2
    42dc:	932080e7          	jalr	-1742(ra) # 5c0a <open>
    if(fd >= 0)
    42e0:	fa0555e3          	bgez	a0,428a <iref+0x74>
    fd = open("xx", O_CREATE);
    42e4:	20000593          	li	a1,512
    42e8:	854e                	mv	a0,s3
    42ea:	00002097          	auipc	ra,0x2
    42ee:	920080e7          	jalr	-1760(ra) # 5c0a <open>
    if(fd >= 0)
    42f2:	fa0541e3          	bltz	a0,4294 <iref+0x7e>
      close(fd);
    42f6:	00002097          	auipc	ra,0x2
    42fa:	8fc080e7          	jalr	-1796(ra) # 5bf2 <close>
    42fe:	bf59                	j	4294 <iref+0x7e>
    4300:	03300493          	li	s1,51
    chdir("..");
    4304:	00003997          	auipc	s3,0x3
    4308:	2e498993          	add	s3,s3,740 # 75e8 <updateNode+0x1384>
    unlink("irefd");
    430c:	00004917          	auipc	s2,0x4
    4310:	ab490913          	add	s2,s2,-1356 # 7dc0 <updateNode+0x1b5c>
    chdir("..");
    4314:	854e                	mv	a0,s3
    4316:	00002097          	auipc	ra,0x2
    431a:	924080e7          	jalr	-1756(ra) # 5c3a <chdir>
    unlink("irefd");
    431e:	854a                	mv	a0,s2
    4320:	00002097          	auipc	ra,0x2
    4324:	8fa080e7          	jalr	-1798(ra) # 5c1a <unlink>
  for(i = 0; i < NINODE + 1; i++){
    4328:	34fd                	addw	s1,s1,-1
    432a:	f4ed                	bnez	s1,4314 <iref+0xfe>
  chdir("/");
    432c:	00003517          	auipc	a0,0x3
    4330:	26450513          	add	a0,a0,612 # 7590 <updateNode+0x132c>
    4334:	00002097          	auipc	ra,0x2
    4338:	906080e7          	jalr	-1786(ra) # 5c3a <chdir>
}
    433c:	70e2                	ld	ra,56(sp)
    433e:	7442                	ld	s0,48(sp)
    4340:	74a2                	ld	s1,40(sp)
    4342:	7902                	ld	s2,32(sp)
    4344:	69e2                	ld	s3,24(sp)
    4346:	6a42                	ld	s4,16(sp)
    4348:	6aa2                	ld	s5,8(sp)
    434a:	6b02                	ld	s6,0(sp)
    434c:	6121                	add	sp,sp,64
    434e:	8082                	ret

0000000000004350 <openiputtest>:
{
    4350:	7179                	add	sp,sp,-48
    4352:	f406                	sd	ra,40(sp)
    4354:	f022                	sd	s0,32(sp)
    4356:	ec26                	sd	s1,24(sp)
    4358:	1800                	add	s0,sp,48
    435a:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    435c:	00004517          	auipc	a0,0x4
    4360:	a9c50513          	add	a0,a0,-1380 # 7df8 <updateNode+0x1b94>
    4364:	00002097          	auipc	ra,0x2
    4368:	8ce080e7          	jalr	-1842(ra) # 5c32 <mkdir>
    436c:	04054263          	bltz	a0,43b0 <openiputtest+0x60>
  pid = fork();
    4370:	00002097          	auipc	ra,0x2
    4374:	852080e7          	jalr	-1966(ra) # 5bc2 <fork>
  if(pid < 0){
    4378:	04054a63          	bltz	a0,43cc <openiputtest+0x7c>
  if(pid == 0){
    437c:	e93d                	bnez	a0,43f2 <openiputtest+0xa2>
    int fd = open("oidir", O_RDWR);
    437e:	4589                	li	a1,2
    4380:	00004517          	auipc	a0,0x4
    4384:	a7850513          	add	a0,a0,-1416 # 7df8 <updateNode+0x1b94>
    4388:	00002097          	auipc	ra,0x2
    438c:	882080e7          	jalr	-1918(ra) # 5c0a <open>
    if(fd >= 0){
    4390:	04054c63          	bltz	a0,43e8 <openiputtest+0x98>
      printf("%s: open directory for write succeeded\n", s);
    4394:	85a6                	mv	a1,s1
    4396:	00004517          	auipc	a0,0x4
    439a:	a8250513          	add	a0,a0,-1406 # 7e18 <updateNode+0x1bb4>
    439e:	00002097          	auipc	ra,0x2
    43a2:	be4080e7          	jalr	-1052(ra) # 5f82 <printf>
      exit(1);
    43a6:	4505                	li	a0,1
    43a8:	00002097          	auipc	ra,0x2
    43ac:	822080e7          	jalr	-2014(ra) # 5bca <exit>
    printf("%s: mkdir oidir failed\n", s);
    43b0:	85a6                	mv	a1,s1
    43b2:	00004517          	auipc	a0,0x4
    43b6:	a4e50513          	add	a0,a0,-1458 # 7e00 <updateNode+0x1b9c>
    43ba:	00002097          	auipc	ra,0x2
    43be:	bc8080e7          	jalr	-1080(ra) # 5f82 <printf>
    exit(1);
    43c2:	4505                	li	a0,1
    43c4:	00002097          	auipc	ra,0x2
    43c8:	806080e7          	jalr	-2042(ra) # 5bca <exit>
    printf("%s: fork failed\n", s);
    43cc:	85a6                	mv	a1,s1
    43ce:	00002517          	auipc	a0,0x2
    43d2:	79250513          	add	a0,a0,1938 # 6b60 <updateNode+0x8fc>
    43d6:	00002097          	auipc	ra,0x2
    43da:	bac080e7          	jalr	-1108(ra) # 5f82 <printf>
    exit(1);
    43de:	4505                	li	a0,1
    43e0:	00001097          	auipc	ra,0x1
    43e4:	7ea080e7          	jalr	2026(ra) # 5bca <exit>
    exit(0);
    43e8:	4501                	li	a0,0
    43ea:	00001097          	auipc	ra,0x1
    43ee:	7e0080e7          	jalr	2016(ra) # 5bca <exit>
  sleep(1);
    43f2:	4505                	li	a0,1
    43f4:	00002097          	auipc	ra,0x2
    43f8:	866080e7          	jalr	-1946(ra) # 5c5a <sleep>
  if(unlink("oidir") != 0){
    43fc:	00004517          	auipc	a0,0x4
    4400:	9fc50513          	add	a0,a0,-1540 # 7df8 <updateNode+0x1b94>
    4404:	00002097          	auipc	ra,0x2
    4408:	816080e7          	jalr	-2026(ra) # 5c1a <unlink>
    440c:	cd19                	beqz	a0,442a <openiputtest+0xda>
    printf("%s: unlink failed\n", s);
    440e:	85a6                	mv	a1,s1
    4410:	00003517          	auipc	a0,0x3
    4414:	94050513          	add	a0,a0,-1728 # 6d50 <updateNode+0xaec>
    4418:	00002097          	auipc	ra,0x2
    441c:	b6a080e7          	jalr	-1174(ra) # 5f82 <printf>
    exit(1);
    4420:	4505                	li	a0,1
    4422:	00001097          	auipc	ra,0x1
    4426:	7a8080e7          	jalr	1960(ra) # 5bca <exit>
  wait(&xstatus);
    442a:	fdc40513          	add	a0,s0,-36
    442e:	00001097          	auipc	ra,0x1
    4432:	7a4080e7          	jalr	1956(ra) # 5bd2 <wait>
  exit(xstatus);
    4436:	fdc42503          	lw	a0,-36(s0)
    443a:	00001097          	auipc	ra,0x1
    443e:	790080e7          	jalr	1936(ra) # 5bca <exit>

0000000000004442 <forkforkfork>:
{
    4442:	1101                	add	sp,sp,-32
    4444:	ec06                	sd	ra,24(sp)
    4446:	e822                	sd	s0,16(sp)
    4448:	e426                	sd	s1,8(sp)
    444a:	1000                	add	s0,sp,32
    444c:	84aa                	mv	s1,a0
  unlink("stopforking");
    444e:	00004517          	auipc	a0,0x4
    4452:	9f250513          	add	a0,a0,-1550 # 7e40 <updateNode+0x1bdc>
    4456:	00001097          	auipc	ra,0x1
    445a:	7c4080e7          	jalr	1988(ra) # 5c1a <unlink>
  int pid = fork();
    445e:	00001097          	auipc	ra,0x1
    4462:	764080e7          	jalr	1892(ra) # 5bc2 <fork>
  if(pid < 0){
    4466:	04054563          	bltz	a0,44b0 <forkforkfork+0x6e>
  if(pid == 0){
    446a:	c12d                	beqz	a0,44cc <forkforkfork+0x8a>
  sleep(20); // two seconds
    446c:	4551                	li	a0,20
    446e:	00001097          	auipc	ra,0x1
    4472:	7ec080e7          	jalr	2028(ra) # 5c5a <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    4476:	20200593          	li	a1,514
    447a:	00004517          	auipc	a0,0x4
    447e:	9c650513          	add	a0,a0,-1594 # 7e40 <updateNode+0x1bdc>
    4482:	00001097          	auipc	ra,0x1
    4486:	788080e7          	jalr	1928(ra) # 5c0a <open>
    448a:	00001097          	auipc	ra,0x1
    448e:	768080e7          	jalr	1896(ra) # 5bf2 <close>
  wait(0);
    4492:	4501                	li	a0,0
    4494:	00001097          	auipc	ra,0x1
    4498:	73e080e7          	jalr	1854(ra) # 5bd2 <wait>
  sleep(10); // one second
    449c:	4529                	li	a0,10
    449e:	00001097          	auipc	ra,0x1
    44a2:	7bc080e7          	jalr	1980(ra) # 5c5a <sleep>
}
    44a6:	60e2                	ld	ra,24(sp)
    44a8:	6442                	ld	s0,16(sp)
    44aa:	64a2                	ld	s1,8(sp)
    44ac:	6105                	add	sp,sp,32
    44ae:	8082                	ret
    printf("%s: fork failed", s);
    44b0:	85a6                	mv	a1,s1
    44b2:	00003517          	auipc	a0,0x3
    44b6:	86e50513          	add	a0,a0,-1938 # 6d20 <updateNode+0xabc>
    44ba:	00002097          	auipc	ra,0x2
    44be:	ac8080e7          	jalr	-1336(ra) # 5f82 <printf>
    exit(1);
    44c2:	4505                	li	a0,1
    44c4:	00001097          	auipc	ra,0x1
    44c8:	706080e7          	jalr	1798(ra) # 5bca <exit>
      int fd = open("stopforking", 0);
    44cc:	00004497          	auipc	s1,0x4
    44d0:	97448493          	add	s1,s1,-1676 # 7e40 <updateNode+0x1bdc>
    44d4:	4581                	li	a1,0
    44d6:	8526                	mv	a0,s1
    44d8:	00001097          	auipc	ra,0x1
    44dc:	732080e7          	jalr	1842(ra) # 5c0a <open>
      if(fd >= 0){
    44e0:	02055763          	bgez	a0,450e <forkforkfork+0xcc>
      if(fork() < 0){
    44e4:	00001097          	auipc	ra,0x1
    44e8:	6de080e7          	jalr	1758(ra) # 5bc2 <fork>
    44ec:	fe0554e3          	bgez	a0,44d4 <forkforkfork+0x92>
        close(open("stopforking", O_CREATE|O_RDWR));
    44f0:	20200593          	li	a1,514
    44f4:	00004517          	auipc	a0,0x4
    44f8:	94c50513          	add	a0,a0,-1716 # 7e40 <updateNode+0x1bdc>
    44fc:	00001097          	auipc	ra,0x1
    4500:	70e080e7          	jalr	1806(ra) # 5c0a <open>
    4504:	00001097          	auipc	ra,0x1
    4508:	6ee080e7          	jalr	1774(ra) # 5bf2 <close>
    450c:	b7e1                	j	44d4 <forkforkfork+0x92>
        exit(0);
    450e:	4501                	li	a0,0
    4510:	00001097          	auipc	ra,0x1
    4514:	6ba080e7          	jalr	1722(ra) # 5bca <exit>

0000000000004518 <killstatus>:
{
    4518:	7139                	add	sp,sp,-64
    451a:	fc06                	sd	ra,56(sp)
    451c:	f822                	sd	s0,48(sp)
    451e:	f426                	sd	s1,40(sp)
    4520:	f04a                	sd	s2,32(sp)
    4522:	ec4e                	sd	s3,24(sp)
    4524:	e852                	sd	s4,16(sp)
    4526:	0080                	add	s0,sp,64
    4528:	8a2a                	mv	s4,a0
    452a:	06400913          	li	s2,100
    if(xst != -1) {
    452e:	59fd                	li	s3,-1
    int pid1 = fork();
    4530:	00001097          	auipc	ra,0x1
    4534:	692080e7          	jalr	1682(ra) # 5bc2 <fork>
    4538:	84aa                	mv	s1,a0
    if(pid1 < 0){
    453a:	02054f63          	bltz	a0,4578 <killstatus+0x60>
    if(pid1 == 0){
    453e:	c939                	beqz	a0,4594 <killstatus+0x7c>
    sleep(1);
    4540:	4505                	li	a0,1
    4542:	00001097          	auipc	ra,0x1
    4546:	718080e7          	jalr	1816(ra) # 5c5a <sleep>
    kill(pid1);
    454a:	8526                	mv	a0,s1
    454c:	00001097          	auipc	ra,0x1
    4550:	6ae080e7          	jalr	1710(ra) # 5bfa <kill>
    wait(&xst);
    4554:	fcc40513          	add	a0,s0,-52
    4558:	00001097          	auipc	ra,0x1
    455c:	67a080e7          	jalr	1658(ra) # 5bd2 <wait>
    if(xst != -1) {
    4560:	fcc42783          	lw	a5,-52(s0)
    4564:	03379d63          	bne	a5,s3,459e <killstatus+0x86>
  for(int i = 0; i < 100; i++){
    4568:	397d                	addw	s2,s2,-1
    456a:	fc0913e3          	bnez	s2,4530 <killstatus+0x18>
  exit(0);
    456e:	4501                	li	a0,0
    4570:	00001097          	auipc	ra,0x1
    4574:	65a080e7          	jalr	1626(ra) # 5bca <exit>
      printf("%s: fork failed\n", s);
    4578:	85d2                	mv	a1,s4
    457a:	00002517          	auipc	a0,0x2
    457e:	5e650513          	add	a0,a0,1510 # 6b60 <updateNode+0x8fc>
    4582:	00002097          	auipc	ra,0x2
    4586:	a00080e7          	jalr	-1536(ra) # 5f82 <printf>
      exit(1);
    458a:	4505                	li	a0,1
    458c:	00001097          	auipc	ra,0x1
    4590:	63e080e7          	jalr	1598(ra) # 5bca <exit>
        getpid();
    4594:	00001097          	auipc	ra,0x1
    4598:	6b6080e7          	jalr	1718(ra) # 5c4a <getpid>
      while(1) {
    459c:	bfe5                	j	4594 <killstatus+0x7c>
       printf("%s: status should be -1\n", s);
    459e:	85d2                	mv	a1,s4
    45a0:	00004517          	auipc	a0,0x4
    45a4:	8b050513          	add	a0,a0,-1872 # 7e50 <updateNode+0x1bec>
    45a8:	00002097          	auipc	ra,0x2
    45ac:	9da080e7          	jalr	-1574(ra) # 5f82 <printf>
       exit(1);
    45b0:	4505                	li	a0,1
    45b2:	00001097          	auipc	ra,0x1
    45b6:	618080e7          	jalr	1560(ra) # 5bca <exit>

00000000000045ba <preempt>:
{
    45ba:	7139                	add	sp,sp,-64
    45bc:	fc06                	sd	ra,56(sp)
    45be:	f822                	sd	s0,48(sp)
    45c0:	f426                	sd	s1,40(sp)
    45c2:	f04a                	sd	s2,32(sp)
    45c4:	ec4e                	sd	s3,24(sp)
    45c6:	e852                	sd	s4,16(sp)
    45c8:	0080                	add	s0,sp,64
    45ca:	892a                	mv	s2,a0
  pid1 = fork();
    45cc:	00001097          	auipc	ra,0x1
    45d0:	5f6080e7          	jalr	1526(ra) # 5bc2 <fork>
  if(pid1 < 0) {
    45d4:	00054563          	bltz	a0,45de <preempt+0x24>
    45d8:	84aa                	mv	s1,a0
  if(pid1 == 0)
    45da:	e105                	bnez	a0,45fa <preempt+0x40>
    for(;;)
    45dc:	a001                	j	45dc <preempt+0x22>
    printf("%s: fork failed", s);
    45de:	85ca                	mv	a1,s2
    45e0:	00002517          	auipc	a0,0x2
    45e4:	74050513          	add	a0,a0,1856 # 6d20 <updateNode+0xabc>
    45e8:	00002097          	auipc	ra,0x2
    45ec:	99a080e7          	jalr	-1638(ra) # 5f82 <printf>
    exit(1);
    45f0:	4505                	li	a0,1
    45f2:	00001097          	auipc	ra,0x1
    45f6:	5d8080e7          	jalr	1496(ra) # 5bca <exit>
  pid2 = fork();
    45fa:	00001097          	auipc	ra,0x1
    45fe:	5c8080e7          	jalr	1480(ra) # 5bc2 <fork>
    4602:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    4604:	00054463          	bltz	a0,460c <preempt+0x52>
  if(pid2 == 0)
    4608:	e105                	bnez	a0,4628 <preempt+0x6e>
    for(;;)
    460a:	a001                	j	460a <preempt+0x50>
    printf("%s: fork failed\n", s);
    460c:	85ca                	mv	a1,s2
    460e:	00002517          	auipc	a0,0x2
    4612:	55250513          	add	a0,a0,1362 # 6b60 <updateNode+0x8fc>
    4616:	00002097          	auipc	ra,0x2
    461a:	96c080e7          	jalr	-1684(ra) # 5f82 <printf>
    exit(1);
    461e:	4505                	li	a0,1
    4620:	00001097          	auipc	ra,0x1
    4624:	5aa080e7          	jalr	1450(ra) # 5bca <exit>
  pipe(pfds);
    4628:	fc840513          	add	a0,s0,-56
    462c:	00001097          	auipc	ra,0x1
    4630:	5ae080e7          	jalr	1454(ra) # 5bda <pipe>
  pid3 = fork();
    4634:	00001097          	auipc	ra,0x1
    4638:	58e080e7          	jalr	1422(ra) # 5bc2 <fork>
    463c:	8a2a                	mv	s4,a0
  if(pid3 < 0) {
    463e:	02054e63          	bltz	a0,467a <preempt+0xc0>
  if(pid3 == 0){
    4642:	e525                	bnez	a0,46aa <preempt+0xf0>
    close(pfds[0]);
    4644:	fc842503          	lw	a0,-56(s0)
    4648:	00001097          	auipc	ra,0x1
    464c:	5aa080e7          	jalr	1450(ra) # 5bf2 <close>
    if(write(pfds[1], "x", 1) != 1)
    4650:	4605                	li	a2,1
    4652:	00002597          	auipc	a1,0x2
    4656:	cf658593          	add	a1,a1,-778 # 6348 <updateNode+0xe4>
    465a:	fcc42503          	lw	a0,-52(s0)
    465e:	00001097          	auipc	ra,0x1
    4662:	58c080e7          	jalr	1420(ra) # 5bea <write>
    4666:	4785                	li	a5,1
    4668:	02f51763          	bne	a0,a5,4696 <preempt+0xdc>
    close(pfds[1]);
    466c:	fcc42503          	lw	a0,-52(s0)
    4670:	00001097          	auipc	ra,0x1
    4674:	582080e7          	jalr	1410(ra) # 5bf2 <close>
    for(;;)
    4678:	a001                	j	4678 <preempt+0xbe>
     printf("%s: fork failed\n", s);
    467a:	85ca                	mv	a1,s2
    467c:	00002517          	auipc	a0,0x2
    4680:	4e450513          	add	a0,a0,1252 # 6b60 <updateNode+0x8fc>
    4684:	00002097          	auipc	ra,0x2
    4688:	8fe080e7          	jalr	-1794(ra) # 5f82 <printf>
     exit(1);
    468c:	4505                	li	a0,1
    468e:	00001097          	auipc	ra,0x1
    4692:	53c080e7          	jalr	1340(ra) # 5bca <exit>
      printf("%s: preempt write error", s);
    4696:	85ca                	mv	a1,s2
    4698:	00003517          	auipc	a0,0x3
    469c:	7d850513          	add	a0,a0,2008 # 7e70 <updateNode+0x1c0c>
    46a0:	00002097          	auipc	ra,0x2
    46a4:	8e2080e7          	jalr	-1822(ra) # 5f82 <printf>
    46a8:	b7d1                	j	466c <preempt+0xb2>
  close(pfds[1]);
    46aa:	fcc42503          	lw	a0,-52(s0)
    46ae:	00001097          	auipc	ra,0x1
    46b2:	544080e7          	jalr	1348(ra) # 5bf2 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    46b6:	660d                	lui	a2,0x3
    46b8:	00008597          	auipc	a1,0x8
    46bc:	5c058593          	add	a1,a1,1472 # cc78 <buf>
    46c0:	fc842503          	lw	a0,-56(s0)
    46c4:	00001097          	auipc	ra,0x1
    46c8:	51e080e7          	jalr	1310(ra) # 5be2 <read>
    46cc:	4785                	li	a5,1
    46ce:	02f50363          	beq	a0,a5,46f4 <preempt+0x13a>
    printf("%s: preempt read error", s);
    46d2:	85ca                	mv	a1,s2
    46d4:	00003517          	auipc	a0,0x3
    46d8:	7b450513          	add	a0,a0,1972 # 7e88 <updateNode+0x1c24>
    46dc:	00002097          	auipc	ra,0x2
    46e0:	8a6080e7          	jalr	-1882(ra) # 5f82 <printf>
}
    46e4:	70e2                	ld	ra,56(sp)
    46e6:	7442                	ld	s0,48(sp)
    46e8:	74a2                	ld	s1,40(sp)
    46ea:	7902                	ld	s2,32(sp)
    46ec:	69e2                	ld	s3,24(sp)
    46ee:	6a42                	ld	s4,16(sp)
    46f0:	6121                	add	sp,sp,64
    46f2:	8082                	ret
  close(pfds[0]);
    46f4:	fc842503          	lw	a0,-56(s0)
    46f8:	00001097          	auipc	ra,0x1
    46fc:	4fa080e7          	jalr	1274(ra) # 5bf2 <close>
  printf("kill... ");
    4700:	00003517          	auipc	a0,0x3
    4704:	7a050513          	add	a0,a0,1952 # 7ea0 <updateNode+0x1c3c>
    4708:	00002097          	auipc	ra,0x2
    470c:	87a080e7          	jalr	-1926(ra) # 5f82 <printf>
  kill(pid1);
    4710:	8526                	mv	a0,s1
    4712:	00001097          	auipc	ra,0x1
    4716:	4e8080e7          	jalr	1256(ra) # 5bfa <kill>
  kill(pid2);
    471a:	854e                	mv	a0,s3
    471c:	00001097          	auipc	ra,0x1
    4720:	4de080e7          	jalr	1246(ra) # 5bfa <kill>
  kill(pid3);
    4724:	8552                	mv	a0,s4
    4726:	00001097          	auipc	ra,0x1
    472a:	4d4080e7          	jalr	1236(ra) # 5bfa <kill>
  printf("wait... ");
    472e:	00003517          	auipc	a0,0x3
    4732:	78250513          	add	a0,a0,1922 # 7eb0 <updateNode+0x1c4c>
    4736:	00002097          	auipc	ra,0x2
    473a:	84c080e7          	jalr	-1972(ra) # 5f82 <printf>
  wait(0);
    473e:	4501                	li	a0,0
    4740:	00001097          	auipc	ra,0x1
    4744:	492080e7          	jalr	1170(ra) # 5bd2 <wait>
  wait(0);
    4748:	4501                	li	a0,0
    474a:	00001097          	auipc	ra,0x1
    474e:	488080e7          	jalr	1160(ra) # 5bd2 <wait>
  wait(0);
    4752:	4501                	li	a0,0
    4754:	00001097          	auipc	ra,0x1
    4758:	47e080e7          	jalr	1150(ra) # 5bd2 <wait>
    475c:	b761                	j	46e4 <preempt+0x12a>

000000000000475e <reparent>:
{
    475e:	7179                	add	sp,sp,-48
    4760:	f406                	sd	ra,40(sp)
    4762:	f022                	sd	s0,32(sp)
    4764:	ec26                	sd	s1,24(sp)
    4766:	e84a                	sd	s2,16(sp)
    4768:	e44e                	sd	s3,8(sp)
    476a:	e052                	sd	s4,0(sp)
    476c:	1800                	add	s0,sp,48
    476e:	89aa                	mv	s3,a0
  int master_pid = getpid();
    4770:	00001097          	auipc	ra,0x1
    4774:	4da080e7          	jalr	1242(ra) # 5c4a <getpid>
    4778:	8a2a                	mv	s4,a0
    477a:	0c800913          	li	s2,200
    int pid = fork();
    477e:	00001097          	auipc	ra,0x1
    4782:	444080e7          	jalr	1092(ra) # 5bc2 <fork>
    4786:	84aa                	mv	s1,a0
    if(pid < 0){
    4788:	02054263          	bltz	a0,47ac <reparent+0x4e>
    if(pid){
    478c:	cd21                	beqz	a0,47e4 <reparent+0x86>
      if(wait(0) != pid){
    478e:	4501                	li	a0,0
    4790:	00001097          	auipc	ra,0x1
    4794:	442080e7          	jalr	1090(ra) # 5bd2 <wait>
    4798:	02951863          	bne	a0,s1,47c8 <reparent+0x6a>
  for(int i = 0; i < 200; i++){
    479c:	397d                	addw	s2,s2,-1
    479e:	fe0910e3          	bnez	s2,477e <reparent+0x20>
  exit(0);
    47a2:	4501                	li	a0,0
    47a4:	00001097          	auipc	ra,0x1
    47a8:	426080e7          	jalr	1062(ra) # 5bca <exit>
      printf("%s: fork failed\n", s);
    47ac:	85ce                	mv	a1,s3
    47ae:	00002517          	auipc	a0,0x2
    47b2:	3b250513          	add	a0,a0,946 # 6b60 <updateNode+0x8fc>
    47b6:	00001097          	auipc	ra,0x1
    47ba:	7cc080e7          	jalr	1996(ra) # 5f82 <printf>
      exit(1);
    47be:	4505                	li	a0,1
    47c0:	00001097          	auipc	ra,0x1
    47c4:	40a080e7          	jalr	1034(ra) # 5bca <exit>
        printf("%s: wait wrong pid\n", s);
    47c8:	85ce                	mv	a1,s3
    47ca:	00002517          	auipc	a0,0x2
    47ce:	51e50513          	add	a0,a0,1310 # 6ce8 <updateNode+0xa84>
    47d2:	00001097          	auipc	ra,0x1
    47d6:	7b0080e7          	jalr	1968(ra) # 5f82 <printf>
        exit(1);
    47da:	4505                	li	a0,1
    47dc:	00001097          	auipc	ra,0x1
    47e0:	3ee080e7          	jalr	1006(ra) # 5bca <exit>
      int pid2 = fork();
    47e4:	00001097          	auipc	ra,0x1
    47e8:	3de080e7          	jalr	990(ra) # 5bc2 <fork>
      if(pid2 < 0){
    47ec:	00054763          	bltz	a0,47fa <reparent+0x9c>
      exit(0);
    47f0:	4501                	li	a0,0
    47f2:	00001097          	auipc	ra,0x1
    47f6:	3d8080e7          	jalr	984(ra) # 5bca <exit>
        kill(master_pid);
    47fa:	8552                	mv	a0,s4
    47fc:	00001097          	auipc	ra,0x1
    4800:	3fe080e7          	jalr	1022(ra) # 5bfa <kill>
        exit(1);
    4804:	4505                	li	a0,1
    4806:	00001097          	auipc	ra,0x1
    480a:	3c4080e7          	jalr	964(ra) # 5bca <exit>

000000000000480e <sbrkfail>:
{
    480e:	7119                	add	sp,sp,-128
    4810:	fc86                	sd	ra,120(sp)
    4812:	f8a2                	sd	s0,112(sp)
    4814:	f4a6                	sd	s1,104(sp)
    4816:	f0ca                	sd	s2,96(sp)
    4818:	ecce                	sd	s3,88(sp)
    481a:	e8d2                	sd	s4,80(sp)
    481c:	e4d6                	sd	s5,72(sp)
    481e:	0100                	add	s0,sp,128
    4820:	8aaa                	mv	s5,a0
  if(pipe(fds) != 0){
    4822:	fb040513          	add	a0,s0,-80
    4826:	00001097          	auipc	ra,0x1
    482a:	3b4080e7          	jalr	948(ra) # 5bda <pipe>
    482e:	e901                	bnez	a0,483e <sbrkfail+0x30>
    4830:	f8040493          	add	s1,s0,-128
    4834:	fa840993          	add	s3,s0,-88
    4838:	8926                	mv	s2,s1
    if(pids[i] != -1)
    483a:	5a7d                	li	s4,-1
    483c:	a085                	j	489c <sbrkfail+0x8e>
    printf("%s: pipe() failed\n", s);
    483e:	85d6                	mv	a1,s5
    4840:	00002517          	auipc	a0,0x2
    4844:	42850513          	add	a0,a0,1064 # 6c68 <updateNode+0xa04>
    4848:	00001097          	auipc	ra,0x1
    484c:	73a080e7          	jalr	1850(ra) # 5f82 <printf>
    exit(1);
    4850:	4505                	li	a0,1
    4852:	00001097          	auipc	ra,0x1
    4856:	378080e7          	jalr	888(ra) # 5bca <exit>
      sbrk(BIG - (uint64)sbrk(0));
    485a:	00001097          	auipc	ra,0x1
    485e:	3f8080e7          	jalr	1016(ra) # 5c52 <sbrk>
    4862:	064007b7          	lui	a5,0x6400
    4866:	40a7853b          	subw	a0,a5,a0
    486a:	00001097          	auipc	ra,0x1
    486e:	3e8080e7          	jalr	1000(ra) # 5c52 <sbrk>
      write(fds[1], "x", 1);
    4872:	4605                	li	a2,1
    4874:	00002597          	auipc	a1,0x2
    4878:	ad458593          	add	a1,a1,-1324 # 6348 <updateNode+0xe4>
    487c:	fb442503          	lw	a0,-76(s0)
    4880:	00001097          	auipc	ra,0x1
    4884:	36a080e7          	jalr	874(ra) # 5bea <write>
      for(;;) sleep(1000);
    4888:	3e800513          	li	a0,1000
    488c:	00001097          	auipc	ra,0x1
    4890:	3ce080e7          	jalr	974(ra) # 5c5a <sleep>
    4894:	bfd5                	j	4888 <sbrkfail+0x7a>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    4896:	0911                	add	s2,s2,4
    4898:	03390563          	beq	s2,s3,48c2 <sbrkfail+0xb4>
    if((pids[i] = fork()) == 0){
    489c:	00001097          	auipc	ra,0x1
    48a0:	326080e7          	jalr	806(ra) # 5bc2 <fork>
    48a4:	00a92023          	sw	a0,0(s2)
    48a8:	d94d                	beqz	a0,485a <sbrkfail+0x4c>
    if(pids[i] != -1)
    48aa:	ff4506e3          	beq	a0,s4,4896 <sbrkfail+0x88>
      read(fds[0], &scratch, 1);
    48ae:	4605                	li	a2,1
    48b0:	faf40593          	add	a1,s0,-81
    48b4:	fb042503          	lw	a0,-80(s0)
    48b8:	00001097          	auipc	ra,0x1
    48bc:	32a080e7          	jalr	810(ra) # 5be2 <read>
    48c0:	bfd9                	j	4896 <sbrkfail+0x88>
  c = sbrk(PGSIZE);
    48c2:	6505                	lui	a0,0x1
    48c4:	00001097          	auipc	ra,0x1
    48c8:	38e080e7          	jalr	910(ra) # 5c52 <sbrk>
    48cc:	8a2a                	mv	s4,a0
    if(pids[i] == -1)
    48ce:	597d                	li	s2,-1
    48d0:	a021                	j	48d8 <sbrkfail+0xca>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    48d2:	0491                	add	s1,s1,4
    48d4:	01348f63          	beq	s1,s3,48f2 <sbrkfail+0xe4>
    if(pids[i] == -1)
    48d8:	4088                	lw	a0,0(s1)
    48da:	ff250ce3          	beq	a0,s2,48d2 <sbrkfail+0xc4>
    kill(pids[i]);
    48de:	00001097          	auipc	ra,0x1
    48e2:	31c080e7          	jalr	796(ra) # 5bfa <kill>
    wait(0);
    48e6:	4501                	li	a0,0
    48e8:	00001097          	auipc	ra,0x1
    48ec:	2ea080e7          	jalr	746(ra) # 5bd2 <wait>
    48f0:	b7cd                	j	48d2 <sbrkfail+0xc4>
  if(c == (char*)0xffffffffffffffffL){
    48f2:	57fd                	li	a5,-1
    48f4:	04fa0163          	beq	s4,a5,4936 <sbrkfail+0x128>
  pid = fork();
    48f8:	00001097          	auipc	ra,0x1
    48fc:	2ca080e7          	jalr	714(ra) # 5bc2 <fork>
    4900:	84aa                	mv	s1,a0
  if(pid < 0){
    4902:	04054863          	bltz	a0,4952 <sbrkfail+0x144>
  if(pid == 0){
    4906:	c525                	beqz	a0,496e <sbrkfail+0x160>
  wait(&xstatus);
    4908:	fbc40513          	add	a0,s0,-68
    490c:	00001097          	auipc	ra,0x1
    4910:	2c6080e7          	jalr	710(ra) # 5bd2 <wait>
  if(xstatus != -1 && xstatus != 2)
    4914:	fbc42783          	lw	a5,-68(s0)
    4918:	577d                	li	a4,-1
    491a:	00e78563          	beq	a5,a4,4924 <sbrkfail+0x116>
    491e:	4709                	li	a4,2
    4920:	08e79d63          	bne	a5,a4,49ba <sbrkfail+0x1ac>
}
    4924:	70e6                	ld	ra,120(sp)
    4926:	7446                	ld	s0,112(sp)
    4928:	74a6                	ld	s1,104(sp)
    492a:	7906                	ld	s2,96(sp)
    492c:	69e6                	ld	s3,88(sp)
    492e:	6a46                	ld	s4,80(sp)
    4930:	6aa6                	ld	s5,72(sp)
    4932:	6109                	add	sp,sp,128
    4934:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    4936:	85d6                	mv	a1,s5
    4938:	00003517          	auipc	a0,0x3
    493c:	58850513          	add	a0,a0,1416 # 7ec0 <updateNode+0x1c5c>
    4940:	00001097          	auipc	ra,0x1
    4944:	642080e7          	jalr	1602(ra) # 5f82 <printf>
    exit(1);
    4948:	4505                	li	a0,1
    494a:	00001097          	auipc	ra,0x1
    494e:	280080e7          	jalr	640(ra) # 5bca <exit>
    printf("%s: fork failed\n", s);
    4952:	85d6                	mv	a1,s5
    4954:	00002517          	auipc	a0,0x2
    4958:	20c50513          	add	a0,a0,524 # 6b60 <updateNode+0x8fc>
    495c:	00001097          	auipc	ra,0x1
    4960:	626080e7          	jalr	1574(ra) # 5f82 <printf>
    exit(1);
    4964:	4505                	li	a0,1
    4966:	00001097          	auipc	ra,0x1
    496a:	264080e7          	jalr	612(ra) # 5bca <exit>
    a = sbrk(0);
    496e:	4501                	li	a0,0
    4970:	00001097          	auipc	ra,0x1
    4974:	2e2080e7          	jalr	738(ra) # 5c52 <sbrk>
    4978:	892a                	mv	s2,a0
    sbrk(10*BIG);
    497a:	3e800537          	lui	a0,0x3e800
    497e:	00001097          	auipc	ra,0x1
    4982:	2d4080e7          	jalr	724(ra) # 5c52 <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    4986:	87ca                	mv	a5,s2
    4988:	3e800737          	lui	a4,0x3e800
    498c:	993a                	add	s2,s2,a4
    498e:	6705                	lui	a4,0x1
      n += *(a+i);
    4990:	0007c683          	lbu	a3,0(a5) # 6400000 <base+0x63f0388>
    4994:	9cb5                	addw	s1,s1,a3
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    4996:	97ba                	add	a5,a5,a4
    4998:	ff279ce3          	bne	a5,s2,4990 <sbrkfail+0x182>
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    499c:	8626                	mv	a2,s1
    499e:	85d6                	mv	a1,s5
    49a0:	00003517          	auipc	a0,0x3
    49a4:	54050513          	add	a0,a0,1344 # 7ee0 <updateNode+0x1c7c>
    49a8:	00001097          	auipc	ra,0x1
    49ac:	5da080e7          	jalr	1498(ra) # 5f82 <printf>
    exit(1);
    49b0:	4505                	li	a0,1
    49b2:	00001097          	auipc	ra,0x1
    49b6:	218080e7          	jalr	536(ra) # 5bca <exit>
    exit(1);
    49ba:	4505                	li	a0,1
    49bc:	00001097          	auipc	ra,0x1
    49c0:	20e080e7          	jalr	526(ra) # 5bca <exit>

00000000000049c4 <mem>:
{
    49c4:	7139                	add	sp,sp,-64
    49c6:	fc06                	sd	ra,56(sp)
    49c8:	f822                	sd	s0,48(sp)
    49ca:	f426                	sd	s1,40(sp)
    49cc:	f04a                	sd	s2,32(sp)
    49ce:	ec4e                	sd	s3,24(sp)
    49d0:	0080                	add	s0,sp,64
    49d2:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    49d4:	00001097          	auipc	ra,0x1
    49d8:	1ee080e7          	jalr	494(ra) # 5bc2 <fork>
    m1 = 0;
    49dc:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    49de:	6909                	lui	s2,0x2
    49e0:	71190913          	add	s2,s2,1809 # 2711 <copyinstr3+0x107>
  if((pid = fork()) == 0){
    49e4:	c115                	beqz	a0,4a08 <mem+0x44>
    wait(&xstatus);
    49e6:	fcc40513          	add	a0,s0,-52
    49ea:	00001097          	auipc	ra,0x1
    49ee:	1e8080e7          	jalr	488(ra) # 5bd2 <wait>
    if(xstatus == -1){
    49f2:	fcc42503          	lw	a0,-52(s0)
    49f6:	57fd                	li	a5,-1
    49f8:	06f50363          	beq	a0,a5,4a5e <mem+0x9a>
    exit(xstatus);
    49fc:	00001097          	auipc	ra,0x1
    4a00:	1ce080e7          	jalr	462(ra) # 5bca <exit>
      *(char**)m2 = m1;
    4a04:	e104                	sd	s1,0(a0)
      m1 = m2;
    4a06:	84aa                	mv	s1,a0
    while((m2 = malloc(10001)) != 0){
    4a08:	854a                	mv	a0,s2
    4a0a:	00001097          	auipc	ra,0x1
    4a0e:	630080e7          	jalr	1584(ra) # 603a <malloc>
    4a12:	f96d                	bnez	a0,4a04 <mem+0x40>
    while(m1){
    4a14:	c881                	beqz	s1,4a24 <mem+0x60>
      m2 = *(char**)m1;
    4a16:	8526                	mv	a0,s1
    4a18:	6084                	ld	s1,0(s1)
      free(m1);
    4a1a:	00001097          	auipc	ra,0x1
    4a1e:	59e080e7          	jalr	1438(ra) # 5fb8 <free>
    while(m1){
    4a22:	f8f5                	bnez	s1,4a16 <mem+0x52>
    m1 = malloc(1024*20);
    4a24:	6515                	lui	a0,0x5
    4a26:	00001097          	auipc	ra,0x1
    4a2a:	614080e7          	jalr	1556(ra) # 603a <malloc>
    if(m1 == 0){
    4a2e:	c911                	beqz	a0,4a42 <mem+0x7e>
    free(m1);
    4a30:	00001097          	auipc	ra,0x1
    4a34:	588080e7          	jalr	1416(ra) # 5fb8 <free>
    exit(0);
    4a38:	4501                	li	a0,0
    4a3a:	00001097          	auipc	ra,0x1
    4a3e:	190080e7          	jalr	400(ra) # 5bca <exit>
      printf("couldn't allocate mem?!!\n", s);
    4a42:	85ce                	mv	a1,s3
    4a44:	00003517          	auipc	a0,0x3
    4a48:	4cc50513          	add	a0,a0,1228 # 7f10 <updateNode+0x1cac>
    4a4c:	00001097          	auipc	ra,0x1
    4a50:	536080e7          	jalr	1334(ra) # 5f82 <printf>
      exit(1);
    4a54:	4505                	li	a0,1
    4a56:	00001097          	auipc	ra,0x1
    4a5a:	174080e7          	jalr	372(ra) # 5bca <exit>
      exit(0);
    4a5e:	4501                	li	a0,0
    4a60:	00001097          	auipc	ra,0x1
    4a64:	16a080e7          	jalr	362(ra) # 5bca <exit>

0000000000004a68 <sharedfd>:
{
    4a68:	7159                	add	sp,sp,-112
    4a6a:	f486                	sd	ra,104(sp)
    4a6c:	f0a2                	sd	s0,96(sp)
    4a6e:	eca6                	sd	s1,88(sp)
    4a70:	e8ca                	sd	s2,80(sp)
    4a72:	e4ce                	sd	s3,72(sp)
    4a74:	e0d2                	sd	s4,64(sp)
    4a76:	fc56                	sd	s5,56(sp)
    4a78:	f85a                	sd	s6,48(sp)
    4a7a:	f45e                	sd	s7,40(sp)
    4a7c:	1880                	add	s0,sp,112
    4a7e:	8a2a                	mv	s4,a0
  unlink("sharedfd");
    4a80:	00003517          	auipc	a0,0x3
    4a84:	4b050513          	add	a0,a0,1200 # 7f30 <updateNode+0x1ccc>
    4a88:	00001097          	auipc	ra,0x1
    4a8c:	192080e7          	jalr	402(ra) # 5c1a <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    4a90:	20200593          	li	a1,514
    4a94:	00003517          	auipc	a0,0x3
    4a98:	49c50513          	add	a0,a0,1180 # 7f30 <updateNode+0x1ccc>
    4a9c:	00001097          	auipc	ra,0x1
    4aa0:	16e080e7          	jalr	366(ra) # 5c0a <open>
  if(fd < 0){
    4aa4:	04054a63          	bltz	a0,4af8 <sharedfd+0x90>
    4aa8:	892a                	mv	s2,a0
  pid = fork();
    4aaa:	00001097          	auipc	ra,0x1
    4aae:	118080e7          	jalr	280(ra) # 5bc2 <fork>
    4ab2:	89aa                	mv	s3,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    4ab4:	07000593          	li	a1,112
    4ab8:	e119                	bnez	a0,4abe <sharedfd+0x56>
    4aba:	06300593          	li	a1,99
    4abe:	4629                	li	a2,10
    4ac0:	fa040513          	add	a0,s0,-96
    4ac4:	00001097          	auipc	ra,0x1
    4ac8:	ed0080e7          	jalr	-304(ra) # 5994 <memset>
    4acc:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    4ad0:	4629                	li	a2,10
    4ad2:	fa040593          	add	a1,s0,-96
    4ad6:	854a                	mv	a0,s2
    4ad8:	00001097          	auipc	ra,0x1
    4adc:	112080e7          	jalr	274(ra) # 5bea <write>
    4ae0:	47a9                	li	a5,10
    4ae2:	02f51963          	bne	a0,a5,4b14 <sharedfd+0xac>
  for(i = 0; i < N; i++){
    4ae6:	34fd                	addw	s1,s1,-1
    4ae8:	f4e5                	bnez	s1,4ad0 <sharedfd+0x68>
  if(pid == 0) {
    4aea:	04099363          	bnez	s3,4b30 <sharedfd+0xc8>
    exit(0);
    4aee:	4501                	li	a0,0
    4af0:	00001097          	auipc	ra,0x1
    4af4:	0da080e7          	jalr	218(ra) # 5bca <exit>
    printf("%s: cannot open sharedfd for writing", s);
    4af8:	85d2                	mv	a1,s4
    4afa:	00003517          	auipc	a0,0x3
    4afe:	44650513          	add	a0,a0,1094 # 7f40 <updateNode+0x1cdc>
    4b02:	00001097          	auipc	ra,0x1
    4b06:	480080e7          	jalr	1152(ra) # 5f82 <printf>
    exit(1);
    4b0a:	4505                	li	a0,1
    4b0c:	00001097          	auipc	ra,0x1
    4b10:	0be080e7          	jalr	190(ra) # 5bca <exit>
      printf("%s: write sharedfd failed\n", s);
    4b14:	85d2                	mv	a1,s4
    4b16:	00003517          	auipc	a0,0x3
    4b1a:	45250513          	add	a0,a0,1106 # 7f68 <updateNode+0x1d04>
    4b1e:	00001097          	auipc	ra,0x1
    4b22:	464080e7          	jalr	1124(ra) # 5f82 <printf>
      exit(1);
    4b26:	4505                	li	a0,1
    4b28:	00001097          	auipc	ra,0x1
    4b2c:	0a2080e7          	jalr	162(ra) # 5bca <exit>
    wait(&xstatus);
    4b30:	f9c40513          	add	a0,s0,-100
    4b34:	00001097          	auipc	ra,0x1
    4b38:	09e080e7          	jalr	158(ra) # 5bd2 <wait>
    if(xstatus != 0)
    4b3c:	f9c42983          	lw	s3,-100(s0)
    4b40:	00098763          	beqz	s3,4b4e <sharedfd+0xe6>
      exit(xstatus);
    4b44:	854e                	mv	a0,s3
    4b46:	00001097          	auipc	ra,0x1
    4b4a:	084080e7          	jalr	132(ra) # 5bca <exit>
  close(fd);
    4b4e:	854a                	mv	a0,s2
    4b50:	00001097          	auipc	ra,0x1
    4b54:	0a2080e7          	jalr	162(ra) # 5bf2 <close>
  fd = open("sharedfd", 0);
    4b58:	4581                	li	a1,0
    4b5a:	00003517          	auipc	a0,0x3
    4b5e:	3d650513          	add	a0,a0,982 # 7f30 <updateNode+0x1ccc>
    4b62:	00001097          	auipc	ra,0x1
    4b66:	0a8080e7          	jalr	168(ra) # 5c0a <open>
    4b6a:	8baa                	mv	s7,a0
  nc = np = 0;
    4b6c:	8ace                	mv	s5,s3
  if(fd < 0){
    4b6e:	02054563          	bltz	a0,4b98 <sharedfd+0x130>
    4b72:	faa40913          	add	s2,s0,-86
      if(buf[i] == 'c')
    4b76:	06300493          	li	s1,99
      if(buf[i] == 'p')
    4b7a:	07000b13          	li	s6,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    4b7e:	4629                	li	a2,10
    4b80:	fa040593          	add	a1,s0,-96
    4b84:	855e                	mv	a0,s7
    4b86:	00001097          	auipc	ra,0x1
    4b8a:	05c080e7          	jalr	92(ra) # 5be2 <read>
    4b8e:	02a05f63          	blez	a0,4bcc <sharedfd+0x164>
    4b92:	fa040793          	add	a5,s0,-96
    4b96:	a01d                	j	4bbc <sharedfd+0x154>
    printf("%s: cannot open sharedfd for reading\n", s);
    4b98:	85d2                	mv	a1,s4
    4b9a:	00003517          	auipc	a0,0x3
    4b9e:	3ee50513          	add	a0,a0,1006 # 7f88 <updateNode+0x1d24>
    4ba2:	00001097          	auipc	ra,0x1
    4ba6:	3e0080e7          	jalr	992(ra) # 5f82 <printf>
    exit(1);
    4baa:	4505                	li	a0,1
    4bac:	00001097          	auipc	ra,0x1
    4bb0:	01e080e7          	jalr	30(ra) # 5bca <exit>
        nc++;
    4bb4:	2985                	addw	s3,s3,1
    for(i = 0; i < sizeof(buf); i++){
    4bb6:	0785                	add	a5,a5,1
    4bb8:	fd2783e3          	beq	a5,s2,4b7e <sharedfd+0x116>
      if(buf[i] == 'c')
    4bbc:	0007c703          	lbu	a4,0(a5)
    4bc0:	fe970ae3          	beq	a4,s1,4bb4 <sharedfd+0x14c>
      if(buf[i] == 'p')
    4bc4:	ff6719e3          	bne	a4,s6,4bb6 <sharedfd+0x14e>
        np++;
    4bc8:	2a85                	addw	s5,s5,1
    4bca:	b7f5                	j	4bb6 <sharedfd+0x14e>
  close(fd);
    4bcc:	855e                	mv	a0,s7
    4bce:	00001097          	auipc	ra,0x1
    4bd2:	024080e7          	jalr	36(ra) # 5bf2 <close>
  unlink("sharedfd");
    4bd6:	00003517          	auipc	a0,0x3
    4bda:	35a50513          	add	a0,a0,858 # 7f30 <updateNode+0x1ccc>
    4bde:	00001097          	auipc	ra,0x1
    4be2:	03c080e7          	jalr	60(ra) # 5c1a <unlink>
  if(nc == N*SZ && np == N*SZ){
    4be6:	6789                	lui	a5,0x2
    4be8:	71078793          	add	a5,a5,1808 # 2710 <copyinstr3+0x106>
    4bec:	00f99763          	bne	s3,a5,4bfa <sharedfd+0x192>
    4bf0:	6789                	lui	a5,0x2
    4bf2:	71078793          	add	a5,a5,1808 # 2710 <copyinstr3+0x106>
    4bf6:	02fa8063          	beq	s5,a5,4c16 <sharedfd+0x1ae>
    printf("%s: nc/np test fails\n", s);
    4bfa:	85d2                	mv	a1,s4
    4bfc:	00003517          	auipc	a0,0x3
    4c00:	3b450513          	add	a0,a0,948 # 7fb0 <updateNode+0x1d4c>
    4c04:	00001097          	auipc	ra,0x1
    4c08:	37e080e7          	jalr	894(ra) # 5f82 <printf>
    exit(1);
    4c0c:	4505                	li	a0,1
    4c0e:	00001097          	auipc	ra,0x1
    4c12:	fbc080e7          	jalr	-68(ra) # 5bca <exit>
    exit(0);
    4c16:	4501                	li	a0,0
    4c18:	00001097          	auipc	ra,0x1
    4c1c:	fb2080e7          	jalr	-78(ra) # 5bca <exit>

0000000000004c20 <fourfiles>:
{
    4c20:	7135                	add	sp,sp,-160
    4c22:	ed06                	sd	ra,152(sp)
    4c24:	e922                	sd	s0,144(sp)
    4c26:	e526                	sd	s1,136(sp)
    4c28:	e14a                	sd	s2,128(sp)
    4c2a:	fcce                	sd	s3,120(sp)
    4c2c:	f8d2                	sd	s4,112(sp)
    4c2e:	f4d6                	sd	s5,104(sp)
    4c30:	f0da                	sd	s6,96(sp)
    4c32:	ecde                	sd	s7,88(sp)
    4c34:	e8e2                	sd	s8,80(sp)
    4c36:	e4e6                	sd	s9,72(sp)
    4c38:	e0ea                	sd	s10,64(sp)
    4c3a:	fc6e                	sd	s11,56(sp)
    4c3c:	1100                	add	s0,sp,160
    4c3e:	8caa                	mv	s9,a0
  char *names[] = { "f0", "f1", "f2", "f3" };
    4c40:	00003797          	auipc	a5,0x3
    4c44:	38878793          	add	a5,a5,904 # 7fc8 <updateNode+0x1d64>
    4c48:	f6f43823          	sd	a5,-144(s0)
    4c4c:	00003797          	auipc	a5,0x3
    4c50:	38478793          	add	a5,a5,900 # 7fd0 <updateNode+0x1d6c>
    4c54:	f6f43c23          	sd	a5,-136(s0)
    4c58:	00003797          	auipc	a5,0x3
    4c5c:	38078793          	add	a5,a5,896 # 7fd8 <updateNode+0x1d74>
    4c60:	f8f43023          	sd	a5,-128(s0)
    4c64:	00003797          	auipc	a5,0x3
    4c68:	37c78793          	add	a5,a5,892 # 7fe0 <updateNode+0x1d7c>
    4c6c:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    4c70:	f7040b93          	add	s7,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    4c74:	895e                	mv	s2,s7
  for(pi = 0; pi < NCHILD; pi++){
    4c76:	4481                	li	s1,0
    4c78:	4a11                	li	s4,4
    fname = names[pi];
    4c7a:	00093983          	ld	s3,0(s2)
    unlink(fname);
    4c7e:	854e                	mv	a0,s3
    4c80:	00001097          	auipc	ra,0x1
    4c84:	f9a080e7          	jalr	-102(ra) # 5c1a <unlink>
    pid = fork();
    4c88:	00001097          	auipc	ra,0x1
    4c8c:	f3a080e7          	jalr	-198(ra) # 5bc2 <fork>
    if(pid < 0){
    4c90:	04054063          	bltz	a0,4cd0 <fourfiles+0xb0>
    if(pid == 0){
    4c94:	cd21                	beqz	a0,4cec <fourfiles+0xcc>
  for(pi = 0; pi < NCHILD; pi++){
    4c96:	2485                	addw	s1,s1,1
    4c98:	0921                	add	s2,s2,8
    4c9a:	ff4490e3          	bne	s1,s4,4c7a <fourfiles+0x5a>
    4c9e:	4491                	li	s1,4
    wait(&xstatus);
    4ca0:	f6c40513          	add	a0,s0,-148
    4ca4:	00001097          	auipc	ra,0x1
    4ca8:	f2e080e7          	jalr	-210(ra) # 5bd2 <wait>
    if(xstatus != 0)
    4cac:	f6c42a83          	lw	s5,-148(s0)
    4cb0:	0c0a9863          	bnez	s5,4d80 <fourfiles+0x160>
  for(pi = 0; pi < NCHILD; pi++){
    4cb4:	34fd                	addw	s1,s1,-1
    4cb6:	f4ed                	bnez	s1,4ca0 <fourfiles+0x80>
    4cb8:	03000b13          	li	s6,48
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4cbc:	00008a17          	auipc	s4,0x8
    4cc0:	fbca0a13          	add	s4,s4,-68 # cc78 <buf>
    if(total != N*SZ){
    4cc4:	6d05                	lui	s10,0x1
    4cc6:	770d0d13          	add	s10,s10,1904 # 1770 <exectest+0x30>
  for(i = 0; i < NCHILD; i++){
    4cca:	03400d93          	li	s11,52
    4cce:	a22d                	j	4df8 <fourfiles+0x1d8>
      printf("fork failed\n", s);
    4cd0:	85e6                	mv	a1,s9
    4cd2:	00002517          	auipc	a0,0x2
    4cd6:	29650513          	add	a0,a0,662 # 6f68 <updateNode+0xd04>
    4cda:	00001097          	auipc	ra,0x1
    4cde:	2a8080e7          	jalr	680(ra) # 5f82 <printf>
      exit(1);
    4ce2:	4505                	li	a0,1
    4ce4:	00001097          	auipc	ra,0x1
    4ce8:	ee6080e7          	jalr	-282(ra) # 5bca <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    4cec:	20200593          	li	a1,514
    4cf0:	854e                	mv	a0,s3
    4cf2:	00001097          	auipc	ra,0x1
    4cf6:	f18080e7          	jalr	-232(ra) # 5c0a <open>
    4cfa:	892a                	mv	s2,a0
      if(fd < 0){
    4cfc:	04054763          	bltz	a0,4d4a <fourfiles+0x12a>
      memset(buf, '0'+pi, SZ);
    4d00:	1f400613          	li	a2,500
    4d04:	0304859b          	addw	a1,s1,48
    4d08:	00008517          	auipc	a0,0x8
    4d0c:	f7050513          	add	a0,a0,-144 # cc78 <buf>
    4d10:	00001097          	auipc	ra,0x1
    4d14:	c84080e7          	jalr	-892(ra) # 5994 <memset>
    4d18:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    4d1a:	00008997          	auipc	s3,0x8
    4d1e:	f5e98993          	add	s3,s3,-162 # cc78 <buf>
    4d22:	1f400613          	li	a2,500
    4d26:	85ce                	mv	a1,s3
    4d28:	854a                	mv	a0,s2
    4d2a:	00001097          	auipc	ra,0x1
    4d2e:	ec0080e7          	jalr	-320(ra) # 5bea <write>
    4d32:	85aa                	mv	a1,a0
    4d34:	1f400793          	li	a5,500
    4d38:	02f51763          	bne	a0,a5,4d66 <fourfiles+0x146>
      for(i = 0; i < N; i++){
    4d3c:	34fd                	addw	s1,s1,-1
    4d3e:	f0f5                	bnez	s1,4d22 <fourfiles+0x102>
      exit(0);
    4d40:	4501                	li	a0,0
    4d42:	00001097          	auipc	ra,0x1
    4d46:	e88080e7          	jalr	-376(ra) # 5bca <exit>
        printf("create failed\n", s);
    4d4a:	85e6                	mv	a1,s9
    4d4c:	00003517          	auipc	a0,0x3
    4d50:	29c50513          	add	a0,a0,668 # 7fe8 <updateNode+0x1d84>
    4d54:	00001097          	auipc	ra,0x1
    4d58:	22e080e7          	jalr	558(ra) # 5f82 <printf>
        exit(1);
    4d5c:	4505                	li	a0,1
    4d5e:	00001097          	auipc	ra,0x1
    4d62:	e6c080e7          	jalr	-404(ra) # 5bca <exit>
          printf("write failed %d\n", n);
    4d66:	00003517          	auipc	a0,0x3
    4d6a:	29250513          	add	a0,a0,658 # 7ff8 <updateNode+0x1d94>
    4d6e:	00001097          	auipc	ra,0x1
    4d72:	214080e7          	jalr	532(ra) # 5f82 <printf>
          exit(1);
    4d76:	4505                	li	a0,1
    4d78:	00001097          	auipc	ra,0x1
    4d7c:	e52080e7          	jalr	-430(ra) # 5bca <exit>
      exit(xstatus);
    4d80:	8556                	mv	a0,s5
    4d82:	00001097          	auipc	ra,0x1
    4d86:	e48080e7          	jalr	-440(ra) # 5bca <exit>
          printf("wrong char\n", s);
    4d8a:	85e6                	mv	a1,s9
    4d8c:	00003517          	auipc	a0,0x3
    4d90:	28450513          	add	a0,a0,644 # 8010 <updateNode+0x1dac>
    4d94:	00001097          	auipc	ra,0x1
    4d98:	1ee080e7          	jalr	494(ra) # 5f82 <printf>
          exit(1);
    4d9c:	4505                	li	a0,1
    4d9e:	00001097          	auipc	ra,0x1
    4da2:	e2c080e7          	jalr	-468(ra) # 5bca <exit>
      total += n;
    4da6:	00a9093b          	addw	s2,s2,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4daa:	660d                	lui	a2,0x3
    4dac:	85d2                	mv	a1,s4
    4dae:	854e                	mv	a0,s3
    4db0:	00001097          	auipc	ra,0x1
    4db4:	e32080e7          	jalr	-462(ra) # 5be2 <read>
    4db8:	02a05063          	blez	a0,4dd8 <fourfiles+0x1b8>
    4dbc:	00008797          	auipc	a5,0x8
    4dc0:	ebc78793          	add	a5,a5,-324 # cc78 <buf>
    4dc4:	00f506b3          	add	a3,a0,a5
        if(buf[j] != '0'+i){
    4dc8:	0007c703          	lbu	a4,0(a5)
    4dcc:	fa971fe3          	bne	a4,s1,4d8a <fourfiles+0x16a>
      for(j = 0; j < n; j++){
    4dd0:	0785                	add	a5,a5,1
    4dd2:	fed79be3          	bne	a5,a3,4dc8 <fourfiles+0x1a8>
    4dd6:	bfc1                	j	4da6 <fourfiles+0x186>
    close(fd);
    4dd8:	854e                	mv	a0,s3
    4dda:	00001097          	auipc	ra,0x1
    4dde:	e18080e7          	jalr	-488(ra) # 5bf2 <close>
    if(total != N*SZ){
    4de2:	03a91863          	bne	s2,s10,4e12 <fourfiles+0x1f2>
    unlink(fname);
    4de6:	8562                	mv	a0,s8
    4de8:	00001097          	auipc	ra,0x1
    4dec:	e32080e7          	jalr	-462(ra) # 5c1a <unlink>
  for(i = 0; i < NCHILD; i++){
    4df0:	0ba1                	add	s7,s7,8
    4df2:	2b05                	addw	s6,s6,1
    4df4:	03bb0d63          	beq	s6,s11,4e2e <fourfiles+0x20e>
    fname = names[i];
    4df8:	000bbc03          	ld	s8,0(s7)
    fd = open(fname, 0);
    4dfc:	4581                	li	a1,0
    4dfe:	8562                	mv	a0,s8
    4e00:	00001097          	auipc	ra,0x1
    4e04:	e0a080e7          	jalr	-502(ra) # 5c0a <open>
    4e08:	89aa                	mv	s3,a0
    total = 0;
    4e0a:	8956                	mv	s2,s5
        if(buf[j] != '0'+i){
    4e0c:	000b049b          	sext.w	s1,s6
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4e10:	bf69                	j	4daa <fourfiles+0x18a>
      printf("wrong length %d\n", total);
    4e12:	85ca                	mv	a1,s2
    4e14:	00003517          	auipc	a0,0x3
    4e18:	20c50513          	add	a0,a0,524 # 8020 <updateNode+0x1dbc>
    4e1c:	00001097          	auipc	ra,0x1
    4e20:	166080e7          	jalr	358(ra) # 5f82 <printf>
      exit(1);
    4e24:	4505                	li	a0,1
    4e26:	00001097          	auipc	ra,0x1
    4e2a:	da4080e7          	jalr	-604(ra) # 5bca <exit>
}
    4e2e:	60ea                	ld	ra,152(sp)
    4e30:	644a                	ld	s0,144(sp)
    4e32:	64aa                	ld	s1,136(sp)
    4e34:	690a                	ld	s2,128(sp)
    4e36:	79e6                	ld	s3,120(sp)
    4e38:	7a46                	ld	s4,112(sp)
    4e3a:	7aa6                	ld	s5,104(sp)
    4e3c:	7b06                	ld	s6,96(sp)
    4e3e:	6be6                	ld	s7,88(sp)
    4e40:	6c46                	ld	s8,80(sp)
    4e42:	6ca6                	ld	s9,72(sp)
    4e44:	6d06                	ld	s10,64(sp)
    4e46:	7de2                	ld	s11,56(sp)
    4e48:	610d                	add	sp,sp,160
    4e4a:	8082                	ret

0000000000004e4c <concreate>:
{
    4e4c:	7135                	add	sp,sp,-160
    4e4e:	ed06                	sd	ra,152(sp)
    4e50:	e922                	sd	s0,144(sp)
    4e52:	e526                	sd	s1,136(sp)
    4e54:	e14a                	sd	s2,128(sp)
    4e56:	fcce                	sd	s3,120(sp)
    4e58:	f8d2                	sd	s4,112(sp)
    4e5a:	f4d6                	sd	s5,104(sp)
    4e5c:	f0da                	sd	s6,96(sp)
    4e5e:	ecde                	sd	s7,88(sp)
    4e60:	1100                	add	s0,sp,160
    4e62:	89aa                	mv	s3,a0
  file[0] = 'C';
    4e64:	04300793          	li	a5,67
    4e68:	faf40423          	sb	a5,-88(s0)
  file[2] = '\0';
    4e6c:	fa040523          	sb	zero,-86(s0)
  for(i = 0; i < N; i++){
    4e70:	4901                	li	s2,0
    if(pid && (i % 3) == 1){
    4e72:	4b0d                	li	s6,3
    4e74:	4a85                	li	s5,1
      link("C0", file);
    4e76:	00003b97          	auipc	s7,0x3
    4e7a:	1c2b8b93          	add	s7,s7,450 # 8038 <updateNode+0x1dd4>
  for(i = 0; i < N; i++){
    4e7e:	02800a13          	li	s4,40
    4e82:	acc9                	j	5154 <concreate+0x308>
      link("C0", file);
    4e84:	fa840593          	add	a1,s0,-88
    4e88:	855e                	mv	a0,s7
    4e8a:	00001097          	auipc	ra,0x1
    4e8e:	da0080e7          	jalr	-608(ra) # 5c2a <link>
    if(pid == 0) {
    4e92:	a465                	j	513a <concreate+0x2ee>
    } else if(pid == 0 && (i % 5) == 1){
    4e94:	4795                	li	a5,5
    4e96:	02f9693b          	remw	s2,s2,a5
    4e9a:	4785                	li	a5,1
    4e9c:	02f90b63          	beq	s2,a5,4ed2 <concreate+0x86>
      fd = open(file, O_CREATE | O_RDWR);
    4ea0:	20200593          	li	a1,514
    4ea4:	fa840513          	add	a0,s0,-88
    4ea8:	00001097          	auipc	ra,0x1
    4eac:	d62080e7          	jalr	-670(ra) # 5c0a <open>
      if(fd < 0){
    4eb0:	26055c63          	bgez	a0,5128 <concreate+0x2dc>
        printf("concreate create %s failed\n", file);
    4eb4:	fa840593          	add	a1,s0,-88
    4eb8:	00003517          	auipc	a0,0x3
    4ebc:	18850513          	add	a0,a0,392 # 8040 <updateNode+0x1ddc>
    4ec0:	00001097          	auipc	ra,0x1
    4ec4:	0c2080e7          	jalr	194(ra) # 5f82 <printf>
        exit(1);
    4ec8:	4505                	li	a0,1
    4eca:	00001097          	auipc	ra,0x1
    4ece:	d00080e7          	jalr	-768(ra) # 5bca <exit>
      link("C0", file);
    4ed2:	fa840593          	add	a1,s0,-88
    4ed6:	00003517          	auipc	a0,0x3
    4eda:	16250513          	add	a0,a0,354 # 8038 <updateNode+0x1dd4>
    4ede:	00001097          	auipc	ra,0x1
    4ee2:	d4c080e7          	jalr	-692(ra) # 5c2a <link>
      exit(0);
    4ee6:	4501                	li	a0,0
    4ee8:	00001097          	auipc	ra,0x1
    4eec:	ce2080e7          	jalr	-798(ra) # 5bca <exit>
        exit(1);
    4ef0:	4505                	li	a0,1
    4ef2:	00001097          	auipc	ra,0x1
    4ef6:	cd8080e7          	jalr	-808(ra) # 5bca <exit>
  memset(fa, 0, sizeof(fa));
    4efa:	02800613          	li	a2,40
    4efe:	4581                	li	a1,0
    4f00:	f8040513          	add	a0,s0,-128
    4f04:	00001097          	auipc	ra,0x1
    4f08:	a90080e7          	jalr	-1392(ra) # 5994 <memset>
  fd = open(".", 0);
    4f0c:	4581                	li	a1,0
    4f0e:	00002517          	auipc	a0,0x2
    4f12:	ab250513          	add	a0,a0,-1358 # 69c0 <updateNode+0x75c>
    4f16:	00001097          	auipc	ra,0x1
    4f1a:	cf4080e7          	jalr	-780(ra) # 5c0a <open>
    4f1e:	892a                	mv	s2,a0
  n = 0;
    4f20:	8aa6                	mv	s5,s1
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4f22:	04300a13          	li	s4,67
      if(i < 0 || i >= sizeof(fa)){
    4f26:	02700b13          	li	s6,39
      fa[i] = 1;
    4f2a:	4b85                	li	s7,1
  while(read(fd, &de, sizeof(de)) > 0){
    4f2c:	4641                	li	a2,16
    4f2e:	f7040593          	add	a1,s0,-144
    4f32:	854a                	mv	a0,s2
    4f34:	00001097          	auipc	ra,0x1
    4f38:	cae080e7          	jalr	-850(ra) # 5be2 <read>
    4f3c:	08a05263          	blez	a0,4fc0 <concreate+0x174>
    if(de.inum == 0)
    4f40:	f7045783          	lhu	a5,-144(s0)
    4f44:	d7e5                	beqz	a5,4f2c <concreate+0xe0>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4f46:	f7244783          	lbu	a5,-142(s0)
    4f4a:	ff4791e3          	bne	a5,s4,4f2c <concreate+0xe0>
    4f4e:	f7444783          	lbu	a5,-140(s0)
    4f52:	ffe9                	bnez	a5,4f2c <concreate+0xe0>
      i = de.name[1] - '0';
    4f54:	f7344783          	lbu	a5,-141(s0)
    4f58:	fd07879b          	addw	a5,a5,-48
    4f5c:	0007871b          	sext.w	a4,a5
      if(i < 0 || i >= sizeof(fa)){
    4f60:	02eb6063          	bltu	s6,a4,4f80 <concreate+0x134>
      if(fa[i]){
    4f64:	fb070793          	add	a5,a4,-80 # fb0 <linktest+0xbc>
    4f68:	97a2                	add	a5,a5,s0
    4f6a:	fd07c783          	lbu	a5,-48(a5)
    4f6e:	eb8d                	bnez	a5,4fa0 <concreate+0x154>
      fa[i] = 1;
    4f70:	fb070793          	add	a5,a4,-80
    4f74:	00878733          	add	a4,a5,s0
    4f78:	fd770823          	sb	s7,-48(a4)
      n++;
    4f7c:	2a85                	addw	s5,s5,1
    4f7e:	b77d                	j	4f2c <concreate+0xe0>
        printf("%s: concreate weird file %s\n", s, de.name);
    4f80:	f7240613          	add	a2,s0,-142
    4f84:	85ce                	mv	a1,s3
    4f86:	00003517          	auipc	a0,0x3
    4f8a:	0da50513          	add	a0,a0,218 # 8060 <updateNode+0x1dfc>
    4f8e:	00001097          	auipc	ra,0x1
    4f92:	ff4080e7          	jalr	-12(ra) # 5f82 <printf>
        exit(1);
    4f96:	4505                	li	a0,1
    4f98:	00001097          	auipc	ra,0x1
    4f9c:	c32080e7          	jalr	-974(ra) # 5bca <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    4fa0:	f7240613          	add	a2,s0,-142
    4fa4:	85ce                	mv	a1,s3
    4fa6:	00003517          	auipc	a0,0x3
    4faa:	0da50513          	add	a0,a0,218 # 8080 <updateNode+0x1e1c>
    4fae:	00001097          	auipc	ra,0x1
    4fb2:	fd4080e7          	jalr	-44(ra) # 5f82 <printf>
        exit(1);
    4fb6:	4505                	li	a0,1
    4fb8:	00001097          	auipc	ra,0x1
    4fbc:	c12080e7          	jalr	-1006(ra) # 5bca <exit>
  close(fd);
    4fc0:	854a                	mv	a0,s2
    4fc2:	00001097          	auipc	ra,0x1
    4fc6:	c30080e7          	jalr	-976(ra) # 5bf2 <close>
  if(n != N){
    4fca:	02800793          	li	a5,40
    4fce:	00fa9763          	bne	s5,a5,4fdc <concreate+0x190>
    if(((i % 3) == 0 && pid == 0) ||
    4fd2:	4a8d                	li	s5,3
    4fd4:	4b05                	li	s6,1
  for(i = 0; i < N; i++){
    4fd6:	02800a13          	li	s4,40
    4fda:	a8c9                	j	50ac <concreate+0x260>
    printf("%s: concreate not enough files in directory listing\n", s);
    4fdc:	85ce                	mv	a1,s3
    4fde:	00003517          	auipc	a0,0x3
    4fe2:	0ca50513          	add	a0,a0,202 # 80a8 <updateNode+0x1e44>
    4fe6:	00001097          	auipc	ra,0x1
    4fea:	f9c080e7          	jalr	-100(ra) # 5f82 <printf>
    exit(1);
    4fee:	4505                	li	a0,1
    4ff0:	00001097          	auipc	ra,0x1
    4ff4:	bda080e7          	jalr	-1062(ra) # 5bca <exit>
      printf("%s: fork failed\n", s);
    4ff8:	85ce                	mv	a1,s3
    4ffa:	00002517          	auipc	a0,0x2
    4ffe:	b6650513          	add	a0,a0,-1178 # 6b60 <updateNode+0x8fc>
    5002:	00001097          	auipc	ra,0x1
    5006:	f80080e7          	jalr	-128(ra) # 5f82 <printf>
      exit(1);
    500a:	4505                	li	a0,1
    500c:	00001097          	auipc	ra,0x1
    5010:	bbe080e7          	jalr	-1090(ra) # 5bca <exit>
      close(open(file, 0));
    5014:	4581                	li	a1,0
    5016:	fa840513          	add	a0,s0,-88
    501a:	00001097          	auipc	ra,0x1
    501e:	bf0080e7          	jalr	-1040(ra) # 5c0a <open>
    5022:	00001097          	auipc	ra,0x1
    5026:	bd0080e7          	jalr	-1072(ra) # 5bf2 <close>
      close(open(file, 0));
    502a:	4581                	li	a1,0
    502c:	fa840513          	add	a0,s0,-88
    5030:	00001097          	auipc	ra,0x1
    5034:	bda080e7          	jalr	-1062(ra) # 5c0a <open>
    5038:	00001097          	auipc	ra,0x1
    503c:	bba080e7          	jalr	-1094(ra) # 5bf2 <close>
      close(open(file, 0));
    5040:	4581                	li	a1,0
    5042:	fa840513          	add	a0,s0,-88
    5046:	00001097          	auipc	ra,0x1
    504a:	bc4080e7          	jalr	-1084(ra) # 5c0a <open>
    504e:	00001097          	auipc	ra,0x1
    5052:	ba4080e7          	jalr	-1116(ra) # 5bf2 <close>
      close(open(file, 0));
    5056:	4581                	li	a1,0
    5058:	fa840513          	add	a0,s0,-88
    505c:	00001097          	auipc	ra,0x1
    5060:	bae080e7          	jalr	-1106(ra) # 5c0a <open>
    5064:	00001097          	auipc	ra,0x1
    5068:	b8e080e7          	jalr	-1138(ra) # 5bf2 <close>
      close(open(file, 0));
    506c:	4581                	li	a1,0
    506e:	fa840513          	add	a0,s0,-88
    5072:	00001097          	auipc	ra,0x1
    5076:	b98080e7          	jalr	-1128(ra) # 5c0a <open>
    507a:	00001097          	auipc	ra,0x1
    507e:	b78080e7          	jalr	-1160(ra) # 5bf2 <close>
      close(open(file, 0));
    5082:	4581                	li	a1,0
    5084:	fa840513          	add	a0,s0,-88
    5088:	00001097          	auipc	ra,0x1
    508c:	b82080e7          	jalr	-1150(ra) # 5c0a <open>
    5090:	00001097          	auipc	ra,0x1
    5094:	b62080e7          	jalr	-1182(ra) # 5bf2 <close>
    if(pid == 0)
    5098:	08090363          	beqz	s2,511e <concreate+0x2d2>
      wait(0);
    509c:	4501                	li	a0,0
    509e:	00001097          	auipc	ra,0x1
    50a2:	b34080e7          	jalr	-1228(ra) # 5bd2 <wait>
  for(i = 0; i < N; i++){
    50a6:	2485                	addw	s1,s1,1
    50a8:	0f448563          	beq	s1,s4,5192 <concreate+0x346>
    file[1] = '0' + i;
    50ac:	0304879b          	addw	a5,s1,48
    50b0:	faf404a3          	sb	a5,-87(s0)
    pid = fork();
    50b4:	00001097          	auipc	ra,0x1
    50b8:	b0e080e7          	jalr	-1266(ra) # 5bc2 <fork>
    50bc:	892a                	mv	s2,a0
    if(pid < 0){
    50be:	f2054de3          	bltz	a0,4ff8 <concreate+0x1ac>
    if(((i % 3) == 0 && pid == 0) ||
    50c2:	0354e73b          	remw	a4,s1,s5
    50c6:	00a767b3          	or	a5,a4,a0
    50ca:	2781                	sext.w	a5,a5
    50cc:	d7a1                	beqz	a5,5014 <concreate+0x1c8>
    50ce:	01671363          	bne	a4,s6,50d4 <concreate+0x288>
       ((i % 3) == 1 && pid != 0)){
    50d2:	f129                	bnez	a0,5014 <concreate+0x1c8>
      unlink(file);
    50d4:	fa840513          	add	a0,s0,-88
    50d8:	00001097          	auipc	ra,0x1
    50dc:	b42080e7          	jalr	-1214(ra) # 5c1a <unlink>
      unlink(file);
    50e0:	fa840513          	add	a0,s0,-88
    50e4:	00001097          	auipc	ra,0x1
    50e8:	b36080e7          	jalr	-1226(ra) # 5c1a <unlink>
      unlink(file);
    50ec:	fa840513          	add	a0,s0,-88
    50f0:	00001097          	auipc	ra,0x1
    50f4:	b2a080e7          	jalr	-1238(ra) # 5c1a <unlink>
      unlink(file);
    50f8:	fa840513          	add	a0,s0,-88
    50fc:	00001097          	auipc	ra,0x1
    5100:	b1e080e7          	jalr	-1250(ra) # 5c1a <unlink>
      unlink(file);
    5104:	fa840513          	add	a0,s0,-88
    5108:	00001097          	auipc	ra,0x1
    510c:	b12080e7          	jalr	-1262(ra) # 5c1a <unlink>
      unlink(file);
    5110:	fa840513          	add	a0,s0,-88
    5114:	00001097          	auipc	ra,0x1
    5118:	b06080e7          	jalr	-1274(ra) # 5c1a <unlink>
    511c:	bfb5                	j	5098 <concreate+0x24c>
      exit(0);
    511e:	4501                	li	a0,0
    5120:	00001097          	auipc	ra,0x1
    5124:	aaa080e7          	jalr	-1366(ra) # 5bca <exit>
      close(fd);
    5128:	00001097          	auipc	ra,0x1
    512c:	aca080e7          	jalr	-1334(ra) # 5bf2 <close>
    if(pid == 0) {
    5130:	bb5d                	j	4ee6 <concreate+0x9a>
      close(fd);
    5132:	00001097          	auipc	ra,0x1
    5136:	ac0080e7          	jalr	-1344(ra) # 5bf2 <close>
      wait(&xstatus);
    513a:	f6c40513          	add	a0,s0,-148
    513e:	00001097          	auipc	ra,0x1
    5142:	a94080e7          	jalr	-1388(ra) # 5bd2 <wait>
      if(xstatus != 0)
    5146:	f6c42483          	lw	s1,-148(s0)
    514a:	da0493e3          	bnez	s1,4ef0 <concreate+0xa4>
  for(i = 0; i < N; i++){
    514e:	2905                	addw	s2,s2,1
    5150:	db4905e3          	beq	s2,s4,4efa <concreate+0xae>
    file[1] = '0' + i;
    5154:	0309079b          	addw	a5,s2,48
    5158:	faf404a3          	sb	a5,-87(s0)
    unlink(file);
    515c:	fa840513          	add	a0,s0,-88
    5160:	00001097          	auipc	ra,0x1
    5164:	aba080e7          	jalr	-1350(ra) # 5c1a <unlink>
    pid = fork();
    5168:	00001097          	auipc	ra,0x1
    516c:	a5a080e7          	jalr	-1446(ra) # 5bc2 <fork>
    if(pid && (i % 3) == 1){
    5170:	d20502e3          	beqz	a0,4e94 <concreate+0x48>
    5174:	036967bb          	remw	a5,s2,s6
    5178:	d15786e3          	beq	a5,s5,4e84 <concreate+0x38>
      fd = open(file, O_CREATE | O_RDWR);
    517c:	20200593          	li	a1,514
    5180:	fa840513          	add	a0,s0,-88
    5184:	00001097          	auipc	ra,0x1
    5188:	a86080e7          	jalr	-1402(ra) # 5c0a <open>
      if(fd < 0){
    518c:	fa0553e3          	bgez	a0,5132 <concreate+0x2e6>
    5190:	b315                	j	4eb4 <concreate+0x68>
}
    5192:	60ea                	ld	ra,152(sp)
    5194:	644a                	ld	s0,144(sp)
    5196:	64aa                	ld	s1,136(sp)
    5198:	690a                	ld	s2,128(sp)
    519a:	79e6                	ld	s3,120(sp)
    519c:	7a46                	ld	s4,112(sp)
    519e:	7aa6                	ld	s5,104(sp)
    51a0:	7b06                	ld	s6,96(sp)
    51a2:	6be6                	ld	s7,88(sp)
    51a4:	610d                	add	sp,sp,160
    51a6:	8082                	ret

00000000000051a8 <bigfile>:
{
    51a8:	7139                	add	sp,sp,-64
    51aa:	fc06                	sd	ra,56(sp)
    51ac:	f822                	sd	s0,48(sp)
    51ae:	f426                	sd	s1,40(sp)
    51b0:	f04a                	sd	s2,32(sp)
    51b2:	ec4e                	sd	s3,24(sp)
    51b4:	e852                	sd	s4,16(sp)
    51b6:	e456                	sd	s5,8(sp)
    51b8:	0080                	add	s0,sp,64
    51ba:	8aaa                	mv	s5,a0
  unlink("bigfile.dat");
    51bc:	00003517          	auipc	a0,0x3
    51c0:	f2450513          	add	a0,a0,-220 # 80e0 <updateNode+0x1e7c>
    51c4:	00001097          	auipc	ra,0x1
    51c8:	a56080e7          	jalr	-1450(ra) # 5c1a <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    51cc:	20200593          	li	a1,514
    51d0:	00003517          	auipc	a0,0x3
    51d4:	f1050513          	add	a0,a0,-240 # 80e0 <updateNode+0x1e7c>
    51d8:	00001097          	auipc	ra,0x1
    51dc:	a32080e7          	jalr	-1486(ra) # 5c0a <open>
    51e0:	89aa                	mv	s3,a0
  for(i = 0; i < N; i++){
    51e2:	4481                	li	s1,0
    memset(buf, i, SZ);
    51e4:	00008917          	auipc	s2,0x8
    51e8:	a9490913          	add	s2,s2,-1388 # cc78 <buf>
  for(i = 0; i < N; i++){
    51ec:	4a51                	li	s4,20
  if(fd < 0){
    51ee:	0a054063          	bltz	a0,528e <bigfile+0xe6>
    memset(buf, i, SZ);
    51f2:	25800613          	li	a2,600
    51f6:	85a6                	mv	a1,s1
    51f8:	854a                	mv	a0,s2
    51fa:	00000097          	auipc	ra,0x0
    51fe:	79a080e7          	jalr	1946(ra) # 5994 <memset>
    if(write(fd, buf, SZ) != SZ){
    5202:	25800613          	li	a2,600
    5206:	85ca                	mv	a1,s2
    5208:	854e                	mv	a0,s3
    520a:	00001097          	auipc	ra,0x1
    520e:	9e0080e7          	jalr	-1568(ra) # 5bea <write>
    5212:	25800793          	li	a5,600
    5216:	08f51a63          	bne	a0,a5,52aa <bigfile+0x102>
  for(i = 0; i < N; i++){
    521a:	2485                	addw	s1,s1,1
    521c:	fd449be3          	bne	s1,s4,51f2 <bigfile+0x4a>
  close(fd);
    5220:	854e                	mv	a0,s3
    5222:	00001097          	auipc	ra,0x1
    5226:	9d0080e7          	jalr	-1584(ra) # 5bf2 <close>
  fd = open("bigfile.dat", 0);
    522a:	4581                	li	a1,0
    522c:	00003517          	auipc	a0,0x3
    5230:	eb450513          	add	a0,a0,-332 # 80e0 <updateNode+0x1e7c>
    5234:	00001097          	auipc	ra,0x1
    5238:	9d6080e7          	jalr	-1578(ra) # 5c0a <open>
    523c:	8a2a                	mv	s4,a0
  total = 0;
    523e:	4981                	li	s3,0
  for(i = 0; ; i++){
    5240:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    5242:	00008917          	auipc	s2,0x8
    5246:	a3690913          	add	s2,s2,-1482 # cc78 <buf>
  if(fd < 0){
    524a:	06054e63          	bltz	a0,52c6 <bigfile+0x11e>
    cc = read(fd, buf, SZ/2);
    524e:	12c00613          	li	a2,300
    5252:	85ca                	mv	a1,s2
    5254:	8552                	mv	a0,s4
    5256:	00001097          	auipc	ra,0x1
    525a:	98c080e7          	jalr	-1652(ra) # 5be2 <read>
    if(cc < 0){
    525e:	08054263          	bltz	a0,52e2 <bigfile+0x13a>
    if(cc == 0)
    5262:	c971                	beqz	a0,5336 <bigfile+0x18e>
    if(cc != SZ/2){
    5264:	12c00793          	li	a5,300
    5268:	08f51b63          	bne	a0,a5,52fe <bigfile+0x156>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    526c:	01f4d79b          	srlw	a5,s1,0x1f
    5270:	9fa5                	addw	a5,a5,s1
    5272:	4017d79b          	sraw	a5,a5,0x1
    5276:	00094703          	lbu	a4,0(s2)
    527a:	0af71063          	bne	a4,a5,531a <bigfile+0x172>
    527e:	12b94703          	lbu	a4,299(s2)
    5282:	08f71c63          	bne	a4,a5,531a <bigfile+0x172>
    total += cc;
    5286:	12c9899b          	addw	s3,s3,300
  for(i = 0; ; i++){
    528a:	2485                	addw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    528c:	b7c9                	j	524e <bigfile+0xa6>
    printf("%s: cannot create bigfile", s);
    528e:	85d6                	mv	a1,s5
    5290:	00003517          	auipc	a0,0x3
    5294:	e6050513          	add	a0,a0,-416 # 80f0 <updateNode+0x1e8c>
    5298:	00001097          	auipc	ra,0x1
    529c:	cea080e7          	jalr	-790(ra) # 5f82 <printf>
    exit(1);
    52a0:	4505                	li	a0,1
    52a2:	00001097          	auipc	ra,0x1
    52a6:	928080e7          	jalr	-1752(ra) # 5bca <exit>
      printf("%s: write bigfile failed\n", s);
    52aa:	85d6                	mv	a1,s5
    52ac:	00003517          	auipc	a0,0x3
    52b0:	e6450513          	add	a0,a0,-412 # 8110 <updateNode+0x1eac>
    52b4:	00001097          	auipc	ra,0x1
    52b8:	cce080e7          	jalr	-818(ra) # 5f82 <printf>
      exit(1);
    52bc:	4505                	li	a0,1
    52be:	00001097          	auipc	ra,0x1
    52c2:	90c080e7          	jalr	-1780(ra) # 5bca <exit>
    printf("%s: cannot open bigfile\n", s);
    52c6:	85d6                	mv	a1,s5
    52c8:	00003517          	auipc	a0,0x3
    52cc:	e6850513          	add	a0,a0,-408 # 8130 <updateNode+0x1ecc>
    52d0:	00001097          	auipc	ra,0x1
    52d4:	cb2080e7          	jalr	-846(ra) # 5f82 <printf>
    exit(1);
    52d8:	4505                	li	a0,1
    52da:	00001097          	auipc	ra,0x1
    52de:	8f0080e7          	jalr	-1808(ra) # 5bca <exit>
      printf("%s: read bigfile failed\n", s);
    52e2:	85d6                	mv	a1,s5
    52e4:	00003517          	auipc	a0,0x3
    52e8:	e6c50513          	add	a0,a0,-404 # 8150 <updateNode+0x1eec>
    52ec:	00001097          	auipc	ra,0x1
    52f0:	c96080e7          	jalr	-874(ra) # 5f82 <printf>
      exit(1);
    52f4:	4505                	li	a0,1
    52f6:	00001097          	auipc	ra,0x1
    52fa:	8d4080e7          	jalr	-1836(ra) # 5bca <exit>
      printf("%s: short read bigfile\n", s);
    52fe:	85d6                	mv	a1,s5
    5300:	00003517          	auipc	a0,0x3
    5304:	e7050513          	add	a0,a0,-400 # 8170 <updateNode+0x1f0c>
    5308:	00001097          	auipc	ra,0x1
    530c:	c7a080e7          	jalr	-902(ra) # 5f82 <printf>
      exit(1);
    5310:	4505                	li	a0,1
    5312:	00001097          	auipc	ra,0x1
    5316:	8b8080e7          	jalr	-1864(ra) # 5bca <exit>
      printf("%s: read bigfile wrong data\n", s);
    531a:	85d6                	mv	a1,s5
    531c:	00003517          	auipc	a0,0x3
    5320:	e6c50513          	add	a0,a0,-404 # 8188 <updateNode+0x1f24>
    5324:	00001097          	auipc	ra,0x1
    5328:	c5e080e7          	jalr	-930(ra) # 5f82 <printf>
      exit(1);
    532c:	4505                	li	a0,1
    532e:	00001097          	auipc	ra,0x1
    5332:	89c080e7          	jalr	-1892(ra) # 5bca <exit>
  close(fd);
    5336:	8552                	mv	a0,s4
    5338:	00001097          	auipc	ra,0x1
    533c:	8ba080e7          	jalr	-1862(ra) # 5bf2 <close>
  if(total != N*SZ){
    5340:	678d                	lui	a5,0x3
    5342:	ee078793          	add	a5,a5,-288 # 2ee0 <sbrklast+0x8e>
    5346:	02f99363          	bne	s3,a5,536c <bigfile+0x1c4>
  unlink("bigfile.dat");
    534a:	00003517          	auipc	a0,0x3
    534e:	d9650513          	add	a0,a0,-618 # 80e0 <updateNode+0x1e7c>
    5352:	00001097          	auipc	ra,0x1
    5356:	8c8080e7          	jalr	-1848(ra) # 5c1a <unlink>
}
    535a:	70e2                	ld	ra,56(sp)
    535c:	7442                	ld	s0,48(sp)
    535e:	74a2                	ld	s1,40(sp)
    5360:	7902                	ld	s2,32(sp)
    5362:	69e2                	ld	s3,24(sp)
    5364:	6a42                	ld	s4,16(sp)
    5366:	6aa2                	ld	s5,8(sp)
    5368:	6121                	add	sp,sp,64
    536a:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    536c:	85d6                	mv	a1,s5
    536e:	00003517          	auipc	a0,0x3
    5372:	e3a50513          	add	a0,a0,-454 # 81a8 <updateNode+0x1f44>
    5376:	00001097          	auipc	ra,0x1
    537a:	c0c080e7          	jalr	-1012(ra) # 5f82 <printf>
    exit(1);
    537e:	4505                	li	a0,1
    5380:	00001097          	auipc	ra,0x1
    5384:	84a080e7          	jalr	-1974(ra) # 5bca <exit>

0000000000005388 <fsfull>:
{
    5388:	7135                	add	sp,sp,-160
    538a:	ed06                	sd	ra,152(sp)
    538c:	e922                	sd	s0,144(sp)
    538e:	e526                	sd	s1,136(sp)
    5390:	e14a                	sd	s2,128(sp)
    5392:	fcce                	sd	s3,120(sp)
    5394:	f8d2                	sd	s4,112(sp)
    5396:	f4d6                	sd	s5,104(sp)
    5398:	f0da                	sd	s6,96(sp)
    539a:	ecde                	sd	s7,88(sp)
    539c:	e8e2                	sd	s8,80(sp)
    539e:	e4e6                	sd	s9,72(sp)
    53a0:	e0ea                	sd	s10,64(sp)
    53a2:	1100                	add	s0,sp,160
  printf("fsfull test\n");
    53a4:	00003517          	auipc	a0,0x3
    53a8:	e2450513          	add	a0,a0,-476 # 81c8 <updateNode+0x1f64>
    53ac:	00001097          	auipc	ra,0x1
    53b0:	bd6080e7          	jalr	-1066(ra) # 5f82 <printf>
  for(nfiles = 0; ; nfiles++){
    53b4:	4481                	li	s1,0
    name[0] = 'f';
    53b6:	06600d13          	li	s10,102
    name[1] = '0' + nfiles / 1000;
    53ba:	3e800c13          	li	s8,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    53be:	06400b93          	li	s7,100
    name[3] = '0' + (nfiles % 100) / 10;
    53c2:	4b29                	li	s6,10
    printf("writing %s\n", name);
    53c4:	00003c97          	auipc	s9,0x3
    53c8:	e14c8c93          	add	s9,s9,-492 # 81d8 <updateNode+0x1f74>
    name[0] = 'f';
    53cc:	f7a40023          	sb	s10,-160(s0)
    name[1] = '0' + nfiles / 1000;
    53d0:	0384c7bb          	divw	a5,s1,s8
    53d4:	0307879b          	addw	a5,a5,48
    53d8:	f6f400a3          	sb	a5,-159(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    53dc:	0384e7bb          	remw	a5,s1,s8
    53e0:	0377c7bb          	divw	a5,a5,s7
    53e4:	0307879b          	addw	a5,a5,48
    53e8:	f6f40123          	sb	a5,-158(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    53ec:	0374e7bb          	remw	a5,s1,s7
    53f0:	0367c7bb          	divw	a5,a5,s6
    53f4:	0307879b          	addw	a5,a5,48
    53f8:	f6f401a3          	sb	a5,-157(s0)
    name[4] = '0' + (nfiles % 10);
    53fc:	0364e7bb          	remw	a5,s1,s6
    5400:	0307879b          	addw	a5,a5,48
    5404:	f6f40223          	sb	a5,-156(s0)
    name[5] = '\0';
    5408:	f60402a3          	sb	zero,-155(s0)
    printf("writing %s\n", name);
    540c:	f6040593          	add	a1,s0,-160
    5410:	8566                	mv	a0,s9
    5412:	00001097          	auipc	ra,0x1
    5416:	b70080e7          	jalr	-1168(ra) # 5f82 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    541a:	20200593          	li	a1,514
    541e:	f6040513          	add	a0,s0,-160
    5422:	00000097          	auipc	ra,0x0
    5426:	7e8080e7          	jalr	2024(ra) # 5c0a <open>
    542a:	892a                	mv	s2,a0
    if(fd < 0){
    542c:	0a055563          	bgez	a0,54d6 <fsfull+0x14e>
      printf("open %s failed\n", name);
    5430:	f6040593          	add	a1,s0,-160
    5434:	00003517          	auipc	a0,0x3
    5438:	db450513          	add	a0,a0,-588 # 81e8 <updateNode+0x1f84>
    543c:	00001097          	auipc	ra,0x1
    5440:	b46080e7          	jalr	-1210(ra) # 5f82 <printf>
  while(nfiles >= 0){
    5444:	0604c363          	bltz	s1,54aa <fsfull+0x122>
    name[0] = 'f';
    5448:	06600b13          	li	s6,102
    name[1] = '0' + nfiles / 1000;
    544c:	3e800a13          	li	s4,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    5450:	06400993          	li	s3,100
    name[3] = '0' + (nfiles % 100) / 10;
    5454:	4929                	li	s2,10
  while(nfiles >= 0){
    5456:	5afd                	li	s5,-1
    name[0] = 'f';
    5458:	f7640023          	sb	s6,-160(s0)
    name[1] = '0' + nfiles / 1000;
    545c:	0344c7bb          	divw	a5,s1,s4
    5460:	0307879b          	addw	a5,a5,48
    5464:	f6f400a3          	sb	a5,-159(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    5468:	0344e7bb          	remw	a5,s1,s4
    546c:	0337c7bb          	divw	a5,a5,s3
    5470:	0307879b          	addw	a5,a5,48
    5474:	f6f40123          	sb	a5,-158(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    5478:	0334e7bb          	remw	a5,s1,s3
    547c:	0327c7bb          	divw	a5,a5,s2
    5480:	0307879b          	addw	a5,a5,48
    5484:	f6f401a3          	sb	a5,-157(s0)
    name[4] = '0' + (nfiles % 10);
    5488:	0324e7bb          	remw	a5,s1,s2
    548c:	0307879b          	addw	a5,a5,48
    5490:	f6f40223          	sb	a5,-156(s0)
    name[5] = '\0';
    5494:	f60402a3          	sb	zero,-155(s0)
    unlink(name);
    5498:	f6040513          	add	a0,s0,-160
    549c:	00000097          	auipc	ra,0x0
    54a0:	77e080e7          	jalr	1918(ra) # 5c1a <unlink>
    nfiles--;
    54a4:	34fd                	addw	s1,s1,-1
  while(nfiles >= 0){
    54a6:	fb5499e3          	bne	s1,s5,5458 <fsfull+0xd0>
  printf("fsfull test finished\n");
    54aa:	00003517          	auipc	a0,0x3
    54ae:	d5e50513          	add	a0,a0,-674 # 8208 <updateNode+0x1fa4>
    54b2:	00001097          	auipc	ra,0x1
    54b6:	ad0080e7          	jalr	-1328(ra) # 5f82 <printf>
}
    54ba:	60ea                	ld	ra,152(sp)
    54bc:	644a                	ld	s0,144(sp)
    54be:	64aa                	ld	s1,136(sp)
    54c0:	690a                	ld	s2,128(sp)
    54c2:	79e6                	ld	s3,120(sp)
    54c4:	7a46                	ld	s4,112(sp)
    54c6:	7aa6                	ld	s5,104(sp)
    54c8:	7b06                	ld	s6,96(sp)
    54ca:	6be6                	ld	s7,88(sp)
    54cc:	6c46                	ld	s8,80(sp)
    54ce:	6ca6                	ld	s9,72(sp)
    54d0:	6d06                	ld	s10,64(sp)
    54d2:	610d                	add	sp,sp,160
    54d4:	8082                	ret
    int total = 0;
    54d6:	4981                	li	s3,0
      int cc = write(fd, buf, BSIZE);
    54d8:	00007a97          	auipc	s5,0x7
    54dc:	7a0a8a93          	add	s5,s5,1952 # cc78 <buf>
      if(cc < BSIZE)
    54e0:	3ff00a13          	li	s4,1023
      int cc = write(fd, buf, BSIZE);
    54e4:	40000613          	li	a2,1024
    54e8:	85d6                	mv	a1,s5
    54ea:	854a                	mv	a0,s2
    54ec:	00000097          	auipc	ra,0x0
    54f0:	6fe080e7          	jalr	1790(ra) # 5bea <write>
      if(cc < BSIZE)
    54f4:	00aa5563          	bge	s4,a0,54fe <fsfull+0x176>
      total += cc;
    54f8:	00a989bb          	addw	s3,s3,a0
    while(1){
    54fc:	b7e5                	j	54e4 <fsfull+0x15c>
    printf("wrote %d bytes\n", total);
    54fe:	85ce                	mv	a1,s3
    5500:	00003517          	auipc	a0,0x3
    5504:	cf850513          	add	a0,a0,-776 # 81f8 <updateNode+0x1f94>
    5508:	00001097          	auipc	ra,0x1
    550c:	a7a080e7          	jalr	-1414(ra) # 5f82 <printf>
    close(fd);
    5510:	854a                	mv	a0,s2
    5512:	00000097          	auipc	ra,0x0
    5516:	6e0080e7          	jalr	1760(ra) # 5bf2 <close>
    if(total == 0)
    551a:	f20985e3          	beqz	s3,5444 <fsfull+0xbc>
  for(nfiles = 0; ; nfiles++){
    551e:	2485                	addw	s1,s1,1
    5520:	b575                	j	53cc <fsfull+0x44>

0000000000005522 <run>:
//

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    5522:	7179                	add	sp,sp,-48
    5524:	f406                	sd	ra,40(sp)
    5526:	f022                	sd	s0,32(sp)
    5528:	ec26                	sd	s1,24(sp)
    552a:	e84a                	sd	s2,16(sp)
    552c:	1800                	add	s0,sp,48
    552e:	84aa                	mv	s1,a0
    5530:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    5532:	00003517          	auipc	a0,0x3
    5536:	cee50513          	add	a0,a0,-786 # 8220 <updateNode+0x1fbc>
    553a:	00001097          	auipc	ra,0x1
    553e:	a48080e7          	jalr	-1464(ra) # 5f82 <printf>
  if((pid = fork()) < 0) {
    5542:	00000097          	auipc	ra,0x0
    5546:	680080e7          	jalr	1664(ra) # 5bc2 <fork>
    554a:	02054e63          	bltz	a0,5586 <run+0x64>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    554e:	c929                	beqz	a0,55a0 <run+0x7e>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    5550:	fdc40513          	add	a0,s0,-36
    5554:	00000097          	auipc	ra,0x0
    5558:	67e080e7          	jalr	1662(ra) # 5bd2 <wait>
    if(xstatus != 0) 
    555c:	fdc42783          	lw	a5,-36(s0)
    5560:	c7b9                	beqz	a5,55ae <run+0x8c>
      printf("FAILED\n");
    5562:	00003517          	auipc	a0,0x3
    5566:	ce650513          	add	a0,a0,-794 # 8248 <updateNode+0x1fe4>
    556a:	00001097          	auipc	ra,0x1
    556e:	a18080e7          	jalr	-1512(ra) # 5f82 <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    5572:	fdc42503          	lw	a0,-36(s0)
  }
}
    5576:	00153513          	seqz	a0,a0
    557a:	70a2                	ld	ra,40(sp)
    557c:	7402                	ld	s0,32(sp)
    557e:	64e2                	ld	s1,24(sp)
    5580:	6942                	ld	s2,16(sp)
    5582:	6145                	add	sp,sp,48
    5584:	8082                	ret
    printf("runtest: fork error\n");
    5586:	00003517          	auipc	a0,0x3
    558a:	caa50513          	add	a0,a0,-854 # 8230 <updateNode+0x1fcc>
    558e:	00001097          	auipc	ra,0x1
    5592:	9f4080e7          	jalr	-1548(ra) # 5f82 <printf>
    exit(1);
    5596:	4505                	li	a0,1
    5598:	00000097          	auipc	ra,0x0
    559c:	632080e7          	jalr	1586(ra) # 5bca <exit>
    f(s);
    55a0:	854a                	mv	a0,s2
    55a2:	9482                	jalr	s1
    exit(0);
    55a4:	4501                	li	a0,0
    55a6:	00000097          	auipc	ra,0x0
    55aa:	624080e7          	jalr	1572(ra) # 5bca <exit>
      printf("OK\n");
    55ae:	00003517          	auipc	a0,0x3
    55b2:	ca250513          	add	a0,a0,-862 # 8250 <updateNode+0x1fec>
    55b6:	00001097          	auipc	ra,0x1
    55ba:	9cc080e7          	jalr	-1588(ra) # 5f82 <printf>
    55be:	bf55                	j	5572 <run+0x50>

00000000000055c0 <runtests>:

int
runtests(struct test *tests, char *justone) {
    55c0:	1101                	add	sp,sp,-32
    55c2:	ec06                	sd	ra,24(sp)
    55c4:	e822                	sd	s0,16(sp)
    55c6:	e426                	sd	s1,8(sp)
    55c8:	e04a                	sd	s2,0(sp)
    55ca:	1000                	add	s0,sp,32
    55cc:	84aa                	mv	s1,a0
    55ce:	892e                	mv	s2,a1
  for (struct test *t = tests; t->s != 0; t++) {
    55d0:	6508                	ld	a0,8(a0)
    55d2:	ed09                	bnez	a0,55ec <runtests+0x2c>
        printf("SOME TESTS FAILED\n");
        return 1;
      }
    }
  }
  return 0;
    55d4:	4501                	li	a0,0
    55d6:	a82d                	j	5610 <runtests+0x50>
      if(!run(t->f, t->s)){
    55d8:	648c                	ld	a1,8(s1)
    55da:	6088                	ld	a0,0(s1)
    55dc:	00000097          	auipc	ra,0x0
    55e0:	f46080e7          	jalr	-186(ra) # 5522 <run>
    55e4:	cd09                	beqz	a0,55fe <runtests+0x3e>
  for (struct test *t = tests; t->s != 0; t++) {
    55e6:	04c1                	add	s1,s1,16
    55e8:	6488                	ld	a0,8(s1)
    55ea:	c11d                	beqz	a0,5610 <runtests+0x50>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    55ec:	fe0906e3          	beqz	s2,55d8 <runtests+0x18>
    55f0:	85ca                	mv	a1,s2
    55f2:	00000097          	auipc	ra,0x0
    55f6:	34c080e7          	jalr	844(ra) # 593e <strcmp>
    55fa:	f575                	bnez	a0,55e6 <runtests+0x26>
    55fc:	bff1                	j	55d8 <runtests+0x18>
        printf("SOME TESTS FAILED\n");
    55fe:	00003517          	auipc	a0,0x3
    5602:	c5a50513          	add	a0,a0,-934 # 8258 <updateNode+0x1ff4>
    5606:	00001097          	auipc	ra,0x1
    560a:	97c080e7          	jalr	-1668(ra) # 5f82 <printf>
        return 1;
    560e:	4505                	li	a0,1
}
    5610:	60e2                	ld	ra,24(sp)
    5612:	6442                	ld	s0,16(sp)
    5614:	64a2                	ld	s1,8(sp)
    5616:	6902                	ld	s2,0(sp)
    5618:	6105                	add	sp,sp,32
    561a:	8082                	ret

000000000000561c <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    561c:	7139                	add	sp,sp,-64
    561e:	fc06                	sd	ra,56(sp)
    5620:	f822                	sd	s0,48(sp)
    5622:	f426                	sd	s1,40(sp)
    5624:	f04a                	sd	s2,32(sp)
    5626:	ec4e                	sd	s3,24(sp)
    5628:	0080                	add	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    562a:	fc840513          	add	a0,s0,-56
    562e:	00000097          	auipc	ra,0x0
    5632:	5ac080e7          	jalr	1452(ra) # 5bda <pipe>
    5636:	06054763          	bltz	a0,56a4 <countfree+0x88>
    printf("pipe() failed in countfree()\n");
    exit(1);
  }
  
  int pid = fork();
    563a:	00000097          	auipc	ra,0x0
    563e:	588080e7          	jalr	1416(ra) # 5bc2 <fork>

  if(pid < 0){
    5642:	06054e63          	bltz	a0,56be <countfree+0xa2>
    printf("fork failed in countfree()\n");
    exit(1);
  }

  if(pid == 0){
    5646:	ed51                	bnez	a0,56e2 <countfree+0xc6>
    close(fds[0]);
    5648:	fc842503          	lw	a0,-56(s0)
    564c:	00000097          	auipc	ra,0x0
    5650:	5a6080e7          	jalr	1446(ra) # 5bf2 <close>
    
    while(1){
      uint64 a = (uint64) sbrk(4096);
      if(a == 0xffffffffffffffff){
    5654:	597d                	li	s2,-1
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    5656:	4485                	li	s1,1

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    5658:	00001997          	auipc	s3,0x1
    565c:	cf098993          	add	s3,s3,-784 # 6348 <updateNode+0xe4>
      uint64 a = (uint64) sbrk(4096);
    5660:	6505                	lui	a0,0x1
    5662:	00000097          	auipc	ra,0x0
    5666:	5f0080e7          	jalr	1520(ra) # 5c52 <sbrk>
      if(a == 0xffffffffffffffff){
    566a:	07250763          	beq	a0,s2,56d8 <countfree+0xbc>
      *(char *)(a + 4096 - 1) = 1;
    566e:	6785                	lui	a5,0x1
    5670:	97aa                	add	a5,a5,a0
    5672:	fe978fa3          	sb	s1,-1(a5) # fff <linktest+0x10b>
      if(write(fds[1], "x", 1) != 1){
    5676:	8626                	mv	a2,s1
    5678:	85ce                	mv	a1,s3
    567a:	fcc42503          	lw	a0,-52(s0)
    567e:	00000097          	auipc	ra,0x0
    5682:	56c080e7          	jalr	1388(ra) # 5bea <write>
    5686:	fc950de3          	beq	a0,s1,5660 <countfree+0x44>
        printf("write() failed in countfree()\n");
    568a:	00003517          	auipc	a0,0x3
    568e:	c2650513          	add	a0,a0,-986 # 82b0 <updateNode+0x204c>
    5692:	00001097          	auipc	ra,0x1
    5696:	8f0080e7          	jalr	-1808(ra) # 5f82 <printf>
        exit(1);
    569a:	4505                	li	a0,1
    569c:	00000097          	auipc	ra,0x0
    56a0:	52e080e7          	jalr	1326(ra) # 5bca <exit>
    printf("pipe() failed in countfree()\n");
    56a4:	00003517          	auipc	a0,0x3
    56a8:	bcc50513          	add	a0,a0,-1076 # 8270 <updateNode+0x200c>
    56ac:	00001097          	auipc	ra,0x1
    56b0:	8d6080e7          	jalr	-1834(ra) # 5f82 <printf>
    exit(1);
    56b4:	4505                	li	a0,1
    56b6:	00000097          	auipc	ra,0x0
    56ba:	514080e7          	jalr	1300(ra) # 5bca <exit>
    printf("fork failed in countfree()\n");
    56be:	00003517          	auipc	a0,0x3
    56c2:	bd250513          	add	a0,a0,-1070 # 8290 <updateNode+0x202c>
    56c6:	00001097          	auipc	ra,0x1
    56ca:	8bc080e7          	jalr	-1860(ra) # 5f82 <printf>
    exit(1);
    56ce:	4505                	li	a0,1
    56d0:	00000097          	auipc	ra,0x0
    56d4:	4fa080e7          	jalr	1274(ra) # 5bca <exit>
      }
    }

    exit(0);
    56d8:	4501                	li	a0,0
    56da:	00000097          	auipc	ra,0x0
    56de:	4f0080e7          	jalr	1264(ra) # 5bca <exit>
  }

  close(fds[1]);
    56e2:	fcc42503          	lw	a0,-52(s0)
    56e6:	00000097          	auipc	ra,0x0
    56ea:	50c080e7          	jalr	1292(ra) # 5bf2 <close>

  int n = 0;
    56ee:	4481                	li	s1,0
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    56f0:	4605                	li	a2,1
    56f2:	fc740593          	add	a1,s0,-57
    56f6:	fc842503          	lw	a0,-56(s0)
    56fa:	00000097          	auipc	ra,0x0
    56fe:	4e8080e7          	jalr	1256(ra) # 5be2 <read>
    if(cc < 0){
    5702:	00054563          	bltz	a0,570c <countfree+0xf0>
      printf("read() failed in countfree()\n");
      exit(1);
    }
    if(cc == 0)
    5706:	c105                	beqz	a0,5726 <countfree+0x10a>
      break;
    n += 1;
    5708:	2485                	addw	s1,s1,1
  while(1){
    570a:	b7dd                	j	56f0 <countfree+0xd4>
      printf("read() failed in countfree()\n");
    570c:	00003517          	auipc	a0,0x3
    5710:	bc450513          	add	a0,a0,-1084 # 82d0 <updateNode+0x206c>
    5714:	00001097          	auipc	ra,0x1
    5718:	86e080e7          	jalr	-1938(ra) # 5f82 <printf>
      exit(1);
    571c:	4505                	li	a0,1
    571e:	00000097          	auipc	ra,0x0
    5722:	4ac080e7          	jalr	1196(ra) # 5bca <exit>
  }

  close(fds[0]);
    5726:	fc842503          	lw	a0,-56(s0)
    572a:	00000097          	auipc	ra,0x0
    572e:	4c8080e7          	jalr	1224(ra) # 5bf2 <close>
  wait((int*)0);
    5732:	4501                	li	a0,0
    5734:	00000097          	auipc	ra,0x0
    5738:	49e080e7          	jalr	1182(ra) # 5bd2 <wait>
  
  return n;
}
    573c:	8526                	mv	a0,s1
    573e:	70e2                	ld	ra,56(sp)
    5740:	7442                	ld	s0,48(sp)
    5742:	74a2                	ld	s1,40(sp)
    5744:	7902                	ld	s2,32(sp)
    5746:	69e2                	ld	s3,24(sp)
    5748:	6121                	add	sp,sp,64
    574a:	8082                	ret

000000000000574c <drivetests>:

int
drivetests(int quick, int continuous, char *justone) {
    574c:	711d                	add	sp,sp,-96
    574e:	ec86                	sd	ra,88(sp)
    5750:	e8a2                	sd	s0,80(sp)
    5752:	e4a6                	sd	s1,72(sp)
    5754:	e0ca                	sd	s2,64(sp)
    5756:	fc4e                	sd	s3,56(sp)
    5758:	f852                	sd	s4,48(sp)
    575a:	f456                	sd	s5,40(sp)
    575c:	f05a                	sd	s6,32(sp)
    575e:	ec5e                	sd	s7,24(sp)
    5760:	e862                	sd	s8,16(sp)
    5762:	e466                	sd	s9,8(sp)
    5764:	e06a                	sd	s10,0(sp)
    5766:	1080                	add	s0,sp,96
    5768:	8aaa                	mv	s5,a0
    576a:	89ae                	mv	s3,a1
    576c:	8932                	mv	s2,a2
  do {
    printf("usertests starting\n");
    576e:	00003b97          	auipc	s7,0x3
    5772:	b82b8b93          	add	s7,s7,-1150 # 82f0 <updateNode+0x208c>
    int free0 = countfree();
    int free1 = 0;
    if (runtests(quicktests, justone)) {
    5776:	00004b17          	auipc	s6,0x4
    577a:	89ab0b13          	add	s6,s6,-1894 # 9010 <quicktests>
      if(continuous != 2) {
    577e:	4a09                	li	s4,2
      }
    }
    if(!quick) {
      if (justone == 0)
        printf("usertests slow tests starting\n");
      if (runtests(slowtests, justone)) {
    5780:	00004c17          	auipc	s8,0x4
    5784:	c60c0c13          	add	s8,s8,-928 # 93e0 <slowtests>
        printf("usertests slow tests starting\n");
    5788:	00003d17          	auipc	s10,0x3
    578c:	b80d0d13          	add	s10,s10,-1152 # 8308 <updateNode+0x20a4>
          return 1;
        }
      }
    }
    if((free1 = countfree()) < free0) {
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    5790:	00003c97          	auipc	s9,0x3
    5794:	b98c8c93          	add	s9,s9,-1128 # 8328 <updateNode+0x20c4>
    5798:	a839                	j	57b6 <drivetests+0x6a>
        printf("usertests slow tests starting\n");
    579a:	856a                	mv	a0,s10
    579c:	00000097          	auipc	ra,0x0
    57a0:	7e6080e7          	jalr	2022(ra) # 5f82 <printf>
    57a4:	a081                	j	57e4 <drivetests+0x98>
    if((free1 = countfree()) < free0) {
    57a6:	00000097          	auipc	ra,0x0
    57aa:	e76080e7          	jalr	-394(ra) # 561c <countfree>
    57ae:	04954663          	blt	a0,s1,57fa <drivetests+0xae>
      if(continuous != 2) {
        return 1;
      }
    }
  } while(continuous);
    57b2:	06098163          	beqz	s3,5814 <drivetests+0xc8>
    printf("usertests starting\n");
    57b6:	855e                	mv	a0,s7
    57b8:	00000097          	auipc	ra,0x0
    57bc:	7ca080e7          	jalr	1994(ra) # 5f82 <printf>
    int free0 = countfree();
    57c0:	00000097          	auipc	ra,0x0
    57c4:	e5c080e7          	jalr	-420(ra) # 561c <countfree>
    57c8:	84aa                	mv	s1,a0
    if (runtests(quicktests, justone)) {
    57ca:	85ca                	mv	a1,s2
    57cc:	855a                	mv	a0,s6
    57ce:	00000097          	auipc	ra,0x0
    57d2:	df2080e7          	jalr	-526(ra) # 55c0 <runtests>
    57d6:	c119                	beqz	a0,57dc <drivetests+0x90>
      if(continuous != 2) {
    57d8:	03499c63          	bne	s3,s4,5810 <drivetests+0xc4>
    if(!quick) {
    57dc:	fc0a95e3          	bnez	s5,57a6 <drivetests+0x5a>
      if (justone == 0)
    57e0:	fa090de3          	beqz	s2,579a <drivetests+0x4e>
      if (runtests(slowtests, justone)) {
    57e4:	85ca                	mv	a1,s2
    57e6:	8562                	mv	a0,s8
    57e8:	00000097          	auipc	ra,0x0
    57ec:	dd8080e7          	jalr	-552(ra) # 55c0 <runtests>
    57f0:	d95d                	beqz	a0,57a6 <drivetests+0x5a>
        if(continuous != 2) {
    57f2:	fb498ae3          	beq	s3,s4,57a6 <drivetests+0x5a>
          return 1;
    57f6:	4505                	li	a0,1
    57f8:	a839                	j	5816 <drivetests+0xca>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    57fa:	8626                	mv	a2,s1
    57fc:	85aa                	mv	a1,a0
    57fe:	8566                	mv	a0,s9
    5800:	00000097          	auipc	ra,0x0
    5804:	782080e7          	jalr	1922(ra) # 5f82 <printf>
      if(continuous != 2) {
    5808:	fb4987e3          	beq	s3,s4,57b6 <drivetests+0x6a>
        return 1;
    580c:	4505                	li	a0,1
    580e:	a021                	j	5816 <drivetests+0xca>
        return 1;
    5810:	4505                	li	a0,1
    5812:	a011                	j	5816 <drivetests+0xca>
  return 0;
    5814:	854e                	mv	a0,s3
}
    5816:	60e6                	ld	ra,88(sp)
    5818:	6446                	ld	s0,80(sp)
    581a:	64a6                	ld	s1,72(sp)
    581c:	6906                	ld	s2,64(sp)
    581e:	79e2                	ld	s3,56(sp)
    5820:	7a42                	ld	s4,48(sp)
    5822:	7aa2                	ld	s5,40(sp)
    5824:	7b02                	ld	s6,32(sp)
    5826:	6be2                	ld	s7,24(sp)
    5828:	6c42                	ld	s8,16(sp)
    582a:	6ca2                	ld	s9,8(sp)
    582c:	6d02                	ld	s10,0(sp)
    582e:	6125                	add	sp,sp,96
    5830:	8082                	ret

0000000000005832 <main>:

int
main(int argc, char *argv[])
{
    5832:	1101                	add	sp,sp,-32
    5834:	ec06                	sd	ra,24(sp)
    5836:	e822                	sd	s0,16(sp)
    5838:	e426                	sd	s1,8(sp)
    583a:	e04a                	sd	s2,0(sp)
    583c:	1000                	add	s0,sp,32
    583e:	84aa                	mv	s1,a0
  int continuous = 0;
  int quick = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    5840:	4789                	li	a5,2
    5842:	02f50263          	beq	a0,a5,5866 <main+0x34>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    5846:	4785                	li	a5,1
    5848:	08a7c063          	blt	a5,a0,58c8 <main+0x96>
  char *justone = 0;
    584c:	4601                	li	a2,0
  int quick = 0;
    584e:	4501                	li	a0,0
  int continuous = 0;
    5850:	4581                	li	a1,0
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    exit(1);
  }
  if (drivetests(quick, continuous, justone)) {
    5852:	00000097          	auipc	ra,0x0
    5856:	efa080e7          	jalr	-262(ra) # 574c <drivetests>
    585a:	c951                	beqz	a0,58ee <main+0xbc>
    exit(1);
    585c:	4505                	li	a0,1
    585e:	00000097          	auipc	ra,0x0
    5862:	36c080e7          	jalr	876(ra) # 5bca <exit>
    5866:	892e                	mv	s2,a1
  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    5868:	00003597          	auipc	a1,0x3
    586c:	af058593          	add	a1,a1,-1296 # 8358 <updateNode+0x20f4>
    5870:	00893503          	ld	a0,8(s2)
    5874:	00000097          	auipc	ra,0x0
    5878:	0ca080e7          	jalr	202(ra) # 593e <strcmp>
    587c:	85aa                	mv	a1,a0
    587e:	e501                	bnez	a0,5886 <main+0x54>
  char *justone = 0;
    5880:	4601                	li	a2,0
    quick = 1;
    5882:	4505                	li	a0,1
    5884:	b7f9                	j	5852 <main+0x20>
  } else if(argc == 2 && strcmp(argv[1], "-c") == 0){
    5886:	00003597          	auipc	a1,0x3
    588a:	ada58593          	add	a1,a1,-1318 # 8360 <updateNode+0x20fc>
    588e:	00893503          	ld	a0,8(s2)
    5892:	00000097          	auipc	ra,0x0
    5896:	0ac080e7          	jalr	172(ra) # 593e <strcmp>
    589a:	c521                	beqz	a0,58e2 <main+0xb0>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    589c:	00003597          	auipc	a1,0x3
    58a0:	b1458593          	add	a1,a1,-1260 # 83b0 <updateNode+0x214c>
    58a4:	00893503          	ld	a0,8(s2)
    58a8:	00000097          	auipc	ra,0x0
    58ac:	096080e7          	jalr	150(ra) # 593e <strcmp>
    58b0:	cd05                	beqz	a0,58e8 <main+0xb6>
  } else if(argc == 2 && argv[1][0] != '-'){
    58b2:	00893603          	ld	a2,8(s2)
    58b6:	00064703          	lbu	a4,0(a2) # 3000 <execout+0xa6>
    58ba:	02d00793          	li	a5,45
    58be:	00f70563          	beq	a4,a5,58c8 <main+0x96>
  int quick = 0;
    58c2:	4501                	li	a0,0
  int continuous = 0;
    58c4:	4581                	li	a1,0
    58c6:	b771                	j	5852 <main+0x20>
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    58c8:	00003517          	auipc	a0,0x3
    58cc:	aa050513          	add	a0,a0,-1376 # 8368 <updateNode+0x2104>
    58d0:	00000097          	auipc	ra,0x0
    58d4:	6b2080e7          	jalr	1714(ra) # 5f82 <printf>
    exit(1);
    58d8:	4505                	li	a0,1
    58da:	00000097          	auipc	ra,0x0
    58de:	2f0080e7          	jalr	752(ra) # 5bca <exit>
  char *justone = 0;
    58e2:	4601                	li	a2,0
    continuous = 1;
    58e4:	4585                	li	a1,1
    58e6:	b7b5                	j	5852 <main+0x20>
    continuous = 2;
    58e8:	85a6                	mv	a1,s1
  char *justone = 0;
    58ea:	4601                	li	a2,0
    58ec:	b79d                	j	5852 <main+0x20>
  }
  printf("ALL TESTS PASSED\n");
    58ee:	00003517          	auipc	a0,0x3
    58f2:	aaa50513          	add	a0,a0,-1366 # 8398 <updateNode+0x2134>
    58f6:	00000097          	auipc	ra,0x0
    58fa:	68c080e7          	jalr	1676(ra) # 5f82 <printf>
  exit(0);
    58fe:	4501                	li	a0,0
    5900:	00000097          	auipc	ra,0x0
    5904:	2ca080e7          	jalr	714(ra) # 5bca <exit>

0000000000005908 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    5908:	1141                	add	sp,sp,-16
    590a:	e406                	sd	ra,8(sp)
    590c:	e022                	sd	s0,0(sp)
    590e:	0800                	add	s0,sp,16
  extern int main();
  main();
    5910:	00000097          	auipc	ra,0x0
    5914:	f22080e7          	jalr	-222(ra) # 5832 <main>
  exit(0);
    5918:	4501                	li	a0,0
    591a:	00000097          	auipc	ra,0x0
    591e:	2b0080e7          	jalr	688(ra) # 5bca <exit>

0000000000005922 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    5922:	1141                	add	sp,sp,-16
    5924:	e422                	sd	s0,8(sp)
    5926:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    5928:	87aa                	mv	a5,a0
    592a:	0585                	add	a1,a1,1
    592c:	0785                	add	a5,a5,1
    592e:	fff5c703          	lbu	a4,-1(a1)
    5932:	fee78fa3          	sb	a4,-1(a5)
    5936:	fb75                	bnez	a4,592a <strcpy+0x8>
    ;
  return os;
}
    5938:	6422                	ld	s0,8(sp)
    593a:	0141                	add	sp,sp,16
    593c:	8082                	ret

000000000000593e <strcmp>:

int
strcmp(const char *p, const char *q)
{
    593e:	1141                	add	sp,sp,-16
    5940:	e422                	sd	s0,8(sp)
    5942:	0800                	add	s0,sp,16
  while(*p && *p == *q)
    5944:	00054783          	lbu	a5,0(a0)
    5948:	cb91                	beqz	a5,595c <strcmp+0x1e>
    594a:	0005c703          	lbu	a4,0(a1)
    594e:	00f71763          	bne	a4,a5,595c <strcmp+0x1e>
    p++, q++;
    5952:	0505                	add	a0,a0,1
    5954:	0585                	add	a1,a1,1
  while(*p && *p == *q)
    5956:	00054783          	lbu	a5,0(a0)
    595a:	fbe5                	bnez	a5,594a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    595c:	0005c503          	lbu	a0,0(a1)
}
    5960:	40a7853b          	subw	a0,a5,a0
    5964:	6422                	ld	s0,8(sp)
    5966:	0141                	add	sp,sp,16
    5968:	8082                	ret

000000000000596a <strlen>:

uint
strlen(const char *s)
{
    596a:	1141                	add	sp,sp,-16
    596c:	e422                	sd	s0,8(sp)
    596e:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    5970:	00054783          	lbu	a5,0(a0)
    5974:	cf91                	beqz	a5,5990 <strlen+0x26>
    5976:	0505                	add	a0,a0,1
    5978:	87aa                	mv	a5,a0
    597a:	86be                	mv	a3,a5
    597c:	0785                	add	a5,a5,1
    597e:	fff7c703          	lbu	a4,-1(a5)
    5982:	ff65                	bnez	a4,597a <strlen+0x10>
    5984:	40a6853b          	subw	a0,a3,a0
    5988:	2505                	addw	a0,a0,1
    ;
  return n;
}
    598a:	6422                	ld	s0,8(sp)
    598c:	0141                	add	sp,sp,16
    598e:	8082                	ret
  for(n = 0; s[n]; n++)
    5990:	4501                	li	a0,0
    5992:	bfe5                	j	598a <strlen+0x20>

0000000000005994 <memset>:

void*
memset(void *dst, int c, uint n)
{
    5994:	1141                	add	sp,sp,-16
    5996:	e422                	sd	s0,8(sp)
    5998:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    599a:	ca19                	beqz	a2,59b0 <memset+0x1c>
    599c:	87aa                	mv	a5,a0
    599e:	1602                	sll	a2,a2,0x20
    59a0:	9201                	srl	a2,a2,0x20
    59a2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    59a6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    59aa:	0785                	add	a5,a5,1
    59ac:	fee79de3          	bne	a5,a4,59a6 <memset+0x12>
  }
  return dst;
}
    59b0:	6422                	ld	s0,8(sp)
    59b2:	0141                	add	sp,sp,16
    59b4:	8082                	ret

00000000000059b6 <strchr>:

char*
strchr(const char *s, char c)
{
    59b6:	1141                	add	sp,sp,-16
    59b8:	e422                	sd	s0,8(sp)
    59ba:	0800                	add	s0,sp,16
  for(; *s; s++)
    59bc:	00054783          	lbu	a5,0(a0)
    59c0:	cb99                	beqz	a5,59d6 <strchr+0x20>
    if(*s == c)
    59c2:	00f58763          	beq	a1,a5,59d0 <strchr+0x1a>
  for(; *s; s++)
    59c6:	0505                	add	a0,a0,1
    59c8:	00054783          	lbu	a5,0(a0)
    59cc:	fbfd                	bnez	a5,59c2 <strchr+0xc>
      return (char*)s;
  return 0;
    59ce:	4501                	li	a0,0
}
    59d0:	6422                	ld	s0,8(sp)
    59d2:	0141                	add	sp,sp,16
    59d4:	8082                	ret
  return 0;
    59d6:	4501                	li	a0,0
    59d8:	bfe5                	j	59d0 <strchr+0x1a>

00000000000059da <gets>:

char*
gets(char *buf, int max)
{
    59da:	711d                	add	sp,sp,-96
    59dc:	ec86                	sd	ra,88(sp)
    59de:	e8a2                	sd	s0,80(sp)
    59e0:	e4a6                	sd	s1,72(sp)
    59e2:	e0ca                	sd	s2,64(sp)
    59e4:	fc4e                	sd	s3,56(sp)
    59e6:	f852                	sd	s4,48(sp)
    59e8:	f456                	sd	s5,40(sp)
    59ea:	f05a                	sd	s6,32(sp)
    59ec:	ec5e                	sd	s7,24(sp)
    59ee:	1080                	add	s0,sp,96
    59f0:	8baa                	mv	s7,a0
    59f2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    59f4:	892a                	mv	s2,a0
    59f6:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    59f8:	4aa9                	li	s5,10
    59fa:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    59fc:	89a6                	mv	s3,s1
    59fe:	2485                	addw	s1,s1,1
    5a00:	0344d863          	bge	s1,s4,5a30 <gets+0x56>
    cc = read(0, &c, 1);
    5a04:	4605                	li	a2,1
    5a06:	faf40593          	add	a1,s0,-81
    5a0a:	4501                	li	a0,0
    5a0c:	00000097          	auipc	ra,0x0
    5a10:	1d6080e7          	jalr	470(ra) # 5be2 <read>
    if(cc < 1)
    5a14:	00a05e63          	blez	a0,5a30 <gets+0x56>
    buf[i++] = c;
    5a18:	faf44783          	lbu	a5,-81(s0)
    5a1c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    5a20:	01578763          	beq	a5,s5,5a2e <gets+0x54>
    5a24:	0905                	add	s2,s2,1
    5a26:	fd679be3          	bne	a5,s6,59fc <gets+0x22>
  for(i=0; i+1 < max; ){
    5a2a:	89a6                	mv	s3,s1
    5a2c:	a011                	j	5a30 <gets+0x56>
    5a2e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    5a30:	99de                	add	s3,s3,s7
    5a32:	00098023          	sb	zero,0(s3)
  return buf;
}
    5a36:	855e                	mv	a0,s7
    5a38:	60e6                	ld	ra,88(sp)
    5a3a:	6446                	ld	s0,80(sp)
    5a3c:	64a6                	ld	s1,72(sp)
    5a3e:	6906                	ld	s2,64(sp)
    5a40:	79e2                	ld	s3,56(sp)
    5a42:	7a42                	ld	s4,48(sp)
    5a44:	7aa2                	ld	s5,40(sp)
    5a46:	7b02                	ld	s6,32(sp)
    5a48:	6be2                	ld	s7,24(sp)
    5a4a:	6125                	add	sp,sp,96
    5a4c:	8082                	ret

0000000000005a4e <stat>:

int
stat(const char *n, struct stat *st)
{
    5a4e:	1101                	add	sp,sp,-32
    5a50:	ec06                	sd	ra,24(sp)
    5a52:	e822                	sd	s0,16(sp)
    5a54:	e426                	sd	s1,8(sp)
    5a56:	e04a                	sd	s2,0(sp)
    5a58:	1000                	add	s0,sp,32
    5a5a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    5a5c:	4581                	li	a1,0
    5a5e:	00000097          	auipc	ra,0x0
    5a62:	1ac080e7          	jalr	428(ra) # 5c0a <open>
  if(fd < 0)
    5a66:	02054563          	bltz	a0,5a90 <stat+0x42>
    5a6a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    5a6c:	85ca                	mv	a1,s2
    5a6e:	00000097          	auipc	ra,0x0
    5a72:	1b4080e7          	jalr	436(ra) # 5c22 <fstat>
    5a76:	892a                	mv	s2,a0
  close(fd);
    5a78:	8526                	mv	a0,s1
    5a7a:	00000097          	auipc	ra,0x0
    5a7e:	178080e7          	jalr	376(ra) # 5bf2 <close>
  return r;
}
    5a82:	854a                	mv	a0,s2
    5a84:	60e2                	ld	ra,24(sp)
    5a86:	6442                	ld	s0,16(sp)
    5a88:	64a2                	ld	s1,8(sp)
    5a8a:	6902                	ld	s2,0(sp)
    5a8c:	6105                	add	sp,sp,32
    5a8e:	8082                	ret
    return -1;
    5a90:	597d                	li	s2,-1
    5a92:	bfc5                	j	5a82 <stat+0x34>

0000000000005a94 <atoi>:

int
atoi(const char *s)
{
    5a94:	1141                	add	sp,sp,-16
    5a96:	e422                	sd	s0,8(sp)
    5a98:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    5a9a:	00054683          	lbu	a3,0(a0)
    5a9e:	fd06879b          	addw	a5,a3,-48
    5aa2:	0ff7f793          	zext.b	a5,a5
    5aa6:	4625                	li	a2,9
    5aa8:	02f66863          	bltu	a2,a5,5ad8 <atoi+0x44>
    5aac:	872a                	mv	a4,a0
  n = 0;
    5aae:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
    5ab0:	0705                	add	a4,a4,1
    5ab2:	0025179b          	sllw	a5,a0,0x2
    5ab6:	9fa9                	addw	a5,a5,a0
    5ab8:	0017979b          	sllw	a5,a5,0x1
    5abc:	9fb5                	addw	a5,a5,a3
    5abe:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    5ac2:	00074683          	lbu	a3,0(a4)
    5ac6:	fd06879b          	addw	a5,a3,-48
    5aca:	0ff7f793          	zext.b	a5,a5
    5ace:	fef671e3          	bgeu	a2,a5,5ab0 <atoi+0x1c>
  return n;
}
    5ad2:	6422                	ld	s0,8(sp)
    5ad4:	0141                	add	sp,sp,16
    5ad6:	8082                	ret
  n = 0;
    5ad8:	4501                	li	a0,0
    5ada:	bfe5                	j	5ad2 <atoi+0x3e>

0000000000005adc <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    5adc:	1141                	add	sp,sp,-16
    5ade:	e422                	sd	s0,8(sp)
    5ae0:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    5ae2:	02b57463          	bgeu	a0,a1,5b0a <memmove+0x2e>
    while(n-- > 0)
    5ae6:	00c05f63          	blez	a2,5b04 <memmove+0x28>
    5aea:	1602                	sll	a2,a2,0x20
    5aec:	9201                	srl	a2,a2,0x20
    5aee:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    5af2:	872a                	mv	a4,a0
      *dst++ = *src++;
    5af4:	0585                	add	a1,a1,1
    5af6:	0705                	add	a4,a4,1
    5af8:	fff5c683          	lbu	a3,-1(a1)
    5afc:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    5b00:	fee79ae3          	bne	a5,a4,5af4 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    5b04:	6422                	ld	s0,8(sp)
    5b06:	0141                	add	sp,sp,16
    5b08:	8082                	ret
    dst += n;
    5b0a:	00c50733          	add	a4,a0,a2
    src += n;
    5b0e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    5b10:	fec05ae3          	blez	a2,5b04 <memmove+0x28>
    5b14:	fff6079b          	addw	a5,a2,-1
    5b18:	1782                	sll	a5,a5,0x20
    5b1a:	9381                	srl	a5,a5,0x20
    5b1c:	fff7c793          	not	a5,a5
    5b20:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    5b22:	15fd                	add	a1,a1,-1
    5b24:	177d                	add	a4,a4,-1
    5b26:	0005c683          	lbu	a3,0(a1)
    5b2a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    5b2e:	fee79ae3          	bne	a5,a4,5b22 <memmove+0x46>
    5b32:	bfc9                	j	5b04 <memmove+0x28>

0000000000005b34 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    5b34:	1141                	add	sp,sp,-16
    5b36:	e422                	sd	s0,8(sp)
    5b38:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    5b3a:	ca05                	beqz	a2,5b6a <memcmp+0x36>
    5b3c:	fff6069b          	addw	a3,a2,-1
    5b40:	1682                	sll	a3,a3,0x20
    5b42:	9281                	srl	a3,a3,0x20
    5b44:	0685                	add	a3,a3,1
    5b46:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    5b48:	00054783          	lbu	a5,0(a0)
    5b4c:	0005c703          	lbu	a4,0(a1)
    5b50:	00e79863          	bne	a5,a4,5b60 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    5b54:	0505                	add	a0,a0,1
    p2++;
    5b56:	0585                	add	a1,a1,1
  while (n-- > 0) {
    5b58:	fed518e3          	bne	a0,a3,5b48 <memcmp+0x14>
  }
  return 0;
    5b5c:	4501                	li	a0,0
    5b5e:	a019                	j	5b64 <memcmp+0x30>
      return *p1 - *p2;
    5b60:	40e7853b          	subw	a0,a5,a4
}
    5b64:	6422                	ld	s0,8(sp)
    5b66:	0141                	add	sp,sp,16
    5b68:	8082                	ret
  return 0;
    5b6a:	4501                	li	a0,0
    5b6c:	bfe5                	j	5b64 <memcmp+0x30>

0000000000005b6e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    5b6e:	1141                	add	sp,sp,-16
    5b70:	e406                	sd	ra,8(sp)
    5b72:	e022                	sd	s0,0(sp)
    5b74:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
    5b76:	00000097          	auipc	ra,0x0
    5b7a:	f66080e7          	jalr	-154(ra) # 5adc <memmove>
}
    5b7e:	60a2                	ld	ra,8(sp)
    5b80:	6402                	ld	s0,0(sp)
    5b82:	0141                	add	sp,sp,16
    5b84:	8082                	ret

0000000000005b86 <initlock>:

// Initialize the spinlock
void initlock(struct spinlock_u *lk) {
    5b86:	1141                	add	sp,sp,-16
    5b88:	e422                	sd	s0,8(sp)
    5b8a:	0800                	add	s0,sp,16
  lk->locked = 0;
    5b8c:	00052023          	sw	zero,0(a0)
}
    5b90:	6422                	ld	s0,8(sp)
    5b92:	0141                	add	sp,sp,16
    5b94:	8082                	ret

0000000000005b96 <acquire>:

// Acquire the spinlock
void acquire(struct spinlock_u *lk) {
    5b96:	1141                	add	sp,sp,-16
    5b98:	e422                	sd	s0,8(sp)
    5b9a:	0800                	add	s0,sp,16
  while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
    5b9c:	4705                	li	a4,1
    5b9e:	87ba                	mv	a5,a4
    5ba0:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    5ba4:	2781                	sext.w	a5,a5
    5ba6:	ffe5                	bnez	a5,5b9e <acquire+0x8>
    ; // Spin until the lock is acquired
}
    5ba8:	6422                	ld	s0,8(sp)
    5baa:	0141                	add	sp,sp,16
    5bac:	8082                	ret

0000000000005bae <release>:

// Release the spinlock
void release(struct spinlock_u *lk) {
    5bae:	1141                	add	sp,sp,-16
    5bb0:	e422                	sd	s0,8(sp)
    5bb2:	0800                	add	s0,sp,16
  __sync_lock_release(&lk->locked);
    5bb4:	0f50000f          	fence	iorw,ow
    5bb8:	0805202f          	amoswap.w	zero,zero,(a0)
}
    5bbc:	6422                	ld	s0,8(sp)
    5bbe:	0141                	add	sp,sp,16
    5bc0:	8082                	ret

0000000000005bc2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    5bc2:	4885                	li	a7,1
 ecall
    5bc4:	00000073          	ecall
 ret
    5bc8:	8082                	ret

0000000000005bca <exit>:
.global exit
exit:
 li a7, SYS_exit
    5bca:	4889                	li	a7,2
 ecall
    5bcc:	00000073          	ecall
 ret
    5bd0:	8082                	ret

0000000000005bd2 <wait>:
.global wait
wait:
 li a7, SYS_wait
    5bd2:	488d                	li	a7,3
 ecall
    5bd4:	00000073          	ecall
 ret
    5bd8:	8082                	ret

0000000000005bda <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    5bda:	4891                	li	a7,4
 ecall
    5bdc:	00000073          	ecall
 ret
    5be0:	8082                	ret

0000000000005be2 <read>:
.global read
read:
 li a7, SYS_read
    5be2:	4895                	li	a7,5
 ecall
    5be4:	00000073          	ecall
 ret
    5be8:	8082                	ret

0000000000005bea <write>:
.global write
write:
 li a7, SYS_write
    5bea:	48c1                	li	a7,16
 ecall
    5bec:	00000073          	ecall
 ret
    5bf0:	8082                	ret

0000000000005bf2 <close>:
.global close
close:
 li a7, SYS_close
    5bf2:	48d5                	li	a7,21
 ecall
    5bf4:	00000073          	ecall
 ret
    5bf8:	8082                	ret

0000000000005bfa <kill>:
.global kill
kill:
 li a7, SYS_kill
    5bfa:	4899                	li	a7,6
 ecall
    5bfc:	00000073          	ecall
 ret
    5c00:	8082                	ret

0000000000005c02 <exec>:
.global exec
exec:
 li a7, SYS_exec
    5c02:	489d                	li	a7,7
 ecall
    5c04:	00000073          	ecall
 ret
    5c08:	8082                	ret

0000000000005c0a <open>:
.global open
open:
 li a7, SYS_open
    5c0a:	48bd                	li	a7,15
 ecall
    5c0c:	00000073          	ecall
 ret
    5c10:	8082                	ret

0000000000005c12 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    5c12:	48c5                	li	a7,17
 ecall
    5c14:	00000073          	ecall
 ret
    5c18:	8082                	ret

0000000000005c1a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    5c1a:	48c9                	li	a7,18
 ecall
    5c1c:	00000073          	ecall
 ret
    5c20:	8082                	ret

0000000000005c22 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    5c22:	48a1                	li	a7,8
 ecall
    5c24:	00000073          	ecall
 ret
    5c28:	8082                	ret

0000000000005c2a <link>:
.global link
link:
 li a7, SYS_link
    5c2a:	48cd                	li	a7,19
 ecall
    5c2c:	00000073          	ecall
 ret
    5c30:	8082                	ret

0000000000005c32 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    5c32:	48d1                	li	a7,20
 ecall
    5c34:	00000073          	ecall
 ret
    5c38:	8082                	ret

0000000000005c3a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    5c3a:	48a5                	li	a7,9
 ecall
    5c3c:	00000073          	ecall
 ret
    5c40:	8082                	ret

0000000000005c42 <dup>:
.global dup
dup:
 li a7, SYS_dup
    5c42:	48a9                	li	a7,10
 ecall
    5c44:	00000073          	ecall
 ret
    5c48:	8082                	ret

0000000000005c4a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    5c4a:	48ad                	li	a7,11
 ecall
    5c4c:	00000073          	ecall
 ret
    5c50:	8082                	ret

0000000000005c52 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    5c52:	48b1                	li	a7,12
 ecall
    5c54:	00000073          	ecall
 ret
    5c58:	8082                	ret

0000000000005c5a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    5c5a:	48b5                	li	a7,13
 ecall
    5c5c:	00000073          	ecall
 ret
    5c60:	8082                	ret

0000000000005c62 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    5c62:	48b9                	li	a7,14
 ecall
    5c64:	00000073          	ecall
 ret
    5c68:	8082                	ret

0000000000005c6a <rcureadlock>:
.global rcureadlock
rcureadlock:
 li a7, SYS_rcureadlock
    5c6a:	48dd                	li	a7,23
 ecall
    5c6c:	00000073          	ecall
 ret
    5c70:	8082                	ret

0000000000005c72 <rcureadunlock>:
.global rcureadunlock
rcureadunlock:
 li a7, SYS_rcureadunlock
    5c72:	48e1                	li	a7,24
 ecall
    5c74:	00000073          	ecall
 ret
    5c78:	8082                	ret

0000000000005c7a <rcusync>:
.global rcusync
rcusync:
 li a7, SYS_rcusync
    5c7a:	48d9                	li	a7,22
 ecall
    5c7c:	00000073          	ecall
 ret
    5c80:	8082                	ret

0000000000005c82 <thread_create>:
.global thread_create
thread_create:
 li a7, SYS_thread_create
    5c82:	48e5                	li	a7,25
 ecall
    5c84:	00000073          	ecall
 ret
    5c88:	8082                	ret

0000000000005c8a <thread_join>:
.global thread_join
thread_join:
 li a7, SYS_thread_join
    5c8a:	48e9                	li	a7,26
 ecall
    5c8c:	00000073          	ecall
 ret
    5c90:	8082                	ret

0000000000005c92 <thread_exit>:
.global thread_exit
thread_exit:
 li a7, SYS_thread_exit
    5c92:	48ed                	li	a7,27
 ecall
    5c94:	00000073          	ecall
 ret
    5c98:	8082                	ret

0000000000005c9a <klist_insert>:
.global klist_insert
klist_insert:
 li a7, SYS_klist_insert
    5c9a:	48f1                	li	a7,28
 ecall
    5c9c:	00000073          	ecall
 ret
    5ca0:	8082                	ret

0000000000005ca2 <klist_delete>:
.global klist_delete
klist_delete:
 li a7, SYS_klist_delete
    5ca2:	48f5                	li	a7,29
 ecall
    5ca4:	00000073          	ecall
 ret
    5ca8:	8082                	ret

0000000000005caa <klist_query>:
.global klist_query
klist_query:
 li a7, SYS_klist_query
    5caa:	48f9                	li	a7,30
 ecall
    5cac:	00000073          	ecall
 ret
    5cb0:	8082                	ret

0000000000005cb2 <klist_print>:
.global klist_print
klist_print:
 li a7, SYS_klist_print
    5cb2:	48fd                	li	a7,31
 ecall
    5cb4:	00000073          	ecall
 ret
    5cb8:	8082                	ret

0000000000005cba <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    5cba:	1101                	add	sp,sp,-32
    5cbc:	ec06                	sd	ra,24(sp)
    5cbe:	e822                	sd	s0,16(sp)
    5cc0:	1000                	add	s0,sp,32
    5cc2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    5cc6:	4605                	li	a2,1
    5cc8:	fef40593          	add	a1,s0,-17
    5ccc:	00000097          	auipc	ra,0x0
    5cd0:	f1e080e7          	jalr	-226(ra) # 5bea <write>
}
    5cd4:	60e2                	ld	ra,24(sp)
    5cd6:	6442                	ld	s0,16(sp)
    5cd8:	6105                	add	sp,sp,32
    5cda:	8082                	ret

0000000000005cdc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    5cdc:	7139                	add	sp,sp,-64
    5cde:	fc06                	sd	ra,56(sp)
    5ce0:	f822                	sd	s0,48(sp)
    5ce2:	f426                	sd	s1,40(sp)
    5ce4:	f04a                	sd	s2,32(sp)
    5ce6:	ec4e                	sd	s3,24(sp)
    5ce8:	0080                	add	s0,sp,64
    5cea:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    5cec:	c299                	beqz	a3,5cf2 <printint+0x16>
    5cee:	0805c963          	bltz	a1,5d80 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    5cf2:	2581                	sext.w	a1,a1
  neg = 0;
    5cf4:	4881                	li	a7,0
    5cf6:	fc040693          	add	a3,s0,-64
  }

  i = 0;
    5cfa:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    5cfc:	2601                	sext.w	a2,a2
    5cfe:	00003517          	auipc	a0,0x3
    5d02:	a7a50513          	add	a0,a0,-1414 # 8778 <digits>
    5d06:	883a                	mv	a6,a4
    5d08:	2705                	addw	a4,a4,1
    5d0a:	02c5f7bb          	remuw	a5,a1,a2
    5d0e:	1782                	sll	a5,a5,0x20
    5d10:	9381                	srl	a5,a5,0x20
    5d12:	97aa                	add	a5,a5,a0
    5d14:	0007c783          	lbu	a5,0(a5)
    5d18:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    5d1c:	0005879b          	sext.w	a5,a1
    5d20:	02c5d5bb          	divuw	a1,a1,a2
    5d24:	0685                	add	a3,a3,1
    5d26:	fec7f0e3          	bgeu	a5,a2,5d06 <printint+0x2a>
  if(neg)
    5d2a:	00088c63          	beqz	a7,5d42 <printint+0x66>
    buf[i++] = '-';
    5d2e:	fd070793          	add	a5,a4,-48
    5d32:	00878733          	add	a4,a5,s0
    5d36:	02d00793          	li	a5,45
    5d3a:	fef70823          	sb	a5,-16(a4)
    5d3e:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
    5d42:	02e05863          	blez	a4,5d72 <printint+0x96>
    5d46:	fc040793          	add	a5,s0,-64
    5d4a:	00e78933          	add	s2,a5,a4
    5d4e:	fff78993          	add	s3,a5,-1
    5d52:	99ba                	add	s3,s3,a4
    5d54:	377d                	addw	a4,a4,-1
    5d56:	1702                	sll	a4,a4,0x20
    5d58:	9301                	srl	a4,a4,0x20
    5d5a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    5d5e:	fff94583          	lbu	a1,-1(s2)
    5d62:	8526                	mv	a0,s1
    5d64:	00000097          	auipc	ra,0x0
    5d68:	f56080e7          	jalr	-170(ra) # 5cba <putc>
  while(--i >= 0)
    5d6c:	197d                	add	s2,s2,-1
    5d6e:	ff3918e3          	bne	s2,s3,5d5e <printint+0x82>
}
    5d72:	70e2                	ld	ra,56(sp)
    5d74:	7442                	ld	s0,48(sp)
    5d76:	74a2                	ld	s1,40(sp)
    5d78:	7902                	ld	s2,32(sp)
    5d7a:	69e2                	ld	s3,24(sp)
    5d7c:	6121                	add	sp,sp,64
    5d7e:	8082                	ret
    x = -xx;
    5d80:	40b005bb          	negw	a1,a1
    neg = 1;
    5d84:	4885                	li	a7,1
    x = -xx;
    5d86:	bf85                	j	5cf6 <printint+0x1a>

0000000000005d88 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    5d88:	715d                	add	sp,sp,-80
    5d8a:	e486                	sd	ra,72(sp)
    5d8c:	e0a2                	sd	s0,64(sp)
    5d8e:	fc26                	sd	s1,56(sp)
    5d90:	f84a                	sd	s2,48(sp)
    5d92:	f44e                	sd	s3,40(sp)
    5d94:	f052                	sd	s4,32(sp)
    5d96:	ec56                	sd	s5,24(sp)
    5d98:	e85a                	sd	s6,16(sp)
    5d9a:	e45e                	sd	s7,8(sp)
    5d9c:	e062                	sd	s8,0(sp)
    5d9e:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    5da0:	0005c903          	lbu	s2,0(a1)
    5da4:	18090c63          	beqz	s2,5f3c <vprintf+0x1b4>
    5da8:	8aaa                	mv	s5,a0
    5daa:	8bb2                	mv	s7,a2
    5dac:	00158493          	add	s1,a1,1
  state = 0;
    5db0:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    5db2:	02500a13          	li	s4,37
    5db6:	4b55                	li	s6,21
    5db8:	a839                	j	5dd6 <vprintf+0x4e>
        putc(fd, c);
    5dba:	85ca                	mv	a1,s2
    5dbc:	8556                	mv	a0,s5
    5dbe:	00000097          	auipc	ra,0x0
    5dc2:	efc080e7          	jalr	-260(ra) # 5cba <putc>
    5dc6:	a019                	j	5dcc <vprintf+0x44>
    } else if(state == '%'){
    5dc8:	01498d63          	beq	s3,s4,5de2 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
    5dcc:	0485                	add	s1,s1,1
    5dce:	fff4c903          	lbu	s2,-1(s1)
    5dd2:	16090563          	beqz	s2,5f3c <vprintf+0x1b4>
    if(state == 0){
    5dd6:	fe0999e3          	bnez	s3,5dc8 <vprintf+0x40>
      if(c == '%'){
    5dda:	ff4910e3          	bne	s2,s4,5dba <vprintf+0x32>
        state = '%';
    5dde:	89d2                	mv	s3,s4
    5de0:	b7f5                	j	5dcc <vprintf+0x44>
      if(c == 'd'){
    5de2:	13490263          	beq	s2,s4,5f06 <vprintf+0x17e>
    5de6:	f9d9079b          	addw	a5,s2,-99
    5dea:	0ff7f793          	zext.b	a5,a5
    5dee:	12fb6563          	bltu	s6,a5,5f18 <vprintf+0x190>
    5df2:	f9d9079b          	addw	a5,s2,-99
    5df6:	0ff7f713          	zext.b	a4,a5
    5dfa:	10eb6f63          	bltu	s6,a4,5f18 <vprintf+0x190>
    5dfe:	00271793          	sll	a5,a4,0x2
    5e02:	00003717          	auipc	a4,0x3
    5e06:	91e70713          	add	a4,a4,-1762 # 8720 <updateNode+0x24bc>
    5e0a:	97ba                	add	a5,a5,a4
    5e0c:	439c                	lw	a5,0(a5)
    5e0e:	97ba                	add	a5,a5,a4
    5e10:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    5e12:	008b8913          	add	s2,s7,8
    5e16:	4685                	li	a3,1
    5e18:	4629                	li	a2,10
    5e1a:	000ba583          	lw	a1,0(s7)
    5e1e:	8556                	mv	a0,s5
    5e20:	00000097          	auipc	ra,0x0
    5e24:	ebc080e7          	jalr	-324(ra) # 5cdc <printint>
    5e28:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    5e2a:	4981                	li	s3,0
    5e2c:	b745                	j	5dcc <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    5e2e:	008b8913          	add	s2,s7,8
    5e32:	4681                	li	a3,0
    5e34:	4629                	li	a2,10
    5e36:	000ba583          	lw	a1,0(s7)
    5e3a:	8556                	mv	a0,s5
    5e3c:	00000097          	auipc	ra,0x0
    5e40:	ea0080e7          	jalr	-352(ra) # 5cdc <printint>
    5e44:	8bca                	mv	s7,s2
      state = 0;
    5e46:	4981                	li	s3,0
    5e48:	b751                	j	5dcc <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
    5e4a:	008b8913          	add	s2,s7,8
    5e4e:	4681                	li	a3,0
    5e50:	4641                	li	a2,16
    5e52:	000ba583          	lw	a1,0(s7)
    5e56:	8556                	mv	a0,s5
    5e58:	00000097          	auipc	ra,0x0
    5e5c:	e84080e7          	jalr	-380(ra) # 5cdc <printint>
    5e60:	8bca                	mv	s7,s2
      state = 0;
    5e62:	4981                	li	s3,0
    5e64:	b7a5                	j	5dcc <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
    5e66:	008b8c13          	add	s8,s7,8
    5e6a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    5e6e:	03000593          	li	a1,48
    5e72:	8556                	mv	a0,s5
    5e74:	00000097          	auipc	ra,0x0
    5e78:	e46080e7          	jalr	-442(ra) # 5cba <putc>
  putc(fd, 'x');
    5e7c:	07800593          	li	a1,120
    5e80:	8556                	mv	a0,s5
    5e82:	00000097          	auipc	ra,0x0
    5e86:	e38080e7          	jalr	-456(ra) # 5cba <putc>
    5e8a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5e8c:	00003b97          	auipc	s7,0x3
    5e90:	8ecb8b93          	add	s7,s7,-1812 # 8778 <digits>
    5e94:	03c9d793          	srl	a5,s3,0x3c
    5e98:	97de                	add	a5,a5,s7
    5e9a:	0007c583          	lbu	a1,0(a5)
    5e9e:	8556                	mv	a0,s5
    5ea0:	00000097          	auipc	ra,0x0
    5ea4:	e1a080e7          	jalr	-486(ra) # 5cba <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    5ea8:	0992                	sll	s3,s3,0x4
    5eaa:	397d                	addw	s2,s2,-1
    5eac:	fe0914e3          	bnez	s2,5e94 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
    5eb0:	8be2                	mv	s7,s8
      state = 0;
    5eb2:	4981                	li	s3,0
    5eb4:	bf21                	j	5dcc <vprintf+0x44>
        s = va_arg(ap, char*);
    5eb6:	008b8993          	add	s3,s7,8
    5eba:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    5ebe:	02090163          	beqz	s2,5ee0 <vprintf+0x158>
        while(*s != 0){
    5ec2:	00094583          	lbu	a1,0(s2)
    5ec6:	c9a5                	beqz	a1,5f36 <vprintf+0x1ae>
          putc(fd, *s);
    5ec8:	8556                	mv	a0,s5
    5eca:	00000097          	auipc	ra,0x0
    5ece:	df0080e7          	jalr	-528(ra) # 5cba <putc>
          s++;
    5ed2:	0905                	add	s2,s2,1
        while(*s != 0){
    5ed4:	00094583          	lbu	a1,0(s2)
    5ed8:	f9e5                	bnez	a1,5ec8 <vprintf+0x140>
        s = va_arg(ap, char*);
    5eda:	8bce                	mv	s7,s3
      state = 0;
    5edc:	4981                	li	s3,0
    5ede:	b5fd                	j	5dcc <vprintf+0x44>
          s = "(null)";
    5ee0:	00003917          	auipc	s2,0x3
    5ee4:	83890913          	add	s2,s2,-1992 # 8718 <updateNode+0x24b4>
        while(*s != 0){
    5ee8:	02800593          	li	a1,40
    5eec:	bff1                	j	5ec8 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
    5eee:	008b8913          	add	s2,s7,8
    5ef2:	000bc583          	lbu	a1,0(s7)
    5ef6:	8556                	mv	a0,s5
    5ef8:	00000097          	auipc	ra,0x0
    5efc:	dc2080e7          	jalr	-574(ra) # 5cba <putc>
    5f00:	8bca                	mv	s7,s2
      state = 0;
    5f02:	4981                	li	s3,0
    5f04:	b5e1                	j	5dcc <vprintf+0x44>
        putc(fd, c);
    5f06:	02500593          	li	a1,37
    5f0a:	8556                	mv	a0,s5
    5f0c:	00000097          	auipc	ra,0x0
    5f10:	dae080e7          	jalr	-594(ra) # 5cba <putc>
      state = 0;
    5f14:	4981                	li	s3,0
    5f16:	bd5d                	j	5dcc <vprintf+0x44>
        putc(fd, '%');
    5f18:	02500593          	li	a1,37
    5f1c:	8556                	mv	a0,s5
    5f1e:	00000097          	auipc	ra,0x0
    5f22:	d9c080e7          	jalr	-612(ra) # 5cba <putc>
        putc(fd, c);
    5f26:	85ca                	mv	a1,s2
    5f28:	8556                	mv	a0,s5
    5f2a:	00000097          	auipc	ra,0x0
    5f2e:	d90080e7          	jalr	-624(ra) # 5cba <putc>
      state = 0;
    5f32:	4981                	li	s3,0
    5f34:	bd61                	j	5dcc <vprintf+0x44>
        s = va_arg(ap, char*);
    5f36:	8bce                	mv	s7,s3
      state = 0;
    5f38:	4981                	li	s3,0
    5f3a:	bd49                	j	5dcc <vprintf+0x44>
    }
  }
}
    5f3c:	60a6                	ld	ra,72(sp)
    5f3e:	6406                	ld	s0,64(sp)
    5f40:	74e2                	ld	s1,56(sp)
    5f42:	7942                	ld	s2,48(sp)
    5f44:	79a2                	ld	s3,40(sp)
    5f46:	7a02                	ld	s4,32(sp)
    5f48:	6ae2                	ld	s5,24(sp)
    5f4a:	6b42                	ld	s6,16(sp)
    5f4c:	6ba2                	ld	s7,8(sp)
    5f4e:	6c02                	ld	s8,0(sp)
    5f50:	6161                	add	sp,sp,80
    5f52:	8082                	ret

0000000000005f54 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    5f54:	715d                	add	sp,sp,-80
    5f56:	ec06                	sd	ra,24(sp)
    5f58:	e822                	sd	s0,16(sp)
    5f5a:	1000                	add	s0,sp,32
    5f5c:	e010                	sd	a2,0(s0)
    5f5e:	e414                	sd	a3,8(s0)
    5f60:	e818                	sd	a4,16(s0)
    5f62:	ec1c                	sd	a5,24(s0)
    5f64:	03043023          	sd	a6,32(s0)
    5f68:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    5f6c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    5f70:	8622                	mv	a2,s0
    5f72:	00000097          	auipc	ra,0x0
    5f76:	e16080e7          	jalr	-490(ra) # 5d88 <vprintf>
}
    5f7a:	60e2                	ld	ra,24(sp)
    5f7c:	6442                	ld	s0,16(sp)
    5f7e:	6161                	add	sp,sp,80
    5f80:	8082                	ret

0000000000005f82 <printf>:

void
printf(const char *fmt, ...)
{
    5f82:	711d                	add	sp,sp,-96
    5f84:	ec06                	sd	ra,24(sp)
    5f86:	e822                	sd	s0,16(sp)
    5f88:	1000                	add	s0,sp,32
    5f8a:	e40c                	sd	a1,8(s0)
    5f8c:	e810                	sd	a2,16(s0)
    5f8e:	ec14                	sd	a3,24(s0)
    5f90:	f018                	sd	a4,32(s0)
    5f92:	f41c                	sd	a5,40(s0)
    5f94:	03043823          	sd	a6,48(s0)
    5f98:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    5f9c:	00840613          	add	a2,s0,8
    5fa0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    5fa4:	85aa                	mv	a1,a0
    5fa6:	4505                	li	a0,1
    5fa8:	00000097          	auipc	ra,0x0
    5fac:	de0080e7          	jalr	-544(ra) # 5d88 <vprintf>
}
    5fb0:	60e2                	ld	ra,24(sp)
    5fb2:	6442                	ld	s0,16(sp)
    5fb4:	6125                	add	sp,sp,96
    5fb6:	8082                	ret

0000000000005fb8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    5fb8:	1141                	add	sp,sp,-16
    5fba:	e422                	sd	s0,8(sp)
    5fbc:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    5fbe:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5fc2:	00003797          	auipc	a5,0x3
    5fc6:	48e7b783          	ld	a5,1166(a5) # 9450 <freep>
    5fca:	a02d                	j	5ff4 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    5fcc:	4618                	lw	a4,8(a2)
    5fce:	9f2d                	addw	a4,a4,a1
    5fd0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    5fd4:	6398                	ld	a4,0(a5)
    5fd6:	6310                	ld	a2,0(a4)
    5fd8:	a83d                	j	6016 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    5fda:	ff852703          	lw	a4,-8(a0)
    5fde:	9f31                	addw	a4,a4,a2
    5fe0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    5fe2:	ff053683          	ld	a3,-16(a0)
    5fe6:	a091                	j	602a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5fe8:	6398                	ld	a4,0(a5)
    5fea:	00e7e463          	bltu	a5,a4,5ff2 <free+0x3a>
    5fee:	00e6ea63          	bltu	a3,a4,6002 <free+0x4a>
{
    5ff2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5ff4:	fed7fae3          	bgeu	a5,a3,5fe8 <free+0x30>
    5ff8:	6398                	ld	a4,0(a5)
    5ffa:	00e6e463          	bltu	a3,a4,6002 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5ffe:	fee7eae3          	bltu	a5,a4,5ff2 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    6002:	ff852583          	lw	a1,-8(a0)
    6006:	6390                	ld	a2,0(a5)
    6008:	02059813          	sll	a6,a1,0x20
    600c:	01c85713          	srl	a4,a6,0x1c
    6010:	9736                	add	a4,a4,a3
    6012:	fae60de3          	beq	a2,a4,5fcc <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    6016:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    601a:	4790                	lw	a2,8(a5)
    601c:	02061593          	sll	a1,a2,0x20
    6020:	01c5d713          	srl	a4,a1,0x1c
    6024:	973e                	add	a4,a4,a5
    6026:	fae68ae3          	beq	a3,a4,5fda <free+0x22>
    p->s.ptr = bp->s.ptr;
    602a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    602c:	00003717          	auipc	a4,0x3
    6030:	42f73223          	sd	a5,1060(a4) # 9450 <freep>
}
    6034:	6422                	ld	s0,8(sp)
    6036:	0141                	add	sp,sp,16
    6038:	8082                	ret

000000000000603a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    603a:	7139                	add	sp,sp,-64
    603c:	fc06                	sd	ra,56(sp)
    603e:	f822                	sd	s0,48(sp)
    6040:	f426                	sd	s1,40(sp)
    6042:	f04a                	sd	s2,32(sp)
    6044:	ec4e                	sd	s3,24(sp)
    6046:	e852                	sd	s4,16(sp)
    6048:	e456                	sd	s5,8(sp)
    604a:	e05a                	sd	s6,0(sp)
    604c:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    604e:	02051493          	sll	s1,a0,0x20
    6052:	9081                	srl	s1,s1,0x20
    6054:	04bd                	add	s1,s1,15
    6056:	8091                	srl	s1,s1,0x4
    6058:	0014899b          	addw	s3,s1,1
    605c:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    605e:	00003517          	auipc	a0,0x3
    6062:	3f253503          	ld	a0,1010(a0) # 9450 <freep>
    6066:	c515                	beqz	a0,6092 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    6068:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    606a:	4798                	lw	a4,8(a5)
    606c:	02977f63          	bgeu	a4,s1,60aa <malloc+0x70>
  if(nu < 4096)
    6070:	8a4e                	mv	s4,s3
    6072:	0009871b          	sext.w	a4,s3
    6076:	6685                	lui	a3,0x1
    6078:	00d77363          	bgeu	a4,a3,607e <malloc+0x44>
    607c:	6a05                	lui	s4,0x1
    607e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    6082:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    6086:	00003917          	auipc	s2,0x3
    608a:	3ca90913          	add	s2,s2,970 # 9450 <freep>
  if(p == (char*)-1)
    608e:	5afd                	li	s5,-1
    6090:	a895                	j	6104 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
    6092:	0000a797          	auipc	a5,0xa
    6096:	be678793          	add	a5,a5,-1050 # fc78 <base>
    609a:	00003717          	auipc	a4,0x3
    609e:	3af73b23          	sd	a5,950(a4) # 9450 <freep>
    60a2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    60a4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    60a8:	b7e1                	j	6070 <malloc+0x36>
      if(p->s.size == nunits)
    60aa:	02e48c63          	beq	s1,a4,60e2 <malloc+0xa8>
        p->s.size -= nunits;
    60ae:	4137073b          	subw	a4,a4,s3
    60b2:	c798                	sw	a4,8(a5)
        p += p->s.size;
    60b4:	02071693          	sll	a3,a4,0x20
    60b8:	01c6d713          	srl	a4,a3,0x1c
    60bc:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    60be:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    60c2:	00003717          	auipc	a4,0x3
    60c6:	38a73723          	sd	a0,910(a4) # 9450 <freep>
      return (void*)(p + 1);
    60ca:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    60ce:	70e2                	ld	ra,56(sp)
    60d0:	7442                	ld	s0,48(sp)
    60d2:	74a2                	ld	s1,40(sp)
    60d4:	7902                	ld	s2,32(sp)
    60d6:	69e2                	ld	s3,24(sp)
    60d8:	6a42                	ld	s4,16(sp)
    60da:	6aa2                	ld	s5,8(sp)
    60dc:	6b02                	ld	s6,0(sp)
    60de:	6121                	add	sp,sp,64
    60e0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    60e2:	6398                	ld	a4,0(a5)
    60e4:	e118                	sd	a4,0(a0)
    60e6:	bff1                	j	60c2 <malloc+0x88>
  hp->s.size = nu;
    60e8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    60ec:	0541                	add	a0,a0,16
    60ee:	00000097          	auipc	ra,0x0
    60f2:	eca080e7          	jalr	-310(ra) # 5fb8 <free>
  return freep;
    60f6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    60fa:	d971                	beqz	a0,60ce <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    60fc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    60fe:	4798                	lw	a4,8(a5)
    6100:	fa9775e3          	bgeu	a4,s1,60aa <malloc+0x70>
    if(p == freep)
    6104:	00093703          	ld	a4,0(s2)
    6108:	853e                	mv	a0,a5
    610a:	fef719e3          	bne	a4,a5,60fc <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
    610e:	8552                	mv	a0,s4
    6110:	00000097          	auipc	ra,0x0
    6114:	b42080e7          	jalr	-1214(ra) # 5c52 <sbrk>
  if(p == (char*)-1)
    6118:	fd5518e3          	bne	a0,s5,60e8 <malloc+0xae>
        return 0;
    611c:	4501                	li	a0,0
    611e:	bf45                	j	60ce <malloc+0x94>

0000000000006120 <init_lock>:
#include "linkedlist.h"

// Define a node structure for the linked list
struct spinlock_u list_lock;

void init_lock(){
    6120:	1141                	add	sp,sp,-16
    6122:	e406                	sd	ra,8(sp)
    6124:	e022                	sd	s0,0(sp)
    6126:	0800                	add	s0,sp,16
    initlock(&list_lock);
    6128:	00003517          	auipc	a0,0x3
    612c:	33050513          	add	a0,a0,816 # 9458 <list_lock>
    6130:	00000097          	auipc	ra,0x0
    6134:	a56080e7          	jalr	-1450(ra) # 5b86 <initlock>
}
    6138:	60a2                	ld	ra,8(sp)
    613a:	6402                	ld	s0,0(sp)
    613c:	0141                	add	sp,sp,16
    613e:	8082                	ret

0000000000006140 <insert>:

// Function to insert a node at the beginning of the linked list
void insert(struct Node **head_ref, int new_data) {
    6140:	1101                	add	sp,sp,-32
    6142:	ec06                	sd	ra,24(sp)
    6144:	e822                	sd	s0,16(sp)
    6146:	e426                	sd	s1,8(sp)
    6148:	e04a                	sd	s2,0(sp)
    614a:	1000                	add	s0,sp,32
    614c:	84aa                	mv	s1,a0
    614e:	892e                	mv	s2,a1
    struct Node *new_node = malloc(sizeof(struct Node));
    6150:	4541                	li	a0,16
    6152:	00000097          	auipc	ra,0x0
    6156:	ee8080e7          	jalr	-280(ra) # 603a <malloc>
    new_node->data = new_data;
    615a:	01252023          	sw	s2,0(a0)
    new_node->next = *head_ref;
    615e:	609c                	ld	a5,0(s1)
    6160:	e51c                	sd	a5,8(a0)
    *head_ref = new_node;
    6162:	e088                	sd	a0,0(s1)
}
    6164:	60e2                	ld	ra,24(sp)
    6166:	6442                	ld	s0,16(sp)
    6168:	64a2                	ld	s1,8(sp)
    616a:	6902                	ld	s2,0(sp)
    616c:	6105                	add	sp,sp,32
    616e:	8082                	ret

0000000000006170 <deleteNode>:

// Function to delete a node with a given key from the linked list
void deleteNode(struct Node **head_ref, int key) {
    6170:	7179                	add	sp,sp,-48
    6172:	f406                	sd	ra,40(sp)
    6174:	f022                	sd	s0,32(sp)
    6176:	ec26                	sd	s1,24(sp)
    6178:	e84a                	sd	s2,16(sp)
    617a:	e44e                	sd	s3,8(sp)
    617c:	1800                	add	s0,sp,48
    617e:	89aa                	mv	s3,a0
    6180:	892e                	mv	s2,a1
    struct Node *temp = *head_ref, *prev = 0;
    6182:	6104                	ld	s1,0(a0)

    acquire(&list_lock);
    6184:	00003517          	auipc	a0,0x3
    6188:	2d450513          	add	a0,a0,724 # 9458 <list_lock>
    618c:	00000097          	auipc	ra,0x0
    6190:	a0a080e7          	jalr	-1526(ra) # 5b96 <acquire>
    if (temp != 0 && temp->data == key) {
    6194:	c0b1                	beqz	s1,61d8 <deleteNode+0x68>
    6196:	409c                	lw	a5,0(s1)
    6198:	4701                	li	a4,0
    619a:	01278a63          	beq	a5,s2,61ae <deleteNode+0x3e>
        rcusync();
        free(temp);
        return;
    }

    while (temp != 0 && temp->data != key) {
    619e:	409c                	lw	a5,0(s1)
    61a0:	05278563          	beq	a5,s2,61ea <deleteNode+0x7a>
        prev = temp;
        temp = temp->next;
    61a4:	649c                	ld	a5,8(s1)
    while (temp != 0 && temp->data != key) {
    61a6:	8726                	mv	a4,s1
    61a8:	cb85                	beqz	a5,61d8 <deleteNode+0x68>
        temp = temp->next;
    61aa:	84be                	mv	s1,a5
    61ac:	bfcd                	j	619e <deleteNode+0x2e>
        *head_ref = temp->next;
    61ae:	649c                	ld	a5,8(s1)
    61b0:	00f9b023          	sd	a5,0(s3)
        release(&list_lock);
    61b4:	00003517          	auipc	a0,0x3
    61b8:	2a450513          	add	a0,a0,676 # 9458 <list_lock>
    61bc:	00000097          	auipc	ra,0x0
    61c0:	9f2080e7          	jalr	-1550(ra) # 5bae <release>
        rcusync();
    61c4:	00000097          	auipc	ra,0x0
    61c8:	ab6080e7          	jalr	-1354(ra) # 5c7a <rcusync>
        free(temp);
    61cc:	8526                	mv	a0,s1
    61ce:	00000097          	auipc	ra,0x0
    61d2:	dea080e7          	jalr	-534(ra) # 5fb8 <free>
        return;
    61d6:	a82d                	j	6210 <deleteNode+0xa0>
    }

    if (temp == 0) {
        release(&list_lock);
    61d8:	00003517          	auipc	a0,0x3
    61dc:	28050513          	add	a0,a0,640 # 9458 <list_lock>
    61e0:	00000097          	auipc	ra,0x0
    61e4:	9ce080e7          	jalr	-1586(ra) # 5bae <release>
        return;
    61e8:	a025                	j	6210 <deleteNode+0xa0>
    }
    prev->next = temp->next;
    61ea:	649c                	ld	a5,8(s1)
    61ec:	e71c                	sd	a5,8(a4)
    release(&list_lock);
    61ee:	00003517          	auipc	a0,0x3
    61f2:	26a50513          	add	a0,a0,618 # 9458 <list_lock>
    61f6:	00000097          	auipc	ra,0x0
    61fa:	9b8080e7          	jalr	-1608(ra) # 5bae <release>
    rcusync();
    61fe:	00000097          	auipc	ra,0x0
    6202:	a7c080e7          	jalr	-1412(ra) # 5c7a <rcusync>
    free(temp);
    6206:	8526                	mv	a0,s1
    6208:	00000097          	auipc	ra,0x0
    620c:	db0080e7          	jalr	-592(ra) # 5fb8 <free>
}
    6210:	70a2                	ld	ra,40(sp)
    6212:	7402                	ld	s0,32(sp)
    6214:	64e2                	ld	s1,24(sp)
    6216:	6942                	ld	s2,16(sp)
    6218:	69a2                	ld	s3,8(sp)
    621a:	6145                	add	sp,sp,48
    621c:	8082                	ret

000000000000621e <search>:

// Function to search for a node with a given key in the linked list
struct Node* search(struct Node *head, int key) {
    621e:	1101                	add	sp,sp,-32
    6220:	ec06                	sd	ra,24(sp)
    6222:	e822                	sd	s0,16(sp)
    6224:	e426                	sd	s1,8(sp)
    6226:	e04a                	sd	s2,0(sp)
    6228:	1000                	add	s0,sp,32
    622a:	84aa                	mv	s1,a0
    622c:	892e                	mv	s2,a1

    struct Node *current = head;
    rcureadlock();
    622e:	00000097          	auipc	ra,0x0
    6232:	a3c080e7          	jalr	-1476(ra) # 5c6a <rcureadlock>
    while (current != 0) {
    6236:	c491                	beqz	s1,6242 <search+0x24>
        if (current->data == key) {
    6238:	409c                	lw	a5,0(s1)
    623a:	01278f63          	beq	a5,s2,6258 <search+0x3a>
            rcureadunlock();
            return current; // Node found
        }
        current = current->next;
    623e:	6484                	ld	s1,8(s1)
    while (current != 0) {
    6240:	fce5                	bnez	s1,6238 <search+0x1a>
    }
    rcureadunlock();
    6242:	00000097          	auipc	ra,0x0
    6246:	a30080e7          	jalr	-1488(ra) # 5c72 <rcureadunlock>
    return 0; // Node not found
    624a:	4501                	li	a0,0
}
    624c:	60e2                	ld	ra,24(sp)
    624e:	6442                	ld	s0,16(sp)
    6250:	64a2                	ld	s1,8(sp)
    6252:	6902                	ld	s2,0(sp)
    6254:	6105                	add	sp,sp,32
    6256:	8082                	ret
            rcureadunlock();
    6258:	00000097          	auipc	ra,0x0
    625c:	a1a080e7          	jalr	-1510(ra) # 5c72 <rcureadunlock>
            return current; // Node found
    6260:	8526                	mv	a0,s1
    6262:	b7ed                	j	624c <search+0x2e>

0000000000006264 <updateNode>:

// Function to update the value of a node with a given key in the linked list
void updateNode(struct Node *head, int key, int new_data) {
    6264:	1101                	add	sp,sp,-32
    6266:	ec06                	sd	ra,24(sp)
    6268:	e822                	sd	s0,16(sp)
    626a:	e426                	sd	s1,8(sp)
    626c:	e04a                	sd	s2,0(sp)
    626e:	1000                	add	s0,sp,32
    6270:	892e                	mv	s2,a1
    6272:	84b2                	mv	s1,a2
    struct Node *nodeToUpdate = search(head, key);
    6274:	00000097          	auipc	ra,0x0
    6278:	faa080e7          	jalr	-86(ra) # 621e <search>

    if (nodeToUpdate != 0) {
    627c:	c901                	beqz	a0,628c <updateNode+0x28>
        nodeToUpdate->data = new_data; // Update the node's data
    627e:	c104                	sw	s1,0(a0)
    } else {
        printf("Node with key %d not found.\n", key);
    }
}
    6280:	60e2                	ld	ra,24(sp)
    6282:	6442                	ld	s0,16(sp)
    6284:	64a2                	ld	s1,8(sp)
    6286:	6902                	ld	s2,0(sp)
    6288:	6105                	add	sp,sp,32
    628a:	8082                	ret
        printf("Node with key %d not found.\n", key);
    628c:	85ca                	mv	a1,s2
    628e:	00002517          	auipc	a0,0x2
    6292:	50250513          	add	a0,a0,1282 # 8790 <digits+0x18>
    6296:	00000097          	auipc	ra,0x0
    629a:	cec080e7          	jalr	-788(ra) # 5f82 <printf>
}
    629e:	b7cd                	j	6280 <updateNode+0x1c>
