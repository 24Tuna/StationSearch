//
//  A`.swift
//  StationSearch
//
//  Created by cmStudent on 2022/07/09.
//

import Foundation

import Combine

protocol APIServiceType{
    func request<Request>(with request:Request) -> AnyPublisher<Request.Response, APIServiceError> where Request:APIRequestType
}

final class APIService: APIServiceType{
    
    private let baseURLstring: String
    
    init(baseURLString: String = "https://express.heartrails.com"){
        self.baseURLstring = baseURLString
    }
    
    func request<StationRequest>(with request: StationRequest) -> AnyPublisher<StationRequest.Response, APIServiceError> where StationRequest: APIRequestType {
        
        guard let pathURL = URL(string: request.path, relativeTo: URL(string: baseURLstring)) else{
            return Fail(error: APIServiceError.invaildUrl).eraseToAnyPublisher()
        }
        
        print("========")
        print(pathURL)
        
        var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = request.queryItems

        print("========")
        print(urlComponents)
        print("========")
        
        var request = URLRequest(url: urlComponents.url!)
        
        let decorder = JSONDecoder()
        //↓JSONのスネークケースをキャメルケースに変換し、parseする
//        decorder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: request)
        //とってきたデータはどうする?
        //mapでレスポンスデータのみをストリームに使う(レスポンスデータは使わない)
            .map{ data, urlResponce in data}
        //エラーが起きた時にresponceErrorを返す
            .mapError { _ in APIServiceError.responseError }
        //ここからは正常に取得できたデータを処理していく
        //デコードする
            .decode(type: StationRequest.Response.self, decoder: decorder)
        //デコードでエラーが起きたらparseErrorを返す
            .mapError { error in
                print("デコードエラー")
                return APIServiceError.parseError(error)}
        //メインスレッドで実行する
            .receive(on: RunLoop.main)
        //Publisherを平坦に鳴らす
            .eraseToAnyPublisher()
    }
}
