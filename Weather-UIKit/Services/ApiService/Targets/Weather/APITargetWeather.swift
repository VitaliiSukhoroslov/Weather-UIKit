//
//  APITargetWeather.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 03.11.2024.
//  
//

import Moya
import Alamofire
import Foundation

enum APITargetWeather {
    case locationCoordinate(request: LocationCoordinateRequest)
}

extension APITargetWeather: TargetType {

    var baseURL: URL {
        BaseTargetType.baseURL
    }

    var path: String {
        let path: String

        switch self {
        case .locationCoordinate: path = "onecall"
        }

        return "/\(apiVersion)/\(path)"
    }

    var method: Moya.Method {
        switch self {
        case .locationCoordinate:
            return .get
        }
    }

    var headers: [String: String]? {
        BaseTargetType.headers
    }

    var task: Task {
        switch self {
        case .locationCoordinate:
            return .requestParameters(
                parameters: requestParameters,
                encoding: URLEncoding.default
            )
        }
    }

    var requestParameters: [String: Any] {
        var parameters: [String: Any] = [:]

        switch self {
        case .locationCoordinate(let request): parameters = request.parameters
        }

        parameters["lang"] = "ru"
        parameters["appid"] = ApiConfig.apiKey
        parameters["units"] = "metric"

        return parameters
    }

    var sampleData: Data {
        Data()
    }

    private var apiVersion: Double {
        3.0
    }
}
