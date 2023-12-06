#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "riscv.h"
#include "spinlock.h"
#include "proc.h"
#include "defs.h"
#include "klinkedlist.h"
// #include "rwlock.h"
// Define a node structure for the linked list
struct spinlock list_lock;
struct Node *head_ref;

void init_lock(){
    initlock(&list_lock, "list_lock");
}

void init_list_lock(){
    head_ref = (struct Node *) kalloc();
    head_ref->lock = (struct ReaderWriterLock *) kalloc();
    rw_lock_init(head_ref->lock);
    head_ref->data = 0;
    head_ref->next = 0;
}

void init_list(){
    head_ref = (struct Node *) kalloc();
    head_ref->data = 0;
    head_ref->next = 0;
}

void insert_lock(int new_data) {
    struct Node *new_node = (struct Node *) kalloc();
    new_node->lock = (struct ReaderWriterLock *) kalloc();
    rw_lock_init(new_node->lock);
    new_node->data = new_data;
    write_lock(head_ref->lock);
    new_node->next = head_ref;
    head_ref = new_node;
    write_unlock(head_ref->next->lock);
}


// Function to insert a node at the beginning of the linked list
void insert(int new_data) {
    struct Node *new_node = (struct Node *) kalloc();
    new_node->data = new_data;
    acquire(&list_lock);
    new_node->next = head_ref;
    release(&list_lock);
    synchronize_rcu();
    head_ref = new_node;
}

void deleteNode_lock(int key) {
    struct Node *temp = head_ref, *prev = 0;

    write_lock(temp->lock);
    if (temp != 0 && temp->data == key) {
        head_ref = temp->next;
        write_unlock(temp->lock);
        // kfree(temp->lock);
        // kfree(temp);
        return;
    }
    
    while (temp != 0) {
        if (temp->data != key) {
            if (temp->next != 0) {
                write_lock(temp->next->lock);
                write_unlock(temp->lock);
                prev = temp;
                temp = temp->next;
            } else {
                write_unlock(temp->lock);
                break;
            }
        } else {
            break;
        }
    }

    if (temp == 0) {
        if (prev != 0) {
            write_unlock(prev->lock);
        }
        return;
    }

    prev->next = temp->next;
    write_unlock(prev->lock);
    write_unlock(temp->lock);
    // kfree(temp->lock);
    // kfree(temp);
}

// Function to delete a node with a given key from the linked list
void deleteNode(int key) {
    struct Node *temp = head_ref, *prev = 0;
    acquire(&list_lock);
    if (temp != 0 && temp->data == key) {
        head_ref = temp->next;
        release(&list_lock);
        synchronize_rcu();
        kfree(temp);
        return;
    }

    while (temp != 0 && temp->data != key) {
        prev = temp;
        temp = temp->next;
    }

    if (temp == 0) {
        release(&list_lock);
        return;
    }
    prev->next = temp->next;
    release(&list_lock);
    synchronize_rcu();
    kfree(temp);
}

// Function to search for a node with a given key in the linked list
struct Node* search(int key) {

    struct Node *current = head_ref;
    rcu_read_lock();
    while (current != 0) {
        if (current->data == key) {
            rcu_read_unlock();
            return current; // Node found
        }
        current = current->next;
    }
    rcu_read_unlock();
    return 0; // Node not found
}

struct Node* search_lock(int key) {
    int cpuid = r_tp();
    struct Node *current = head_ref;
    while (current != 0) {
        read_lock(current->lock,cpuid);
        if (current->data == key) {
            read_unlock(current->lock,cpuid);
            return current; // Node found
        }
        read_unlock(current->lock,cpuid);
        current = current->next;
    }
    return 0; // Node not found
}


// Function to update the value of a node with a given key in the linked list
void updateNode(int key, int new_data) {
    struct Node *nodeToUpdate = search(key);

    if (nodeToUpdate != 0) {
        nodeToUpdate->data = new_data; // Update the node's data
    } else {
        printf("Node with key %d not found.\n", key);
    }
}

void printList() {
    printf("Final Linked List: ");
    struct Node *temp = head_ref;
    while (temp != 0) {
        printf("%d -> ", temp->data);
        temp = temp->next;
    }
    printf("NULL\n");
}
