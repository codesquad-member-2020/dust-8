//
//  ChartTableViewDatasource.swift
//  dust
//
//  Created by 신한섭 on 2020/03/31.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class ChartTableViewDatasource: NSObject, UITableViewDataSource {
    
    var modelManger: DustInfoModelManager?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelManger?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChartCell") as! ChartTableViewCell
        let currentModel = modelManger?.index(of: indexPath.row) ?? DustInfoModel(numeric: 0, station: "", time: "0")
        
        cell.bar.frame = CGRect(x: 0, y: 0, width: cell.bounds.width * CGFloat(currentModel.percentage), height: cell.bounds.height)
        cell.bar.backgroundColor = UIColor(named: "\(currentModel.grade)")
        cell.numeric.text = String(currentModel.numeric)
        
        return cell
    }
}
