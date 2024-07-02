//
//  Graph.swift
//  Graph
//
//  Created by 이현호 on 2023/08/09.
//

import Foundation

struct AdjMatGraph{
    var verties: [String] = []
    var size = 10
    var adjMat: [[Int]] = Array(repeating: Array(repeating: 0, count: 10), count: 10)
    
    func getVertex(num: Int) -> String{
        return verties[num]
    }
    
    mutating func setVertex(vertex: String) {
        verties.append(vertex)
    }
    
    func getEdge(from: Int, to: Int) -> Int{
        return adjMat[from][to]
    }
    
    mutating func setEdge(from: Int, to: Int){
        adjMat[from][to] = 1
    }
    
}
