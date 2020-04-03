//
//  DustInfoModel.swift
//  dust
//
//  Created by 신한섭 on 2020/03/31.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct DustInfoModels: Codable {
    
    private(set) var models: [DustInfoModel]
    
    enum CodingKeys: String, CodingKey {
        case models = "result"
    }
}

struct DustInfoModel: Codable {

    private(set) var numeric: Int
    private(set) var grade: Int
    private(set) var time: Date
    
    enum CodingKeys: String, CodingKey {
        case numeric = "pm10Value"
        case grade = "pm10Grade1h"
        case time = "dataTime"
    }
    
    init() {
        numeric = 0
        grade = 0
        time = Date()
    }
}
