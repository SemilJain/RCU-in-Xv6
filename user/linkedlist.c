#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "linkedlist.h"

// Define a node structure for the linked list
struct spinlock_u list_lock;

void init_lock(){
    initlock(&list_lock);
}

// Function to insert a node at the beginning of the linked list
void insert(struct Node **head_ref, int new_data) {
    struct Node *new_node = malloc(sizeof(struct Node));
    new_node->data = new_data;
    new_node->next = *head_ref;
    *head_ref = new_node;
}

// Function to delete a node with a given key from the linked list
void deleteNode(struct Node **head_ref, int key) {
    struct Node *temp = *head_ref, *prev = 0;

    acquire(&list_lock);
    if (temp != 0 && temp->data == key) {
        *head_ref = temp->next;
        release(&list_lock);
        rcusync();
        free(temp);
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
    rcusync();
    free(temp);
}

// Function to search for a node with a given key in the linked list
struct Node* search(struct Node *head, int key) {

    struct Node *current = head;
    rcureadlock();
    while (current != 0) {
        if (current->data == key) {
            rcureadunlock();
            return current; // Node found
        }
        current = current->next;
    }
    rcureadunlock();
    return 0; // Node not found
}

// Function to update the value of a node with a given key in the linked list
void updateNode(struct Node *head, int key, int new_data) {
    struct Node *nodeToUpdate = search(head, key);

    if (nodeToUpdate != 0) {
        nodeToUpdate->data = new_data; // Update the node's data
    } else {
        printf("Node with key %d not found.\n", key);
    }
}
