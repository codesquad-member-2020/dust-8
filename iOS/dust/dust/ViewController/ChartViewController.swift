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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var modelManager = DustInfoModelManager()
    private var dataSource = ChartTableViewDatasource()
    private var delegate = ChartTableViewDelegate()
    private let emoticonUnicode = ["\u{1F600}", "\u{1F600}", "\u{1F642}", "\u{1F637}", "\u{1F631}"]
    private let endPoint = "http://ec2-54-180-115-105.ap-northeast-2.compute.amazonaws.com:8080"
    
    private let locationManager = CLLocationManager()
    private let locationManagerDelegate = LocationManagerDelegate()
    private var station: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPermission()
        self.locationManager.delegate = locationManagerDelegate
        self.emoticonLabel.font = UIFont(name: "TimesNewRomanPSMT", size: self.gradationView.frame.height * 0.35)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeGradientViewUI(_:)),
                                               name: .FirstCellOnTalbeView,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getStationName(_:)),
                                               name: .sendStationName,
                                               object: nil)
        
        locationManager.requestLocation()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getDustInfo),
                                               name: .receiveStationFinished,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setupUI),
                                               name: .setupDustModelComplete,
                                               object: nil)
    }
    
    func setupDelegate() {
        delegate.modelManager = modelManager
        DispatchQueue.main.async {
            self.chartTableView.delegate = self.delegate
        }
    }
    
    func setupDatasource() {
        dataSource.modelManger = modelManager
        DispatchQueue.main.async {
            self.chartTableView.dataSource = self.dataSource
        }
    }
    
    func changeGradationViewUI(model: DustInfoModel) {
        DispatchQueue.main.async {
            self.gradationView.setGradientColor(grade: model.grade)
            self.numericLabel.text = String(model.numeric) + "𝜇g/m³"
            self.gradeLabel.text = "\(model.grade)"
            self.stationLabel.text = String(self.station ?? "")
            self.timeLabel.text = Calendar.calculateDay.getHourMinuteString(date: model.time)
            self.gradeLabel.text = "\(DustGrade.Grade(index: model.grade).rawValue)"
            self.emoticonLabel.text = self.emoticonUnicode[model.grade]
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
        NetworkConnection.request(resource: endPoint + "/stations?latitude=\(coordinate.latitude)&longitude=\(coordinate.longitude)"){
            do {
                guard let json = try JSONSerialization.jsonObject(with: $0, options: []) as? [String:Any] else {return}
                self.station = json["result"] as! String?
                NotificationCenter.default.post(name: .receiveStationFinished,
                                                object: nil)
            } catch {
                fatalError("관측소 오류!")
            }
        }
    }
    
    @objc func getDustInfo() {
        if let stationName = station {
            NetworkConnection.request(resource:
            endPoint + "/stations/dust-status?stationName=\(stationName)") {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.dateConverter)
                    let model = try decoder.decode(DustInfoModels.self, from: $0)
                    NotificationCenter.default.post(name: .receiveDustInfoFinished,
                                                    object: nil,
                                                    userInfo: ["model" : model.models])
                } catch {
                    fatalError()
                }
            }
        } else {
            let alert = UIAlertController(title: "유효하지 않은 관측소", message: "관측소 정보가 유효하지 않아서 미세먼지 수치를 불러올 수 없습니다.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "예", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func setupUI() {
        setupDelegate()
        setupDatasource()
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.chartTableView.reloadData()
        }
        changeGradationViewUI(model: modelManager.index(of: 0))
    }
}

extension Notification.Name {
    static let receiveStationFinished = Notification.Name("receiveStationFinished")
    static let receiveDustInfoFinished = Notification.Name("receiveDustInfoFinished")
}
