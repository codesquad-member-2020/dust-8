//
//  PlayButton.swift
//  dust
//
//  Created by 신한섭 on 2020/04/01.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class PlayButton: UIButton {
    
    private var playFlag: Bool {
        didSet {
            setImageToPlay(flag: playFlag)
        }
    }
    
    override init(frame: CGRect) {
        self.playFlag = false
        super.init(frame: frame)
        self.addTarget(self,
                       action: #selector(convertFlag),
                       for: .touchDown)
        setBorder(width: 1, color: .black)
    }
    
    required init?(coder: NSCoder) {
        self.playFlag = false
        super.init(coder: coder)
        self.addTarget(self,
                       action: #selector(convertFlag),
                       for: .touchDown)
        setBorder(width: 1, color: .black)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setFlagFalse),
                                               name: .setButtonImagePlay,
                                               object: nil)
    }
    
    private func setBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    @objc func convertFlag() {
        NotificationCenter.default.post(name: .playButtonPushed,
                                        object: nil,
                                        userInfo: ["buttonFlag": playFlag])
        
        playFlag = !playFlag
    }
    
    func setImageToPlay(flag: Bool) {
        DispatchQueue.main.async {
            if self.playFlag {
                self.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            } else {
                self.setImage(UIImage(systemName: "play.fill"), for: .normal)
            }
        }
    }
    
    @objc func setFlagFalse() {
        playFlag = false
    }
}

extension Notification.Name {
    static let playButtonPushed = Notification.Name("playButtonPushed")
}
