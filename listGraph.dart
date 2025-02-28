import 'dart:math';
import 'dart:io'; // Import for stdin

class Graph {
  final int V;
  List<List<int>> adj;

  Graph(this.V) : adj = List.generate(V, (_) => []);

  // Method to add an edge to the graph
  void addEdge(int u, int v) {
    adj[u].add(v); // Directed graph
  }

  // Method to generate a random simple directed graph
  void generateRandomGraph(int E) {
    var rng = Random();
    for (int i = 0; i < E; ++i) {
      int u = rng.nextInt(V);
      int v = rng.nextInt(V);
      if (u != v && !adj[u].contains(v)) {
        addEdge(u, v);
      }
    }
  }

  // Method to print the adjacency list representation of the graph
  void printGraph() {
    for (int i = 0; i < V; ++i) {
      stdout.write('$i: ');
      for (int j in adj[i]) {
        stdout.write('$j ');
      }
      print('');
    }
  }

  // Method for DFS algorithm
  void DFS(int v, List<bool> visited) {
    visited[v] = true;
    stdout.write('$v ');

    for (int neighbor in adj[v]) {
      if (!visited[neighbor]) {
        DFS(neighbor, visited);
      }
    }
  }

  // Method to check if the graph is strongly connected
  bool isStronglyConnected() {
    List<bool> visited = List.filled(V, false);
    DFS(0, visited);

    for (bool v in visited) {
      if (!v) return false;
    }

    Graph transposed = getTranspose();
    visited = List.filled(V, false);
    transposed.DFS(0, visited);

    for (bool v in visited) {
      if (!v) return false;
    }

    return true;
  }

  // Method to get the transpose of the graph
  Graph getTranspose() {
    Graph g = Graph(V);
    for (int v = 0; v < V; v++) {
      for (int neighbor in adj[v]) {
        g.addEdge(neighbor, v);
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
      dfsNumbers[v] = count++;
      for (int neighbor in adj[v]) {
        if (!visited[neighbor]) {
          DFSNum(neighbor);
        }
      }
    }

    DFSNum(0);

    print('DFS Numbers:');
    for (int i = 0; i < V; ++i) {
      print('Vertex $i: ${dfsNumbers[i]}');
    }
  }
}

void main() {
  print('Enter the number of vertices (V):');
  int V = int.parse(stdin.readLineSync()!);

  print('Enter the number of edges (E):');
  int E = int.parse(stdin.readLineSync()!);

  Graph g = Graph(V);

  // Generate a random simple directed graph
  g.generateRandomGraph(E);

  // Print the graph
  print('Adjacency List of the graph:');
  g.printGraph();

  // Apply DFS
  print('\nDFS traversal starting from vertex 0:');
  List<bool> visited = List.filled(V, false);
  g.DFS(0, visited);

  // Check if the graph is strongly connected
  print('\nIs the graph strongly connected? ${g.isStronglyConnected()}');

  // Check DFS numbers for every vertex
  g.checkDFSNumbers();
}
/*
 كرم سمير دريباتي 
عيسى اكرم زوباري 
هزار سمير سعيد 
شمس غسان خريما 
رادا فوائد شعبان 
*/