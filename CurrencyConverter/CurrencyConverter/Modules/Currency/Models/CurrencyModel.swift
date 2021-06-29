//
//  CurrencyModel.swift
//  CurrencyConverter
//
//  Created by Mohammed Badr on 28/06/2021.
//

import Foundation
// MARK: - CurrencyModel
struct CurrencyModel: BaseModel {
    var success: Bool?
    var timestamp: Int?
    var base, date: String?
    var rates: [String: Double]?
}
