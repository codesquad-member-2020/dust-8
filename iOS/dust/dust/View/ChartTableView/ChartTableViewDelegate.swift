//
//  ChartTableViewDelegate.swift
//  dust
//
//  Created by 신한섭 on 2020/03/31.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class ChartTableViewDelegate: NSObject, UITableViewDelegate {
    
    var modelManager: DustInfoModelManager?
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableView = scrollView as? UITableView ?? UITableView()
        let visibleIndexPath = tableView.indexPathsForVisibleRows?.first ?? [0,0]
        let firstModel = modelManager?.index(of: visibleIndexPath.row) ?? DustInfoModel(numeric: 0, station: "", time: "0")
        NotificationCenter.default.post(name: .FirstCellOnTalbeView,
                                        object: nil,
                                        userInfo: ["model": firstModel])
    }
}

extension Notification.Name {
    static let FirstCellOnTalbeView = Notification.Name("FirstCellOnTalbeView")
}
