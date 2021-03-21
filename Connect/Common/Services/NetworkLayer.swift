//
//  NetworkLayer.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 20.03.2021.
//

import Foundation
import CoreLocation
import MapboxGeocoder

protocol NetworkLayerProtocol {
    func retrieveCities(completion: @escaping (Result<[String], NSError>) -> ()) -> ()
    func retrieveTags(completion: @escaping (Result<[Tag], NSError>) -> ()) -> () 
    func retrieveEvents(with body : EventRequest, completion: @escaping (Result<[Event], NSError>) -> ())
}

final class NetworkLayer : NetworkLayerProtocol {
    
    public static var shared : NetworkLayerProtocol = NetworkLayer()
    
    private let baseURL : String = "http://146.66.200.213:8080/"
    
    private func serialize<T : Codable>(data : T) -> Data? {
        guard let data = try? JSONEncoder().encode(data) else { return nil }
        return data
    }
    
    private func serialize(data : [String : Any?]) -> Data? {
        return try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
    }
    
    private func deserialize<T : Codable>(data : Data, as objectType : T.Type) -> T? {
        guard let deserializedData = try? JSONDecoder().decode(objectType, from: data) else { return nil }
        return deserializedData
    }
    
    private func createDataTask(with url : URL?, completion: @escaping (Data?, URLResponse?, Error?) -> ()) -> () {
        guard let url = url else {
            print("\(#function) on \(#line) received URL which is nil")
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func createDataTask(with request : URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> ()) -> () {
        URLSession.shared.dataTask(with: request, completionHandler: completion).resume()
    }
    
    private func url(with route : String) -> URL? {
        return URL(string: self.baseURL + route)
    }
    
    public func retrieveCities(completion: @escaping (Result<[String], NSError>) -> ()) -> () {
        self.createDataTask(with: self.url(with: "events/cities/get")) { data, response, error in
            if let data = data {
                guard let cities = self.deserialize(data: data, as: [String].self) else { return }
                
                DispatchQueue.main.async {
                    completion(.success(cities))
                }
            }
        }
    }
    
    public func retrieveTags(completion: @escaping (Result<[Tag], NSError>) -> ()) -> () {
        self.createDataTask(with: self.url(with: "tags/get")) { data, response, error in
            if let data = data {
                guard let tags = self.deserialize(data: data, as: [Tag].self) else { return }
                
                DispatchQueue.main.async {
                    completion(.success(tags))
                }
            }
        }
    }
    
    public func retrieveEvents(with body : EventRequest, completion: @escaping (Result<[Event], NSError>) -> ()) {
        guard let url = self.url(with: "events/get"),
              let requestBody = self.serialize(data: body)
        else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = requestBody
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        self.createDataTask(with: request) { data, response, error in
            if let data = data {
                guard let events = self.deserialize(data: data, as: [Event].self) else { return }
                
                DispatchQueue.main.async {
                    completion(.success(events))
                }
            }
        }
    }
    
    private init() { }
}
