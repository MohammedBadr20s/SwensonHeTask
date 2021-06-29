//
//  Coordinator.swift
//  CurrencyConverter
//
//  Created by GoKu on 28/06/2021.
//

import UIKit

//MARK:- Coordinator Protocol
protocol Coordinator {
    
    var childCoordinalors: [Coordinator] { get set }
    
    init(navigationController: UINavigationController)
    
    func start(backDelegate: BackDelegate?)
    
}

protocol ChildCoordinator: Coordinator {
    init(navigationController: UINavigationController, parentNavigationController: UINavigationController)
}


protocol BackDelegate: class {
    func back()
}
