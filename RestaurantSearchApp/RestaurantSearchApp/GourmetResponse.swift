import Foundation

struct Gourmet: Codable {
    let results: Results
}

struct Results: Codable {
    let shop: [Shop]?
    let error: [Errors]?
}

struct Shop: Codable {
    let access: String
    let address: String
    let mobile_access: String
    let name: String
    let logo_image: URL?
    let photo: Photos
    
    enum CodingKeys: String, CodingKey {
        case address
        case access
        case mobile_access
        case name
        case logo_image
        case photo
    }
}

struct Photos: Codable {
    let mobile: PhotoSize
}

struct PhotoSize: Codable {
    let l: String
    let s: String
}

struct Errors: Codable {
    let code: Int
    let message: String
}
