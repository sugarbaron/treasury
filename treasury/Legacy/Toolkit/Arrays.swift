//
//  Arrays.swift
//  treasury
//
//  Created by sugarbaron on 20.07.2021.
//

import Foundation

func +=<E>(array: inout Array<E>, _ element: E) { array.append(element) }

func enumerate<T>(_ array: Array<T>) -> [(index: Int, item: T)] { Array(zip(array.indices, array)) }

extension Array {
    
    var isNotEmpty: Bool { isEmpty == false }
    
}


