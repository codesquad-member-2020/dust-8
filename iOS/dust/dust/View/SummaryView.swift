//
//  SummaryView.swift
//  dust
//
//  Created by 신한섭 on 2020/03/31.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class SummaryView: UIView {
    
    enum State: String {
        case Good
        case Normal
        case Bad
        case Terrible
    }
    
    private var gradientLayer: CAGradientLayer
    private var state: State {
        didSet {
            setGradientColor(state: state)
        }
    }
    
    override init(frame: CGRect) {
        self.gradientLayer = CAGradientLayer()
        self.state = .Normal
        super.init(frame: frame)
        self.gradientLayer.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        self.gradientLayer = CAGradientLayer()
        self.state = .Normal
        super.init(coder: coder)
        self.gradientLayer.frame = self.bounds
    }
    
    func setGradientColor(state: State) {
        DispatchQueue.main.async {
            self.gradientLayer.colors = [UIColor(named: state.rawValue)?.cgColor ?? UIColor.white.cgColor, UIColor.white.cgColor]
            self.layer.insertSublayer(self.gradientLayer, at: 0)
        }
    }
}
