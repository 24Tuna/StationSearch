//
//  LinesModel.swift
//  StationSearch
//
//  Created by cmStudent on 2022/07/09.
//

import Foundation

struct LinesResponce:Decodable{
    let lines:Lines
}

struct Lines:Decodable{
    let line: String
}
