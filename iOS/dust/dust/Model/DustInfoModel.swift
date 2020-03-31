//
//  DustInfoModel.swift
//  dust
//
//  Created by 신한섭 on 2020/03/31.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct DustInfoModel {
    
    enum Grade: String, CaseIterable {
        case Good
        case Normal
        case Bad
        case Terrible
        
        init(index: Int) {
            self = Grade.allCases[index]
        }
    }
    
    var numeric: Int
    var percentage: Double
    var grade: Grade
    var station: String
    var time: String
    
    init(numeric: Int, station: String, time: String) {
        self.numeric = numeric
        self.percentage = (Double(numeric) > 200.0 ? 200.0 : Double(numeric)) / 200
        self.grade = Grade(index: Int(percentage * 100) / (100 / Grade.allCases.count) >= 4 ? 3 : Int(percentage * 100) / (100 / Grade.allCases.count))
        self.station = station
        self.time = String(time) + ":00"
    }
}
