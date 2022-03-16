import Foundation
import UIKit
protocol DataDefaultsProtocol: AnyObject {
    func saveCount(count: Int, id: Int)
    func getNumber(id: Int) -> String
}

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


extension ViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var food = foods[indexPath.row]
        let newBool = UserDefaults.standard.bool(forKey: "\(food.id)")
        food.isFavorite = (newBool)
        let favoriteAction = UIContextualAction(style: .normal, title: "") { action, view, completion in
            food.isFavorite?.toggle()
            self.foods[indexPath.row] = food
            UserDefaults.standard.set(food.isFavorite, forKey: "\(food.id)")
            completion(true)
        }
        if food.isFavorite! {
            favoriteAction.image = #imageLiteral(resourceName: "heartSecond")
        } else {
            favoriteAction.image = #imageLiteral(resourceName: "heart")
        }
        
        favoriteAction.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04)
        let configuration = UISwipeActionsConfiguration(actions: [favoriteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodTableViewCell.identifier) as! FoodTableViewCell
        let food = foods[indexPath.row]
        cell.configure(with: food, delegate: self)
        return cell
    }
}

extension ViewController: ViewControllerDelegate {
    func minus(count: Int, id: Int) -> Int {
        var count = count
        if count != 1 {
            count -= 1
            UserDefaults.standard.set(count, forKey: "\(id)")
        }
//        restDefault?.saveCount(count: count, id: id)
        return count
    }
    
    func plus(count: Int, id: Int) -> Int {
        var count = count
        count += 1
        UserDefaults.standard.set(count, forKey: "\(id)")
//        restDefault?.saveCount(count: count, id: id)
        return count
    }

}

