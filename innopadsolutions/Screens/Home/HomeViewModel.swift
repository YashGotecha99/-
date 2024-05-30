//
//  HomeViewModel.swift
//  innopadsolutions
//
//  Created by Yash.Gotecha on 30/05/24.
//

import Foundation
import Alamofire

class HomeViewModel: NSObject {
    
    static let shared = HomeViewModel()
    
    func getAllProductsApi(completion:@escaping ([Products]) -> Void){

        ApiManager.shared.fetchforProduct(type: [Products].self, httpMethod: .get, api: "products", parameters: nil) { success, result  in
            if success{
                guard let result = result else {return}
                completion(result)
            }
        }
    }
}
