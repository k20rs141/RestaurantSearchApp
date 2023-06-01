import UIKit
import MapKit

class ViewController: UIViewController {
    let locationManager = LocationManager.shared
    var searchWord: String = ""
    var range = 3
    var error: [Errors]? {
        didSet {
            if let error = error?.first {
                switch error.code {
                case 1000:
                    present(.showAPIErrorAlert(title: "サーバ障害エラー", message: error.message))
                case 2000:
                    present(.showAPIErrorAlert(title: "APIキーまたはIPアドレスの認証エラー", message: error.message))
                default:
                    present(.showAPIErrorAlert(title: "パラメータ不正エラー", message: error.message))
                }
            }
        }
    }
    var shops = [Shop]() {
        didSet {
            tableView.reloadData()
        }
    }

    @IBOutlet weak var searchText: UISearchBar!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "RestaurantCustomCell", bundle: nil), forCellReuseIdentifier: "RestaurantCustomCell")
            tableView.refreshControl = UIRefreshControl()
            tableView.refreshControl?.addTarget(self, action: #selector(self.handleRefreshControl), for: .valueChanged)
        }
    }

    enum Constants {
        static let baseURL = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key="
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchText.delegate = self
        checkAuthorizationStatus()
        fetchGourmet()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    private func fetchGourmet() {
        var gourmetSearchURL = ""
        // 予約文字をエンコード
        guard let encodeSearchWord = searchWord.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        if let userLocation = locationManager.userLocation?.coordinate {
            gourmetSearchURL = Constants.baseURL + apiKey + "&lat=\(userLocation.latitude)&lng=\(userLocation.longitude)&keyword=\(encodeSearchWord)&range=\(range)&count=50&format=json"
        } else {
            gourmetSearchURL = Constants.baseURL + apiKey + "&lat=35.68944&lng=139.69167&keyword=\(encodeSearchWord)&range=\(range)&count=50&format=json"
        }
        print(gourmetSearchURL)

        Task {
            do {
                let response = try await HotPepperAPIService.shared.request(with: gourmetSearchURL)
                if let shops = response.results.shop {
                    if shops.count == 0 {
                        present(.showAPIErrorAlert(title: "検索結果が0件です", message: ""))
                    } else {
                        DispatchQueue.main.async {
                            self.shops = shops
                        }
                    }
                } else if let error = response.results.error {
                    self.error = error
                }
            } catch {
                print("unknown: \(error.localizedDescription)")
            }
        }
    }
    
    private func checkAuthorizationStatus() {
        if locationManager.denied {
            print("test: \(locationManager.denied)")
            present(.showLocationAlert(title: "位置情報をオンにして下さい", message: "位置情報を利用して店舗検索を行います。設定から位置情報の許可をお願いします。"))
        }
    }

    @objc func handleRefreshControl() {
        fetchGourmet()
        tableView.refreshControl?.endRefreshing()
    }
}

extension ViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return shops.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCustomCell", for: indexPath) as? RestaurantCustomCell else {
            return UITableViewCell()
        }
        cell.shop = shops[indexPath.section]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let storyboard: UIStoryboard = UIStoryboard(name: "ShopDetail", bundle: nil)
        guard let shopDetailViewController = storyboard.instantiateViewController(withIdentifier: "ShopDetailViewController") as? ShopDetailViewController else { return }
        shopDetailViewController.shopDetail = shops[indexPath.section]
        self.navigationController?.pushViewController(shopDetailViewController, animated: true)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        guard let searchWord = searchBar.text, !searchWord.isEmpty else {
            return present(.emptySearchTextAlert(title: "検索欄が空白です！", message: "キーワードを入力してください。"))
        }
        self.searchWord = searchWord
        fetchGourmet()
    }
}
