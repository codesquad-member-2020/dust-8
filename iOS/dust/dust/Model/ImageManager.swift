//
//  ImageHandler.swift
//  dust
//
//  Created by 신한섭 on 2020/04/01.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class ImageManager {
    private var images: [UIImage]
    private let urlString = [
        "http://www.airkorea.or.kr/file/viewImage/?atch_id=138717",
        "http://www.airkorea.or.kr/file/viewImage/?atch_id=138718",
        "http://www.airkorea.or.kr/file/viewImage/?atch_id=138719"
    ]
    private var count = 0
    
    
    init() {
        self.images = [UIImage]()
    }
    
    func downloadImages() {
        urlString.forEach { url in
            OperationQueue().addOperation {
                NetworkConnection.request(resource: url) {
                    self.images.append(UIImage(data: $0) ?? UIImage())
                    self.count += 1
                    if self.count == self.urlString.count {
                        NotificationCenter.default.post(name: .downloadFinished,
                                                        object: nil)
                    }
                }
            }
        }
    }
    
    func index(of index: Int) -> UIImage? {
        return images[index]
    }
}

extension Notification.Name {
    static let downloadFinished = Notification.Name("downloadFinished")
}
