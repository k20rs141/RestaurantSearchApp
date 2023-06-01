import Foundation

struct Gourmet: Codable {
    let results: Results
}

struct Results: Codable {
    let shop: [Shop]?
    let error: [Errors]?
}

struct Shop: Codable {
    // 検索一覧画面
    let name: String
    let genre: Genre
    let budget: Budget
    let mobileAccess: String
    let photo: Photos?
    // 店舗詳細画面
    let address: String
    let open: String
    let close: String
    let card: String
    let privateRoom: String
    let nonSmoking: String
    let parking: String
    let urls: Url
    
    enum CodingKeys: String, CodingKey {
        case name
        case genre
        case budget
        case mobileAccess = "mobile_access"
        case photo
        case address
        case open
        case close
        case card
        case privateRoom = "private_room"
        case nonSmoking = "non_smoking"
        case parking
        case urls
    }
}

struct Genre: Codable {
    let name: String
}

struct Budget: Codable {
    let name: String
}

struct Photos: Codable {
    let pc: PhotoSize
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

struct Url: Codable {
    let pc: String
}

struct Errors: Codable {
    let code: Int
    let message: String
}
