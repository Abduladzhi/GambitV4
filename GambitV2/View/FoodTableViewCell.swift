import Foundation
import UIKit

protocol ViewControllerDelegate: AnyObject {
    func plus(count: Int) -> Int
}

class FoodTableViewCell: UITableViewCell {
    weak var delegate: ViewControllerDelegate?
    static let identifier = "foodCell"
    
    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelNumberFood: UILabel!
    @IBOutlet weak var buttonBasket: UIButton!
    
    
    var numberFood: Int = 1
    
    override func prepareForReuse() {
             super.prepareForReuse()
        nameLabel.text?.removeAll()
        labelPrice.text?.removeAll()
        numberFood = 1
        imageFood.image = nil
        }
    @IBAction func btnUp(_ sender: UIButton) {
        var number = Int(labelNumberFood.text ?? "0")
        number = delegate?.plus(count: number ?? 0)
        self.labelNumberFood.text = String(number ?? 0)
//        self.labelNumberFood.text = String(numberFood)
    }
    
    @IBAction func btnBasket(_ sender: UIButton) {
    }
    
    @IBAction func btnLess(_ sender: UIButton) {
        numberFood -= 1
        self.labelNumberFood.text = String(numberFood)
    }

    func configure(with food: Food, delegate: ViewControllerDelegate) {
        self.delegate = delegate
        self.labelNumberFood.text = String(numberFood)
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
