//
//  UITableView+Extension.swift
//  CurrencyConverter
//
//  Created by Mohammed Badr on 29/06/2021.
//

import Foundation



import UIKit


extension UITableView {
    func showStateView(show: Bool, state: State? = nil, msg: String? = nil) {
        if show {
            let stateView = StateView(frame: CGRect(x: 0, y: self.center.y, width: self.frame.width, height: self.frame.height))
            stateView.config(status: state ?? .loading, msg: msg)
            self.tableFooterView = stateView
        } else {
            self.tableFooterView = nil
        }
    }
}
