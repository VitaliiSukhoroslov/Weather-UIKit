//
//  VerbosePlugin.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 03.11.2024.
//
//

import Moya
import Foundation

struct VerbosePlugin: PluginType {
    let verbose: Bool

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        #if DEBUG
        if let body = request.httpBody,
           let str = String(data: body, encoding: .utf8) {
            if verbose {
                print("request to send: \(str))")
            }
        }
        #endif
        return request
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        #if DEBUG
        switch result {
        case .success(let body):
            if verbose {
                print("Response:")
                if let json = try? JSONSerialization.jsonObject(with: body.data, options: .mutableContainers) {
                    print(json)
                } else {
                    let response = String(data: body.data, encoding: .utf8)
                    print(response ?? "nil")
                }
            }
        case .failure:
            break
        }
        #endif
    }
}
