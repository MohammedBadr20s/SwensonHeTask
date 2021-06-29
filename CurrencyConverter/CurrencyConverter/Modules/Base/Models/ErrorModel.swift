//
//  ErrorModel.swift
//  CurrencyConverter
//
//  Created by Mohammed Badr on 28/06/2021.
//

import Foundation

// MARK: - ActionModel
struct ErrorModel: BaseModel, Error {
    var success: Bool?
    var error: ErrorData?
}

// MARK: - ErrorModel
struct ErrorData: BaseModel {
    var code: Int?
    var type, info: String?
}
