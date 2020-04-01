//
//  DustInfoModelManager.swift
//  dust
//
//  Created by 신한섭 on 2020/03/31.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

class DustInfoModelManager {
    private(set) var model = [DustInfoModel]()
    public var count: Int {
        get {
            return model.count
        }
    }
    
    init() {
        for index in 0..<24 {
            model.append(DustInfoModel(numeric: Int.random(in: 0...200), station: "강남구", time: String(index)))
        }
    }
    
    func index(of index: Int) -> DustInfoModel{
        return model[index]
    }
}
