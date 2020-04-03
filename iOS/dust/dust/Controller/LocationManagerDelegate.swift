//
//  LocationDelegate.swift
//  dust
//
//  Created by 신한섭 on 2020/04/02.
//  Copyright © 2020 신한섭. All rights reserved.
//

import CoreLocation

class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            manager.stopUpdatingLocation()
            NotificationCenter.default.post(name: .sendStationName,
                                            object: nil,
                                            userInfo: ["coordinate" : currentLocation.coordinate])
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension Notification.Name {
    static let sendStationName = Notification.Name("sendStationName")
}
