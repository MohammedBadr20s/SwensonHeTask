//
//  URLRequestBuilder.swift
//  CurrencyConverter
//
//  Created by Mohammed Badr on 28/06/2021.
//

import Foundation
import Alamofire
import RxSwift

//MARK:- URL Request Building Protocol
protocol URLRequestBuilder: URLRequestConvertible {
    var baseURL: String { get }
    
    var mainURL: URL { get }
    
    var requestURL: URL{ get }
    
    var path: String { get }
    
    var headers: HTTPHeaders { get }
    
    var parameters: Parameters? { get }
    
    var method: HTTPMethod { get }
    
    var encoding: ParameterEncoding { get }
    
    var urlRequest: URLRequest { get }
    
    func Request<T: BaseModel>(model: T.Type) -> Observable<T>
    
    func handleError<T: BaseModel>(apiError: ApiError?, data: Any?, observer: AnyObserver<T>)
}


extension URLRequestBuilder {
    
    var baseURL: String {
        return Environment.current()?.rawValue ?? ServerPath.baseURL.rawValue
    }
    
    var mainURL: URL {
        /*Forced Typecast is safe here because your baseURL must be valid or the app will crash with the First API Request
         and navigate to this line of code before even launch
         */
        return URL(string: baseURL)!
    }
    
    var requestURL: URL {
        /*Forced Typecast is safe here because if mainURL is valid requestURL is going to be valid even if path is empty
         */
        let urlStr = mainURL.absoluteString + path
        return URL(string: urlStr)!
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        case .delete:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        headers.forEach{request.addValue($0.value, forHTTPHeaderField: $0.name)}
        return request
    }
    
    func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    //MARK:- API Request Function
    func Request<T: BaseModel>(model: T.Type) -> Observable<T> {
        return Observable.create { (observer: AnyObserver<T>) -> Disposable in
            let manager = AF
            manager.sessionConfiguration.timeoutIntervalForRequest = 60
            manager.sessionConfiguration.timeoutIntervalForResource = 60
            manager.request(self).responseJSON { (response: AFDataResponse<Any>) in
                response.interceptResuest("\(self.requestURL)", self.parameters)
                
                let resEnum = ResponseHandler.shared.handleResponse(response, model: model)
                
                switch resEnum {
                case .failure(let error, let data):
                    return handleError(apiError: error, data: data, observer: observer)
                case .success(let value):
                    if let model = value as? T {
                        observer.onNext(model)
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    //MARK:- Handle Error comes from Request Function
    func handleError<T: BaseModel>(apiError: ApiError?, data: Any?, observer: AnyObserver<T>) {
        if let error = data as? ErrorModel {
            observer.onError(error)
        } else if let apiError = apiError {
            observer.onError(ErrorModel(success: false, error: ErrorData(code: apiError.rawValue, type: apiError.title, info: apiError.message)))
        } else if let error = data as? [ErrorModel] {
            let defaultError = ErrorModel(success: false, error: ErrorData(code: apiError?.rawValue, type: apiError?.title, info: apiError?.message))
            observer.onError(error.first ?? defaultError)
        }
    }
}
