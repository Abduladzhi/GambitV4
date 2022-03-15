import Foundation

struct Food: Codable {
    let id: Int
    let name: String
    let image: String
    let price: Int
    let oldPrice: Int
    let description: String
}
