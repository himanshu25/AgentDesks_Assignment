
//
//  File.swift
//  AgentDesksAssignment
//
//  Created by Himanshu on 11/05/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//

import Foundation
import Alamofire

extension FacilitiesWorker {
    public typealias facilitiesCompletionBlock = (NSError?, [String]?) -> Void

    
    func request(url: String, type: HTTPMethod, with completion: @escaping facilitiesCompletionBlock) {
        Alamofire.request(url, method: type).responseJSON { response in
            response.result.ifSuccess {
                DispatchQueue.main.async {
                    let responseResult = response.result
                    guard let resultsDictionary = responseResult.value as? [String: AnyObject], let facilities = resultsDictionary["facilities"] as? [[String: AnyObject]] else {return}
                    for facility in facilities {
                        print(facility)
                    }
                }
                completion(nil, [""])
            }
            response.result.ifFailure {
                DispatchQueue.main.async {
                    let code = response.response?.statusCode ?? 0
                    completion(nil, nil)
                }
            }
        }
    }
}