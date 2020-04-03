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
    
    init() {
        self.images = [UIImage]()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showImage(_:)),
                                               name: .receiveImagesURLFinished,
                                               object: nil)
    }
    
    @objc func showImage(_ notification: Notification) {
        guard let urls = notification.userInfo?["imagesURL"] as? [String] else {return}
        urls.forEach {
            do {
                let url = URL(string: $0)
                let data = try Data(contentsOf: url!)
                images.append(UIImage(data: data) ?? UIImage())
            } catch {
                
            }
        }
        NotificationCenter.default.post(name: .downloadFinished,
                                        object: nil)
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
