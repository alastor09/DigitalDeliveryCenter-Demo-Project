//
//  DPNetworkManager.swift
//  Digital Delivery Centre Demo Project
//
//  Created by Harshdeep Singh on 2017-02-11.
//  Copyright © 2017 Digital Delivery Centre. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class DPNetworkManager: NSObject {
    
    #if RELEASE
    static let server = "http://www.seismi.org"
    #else
    static let server = "http://www.seismi.org"
    #endif
    
    static let restServicePathFirstVersion = "/api"
    
    struct APIRoutes {
        static let earthquakes = "\(server)\(restServicePathFirstVersion)/eqs/"
    }
    
    //MARK: Shared Instance
    
    static let sharedInstance : DPNetworkManager = {
        let instance = DPNetworkManager()
        return instance
    }()
    
    
    func getEarthquakes(completionHandler:@escaping (_ response:JSON, _ error:Error?) -> Void) {
        GET(apiUrl: APIRoutes.earthquakes, completionHandler: completionHandler)
    }
    
    private func GET(apiUrl: String, completionHandler:@escaping (_ response:JSON, _ error:Error?) -> Void) {
        Alamofire.request(apiUrl, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completionHandler(JSON(value), nil)
                case .failure(let error):
                    completionHandler([], error)
                }
        }
    }

}
