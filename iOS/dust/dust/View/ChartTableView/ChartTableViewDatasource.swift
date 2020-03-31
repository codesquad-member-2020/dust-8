//
//  ChartTableViewDatasource.swift
//  dust
//
//  Created by 신한섭 on 2020/03/31.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class ChartTableViewDatasource: NSObject, UITableViewDataSource {
    
    var model: [DustInfoModel]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChartCell") as! ChartTableViewCell
        
        cell.bar.frame = CGRect(x: 0, y: 0, width: cell.bounds.width * CGFloat(model![indexPath.row].percentage), height: cell.bounds.height)
        cell.numeric.text = String(model![indexPath.row].numeric)
        return cell
    }
}
