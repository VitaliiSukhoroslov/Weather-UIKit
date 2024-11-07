//
//  APIServiceWeather.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 03.11.2024.
//  
//

import Moya
import Alamofire
import Foundation

class APIServiceWeather: BaseAPIService {

    private let provider: MoyaProvider<APITargetWeather> = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        configuration.timeoutIntervalForResource = 120

        let session = Session(
            configuration: configuration,
            serverTrustManager: ServerTrustManager(
                allHostsMustBeEvaluated: false,
                evaluators: [:]
            )
        )

        var plugins = [PluginType]()
#if DEBUG
        plugins.append(NetworkLoggerPlugin(configuration: .init(logOptions: .formatRequestAscURL)))
        plugins.append(VerbosePlugin(verbose: true))
#endif
        return MoyaProvider<APITargetWeather>(
            session: session,
            plugins: plugins
        )
    }()

    override init() {
        super.init()
    }

    var isReachable: Bool {
        NetworkReachabilityManager()?.isReachable ?? false
    }
}

extension APIServiceWeather: APIServiceWeatherProtocol {
    /// Получение погоды по координатам
    func getWeatherLocationCoordinate(
        request: LocationCoordinateRequest,
        completion: ((Result<CommonWeather, Error>) -> Void)?
    ) {
        provider.request(
            .locationCoordinate(request: request),
            completion: createInnerCompletionBlock(from: completion)
        )
    }
}
