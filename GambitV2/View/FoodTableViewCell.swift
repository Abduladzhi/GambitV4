import Foundation
import UIKit

class FoodTableViewCell: UITableViewCell {
    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelNumberFood: UILabel!
    @IBOutlet weak var buttonBasket: UIButton!
    
    var numberFood: Int = 1
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    @IBAction func btnUp(_ sender: UIButton) {
        numberFood += 1
        self.labelNumberFood.text = String(numberFood)
    }
    @IBAction func btnBasket(_ sender: UIButton) {
    }
    
    @IBAction func btnLess(_ sender: UIButton) {
        numberFood -= 1
        self.labelNumberFood.text = String(numberFood)
    }
    
    func configure(with food: Food) {
        self.labelNumberFood.text = String(numberFood)
        self.buttonBasket.isHidden = true
        self.nameLabel.text = food.name
        self.labelPrice.text = String(food.price) + "₽"
        self.imageFood.downloaded(from: food.image)
    }
}
