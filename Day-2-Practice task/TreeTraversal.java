import java.util.Scanner;

class TreeNode {
    int data;
    TreeNode left, right;

    TreeNode(int value) {
        data = value;
        left = null;
        right = null;
    }
}

class BST {
    TreeNode root = null;

    void insert(int value) {
        TreeNode newNode = new TreeNode(value);
        if (root == null) {
            root = newNode;
            return;
        }

        TreeNode temp = root;
        while (true) {
            if (value < temp.data) {
                if (temp.left == null) {
                    temp.left = newNode;
                    break;
                }
                temp = temp.left;
            } else {
                if (temp.right == null) {
                    temp.right = newNode;
                    break;
                }
                temp = temp.right;
            }
        }
    }

    void inorder(TreeNode temp) {
        if (temp == null) return;
        inorder(temp.left);
        System.out.print(temp.data + " ");
        inorder(temp.right);
    }

    void preorder(TreeNode temp) {
        if (temp == null) return;
        System.out.print(temp.data + " ");
        preorder(temp.left);
        preorder(temp.right);
    }

    void postorder(TreeNode temp) {
        if (temp == null) return;
        postorder(temp.left);
        postorder(temp.right);
        System.out.print(temp.data + " ");
    }
}

public class TreeTraversal {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        BST tree = new BST();
        int choice, value;

        do {
            System.out.println("\n===== BINARY SEARCH TREE =====");
            System.out.println("1. Insert");
            System.out.println("2. Inorder");
            System.out.println("3. Preorder");
            System.out.println("4. Postorder");
            System.out.println("5. Exit");
            System.out.print("Enter choice: ");
            choice = sc.nextInt();

            switch (choice) {
                case 1:
                    System.out.print("Enter value: ");
                    value = sc.nextInt();
                    tree.insert(value);
                    break;
                case 2:
                    System.out.print("Inorder: ");
                    tree.inorder(tree.root);
                    System.out.println();
                    break;
                case 3:
                    System.out.print("Preorder: ");
                    tree.preorder(tree.root);
                    System.out.println();
                    break;
                case 4:
                    System.out.print("Postorder: ");
                    tree.postorder(tree.root);
                    System.out.println();
                    break;
                case 5: System.out.println("Exit"); break;
                default: System.out.println("Invalid choice.");
            }
        } while (choice != 5);
        sc.close();
    }
}
