import UIKit
import Nuke

final class ShopDetailViewController: UIViewController {
    @IBOutlet weak private var shopImageView: UIImageView!
    @IBOutlet weak private var shopNameLabel: UILabel!
    @IBOutlet weak private var genreLabel: UILabel!
    @IBOutlet weak private var budgetLabel: UILabel!
    @IBOutlet weak private var accessLabel: UILabel!
    @IBOutlet weak private var addressDetailLabel: UILabel!
    @IBOutlet weak private var accessDetailLabel: UILabel!
    @IBOutlet weak private var budgetDetailLabel: UILabel!
    @IBOutlet weak private var openDetailLabel: UILabel!
    @IBOutlet weak private var closeDetailLabel: UILabel!
    @IBOutlet weak private var cardDetailLabel: UILabel!
    @IBOutlet weak private var privateRoomDetailLabel: UILabel!
    @IBOutlet weak private var nonSmokingLabel: UILabel!
    @IBOutlet weak private var parkingDetailLabel: UILabel!
    @IBOutlet weak private var bottomView: UIView! {
        didSet {
            bottomView.layer.shadowOffset = CGSize(width: 0.0, height: -2.0)
            bottomView.layer.shadowColor = UIColor.black.cgColor
            bottomView.layer.shadowOpacity = 0.2
            bottomView.layer.shadowRadius = 10
        }
    }

    @IBAction private func reserveButton(_ sender: UIButton) {
        guard let url = URL(string: shopDetail?.urls.pc ?? "URLがありません") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

    var shopDetail: Shop? {
        didSet {
            Task { @MainActor in
                self.shopNameLabel.text = self.shopDetail?.name
                self.genreLabel.text = self.shopDetail?.genre.name
                self.budgetLabel.text = self.shopDetail?.budget.name
                self.accessLabel.text = self.shopDetail?.mobileAccess
                self.addressDetailLabel.text = self.shopDetail?.address
                self.accessDetailLabel.text = self.shopDetail?.mobileAccess
                self.budgetDetailLabel.text = self.shopDetail?.budget.name
                self.openDetailLabel.text = self.shopDetail?.open
                self.closeDetailLabel.text = self.shopDetail?.close
                self.cardDetailLabel.text = self.shopDetail?.card
                self.privateRoomDetailLabel.text = self.shopDetail?.privateRoom
                self.nonSmokingLabel.text = self.shopDetail?.nonSmoking
                self.parkingDetailLabel.text = self.shopDetail?.parking

                guard let url = URL(string: shopDetail?.photo?.pc.large ?? "画像がありません") else { return }
                let image = try await ImagePipeline.shared.image(for: url)
                self.shopImageView.image = image
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        customNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func customNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.backItem?.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
    }
}
