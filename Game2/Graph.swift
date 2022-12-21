//
//  Graph.swift
//  Game2
//
//  Created by Семен Безгин on 19.12.2022.
//

import Foundation

struct Vertex: Hashable {
    let name: String
    let housing: String
    
    let x: Double
    let y: Double
    
    let x0: Double
    let y0: Double
}

class Graph {
    private var countVertex: Int {
        return listVertex.count
    }
    private var listVertex: [Vertex]
    private var dictEdges: [Vertex:[Vertex]]
    
    init() {
        self.listVertex = []
        self.dictEdges = [:]
    }
    
    public func setTestGraph() {
        let arr = [
            Vertex(name: "1", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8),
            Vertex(name: "2", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8),
            Vertex(name: "3", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8),
            Vertex(name: "4", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8),
            Vertex(name: "5", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8),
            Vertex(name: "6", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8),
            Vertex(name: "7", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8),
            Vertex(name: "8", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8),
            Vertex(name: "9", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8),
            Vertex(name: "10", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8),
            Vertex(name: "11", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8)
        ]

        for x in arr {
            self.appendVertex(x)
        }
        
        self.appendEdges(Vertex(name: "1", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8), with: [Vertex(name: "2", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8), Vertex(name: "3", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8)])
        self.appendEdges(Vertex(name: "2", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8), with: [Vertex(name: "4", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8), Vertex(name: "5", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8)])
        self.appendEdges(Vertex(name: "3", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8), with: [Vertex(name: "6", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8), Vertex(name: "5", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8)])
        self.appendEdges(Vertex(name: "4", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8), with: [Vertex(name: "7", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8)])
        self.appendEdges(Vertex(name: "5", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8), with: [Vertex(name: "7", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8), Vertex(name: "8", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8)])
        self.appendEdges(Vertex(name: "6", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8), with: [Vertex(name: "9", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8), Vertex(name: "10", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8)])
        self.appendEdges(Vertex(name: "8", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8), with: [Vertex(name: "11", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8)])
        self.appendEdges(Vertex(name: "9", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8), with: [Vertex(name: "11", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8)])
    }
    
    public func appendVertex(_ vertex: Vertex) {
        if !self.listVertex.contains(vertex) {
            self.listVertex.append(vertex)
            self.dictEdges[vertex] = []
        } else {
            print("Повтор \(vertex)")
        }
    }
    
    public func appendEdges(_ vertex: Vertex, with edges: [Vertex], mutually: Bool = false) {
        if self.listVertex.contains(vertex) {
            for x in edges {
                if self.dictEdges[vertex] != nil {
                    if mutually {
                        self.dictEdges[x]!.append(vertex)
                    }
                    self.dictEdges[vertex]!.append(x)
                } else {
                    print("Попытка связать с несуществующей вершиной \(x)")
                }
            }
        } else {
            print("Вершины не существует \(vertex)")
        }
    }
    
    public func showVertex() {
        for x in listVertex {
            print(x)
        }
    }
    
    public func showEdges() {
        for x in dictEdges.keys {
            print("\(x) -> \(self.dictEdges[x]!)")
        }
    }
    
    public func findVertexByName(_ name: String) -> [Vertex] {
        var result: [Vertex] = []
        
        for x in listVertex {
            if x.name == name {
                result.append(x)
            }
        }
        
        return result
    }
    
    public func bfs(_ currentVertex: Vertex, to targetVertex: Vertex) -> [Vertex] {
        var queue: [Vertex] = [currentVertex]
        var result: [Vertex] = []
        var isFounded: Bool = false
        var visited: [Vertex : Vertex?] = [
            currentVertex : nil
        ]
        
        while queue != [] && !isFounded {
            let vertex = queue[0]
            queue.removeFirst()
            
            if self.dictEdges[vertex] != nil {
                for x in self.dictEdges[vertex]! {
                    if visited.keys.contains(x) == false {
                        visited[x] = vertex
                        queue.append(x)
                        
                        if x == targetVertex {
                            var v = targetVertex
                            result = [v]
                            
                            while visited[v]! != nil {
                                result.append(visited[v]!!)
                                v = visited[v]!!
                            }
                            
                            isFounded = true
                            break
                        }
                    }
                }
            }
        }
        
        return result.reversed()
    }
}
//
//let graph = Graph()
//graph.setTestGraph()
//
//for i in graph.bfs(Vertex(name: "1", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8), to: Vertex(name: "9", housing: "B1", x: 1.2, y: 3.4, x0: 5.6, y0: 7.8)) {
//    print(i.name)
//}
//
//print(graph.findVertexByName("1"))
//
////graph.showVertex()
////graph.showEdges()
