
//
//  File.swift
//  AgentDesksAssignment
//
//  Created by Himanshu on 11/05/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//

import Foundation
import Alamofire

extension FacilityWorker {
    
    func request(url: String, type: HTTPMethod, with completion: @escaping facilitiesCompletionBlock) {
        Alamofire.request(url, method: type).responseJSON { response in
            response.result.ifSuccess {
                DispatchQueue.main.async {
                    let responseResult = response.result
                    guard let resultsDictionary = responseResult.value as? [String: AnyObject], let facilities = resultsDictionary["facilities"] as? [[String: AnyObject]] else {return}
                }
                completion(nil, self.facilitiesArray)
            }
            response.result.ifFailure {
                DispatchQueue.main.async {
                    let _ = response.response?.statusCode ?? 0
                    completion(nil, nil)
                }
            }
        }
    }
}
