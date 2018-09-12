import Alamofire

class API {
    static let host = "api-endpoint.igdb.com"
}


class APIManager {

    let apiKey = APIKeyManager().apiKey(for: "igdbApiKey")
    let baseUrl = "https://\(API.host)/"
    
    func fetchPlatforms(handler: @escaping (([Platform]?) -> Void)) {
        fetch(path: "platforms/", handler: handler)
    }
    
    func fetchPlatform(id: Int, handler: @escaping ((Platform?) -> Void)) {
        fetch(path: "/platforms/\(id)", handler: handler)
    }
    
    private func fetch<T: Codable>(path: String, handler: @escaping ((T?) -> Void)) {
        guard let apiKey = apiKey else {
            assertionFailure("No API key found for igdb")
            handler(nil)
            return
        }
        let url = "\(baseUrl)\(path)?fields=*"
        print("Request url: \(url)")
        let headers: HTTPHeaders = [
            "user-key": apiKey,
            "Accept": "application/json"
        ]
        Alamofire.request(url, headers: headers).responseString { response in
            guard let jsonString = response.result.value,
                let jsonData = jsonString.data(using: .utf8) else {
                handler(nil)
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: jsonData)
                handler(result)
            } catch {
                // kind of nasty but I'll try to decode an array and return the first item if it exists
                do {
                    let result = try JSONDecoder().decode([T].self, from: jsonData)
                    handler(result[0])
                } catch {
                    print("something happened with decoding: \(error)")
                    handler(nil)
                }
            }
        }
    }
}
