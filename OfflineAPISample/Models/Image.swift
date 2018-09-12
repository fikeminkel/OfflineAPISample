import UIKit

struct Image: Codable {
    enum CodingKeys: String, CodingKey {
        case urlString = "url"
        case width
        case height
        case cloudinaryId = "cloudinary_id"
    }

    var url: URL? {
        return URL(string: "https:\(urlString)")
    }
    let urlString: String
    let width: Int
    let height: Int
    let cloudinaryId: String
}
