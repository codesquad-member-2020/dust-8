//
//  FirstViewController.swift
//  dust
//
//  Created by 신한섭 on 2020/03/30.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit
import CoreLocation

class ChartViewController: UIViewController {
    
    @IBOutlet weak var gradationView: GradationView!
    @IBOutlet weak var chartTableView: UITableView!
    @IBOutlet weak var emoticonLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var numericLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stationLabel: UILabel!
    
    private var modelManager = DustInfoModelManager()
    private var dataSource = ChartTableViewDatasource()
    private var delegate = ChartTableViewDelegate()
    private let emoticonUnicode = ["Good" : "\u{1F600}", "Normal" : "\u{1F642}", "Bad" : "\u{1F637}", "Terrible" : "\u{1F631}"]
    
    private let locationManager = CLLocationManager()
    private let locationManagerDelegate = LocationManagerDelegate()
    private var station: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPermission()
        setupDelegate()
        setupDatasource()
        
        self.emoticonLabel.font = UIFont(name: "TimesNewRomanPSMT", size: self.gradationView.frame.height * 0.35)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeGradientViewUI(_:)),
                                               name: .FirstCellOnTalbeView,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getStationName(_:)),
                                               name: .sendStationName,
                                               object: nil)
        
        locationManager.startUpdatingLocation()
    }
    
    func setupDelegate() {
        delegate.modelManager = modelManager
        self.chartTableView.delegate = delegate
        self.locationManager.delegate = locationManagerDelegate
    }
    
    func setupDatasource() {
        dataSource.modelManger = modelManager
        self.chartTableView.dataSource = dataSource
    }
    
    func changeGradationViewUI(model: DustInfoModel) {
        DispatchQueue.main.async {
            self.gradationView.setGradientColor(state: "\(model.grade)")
            self.numericLabel.text = String(model.numeric)
            self.gradeLabel.text = "\(model.grade)"
            self.emoticonLabel.text = self.emoticonUnicode["\(model.grade)"]
        }
    }
    
    @objc func changeGradientViewUI(_ notification: Notification) {
        guard let model = notification.userInfo?["model"] as? DustInfoModel else {return}
        changeGradationViewUI(model: model)
    }
    
    func getPermission() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return
            
        case .denied, .restricted:
            let alert = UIAlertController(title: "위치 서비스 사용 불가", message: "설정에서 위치 정보 서비스를 허용해주세요.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "예", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            return
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            fatalError("unknown error")
        }
    }
    
    @objc func getStationName(_ notification: Notification) {
        guard let coordinate = notification.userInfo?["coordinate"] as?  CLLocationCoordinate2D else {return}
        NetworkConnection.request(resource: "https://dust08.herokuapp.com/stations?latitude=\(coordinate.latitude)&longitude=\(coordinate.longitude)"){
            do {
                guard let json = try JSONSerialization.jsonObject(with: $0, options: []) as? [String:Any] else {return}
                self.station = json["result"] as! String?
            } catch {
                fatalError("관측소 오류!")
            }
        }
    }
}

