#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

struct balance {
    char name[32];
    int amount;
};
// struct thread_spinlock* lock;
struct spinlock_u thread_lock;

// void init_lock(){
//     initlock(&thread_lock);
// }
volatile int total_balance = 0;
struct balance b1 = {"b1", 3200};
struct balance b2 = {"b2", 2800};
volatile unsigned int delay (unsigned int d) {
   unsigned int i; 
   for (i = 0; i < d; i++) {
       __asm volatile( "nop" ::: );
   }

   return i;   
}

void do_work(void *arg){
    int i; 
    int old;
    struct balance *b = (struct balance*) arg; 
    fprintf(1, "Starting do_work: s:%s\n", b->name);

    for (i = 0; i < b->amount; i++) { 
        //  thread_spin_lock(lock);
        // thread_mutex_lock(lock);
        acquire(&thread_lock);
         old = total_balance;
         delay(100000);
         total_balance = old + 1;
         release(&thread_lock);
        //  thread_spin_unlock(lock);
        // thread_mutex_unlock(lock);

    }
  
    fprintf(1, "Done s:%s\n", b->name);

    thread_exit(0);
    return;
}
void do_work2(){
    int i; 
    int old;
    // struct balance *b = b1; 
    fprintf(1, "Starting do_work: s:%s\n", b1.name);

    for (i = 0; i < b1.amount; i++) { 
        //  thread_spin_lock(lock);
        // thread_mutex_lock(lock);
        acquire(&thread_lock);
         old = total_balance;
         delay(100000);
         total_balance = old + 1;
         release(&thread_lock);
        //  thread_spin_unlock(lock);
        // thread_mutex_unlock(lock);
    }
  
    fprintf(1, "Done s:%s\n", b1.name);

    thread_exit(0);
    return;
}

int main(int argc, char *argv[]) {
//   thread_spin_init(lock);
initlock(&thread_lock);
  struct balance b1 = {"b1", 3200};
  struct balance b2 = {"b2", 2800};
 
  void *s1, *s2;
  int t1, t2, r1, r2;

  s1 = malloc(4096);
  s2 = malloc(4096);
  fprintf(1, "ustack addr %p\n", s1);
    fprintf(1,"in here");
  t1 = thread_create(do_work, (void*)&b1, s1);
  fprintf(1,"in here1");
  t2 = thread_create(do_work2, (void*)&b2, s2); 
  fprintf(1,"in here2");
  r1 = thread_join();
  r2 = thread_join();
  
  fprintf(1, "Threads finished: (%d):%d, (%d):%d, shared balance:%d\n", 
      t1, r1, t2, r2, total_balance);

  exit(0);
}
