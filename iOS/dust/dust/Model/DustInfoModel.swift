//
//  DustInfoModel.swift
//  dust
//
//  Created by 신한섭 on 2020/03/31.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct DustInfoModel {
    var numeric: Int
    var percentage: Double
    
    init(numeric: Int) {
        self.numeric = numeric
        self.percentage = (Double(numeric) > 200.0 ? 200.0 : Double(numeric)) / 200
    }
}
