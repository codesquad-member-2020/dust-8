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
    private let operationQueue = OperationQueue()
    @IBOutlet weak var gradeOfCities: UILabel!
    @IBOutlet weak var forecastContent: UILabel!
    
    @IBOutlet weak var playButton: PlayButton!
    @IBOutlet weak var acitivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var forecastImageVIew: UIImageView!
    @IBOutlet weak var slider: UISlider!
    
    private let endPoint = "http://ec2-54-180-115-105.ap-northeast-2.compute.amazonaws.com:8080"
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        DispatchQueue.main.async {
            self.forecastImageVIew.image = self.imageManager.index(of: Int(sender.value))
        }
        operationQueue.cancelAllOperations()
        NotificationCenter.default.post(name: .setButtonImagePlay,
                                        object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(downloadFinished),
                                               name: .downloadFinished,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(play(_:)),
                                               name: .playButtonPushed,
                                               object: nil)
        
        NetworkConnection.request(resource: endPoint + "/forecase") {
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(ForecastModel.self, from: $0)
                model.forecastInfo.imagesURL.forEach {
                    print($0)
                }
                
                DispatchQueue.main.async {
                    self.gradeOfCities.text = model.forecastInfo.gradeOfCities
                    self.forecastContent.text = model.forecastInfo.forecastContent
                }
                NotificationCenter.default.post(name: .receiveImagesURLFinished,
                                                object: nil,
                                                userInfo: ["imagesURL" : model.forecastInfo.imagesURL])
            } catch {
                fatalError()
            }
        }
    }
    
    @objc func downloadFinished() {
        DispatchQueue.main.async {
            self.forecastImageVIew.image = self.imageManager.index(of: 0)
            self.slider.setupSlider(min: 0, max: Float(self.imageManager.count() - 1))
            self.acitivityIndicator.stopAnimating()
            self.slider.isEnabled = true
            self.playButton.isEnabled = true
        }
    }
    
    @objc func play(_ notification: Notification) {
        guard let flag: Bool = notification.userInfo?["buttonFlag"] as? Bool else {return}
        if flag {
            operationQueue.cancelAllOperations()
        } else {
            let operation = ImageOperation(slider: slider, imageView: forecastImageVIew, imageManager: imageManager)
            operationQueue.addOperation(operation)
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        operationQueue.cancelAllOperations()
    }
}

extension UISlider {
    func setupSlider(min: Float, max: Float) {
        self.value = 0
        self.maximumValue = max
        self.minimumValue = min
    }
}

extension Notification.Name {
    static let setButtonImagePlay = Notification.Name("setButtonImagePlay")
    static let receiveImagesURLFinished = Notification.Name("receiveImagesURLFinished")
}
