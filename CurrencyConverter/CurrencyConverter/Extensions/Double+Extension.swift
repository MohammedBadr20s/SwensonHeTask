//
//  Double+Extension.swift
//  CurrencyConverter
//
//  Created by Mohammed Badr on 28/06/2021.
//

import Foundation

extension Double {
    func round(places: Int) -> Double {
       let multiplier = pow(10, Double(places))
        return Darwin.round(self * multiplier) / multiplier
    }
}
