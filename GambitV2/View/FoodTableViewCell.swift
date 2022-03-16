import Foundation
import UIKit

protocol ViewControllerDelegate: AnyObject {
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
    
    var numberFood: Int = 1
    
    override func prepareForReuse() {
             super.prepareForReuse()
        labelNumberFood.text?.removeAll()
        imageFood.image = nil
        }
    @IBAction func btnUp(_ sender: UIButton) {
        var number = Int(labelNumberFood.text ?? "0")
        number = delegate?.plus(count: number ?? 0, id: self.id)
        self.labelNumberFood.text = String(number ?? 0)
//        self.labelNumberFood.text = String(numberFood)
    }
    
    @IBAction func btnBasket(_ sender: UIButton) {
        var number = Int(labelNumberFood.text ?? "0")
        number = delegate?.plus(count: number ?? 0, id: self.id)
        self.labelNumberFood.text = String(number ?? 0)
//        self.labelNumberFood.text = String(numberFood)
    }
    
    @IBAction func btnLess(_ sender: UIButton) {
        var number = Int(labelNumberFood.text ?? "0")
        number = delegate?.minus(count: number ?? 0, id: self.id)
        self.labelNumberFood.text = String(number ?? 0)
//        self.labelNumberFood.text = String(numberFood)
    }
    var id = 0
    
    func configure(with food: Food, delegate: ViewControllerDelegate) {
        self.delegate = delegate
        self.id = food.id
        let numberFood = UserDefaults.standard.string(forKey: "\(id)")
        
//        if ((labelNumberFood.text?.isEmpty) != nil) {
//            self.buttonUIUp.isHidden = false
//            self.buttonUILess.isHidden = false
//            self.labelNumberFood.isHidden = false
//            self.buttonBasket.isHidden = true
//        } else {
//            self.buttonUIUp.isHidden = true
//            self.buttonUILess.isHidden = true
//            self.labelNumberFood.isHidden = true
//            self.buttonBasket.isHidden = false
//        }
        
        self.labelNumberFood.text = numberFood
        self.buttonBasket.isHidden = true
        self.nameLabel.text = food.name
        self.labelPrice.text = String(food.price) + "₽"
        self.imageFood.downloaded(from: food.image)
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


