//
//  Models.swift
//  Services
//
//  Created by Jakub Sędal on 19/04/2024.
//

import Foundation

public struct StationResponse: Decodable {
    public let data: StationData
}

public struct StatusResponse: Decodable {
    public let data: StatusData
}

public struct StationData: Decodable {
    public let stations: [Station]
}

public struct StatusData: Decodable {
    public let stations: [StationStatus]
}

public struct StationStatus: Decodable {
    public let stationId: String
    public let numBikesAvailable: Int
    public let numDocksAvailable: Int
}

public struct Station: Decodable {
    public let stationId: String
    public let name: String
    public let address: String
    public let crossStreet: String
    public let lat: Double
    public let lon: Double
}
