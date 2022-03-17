import Foundation
import UIKit

protocol FoodPresenterDelegate: AnyObject {
    func presentFoods(foods: [Food])
    func didShowError(error: String)
}

typealias PresentDelegate = FoodPresenterDelegate & UIViewController

class FoodPresenter {
    
    weak var delegate: PresentDelegate?
    var service: FoodService?
    
    func viewWasLoad() {
        service = FoodService(presenter: self)
        
        service?.getFoods(successCompletion: { foods in
            
            self.delegate?.presentFoods(foods: foods)
            
        }, failureCompletion: { error in
            
            self.delegate?.didShowError(error: error)
            
        })
    }
    
    public func setViewDelegate(delegate: FoodPresenterDelegate & UIViewController) {
        self.delegate = delegate
    }
    
//    func didSuccessObtainFood(foods: [Food]) {
//        delegate?.presentFoods(foods: foods)
//    }
//
//    func didFailureObtainFood(error: String) {
//        delegate?.didShowError(error: error)
//    }
}
