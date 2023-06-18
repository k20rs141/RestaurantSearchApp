import Observation

@Observable final class HotPepperViewModel {
    let locationManager = LocationManager.shared
    var shops = [Shop]()
    var searchWord = ""
    var range = 3
    var gourmetSearchURL = ""

    enum Constants {
        static let baseURL = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key="
    }

    // ホットペッパーAPIの取得
    func fetchGourmet() {
        // 予約文字をエンコード
        guard let encodeSearchWord = searchWord.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        if let userLocation = locationManager.userLocation?.coordinate {
            gourmetSearchURL = Constants.baseURL + apiKey + "&lat=\(userLocation.latitude)&lng=\(userLocation.longitude)&keyword=\(encodeSearchWord)&range=\(range)&count=50&format=json"
        } else {
            gourmetSearchURL = Constants.baseURL + apiKey + "&lat=35.68944&lng=139.69167&keyword=\(encodeSearchWord)&range=\(range)&count=50&format=json"
        }

        Task {
            do {
                let response = try await HotPepperAPIService.shared.request(with: gourmetSearchURL)
                if let shops = response.results.shop {
                    if shops.count == 0 {
//                        present(.showAPIErrorAlert(title: "検索結果が0件です", message: ""))
                    } else {
                        self.shops = shops
                    }
                } else if let error = response.results.error {

                }
            } catch {
                APIError.invalidURL
            }
        }
    }
}
