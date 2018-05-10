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

    func getFacilities() {
        request(url: "https://my-json-server.typicode.com/iranjith4/ad-assignment/db", type: .get) { (error, array) in
            
        }
    }
    
    func getAllFacilities(with completion: @escaping facilitiesCompletionBlock) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url: URL = URL(string: "https://my-json-server.typicode.com/iranjith4/ad-assignment/db")!
        let request = URLRequest(url: url)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let facilitiesJson = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                    let facilitiesDict = facilitiesJson as? [String: AnyObject]
                    completion(nil, [""])
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        dataTask.resume()
    }
}
