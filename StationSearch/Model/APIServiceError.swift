//
//  APIServiceError.swift
//  StationSearch
//
//  Created by cmStudent on 2022/07/09.
//

import Foundation

enum APIServiceError: Error{
    //URLが不正な場合
    case invaildUrl
    //APIレスポンスのエラー
    case responseError
    //パースが失敗した場合
    case parseError(Error)
}
