//
//  NetworkLayer.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 20.03.2021.
//

import Foundation

protocol NetworkLayerProtocol {
    func retrieveEvents(completion: @escaping (Result<[Event], NSError>) -> ()) -> ()
}

final class NetworkLayer : NetworkLayerProtocol {
    
    public static var shared : NetworkLayerProtocol = NetworkLayer()
    
    private let baseURL : String = "http://146.66.200.213:8080/"
    
    private func serialize<T : Codable>(data : T) -> Any? {
        guard let data = try? JSONEncoder().encode(data),
              let serializedData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        else { return nil }
        
        return serializedData
    }
    
    private func deserialize<T : Codable>(data : Any, as objectType : T.Type) -> T? {
        guard let data = try? JSONSerialization.data(withJSONObject: data, options: []),
              let deserializedData = try? JSONDecoder().decode(objectType, from: data)
        else { return nil }
        
        return deserializedData
    }
    
    private func createDataTask(with url : URL?, completion: @escaping (Data?, URLResponse?, Error?) -> ()) -> () {
        guard let url = url else {
            print("\(#function) on \(#line) received URL which is nil")
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    public func retrieveEvents(completion: @escaping (Result<[Event], NSError>) -> ()) -> () {
        let stringURL = self.baseURL + "events/get"
        let url = URL(string: stringURL)
        
        self.createDataTask(with: url) { data, response, error in
            if let data = data {
                guard let events = self.deserialize(data: data, as: [Event].self) else { return }
                completion(.success(events))
            }
        }
    }
    
    private init() { }
}
