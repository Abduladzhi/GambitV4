//
//  FoodTableViewCell.swift
//  GambitV2
//
//  Created by Abduladzhi on 14.03.2022.
//
import Foundation
import UIKit

class FoodTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with food: Food) {
        self.nameLabel.text = food.name
//        self.bigImage.downloaded(from: menu.image)
    }
}
