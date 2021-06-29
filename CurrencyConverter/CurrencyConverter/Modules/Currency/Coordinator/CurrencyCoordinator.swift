//
//  CurrencyCoordinator.swift
//  CurrencyConverter
//
//  Created by GoKu on 28/06/2021.
//

import UIKit


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

extension CurrencyCoordinator: CurrencyViewNavigationDelegate {
    func navigateToCurrencyConverter(baseCurrency: String, rate: [String : Double]) {
        let vc = CurrencyDetailsViewController.instantiate()
        vc.baseCurrency = baseCurrency
        vc.rate = rate
        vc.backDelegate = self
        self.navigationController.pushViewController(vc, animated: true)
    }
}

extension CurrencyCoordinator: BackDelegate {
    func back() {
        navigationController.popViewController(animated: true)
        if childCoordinalors.count > 1 {
            childCoordinalors.removeLast()
        }
    }
}
