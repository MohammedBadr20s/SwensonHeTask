//
//  Constants.swift
//  CurrencyConverter
//
//  Created by Mohammed Badr on 28/06/2021.
//

import Foundation

//MARK:- Constants of the app
enum Constants: String {
    case APIKey = "7df3d13fdb8d7096a7e8010bd4c9b5de"
    case environment
}

//MARK:- Environment
enum Environment: String {
    case Development = "http://data.fixer.io/api//"
    case Production = "http://data.fixer.io/api/"
    
    func changeTo() {
        UserDefaults.standard.setValue(self.rawValue, forKey: Constants.environment.rawValue)
        UserDefaults.standard.synchronize()
    }
    static func current() -> Environment? {
        return Environment(rawValue: UserDefaults.standard.value(forKey: Constants.environment.rawValue) as? String ?? Environment.Production.rawValue)
    }
}
//MARK:- App languages
enum AppLanguages: String{
    case en, ar
}
