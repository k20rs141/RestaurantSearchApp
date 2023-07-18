import MapKit
import UIKit

final class APIEndpoint {
    init(view: UIAlertController, shops: [Shop] = [Shop](), error: [Errors]? = nil) {
        self.view = view
        self.shops = shops
        self.error = error
    }
    private let locationManager = LocationManager.shared
    private let view: UIAlertController
    private var shops = [Shop]()
    private var error: [Errors]? {
        didSet {
            if let error = error?.first {
                switch error.code {
                case 1000:
                    view.present(.makeAPIErrorAlert(title: "サーバ障害エラー", message: error.message))
                case 2000:
                        view.present(.makeAPIErrorAlert(title: "APIキーまたはIPアドレスの認証エラー", message: error.message))
                default:
                    view.present(.makeAPIErrorAlert(title: "パラメータ不正エラー", message: error.message))
                }
            }
        }
    }

    // ホットペッパーAPIの取得
    func fetchGourmet(searchWord: String, range: Int) {
        // URLComponentsの作成
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "webservice.recruit.co.jp"
        urlComponents.path = "/hotpepper/gourmet/v1/"
        // クエリの追加
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "key", value: apiKey))
        queryItems.append(URLQueryItem(name: "lat", value: "\(locationManager.userLocation?.coordinate.latitude ?? 35.68944)"))
        queryItems.append(URLQueryItem(name: "lng", value: "\(locationManager.userLocation?.coordinate.longitude ?? 139.69167)"))
        // 予約文字をエンコード
        guard let encodeSearchWord = searchWord.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        queryItems.append(URLQueryItem(name: "keyword", value: "\(encodeSearchWord)"))
        queryItems.append(URLQueryItem(name: "range", value: "\(range)"))
        queryItems.append(URLQueryItem(name: "count", value: "50"))
        queryItems.append(URLQueryItem(name: "format", value: "json"))

        urlComponents.queryItems = queryItems
        print("URLComponents: \(urlComponents)")

        Task {
            do {
                guard let url = urlComponents.url else { return }
                let response = try await HotPepperAPIService.shared.request(with: url.absoluteString)
                if let shops = response.results.shop {
                    if shops.count == 0 {
//                        view.present(.makeAPIErrorAlert(title: "検索結果が0件です", message: ""))
//                        present(.makeAPIErrorAlert(title: "検索結果が0件です", message: ""))
                    } else {
                        DispatchQueue.main.async { [weak self] in
                            self?.shops = shops
                            print(shops)
                        }
                    }
                } else if let error = response.results.error {
                    self.error = error
                }
            } catch {
                UIAlertController().present(.makeAPIErrorAlert(title: APIError.invalidURL.title, message: APIError.invalidURL.description))
            }
        }
    }

}
