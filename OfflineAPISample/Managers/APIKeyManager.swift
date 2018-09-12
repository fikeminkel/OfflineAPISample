import UIKit

class APIKeyManager {
    let keys: [String: Any?]
    init() {
        let path = Bundle.main.path(forResource: "Keys", ofType: "plist")!
        keys = NSDictionary(contentsOfFile: path) as! [String: Any]
    }
    
    func apiKey(for key: String) -> String? {
        return keys[key] as? String
    }
}
