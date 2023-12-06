#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"
#include "klinkedlist.h"

uint64
sys_exit(void)
{
  int n;
  argint(0, &n);
  exit(n);
  return 0;  // not reached
}

uint64
sys_getpid(void)
{
  return myproc()->pid;
}

uint64
sys_fork(void)
{
  return fork();
}

uint64
sys_wait(void)
{
  uint64 p;
  argaddr(0, &p);
  return wait(p);
}

uint64
sys_sbrk(void)
{
  uint64 addr;
  int n;

  argint(0, &n);
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

uint64
sys_sleep(void)
{
  int n;
  uint ticks0;

  argint(0, &n);
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

uint64
sys_kill(void)
{
  int pid;

  argint(0, &pid);
  return kill(pid);
}

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

uint64
sys_rcureadlock(void)
{
  // rcu_read_lock();
  push_off();
  return 1;
}

uint64
sys_rcureadunlock(void)
{
  // rcu_read_unlock();
  pop_off();
  return 1;
}

uint64
sys_rcusync(void)
{
  // synchronize_rcu();
  int i = 0;
    struct proc *p = myproc();
    // how to identify number of CPUs running ?
    while (i < 2) {
        p->cpu_affinity =  i++;
        yield();
    }
   p->cpu_affinity = -1;
    printf ("\n RCU sync done!");
  return 1;
}

uint64
sys_thread_create(void)
{
  void (*fcn)(void *);
  void *arg; //char?
  void *user_stack; //char?

  argaddr(0, (uint64 *)&fcn);
  argaddr(1, (uint64 *)&arg);
  argaddr(2, (uint64 *)&user_stack);
  return thread_create(fcn,arg,user_stack);
}

uint64
sys_thread_join(void)
{
  return thread_join();
}

uint64
sys_thread_exit(void)
{
  int n;
  argint(0, &n);
  return thread_exit(n);
}

uint64
sys_klist_insert(void)
{
  int n, is_rcu;
  argint(0, &n);
  argint(1, &is_rcu);
  if (is_rcu)
  {
    init_list();
  } else{
    init_list_lock();
  }
  
  for (int i = 1; i <= n; i++)
  {
    if (is_rcu)
    {
      insert(i);
    } else{
      insert_lock(i);
    }
    
  }
  printf("Total free pages %d\n",get_total_free_pages());
  return 1;
}

uint64
sys_klist_delete(void)
{
  int n, is_rcu;
  argint(0, &n);
  argint(1, &is_rcu);
  if (is_rcu)
    {
      deleteNode(n);
    } else{
      deleteNode_lock(n);
    }
  
  return 1;
}

uint64
sys_klist_query(void)
{
  int n, is_rcu;
  argint(0, &n);
  argint(1, &is_rcu);
  struct Node * res;
  if (is_rcu)
    {
      res = search(n);
    } else{
      res = search_lock(n);
    }
    if (res!=0)
    {
      printf("present\n");    
    }

  return 1;
}

uint64
sys_klist_print(void)
{
    printList(); 
  return 1;
}