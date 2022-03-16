import Foundation

struct Food: Codable {
    let id: Int
    let name: String
    let image: String
    let price: Int
    let oldPrice: Int
    let description: String
    var isFavorite: Bool?

    init?(dict: [String: AnyObject]) {
        guard let id = dict["id"] as? Int,
        let name = dict["name"] as? String,
        let image = dict["image"] as? String,
        let price = dict["price"] as? Int,
        let oldPrice = dict["oldPrice"] as? Int,
        let description = dict["description"] as? String else { return nil }
        
        self.id = id
        self.name = name
        self.image = image
        self.price = price
        self.oldPrice = oldPrice
        self.description = description
    }
}
