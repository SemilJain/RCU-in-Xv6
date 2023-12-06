struct Node {
    int data;
    struct Node *next;
};

void init_lock();
void insert(struct Node **, int);
void deleteNode(struct Node **, int);
struct Node* search(struct Node *, int);
void updateNode(struct Node *, int, int);
