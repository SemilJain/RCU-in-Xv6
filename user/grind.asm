
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	1141                	add	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	add	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       6:	611c                	ld	a5,0(a0)
       8:	80000737          	lui	a4,0x80000
       c:	ffe74713          	xor	a4,a4,-2
      10:	02e7f7b3          	remu	a5,a5,a4
      14:	0785                	add	a5,a5,1
    hi = x / 127773;
    lo = x % 127773;
      16:	66fd                	lui	a3,0x1f
      18:	31d68693          	add	a3,a3,797 # 1f31d <base+0x1cf15>
      1c:	02d7e733          	rem	a4,a5,a3
    x = 16807 * lo - 2836 * hi;
      20:	6611                	lui	a2,0x4
      22:	1a760613          	add	a2,a2,423 # 41a7 <base+0x1d9f>
      26:	02c70733          	mul	a4,a4,a2
    hi = x / 127773;
      2a:	02d7c7b3          	div	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      2e:	76fd                	lui	a3,0xfffff
      30:	4ec68693          	add	a3,a3,1260 # fffffffffffff4ec <base+0xffffffffffffd0e4>
      34:	02d787b3          	mul	a5,a5,a3
      38:	97ba                	add	a5,a5,a4
    if (x < 0)
      3a:	0007c963          	bltz	a5,4c <do_rand+0x4c>
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      3e:	17fd                	add	a5,a5,-1
    *ctx = x;
      40:	e11c                	sd	a5,0(a0)
    return (x);
}
      42:	0007851b          	sext.w	a0,a5
      46:	6422                	ld	s0,8(sp)
      48:	0141                	add	sp,sp,16
      4a:	8082                	ret
        x += 0x7fffffff;
      4c:	80000737          	lui	a4,0x80000
      50:	fff74713          	not	a4,a4
      54:	97ba                	add	a5,a5,a4
      56:	b7e5                	j	3e <do_rand+0x3e>

0000000000000058 <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      58:	1141                	add	sp,sp,-16
      5a:	e406                	sd	ra,8(sp)
      5c:	e022                	sd	s0,0(sp)
      5e:	0800                	add	s0,sp,16
    return (do_rand(&rand_next));
      60:	00002517          	auipc	a0,0x2
      64:	fa050513          	add	a0,a0,-96 # 2000 <rand_next>
      68:	00000097          	auipc	ra,0x0
      6c:	f98080e7          	jalr	-104(ra) # 0 <do_rand>
}
      70:	60a2                	ld	ra,8(sp)
      72:	6402                	ld	s0,0(sp)
      74:	0141                	add	sp,sp,16
      76:	8082                	ret

0000000000000078 <go>:

void
go(int which_child)
{
      78:	7159                	add	sp,sp,-112
      7a:	f486                	sd	ra,104(sp)
      7c:	f0a2                	sd	s0,96(sp)
      7e:	eca6                	sd	s1,88(sp)
      80:	e8ca                	sd	s2,80(sp)
      82:	e4ce                	sd	s3,72(sp)
      84:	e0d2                	sd	s4,64(sp)
      86:	fc56                	sd	s5,56(sp)
      88:	f85a                	sd	s6,48(sp)
      8a:	1880                	add	s0,sp,112
      8c:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      8e:	4501                	li	a0,0
      90:	00001097          	auipc	ra,0x1
      94:	e62080e7          	jalr	-414(ra) # ef2 <sbrk>
      98:	8aaa                	mv	s5,a0
  uint64 iters = 0;

  mkdir("grindir");
      9a:	00001517          	auipc	a0,0x1
      9e:	4a650513          	add	a0,a0,1190 # 1540 <updateNode+0x3c>
      a2:	00001097          	auipc	ra,0x1
      a6:	e30080e7          	jalr	-464(ra) # ed2 <mkdir>
  if(chdir("grindir") != 0){
      aa:	00001517          	auipc	a0,0x1
      ae:	49650513          	add	a0,a0,1174 # 1540 <updateNode+0x3c>
      b2:	00001097          	auipc	ra,0x1
      b6:	e28080e7          	jalr	-472(ra) # eda <chdir>
      ba:	cd11                	beqz	a0,d6 <go+0x5e>
    printf("grind: chdir grindir failed\n");
      bc:	00001517          	auipc	a0,0x1
      c0:	48c50513          	add	a0,a0,1164 # 1548 <updateNode+0x44>
      c4:	00001097          	auipc	ra,0x1
      c8:	15e080e7          	jalr	350(ra) # 1222 <printf>
    exit(1);
      cc:	4505                	li	a0,1
      ce:	00001097          	auipc	ra,0x1
      d2:	d9c080e7          	jalr	-612(ra) # e6a <exit>
  }
  chdir("/");
      d6:	00001517          	auipc	a0,0x1
      da:	49250513          	add	a0,a0,1170 # 1568 <updateNode+0x64>
      de:	00001097          	auipc	ra,0x1
      e2:	dfc080e7          	jalr	-516(ra) # eda <chdir>
      e6:	00001997          	auipc	s3,0x1
      ea:	49298993          	add	s3,s3,1170 # 1578 <updateNode+0x74>
      ee:	c489                	beqz	s1,f8 <go+0x80>
      f0:	00001997          	auipc	s3,0x1
      f4:	48098993          	add	s3,s3,1152 # 1570 <updateNode+0x6c>
  uint64 iters = 0;
      f8:	4481                	li	s1,0
  int fd = -1;
      fa:	5a7d                	li	s4,-1
      fc:	00001917          	auipc	s2,0x1
     100:	72c90913          	add	s2,s2,1836 # 1828 <updateNode+0x324>
     104:	a839                	j	122 <go+0xaa>
    iters++;
    if((iters % 500) == 0)
      write(1, which_child?"B":"A", 1);
    int what = rand() % 23;
    if(what == 1){
      close(open("grindir/../a", O_CREATE|O_RDWR));
     106:	20200593          	li	a1,514
     10a:	00001517          	auipc	a0,0x1
     10e:	47650513          	add	a0,a0,1142 # 1580 <updateNode+0x7c>
     112:	00001097          	auipc	ra,0x1
     116:	d98080e7          	jalr	-616(ra) # eaa <open>
     11a:	00001097          	auipc	ra,0x1
     11e:	d78080e7          	jalr	-648(ra) # e92 <close>
    iters++;
     122:	0485                	add	s1,s1,1
    if((iters % 500) == 0)
     124:	1f400793          	li	a5,500
     128:	02f4f7b3          	remu	a5,s1,a5
     12c:	eb81                	bnez	a5,13c <go+0xc4>
      write(1, which_child?"B":"A", 1);
     12e:	4605                	li	a2,1
     130:	85ce                	mv	a1,s3
     132:	4505                	li	a0,1
     134:	00001097          	auipc	ra,0x1
     138:	d56080e7          	jalr	-682(ra) # e8a <write>
    int what = rand() % 23;
     13c:	00000097          	auipc	ra,0x0
     140:	f1c080e7          	jalr	-228(ra) # 58 <rand>
     144:	47dd                	li	a5,23
     146:	02f5653b          	remw	a0,a0,a5
    if(what == 1){
     14a:	4785                	li	a5,1
     14c:	faf50de3          	beq	a0,a5,106 <go+0x8e>
    } else if(what == 2){
     150:	47d9                	li	a5,22
     152:	fca7e8e3          	bltu	a5,a0,122 <go+0xaa>
     156:	050a                	sll	a0,a0,0x2
     158:	954a                	add	a0,a0,s2
     15a:	411c                	lw	a5,0(a0)
     15c:	97ca                	add	a5,a5,s2
     15e:	8782                	jr	a5
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     160:	20200593          	li	a1,514
     164:	00001517          	auipc	a0,0x1
     168:	42c50513          	add	a0,a0,1068 # 1590 <updateNode+0x8c>
     16c:	00001097          	auipc	ra,0x1
     170:	d3e080e7          	jalr	-706(ra) # eaa <open>
     174:	00001097          	auipc	ra,0x1
     178:	d1e080e7          	jalr	-738(ra) # e92 <close>
     17c:	b75d                	j	122 <go+0xaa>
    } else if(what == 3){
      unlink("grindir/../a");
     17e:	00001517          	auipc	a0,0x1
     182:	40250513          	add	a0,a0,1026 # 1580 <updateNode+0x7c>
     186:	00001097          	auipc	ra,0x1
     18a:	d34080e7          	jalr	-716(ra) # eba <unlink>
     18e:	bf51                	j	122 <go+0xaa>
    } else if(what == 4){
      if(chdir("grindir") != 0){
     190:	00001517          	auipc	a0,0x1
     194:	3b050513          	add	a0,a0,944 # 1540 <updateNode+0x3c>
     198:	00001097          	auipc	ra,0x1
     19c:	d42080e7          	jalr	-702(ra) # eda <chdir>
     1a0:	e115                	bnez	a0,1c4 <go+0x14c>
        printf("grind: chdir grindir failed\n");
        exit(1);
      }
      unlink("../b");
     1a2:	00001517          	auipc	a0,0x1
     1a6:	40650513          	add	a0,a0,1030 # 15a8 <updateNode+0xa4>
     1aa:	00001097          	auipc	ra,0x1
     1ae:	d10080e7          	jalr	-752(ra) # eba <unlink>
      chdir("/");
     1b2:	00001517          	auipc	a0,0x1
     1b6:	3b650513          	add	a0,a0,950 # 1568 <updateNode+0x64>
     1ba:	00001097          	auipc	ra,0x1
     1be:	d20080e7          	jalr	-736(ra) # eda <chdir>
     1c2:	b785                	j	122 <go+0xaa>
        printf("grind: chdir grindir failed\n");
     1c4:	00001517          	auipc	a0,0x1
     1c8:	38450513          	add	a0,a0,900 # 1548 <updateNode+0x44>
     1cc:	00001097          	auipc	ra,0x1
     1d0:	056080e7          	jalr	86(ra) # 1222 <printf>
        exit(1);
     1d4:	4505                	li	a0,1
     1d6:	00001097          	auipc	ra,0x1
     1da:	c94080e7          	jalr	-876(ra) # e6a <exit>
    } else if(what == 5){
      close(fd);
     1de:	8552                	mv	a0,s4
     1e0:	00001097          	auipc	ra,0x1
     1e4:	cb2080e7          	jalr	-846(ra) # e92 <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     1e8:	20200593          	li	a1,514
     1ec:	00001517          	auipc	a0,0x1
     1f0:	3c450513          	add	a0,a0,964 # 15b0 <updateNode+0xac>
     1f4:	00001097          	auipc	ra,0x1
     1f8:	cb6080e7          	jalr	-842(ra) # eaa <open>
     1fc:	8a2a                	mv	s4,a0
     1fe:	b715                	j	122 <go+0xaa>
    } else if(what == 6){
      close(fd);
     200:	8552                	mv	a0,s4
     202:	00001097          	auipc	ra,0x1
     206:	c90080e7          	jalr	-880(ra) # e92 <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     20a:	20200593          	li	a1,514
     20e:	00001517          	auipc	a0,0x1
     212:	3b250513          	add	a0,a0,946 # 15c0 <updateNode+0xbc>
     216:	00001097          	auipc	ra,0x1
     21a:	c94080e7          	jalr	-876(ra) # eaa <open>
     21e:	8a2a                	mv	s4,a0
     220:	b709                	j	122 <go+0xaa>
    } else if(what == 7){
      write(fd, buf, sizeof(buf));
     222:	3e700613          	li	a2,999
     226:	00002597          	auipc	a1,0x2
     22a:	dfa58593          	add	a1,a1,-518 # 2020 <buf.0>
     22e:	8552                	mv	a0,s4
     230:	00001097          	auipc	ra,0x1
     234:	c5a080e7          	jalr	-934(ra) # e8a <write>
     238:	b5ed                	j	122 <go+0xaa>
    } else if(what == 8){
      read(fd, buf, sizeof(buf));
     23a:	3e700613          	li	a2,999
     23e:	00002597          	auipc	a1,0x2
     242:	de258593          	add	a1,a1,-542 # 2020 <buf.0>
     246:	8552                	mv	a0,s4
     248:	00001097          	auipc	ra,0x1
     24c:	c3a080e7          	jalr	-966(ra) # e82 <read>
     250:	bdc9                	j	122 <go+0xaa>
    } else if(what == 9){
      mkdir("grindir/../a");
     252:	00001517          	auipc	a0,0x1
     256:	32e50513          	add	a0,a0,814 # 1580 <updateNode+0x7c>
     25a:	00001097          	auipc	ra,0x1
     25e:	c78080e7          	jalr	-904(ra) # ed2 <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     262:	20200593          	li	a1,514
     266:	00001517          	auipc	a0,0x1
     26a:	37250513          	add	a0,a0,882 # 15d8 <updateNode+0xd4>
     26e:	00001097          	auipc	ra,0x1
     272:	c3c080e7          	jalr	-964(ra) # eaa <open>
     276:	00001097          	auipc	ra,0x1
     27a:	c1c080e7          	jalr	-996(ra) # e92 <close>
      unlink("a/a");
     27e:	00001517          	auipc	a0,0x1
     282:	36a50513          	add	a0,a0,874 # 15e8 <updateNode+0xe4>
     286:	00001097          	auipc	ra,0x1
     28a:	c34080e7          	jalr	-972(ra) # eba <unlink>
     28e:	bd51                	j	122 <go+0xaa>
    } else if(what == 10){
      mkdir("/../b");
     290:	00001517          	auipc	a0,0x1
     294:	36050513          	add	a0,a0,864 # 15f0 <updateNode+0xec>
     298:	00001097          	auipc	ra,0x1
     29c:	c3a080e7          	jalr	-966(ra) # ed2 <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     2a0:	20200593          	li	a1,514
     2a4:	00001517          	auipc	a0,0x1
     2a8:	35450513          	add	a0,a0,852 # 15f8 <updateNode+0xf4>
     2ac:	00001097          	auipc	ra,0x1
     2b0:	bfe080e7          	jalr	-1026(ra) # eaa <open>
     2b4:	00001097          	auipc	ra,0x1
     2b8:	bde080e7          	jalr	-1058(ra) # e92 <close>
      unlink("b/b");
     2bc:	00001517          	auipc	a0,0x1
     2c0:	34c50513          	add	a0,a0,844 # 1608 <updateNode+0x104>
     2c4:	00001097          	auipc	ra,0x1
     2c8:	bf6080e7          	jalr	-1034(ra) # eba <unlink>
     2cc:	bd99                	j	122 <go+0xaa>
    } else if(what == 11){
      unlink("b");
     2ce:	00001517          	auipc	a0,0x1
     2d2:	30250513          	add	a0,a0,770 # 15d0 <updateNode+0xcc>
     2d6:	00001097          	auipc	ra,0x1
     2da:	be4080e7          	jalr	-1052(ra) # eba <unlink>
      link("../grindir/./../a", "../b");
     2de:	00001597          	auipc	a1,0x1
     2e2:	2ca58593          	add	a1,a1,714 # 15a8 <updateNode+0xa4>
     2e6:	00001517          	auipc	a0,0x1
     2ea:	32a50513          	add	a0,a0,810 # 1610 <updateNode+0x10c>
     2ee:	00001097          	auipc	ra,0x1
     2f2:	bdc080e7          	jalr	-1060(ra) # eca <link>
     2f6:	b535                	j	122 <go+0xaa>
    } else if(what == 12){
      unlink("../grindir/../a");
     2f8:	00001517          	auipc	a0,0x1
     2fc:	33050513          	add	a0,a0,816 # 1628 <updateNode+0x124>
     300:	00001097          	auipc	ra,0x1
     304:	bba080e7          	jalr	-1094(ra) # eba <unlink>
      link(".././b", "/grindir/../a");
     308:	00001597          	auipc	a1,0x1
     30c:	2a858593          	add	a1,a1,680 # 15b0 <updateNode+0xac>
     310:	00001517          	auipc	a0,0x1
     314:	32850513          	add	a0,a0,808 # 1638 <updateNode+0x134>
     318:	00001097          	auipc	ra,0x1
     31c:	bb2080e7          	jalr	-1102(ra) # eca <link>
     320:	b509                	j	122 <go+0xaa>
    } else if(what == 13){
      int pid = fork();
     322:	00001097          	auipc	ra,0x1
     326:	b40080e7          	jalr	-1216(ra) # e62 <fork>
      if(pid == 0){
     32a:	c909                	beqz	a0,33c <go+0x2c4>
        exit(0);
      } else if(pid < 0){
     32c:	00054c63          	bltz	a0,344 <go+0x2cc>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     330:	4501                	li	a0,0
     332:	00001097          	auipc	ra,0x1
     336:	b40080e7          	jalr	-1216(ra) # e72 <wait>
     33a:	b3e5                	j	122 <go+0xaa>
        exit(0);
     33c:	00001097          	auipc	ra,0x1
     340:	b2e080e7          	jalr	-1234(ra) # e6a <exit>
        printf("grind: fork failed\n");
     344:	00001517          	auipc	a0,0x1
     348:	2fc50513          	add	a0,a0,764 # 1640 <updateNode+0x13c>
     34c:	00001097          	auipc	ra,0x1
     350:	ed6080e7          	jalr	-298(ra) # 1222 <printf>
        exit(1);
     354:	4505                	li	a0,1
     356:	00001097          	auipc	ra,0x1
     35a:	b14080e7          	jalr	-1260(ra) # e6a <exit>
    } else if(what == 14){
      int pid = fork();
     35e:	00001097          	auipc	ra,0x1
     362:	b04080e7          	jalr	-1276(ra) # e62 <fork>
      if(pid == 0){
     366:	c909                	beqz	a0,378 <go+0x300>
        fork();
        fork();
        exit(0);
      } else if(pid < 0){
     368:	02054563          	bltz	a0,392 <go+0x31a>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     36c:	4501                	li	a0,0
     36e:	00001097          	auipc	ra,0x1
     372:	b04080e7          	jalr	-1276(ra) # e72 <wait>
     376:	b375                	j	122 <go+0xaa>
        fork();
     378:	00001097          	auipc	ra,0x1
     37c:	aea080e7          	jalr	-1302(ra) # e62 <fork>
        fork();
     380:	00001097          	auipc	ra,0x1
     384:	ae2080e7          	jalr	-1310(ra) # e62 <fork>
        exit(0);
     388:	4501                	li	a0,0
     38a:	00001097          	auipc	ra,0x1
     38e:	ae0080e7          	jalr	-1312(ra) # e6a <exit>
        printf("grind: fork failed\n");
     392:	00001517          	auipc	a0,0x1
     396:	2ae50513          	add	a0,a0,686 # 1640 <updateNode+0x13c>
     39a:	00001097          	auipc	ra,0x1
     39e:	e88080e7          	jalr	-376(ra) # 1222 <printf>
        exit(1);
     3a2:	4505                	li	a0,1
     3a4:	00001097          	auipc	ra,0x1
     3a8:	ac6080e7          	jalr	-1338(ra) # e6a <exit>
    } else if(what == 15){
      sbrk(6011);
     3ac:	6505                	lui	a0,0x1
     3ae:	77b50513          	add	a0,a0,1915 # 177b <updateNode+0x277>
     3b2:	00001097          	auipc	ra,0x1
     3b6:	b40080e7          	jalr	-1216(ra) # ef2 <sbrk>
     3ba:	b3a5                	j	122 <go+0xaa>
    } else if(what == 16){
      if(sbrk(0) > break0)
     3bc:	4501                	li	a0,0
     3be:	00001097          	auipc	ra,0x1
     3c2:	b34080e7          	jalr	-1228(ra) # ef2 <sbrk>
     3c6:	d4aafee3          	bgeu	s5,a0,122 <go+0xaa>
        sbrk(-(sbrk(0) - break0));
     3ca:	4501                	li	a0,0
     3cc:	00001097          	auipc	ra,0x1
     3d0:	b26080e7          	jalr	-1242(ra) # ef2 <sbrk>
     3d4:	40aa853b          	subw	a0,s5,a0
     3d8:	00001097          	auipc	ra,0x1
     3dc:	b1a080e7          	jalr	-1254(ra) # ef2 <sbrk>
     3e0:	b389                	j	122 <go+0xaa>
    } else if(what == 17){
      int pid = fork();
     3e2:	00001097          	auipc	ra,0x1
     3e6:	a80080e7          	jalr	-1408(ra) # e62 <fork>
     3ea:	8b2a                	mv	s6,a0
      if(pid == 0){
     3ec:	c51d                	beqz	a0,41a <go+0x3a2>
        close(open("a", O_CREATE|O_RDWR));
        exit(0);
      } else if(pid < 0){
     3ee:	04054963          	bltz	a0,440 <go+0x3c8>
        printf("grind: fork failed\n");
        exit(1);
      }
      if(chdir("../grindir/..") != 0){
     3f2:	00001517          	auipc	a0,0x1
     3f6:	26650513          	add	a0,a0,614 # 1658 <updateNode+0x154>
     3fa:	00001097          	auipc	ra,0x1
     3fe:	ae0080e7          	jalr	-1312(ra) # eda <chdir>
     402:	ed21                	bnez	a0,45a <go+0x3e2>
        printf("grind: chdir failed\n");
        exit(1);
      }
      kill(pid);
     404:	855a                	mv	a0,s6
     406:	00001097          	auipc	ra,0x1
     40a:	a94080e7          	jalr	-1388(ra) # e9a <kill>
      wait(0);
     40e:	4501                	li	a0,0
     410:	00001097          	auipc	ra,0x1
     414:	a62080e7          	jalr	-1438(ra) # e72 <wait>
     418:	b329                	j	122 <go+0xaa>
        close(open("a", O_CREATE|O_RDWR));
     41a:	20200593          	li	a1,514
     41e:	00001517          	auipc	a0,0x1
     422:	20250513          	add	a0,a0,514 # 1620 <updateNode+0x11c>
     426:	00001097          	auipc	ra,0x1
     42a:	a84080e7          	jalr	-1404(ra) # eaa <open>
     42e:	00001097          	auipc	ra,0x1
     432:	a64080e7          	jalr	-1436(ra) # e92 <close>
        exit(0);
     436:	4501                	li	a0,0
     438:	00001097          	auipc	ra,0x1
     43c:	a32080e7          	jalr	-1486(ra) # e6a <exit>
        printf("grind: fork failed\n");
     440:	00001517          	auipc	a0,0x1
     444:	20050513          	add	a0,a0,512 # 1640 <updateNode+0x13c>
     448:	00001097          	auipc	ra,0x1
     44c:	dda080e7          	jalr	-550(ra) # 1222 <printf>
        exit(1);
     450:	4505                	li	a0,1
     452:	00001097          	auipc	ra,0x1
     456:	a18080e7          	jalr	-1512(ra) # e6a <exit>
        printf("grind: chdir failed\n");
     45a:	00001517          	auipc	a0,0x1
     45e:	20e50513          	add	a0,a0,526 # 1668 <updateNode+0x164>
     462:	00001097          	auipc	ra,0x1
     466:	dc0080e7          	jalr	-576(ra) # 1222 <printf>
        exit(1);
     46a:	4505                	li	a0,1
     46c:	00001097          	auipc	ra,0x1
     470:	9fe080e7          	jalr	-1538(ra) # e6a <exit>
    } else if(what == 18){
      int pid = fork();
     474:	00001097          	auipc	ra,0x1
     478:	9ee080e7          	jalr	-1554(ra) # e62 <fork>
      if(pid == 0){
     47c:	c909                	beqz	a0,48e <go+0x416>
        kill(getpid());
        exit(0);
      } else if(pid < 0){
     47e:	02054563          	bltz	a0,4a8 <go+0x430>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     482:	4501                	li	a0,0
     484:	00001097          	auipc	ra,0x1
     488:	9ee080e7          	jalr	-1554(ra) # e72 <wait>
     48c:	b959                	j	122 <go+0xaa>
        kill(getpid());
     48e:	00001097          	auipc	ra,0x1
     492:	a5c080e7          	jalr	-1444(ra) # eea <getpid>
     496:	00001097          	auipc	ra,0x1
     49a:	a04080e7          	jalr	-1532(ra) # e9a <kill>
        exit(0);
     49e:	4501                	li	a0,0
     4a0:	00001097          	auipc	ra,0x1
     4a4:	9ca080e7          	jalr	-1590(ra) # e6a <exit>
        printf("grind: fork failed\n");
     4a8:	00001517          	auipc	a0,0x1
     4ac:	19850513          	add	a0,a0,408 # 1640 <updateNode+0x13c>
     4b0:	00001097          	auipc	ra,0x1
     4b4:	d72080e7          	jalr	-654(ra) # 1222 <printf>
        exit(1);
     4b8:	4505                	li	a0,1
     4ba:	00001097          	auipc	ra,0x1
     4be:	9b0080e7          	jalr	-1616(ra) # e6a <exit>
    } else if(what == 19){
      int fds[2];
      if(pipe(fds) < 0){
     4c2:	fa840513          	add	a0,s0,-88
     4c6:	00001097          	auipc	ra,0x1
     4ca:	9b4080e7          	jalr	-1612(ra) # e7a <pipe>
     4ce:	02054b63          	bltz	a0,504 <go+0x48c>
        printf("grind: pipe failed\n");
        exit(1);
      }
      int pid = fork();
     4d2:	00001097          	auipc	ra,0x1
     4d6:	990080e7          	jalr	-1648(ra) # e62 <fork>
      if(pid == 0){
     4da:	c131                	beqz	a0,51e <go+0x4a6>
          printf("grind: pipe write failed\n");
        char c;
        if(read(fds[0], &c, 1) != 1)
          printf("grind: pipe read failed\n");
        exit(0);
      } else if(pid < 0){
     4dc:	0a054a63          	bltz	a0,590 <go+0x518>
        printf("grind: fork failed\n");
        exit(1);
      }
      close(fds[0]);
     4e0:	fa842503          	lw	a0,-88(s0)
     4e4:	00001097          	auipc	ra,0x1
     4e8:	9ae080e7          	jalr	-1618(ra) # e92 <close>
      close(fds[1]);
     4ec:	fac42503          	lw	a0,-84(s0)
     4f0:	00001097          	auipc	ra,0x1
     4f4:	9a2080e7          	jalr	-1630(ra) # e92 <close>
      wait(0);
     4f8:	4501                	li	a0,0
     4fa:	00001097          	auipc	ra,0x1
     4fe:	978080e7          	jalr	-1672(ra) # e72 <wait>
     502:	b105                	j	122 <go+0xaa>
        printf("grind: pipe failed\n");
     504:	00001517          	auipc	a0,0x1
     508:	17c50513          	add	a0,a0,380 # 1680 <updateNode+0x17c>
     50c:	00001097          	auipc	ra,0x1
     510:	d16080e7          	jalr	-746(ra) # 1222 <printf>
        exit(1);
     514:	4505                	li	a0,1
     516:	00001097          	auipc	ra,0x1
     51a:	954080e7          	jalr	-1708(ra) # e6a <exit>
        fork();
     51e:	00001097          	auipc	ra,0x1
     522:	944080e7          	jalr	-1724(ra) # e62 <fork>
        fork();
     526:	00001097          	auipc	ra,0x1
     52a:	93c080e7          	jalr	-1732(ra) # e62 <fork>
        if(write(fds[1], "x", 1) != 1)
     52e:	4605                	li	a2,1
     530:	00001597          	auipc	a1,0x1
     534:	16858593          	add	a1,a1,360 # 1698 <updateNode+0x194>
     538:	fac42503          	lw	a0,-84(s0)
     53c:	00001097          	auipc	ra,0x1
     540:	94e080e7          	jalr	-1714(ra) # e8a <write>
     544:	4785                	li	a5,1
     546:	02f51363          	bne	a0,a5,56c <go+0x4f4>
        if(read(fds[0], &c, 1) != 1)
     54a:	4605                	li	a2,1
     54c:	fa040593          	add	a1,s0,-96
     550:	fa842503          	lw	a0,-88(s0)
     554:	00001097          	auipc	ra,0x1
     558:	92e080e7          	jalr	-1746(ra) # e82 <read>
     55c:	4785                	li	a5,1
     55e:	02f51063          	bne	a0,a5,57e <go+0x506>
        exit(0);
     562:	4501                	li	a0,0
     564:	00001097          	auipc	ra,0x1
     568:	906080e7          	jalr	-1786(ra) # e6a <exit>
          printf("grind: pipe write failed\n");
     56c:	00001517          	auipc	a0,0x1
     570:	13450513          	add	a0,a0,308 # 16a0 <updateNode+0x19c>
     574:	00001097          	auipc	ra,0x1
     578:	cae080e7          	jalr	-850(ra) # 1222 <printf>
     57c:	b7f9                	j	54a <go+0x4d2>
          printf("grind: pipe read failed\n");
     57e:	00001517          	auipc	a0,0x1
     582:	14250513          	add	a0,a0,322 # 16c0 <updateNode+0x1bc>
     586:	00001097          	auipc	ra,0x1
     58a:	c9c080e7          	jalr	-868(ra) # 1222 <printf>
     58e:	bfd1                	j	562 <go+0x4ea>
        printf("grind: fork failed\n");
     590:	00001517          	auipc	a0,0x1
     594:	0b050513          	add	a0,a0,176 # 1640 <updateNode+0x13c>
     598:	00001097          	auipc	ra,0x1
     59c:	c8a080e7          	jalr	-886(ra) # 1222 <printf>
        exit(1);
     5a0:	4505                	li	a0,1
     5a2:	00001097          	auipc	ra,0x1
     5a6:	8c8080e7          	jalr	-1848(ra) # e6a <exit>
    } else if(what == 20){
      int pid = fork();
     5aa:	00001097          	auipc	ra,0x1
     5ae:	8b8080e7          	jalr	-1864(ra) # e62 <fork>
      if(pid == 0){
     5b2:	c909                	beqz	a0,5c4 <go+0x54c>
        chdir("a");
        unlink("../a");
        fd = open("x", O_CREATE|O_RDWR);
        unlink("x");
        exit(0);
      } else if(pid < 0){
     5b4:	06054f63          	bltz	a0,632 <go+0x5ba>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     5b8:	4501                	li	a0,0
     5ba:	00001097          	auipc	ra,0x1
     5be:	8b8080e7          	jalr	-1864(ra) # e72 <wait>
     5c2:	b685                	j	122 <go+0xaa>
        unlink("a");
     5c4:	00001517          	auipc	a0,0x1
     5c8:	05c50513          	add	a0,a0,92 # 1620 <updateNode+0x11c>
     5cc:	00001097          	auipc	ra,0x1
     5d0:	8ee080e7          	jalr	-1810(ra) # eba <unlink>
        mkdir("a");
     5d4:	00001517          	auipc	a0,0x1
     5d8:	04c50513          	add	a0,a0,76 # 1620 <updateNode+0x11c>
     5dc:	00001097          	auipc	ra,0x1
     5e0:	8f6080e7          	jalr	-1802(ra) # ed2 <mkdir>
        chdir("a");
     5e4:	00001517          	auipc	a0,0x1
     5e8:	03c50513          	add	a0,a0,60 # 1620 <updateNode+0x11c>
     5ec:	00001097          	auipc	ra,0x1
     5f0:	8ee080e7          	jalr	-1810(ra) # eda <chdir>
        unlink("../a");
     5f4:	00001517          	auipc	a0,0x1
     5f8:	f9450513          	add	a0,a0,-108 # 1588 <updateNode+0x84>
     5fc:	00001097          	auipc	ra,0x1
     600:	8be080e7          	jalr	-1858(ra) # eba <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     604:	20200593          	li	a1,514
     608:	00001517          	auipc	a0,0x1
     60c:	09050513          	add	a0,a0,144 # 1698 <updateNode+0x194>
     610:	00001097          	auipc	ra,0x1
     614:	89a080e7          	jalr	-1894(ra) # eaa <open>
        unlink("x");
     618:	00001517          	auipc	a0,0x1
     61c:	08050513          	add	a0,a0,128 # 1698 <updateNode+0x194>
     620:	00001097          	auipc	ra,0x1
     624:	89a080e7          	jalr	-1894(ra) # eba <unlink>
        exit(0);
     628:	4501                	li	a0,0
     62a:	00001097          	auipc	ra,0x1
     62e:	840080e7          	jalr	-1984(ra) # e6a <exit>
        printf("grind: fork failed\n");
     632:	00001517          	auipc	a0,0x1
     636:	00e50513          	add	a0,a0,14 # 1640 <updateNode+0x13c>
     63a:	00001097          	auipc	ra,0x1
     63e:	be8080e7          	jalr	-1048(ra) # 1222 <printf>
        exit(1);
     642:	4505                	li	a0,1
     644:	00001097          	auipc	ra,0x1
     648:	826080e7          	jalr	-2010(ra) # e6a <exit>
    } else if(what == 21){
      unlink("c");
     64c:	00001517          	auipc	a0,0x1
     650:	09450513          	add	a0,a0,148 # 16e0 <updateNode+0x1dc>
     654:	00001097          	auipc	ra,0x1
     658:	866080e7          	jalr	-1946(ra) # eba <unlink>
      // should always succeed. check that there are free i-nodes,
      // file descriptors, blocks.
      int fd1 = open("c", O_CREATE|O_RDWR);
     65c:	20200593          	li	a1,514
     660:	00001517          	auipc	a0,0x1
     664:	08050513          	add	a0,a0,128 # 16e0 <updateNode+0x1dc>
     668:	00001097          	auipc	ra,0x1
     66c:	842080e7          	jalr	-1982(ra) # eaa <open>
     670:	8b2a                	mv	s6,a0
      if(fd1 < 0){
     672:	04054f63          	bltz	a0,6d0 <go+0x658>
        printf("grind: create c failed\n");
        exit(1);
      }
      if(write(fd1, "x", 1) != 1){
     676:	4605                	li	a2,1
     678:	00001597          	auipc	a1,0x1
     67c:	02058593          	add	a1,a1,32 # 1698 <updateNode+0x194>
     680:	00001097          	auipc	ra,0x1
     684:	80a080e7          	jalr	-2038(ra) # e8a <write>
     688:	4785                	li	a5,1
     68a:	06f51063          	bne	a0,a5,6ea <go+0x672>
        printf("grind: write c failed\n");
        exit(1);
      }
      struct stat st;
      if(fstat(fd1, &st) != 0){
     68e:	fa840593          	add	a1,s0,-88
     692:	855a                	mv	a0,s6
     694:	00001097          	auipc	ra,0x1
     698:	82e080e7          	jalr	-2002(ra) # ec2 <fstat>
     69c:	e525                	bnez	a0,704 <go+0x68c>
        printf("grind: fstat failed\n");
        exit(1);
      }
      if(st.size != 1){
     69e:	fb843583          	ld	a1,-72(s0)
     6a2:	4785                	li	a5,1
     6a4:	06f59d63          	bne	a1,a5,71e <go+0x6a6>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
        exit(1);
      }
      if(st.ino > 200){
     6a8:	fac42583          	lw	a1,-84(s0)
     6ac:	0c800793          	li	a5,200
     6b0:	08b7e563          	bltu	a5,a1,73a <go+0x6c2>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
        exit(1);
      }
      close(fd1);
     6b4:	855a                	mv	a0,s6
     6b6:	00000097          	auipc	ra,0x0
     6ba:	7dc080e7          	jalr	2012(ra) # e92 <close>
      unlink("c");
     6be:	00001517          	auipc	a0,0x1
     6c2:	02250513          	add	a0,a0,34 # 16e0 <updateNode+0x1dc>
     6c6:	00000097          	auipc	ra,0x0
     6ca:	7f4080e7          	jalr	2036(ra) # eba <unlink>
     6ce:	bc91                	j	122 <go+0xaa>
        printf("grind: create c failed\n");
     6d0:	00001517          	auipc	a0,0x1
     6d4:	01850513          	add	a0,a0,24 # 16e8 <updateNode+0x1e4>
     6d8:	00001097          	auipc	ra,0x1
     6dc:	b4a080e7          	jalr	-1206(ra) # 1222 <printf>
        exit(1);
     6e0:	4505                	li	a0,1
     6e2:	00000097          	auipc	ra,0x0
     6e6:	788080e7          	jalr	1928(ra) # e6a <exit>
        printf("grind: write c failed\n");
     6ea:	00001517          	auipc	a0,0x1
     6ee:	01650513          	add	a0,a0,22 # 1700 <updateNode+0x1fc>
     6f2:	00001097          	auipc	ra,0x1
     6f6:	b30080e7          	jalr	-1232(ra) # 1222 <printf>
        exit(1);
     6fa:	4505                	li	a0,1
     6fc:	00000097          	auipc	ra,0x0
     700:	76e080e7          	jalr	1902(ra) # e6a <exit>
        printf("grind: fstat failed\n");
     704:	00001517          	auipc	a0,0x1
     708:	01450513          	add	a0,a0,20 # 1718 <updateNode+0x214>
     70c:	00001097          	auipc	ra,0x1
     710:	b16080e7          	jalr	-1258(ra) # 1222 <printf>
        exit(1);
     714:	4505                	li	a0,1
     716:	00000097          	auipc	ra,0x0
     71a:	754080e7          	jalr	1876(ra) # e6a <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     71e:	2581                	sext.w	a1,a1
     720:	00001517          	auipc	a0,0x1
     724:	01050513          	add	a0,a0,16 # 1730 <updateNode+0x22c>
     728:	00001097          	auipc	ra,0x1
     72c:	afa080e7          	jalr	-1286(ra) # 1222 <printf>
        exit(1);
     730:	4505                	li	a0,1
     732:	00000097          	auipc	ra,0x0
     736:	738080e7          	jalr	1848(ra) # e6a <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     73a:	00001517          	auipc	a0,0x1
     73e:	01e50513          	add	a0,a0,30 # 1758 <updateNode+0x254>
     742:	00001097          	auipc	ra,0x1
     746:	ae0080e7          	jalr	-1312(ra) # 1222 <printf>
        exit(1);
     74a:	4505                	li	a0,1
     74c:	00000097          	auipc	ra,0x0
     750:	71e080e7          	jalr	1822(ra) # e6a <exit>
    } else if(what == 22){
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     754:	f9840513          	add	a0,s0,-104
     758:	00000097          	auipc	ra,0x0
     75c:	722080e7          	jalr	1826(ra) # e7a <pipe>
     760:	10054063          	bltz	a0,860 <go+0x7e8>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     764:	fa040513          	add	a0,s0,-96
     768:	00000097          	auipc	ra,0x0
     76c:	712080e7          	jalr	1810(ra) # e7a <pipe>
     770:	10054663          	bltz	a0,87c <go+0x804>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     774:	00000097          	auipc	ra,0x0
     778:	6ee080e7          	jalr	1774(ra) # e62 <fork>
      if(pid1 == 0){
     77c:	10050e63          	beqz	a0,898 <go+0x820>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     780:	1c054663          	bltz	a0,94c <go+0x8d4>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     784:	00000097          	auipc	ra,0x0
     788:	6de080e7          	jalr	1758(ra) # e62 <fork>
      if(pid2 == 0){
     78c:	1c050e63          	beqz	a0,968 <go+0x8f0>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     790:	2a054a63          	bltz	a0,a44 <go+0x9cc>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     794:	f9842503          	lw	a0,-104(s0)
     798:	00000097          	auipc	ra,0x0
     79c:	6fa080e7          	jalr	1786(ra) # e92 <close>
      close(aa[1]);
     7a0:	f9c42503          	lw	a0,-100(s0)
     7a4:	00000097          	auipc	ra,0x0
     7a8:	6ee080e7          	jalr	1774(ra) # e92 <close>
      close(bb[1]);
     7ac:	fa442503          	lw	a0,-92(s0)
     7b0:	00000097          	auipc	ra,0x0
     7b4:	6e2080e7          	jalr	1762(ra) # e92 <close>
      char buf[4] = { 0, 0, 0, 0 };
     7b8:	f8042823          	sw	zero,-112(s0)
      read(bb[0], buf+0, 1);
     7bc:	4605                	li	a2,1
     7be:	f9040593          	add	a1,s0,-112
     7c2:	fa042503          	lw	a0,-96(s0)
     7c6:	00000097          	auipc	ra,0x0
     7ca:	6bc080e7          	jalr	1724(ra) # e82 <read>
      read(bb[0], buf+1, 1);
     7ce:	4605                	li	a2,1
     7d0:	f9140593          	add	a1,s0,-111
     7d4:	fa042503          	lw	a0,-96(s0)
     7d8:	00000097          	auipc	ra,0x0
     7dc:	6aa080e7          	jalr	1706(ra) # e82 <read>
      read(bb[0], buf+2, 1);
     7e0:	4605                	li	a2,1
     7e2:	f9240593          	add	a1,s0,-110
     7e6:	fa042503          	lw	a0,-96(s0)
     7ea:	00000097          	auipc	ra,0x0
     7ee:	698080e7          	jalr	1688(ra) # e82 <read>
      close(bb[0]);
     7f2:	fa042503          	lw	a0,-96(s0)
     7f6:	00000097          	auipc	ra,0x0
     7fa:	69c080e7          	jalr	1692(ra) # e92 <close>
      int st1, st2;
      wait(&st1);
     7fe:	f9440513          	add	a0,s0,-108
     802:	00000097          	auipc	ra,0x0
     806:	670080e7          	jalr	1648(ra) # e72 <wait>
      wait(&st2);
     80a:	fa840513          	add	a0,s0,-88
     80e:	00000097          	auipc	ra,0x0
     812:	664080e7          	jalr	1636(ra) # e72 <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     816:	f9442783          	lw	a5,-108(s0)
     81a:	fa842703          	lw	a4,-88(s0)
     81e:	8fd9                	or	a5,a5,a4
     820:	ef89                	bnez	a5,83a <go+0x7c2>
     822:	00001597          	auipc	a1,0x1
     826:	fd658593          	add	a1,a1,-42 # 17f8 <updateNode+0x2f4>
     82a:	f9040513          	add	a0,s0,-112
     82e:	00000097          	auipc	ra,0x0
     832:	3b0080e7          	jalr	944(ra) # bde <strcmp>
     836:	8e0506e3          	beqz	a0,122 <go+0xaa>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     83a:	f9040693          	add	a3,s0,-112
     83e:	fa842603          	lw	a2,-88(s0)
     842:	f9442583          	lw	a1,-108(s0)
     846:	00001517          	auipc	a0,0x1
     84a:	fba50513          	add	a0,a0,-70 # 1800 <updateNode+0x2fc>
     84e:	00001097          	auipc	ra,0x1
     852:	9d4080e7          	jalr	-1580(ra) # 1222 <printf>
        exit(1);
     856:	4505                	li	a0,1
     858:	00000097          	auipc	ra,0x0
     85c:	612080e7          	jalr	1554(ra) # e6a <exit>
        fprintf(2, "grind: pipe failed\n");
     860:	00001597          	auipc	a1,0x1
     864:	e2058593          	add	a1,a1,-480 # 1680 <updateNode+0x17c>
     868:	4509                	li	a0,2
     86a:	00001097          	auipc	ra,0x1
     86e:	98a080e7          	jalr	-1654(ra) # 11f4 <fprintf>
        exit(1);
     872:	4505                	li	a0,1
     874:	00000097          	auipc	ra,0x0
     878:	5f6080e7          	jalr	1526(ra) # e6a <exit>
        fprintf(2, "grind: pipe failed\n");
     87c:	00001597          	auipc	a1,0x1
     880:	e0458593          	add	a1,a1,-508 # 1680 <updateNode+0x17c>
     884:	4509                	li	a0,2
     886:	00001097          	auipc	ra,0x1
     88a:	96e080e7          	jalr	-1682(ra) # 11f4 <fprintf>
        exit(1);
     88e:	4505                	li	a0,1
     890:	00000097          	auipc	ra,0x0
     894:	5da080e7          	jalr	1498(ra) # e6a <exit>
        close(bb[0]);
     898:	fa042503          	lw	a0,-96(s0)
     89c:	00000097          	auipc	ra,0x0
     8a0:	5f6080e7          	jalr	1526(ra) # e92 <close>
        close(bb[1]);
     8a4:	fa442503          	lw	a0,-92(s0)
     8a8:	00000097          	auipc	ra,0x0
     8ac:	5ea080e7          	jalr	1514(ra) # e92 <close>
        close(aa[0]);
     8b0:	f9842503          	lw	a0,-104(s0)
     8b4:	00000097          	auipc	ra,0x0
     8b8:	5de080e7          	jalr	1502(ra) # e92 <close>
        close(1);
     8bc:	4505                	li	a0,1
     8be:	00000097          	auipc	ra,0x0
     8c2:	5d4080e7          	jalr	1492(ra) # e92 <close>
        if(dup(aa[1]) != 1){
     8c6:	f9c42503          	lw	a0,-100(s0)
     8ca:	00000097          	auipc	ra,0x0
     8ce:	618080e7          	jalr	1560(ra) # ee2 <dup>
     8d2:	4785                	li	a5,1
     8d4:	02f50063          	beq	a0,a5,8f4 <go+0x87c>
          fprintf(2, "grind: dup failed\n");
     8d8:	00001597          	auipc	a1,0x1
     8dc:	ea858593          	add	a1,a1,-344 # 1780 <updateNode+0x27c>
     8e0:	4509                	li	a0,2
     8e2:	00001097          	auipc	ra,0x1
     8e6:	912080e7          	jalr	-1774(ra) # 11f4 <fprintf>
          exit(1);
     8ea:	4505                	li	a0,1
     8ec:	00000097          	auipc	ra,0x0
     8f0:	57e080e7          	jalr	1406(ra) # e6a <exit>
        close(aa[1]);
     8f4:	f9c42503          	lw	a0,-100(s0)
     8f8:	00000097          	auipc	ra,0x0
     8fc:	59a080e7          	jalr	1434(ra) # e92 <close>
        char *args[3] = { "echo", "hi", 0 };
     900:	00001797          	auipc	a5,0x1
     904:	e9878793          	add	a5,a5,-360 # 1798 <updateNode+0x294>
     908:	faf43423          	sd	a5,-88(s0)
     90c:	00001797          	auipc	a5,0x1
     910:	e9478793          	add	a5,a5,-364 # 17a0 <updateNode+0x29c>
     914:	faf43823          	sd	a5,-80(s0)
     918:	fa043c23          	sd	zero,-72(s0)
        exec("grindir/../echo", args);
     91c:	fa840593          	add	a1,s0,-88
     920:	00001517          	auipc	a0,0x1
     924:	e8850513          	add	a0,a0,-376 # 17a8 <updateNode+0x2a4>
     928:	00000097          	auipc	ra,0x0
     92c:	57a080e7          	jalr	1402(ra) # ea2 <exec>
        fprintf(2, "grind: echo: not found\n");
     930:	00001597          	auipc	a1,0x1
     934:	e8858593          	add	a1,a1,-376 # 17b8 <updateNode+0x2b4>
     938:	4509                	li	a0,2
     93a:	00001097          	auipc	ra,0x1
     93e:	8ba080e7          	jalr	-1862(ra) # 11f4 <fprintf>
        exit(2);
     942:	4509                	li	a0,2
     944:	00000097          	auipc	ra,0x0
     948:	526080e7          	jalr	1318(ra) # e6a <exit>
        fprintf(2, "grind: fork failed\n");
     94c:	00001597          	auipc	a1,0x1
     950:	cf458593          	add	a1,a1,-780 # 1640 <updateNode+0x13c>
     954:	4509                	li	a0,2
     956:	00001097          	auipc	ra,0x1
     95a:	89e080e7          	jalr	-1890(ra) # 11f4 <fprintf>
        exit(3);
     95e:	450d                	li	a0,3
     960:	00000097          	auipc	ra,0x0
     964:	50a080e7          	jalr	1290(ra) # e6a <exit>
        close(aa[1]);
     968:	f9c42503          	lw	a0,-100(s0)
     96c:	00000097          	auipc	ra,0x0
     970:	526080e7          	jalr	1318(ra) # e92 <close>
        close(bb[0]);
     974:	fa042503          	lw	a0,-96(s0)
     978:	00000097          	auipc	ra,0x0
     97c:	51a080e7          	jalr	1306(ra) # e92 <close>
        close(0);
     980:	4501                	li	a0,0
     982:	00000097          	auipc	ra,0x0
     986:	510080e7          	jalr	1296(ra) # e92 <close>
        if(dup(aa[0]) != 0){
     98a:	f9842503          	lw	a0,-104(s0)
     98e:	00000097          	auipc	ra,0x0
     992:	554080e7          	jalr	1364(ra) # ee2 <dup>
     996:	cd19                	beqz	a0,9b4 <go+0x93c>
          fprintf(2, "grind: dup failed\n");
     998:	00001597          	auipc	a1,0x1
     99c:	de858593          	add	a1,a1,-536 # 1780 <updateNode+0x27c>
     9a0:	4509                	li	a0,2
     9a2:	00001097          	auipc	ra,0x1
     9a6:	852080e7          	jalr	-1966(ra) # 11f4 <fprintf>
          exit(4);
     9aa:	4511                	li	a0,4
     9ac:	00000097          	auipc	ra,0x0
     9b0:	4be080e7          	jalr	1214(ra) # e6a <exit>
        close(aa[0]);
     9b4:	f9842503          	lw	a0,-104(s0)
     9b8:	00000097          	auipc	ra,0x0
     9bc:	4da080e7          	jalr	1242(ra) # e92 <close>
        close(1);
     9c0:	4505                	li	a0,1
     9c2:	00000097          	auipc	ra,0x0
     9c6:	4d0080e7          	jalr	1232(ra) # e92 <close>
        if(dup(bb[1]) != 1){
     9ca:	fa442503          	lw	a0,-92(s0)
     9ce:	00000097          	auipc	ra,0x0
     9d2:	514080e7          	jalr	1300(ra) # ee2 <dup>
     9d6:	4785                	li	a5,1
     9d8:	02f50063          	beq	a0,a5,9f8 <go+0x980>
          fprintf(2, "grind: dup failed\n");
     9dc:	00001597          	auipc	a1,0x1
     9e0:	da458593          	add	a1,a1,-604 # 1780 <updateNode+0x27c>
     9e4:	4509                	li	a0,2
     9e6:	00001097          	auipc	ra,0x1
     9ea:	80e080e7          	jalr	-2034(ra) # 11f4 <fprintf>
          exit(5);
     9ee:	4515                	li	a0,5
     9f0:	00000097          	auipc	ra,0x0
     9f4:	47a080e7          	jalr	1146(ra) # e6a <exit>
        close(bb[1]);
     9f8:	fa442503          	lw	a0,-92(s0)
     9fc:	00000097          	auipc	ra,0x0
     a00:	496080e7          	jalr	1174(ra) # e92 <close>
        char *args[2] = { "cat", 0 };
     a04:	00001797          	auipc	a5,0x1
     a08:	dcc78793          	add	a5,a5,-564 # 17d0 <updateNode+0x2cc>
     a0c:	faf43423          	sd	a5,-88(s0)
     a10:	fa043823          	sd	zero,-80(s0)
        exec("/cat", args);
     a14:	fa840593          	add	a1,s0,-88
     a18:	00001517          	auipc	a0,0x1
     a1c:	dc050513          	add	a0,a0,-576 # 17d8 <updateNode+0x2d4>
     a20:	00000097          	auipc	ra,0x0
     a24:	482080e7          	jalr	1154(ra) # ea2 <exec>
        fprintf(2, "grind: cat: not found\n");
     a28:	00001597          	auipc	a1,0x1
     a2c:	db858593          	add	a1,a1,-584 # 17e0 <updateNode+0x2dc>
     a30:	4509                	li	a0,2
     a32:	00000097          	auipc	ra,0x0
     a36:	7c2080e7          	jalr	1986(ra) # 11f4 <fprintf>
        exit(6);
     a3a:	4519                	li	a0,6
     a3c:	00000097          	auipc	ra,0x0
     a40:	42e080e7          	jalr	1070(ra) # e6a <exit>
        fprintf(2, "grind: fork failed\n");
     a44:	00001597          	auipc	a1,0x1
     a48:	bfc58593          	add	a1,a1,-1028 # 1640 <updateNode+0x13c>
     a4c:	4509                	li	a0,2
     a4e:	00000097          	auipc	ra,0x0
     a52:	7a6080e7          	jalr	1958(ra) # 11f4 <fprintf>
        exit(7);
     a56:	451d                	li	a0,7
     a58:	00000097          	auipc	ra,0x0
     a5c:	412080e7          	jalr	1042(ra) # e6a <exit>

0000000000000a60 <iter>:
  }
}

void
iter()
{
     a60:	7179                	add	sp,sp,-48
     a62:	f406                	sd	ra,40(sp)
     a64:	f022                	sd	s0,32(sp)
     a66:	ec26                	sd	s1,24(sp)
     a68:	e84a                	sd	s2,16(sp)
     a6a:	1800                	add	s0,sp,48
  unlink("a");
     a6c:	00001517          	auipc	a0,0x1
     a70:	bb450513          	add	a0,a0,-1100 # 1620 <updateNode+0x11c>
     a74:	00000097          	auipc	ra,0x0
     a78:	446080e7          	jalr	1094(ra) # eba <unlink>
  unlink("b");
     a7c:	00001517          	auipc	a0,0x1
     a80:	b5450513          	add	a0,a0,-1196 # 15d0 <updateNode+0xcc>
     a84:	00000097          	auipc	ra,0x0
     a88:	436080e7          	jalr	1078(ra) # eba <unlink>
  
  int pid1 = fork();
     a8c:	00000097          	auipc	ra,0x0
     a90:	3d6080e7          	jalr	982(ra) # e62 <fork>
  if(pid1 < 0){
     a94:	02054163          	bltz	a0,ab6 <iter+0x56>
     a98:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     a9a:	e91d                	bnez	a0,ad0 <iter+0x70>
    rand_next ^= 31;
     a9c:	00001717          	auipc	a4,0x1
     aa0:	56470713          	add	a4,a4,1380 # 2000 <rand_next>
     aa4:	631c                	ld	a5,0(a4)
     aa6:	01f7c793          	xor	a5,a5,31
     aaa:	e31c                	sd	a5,0(a4)
    go(0);
     aac:	4501                	li	a0,0
     aae:	fffff097          	auipc	ra,0xfffff
     ab2:	5ca080e7          	jalr	1482(ra) # 78 <go>
    printf("grind: fork failed\n");
     ab6:	00001517          	auipc	a0,0x1
     aba:	b8a50513          	add	a0,a0,-1142 # 1640 <updateNode+0x13c>
     abe:	00000097          	auipc	ra,0x0
     ac2:	764080e7          	jalr	1892(ra) # 1222 <printf>
    exit(1);
     ac6:	4505                	li	a0,1
     ac8:	00000097          	auipc	ra,0x0
     acc:	3a2080e7          	jalr	930(ra) # e6a <exit>
    exit(0);
  }

  int pid2 = fork();
     ad0:	00000097          	auipc	ra,0x0
     ad4:	392080e7          	jalr	914(ra) # e62 <fork>
     ad8:	892a                	mv	s2,a0
  if(pid2 < 0){
     ada:	02054263          	bltz	a0,afe <iter+0x9e>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     ade:	ed0d                	bnez	a0,b18 <iter+0xb8>
    rand_next ^= 7177;
     ae0:	00001697          	auipc	a3,0x1
     ae4:	52068693          	add	a3,a3,1312 # 2000 <rand_next>
     ae8:	629c                	ld	a5,0(a3)
     aea:	6709                	lui	a4,0x2
     aec:	c0970713          	add	a4,a4,-1015 # 1c09 <digits+0x321>
     af0:	8fb9                	xor	a5,a5,a4
     af2:	e29c                	sd	a5,0(a3)
    go(1);
     af4:	4505                	li	a0,1
     af6:	fffff097          	auipc	ra,0xfffff
     afa:	582080e7          	jalr	1410(ra) # 78 <go>
    printf("grind: fork failed\n");
     afe:	00001517          	auipc	a0,0x1
     b02:	b4250513          	add	a0,a0,-1214 # 1640 <updateNode+0x13c>
     b06:	00000097          	auipc	ra,0x0
     b0a:	71c080e7          	jalr	1820(ra) # 1222 <printf>
    exit(1);
     b0e:	4505                	li	a0,1
     b10:	00000097          	auipc	ra,0x0
     b14:	35a080e7          	jalr	858(ra) # e6a <exit>
    exit(0);
  }

  int st1 = -1;
     b18:	57fd                	li	a5,-1
     b1a:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     b1e:	fdc40513          	add	a0,s0,-36
     b22:	00000097          	auipc	ra,0x0
     b26:	350080e7          	jalr	848(ra) # e72 <wait>
  if(st1 != 0){
     b2a:	fdc42783          	lw	a5,-36(s0)
     b2e:	ef99                	bnez	a5,b4c <iter+0xec>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     b30:	57fd                	li	a5,-1
     b32:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
     b36:	fd840513          	add	a0,s0,-40
     b3a:	00000097          	auipc	ra,0x0
     b3e:	338080e7          	jalr	824(ra) # e72 <wait>

  exit(0);
     b42:	4501                	li	a0,0
     b44:	00000097          	auipc	ra,0x0
     b48:	326080e7          	jalr	806(ra) # e6a <exit>
    kill(pid1);
     b4c:	8526                	mv	a0,s1
     b4e:	00000097          	auipc	ra,0x0
     b52:	34c080e7          	jalr	844(ra) # e9a <kill>
    kill(pid2);
     b56:	854a                	mv	a0,s2
     b58:	00000097          	auipc	ra,0x0
     b5c:	342080e7          	jalr	834(ra) # e9a <kill>
     b60:	bfc1                	j	b30 <iter+0xd0>

0000000000000b62 <main>:
}

int
main()
{
     b62:	1101                	add	sp,sp,-32
     b64:	ec06                	sd	ra,24(sp)
     b66:	e822                	sd	s0,16(sp)
     b68:	e426                	sd	s1,8(sp)
     b6a:	1000                	add	s0,sp,32
    }
    if(pid > 0){
      wait(0);
    }
    sleep(20);
    rand_next += 1;
     b6c:	00001497          	auipc	s1,0x1
     b70:	49448493          	add	s1,s1,1172 # 2000 <rand_next>
     b74:	a829                	j	b8e <main+0x2c>
      iter();
     b76:	00000097          	auipc	ra,0x0
     b7a:	eea080e7          	jalr	-278(ra) # a60 <iter>
    sleep(20);
     b7e:	4551                	li	a0,20
     b80:	00000097          	auipc	ra,0x0
     b84:	37a080e7          	jalr	890(ra) # efa <sleep>
    rand_next += 1;
     b88:	609c                	ld	a5,0(s1)
     b8a:	0785                	add	a5,a5,1
     b8c:	e09c                	sd	a5,0(s1)
    int pid = fork();
     b8e:	00000097          	auipc	ra,0x0
     b92:	2d4080e7          	jalr	724(ra) # e62 <fork>
    if(pid == 0){
     b96:	d165                	beqz	a0,b76 <main+0x14>
    if(pid > 0){
     b98:	fea053e3          	blez	a0,b7e <main+0x1c>
      wait(0);
     b9c:	4501                	li	a0,0
     b9e:	00000097          	auipc	ra,0x0
     ba2:	2d4080e7          	jalr	724(ra) # e72 <wait>
     ba6:	bfe1                	j	b7e <main+0x1c>

0000000000000ba8 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
     ba8:	1141                	add	sp,sp,-16
     baa:	e406                	sd	ra,8(sp)
     bac:	e022                	sd	s0,0(sp)
     bae:	0800                	add	s0,sp,16
  extern int main();
  main();
     bb0:	00000097          	auipc	ra,0x0
     bb4:	fb2080e7          	jalr	-78(ra) # b62 <main>
  exit(0);
     bb8:	4501                	li	a0,0
     bba:	00000097          	auipc	ra,0x0
     bbe:	2b0080e7          	jalr	688(ra) # e6a <exit>

0000000000000bc2 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     bc2:	1141                	add	sp,sp,-16
     bc4:	e422                	sd	s0,8(sp)
     bc6:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     bc8:	87aa                	mv	a5,a0
     bca:	0585                	add	a1,a1,1
     bcc:	0785                	add	a5,a5,1
     bce:	fff5c703          	lbu	a4,-1(a1)
     bd2:	fee78fa3          	sb	a4,-1(a5)
     bd6:	fb75                	bnez	a4,bca <strcpy+0x8>
    ;
  return os;
}
     bd8:	6422                	ld	s0,8(sp)
     bda:	0141                	add	sp,sp,16
     bdc:	8082                	ret

0000000000000bde <strcmp>:

int
strcmp(const char *p, const char *q)
{
     bde:	1141                	add	sp,sp,-16
     be0:	e422                	sd	s0,8(sp)
     be2:	0800                	add	s0,sp,16
  while(*p && *p == *q)
     be4:	00054783          	lbu	a5,0(a0)
     be8:	cb91                	beqz	a5,bfc <strcmp+0x1e>
     bea:	0005c703          	lbu	a4,0(a1)
     bee:	00f71763          	bne	a4,a5,bfc <strcmp+0x1e>
    p++, q++;
     bf2:	0505                	add	a0,a0,1
     bf4:	0585                	add	a1,a1,1
  while(*p && *p == *q)
     bf6:	00054783          	lbu	a5,0(a0)
     bfa:	fbe5                	bnez	a5,bea <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     bfc:	0005c503          	lbu	a0,0(a1)
}
     c00:	40a7853b          	subw	a0,a5,a0
     c04:	6422                	ld	s0,8(sp)
     c06:	0141                	add	sp,sp,16
     c08:	8082                	ret

0000000000000c0a <strlen>:

uint
strlen(const char *s)
{
     c0a:	1141                	add	sp,sp,-16
     c0c:	e422                	sd	s0,8(sp)
     c0e:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     c10:	00054783          	lbu	a5,0(a0)
     c14:	cf91                	beqz	a5,c30 <strlen+0x26>
     c16:	0505                	add	a0,a0,1
     c18:	87aa                	mv	a5,a0
     c1a:	86be                	mv	a3,a5
     c1c:	0785                	add	a5,a5,1
     c1e:	fff7c703          	lbu	a4,-1(a5)
     c22:	ff65                	bnez	a4,c1a <strlen+0x10>
     c24:	40a6853b          	subw	a0,a3,a0
     c28:	2505                	addw	a0,a0,1
    ;
  return n;
}
     c2a:	6422                	ld	s0,8(sp)
     c2c:	0141                	add	sp,sp,16
     c2e:	8082                	ret
  for(n = 0; s[n]; n++)
     c30:	4501                	li	a0,0
     c32:	bfe5                	j	c2a <strlen+0x20>

0000000000000c34 <memset>:

void*
memset(void *dst, int c, uint n)
{
     c34:	1141                	add	sp,sp,-16
     c36:	e422                	sd	s0,8(sp)
     c38:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     c3a:	ca19                	beqz	a2,c50 <memset+0x1c>
     c3c:	87aa                	mv	a5,a0
     c3e:	1602                	sll	a2,a2,0x20
     c40:	9201                	srl	a2,a2,0x20
     c42:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     c46:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     c4a:	0785                	add	a5,a5,1
     c4c:	fee79de3          	bne	a5,a4,c46 <memset+0x12>
  }
  return dst;
}
     c50:	6422                	ld	s0,8(sp)
     c52:	0141                	add	sp,sp,16
     c54:	8082                	ret

0000000000000c56 <strchr>:

char*
strchr(const char *s, char c)
{
     c56:	1141                	add	sp,sp,-16
     c58:	e422                	sd	s0,8(sp)
     c5a:	0800                	add	s0,sp,16
  for(; *s; s++)
     c5c:	00054783          	lbu	a5,0(a0)
     c60:	cb99                	beqz	a5,c76 <strchr+0x20>
    if(*s == c)
     c62:	00f58763          	beq	a1,a5,c70 <strchr+0x1a>
  for(; *s; s++)
     c66:	0505                	add	a0,a0,1
     c68:	00054783          	lbu	a5,0(a0)
     c6c:	fbfd                	bnez	a5,c62 <strchr+0xc>
      return (char*)s;
  return 0;
     c6e:	4501                	li	a0,0
}
     c70:	6422                	ld	s0,8(sp)
     c72:	0141                	add	sp,sp,16
     c74:	8082                	ret
  return 0;
     c76:	4501                	li	a0,0
     c78:	bfe5                	j	c70 <strchr+0x1a>

0000000000000c7a <gets>:

char*
gets(char *buf, int max)
{
     c7a:	711d                	add	sp,sp,-96
     c7c:	ec86                	sd	ra,88(sp)
     c7e:	e8a2                	sd	s0,80(sp)
     c80:	e4a6                	sd	s1,72(sp)
     c82:	e0ca                	sd	s2,64(sp)
     c84:	fc4e                	sd	s3,56(sp)
     c86:	f852                	sd	s4,48(sp)
     c88:	f456                	sd	s5,40(sp)
     c8a:	f05a                	sd	s6,32(sp)
     c8c:	ec5e                	sd	s7,24(sp)
     c8e:	1080                	add	s0,sp,96
     c90:	8baa                	mv	s7,a0
     c92:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c94:	892a                	mv	s2,a0
     c96:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     c98:	4aa9                	li	s5,10
     c9a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     c9c:	89a6                	mv	s3,s1
     c9e:	2485                	addw	s1,s1,1
     ca0:	0344d863          	bge	s1,s4,cd0 <gets+0x56>
    cc = read(0, &c, 1);
     ca4:	4605                	li	a2,1
     ca6:	faf40593          	add	a1,s0,-81
     caa:	4501                	li	a0,0
     cac:	00000097          	auipc	ra,0x0
     cb0:	1d6080e7          	jalr	470(ra) # e82 <read>
    if(cc < 1)
     cb4:	00a05e63          	blez	a0,cd0 <gets+0x56>
    buf[i++] = c;
     cb8:	faf44783          	lbu	a5,-81(s0)
     cbc:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     cc0:	01578763          	beq	a5,s5,cce <gets+0x54>
     cc4:	0905                	add	s2,s2,1
     cc6:	fd679be3          	bne	a5,s6,c9c <gets+0x22>
  for(i=0; i+1 < max; ){
     cca:	89a6                	mv	s3,s1
     ccc:	a011                	j	cd0 <gets+0x56>
     cce:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     cd0:	99de                	add	s3,s3,s7
     cd2:	00098023          	sb	zero,0(s3)
  return buf;
}
     cd6:	855e                	mv	a0,s7
     cd8:	60e6                	ld	ra,88(sp)
     cda:	6446                	ld	s0,80(sp)
     cdc:	64a6                	ld	s1,72(sp)
     cde:	6906                	ld	s2,64(sp)
     ce0:	79e2                	ld	s3,56(sp)
     ce2:	7a42                	ld	s4,48(sp)
     ce4:	7aa2                	ld	s5,40(sp)
     ce6:	7b02                	ld	s6,32(sp)
     ce8:	6be2                	ld	s7,24(sp)
     cea:	6125                	add	sp,sp,96
     cec:	8082                	ret

0000000000000cee <stat>:

int
stat(const char *n, struct stat *st)
{
     cee:	1101                	add	sp,sp,-32
     cf0:	ec06                	sd	ra,24(sp)
     cf2:	e822                	sd	s0,16(sp)
     cf4:	e426                	sd	s1,8(sp)
     cf6:	e04a                	sd	s2,0(sp)
     cf8:	1000                	add	s0,sp,32
     cfa:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     cfc:	4581                	li	a1,0
     cfe:	00000097          	auipc	ra,0x0
     d02:	1ac080e7          	jalr	428(ra) # eaa <open>
  if(fd < 0)
     d06:	02054563          	bltz	a0,d30 <stat+0x42>
     d0a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     d0c:	85ca                	mv	a1,s2
     d0e:	00000097          	auipc	ra,0x0
     d12:	1b4080e7          	jalr	436(ra) # ec2 <fstat>
     d16:	892a                	mv	s2,a0
  close(fd);
     d18:	8526                	mv	a0,s1
     d1a:	00000097          	auipc	ra,0x0
     d1e:	178080e7          	jalr	376(ra) # e92 <close>
  return r;
}
     d22:	854a                	mv	a0,s2
     d24:	60e2                	ld	ra,24(sp)
     d26:	6442                	ld	s0,16(sp)
     d28:	64a2                	ld	s1,8(sp)
     d2a:	6902                	ld	s2,0(sp)
     d2c:	6105                	add	sp,sp,32
     d2e:	8082                	ret
    return -1;
     d30:	597d                	li	s2,-1
     d32:	bfc5                	j	d22 <stat+0x34>

0000000000000d34 <atoi>:

int
atoi(const char *s)
{
     d34:	1141                	add	sp,sp,-16
     d36:	e422                	sd	s0,8(sp)
     d38:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     d3a:	00054683          	lbu	a3,0(a0)
     d3e:	fd06879b          	addw	a5,a3,-48
     d42:	0ff7f793          	zext.b	a5,a5
     d46:	4625                	li	a2,9
     d48:	02f66863          	bltu	a2,a5,d78 <atoi+0x44>
     d4c:	872a                	mv	a4,a0
  n = 0;
     d4e:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     d50:	0705                	add	a4,a4,1
     d52:	0025179b          	sllw	a5,a0,0x2
     d56:	9fa9                	addw	a5,a5,a0
     d58:	0017979b          	sllw	a5,a5,0x1
     d5c:	9fb5                	addw	a5,a5,a3
     d5e:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     d62:	00074683          	lbu	a3,0(a4)
     d66:	fd06879b          	addw	a5,a3,-48
     d6a:	0ff7f793          	zext.b	a5,a5
     d6e:	fef671e3          	bgeu	a2,a5,d50 <atoi+0x1c>
  return n;
}
     d72:	6422                	ld	s0,8(sp)
     d74:	0141                	add	sp,sp,16
     d76:	8082                	ret
  n = 0;
     d78:	4501                	li	a0,0
     d7a:	bfe5                	j	d72 <atoi+0x3e>

0000000000000d7c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     d7c:	1141                	add	sp,sp,-16
     d7e:	e422                	sd	s0,8(sp)
     d80:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     d82:	02b57463          	bgeu	a0,a1,daa <memmove+0x2e>
    while(n-- > 0)
     d86:	00c05f63          	blez	a2,da4 <memmove+0x28>
     d8a:	1602                	sll	a2,a2,0x20
     d8c:	9201                	srl	a2,a2,0x20
     d8e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     d92:	872a                	mv	a4,a0
      *dst++ = *src++;
     d94:	0585                	add	a1,a1,1
     d96:	0705                	add	a4,a4,1
     d98:	fff5c683          	lbu	a3,-1(a1)
     d9c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     da0:	fee79ae3          	bne	a5,a4,d94 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     da4:	6422                	ld	s0,8(sp)
     da6:	0141                	add	sp,sp,16
     da8:	8082                	ret
    dst += n;
     daa:	00c50733          	add	a4,a0,a2
    src += n;
     dae:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     db0:	fec05ae3          	blez	a2,da4 <memmove+0x28>
     db4:	fff6079b          	addw	a5,a2,-1
     db8:	1782                	sll	a5,a5,0x20
     dba:	9381                	srl	a5,a5,0x20
     dbc:	fff7c793          	not	a5,a5
     dc0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     dc2:	15fd                	add	a1,a1,-1
     dc4:	177d                	add	a4,a4,-1
     dc6:	0005c683          	lbu	a3,0(a1)
     dca:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     dce:	fee79ae3          	bne	a5,a4,dc2 <memmove+0x46>
     dd2:	bfc9                	j	da4 <memmove+0x28>

0000000000000dd4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     dd4:	1141                	add	sp,sp,-16
     dd6:	e422                	sd	s0,8(sp)
     dd8:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     dda:	ca05                	beqz	a2,e0a <memcmp+0x36>
     ddc:	fff6069b          	addw	a3,a2,-1
     de0:	1682                	sll	a3,a3,0x20
     de2:	9281                	srl	a3,a3,0x20
     de4:	0685                	add	a3,a3,1
     de6:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     de8:	00054783          	lbu	a5,0(a0)
     dec:	0005c703          	lbu	a4,0(a1)
     df0:	00e79863          	bne	a5,a4,e00 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     df4:	0505                	add	a0,a0,1
    p2++;
     df6:	0585                	add	a1,a1,1
  while (n-- > 0) {
     df8:	fed518e3          	bne	a0,a3,de8 <memcmp+0x14>
  }
  return 0;
     dfc:	4501                	li	a0,0
     dfe:	a019                	j	e04 <memcmp+0x30>
      return *p1 - *p2;
     e00:	40e7853b          	subw	a0,a5,a4
}
     e04:	6422                	ld	s0,8(sp)
     e06:	0141                	add	sp,sp,16
     e08:	8082                	ret
  return 0;
     e0a:	4501                	li	a0,0
     e0c:	bfe5                	j	e04 <memcmp+0x30>

0000000000000e0e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     e0e:	1141                	add	sp,sp,-16
     e10:	e406                	sd	ra,8(sp)
     e12:	e022                	sd	s0,0(sp)
     e14:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
     e16:	00000097          	auipc	ra,0x0
     e1a:	f66080e7          	jalr	-154(ra) # d7c <memmove>
}
     e1e:	60a2                	ld	ra,8(sp)
     e20:	6402                	ld	s0,0(sp)
     e22:	0141                	add	sp,sp,16
     e24:	8082                	ret

0000000000000e26 <initlock>:

// Initialize the spinlock
void initlock(struct spinlock_u *lk) {
     e26:	1141                	add	sp,sp,-16
     e28:	e422                	sd	s0,8(sp)
     e2a:	0800                	add	s0,sp,16
  lk->locked = 0;
     e2c:	00052023          	sw	zero,0(a0)
}
     e30:	6422                	ld	s0,8(sp)
     e32:	0141                	add	sp,sp,16
     e34:	8082                	ret

0000000000000e36 <acquire>:

// Acquire the spinlock
void acquire(struct spinlock_u *lk) {
     e36:	1141                	add	sp,sp,-16
     e38:	e422                	sd	s0,8(sp)
     e3a:	0800                	add	s0,sp,16
  while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
     e3c:	4705                	li	a4,1
     e3e:	87ba                	mv	a5,a4
     e40:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
     e44:	2781                	sext.w	a5,a5
     e46:	ffe5                	bnez	a5,e3e <acquire+0x8>
    ; // Spin until the lock is acquired
}
     e48:	6422                	ld	s0,8(sp)
     e4a:	0141                	add	sp,sp,16
     e4c:	8082                	ret

0000000000000e4e <release>:

// Release the spinlock
void release(struct spinlock_u *lk) {
     e4e:	1141                	add	sp,sp,-16
     e50:	e422                	sd	s0,8(sp)
     e52:	0800                	add	s0,sp,16
  __sync_lock_release(&lk->locked);
     e54:	0f50000f          	fence	iorw,ow
     e58:	0805202f          	amoswap.w	zero,zero,(a0)
}
     e5c:	6422                	ld	s0,8(sp)
     e5e:	0141                	add	sp,sp,16
     e60:	8082                	ret

0000000000000e62 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     e62:	4885                	li	a7,1
 ecall
     e64:	00000073          	ecall
 ret
     e68:	8082                	ret

0000000000000e6a <exit>:
.global exit
exit:
 li a7, SYS_exit
     e6a:	4889                	li	a7,2
 ecall
     e6c:	00000073          	ecall
 ret
     e70:	8082                	ret

0000000000000e72 <wait>:
.global wait
wait:
 li a7, SYS_wait
     e72:	488d                	li	a7,3
 ecall
     e74:	00000073          	ecall
 ret
     e78:	8082                	ret

0000000000000e7a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     e7a:	4891                	li	a7,4
 ecall
     e7c:	00000073          	ecall
 ret
     e80:	8082                	ret

0000000000000e82 <read>:
.global read
read:
 li a7, SYS_read
     e82:	4895                	li	a7,5
 ecall
     e84:	00000073          	ecall
 ret
     e88:	8082                	ret

0000000000000e8a <write>:
.global write
write:
 li a7, SYS_write
     e8a:	48c1                	li	a7,16
 ecall
     e8c:	00000073          	ecall
 ret
     e90:	8082                	ret

0000000000000e92 <close>:
.global close
close:
 li a7, SYS_close
     e92:	48d5                	li	a7,21
 ecall
     e94:	00000073          	ecall
 ret
     e98:	8082                	ret

0000000000000e9a <kill>:
.global kill
kill:
 li a7, SYS_kill
     e9a:	4899                	li	a7,6
 ecall
     e9c:	00000073          	ecall
 ret
     ea0:	8082                	ret

0000000000000ea2 <exec>:
.global exec
exec:
 li a7, SYS_exec
     ea2:	489d                	li	a7,7
 ecall
     ea4:	00000073          	ecall
 ret
     ea8:	8082                	ret

0000000000000eaa <open>:
.global open
open:
 li a7, SYS_open
     eaa:	48bd                	li	a7,15
 ecall
     eac:	00000073          	ecall
 ret
     eb0:	8082                	ret

0000000000000eb2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     eb2:	48c5                	li	a7,17
 ecall
     eb4:	00000073          	ecall
 ret
     eb8:	8082                	ret

0000000000000eba <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     eba:	48c9                	li	a7,18
 ecall
     ebc:	00000073          	ecall
 ret
     ec0:	8082                	ret

0000000000000ec2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     ec2:	48a1                	li	a7,8
 ecall
     ec4:	00000073          	ecall
 ret
     ec8:	8082                	ret

0000000000000eca <link>:
.global link
link:
 li a7, SYS_link
     eca:	48cd                	li	a7,19
 ecall
     ecc:	00000073          	ecall
 ret
     ed0:	8082                	ret

0000000000000ed2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     ed2:	48d1                	li	a7,20
 ecall
     ed4:	00000073          	ecall
 ret
     ed8:	8082                	ret

0000000000000eda <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     eda:	48a5                	li	a7,9
 ecall
     edc:	00000073          	ecall
 ret
     ee0:	8082                	ret

0000000000000ee2 <dup>:
.global dup
dup:
 li a7, SYS_dup
     ee2:	48a9                	li	a7,10
 ecall
     ee4:	00000073          	ecall
 ret
     ee8:	8082                	ret

0000000000000eea <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     eea:	48ad                	li	a7,11
 ecall
     eec:	00000073          	ecall
 ret
     ef0:	8082                	ret

0000000000000ef2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     ef2:	48b1                	li	a7,12
 ecall
     ef4:	00000073          	ecall
 ret
     ef8:	8082                	ret

0000000000000efa <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     efa:	48b5                	li	a7,13
 ecall
     efc:	00000073          	ecall
 ret
     f00:	8082                	ret

0000000000000f02 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     f02:	48b9                	li	a7,14
 ecall
     f04:	00000073          	ecall
 ret
     f08:	8082                	ret

0000000000000f0a <rcureadlock>:
.global rcureadlock
rcureadlock:
 li a7, SYS_rcureadlock
     f0a:	48dd                	li	a7,23
 ecall
     f0c:	00000073          	ecall
 ret
     f10:	8082                	ret

0000000000000f12 <rcureadunlock>:
.global rcureadunlock
rcureadunlock:
 li a7, SYS_rcureadunlock
     f12:	48e1                	li	a7,24
 ecall
     f14:	00000073          	ecall
 ret
     f18:	8082                	ret

0000000000000f1a <rcusync>:
.global rcusync
rcusync:
 li a7, SYS_rcusync
     f1a:	48d9                	li	a7,22
 ecall
     f1c:	00000073          	ecall
 ret
     f20:	8082                	ret

0000000000000f22 <thread_create>:
.global thread_create
thread_create:
 li a7, SYS_thread_create
     f22:	48e5                	li	a7,25
 ecall
     f24:	00000073          	ecall
 ret
     f28:	8082                	ret

0000000000000f2a <thread_join>:
.global thread_join
thread_join:
 li a7, SYS_thread_join
     f2a:	48e9                	li	a7,26
 ecall
     f2c:	00000073          	ecall
 ret
     f30:	8082                	ret

0000000000000f32 <thread_exit>:
.global thread_exit
thread_exit:
 li a7, SYS_thread_exit
     f32:	48ed                	li	a7,27
 ecall
     f34:	00000073          	ecall
 ret
     f38:	8082                	ret

0000000000000f3a <klist_insert>:
.global klist_insert
klist_insert:
 li a7, SYS_klist_insert
     f3a:	48f1                	li	a7,28
 ecall
     f3c:	00000073          	ecall
 ret
     f40:	8082                	ret

0000000000000f42 <klist_delete>:
.global klist_delete
klist_delete:
 li a7, SYS_klist_delete
     f42:	48f5                	li	a7,29
 ecall
     f44:	00000073          	ecall
 ret
     f48:	8082                	ret

0000000000000f4a <klist_query>:
.global klist_query
klist_query:
 li a7, SYS_klist_query
     f4a:	48f9                	li	a7,30
 ecall
     f4c:	00000073          	ecall
 ret
     f50:	8082                	ret

0000000000000f52 <klist_print>:
.global klist_print
klist_print:
 li a7, SYS_klist_print
     f52:	48fd                	li	a7,31
 ecall
     f54:	00000073          	ecall
 ret
     f58:	8082                	ret

0000000000000f5a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     f5a:	1101                	add	sp,sp,-32
     f5c:	ec06                	sd	ra,24(sp)
     f5e:	e822                	sd	s0,16(sp)
     f60:	1000                	add	s0,sp,32
     f62:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     f66:	4605                	li	a2,1
     f68:	fef40593          	add	a1,s0,-17
     f6c:	00000097          	auipc	ra,0x0
     f70:	f1e080e7          	jalr	-226(ra) # e8a <write>
}
     f74:	60e2                	ld	ra,24(sp)
     f76:	6442                	ld	s0,16(sp)
     f78:	6105                	add	sp,sp,32
     f7a:	8082                	ret

0000000000000f7c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     f7c:	7139                	add	sp,sp,-64
     f7e:	fc06                	sd	ra,56(sp)
     f80:	f822                	sd	s0,48(sp)
     f82:	f426                	sd	s1,40(sp)
     f84:	f04a                	sd	s2,32(sp)
     f86:	ec4e                	sd	s3,24(sp)
     f88:	0080                	add	s0,sp,64
     f8a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     f8c:	c299                	beqz	a3,f92 <printint+0x16>
     f8e:	0805c963          	bltz	a1,1020 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     f92:	2581                	sext.w	a1,a1
  neg = 0;
     f94:	4881                	li	a7,0
     f96:	fc040693          	add	a3,s0,-64
  }

  i = 0;
     f9a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     f9c:	2601                	sext.w	a2,a2
     f9e:	00001517          	auipc	a0,0x1
     fa2:	94a50513          	add	a0,a0,-1718 # 18e8 <digits>
     fa6:	883a                	mv	a6,a4
     fa8:	2705                	addw	a4,a4,1
     faa:	02c5f7bb          	remuw	a5,a1,a2
     fae:	1782                	sll	a5,a5,0x20
     fb0:	9381                	srl	a5,a5,0x20
     fb2:	97aa                	add	a5,a5,a0
     fb4:	0007c783          	lbu	a5,0(a5)
     fb8:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     fbc:	0005879b          	sext.w	a5,a1
     fc0:	02c5d5bb          	divuw	a1,a1,a2
     fc4:	0685                	add	a3,a3,1
     fc6:	fec7f0e3          	bgeu	a5,a2,fa6 <printint+0x2a>
  if(neg)
     fca:	00088c63          	beqz	a7,fe2 <printint+0x66>
    buf[i++] = '-';
     fce:	fd070793          	add	a5,a4,-48
     fd2:	00878733          	add	a4,a5,s0
     fd6:	02d00793          	li	a5,45
     fda:	fef70823          	sb	a5,-16(a4)
     fde:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
     fe2:	02e05863          	blez	a4,1012 <printint+0x96>
     fe6:	fc040793          	add	a5,s0,-64
     fea:	00e78933          	add	s2,a5,a4
     fee:	fff78993          	add	s3,a5,-1
     ff2:	99ba                	add	s3,s3,a4
     ff4:	377d                	addw	a4,a4,-1
     ff6:	1702                	sll	a4,a4,0x20
     ff8:	9301                	srl	a4,a4,0x20
     ffa:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     ffe:	fff94583          	lbu	a1,-1(s2)
    1002:	8526                	mv	a0,s1
    1004:	00000097          	auipc	ra,0x0
    1008:	f56080e7          	jalr	-170(ra) # f5a <putc>
  while(--i >= 0)
    100c:	197d                	add	s2,s2,-1
    100e:	ff3918e3          	bne	s2,s3,ffe <printint+0x82>
}
    1012:	70e2                	ld	ra,56(sp)
    1014:	7442                	ld	s0,48(sp)
    1016:	74a2                	ld	s1,40(sp)
    1018:	7902                	ld	s2,32(sp)
    101a:	69e2                	ld	s3,24(sp)
    101c:	6121                	add	sp,sp,64
    101e:	8082                	ret
    x = -xx;
    1020:	40b005bb          	negw	a1,a1
    neg = 1;
    1024:	4885                	li	a7,1
    x = -xx;
    1026:	bf85                	j	f96 <printint+0x1a>

0000000000001028 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    1028:	715d                	add	sp,sp,-80
    102a:	e486                	sd	ra,72(sp)
    102c:	e0a2                	sd	s0,64(sp)
    102e:	fc26                	sd	s1,56(sp)
    1030:	f84a                	sd	s2,48(sp)
    1032:	f44e                	sd	s3,40(sp)
    1034:	f052                	sd	s4,32(sp)
    1036:	ec56                	sd	s5,24(sp)
    1038:	e85a                	sd	s6,16(sp)
    103a:	e45e                	sd	s7,8(sp)
    103c:	e062                	sd	s8,0(sp)
    103e:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    1040:	0005c903          	lbu	s2,0(a1)
    1044:	18090c63          	beqz	s2,11dc <vprintf+0x1b4>
    1048:	8aaa                	mv	s5,a0
    104a:	8bb2                	mv	s7,a2
    104c:	00158493          	add	s1,a1,1
  state = 0;
    1050:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1052:	02500a13          	li	s4,37
    1056:	4b55                	li	s6,21
    1058:	a839                	j	1076 <vprintf+0x4e>
        putc(fd, c);
    105a:	85ca                	mv	a1,s2
    105c:	8556                	mv	a0,s5
    105e:	00000097          	auipc	ra,0x0
    1062:	efc080e7          	jalr	-260(ra) # f5a <putc>
    1066:	a019                	j	106c <vprintf+0x44>
    } else if(state == '%'){
    1068:	01498d63          	beq	s3,s4,1082 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
    106c:	0485                	add	s1,s1,1
    106e:	fff4c903          	lbu	s2,-1(s1)
    1072:	16090563          	beqz	s2,11dc <vprintf+0x1b4>
    if(state == 0){
    1076:	fe0999e3          	bnez	s3,1068 <vprintf+0x40>
      if(c == '%'){
    107a:	ff4910e3          	bne	s2,s4,105a <vprintf+0x32>
        state = '%';
    107e:	89d2                	mv	s3,s4
    1080:	b7f5                	j	106c <vprintf+0x44>
      if(c == 'd'){
    1082:	13490263          	beq	s2,s4,11a6 <vprintf+0x17e>
    1086:	f9d9079b          	addw	a5,s2,-99
    108a:	0ff7f793          	zext.b	a5,a5
    108e:	12fb6563          	bltu	s6,a5,11b8 <vprintf+0x190>
    1092:	f9d9079b          	addw	a5,s2,-99
    1096:	0ff7f713          	zext.b	a4,a5
    109a:	10eb6f63          	bltu	s6,a4,11b8 <vprintf+0x190>
    109e:	00271793          	sll	a5,a4,0x2
    10a2:	00000717          	auipc	a4,0x0
    10a6:	7ee70713          	add	a4,a4,2030 # 1890 <updateNode+0x38c>
    10aa:	97ba                	add	a5,a5,a4
    10ac:	439c                	lw	a5,0(a5)
    10ae:	97ba                	add	a5,a5,a4
    10b0:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    10b2:	008b8913          	add	s2,s7,8
    10b6:	4685                	li	a3,1
    10b8:	4629                	li	a2,10
    10ba:	000ba583          	lw	a1,0(s7)
    10be:	8556                	mv	a0,s5
    10c0:	00000097          	auipc	ra,0x0
    10c4:	ebc080e7          	jalr	-324(ra) # f7c <printint>
    10c8:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    10ca:	4981                	li	s3,0
    10cc:	b745                	j	106c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    10ce:	008b8913          	add	s2,s7,8
    10d2:	4681                	li	a3,0
    10d4:	4629                	li	a2,10
    10d6:	000ba583          	lw	a1,0(s7)
    10da:	8556                	mv	a0,s5
    10dc:	00000097          	auipc	ra,0x0
    10e0:	ea0080e7          	jalr	-352(ra) # f7c <printint>
    10e4:	8bca                	mv	s7,s2
      state = 0;
    10e6:	4981                	li	s3,0
    10e8:	b751                	j	106c <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
    10ea:	008b8913          	add	s2,s7,8
    10ee:	4681                	li	a3,0
    10f0:	4641                	li	a2,16
    10f2:	000ba583          	lw	a1,0(s7)
    10f6:	8556                	mv	a0,s5
    10f8:	00000097          	auipc	ra,0x0
    10fc:	e84080e7          	jalr	-380(ra) # f7c <printint>
    1100:	8bca                	mv	s7,s2
      state = 0;
    1102:	4981                	li	s3,0
    1104:	b7a5                	j	106c <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
    1106:	008b8c13          	add	s8,s7,8
    110a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    110e:	03000593          	li	a1,48
    1112:	8556                	mv	a0,s5
    1114:	00000097          	auipc	ra,0x0
    1118:	e46080e7          	jalr	-442(ra) # f5a <putc>
  putc(fd, 'x');
    111c:	07800593          	li	a1,120
    1120:	8556                	mv	a0,s5
    1122:	00000097          	auipc	ra,0x0
    1126:	e38080e7          	jalr	-456(ra) # f5a <putc>
    112a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    112c:	00000b97          	auipc	s7,0x0
    1130:	7bcb8b93          	add	s7,s7,1980 # 18e8 <digits>
    1134:	03c9d793          	srl	a5,s3,0x3c
    1138:	97de                	add	a5,a5,s7
    113a:	0007c583          	lbu	a1,0(a5)
    113e:	8556                	mv	a0,s5
    1140:	00000097          	auipc	ra,0x0
    1144:	e1a080e7          	jalr	-486(ra) # f5a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1148:	0992                	sll	s3,s3,0x4
    114a:	397d                	addw	s2,s2,-1
    114c:	fe0914e3          	bnez	s2,1134 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
    1150:	8be2                	mv	s7,s8
      state = 0;
    1152:	4981                	li	s3,0
    1154:	bf21                	j	106c <vprintf+0x44>
        s = va_arg(ap, char*);
    1156:	008b8993          	add	s3,s7,8
    115a:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    115e:	02090163          	beqz	s2,1180 <vprintf+0x158>
        while(*s != 0){
    1162:	00094583          	lbu	a1,0(s2)
    1166:	c9a5                	beqz	a1,11d6 <vprintf+0x1ae>
          putc(fd, *s);
    1168:	8556                	mv	a0,s5
    116a:	00000097          	auipc	ra,0x0
    116e:	df0080e7          	jalr	-528(ra) # f5a <putc>
          s++;
    1172:	0905                	add	s2,s2,1
        while(*s != 0){
    1174:	00094583          	lbu	a1,0(s2)
    1178:	f9e5                	bnez	a1,1168 <vprintf+0x140>
        s = va_arg(ap, char*);
    117a:	8bce                	mv	s7,s3
      state = 0;
    117c:	4981                	li	s3,0
    117e:	b5fd                	j	106c <vprintf+0x44>
          s = "(null)";
    1180:	00000917          	auipc	s2,0x0
    1184:	70890913          	add	s2,s2,1800 # 1888 <updateNode+0x384>
        while(*s != 0){
    1188:	02800593          	li	a1,40
    118c:	bff1                	j	1168 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
    118e:	008b8913          	add	s2,s7,8
    1192:	000bc583          	lbu	a1,0(s7)
    1196:	8556                	mv	a0,s5
    1198:	00000097          	auipc	ra,0x0
    119c:	dc2080e7          	jalr	-574(ra) # f5a <putc>
    11a0:	8bca                	mv	s7,s2
      state = 0;
    11a2:	4981                	li	s3,0
    11a4:	b5e1                	j	106c <vprintf+0x44>
        putc(fd, c);
    11a6:	02500593          	li	a1,37
    11aa:	8556                	mv	a0,s5
    11ac:	00000097          	auipc	ra,0x0
    11b0:	dae080e7          	jalr	-594(ra) # f5a <putc>
      state = 0;
    11b4:	4981                	li	s3,0
    11b6:	bd5d                	j	106c <vprintf+0x44>
        putc(fd, '%');
    11b8:	02500593          	li	a1,37
    11bc:	8556                	mv	a0,s5
    11be:	00000097          	auipc	ra,0x0
    11c2:	d9c080e7          	jalr	-612(ra) # f5a <putc>
        putc(fd, c);
    11c6:	85ca                	mv	a1,s2
    11c8:	8556                	mv	a0,s5
    11ca:	00000097          	auipc	ra,0x0
    11ce:	d90080e7          	jalr	-624(ra) # f5a <putc>
      state = 0;
    11d2:	4981                	li	s3,0
    11d4:	bd61                	j	106c <vprintf+0x44>
        s = va_arg(ap, char*);
    11d6:	8bce                	mv	s7,s3
      state = 0;
    11d8:	4981                	li	s3,0
    11da:	bd49                	j	106c <vprintf+0x44>
    }
  }
}
    11dc:	60a6                	ld	ra,72(sp)
    11de:	6406                	ld	s0,64(sp)
    11e0:	74e2                	ld	s1,56(sp)
    11e2:	7942                	ld	s2,48(sp)
    11e4:	79a2                	ld	s3,40(sp)
    11e6:	7a02                	ld	s4,32(sp)
    11e8:	6ae2                	ld	s5,24(sp)
    11ea:	6b42                	ld	s6,16(sp)
    11ec:	6ba2                	ld	s7,8(sp)
    11ee:	6c02                	ld	s8,0(sp)
    11f0:	6161                	add	sp,sp,80
    11f2:	8082                	ret

00000000000011f4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    11f4:	715d                	add	sp,sp,-80
    11f6:	ec06                	sd	ra,24(sp)
    11f8:	e822                	sd	s0,16(sp)
    11fa:	1000                	add	s0,sp,32
    11fc:	e010                	sd	a2,0(s0)
    11fe:	e414                	sd	a3,8(s0)
    1200:	e818                	sd	a4,16(s0)
    1202:	ec1c                	sd	a5,24(s0)
    1204:	03043023          	sd	a6,32(s0)
    1208:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    120c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1210:	8622                	mv	a2,s0
    1212:	00000097          	auipc	ra,0x0
    1216:	e16080e7          	jalr	-490(ra) # 1028 <vprintf>
}
    121a:	60e2                	ld	ra,24(sp)
    121c:	6442                	ld	s0,16(sp)
    121e:	6161                	add	sp,sp,80
    1220:	8082                	ret

0000000000001222 <printf>:

void
printf(const char *fmt, ...)
{
    1222:	711d                	add	sp,sp,-96
    1224:	ec06                	sd	ra,24(sp)
    1226:	e822                	sd	s0,16(sp)
    1228:	1000                	add	s0,sp,32
    122a:	e40c                	sd	a1,8(s0)
    122c:	e810                	sd	a2,16(s0)
    122e:	ec14                	sd	a3,24(s0)
    1230:	f018                	sd	a4,32(s0)
    1232:	f41c                	sd	a5,40(s0)
    1234:	03043823          	sd	a6,48(s0)
    1238:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    123c:	00840613          	add	a2,s0,8
    1240:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1244:	85aa                	mv	a1,a0
    1246:	4505                	li	a0,1
    1248:	00000097          	auipc	ra,0x0
    124c:	de0080e7          	jalr	-544(ra) # 1028 <vprintf>
}
    1250:	60e2                	ld	ra,24(sp)
    1252:	6442                	ld	s0,16(sp)
    1254:	6125                	add	sp,sp,96
    1256:	8082                	ret

0000000000001258 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1258:	1141                	add	sp,sp,-16
    125a:	e422                	sd	s0,8(sp)
    125c:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    125e:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1262:	00001797          	auipc	a5,0x1
    1266:	dae7b783          	ld	a5,-594(a5) # 2010 <freep>
    126a:	a02d                	j	1294 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    126c:	4618                	lw	a4,8(a2)
    126e:	9f2d                	addw	a4,a4,a1
    1270:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1274:	6398                	ld	a4,0(a5)
    1276:	6310                	ld	a2,0(a4)
    1278:	a83d                	j	12b6 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    127a:	ff852703          	lw	a4,-8(a0)
    127e:	9f31                	addw	a4,a4,a2
    1280:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1282:	ff053683          	ld	a3,-16(a0)
    1286:	a091                	j	12ca <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1288:	6398                	ld	a4,0(a5)
    128a:	00e7e463          	bltu	a5,a4,1292 <free+0x3a>
    128e:	00e6ea63          	bltu	a3,a4,12a2 <free+0x4a>
{
    1292:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1294:	fed7fae3          	bgeu	a5,a3,1288 <free+0x30>
    1298:	6398                	ld	a4,0(a5)
    129a:	00e6e463          	bltu	a3,a4,12a2 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    129e:	fee7eae3          	bltu	a5,a4,1292 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    12a2:	ff852583          	lw	a1,-8(a0)
    12a6:	6390                	ld	a2,0(a5)
    12a8:	02059813          	sll	a6,a1,0x20
    12ac:	01c85713          	srl	a4,a6,0x1c
    12b0:	9736                	add	a4,a4,a3
    12b2:	fae60de3          	beq	a2,a4,126c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    12b6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    12ba:	4790                	lw	a2,8(a5)
    12bc:	02061593          	sll	a1,a2,0x20
    12c0:	01c5d713          	srl	a4,a1,0x1c
    12c4:	973e                	add	a4,a4,a5
    12c6:	fae68ae3          	beq	a3,a4,127a <free+0x22>
    p->s.ptr = bp->s.ptr;
    12ca:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    12cc:	00001717          	auipc	a4,0x1
    12d0:	d4f73223          	sd	a5,-700(a4) # 2010 <freep>
}
    12d4:	6422                	ld	s0,8(sp)
    12d6:	0141                	add	sp,sp,16
    12d8:	8082                	ret

00000000000012da <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    12da:	7139                	add	sp,sp,-64
    12dc:	fc06                	sd	ra,56(sp)
    12de:	f822                	sd	s0,48(sp)
    12e0:	f426                	sd	s1,40(sp)
    12e2:	f04a                	sd	s2,32(sp)
    12e4:	ec4e                	sd	s3,24(sp)
    12e6:	e852                	sd	s4,16(sp)
    12e8:	e456                	sd	s5,8(sp)
    12ea:	e05a                	sd	s6,0(sp)
    12ec:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    12ee:	02051493          	sll	s1,a0,0x20
    12f2:	9081                	srl	s1,s1,0x20
    12f4:	04bd                	add	s1,s1,15
    12f6:	8091                	srl	s1,s1,0x4
    12f8:	0014899b          	addw	s3,s1,1
    12fc:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    12fe:	00001517          	auipc	a0,0x1
    1302:	d1253503          	ld	a0,-750(a0) # 2010 <freep>
    1306:	c515                	beqz	a0,1332 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1308:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    130a:	4798                	lw	a4,8(a5)
    130c:	02977f63          	bgeu	a4,s1,134a <malloc+0x70>
  if(nu < 4096)
    1310:	8a4e                	mv	s4,s3
    1312:	0009871b          	sext.w	a4,s3
    1316:	6685                	lui	a3,0x1
    1318:	00d77363          	bgeu	a4,a3,131e <malloc+0x44>
    131c:	6a05                	lui	s4,0x1
    131e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1322:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1326:	00001917          	auipc	s2,0x1
    132a:	cea90913          	add	s2,s2,-790 # 2010 <freep>
  if(p == (char*)-1)
    132e:	5afd                	li	s5,-1
    1330:	a895                	j	13a4 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
    1332:	00001797          	auipc	a5,0x1
    1336:	0d678793          	add	a5,a5,214 # 2408 <base>
    133a:	00001717          	auipc	a4,0x1
    133e:	ccf73b23          	sd	a5,-810(a4) # 2010 <freep>
    1342:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1344:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    1348:	b7e1                	j	1310 <malloc+0x36>
      if(p->s.size == nunits)
    134a:	02e48c63          	beq	s1,a4,1382 <malloc+0xa8>
        p->s.size -= nunits;
    134e:	4137073b          	subw	a4,a4,s3
    1352:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1354:	02071693          	sll	a3,a4,0x20
    1358:	01c6d713          	srl	a4,a3,0x1c
    135c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    135e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    1362:	00001717          	auipc	a4,0x1
    1366:	caa73723          	sd	a0,-850(a4) # 2010 <freep>
      return (void*)(p + 1);
    136a:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    136e:	70e2                	ld	ra,56(sp)
    1370:	7442                	ld	s0,48(sp)
    1372:	74a2                	ld	s1,40(sp)
    1374:	7902                	ld	s2,32(sp)
    1376:	69e2                	ld	s3,24(sp)
    1378:	6a42                	ld	s4,16(sp)
    137a:	6aa2                	ld	s5,8(sp)
    137c:	6b02                	ld	s6,0(sp)
    137e:	6121                	add	sp,sp,64
    1380:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    1382:	6398                	ld	a4,0(a5)
    1384:	e118                	sd	a4,0(a0)
    1386:	bff1                	j	1362 <malloc+0x88>
  hp->s.size = nu;
    1388:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    138c:	0541                	add	a0,a0,16
    138e:	00000097          	auipc	ra,0x0
    1392:	eca080e7          	jalr	-310(ra) # 1258 <free>
  return freep;
    1396:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    139a:	d971                	beqz	a0,136e <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    139c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    139e:	4798                	lw	a4,8(a5)
    13a0:	fa9775e3          	bgeu	a4,s1,134a <malloc+0x70>
    if(p == freep)
    13a4:	00093703          	ld	a4,0(s2)
    13a8:	853e                	mv	a0,a5
    13aa:	fef719e3          	bne	a4,a5,139c <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
    13ae:	8552                	mv	a0,s4
    13b0:	00000097          	auipc	ra,0x0
    13b4:	b42080e7          	jalr	-1214(ra) # ef2 <sbrk>
  if(p == (char*)-1)
    13b8:	fd5518e3          	bne	a0,s5,1388 <malloc+0xae>
        return 0;
    13bc:	4501                	li	a0,0
    13be:	bf45                	j	136e <malloc+0x94>

00000000000013c0 <init_lock>:
#include "linkedlist.h"

// Define a node structure for the linked list
struct spinlock_u list_lock;

void init_lock(){
    13c0:	1141                	add	sp,sp,-16
    13c2:	e406                	sd	ra,8(sp)
    13c4:	e022                	sd	s0,0(sp)
    13c6:	0800                	add	s0,sp,16
    initlock(&list_lock);
    13c8:	00001517          	auipc	a0,0x1
    13cc:	c5050513          	add	a0,a0,-944 # 2018 <list_lock>
    13d0:	00000097          	auipc	ra,0x0
    13d4:	a56080e7          	jalr	-1450(ra) # e26 <initlock>
}
    13d8:	60a2                	ld	ra,8(sp)
    13da:	6402                	ld	s0,0(sp)
    13dc:	0141                	add	sp,sp,16
    13de:	8082                	ret

00000000000013e0 <insert>:

// Function to insert a node at the beginning of the linked list
void insert(struct Node **head_ref, int new_data) {
    13e0:	1101                	add	sp,sp,-32
    13e2:	ec06                	sd	ra,24(sp)
    13e4:	e822                	sd	s0,16(sp)
    13e6:	e426                	sd	s1,8(sp)
    13e8:	e04a                	sd	s2,0(sp)
    13ea:	1000                	add	s0,sp,32
    13ec:	84aa                	mv	s1,a0
    13ee:	892e                	mv	s2,a1
    struct Node *new_node = malloc(sizeof(struct Node));
    13f0:	4541                	li	a0,16
    13f2:	00000097          	auipc	ra,0x0
    13f6:	ee8080e7          	jalr	-280(ra) # 12da <malloc>
    new_node->data = new_data;
    13fa:	01252023          	sw	s2,0(a0)
    new_node->next = *head_ref;
    13fe:	609c                	ld	a5,0(s1)
    1400:	e51c                	sd	a5,8(a0)
    *head_ref = new_node;
    1402:	e088                	sd	a0,0(s1)
}
    1404:	60e2                	ld	ra,24(sp)
    1406:	6442                	ld	s0,16(sp)
    1408:	64a2                	ld	s1,8(sp)
    140a:	6902                	ld	s2,0(sp)
    140c:	6105                	add	sp,sp,32
    140e:	8082                	ret

0000000000001410 <deleteNode>:

// Function to delete a node with a given key from the linked list
void deleteNode(struct Node **head_ref, int key) {
    1410:	7179                	add	sp,sp,-48
    1412:	f406                	sd	ra,40(sp)
    1414:	f022                	sd	s0,32(sp)
    1416:	ec26                	sd	s1,24(sp)
    1418:	e84a                	sd	s2,16(sp)
    141a:	e44e                	sd	s3,8(sp)
    141c:	1800                	add	s0,sp,48
    141e:	89aa                	mv	s3,a0
    1420:	892e                	mv	s2,a1
    struct Node *temp = *head_ref, *prev = 0;
    1422:	6104                	ld	s1,0(a0)

    acquire(&list_lock);
    1424:	00001517          	auipc	a0,0x1
    1428:	bf450513          	add	a0,a0,-1036 # 2018 <list_lock>
    142c:	00000097          	auipc	ra,0x0
    1430:	a0a080e7          	jalr	-1526(ra) # e36 <acquire>
    if (temp != 0 && temp->data == key) {
    1434:	c0b1                	beqz	s1,1478 <deleteNode+0x68>
    1436:	409c                	lw	a5,0(s1)
    1438:	4701                	li	a4,0
    143a:	01278a63          	beq	a5,s2,144e <deleteNode+0x3e>
        rcusync();
        free(temp);
        return;
    }

    while (temp != 0 && temp->data != key) {
    143e:	409c                	lw	a5,0(s1)
    1440:	05278563          	beq	a5,s2,148a <deleteNode+0x7a>
        prev = temp;
        temp = temp->next;
    1444:	649c                	ld	a5,8(s1)
    while (temp != 0 && temp->data != key) {
    1446:	8726                	mv	a4,s1
    1448:	cb85                	beqz	a5,1478 <deleteNode+0x68>
        temp = temp->next;
    144a:	84be                	mv	s1,a5
    144c:	bfcd                	j	143e <deleteNode+0x2e>
        *head_ref = temp->next;
    144e:	649c                	ld	a5,8(s1)
    1450:	00f9b023          	sd	a5,0(s3)
        release(&list_lock);
    1454:	00001517          	auipc	a0,0x1
    1458:	bc450513          	add	a0,a0,-1084 # 2018 <list_lock>
    145c:	00000097          	auipc	ra,0x0
    1460:	9f2080e7          	jalr	-1550(ra) # e4e <release>
        rcusync();
    1464:	00000097          	auipc	ra,0x0
    1468:	ab6080e7          	jalr	-1354(ra) # f1a <rcusync>
        free(temp);
    146c:	8526                	mv	a0,s1
    146e:	00000097          	auipc	ra,0x0
    1472:	dea080e7          	jalr	-534(ra) # 1258 <free>
        return;
    1476:	a82d                	j	14b0 <deleteNode+0xa0>
    }

    if (temp == 0) {
        release(&list_lock);
    1478:	00001517          	auipc	a0,0x1
    147c:	ba050513          	add	a0,a0,-1120 # 2018 <list_lock>
    1480:	00000097          	auipc	ra,0x0
    1484:	9ce080e7          	jalr	-1586(ra) # e4e <release>
        return;
    1488:	a025                	j	14b0 <deleteNode+0xa0>
    }
    prev->next = temp->next;
    148a:	649c                	ld	a5,8(s1)
    148c:	e71c                	sd	a5,8(a4)
    release(&list_lock);
    148e:	00001517          	auipc	a0,0x1
    1492:	b8a50513          	add	a0,a0,-1142 # 2018 <list_lock>
    1496:	00000097          	auipc	ra,0x0
    149a:	9b8080e7          	jalr	-1608(ra) # e4e <release>
    rcusync();
    149e:	00000097          	auipc	ra,0x0
    14a2:	a7c080e7          	jalr	-1412(ra) # f1a <rcusync>
    free(temp);
    14a6:	8526                	mv	a0,s1
    14a8:	00000097          	auipc	ra,0x0
    14ac:	db0080e7          	jalr	-592(ra) # 1258 <free>
}
    14b0:	70a2                	ld	ra,40(sp)
    14b2:	7402                	ld	s0,32(sp)
    14b4:	64e2                	ld	s1,24(sp)
    14b6:	6942                	ld	s2,16(sp)
    14b8:	69a2                	ld	s3,8(sp)
    14ba:	6145                	add	sp,sp,48
    14bc:	8082                	ret

00000000000014be <search>:

// Function to search for a node with a given key in the linked list
struct Node* search(struct Node *head, int key) {
    14be:	1101                	add	sp,sp,-32
    14c0:	ec06                	sd	ra,24(sp)
    14c2:	e822                	sd	s0,16(sp)
    14c4:	e426                	sd	s1,8(sp)
    14c6:	e04a                	sd	s2,0(sp)
    14c8:	1000                	add	s0,sp,32
    14ca:	84aa                	mv	s1,a0
    14cc:	892e                	mv	s2,a1

    struct Node *current = head;
    rcureadlock();
    14ce:	00000097          	auipc	ra,0x0
    14d2:	a3c080e7          	jalr	-1476(ra) # f0a <rcureadlock>
    while (current != 0) {
    14d6:	c491                	beqz	s1,14e2 <search+0x24>
        if (current->data == key) {
    14d8:	409c                	lw	a5,0(s1)
    14da:	01278f63          	beq	a5,s2,14f8 <search+0x3a>
            rcureadunlock();
            return current; // Node found
        }
        current = current->next;
    14de:	6484                	ld	s1,8(s1)
    while (current != 0) {
    14e0:	fce5                	bnez	s1,14d8 <search+0x1a>
    }
    rcureadunlock();
    14e2:	00000097          	auipc	ra,0x0
    14e6:	a30080e7          	jalr	-1488(ra) # f12 <rcureadunlock>
    return 0; // Node not found
    14ea:	4501                	li	a0,0
}
    14ec:	60e2                	ld	ra,24(sp)
    14ee:	6442                	ld	s0,16(sp)
    14f0:	64a2                	ld	s1,8(sp)
    14f2:	6902                	ld	s2,0(sp)
    14f4:	6105                	add	sp,sp,32
    14f6:	8082                	ret
            rcureadunlock();
    14f8:	00000097          	auipc	ra,0x0
    14fc:	a1a080e7          	jalr	-1510(ra) # f12 <rcureadunlock>
            return current; // Node found
    1500:	8526                	mv	a0,s1
    1502:	b7ed                	j	14ec <search+0x2e>

0000000000001504 <updateNode>:

// Function to update the value of a node with a given key in the linked list
void updateNode(struct Node *head, int key, int new_data) {
    1504:	1101                	add	sp,sp,-32
    1506:	ec06                	sd	ra,24(sp)
    1508:	e822                	sd	s0,16(sp)
    150a:	e426                	sd	s1,8(sp)
    150c:	e04a                	sd	s2,0(sp)
    150e:	1000                	add	s0,sp,32
    1510:	892e                	mv	s2,a1
    1512:	84b2                	mv	s1,a2
    struct Node *nodeToUpdate = search(head, key);
    1514:	00000097          	auipc	ra,0x0
    1518:	faa080e7          	jalr	-86(ra) # 14be <search>

    if (nodeToUpdate != 0) {
    151c:	c901                	beqz	a0,152c <updateNode+0x28>
        nodeToUpdate->data = new_data; // Update the node's data
    151e:	c104                	sw	s1,0(a0)
    } else {
        printf("Node with key %d not found.\n", key);
    }
}
    1520:	60e2                	ld	ra,24(sp)
    1522:	6442                	ld	s0,16(sp)
    1524:	64a2                	ld	s1,8(sp)
    1526:	6902                	ld	s2,0(sp)
    1528:	6105                	add	sp,sp,32
    152a:	8082                	ret
        printf("Node with key %d not found.\n", key);
    152c:	85ca                	mv	a1,s2
    152e:	00000517          	auipc	a0,0x0
    1532:	3d250513          	add	a0,a0,978 # 1900 <digits+0x18>
    1536:	00000097          	auipc	ra,0x0
    153a:	cec080e7          	jalr	-788(ra) # 1222 <printf>
}
    153e:	b7cd                	j	1520 <updateNode+0x1c>
