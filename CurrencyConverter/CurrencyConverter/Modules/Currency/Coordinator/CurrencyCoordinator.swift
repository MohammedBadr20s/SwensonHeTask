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
        self.navigationController.viewControllers.append(vc)
    }
    
    
    
}
