import UIKit

class PlatformsViewController: UIViewController {

    
    @IBOutlet weak var loadPlatformsButton: UIButton!
    @IBOutlet weak var platformsTableView: UITableView!
    
    var platforms: [Platform]?
    var selectedPlatform: Platform?
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
    }

    // This extends the superclass.
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        platformsTableView.dataSource = self
        platformsTableView.delegate = self
        
        loadPlatformsButton.addTarget(self, action: #selector(self.loadPlatformsTapped(_:)), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func loadPlatformsTapped(_ sender: Any) {
        // in a real-world application I wouldn't call APIManager directly.
        // I'd use a PlatformsViewModel to get the data and transform it to what the VC needs.
        let apiManager = APIManager()
        apiManager.fetchPlatforms { platforms in
            self.platforms = platforms
            self.platformsTableView.reloadData()
        }
    }
    
    func presentPlatformViewController() {
        let platformVC = PlatformViewController(nibName: "PlatformViewController", bundle: nil)
        // we could pass the entire platform object here but I want to simulate multiple API calls
        platformVC.platformId = selectedPlatform?.id
        navigationController?.pushViewController(platformVC, animated: true)
    }
}

extension PlatformsViewController: UITableViewDataSource, UITableViewDelegate {
    var numPlatforms: Int {
        guard let platforms = platforms else {
            return 0
        }
        return platforms.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numPlatforms
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell?
        guard let label = cell?.contentView.subviews[0] as? UILabel else {
            return cell!
        }
        guard let platform = platforms?[indexPath.row] else {
            return cell!
        }
        label.text = platform.name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let platforms = platforms, platforms.count > indexPath.row else {
            return
        }
        self.selectedPlatform = platforms[indexPath.row]
        presentPlatformViewController()
    }
}
