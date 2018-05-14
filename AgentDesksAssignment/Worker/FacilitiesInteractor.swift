//
//  FacilitiesInteractor.swift
//  AgentDesksAssignment
//
//  Created by Himanshu on 11/05/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData

class FacilitiesWorker {
    public typealias facilitiesCompletionBlock = (NSError?, [Facility]?) -> Void
//    var facilitiesArray = [Facilities]()
    static let sharedInstance = FacilitiesWorker()
    public var facilitiesArray = [Facility]()
    var exclusionsArray =  [[[String: AnyObject]]]()

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
                    let facilityArray = facilitiesDict!["facilities"] as? [[String: AnyObject]]
                    self.exclusionsArray = (facilitiesDict!["exclusions"] as? [[[String: AnyObject]]])!
                    for f in facilityArray! {
                        self.facilitiesArray.append(self.createFacilityEntityFrom(dictionary: f) as! Facility)
                    }
                    // find combinations of mutually exclusive options nc2
                    // Example: {a,b,c} -> {{a,b}, {a,c}, {b,c}}
                    // starting with {a,b}, find facility Fa with id a.Fid & Fb with id b.Fid
                    // Find option a.Oid in facility Fa , same for b
                    // Add option b.Oid as exclusion of a.Oid
                    // Do the same for {a,c}, {b,c}
                    completion(nil, self.facilitiesArray)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        dataTask.resume()
    }
    
    private func createFacilityEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        let context = DataManager.sharedInstance.getContext()
        if let facilityEntity = NSEntityDescription.insertNewObject(forEntityName: "Facility", into: context) as? Facility {
            facilityEntity.facilityId = dictionary["facility_id"] as? String
            facilityEntity.name = dictionary["name"] as? String
            if let options = dictionary["options"] as? [[String: AnyObject]] {
                for option in options {
                    facilityEntity.addToOptions((createOptionEntityFrom(dictionary: option) as! Option))
                }
            }
            return facilityEntity
        }
        return nil
    }
    
    private func createOptionEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        let context = DataManager.sharedInstance.getContext()
        if let optionEntity = NSEntityDescription.insertNewObject(forEntityName: "Option", into: context) as? Option {
            optionEntity.id = dictionary["id"] as? String
            optionEntity.name = dictionary["name"] as? String
            optionEntity.icon = dictionary["icon"] as? String
            for exclusionObjectarray in  exclusionsArray {
                let id = exclusionObjectarray[0]["options_id"] as! String
                let excludedId = exclusionObjectarray[1]["options_id"] as! String
                if id == optionEntity.id || excludedId == optionEntity.id {
                    optionEntity.addToExclusions(optionEntity)
                }
            }
            return optionEntity
        }
        return nil
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
