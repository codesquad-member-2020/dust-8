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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(receiveDustInfo(_:)),
                                               name: .receiveDustInfoFinished,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func index(of index: Int) -> DustInfoModel{
        return model[index]
    }
    
    @objc func receiveDustInfo(_ notification: Notification) {
        guard let model = notification.userInfo?["model"] as? [DustInfoModel] else {return}
        self.model = model
        NotificationCenter.default.post(name: .setupDustModelComplete,
                                        object: nil)
    }
}

extension Notification.Name {
    static let setupDustModelComplete = Notification.Name("setupDustModelComplete")
}
