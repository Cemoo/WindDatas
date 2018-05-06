//
//  Processes.swift
//  WindDatasApp
//
//  Created by Erencan Evren on 30.04.2018.
//  Copyright © 2018 Cemal Bayrı. All rights reserved.
//

import Foundation

class Processes {
    static func getMod(_ arr: [Double]) -> Double {
        return (arr.reduce(0, {$0 + $1})) / Double(arr.count)
    }
    
    static func getMedian(_ array: [Double]) -> Float {
        let sorted = array.sorted()
        if sorted.count % 2 == 0 {
            return Float((sorted[(sorted.count / 2)] + sorted[(sorted.count / 2) - 1])) / 2
        } else {
            return Float(sorted[(sorted.count - 1) / 2])
        }
    }
    
    static func getstDev(_ arr: [Double]) -> Double {
        let length = Double(arr.count)
        let avg = arr.reduce(0, {$0 + $1}) / length
        let sumOfSquaredAvgDiff = arr.map { pow($0 - avg, 2.0)}.reduce(0, {$0 + $1})
        return sqrt(sumOfSquaredAvgDiff / length)
    }
    
    static func getMin(_ arr: [Double]) -> Double{
        return arr.min()!
    }
    
    static func getMax(_ arr: [Double]) -> Double{
        return arr.max()!
    }
}
