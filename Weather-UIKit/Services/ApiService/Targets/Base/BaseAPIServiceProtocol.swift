//
//  BaseAPIServiceProtocol.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 03.11.2024.
//
//

import Foundation
import Moya

protocol BaseAPIServiceProtocol {
    func createInnerCompletionBlock<T: Decodable>(
        from outerBlock: ((Swift.Result<T, Error>) -> Void)?
    ) -> Completion
}
