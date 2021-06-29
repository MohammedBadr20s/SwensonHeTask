//
//  UIColor+Extension.swift
//  CurrencyConverter
//
//  Created by Mohammed Badr on 28/06/2021.
//

import UIKit

extension UIColor {
    
    class var accentColor: UIColor {
        return UIColor(named: "AccentColor") ?? UIColor.systemBlue
    }
    class var seperatorColor: UIColor {
        return UIColor(named: "seperatorColor") ?? UIColor.white
    }
    class var Blue: UIColor {
        return UIColor(named: "Blue") ?? UIColor.Blue
    }
    class var DarkBlue: UIColor {
        return UIColor(named: "DarkBlue") ?? UIColor.DarkBlue
    }
    
    class var Red: UIColor {
        return UIColor(named: "Red") ?? UIColor.DarkBlue
    }
    
    class var Black: UIColor {
        return UIColor(named: "Black") ?? UIColor.Black
    }
    
}
