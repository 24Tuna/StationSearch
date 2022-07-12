//
//  StationResponce.swift
//  StationSearch
//
//  Created by cmStudent on 2022/07/09.
//

import Foundation
//import Combine

protocol APIRequestType{
    //<ジェネリクス>の書き方の代わり
    associatedtype Response: Decodable
    
    //プロパティ
    var path: String { get }//計算型プロパティ※ではない
    var queryItems: [URLQueryItem]? { get }
}

struct StationRequest: APIRequestType{
    typealias Response =  Welcome
    private let query: String
    let path = "/api/json"
    let queryItems: [URLQueryItem]?
    
    init(query: String){
        self.query = query
        self.queryItems = [.init(name: "method", value: "getStations"),
                          .init(name: "line", value: query)]
    }
}

struct LinesRequest: APIRequestType{
    typealias Response = Lines
    private let query: String
    let path = "/search/repositries"
    let queryItems: [URLQueryItem]?
    
    init(query: String){
        self.query = query
        self.queryItems = [.init(name: "method", value: "getLines"),
                          .init(name: "prefecture", value: "東京都")]
    }
}

