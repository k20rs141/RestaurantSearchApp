import Nuke
import UIKit

final class RestaurantCustomCell: UITableViewCell {
    @IBOutlet weak private var shopImageView: UIImageView!
    @IBOutlet weak private var shopNameLabel: UILabel!
    @IBOutlet weak private var genreLabel: UILabel!
    @IBOutlet weak private var budgetLabel: UILabel!
    @IBOutlet weak private var accessLabel: UILabel!

    var shop: Shop? {
        didSet {
            Task { @MainActor in
                shopNameLabel.text = shop?.name
                genreLabel.text = shop?.genre.name
                budgetLabel.text = shop?.budget.name
                accessLabel.text = shop?.mobileAccess

                guard let url = URL(string: shop?.photo?.mobile.large ?? "N/A") else { return }
                let image = try await ImagePipeline.shared.image(for: url)
                self.shopImageView.image = image
            }
        }
    }

    override func awakeFromNib() {
        super .awakeFromNib()
    }
}
