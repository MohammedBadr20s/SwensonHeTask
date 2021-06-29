//
//  UIViewController+Extension.swift
//  CurrencyConverter
//
//  Created by Mohammed Badr on 29/06/2021.
//

import UIKit
import SwiftMessages

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    func showToast(message: String, status: Theme, position: SwiftMessages.PresentationStyle, duration: SwiftMessages.Duration) {
        guard let window = UIApplication.shared.keyWindow else { return }
        let success = MessageView.viewFromNib(layout: .cardView)
        success.configureTheme(status, iconStyle: .default)
        success.configureDropShadow()
        success.configureContent(title: "", body: message)
        success.button?.isHidden = true
        success.titleLabel?.isHidden = true
        var successConfig = SwiftMessages.defaultConfig
        successConfig.duration = duration
        successConfig.presentationStyle = position
        successConfig.presentationContext = .view(window.subviews.first ?? UIView())
        SwiftMessages.show(config: successConfig, view: success)
    }
}
