import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    public var foods = [Food]()
    private let presenter = FoodPresenter()
    var restDefault: DataDefaultsProtocol = FoodDefault()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    private func setupView() {
        // Table
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        // Presenter
        presenter.setViewDelegate(delegate: self)
        presenter.viewWasLoad()
    }
}



extension ViewController: FoodPresenterDelegate {
    
    func presentFoods(foods: [Food]) {
        self.foods = foods
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didShowError(error: String) {
//        показать ошибку
    }
}

extension ViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var food = foods[indexPath.row]
        let newBool = UserDefaults.standard.bool(forKey: "isFavorite\(food.id)")
        food.isFavorite = (newBool)
        let favoriteAction = UIContextualAction(style: .normal, title: "") { action, view, completion in
            food.isFavorite?.toggle()
            self.foods[indexPath.row] = food
            UserDefaults.standard.set(food.isFavorite, forKey: "isFavorite\(food.id)")
//            let qwer: Dictionary<String, Int> = ["count": 1, "isFavorite": 0]
//            UserDefaults.standard.set(qwer, forKey: "\(food.id)")
            print(food.id)
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
        if count != 0 {
            count -= 1
//            UserDefaults.standard.set(count, forKey: "\(id)")
            restDefault.saveCount(count: count, id: id)
        }
        return count
    }
    
    func plus(count: Int, id: Int) -> Int {
        var count = count
        count += 1
        print("\(count) \(id)")
//        UserDefaults.standard.set(count, forKey: "\(id)")
        restDefault.saveCount(count: count, id: id)
//        restDefault?.saveCount(count: count, id: id)
        return count
    }

    func openSecondVC() {
        guard let viewController = UIStoryboard(name: "SecondVC", bundle: nil).instantiateViewController(withIdentifier: "SecondVC") as? SecondVC else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
}

