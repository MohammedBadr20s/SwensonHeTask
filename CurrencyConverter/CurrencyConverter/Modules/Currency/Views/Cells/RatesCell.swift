//
//  RatesCell.swift
//  CurrencyConverter
//
//  Created by GoKu on 29/06/2021.
//

import UIKit

class RatesCell: UITableViewCell {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var flagNameLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    
    static let id = "RatesCell"
    static func RatesCellNib() -> UINib {
        return UINib(nibName: id, bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(image: UIImage? = nil, flagName: String, rate: Double) {
        self.imageView?.image = image
        self.flagNameLbl.text = flagName
        self.rateLbl.text = "\(rate)"
    }
}
