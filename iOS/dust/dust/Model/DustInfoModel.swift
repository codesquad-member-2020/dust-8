//
//  DustInfoModel.swift
//  dust
//
//  Created by 신한섭 on 2020/03/31.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct DustInfoModels: Codable {
    
    var models: [DustInfoModel]
    
    enum CodingKeys: String, CodingKey {
        case models = "result"
    }
}

struct DustInfoModel: Codable {

    var numeric: Int
    var grade: Int
    var time: Date
    
    enum CodingKeys: String, CodingKey {
        case numeric = "pm10Value"
        case grade = "pm10Grade1h"
        case time = "dataTime"
    }
}
