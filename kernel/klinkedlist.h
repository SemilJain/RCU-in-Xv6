#include "rwlock.h"
struct Node {
    int data;
    struct Node *next;
    struct ReaderWriterLock * lock;
};

void init_lock();
void init_list();
void insert(int);
void deleteNode(int);
struct Node* search(int);
void init_list_lock();
void insert_lock(int);
void deleteNode_lock(int);
struct Node* search_lock(int);
void updateNode(int, int);
void printList(void);
