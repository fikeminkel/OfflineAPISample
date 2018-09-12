import UIKit

struct Platform: Codable {
    let id: Int
    let slug: String
    let name: String
    let url: URL
    let logo: Image?
    let summary: String?
}

