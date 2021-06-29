//
//  Injection.swift
//  CurrencyConverter
//
//  Created by Mohammed Badr on 28/06/2021.
//

import Foundation
import Swinject
//MARK:- Injection
class Injection {
    
    private static let baseContainer = Container()
    static let container = baseContainer.synchronize()
    
    private init() {}
    
    //MARK:- Register BaseViewModel
    private static func registerBaseVM() {
        baseContainer.register(BaseViewModel.self) { (_) in
            return BaseViewModel()
        }
    }
    //MARK:- Register Currency View Model
    private static func registerCurrencyViewModel() {
        baseContainer.register(CurrencyViewModel.self) { (_) in
            return CurrencyViewModel()
        }
    }
    //MARK:- Register Dependencies
    public static func register() {
        registerBaseVM()
        registerCurrencyViewModel()
    }
}
