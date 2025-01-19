import 'dart:math';
import 'dart:io'; // Import for stdin

class Graph {
  final int V;
  List<int> adj; // Adjacency array to store edges
  List<int>
      adjecency; // Offset array to store start indices of each vertex's edges

  Graph(this.V)
      : adj = [],
        adjecency = List.filled(V + 1, 0);

  // Method to add an edge to the graph
  void addEdge(int u, int v) {
    adj.add(v); // Directed graph
  }

  // Method to generate a random simple directed graph
  void generateRandomGraph(int E) {
    var rng = Random();
    int edgeCount = 0;
    for (int i = 0; i < E; ++i) {
      int u = rng.nextInt(V);
      int v = rng.nextInt(V);
      if (u != v) {
        addEdge(u, v);
        edgeCount++;
      }
    }

    // Create the adjacency array
    List<int> degree = List.filled(V, 0);
    for (int i = 0; i < edgeCount; ++i) {
      degree[adj[i]]++;
    }
    adjecency[0] = 0;
    for (int i = 1; i <= V; ++i) {
      adjecency[i] = adjecency[i - 1] + degree[i - 1];
    }
  }

// طباعة مصفوفة البيان الاحادية
  void printGraph() {
    for (int i = 0; i < V; ++i) {
      stdout.write('$i: ');
      for (int j = adjecency[i]; j < adjecency[i + 1]; ++j) {
       print ('${adj[j]} ');
      }
      print('');
    }
  }

  // Method for DFS algorithm
  void DFS(int v, List<bool> visited) {
    visited[v] = true;
    print('$v ');

    for (int i = adjecency[v]; i < adjecency[v + 1]; ++i) {
      int neighbor = adj[i];
      if (!visited[neighbor]) {
        DFS(neighbor, visited);
      }
    }
  }

  // Method to check isStronglyConnected Graph
  bool isStronglyConnected() {
    List<bool> visited = List.filled(V, false);
    DFS(0, visited);

    for (bool v in visited) {
      if (!v) return false;
    }

    visited = List.filled(V, false);

    for (bool v in visited) {
      if (!v) return false;
    }

    return true;
  }

  // Method to check DFS number for every vertex
  void checkDFSNumbers() {
    List<int> dfsNumbers = List.filled(V, -1);
    List<bool> visited = List.filled(V, false);
    int count = 0;

    void DFSNum(int v) {
      visited[v] = true;
      dfsNumbers[v] = count++;
      for (int i = adjecency[v]; i < adjecency[v + 1]; ++i) {
        int neighbor = adj[i];
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
  print('Adjacency Array of the graph:');
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
/*اسماء من كتب الكود :
كرم سمير دريباتي 
عيسى اكرم زوباري 
هزار سمير سعيد 
شمس غسان خريما 
رادا فوائد شعبان 
 */
