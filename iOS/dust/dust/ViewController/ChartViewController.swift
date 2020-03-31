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
    
    private var model = [DustInfoModel]()
    private var dataSource = ChartTableViewDatasource()
    private var delegate = ChartTableViewDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0..<24 {
            model.append(DustInfoModel(numeric: Int.random(in: 0...200)))
        }
        
        dataSource.model = model
        delegate.model = model
        self.chartTableView.dataSource = dataSource
        self.chartTableView.delegate = delegate
        
        summaryView.state = model[0].grade
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeSummaryViewUI(_:)),
                                               name: .FirstCellOnTalbeView,
                                               object: nil)
    }
    
    @objc func changeSummaryViewUI(_ notification: Notification) {
        guard let model = notification.userInfo?["model"] as? DustInfoModel else {return}
        summaryView.state = model.grade
    }
}

