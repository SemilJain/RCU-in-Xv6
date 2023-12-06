struct Node {
    int data;
    struct Node *next;
};

void init_lock();
void init_list();
void insert(int);
void deleteNode(int);
struct Node* search(int);
void updateNode(int, int);
void printList(void);
