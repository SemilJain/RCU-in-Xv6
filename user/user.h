struct stat;
struct spinlock_u {
  uint locked; // 0 if not locked, 1 if locked
};
// struct thread_mutex {
//   uint locked; // 0 = unlocked, 1 = locked
//   // struct thread_queue *queue; // queue of sleeping threads
// };

// system calls
int fork(void);
int exit(int) __attribute__((noreturn));
int wait(int*);
int pipe(int*);
int write(int, const void*, int);
int read(int, void*, int);
int close(int);
int kill(int);
int exec(const char*, char**);
int open(const char*, int);
int mknod(const char*, short, short);
int unlink(const char*);
int fstat(int fd, struct stat*);
int link(const char*, const char*);
int mkdir(const char*);
int chdir(const char*);
int dup(int);
int getpid(void);
char* sbrk(int);
int sleep(int);
int uptime(void);
int rcureadlock(void);
int rcureadunlock(void);
int rcusync(void);
int thread_create(void(*fcn)(void*), void *arg, void*stack);
int thread_join(void);
int thread_exit(int);
int klist_insert(int,int);
int klist_delete(int,int);
int klist_query(int,int);
int klist_print(void);

// ulib.c
int stat(const char*, struct stat*);
char* strcpy(char*, const char*);
void *memmove(void*, const void*, int);
char* strchr(const char*, char c);
int strcmp(const char*, const char*);
void fprintf(int, const char*, ...);
void printf(const char*, ...);
char* gets(char*, int max);
uint strlen(const char*);
void* memset(void*, int, uint);
void* malloc(uint);
void free(void*);
int atoi(const char*);
int memcmp(const void *, const void *, uint);
void *memcpy(void *, const void *, uint);
void initlock(struct spinlock_u *);
void acquire(struct spinlock_u *);
void release(struct spinlock_u *);
