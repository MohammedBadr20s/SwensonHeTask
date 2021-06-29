//
//  CurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by Mohammed Badr on 28/06/2021.
//

import Foundation
import RxSwift
import RxCocoa

class CurrencyViewModel: BaseViewModel, ViewModelType {
    
    
    //MARK:- Subjects
    private var currencyData = BehaviorSubject<CurrencyModel?>(value: nil)
    private var rates = BehaviorSubject<[String: Double]>(value: [:])
    
    //MARK:- Inner Input & Output Structs
    var input: Input
    var output: Output
    
    struct Input {
    }
    
    struct Output {
        let currencyData: Observable<CurrencyModel?>
        let ratesData: Observable<[String: Double]>
    }
    
    override init() {
        input = Input()
        output = Output(
            currencyData: currencyData.asObservable(),
            ratesData: rates.asObservable()
        )
        
        super.init()
    }
    
    //MARK:- Getting Latest Currency Data and rates from Fixer.io API
    func getLatestData() {
        CurrencyRouter.getLatestData(accessKey: Constants.APIKey.rawValue).Request(model: CurrencyModel.self).subscribe { (response: CurrencyModel) in
            self.currencyData.onNext(response)
            if let rates = response.rates {
                self.rates.onNext(rates)
            }
            
        } onError: { (error: Error) in
            let error = error as? ErrorModel ?? ErrorModel(success: false, error: ErrorData(code: error._code, type: nil, info: error.localizedDescription))
            self.currencyData.onError(error)
            
        }.disposed(by: disposeBag)
        
    }
}
