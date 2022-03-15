import Foundation
import UIKit

protocol FoodPresenterDelegate: AnyObject {
    func presentFoods(foods: [Food])
}

typealias PresentDelegate = FoodPresenterDelegate & UIViewController

class FoodPresenter {
    weak var delegate: PresentDelegate?
    
    public func getFoods() {
        guard let url = URL(string: "https://api.gambit-app.ru/category/39?page=1") else { return }
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let foods = try JSONDecoder().decode([Food].self, from: data)
                self?.delegate?.presentFoods(foods: foods)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    public func setViewDelegate(delegate: FoodPresenterDelegate & UIViewController) {
        self.delegate = delegate
    }
}
