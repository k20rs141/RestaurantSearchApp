import UIKit

extension UIAlertController {
    static func makeAPIErrorAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { action in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        return alert
    }

    static func makeLocationAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "'設定'を開く", style: .default, handler: { action in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }))
        alert.addAction(UIAlertAction(title: "位置情報サービスをオフのままにする", style: .default, handler: nil))
        return alert
    }
}

extension UIViewController {
    func present(_ alert: UIAlertController, completion: (() -> Void)? = nil) {
       present(alert, animated: true, completion: completion)
   }
}
