import UIKit

class ViewController: UIViewController, FoodPresenterDelegate {

    @IBOutlet weak var tableView: UITableView!
    var foods = [Food]()
    
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
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodTableViewCell.identifier) as! FoodTableViewCell
        let food = foods[indexPath.row]
        cell.configure(with: food)
        return cell
    }
}

