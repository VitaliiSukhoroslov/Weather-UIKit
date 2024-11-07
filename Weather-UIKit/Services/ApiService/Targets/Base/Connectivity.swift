//
//  Connectivity.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 03.11.2024.
//
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        NetworkReachabilityManager()?.isReachable ?? false
    }
}
