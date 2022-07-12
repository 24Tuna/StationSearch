//
//  StationModel.swift
//  StationSearch
//
//  Created by cmStudent on 2022/07/09.
//

import Foundation

struct Welcome: Decodable {
    let response: StationResponse
}


struct StationResponse: Decodable {
    let station: [Station]
}

struct Station: Decodable,Hashable{
    let name: String
    let x, y: Double
}
