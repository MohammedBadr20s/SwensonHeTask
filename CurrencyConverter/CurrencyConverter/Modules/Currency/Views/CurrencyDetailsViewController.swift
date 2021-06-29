//
//  CurrencyDetailsViewController.swift
//  CurrencyConverter
//
//  Created by GoKu on 29/06/2021.
//

import UIKit

class CurrencyDetailsViewController: BaseViewController {

    @IBOutlet weak var baseCurrencyTF: UITextField!
    @IBOutlet weak var rateResultLbl: UILabel!
    var baseCurrency: String = ""
    var rate = [String: Double]() {
        didSet {
            baseCurrencyTF.text = "\(1.00) \(self.baseCurrency)"
            self.rateResultLbl.text = "\((rate.values.first ?? 1).round(places: 2)) \(rate.keys.first ?? "")"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .white
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.isNavigationBarHidden = true
    }
    override func ConfigureUI() {
        
        self.hideKeyboardWhenTappedAround()
        baseCurrencyTF.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        baseCurrencyTF.addTarget(self, action: #selector(self.textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        baseCurrencyTF.addTarget(self, action: #selector(self.textFieldDidEndEditing(_:)), for: .editingDidEnd)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text?.components(separatedBy: " ")
        let result = ((Double(text?.first ?? "1") ?? 1) * (rate.values.first ?? 1)).round(places: 2)
        self.rateResultLbl.text = "\(result) \(rate.keys.first ?? "")"
        
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = nil
    }
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = (textField.text ?? "") + " \(self.baseCurrency)"
    }
}
