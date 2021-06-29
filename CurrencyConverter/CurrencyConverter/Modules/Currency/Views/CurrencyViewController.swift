//
//  CurrencyViewController.swift
//  CurrencyConverter
//
//  Created by GoKu on 28/06/2021.
//

import UIKit
import FlagKit

class CurrencyViewController: BaseViewController {

    @IBOutlet weak var baseCurrencyImageView: UIImageView!
    @IBOutlet weak var baseCurrencyLbl: UILabel!
    @IBOutlet weak var ratesTableView: UITableView!
    var selectedRate = Double()
    let viewModel = Injection.container.resolve(CurrencyViewModel.self)!
    var rates = [String: Double]() {
        didSet {
            DispatchQueue.main.async {
                self.ratesTableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func ConfigureUI() {
        setupTableView()
        bindViewModel()
        self.ratesTableView.showStateView(show: true, state: .loading, msg: nil)
        self.viewModel.getLatestData()
    }
    func setupTableView() {
        self.ratesTableView.register(RatesCell.RatesCellNib(), forCellReuseIdentifier: RatesCell.id)
        self.ratesTableView.delegate = self
        self.ratesTableView.dataSource = self
    }
    
    func bindViewModel() {
        self.viewModel.output.currencyData.subscribe { (response: CurrencyModel?) in
            if let data = response {
                self.baseCurrencyLbl.text = data.base ?? ""
                self.baseCurrencyImageView.image = Flag(countryCode: String(data.base?.dropLast() ?? "").uppercased())?.image(style: .circle)
                self.rates = data.rates ?? [:]
                if self.rates.values.count == 0 {
                    self.ratesTableView.showStateView(show: true, state: .noData, msg: nil)
                } else {
                    self.ratesTableView.tableFooterView = nil
                }
            }
        } onError: { (error: Error) in
            if let error = error as? ErrorModel {
                self.ratesTableView.showStateView(show: true, state: .error, msg: error.error?.info ?? "")
            }
            
        }.disposed(by: self.viewModel.disposeBag)

    }
}

extension CurrencyViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RatesCell.id, for: indexPath) as? RatesCell else { return RatesCell()}
        let flag = Flag(countryCode: String(Array(self.rates.keys)[indexPath.row].uppercased().dropLast()))
                        
        cell.config(image: flag?.image(style: .circle), flagName: Array(self.rates.keys)[indexPath.row], rate: Array(self.rates.values)[indexPath.row].round(places: 2))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CurrencyDetailsViewController.instantiate()
        vc.baseCurrency = self.baseCurrencyLbl.text ?? ""
        vc.rate = [Array(self.rates.keys)[indexPath.row]: Array(self.rates.values)[indexPath.row]]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
