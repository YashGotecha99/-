//
//  BaseUrl.swift
//  innopadsolutions
//
//  Created by Yash.Gotecha on 30/05/24.
//

import Foundation
import UIKit

var liveURL = "https://fakestoreapi.com/"


var serverUrl : String {
    
    return liveURL
}

class BaseUrl: NSObject {
    static let sharedInstance = BaseUrl()
    
    override init() {
    }
    
    func CreateMainUrl(optionalUrl:NSString) -> String {
        let base_url = serverUrl
        let main_url = "\(base_url )\(optionalUrl )"
        return main_url as String
    }
}
