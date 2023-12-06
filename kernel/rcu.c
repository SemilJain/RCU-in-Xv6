#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "spinlock.h"
#include "proc.h"

void rcu_read_unlock() {
    pop_off();
}

void rcu_read_lock()
{
    push_off();
}

void synchronize_rcu() {
    int i = 0;
    struct proc *p = myproc();
    // how to identify number of CPUs running ?
    while (i < 3) {
        p->cpu_affinity =  i++;
        yield();
    }
    p->cpu_affinity = -1;
}
