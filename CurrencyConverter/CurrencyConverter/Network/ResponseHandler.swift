//
//  ResponseHandler.swift
//  CurrencyConverter
//
//  Created by GoKu on 28/06/2021.
//

import Foundation
import Alamofire

//MARK:- Response Enum
enum ResponseEnum {
    case failure(_ error: ApiError?, _ data: Any?)
    case success(_ value: Any?)
}

//MARK:- ApiError Status Codes with message and Title
enum ApiError: Int {
    case BadRequest = 400
    case ServerError = 500
    case BadGateway = 502
    case ClientSideError = 0
    case UnprocessedEntity = 422
    case Unauthorized = 401
    case MethodNotAllowed = 405
    case NoInternet = 504
    case Redirect = 406
    
    var message: String {
        switch self {
        case .BadRequest:
            return "API Bad Request"
        case .ServerError:
            return "SERVER ERROR"
        case .BadGateway:
            return "Bad Gatway"
        case .ClientSideError:
            return "Client Side ERROR"
        case .UnprocessedEntity:
            return "UNPROCESSED DATA"
        case .Unauthorized:
            return "UnAuthorized API Request"
        case .MethodNotAllowed:
            return "Method Not Allowed"
        case .NoInternet:
            return "NO INTERNET"
        case .Redirect:
            return "Redirect Error"
        }
    }
    
    var title: String {
        switch self {
        case .BadRequest:
            return "Bad Request"
        case .ServerError:
            return "Server Error"
        case .BadGateway:
            return "Bad Gateway"
        case .ClientSideError:
            return "Client Side Error"
        case .UnprocessedEntity:
            return "Data Error"
        case .Unauthorized:
            return "UnAuthorized"
        case .NoInternet:
            return "No Internet"
        case .MethodNotAllowed:
            return "Wrong Method"
        case .Redirect:
            return "Redirect Error"
        }
    }
}

//MARK:- Response Handler

class ResponseHandler {
    static let shared = ResponseHandler()
    
    //MARK:- Handle Response Data according to status Code
    func handleResponse<T: BaseModel>(_ response: AFDataResponse<Any>, model: T.Type) -> ResponseEnum {
        guard let code = response.response?.statusCode else {
            return .failure(ApiError.ClientSideError, nil)
        }
        if code < 400, let res = response.value as? Parameters, res["error"] == nil {
            return handleResponseData(response: .success(res), model: model)
        } else {
            return handleError(response.value, code: code)
        }
    }
    
    //MARK:- Handle Error Data
    func handleError(_ res: Any?, code: Int) -> ResponseEnum {
        let error = ApiError(rawValue: code)
        
        if let res = res {
            let errorModel = ErrorModel.decodeJSON(res, To: ErrorModel.self, format: .useDefaultKeys)
            return .failure(error, errorModel)
        }
        
        return .failure(error, nil)
    }
    
    
    
    //MARK:- Handle Response Data
    func handleResponseData<T: BaseModel>(response: ResponseEnum, model: T.Type) -> ResponseEnum {
        switch response {
        case .failure(let error, let data):
            return .failure(error, data)
        case .success(let value):
            guard let value = value else {
                return .failure(ApiError.ClientSideError, nil)
            }
            guard let responseData = model.decodeJSON(value, To: model, format: .useDefaultKeys) else {
                return .failure(ApiError.UnprocessedEntity, nil)
            }
            return .success(responseData)
        }
    }
}
