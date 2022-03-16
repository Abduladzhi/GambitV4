//
//  FoodDefault.swift
//  GambitV2
//
//  Created by Abduladzhi on 16.03.2022.
//

import Foundation

class FoodDefault: DataDefaultsProtocol {
    let defaults = UserDefaults.standard
    
    func saveCount(count: Int, id: Int) {
        defaults.set(count, forKey: "\(id)")
//        print("\(count) сохранение")
    }
    
    func getNumber(id: Int) -> String {
        let count = defaults.string(forKey: "\(id)")
//        print("\(count) сохранение")
        return count ?? "0"
    }
    
    
}









