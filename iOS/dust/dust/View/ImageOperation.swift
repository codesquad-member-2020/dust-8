//
//  ImageOperation.swift
//  dust
//
//  Created by 신한섭 on 2020/04/02.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class ImageOperation: Operation {
    var slider: UISlider
    var imageView: UIImageView
    var imageManager: ImageManager
    
    init(slider: UISlider, imageView: UIImageView, imageManager: ImageManager) {
        self.slider = slider
        self.imageView = imageView
        self.imageManager = imageManager
    }
    
    override func main() {
        for index in 0..<imageManager.count() {
            if (!self.isCancelled && !isFinished) {
                DispatchQueue.main.async {
                    self.slider.value = Float(index)
                    self.imageView.image = self.imageManager.index(of: index)
                }
                sleep(1)
            }
        }
    }
}
