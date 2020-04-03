//
//  SummaryView.swift
//  dust
//
//  Created by 신한섭 on 2020/03/31.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class GradationView: UIView {
    
    private var gradientLayer: CAGradientLayer
    
    override init(frame: CGRect) {
        self.gradientLayer = CAGradientLayer()
        super.init(frame: frame)
        self.gradientLayer.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        self.gradientLayer = CAGradientLayer()
        super.init(coder: coder)
        self.gradientLayer.frame = self.bounds
    }
    
    func setGradientColor(grade: Int) {
        DispatchQueue.main.async {
            self.gradientLayer.colors = [UIColor(named: DustGrade.Grade(index: grade).rawValue)?.cgColor ?? UIColor.white.cgColor, UIColor.white.cgColor]
            self.layer.insertSublayer(self.gradientLayer, at: 0)
        }
    }
}
