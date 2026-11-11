import java.util.*;
public class ClaimGraph {
    static ArrayList<ArrayList<Integer>> graph = new ArrayList<>();
    static void addEdge(int u, int v) {
        graph.get(u).add(v);
    }
    static void bfs(int start, int end) {
        boolean[] visited = new boolean[4];
        int[] parent = new int[4];
        Arrays.fill(parent, -1);
        Queue<Integer> queue = new LinkedList<>();
        queue.add(start);
        visited[start] = true;
        while (!queue.isEmpty()) {
            int current = queue.poll();
            for (int next : graph.get(current)) {
                if (!visited[next]) {
                    visited[next] = true;
                    parent[next] = current;
                    queue.add(next);
                }
            }
        }
        if (!visited[end]) {
            System.out.println("No path found");
            return;
        }
        ArrayList<Integer> path = new ArrayList<>();
        for (int i = end; i != -1; i = parent[i]) {
            path.add(i);
        }
        Collections.reverse(path);
        System.out.println("Shortest Path: " + path);
    }
    static boolean dfs(int node, boolean[] visited, boolean[] path) {
        visited[node] = true;
        path[node] = true;
        for (int next : graph.get(node)) {
            if (!visited[next]) {
                if (dfs(next, visited, path)) {
                    return true;
                }
            } else if (path[next]) {
                return true;
            }
        }
        path[node] = false;
        return false;
    }
    public static void main(String[] args) {
        for (int i = 0; i < 4; i++) {
            graph.add(new ArrayList<>());
        }
        addEdge(0, 1);
        addEdge(1, 2);
        addEdge(2, 3);
        addEdge(3, 1);
        String[] stages = {
                "Registration",
                "Assessment",
                "Surveyor",
                "Settlement"
        };
        System.out.println("Approval Stages:");
        for (int i = 0; i < stages.length; i++) {
            System.out.println(i + " - " + stages[i]);
        }
        bfs(0, 3);
        boolean[] visited = new boolean[4];
        boolean[] path = new boolean[4];
        boolean cycle = false;
        for (int i = 0; i < 4; i++) {
            if (!visited[i]) {
                if (dfs(i, visited, path)) {
                    cycle = true;
                    break;
                }
            }
        }
        System.out.println("Cycle Detected: " + cycle);
    }
}
