//
//  CurrencyRouter.swift
//  CurrencyConverter
//
//  Created by GoKu on 28/06/2021.
//

import Foundation
import Alamofire
import RxSwift

enum CurrencyRouter: URLRequestBuilder {
    
    case getLatestData(accessKey: String)
    
    var path: String {
        switch self {
        case .getLatestData:
            return ServerPath.getLatest.rawValue
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getLatestData(let accessKey):
            return [
                "access_key": accessKey
            ]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        return [
            "Content-Type": "application/json",
        ]
    }
}
