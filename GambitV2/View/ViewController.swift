import UIKit

class ViewController: UIViewController, FoodPresenterDelegate {

    @IBOutlet weak var tableView: UITableView!
    public var foods = [Food]()
    private let presenter = FoodPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Table
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        // Presenter
        presenter.setViewDelegate(delegate: self)
        presenter.getFoods()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        Нажатие
    }
    
    // presenter delegate
    func presentFoods(foods: [Food]) {
        self.foods = foods
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
    func plus(count: Int) -> Int {
        var count = count
        count += 1
        return count
    }
    
    
}
