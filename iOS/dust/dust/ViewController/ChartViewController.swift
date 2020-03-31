//
//  FirstViewController.swift
//  dust
//
//  Created by 신한섭 on 2020/03/30.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class ChartViewController: UIViewController {
    
    @IBOutlet weak var summaryView: SummaryView!
    @IBOutlet weak var chartTableView: UITableView!
    @IBOutlet weak var emoticonLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var numericLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stationLabel: UILabel!
    
    private var model = [DustInfoModel]()
    private var dataSource = ChartTableViewDatasource()
    private var delegate = ChartTableViewDelegate()
    private let emoticonUnicode = ["Good" : "\u{1F600}", "Normal" : "\u{1F642}", "Bad" : "\u{1F637}", "Terrible" : "\u{1F631}"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0..<24 {
            model.append(DustInfoModel(numeric: Int.random(in: 0...200), station: "강남구", time: String(index)))
        }
        
        setupDelegate()
        setupDatasource()
        
        self.emoticonLabel.font = UIFont(name: self.timeLabel.font.fontName, size: self.summaryView.frame.height * 0.35)
        
        changeSummaryViewUI(model: model[0])
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeSummaryViewUI(_:)),
                                               name: .FirstCellOnTalbeView,
                                               object: nil)
    }
    
    func setupDelegate() {
        delegate.model = model
        self.chartTableView.delegate = delegate
    }
    
    func setupDatasource() {
        dataSource.model = model
        self.chartTableView.dataSource = dataSource
    }
    
    func changeSummaryViewUI(model: DustInfoModel) {
        DispatchQueue.main.async {
            self.summaryView.state = model.grade
            self.numericLabel.text = String(model.numeric)
            self.stationLabel.text = String(model.station)
            self.timeLabel.text = String(model.time)
            self.gradeLabel.text = model.grade.rawValue
            
            self.emoticonLabel.text = self.emoticonUnicode[model.grade.rawValue]
        }
    }
    
    @objc func changeSummaryViewUI(_ notification: Notification) {
        guard let model = notification.userInfo?["model"] as? DustInfoModel else {return}
        changeSummaryViewUI(model: model)
    }
}

