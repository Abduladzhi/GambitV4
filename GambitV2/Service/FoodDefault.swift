import Foundation

class FoodDefault: DataDefaultsProtocol {
    let defaults = UserDefaults.standard
    
    func saveCount(count: Int, id: Int) {
        
        defaults.set(count, forKey: "\(id)")
//        print("\(count) сохранение")
    }
    
    func getNumber(id: Int) -> Int {
        let count = defaults.integer(forKey: "\(id)")
//        print("\(count) сохранение")
        return count
    }
}









