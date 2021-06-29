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
    let viewModel = Injection.container.resolve(CurrencyViewModel.self)!
    var backDelegate: BackDelegate?
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
//        self.navigationController?.navigationBar.tintColor = .white
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.isNavigationBarHidden = true
    }
    override func ConfigureUI() {
        
        self.hideKeyboardWhenTappedAround()
        bindTextField()
    }

    
    private func bindTextField() {
        
        self.baseCurrencyTF.rx.controlEvent([.editingChanged]).bind { (_) in
            self.calculateResult()
        }.disposed(by: self.viewModel.disposeBag)
        
        self.baseCurrencyTF.rx.controlEvent([.editingDidBegin]).bind { (_) in
            self.baseCurrencyTF.text = nil
        }.disposed(by: self.viewModel.disposeBag)
        
        self.baseCurrencyTF.rx.controlEvent([.editingDidEnd]).bind { (_) in
            let text = self.baseCurrencyTF.text  ?? "1.00"
            self.baseCurrencyTF.text = (text.isEmpty ? "1.00" : text) + " \(self.baseCurrency)"
            if text.isEmpty {
                self.calculateResult()
            }
        }.disposed(by: self.viewModel.disposeBag)
    }
    
    private func calculateResult() {
        let text = self.baseCurrencyTF.text?.components(separatedBy: " ")
        let result = ((Double(text?.first ?? "1.00") ?? 1) * (self.rate.values.first ?? 1)).round(places: 2)
        self.rateResultLbl.text = "\(result) \(self.rate.keys.first ?? "")"
    }
}
