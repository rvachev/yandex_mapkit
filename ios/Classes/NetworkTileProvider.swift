//
//  NetworkTileProvider.swift
//  yandex_mapkit
//
//  Created by Роман Рвачев on 22.03.2023.
//

import Foundation
import YandexMapsMobile

public class NetworkTileProvider: NSObject, YMKTileProvider {
    private let baseUrl: String
    private let headers: [String: String]
    
    public required init(baseUrl: String, headers: [String : String]) {
        self.baseUrl = baseUrl
        self.headers = headers
    }
    
    public func getBaseUrl() -> String {
        return baseUrl
    }
    
    public func load(with tileId: YMKTileId, version: YMKVersion, etag: String) -> YMKRawTile {
        let formattedUrl = baseUrl.replacingOccurrences(of: "{x}", with: String(tileId.x)).replacingOccurrences(of: "{y}", with: String(tileId.y)).replacingOccurrences(of: "{z}", with: String(tileId.z + 1))
        let url = URL(string: formattedUrl)
        let data = downloadFile(url: url)
        return YMKRawTile(version: version, etag: etag, state: YMKRawTileState.ok, rawData: data)
    }
    
    private func downloadFile(url: URL?) -> Data {
        var request = URLRequest(url: url!)
        var receivedData = Data()
        request.httpMethod = "GET"
        for header in headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        let group = DispatchGroup()
        group.enter()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                return
            }
            guard let data = data else {return}
            receivedData = data
            group.leave()
        }
        task.resume()
        group.wait()
        return receivedData
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object else { return false }
        
        guard let rightChild = object as? NetworkTileProvider else { return false }
        
        if self === rightChild {
            return true
        }
        
        return baseUrl == rightChild.baseUrl && headers == rightChild.headers
    }
    
    public override var hash: Int {
        return baseUrl.hash ^ headers.hashValue
    }
}
