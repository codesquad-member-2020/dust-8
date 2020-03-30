//
//  SummaryView.swift
//  dust
//
//  Created by 신한섭 on 2020/03/31.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class SummaryView: UIView {
    var gradientLayer: CAGradientLayer
    
    override init(frame: CGRect) {
        self.gradientLayer = CAGradientLayer()
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        self.gradientLayer = CAGradientLayer()
        super.init(coder: coder)
    }
}
