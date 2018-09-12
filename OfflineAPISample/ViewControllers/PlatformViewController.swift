import UIKit
import AlamofireImage


class PlatformViewController: UIViewController {
    var platformId: Int?
    var platform: Platform?
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var summaryTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPlatform()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fetchPlatform() {
        guard let platformId = platformId else {
            return
        }
        let apiManager = APIManager()
        apiManager.fetchPlatform(id: platformId) { platform in
            guard let platform = platform else {
                return
            }
            self.platform = platform
            self.updateViews()
        }
    }
    
    func updateViews() {
        guard let platform = platform else {
            return
        }
        if let logoURL = platform.logo?.url {
            logoImageView.af_setImage(withURL: logoURL)
        }
        summaryTextView.text = {
            guard let summary = platform.summary else {
                return "No Summary Available"
            }
            return summary
        }()
    }

}
