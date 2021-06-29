//
//  CurrencyViewController.swift
//  CurrencyConverter
//
//  Created by Mohammed Badr on 28/06/2021.
//

import UIKit
import FlagKit

//MARK:- CurrrencyModule Navigation Protocol
protocol CurrencyViewNavigationDelegate {
    func navigateToCurrencyConverter(baseCurrency: String, rate: [String: Double])
}
//MARK:- Currency View Controller which responsible for showing the base currency and its rates list with other currencies
class CurrencyViewController: BaseViewController {
    //MARK:- Properties
    @IBOutlet weak var baseCurrencyImageView: UIImageView!
    @IBOutlet weak var baseCurrencyLbl: UILabel!
    @IBOutlet weak var ratesTableView: UITableView!
    let viewModel = Injection.container.resolve(CurrencyViewModel.self)!
    var navigationDelegate: CurrencyViewNavigationDelegate?
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //MARK:- Configure UI elements
    override func ConfigureUI() {
        bindTableView()
        bindViewModel()
        self.ratesTableView.showStateView(show: true, state: .loading, msg: nil)
        self.viewModel.getLatestData()
    }
    
    //MARK:- Binding View Model Data to View
    private func bindViewModel() {
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
            
            if data.isEmpty {
                self.ratesTableView.showStateView(show: true, state: .noData, msg: "Opps! Looks like something went wrong")
            } else {
                self.ratesTableView.tableFooterView = nil
            }
            
        }.disposed(by: self.viewModel.disposeBag)
    }
    //MARK:- Binding TableView with ViewModel Data
    private func bindTableView() {
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
    
    //MARK:- Rate Cell Configuration
    private func ratesCellConfiguration(tableView: UITableView, index: IndexPath, key: String, value: Double) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RatesCell.id, for: index) as? RatesCell else { return RatesCell()}
        
        let flag = Flag(countryCode: String(key.uppercased().dropLast()))
        
        cell.config(image: flag?.image(style: .circle), flagName: key, rate: value)
        
        return cell
    }
}
