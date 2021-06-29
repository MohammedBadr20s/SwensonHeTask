//
//  CurrencyViewController.swift
//  CurrencyConverter
//
//  Created by GoKu on 28/06/2021.
//

import UIKit
import FlagKit

protocol CurrencyViewNavigationDelegate {
    func navigateToCurrencyConverter(baseCurrency: String, rate: [String: Double])
}

class CurrencyViewController: BaseViewController {

    @IBOutlet weak var baseCurrencyImageView: UIImageView!
    @IBOutlet weak var baseCurrencyLbl: UILabel!
    @IBOutlet weak var ratesTableView: UITableView!
    let viewModel = Injection.container.resolve(CurrencyViewModel.self)!
    var navigationDelegate: CurrencyViewNavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func ConfigureUI() {
        bindTableView()
        bindViewModel()
        self.ratesTableView.showStateView(show: true, state: .loading, msg: nil)
        self.viewModel.getLatestData()
    }
    
    func bindViewModel() {
        self.viewModel.output.currencyData.subscribe { (response: CurrencyModel?) in
            if let data = response {
                
                self.baseCurrencyLbl.text = data.base ?? ""
                self.baseCurrencyImageView.image = Flag(countryCode: String(data.base?.dropLast() ?? "").uppercased())?.image(style: .circle)
                
            }
        } onError: { (error: Error) in
            
            if let error = error as? ErrorModel {
                self.ratesTableView.showStateView(show: true, state: .error, msg: error.error?.info ?? "")
            }
            
        }.disposed(by: self.viewModel.disposeBag)
        
        self.viewModel.output.ratesData.bind { (data: [String : Double]) in
            
            if data.count == 0 {
                self.ratesTableView.showStateView(show: true, state: .noData, msg: "Opps! Looks like something went wrong")
            } else {
                self.ratesTableView.tableFooterView = nil
            }
            
        }.disposed(by: self.viewModel.disposeBag)
    }
    
    func bindTableView() {
        self.ratesTableView.register(RatesCell.RatesCellNib(), forCellReuseIdentifier: RatesCell.id)
        
        self.viewModel.output.ratesData.bind(to: self.ratesTableView.rx.items) { (tableView, row, element) -> UITableViewCell in
            
            return self.ratesCellConfiguration(tableView: tableView, index: IndexPath(row: row, section: 0), key: element.key, value: element.value)
            
        }.disposed(by: self.viewModel.disposeBag)
        
        self.ratesTableView.rx.modelSelected(Dictionary<String, Double>.Element.self).subscribe { (item) in
            if let item = item.element {
                
                self.navigationDelegate?.navigateToCurrencyConverter(baseCurrency: self.baseCurrencyLbl.text ?? "", rate: [item.key : item.value])
            }
        }.disposed(by: self.viewModel.disposeBag)

    }
    
    private func ratesCellConfiguration(tableView: UITableView, index: IndexPath, key: String, value: Double) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RatesCell.id, for: index) as? RatesCell else { return RatesCell()}
        
        let flag = Flag(countryCode: String(key.uppercased().dropLast()))
        
        cell.config(image: flag?.image(style: .circle), flagName: key, rate: value)
        
        return cell
    }
}
