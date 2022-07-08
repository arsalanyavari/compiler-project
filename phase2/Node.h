#include <iostream>
#include <vector>
using namespace std;


class Node{
    public:
        int h;
        char *name;
        char *data;
        // Node *parent;
        vector<Node *> children;

        Node()
        {
        }

        void add_child(Node *child)
        { 
            children.push_back(child); 
        }

};