//
//  ApiConfig.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 03.11.2024.
//
//

import UIKit

protocol ApiConfigProtocol {
    static var baseUrl: URL { get }
}

enum ApiConfig: ApiConfigProtocol {

    static var baseUrl: URL {
        URL(string: "https://api.openweathermap.org/data")!
    }

    static var apiKey: String {
        "892f2c15a4c7f67ed597cceb42cab9d0"
    }
}
