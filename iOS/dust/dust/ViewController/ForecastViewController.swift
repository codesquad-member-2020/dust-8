//
//  SecondViewController.swift
//  dust
//
//  Created by 신한섭 on 2020/03/30.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    
    private let imageManager = ImageManager()
    
    @IBOutlet weak var forecastImageVIew: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBAction func sliderChanged(_ sender: UISlider) {
        DispatchQueue.main.async {
            self.forecastImageVIew.image = self.imageManager.index(of: Int(sender.value))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageManager.downloadImages()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(downloadFinished),
                                               name: .downloadFinished,
                                               object: nil)
    }
    
    @objc func downloadFinished() {
        DispatchQueue.main.async {
            self.forecastImageVIew.image = self.imageManager.index(of: 0)
            self.slider.setupSlider(min: 0, max: Float(self.imageManager.count() - 1))
        }
    }
}

extension UISlider {
    func setupSlider(min: Float, max: Float) {
        self.value = 0
        self.maximumValue = max
        self.minimumValue = min
    }
}
