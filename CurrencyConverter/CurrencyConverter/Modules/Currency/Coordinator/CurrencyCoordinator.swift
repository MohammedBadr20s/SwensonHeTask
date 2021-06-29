//
//  CurrencyCoordinator.swift
//  CurrencyConverter
//
//  Created by Mohammed Badr on 28/06/2021.
//

import UIKit

//MARK:- Currency Coordinator Which is responsible for Navigations from and to Currency Module Views
class CurrencyCoordinator: Coordinator {
    var childCoordinalors: [Coordinator] = []
    let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.tintColor = .Black
        self.navigationController.isNavigationBarHidden = true
    }
    
    func start(backDelegate: BackDelegate?) {
        let vc = CurrencyViewController.instantiate()
        vc.title = "Currency Converter"
        vc.navigationDelegate = self
        self.navigationController.viewControllers.append(vc)
    }
    
}

//MARK:- Currency View Navigation Delegate which responsible for navigations from Currency View
extension CurrencyCoordinator: CurrencyViewNavigationDelegate {
    func navigateToCurrencyConverter(baseCurrency: String, rate: [String : Double]) {
        let vc = CurrencyConverterViewController.instantiate()
        vc.baseCurrency = baseCurrency
        vc.rate = rate
        vc.backDelegate = self
        self.navigationController.pushViewController(vc, animated: true)
    }
}
//MARK:- Back Delegate which responsible for Poping up the last view
extension CurrencyCoordinator: BackDelegate {
    func back() {
        navigationController.popViewController(animated: true)
        if childCoordinalors.count > 1 {
            childCoordinalors.removeLast()
        }
    }
}
