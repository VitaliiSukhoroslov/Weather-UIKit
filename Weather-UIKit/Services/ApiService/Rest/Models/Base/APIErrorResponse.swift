//
//  APIErrorResponse.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 03.11.2024.
//

enum RestApiError: Error {
    case dataIsNull
    case statusCode(code: Int)
    case errorModel(_ model: APIErrorResponse)
}

struct APIErrorResponse: Codable {
    let meta: String

    enum CodingKeys: String, CodingKey {
        case meta
    }

    struct Meta: Codable {
        let code: Int
        let message: String

        enum CodingKeys: String, CodingKey {
            case code, message
        }
    }
}
