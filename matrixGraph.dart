import 'dart:math';
import 'dart:io'; // Import for stdin

class Graph {
  final int V;
  List<List<int>> adj;

  Graph(this.V)
      : adj = List.generate(V, (_) => List.filled(V, 0)); // تهيئة المصفوفة

  // Method to add an edge to the graph
  void addEdge(int u, int v) {
    adj[u][v] = 1; // Directed graph
  }

  // Method to generate a random simple directed graph
  void generateRandomGraph(int E) {
    var rng = Random(); //توليد تابع عشوائي
    for (int i = 0; i < E; ++i) {
      int u = rng.nextInt(V);
      int v = rng.nextInt(V);
      if (u != v) {
        addEdge(u, v);
      }
    }
  }

  // طباعة مصفوفة البيان الثنائية
  void printGraph() {
    for (int i = 0; i < V; ++i) {
      for (int j = 0; j < V; ++j) {
        print ('${adj[i][j]} ');
      }
      print('');
    }
  }

  // Method for DFS algorithm
  void DFS(int v, List<bool> visited) {
    visited[v] = true;
    print('$v ');

    for (int i = 0; i < V; ++i) {
      if (adj[v][i] == 1 && !visited[i]) {
        DFS(i, visited);
      }
    }
  }

  // Method to check isStronglyConnected Graph
  bool isStronglyConnected() {
    List<bool> visited = List.filled(V, false); // تهيئة 
    DFS(0, visited);

    for (bool v in visited) {
      if (!v) return false;
    }

    Graph myGraph = getMyGraph();
    visited = List.filled(V, false);
    myGraph.DFS(0, visited);

    for (bool v in visited) {
      if (!v) return false;
    }

    return true;
  }

  // Method to get the MyGraph
  Graph getMyGraph() {
    Graph g = Graph(V);
    for (int i = 0; i < V; i++) {
      for (int j = 0; j < V; j++) {
        if (adj[i][j] == 1) {
          g.addEdge(j, i);
        }
      }
    }
    return g;
  }

  // Method to check DFS number for every vertex
  void checkDFSNumbers() {
    List<int> dfsNumbers = List.filled(V, -1);
    List<bool> visited = List.filled(V, false);
    int count = 0;

    void DFSNum(int v) {
      visited[v] = true;
      dfsNumbers[v] = ++count;
      for (int i = 0; i < V; ++i) {
        if (adj[v][i] == 1 && !visited[i]) {
          DFSNum(i);
        }
      }
    }

    DFSNum(0);// البدء باول عقدة 

    print('DFS Numbers:');
    for (int i = 0; i < V; ++i) {
      print('Vertex $i: ${dfsNumbers[i]}');
    }
  }
}

void main() {
  print('Enter the number of vertices (V):');
  int V = int.parse(stdin.readLineSync()!);

  print('\nEnter the number of edges (E):');
  int E = int.parse(stdin.readLineSync()!);

  Graph MyGrahp = Graph(V);

  // Generate a random simple directed graph
  MyGrahp.generateRandomGraph(E);

  // Print the graph
  print('Adjacency Matrix of the graph:');
  MyGrahp.printGraph();

  // Apply DFS
  print('\nDFS traversal starting from vertex 0:');
  List<bool> visited = List.filled(V, false);
  MyGrahp.DFS(0, visited);

  // Check if the graph is strongly connected
  print('\nIs the graph strongly connected? ${MyGrahp.isStronglyConnected()}');

  // Check DFS numbers for every vertex
  MyGrahp.checkDFSNumbers();
}
/* 
حيان وائل حسن 
ليال جورج الياس 
سلسبيل برهان الشيخ يوسف 
رهف سامر اسماعيل 
ندى مازن زريق 
*/