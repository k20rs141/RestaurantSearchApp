import UIKit
import Nuke

class ShopDetailViewController: UIViewController {
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var accessLabel: UILabel!

    @IBOutlet weak var addressDetailLabel: UILabel!
    @IBOutlet weak var accessDetailLabel: UILabel!
    @IBOutlet weak var budgetDetailLabel: UILabel!
    @IBOutlet weak var openDetailLabel: UILabel!
    @IBOutlet weak var closeDetailLabel: UILabel!
    @IBOutlet weak var cardDetailLabel: UILabel!
    @IBOutlet weak var privateRoomDetailLabel: UILabel!
    @IBOutlet weak var nonSmokingLabel: UILabel!
    @IBOutlet weak var parkingDetailLabel: UILabel!

    @IBOutlet weak var bottomView: UIView! {
        didSet {
            bottomView.layer.shadowOffset = CGSize(width: 0.0, height: -2.0)
            bottomView.layer.shadowColor = UIColor.black.cgColor
            bottomView.layer.shadowOpacity = 0.2
            bottomView.layer.shadowRadius = 10
        }
    }
    @IBAction func reserveButton(_ sender: UIButton) {
        guard let url = URL(string: shopDetail?.urls.pc ?? "URLがありません") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

    var shopDetail: Shop? {
        didSet {
            Task {
                guard let url = URL(string: shopDetail?.photo?.pc.large ?? "画像がありません") else { return }
                let image = try await ImagePipeline.shared.image(for: url)
                DispatchQueue.main.async {
                    self.shopImageView.image = image
                    self.shopNameLabel.text = self.shopDetail?.name
                    self.genreLabel.text = self.shopDetail?.genre.name
                    self.budgetLabel.text = self.shopDetail?.budget.name
                    self.accessLabel.text = self.shopDetail?.address
                    self.addressDetailLabel.text = self.shopDetail?.address
                    self.accessDetailLabel.text = self.shopDetail?.mobileAccess
                    self.budgetDetailLabel.text = self.shopDetail?.budget.name
                    self.openDetailLabel.text = self.shopDetail?.open
                    self.closeDetailLabel.text = self.shopDetail?.close
                    self.cardDetailLabel.text = self.shopDetail?.card
                    self.privateRoomDetailLabel.text = self.shopDetail?.privateRoom
                    self.nonSmokingLabel.text = self.shopDetail?.nonSmoking
                    self.parkingDetailLabel.text = self.shopDetail?.parking
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.backItem?.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

}
