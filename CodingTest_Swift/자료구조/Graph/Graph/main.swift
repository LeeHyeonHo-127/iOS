//
//  main.swift
//  Graph
//
//  Created by 이현호 on 2023/08/09.
//

import Foundation

var graph: AdjMatGraph = AdjMatGraph()

graph.setVertex(vertex: "A")
graph.setVertex(vertex: "B")
graph.setVertex(vertex: "C")
graph.setVertex(vertex: "D")

graph.setEdge(from: 0, to: 1)
graph.setEdge(from: 0, to: 2)
graph.setEdge(from: 0, to: 3)
graph.setEdge(from: 1, to: 3)

for i in 0..<10{
    print(graph.adjMat[i])
}

/*
 [0, 1, 1, 1, 0, 0, 0, 0, 0, 0]
 [0, 0, 0, 1, 0, 0, 0, 0, 0, 0]
 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
 */
