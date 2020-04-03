//
//  ForecastModel.swift
//  dust
//
//  Created by 신한섭 on 2020/04/03.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct ForecastModel: Codable {
    let forecastInfo: ForecastInfo
    
    enum CodingKeys: String, CodingKey {
        case forecastInfo = "result"
    }
}

struct ForecastInfo: Codable {
    let imagesURL: [String]
    let gradeOfCities: String
    let forecastContent: String
    
    enum CodingKeys: String, CodingKey {
        case imagesURL = "images"
        case gradeOfCities
        case forecastContent = "forecaseContent"
    }
}
