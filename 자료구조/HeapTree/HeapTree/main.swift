//
//  main.swift
//  HeapTree
//
//  Created by 이현호 on 2023/08/02.
//

import Foundation

var heap: Heap<Int> = Heap(data: 3)
heap.insert(data: 1)
heap.insert(data: 10)
heap.insert(data: 7)
heap.insert(data: 11)
heap.insert(data: 100)

print(heap.heap)

print("pop = \(heap.pop())")
print("pop = \(heap.pop())")
print("pop = \(heap.pop())")
print("pop = \(heap.pop())")
print("pop = \(heap.pop())")
print("pop = \(heap.pop())")
/*
 pop = 100
 pop = 11
 pop = 10
 pop = 7
 pop = 3
 pop = 1
 */




