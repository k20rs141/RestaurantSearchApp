import Foundation

enum GenreCategory: String, CaseIterable {
    case izakaya = "G001"                 // 居酒屋
    case diningBar = "G002"               // ダイニングバー・バル
    case creativeCuisine = "G003"         // 創作料理
    case japaneseFood = "G004"            // 和食
    case westernFood = "G005"             // 洋食
    case italianFrench = "G006"           // イタリアン・フレンチ
    case chineseFood = "G007"             // 中華
    case barbecueHormone = "G008"         // 焼肉・ホルモン
    case koreanFood = "G017"              // 韓国料理
    case asianEthnic = "G009"             // アジア・エスニック料理
    case internationalCuisine = "G010"    // 各国料理
    case karaokeParty = "G011"            // カラオケ・パーティ
    case barCocktail = "G012"             // バー・カクテル
    case ramen = "G013"                   // ラーメン
    case okonomiyakiMonja = "G016"        // お好み焼き・もんじゃ
    case cafeSweets = "G014"              // カフェ・スイーツ
    case otherGourmet = "G015"            // その他グルメ

    var name: String {
        switch self {
        case .izakaya:
            return "居酒屋"
        case .diningBar:
            return "ダイニングバー・バル"
        case .creativeCuisine:
            return "創作料理"
        case .japaneseFood:
            return "和食"
        case .westernFood:
            return "洋食"
        case .italianFrench:
            return "イタリアン・フレンチ"
        case .chineseFood:
            return "中華"
        case .barbecueHormone:
            return "焼肉・ホルモン"
        case .koreanFood:
            return "韓国料理"
        case .asianEthnic:
            return "アジア・エスニック料理"
        case .internationalCuisine:
            return "各国料理"
        case .karaokeParty:
            return "カラオケ・パーティ"
        case .barCocktail:
            return "バー・カクテル"
        case .ramen:
            return "ラーメン"
        case .okonomiyakiMonja:
            return "お好み焼き・もんじゃ"
        case .cafeSweets:
            return "カフェ・スイーツ"
        case .otherGourmet:
            return "その他グルメ"
        }
    }
}
