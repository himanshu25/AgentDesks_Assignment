//
//  FacilitiesInteractor.swift
//  AgentDesksAssignment
//
//  Created by Himanshu on 11/05/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//

import Foundation
import Alamofire

class FacilitiesWorker {
    
    static let sharedInstance = FacilitiesWorker()

    // Use it if you want to use Alamofire
    func getFacilities() {
        request(url: "https://my-json-server.typicode.com/iranjith4/ad-assignment/db", type: .get) { (error, array) in
            
        }
    }
    
    func getAllFacilities(with completion: @escaping facilitiesCompletionBlock) {
        let dataTask = session().dataTask(with: urlRequest()) { (data, response, error) in
            if let data = data {
                do {
                    let facilitiesJson = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                    let facilitiesDict = facilitiesJson as? [String: AnyObject]
                    print(facilitiesDict)
                    completion(nil, [""])
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        dataTask.resume()
    }
    
    func urlRequest() -> URLRequest {
        let url: URL = URL(string: "https://my-json-server.typicode.com/iranjith4/ad-assignment/db")!
        return URLRequest(url: url)
    }
    
    func session() -> URLSession {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }
    
}
