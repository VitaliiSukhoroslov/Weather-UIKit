//
//  LocationCoordinateRequest.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 03.11.2024.
//  
//

struct LocationCoordinateRequest {

    let latitude: Double
    let longitude: Double

    init (latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension LocationCoordinateRequest {
    var parameters: [String: Any] {
        let params: [String: Any?] = [
            "lat": latitude,
            "lon": longitude
        ]

        return params.removeNilAndEmptyValues()
    }
}
