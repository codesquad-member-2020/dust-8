//
//  SecondViewController.swift
//  dust
//
//  Created by 신한섭 on 2020/03/30.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var forecastImageVIew: UIImageView!
    private let imageManager = ImageManager()
    
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
        }
    }
}
