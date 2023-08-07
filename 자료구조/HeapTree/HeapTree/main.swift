//
//  main.swift
//  HeapTree
//
//  Created by 이현호 on 2023/08/02.
//

import Foundation

var heap: Heap<Int> = Heap(data: 10)
heap.insert(data: 100)
heap.insert(data: 3)
heap.insert(data: 5)

print(heap.heap)

print("pop = \(heap.pop())")
print("pop = \(heap.pop())")
print("pop = \(heap.pop())")
print("pop = \(heap.pop())")

/*
 pop = 100
 pop = 10
 pop = 3
 pop = 5
 */




