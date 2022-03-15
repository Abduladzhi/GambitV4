//
//  ViewController.swift
//  GambitV2
//
//  Created by Abduladzhi on 13.03.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FoodPresenterDelegate {

    @IBOutlet weak var tableView: UITableView!
    
//    private let tableView: UITableView = {
//        let table = UITableView()
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        return table
//    }()
    
    private var foods = [Food]()
    
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
    // table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell") as! FoodTableViewCell
        //        cell.nameLabel.text = foods[indexPath.row].name
                let food = foods[indexPath.row]
                cell.configure(with: food)
                return cell
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

//extension ViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return foods.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell") as! FoodTableViewCell
////        cell.nameLabel.text = foods[indexPath.row].name
//        let food = foods[indexPath.row]
//        cell.configure(with: food)
//        return cell
//    }
//
//
//}
