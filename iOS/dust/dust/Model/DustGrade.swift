//
//  DustGrade.swift
//  dust
//
//  Created by 신한섭 on 2020/04/03.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

class DustGrade {
    enum Grade: String, CaseIterable {
        case Good = "좋음"
        case Normal = "보통"
        case Bad = "나쁨"
        case Terrible = "매우 나쁨"
        
        init(index: Int) {
            if index == 0 {
                self = Grade.allCases[index]
            } else {
                self = Grade.allCases[index - 1]
            }
        }
    }
}
