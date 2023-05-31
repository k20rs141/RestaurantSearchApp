import Nuke
import UIKit

class RestaurantCustomCell: UITableViewCell {
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var accessLabel: UILabel!
    
    var shop: Shop? {
        didSet {
            Task {
                guard let url = URL(string: shop?.photo?.mobile.large ?? "N/A") else { return }
                let image = try await ImagePipeline.shared.image(for: url)
                DispatchQueue.main.async {
                    self.shopImageView.image = image
                }
            }
            shopNameLabel.text = shop?.name
            genreLabel.text = shop?.genre.name
            budgetLabel.text = shop?.budget.name
            accessLabel.text = shop?.mobileAccess
        }
    }
    
    override func awakeFromNib() {
        super .awakeFromNib()
    }
}
