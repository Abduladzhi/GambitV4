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
    
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let food = foods[indexPath.row]
//        let favoriteTitle = food.isFavorite ?? false ? "🤍":"❤️"
//        let favoriteAction = UITableViewRowAction(style: .normal, title: favoriteTitle) { _, indexPath in
//        self.foods[indexPath.row].isFavorite?.toggle()
//        }
//        favoriteAction.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04)
//        return [favoriteAction]
//    }
    
    
    private func handleMarkAsFavourite() {
        print("Marked as favourite")
    }
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: "Favourite") { [weak self] (action, view, completionHandler) in
                                            self?.handleMarkAsFavourite()
                                            completionHandler(true)
        }
        action.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [action])
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
    func plus(count: Int, id: Int) -> Int {
        var count = count
        count += 1
        UserDefaults.standard.set(count, forKey: "\(id)")
//        restDefault?.saveCount(count: count, id: id)
        return count
    }
}

