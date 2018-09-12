import UIKit
import OHHTTPStubs

class OfflineDataProvider {
    
    weak var stubDescriptor: OHHTTPStubsDescriptor?
    
    init() {
        stubDescriptor = stub(condition: isHost(API.host)) { request in
            guard let offlineDataPath = self.bundleDataPath(for: request.url) else {
                return OHHTTPStubsResponse(jsonObject: [], statusCode: 404, headers: nil)
            }
            return OHHTTPStubsResponse(fileAtPath: offlineDataPath, statusCode: 200, headers: nil)
        }
    }
    
    func bundleDataPath(for url: URL?) -> String? {
        guard let url = url else { return nil }
        var pathComponents = url.pathComponents
        pathComponents.removeFirst()
        pathComponents.insert("OfflineData", at: 0)
        guard let filename = pathComponents.popLast()?.components(separatedBy: ".")[0] else {
            return nil
        }
        let path = pathComponents.joined(separator: "/")
        return Bundle.main.path(forResource: filename, ofType: "json", inDirectory: path) // add .json since the API urls don't have a file extension
    }
    
    func disable() {
        guard let stubDescriptor = stubDescriptor else { return }
        OHHTTPStubs.removeStub(stubDescriptor)
    }
}
