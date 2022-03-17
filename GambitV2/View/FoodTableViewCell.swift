import Foundation
import UIKit

protocol ViewControllerDelegate: AnyObject {
    func openSecondVC()
    func plus(count: Int, id: Int) -> Int
    func minus(count: Int, id: Int) -> Int
    
}
class FoodTableViewCell: UITableViewCell {
    weak var delegate: ViewControllerDelegate?
    static let identifier = "foodCell"
    
    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelNumberFood: UILabel!
    @IBOutlet weak var buttonBasket: UIButton!
    @IBOutlet weak var buttonUIUp: UIButton!
    @IBOutlet weak var buttonUILess: UIButton!
    
    var numberFood: Int?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageFood.image = nil
    }
    
    @IBAction func btnUp(_ sender: UIButton) {
        var number = Int(labelNumberFood.text ?? "0")
        number = delegate?.plus(count: number ?? 0, id: self.id)
        self.labelNumberFood.text = String(number ?? 0)
    }
    
    @IBAction func btnBasket(_ sender: UIButton) {
        
        var number = Int(labelNumberFood.text ?? "0")
        number = delegate?.plus(count: number ?? 0, id: self.id)
        if number == nil || number == 0{
            self.labelNumberFood.text = String(number ?? 0)
            self.buttonBasket.isHidden = false
            self.buttonUIUp.isHidden = true
            self.buttonUILess.isHidden = true
            self.labelNumberFood.isHidden = true
        } else {
            self.labelNumberFood.text = String(number ?? 0)
            self.buttonBasket.isHidden = true
            self.buttonUIUp.isHidden = false
            self.buttonUILess.isHidden = false
            self.labelNumberFood.isHidden = false
        }
    }
    
    @IBAction func btnLess(_ sender: UIButton) {
        var number = Int(labelNumberFood.text ?? "0")
        number = delegate?.minus(count: number ?? 0, id: self.id)
        self.labelNumberFood.text = String(number ?? 0)
        if number == 0 {
            self.labelNumberFood.text = String(number ?? 0)
            self.buttonBasket.isHidden = false
            self.buttonUIUp.isHidden = true
            self.buttonUILess.isHidden = true
            self.labelNumberFood.isHidden = true
        } else {
            self.labelNumberFood.text = String(number ?? 0)
            self.buttonBasket.isHidden = true
            self.buttonUIUp.isHidden = false
            self.buttonUILess.isHidden = false
            self.labelNumberFood.isHidden = false
        }
    }
    
    var id = 0
    func configure(with food: Food, delegate: ViewControllerDelegate) {
        self.delegate = delegate
        self.id = food.id
        let numberFood = UserDefaults.standard.string(forKey: "\(id)")
        if numberFood == nil || numberFood == "0"{
            self.buttonBasket.isHidden = false
            self.labelNumberFood.text = numberFood
            self.buttonUIUp.isHidden = true
            self.buttonUILess.isHidden = true
            self.labelNumberFood.isHidden = true
        } else {
            self.buttonBasket.isHidden = true
            self.buttonUIUp.isHidden = false
            self.buttonUILess.isHidden = false
            self.labelNumberFood.isHidden = false
            self.labelNumberFood.text = numberFood
        }
        labelPrice.layer.masksToBounds = true
        labelPrice.layer.cornerRadius = 5
        self.nameLabel.text = food.name
        self.labelPrice.text = String(food.price) + "₽"
        self.imageFood.downloaded(from: food.image)
    }
}




