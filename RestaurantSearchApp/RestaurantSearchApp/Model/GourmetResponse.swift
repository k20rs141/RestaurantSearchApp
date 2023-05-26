import Foundation

struct Gourmet: Codable {
    let results: Results
}

struct Results: Codable {
    let shop: [Shop]?
    let error: [Errors]?
}

struct Shop: Codable {
    let name: String
    let logoImage: URL?
    let address: String
    let genre: Genre
    let mobileAccess: String
    let photo: Photos?
    
    enum CodingKeys: String, CodingKey {
        case name
        case logoImage = "logo_image"
        case address
        case genre
        case mobileAccess = "mobile_access"
        case photo
    }
}

struct Genre: Codable {
    let name: String
}

struct Photos: Codable {
    let mobile: PhotoSize
}

struct PhotoSize: Codable {
    let large: String?
    let small: String?
    
    enum CodingKeys: String, CodingKey {
        case large = "l"
        case small = "s"
    }
}

struct Errors: Codable {
    let code: Int
    let message: String
}
