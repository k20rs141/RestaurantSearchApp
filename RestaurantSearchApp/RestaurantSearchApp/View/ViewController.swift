import UIKit
import MapKit

class ViewController: UIViewController {
    let locationManager = LocationManager.shared
    var searchWord: String = ""
    var shops = [Shop]() {
        didSet {
            tableView.reloadData()
        }
    }

    @IBOutlet weak var searchText: UISearchBar!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "RestaurantCustomCell", bundle: nil), forCellReuseIdentifier: "RestaurantCustomCell")
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
    }
    
    private func fetchGourmet() {
        // 予約文字をエンコード
        guard let encodeSearchWord = searchWord.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let userLocation = locationManager.userLocation?.coordinate else { return }

        let gourmetSearchURL = Constants.baseURL + apiKey + "&lat=\(userLocation.latitude)&lng=\(userLocation.longitude)&keyword=\(encodeSearchWord)&count=30&format=json"
        
        Task {
            do {
                let response = try await HotPepperAPIService.shared.request(with: gourmetSearchURL)
                DispatchQueue.main.async {
                    if let shops = response.results.shop {
                        self.shops = shops
                    }
                }
            } catch {
                print("unknown: \(error.localizedDescription)")
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shops.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCustomCell", for: indexPath) as? RestaurantCustomCell else {
            return UITableViewCell()
        }
        cell.shop = shops[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        guard let searchWord = searchBar.text, !searchWord.isEmpty else {
            return UIAlertController.emptySearchTextAlert(self)
        }
        self.searchWord = searchWord
        fetchGourmet()
    }
}
