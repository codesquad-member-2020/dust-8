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
    private var received = 0
    
    
    init() {
        self.images = [UIImage]()
    }
    
    func downloadImages() {
        urlString.forEach { url in
            OperationQueue().addOperation {
                NetworkConnection.request(resource: url) {
                    self.images.append(UIImage(data: $0) ?? UIImage())
                    self.received += 1
                    if self.received == self.urlString.count {
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
    
    func count() -> Int {
        return self.images.count
    }
}

extension Notification.Name {
    static let downloadFinished = Notification.Name("downloadFinished")
}
