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
//    private func handleMoveToFavorite() {
//            print("Moved to favorite")
//        }
//    func tableView(_ tableView: UITableView,
//                       trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let favorite = UIContextualAction(style: .normal,
//                                                 title: "Favorite") { [weak self] (action, view, completionHandler) in
//                                                    self?.handleMoveToFavorite()
//                                                    completionHandler(true)
//                }
//        let deleteAction = UIContextualAction(style: .normal, title: "Delete", handler: {a,b,c in
//                // example of your delete function
//            self.foods.remove(at: indexPath.row)
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
//            })
//
////        deleteAction.image = UIImage(named: "trash.png")
//        deleteAction.backgroundColor = .red
//
//        favorite.backgroundColor = .systemGray
//        let configuration = UISwipeActionsConfiguration(actions: [favorite, deleteAction])
//        return configuration
//    }
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

