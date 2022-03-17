//
//  FoodService.swift
//  GambitV2
//
//  Created by Ахмедов Ахмед Арсенович on 17.03.2022.
//

import Foundation

class FoodService {
    
    var presenter: FoodPresenter?
    
    init(presenter: FoodPresenter) {
        self.presenter = presenter
    }
    
    public func getFoods(successCompletion: @escaping([Food]) ->(), failureCompletion: @escaping(String) ->()) {
        
        guard let url = URL(string: "https://api.gambit-app.ru/category/39?page=1") else { return }
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let foods = try JSONDecoder().decode([Food].self, from: data)
//                self?.presenter?.didSuccessObtainFood(foods: foods)
                successCompletion(foods)
            } catch {
                failureCompletion(error.localizedDescription)
//                self?.presenter?.didFailureObtainFood(error: "Произошла неизвестная ошибка")
            }
        }
        task.resume()
    }
}
