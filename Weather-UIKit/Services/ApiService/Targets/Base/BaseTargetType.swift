//
//  BaseTargetType.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 03.11.2024.
//
//

import Foundation
import Moya

enum BaseTargetType {
    static var baseURL: URL {
        ApiConfig.baseUrl
    }

    static var headers: [String: String] {
        var headers = [String: String]()
        return headers
    }
}
