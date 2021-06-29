//
//  BaseCoordinator.swift
//  CurrencyConverter
//
//  Created by GoKu on 28/06/2021.
//

import Foundation
import UIKit

//MARK:- BaseCoordinator
class BaseCoordinator: Coordinator {
    var childCoordinalors: [Coordinator] = []
    private var navigationController: UINavigationController
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(backDelegate: BackDelegate?) {}
    
    //MARK:- Start Screen
    func navigate(window: UIWindow?) {
        self.navigationController = UINavigationController()
        self.navigationController.isNavigationBarHidden = false
        let coordinator = CurrencyCoordinator(navigationController: self.navigationController)
        self.childCoordinalors.append(coordinator)
        coordinator.start(backDelegate: nil)
        window?.rootViewController?.removeFromParent()
        window?.rootViewController = self.navigationController
        window?.makeKeyAndVisible()
    }
}
