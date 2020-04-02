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
        
        return cell
    }
}
