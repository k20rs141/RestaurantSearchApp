import Nuke
import UIKit

final class RestaurantCustomCell: UITableViewCell {
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var accessLabel: UILabel!

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
