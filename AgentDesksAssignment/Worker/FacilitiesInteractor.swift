//
//  FacilitiesInteractor.swift
//  AgentDesksAssignment
//
//  Created by Himanshu on 11/05/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//

import Foundation
import Alamofire

class FacilityWorker {
    public typealias facilitiesCompletionBlock = (NSError?, [Facility]?) -> Void
    static let sharedInstance = FacilityWorker()
    public var facilitiesArray = [Facility]()
    var exclusionsArray =  [[[String: AnyObject]]]()
    
    fileprivate var urlRequest: URLRequest {
        let url: URL = URL(string: "https://my-json-server.typicode.com/iranjith4/ad-assignment/db")!
        return URLRequest(url: url)
    }
    
    fileprivate var session: URLSession {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }
    
    // Use it if you want to use Alamofire
    func getFacilities() {
        request(url: "https://my-json-server.typicode.com/iranjith4/ad-assignment/db", type: .get) { (error, array) in
            
        }
    }
    
    func getAllFacilities(with completion: @escaping facilitiesCompletionBlock) {
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                do {
                    let facilitiesJson = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                    let facilitiesDict = facilitiesJson as? [String: AnyObject]
                    let facilityArray = facilitiesDict!["facilities"] as? [[String: AnyObject]]
                    // CoreDataStack.sharedInstance.clearData()
                    DataManager.sharedInstance.saveFacilityInCoreDataWith(array: facilityArray!)
//                    for facility in facilityArray! {
//                        if let options = facility["options"] as? [[String: AnyObject]] {
//                            for option in options {
//                                DataManager.sharedInstance.saveOptionInCoreDataWith(array: options)
//                            }
//                        }
//                    }
                    self.exclusionsArray = (facilitiesDict!["exclusions"] as? [[[String: AnyObject]]])!
                    DataManager.sharedInstance.exclusionsArray = self.exclusionsArray
                    for f in facilityArray! {
                        self.facilitiesArray.append(DataManager.sharedInstance.createFacility(dictionary: f) as! Facility)
                    }
                    // find combinations of mutually exclusive options nc2
                    // Example: {a,b,c} -> {{a,b}, {a,c}, {b,c}}
                    // starting with {a,b}, find facility Fa with id a.Fid & Fb with id b.Fid
                    // Find option a.Oid in facility Fa , same for b
                    // Add option b.Oid as exclusion of a.Oid
                    // Do the same for {a,c}, {b,c}
                    for fac in self.facilitiesArray {
                        for opt in fac.options! {
                            for exclusionObjectarray in self.exclusionsArray  {
                                let id = exclusionObjectarray[0]["options_id"] as! String
                                let excludedId = exclusionObjectarray[1]["options_id"] as! String
                                if id == (opt as! Option).id || excludedId == (opt as! Option).id {
                                    (opt as! Option).addToExclusions(DataManager.sharedInstance.createExclusion(dictionary: exclusionObjectarray[1]) as! Option)
                                    (opt as! Option).addToExclusions(DataManager.sharedInstance.createExclusion(dictionary: exclusionObjectarray[0]) as! Option)
                                }
                            }
                        }
                    }
                    completion(nil, self.facilitiesArray)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            else {
                print("error")
            }
        }
        dataTask.resume()
    }
    
}
