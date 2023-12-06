#include "kernel/types.h"
#include "kernel/stat.h"
#include "linkedlist.h"
#include "user/user.h"

#define INSERT_COUNT 1000
#define QUERY_COUNT 300
#define DELETE_COUNT 200
#define IS_RCU 0
#define READTHREADS 1
#define DELETETHREADS 1


void rcu_test() {

    
    klist_insert(INSERT_COUNT, IS_RCU);
    klist_print();
    int pid = fork();
    if (pid == 0)
    {   
        for (int i = 1; i <= QUERY_COUNT; i++)
        {
            klist_query(i,IS_RCU);
            if (i%10)
            {
                sleep(1);
            }
            
        }        
        exit(0);
    }else{
        for (int i = 1; i <= DELETE_COUNT; i++)
        {
           klist_delete(i,IS_RCU);
           if(i%12){
                sleep(1);
            }   
        }
    }
    wait((int *)0);
    klist_print();
}

int main() {
    int start = uptime();
    rcu_test();
    int end = uptime();

    fprintf(1,"Total time: %d\n", end - start);
    exit(0);
}