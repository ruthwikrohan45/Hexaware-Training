class Node {
    int data;
    Node left, right;
    Node(int value) {
        data = value;
    }
}
public class ClaimBST {
    Node root;
    Node insert(Node root, int value) {
        if (root == null) {
            return new Node(value);
        }
        if (value < root.data) {
            root.left = insert(root.left, value);
        } else if (value > root.data) {
            root.right = insert(root.right, value);
        }
        return root;
    }
    boolean search(Node root, int value) {
        if (root == null) {
            return false;
        }
        if (root.data == value) {
            return true;
        }
        if (value < root.data) {
            return search(root.left, value);
        }
        return search(root.right, value);
    }

    void inorder(Node root) {
        if (root != null) {
            inorder(root.left);
            System.out.print(root.data + " ");
            inorder(root.right);
        }
    }

    void preorder(Node root) {
        if (root != null) {
            System.out.print(root.data + " ");
            preorder(root.left);
            preorder(root.right);
        }
    }

    void postorder(Node root) {
        if (root != null) {
            postorder(root.left);
            postorder(root.right);
            System.out.print(root.data + " ");
        }
    }

    public static void main(String[] args) {
        ClaimBST tree = new ClaimBST();
        int[] ids = {
                105, 102, 108, 101, 104,
                107, 110, 103, 106, 109,
                112, 111, 115, 114, 113
        };
        for (int id : ids) {
            tree.root = tree.insert(tree.root, id);
        }
        System.out.println("Inorder:");
        tree.inorder(tree.root);
        System.out.println("\nPreorder:");
        tree.preorder(tree.root);
        System.out.println("\nPostorder:");
        tree.postorder(tree.root);
        System.out.println("\nSearch 108: " + tree.search(tree.root, 108));
    }
}
