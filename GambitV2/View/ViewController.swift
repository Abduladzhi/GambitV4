import UIKit

class ViewController: UIViewController, FoodPresenterDelegate {
    @IBOutlet weak var tableView: UITableView!
    public var foods = [Food]()
    private let presenter = FoodPresenter()
    var restDefault: DataDefaultsProtocol?
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
//    Нажатие
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // presenter delegate
    func presentFoods(foods: [Food]) {
        self.foods = foods
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}



