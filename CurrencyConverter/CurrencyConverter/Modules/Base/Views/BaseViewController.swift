//
//  BaseViewController.swift
//  CurrencyConverter
//
//  Created by Mohammed Badr on 28/06/2021.
//

import UIKit

//MARK:- Base View Controller for Common Functions between View Controllers to be set here
class BaseViewController: UIViewController, Storyboarded {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ConfigureUI()
    }

    func ConfigureUI() {
        
    }
}
