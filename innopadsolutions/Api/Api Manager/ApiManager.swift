//
//  ApiManager.swift
//  innopadsolutions
//
//  Created by Yash.Gotecha on 30/05/24.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD

public typealias parameters = [String: Any]

struct ErrorMessage {
    static let somethingWentWrong = "Something went wrong."
}

class ApiManager:NSObject{
    static let shared = ApiManager()
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
 
    fileprivate func printAPI_Before(strURL:String = "", parameters:[String:Any] = [:], headers: HTTPHeaders = [:]) {
        var str = "\(parameters)"
        str = str.replacingOccurrences(of: " = ", with: ":")
        str = str.replacingOccurrences(of: "\"", with: "")
        str = str.replacingOccurrences(of: ";", with: "")
        print("APi - \(strURL)\nParameters - \(str)\nHeaders - \(headers)")
    }
    
    fileprivate func printAPI_After(response :AFDataResponse<Any>) {
        if let value = response.value {
            print("result.value: \(value)") // result of response serialization
        }
        if let error = response.error {
            print("result.error: \(error)") // result of response serialization
        }
    }
    func fetch<T:Decodable>(type:T.Type, httpMethod:HTTPMethod,api:String = "",parameters : [String:Any]?,isAuthorization: Bool,completionHandler : @escaping (Bool, T?,[String:Any]) -> Void){
        SVProgressHUD.show()
        var strUrl = String()
        strUrl = BaseUrl.sharedInstance.CreateMainUrl(optionalUrl: api as NSString)
        
        let headers : HTTPHeaders = []
        
//        var parameter = parameters
//        if httpMethod == .get {
//            parameter = nil
//        }
        
        ApiManager.shared.printAPI_Before(strURL: strUrl, parameters: parameters ?? [:], headers: headers)
        
//        let request = AF.request(strUrl, method: httpMethod, parameters: parameter, encoding: JSONEncoding.default, headers: headers)
        
        let request = AF.request(strUrl, method: httpMethod, parameters: parameters, encoding:  URLEncoding.default, headers: headers)
        
        print("request body: \(request.convertible.urlRequest?.url)")

        request.responseJSON {
            response in
            SVProgressHUD.dismiss()
            switch response.result {
            case .success:
//                print(response)
                if response.response?.statusCode == 200 {
                    if response.value != nil {
                        if let dicValue = response.value as? [String: Any] {
                            if let statusCode = response.response?.statusCode as? Int {
                                print(statusCode)
                                if statusCode == 200 {
                                    do {
                                        if let data = response.data{
                                            let value = try JSONDecoder().decode(type.self, from: data)
                                            completionHandler(true,value, response.value as? [String: Any] ?? [:])
                                        }
                                    }catch let error as NSError{
                                        print(error)
                                       self.AlertOnWindow(message: error.localizedDescription)
                                    }
                                }
                                else {
                                    self.AlertOnWindow(message: dicValue["message"] as? String ?? ErrorMessage.somethingWentWrong)
                                }
                            }
                        }
                    }
                }
                else {
//                    if let dicValue = response.value as? [String: Any] {
//                        do {
//                            if let data = response.data{
//                                let value = try JSONDecoder().decode(type.self, from: data)
//                                completionHandler(true,value, response.value as? [String: Any] ?? [:])
//                            }
//                        }catch let error as NSError{
//                            print(error)
//                           self.AlertOnWindow(message: error.localizedDescription)
//                        }
////                        self.AlertOnWindow(message: dicValue["message"] as? String ?? ErrorMessage.somethingWentWrong)
//
//                    }else{
//                        self.AlertOnWindow(message: ErrorMessage.somethingWentWrong)
//
//                    }
                    // New Code
                    if let dicValue = response.value as? [String: Any] {
                        if let error = dicValue["error"] {
                            self.AlertOnWindow(message: error as? String ?? ErrorMessage.somethingWentWrong)
                        }
                        else if let errors = dicValue["errors"] as? [String: Any]  {
                            if let error = errors["error"] as? [String: Any] {
                                self.AlertOnWindow(message: errors["message"] as? String ?? ErrorMessage.somethingWentWrong)
                            } else{
                                self.AlertOnWindow(message: (errors["error"] as? String ?? dicValue["message"] as? String) ?? ErrorMessage.somethingWentWrong)
                            }
                        }
                        else {
                            self.AlertOnWindow(message: dicValue["message"] as? String ?? ErrorMessage.somethingWentWrong)
                        }
                    }else{
                        self.AlertOnWindow(message: ErrorMessage.somethingWentWrong)
                        
                    }
                    //..
                }
                break
            case .failure(let error):
                completionHandler(false,nil,[:])
                self.AlertOnWindow(message: error.localizedDescription)
                
            }
        }
    }
    
    func fetchforProduct<T:Decodable>(type:T.Type, httpMethod:HTTPMethod,api:String = "",parameters : [String:Any]?,completionHandler : @escaping (Bool, T?) -> Void){
        SVProgressHUD.show()
        var strUrl = String()
        strUrl = BaseUrl.sharedInstance.CreateMainUrl(optionalUrl: api as NSString)
        
        let headers : HTTPHeaders = []
        
        ApiManager.shared.printAPI_Before(strURL: strUrl, parameters: parameters ?? [:], headers: headers)
       
       let request = AF.request(strUrl, method: httpMethod, parameters: parameters, encoding:  URLEncoding.default, headers: headers)
        
        print("request body: \(request.convertible.urlRequest?.url)")

        request.responseJSON {
            response in
            SVProgressHUD.dismiss()
            switch response.result {
            case .success:
                print(response)
                if response.response?.statusCode == 200 {
                    if response.value != nil {
                      //  if let dicValue = response.value as? [String: Any] {
                           // if let statusCode = response.response?.statusCode as? Int {
                              //  print(statusCode)
                                if response.response?.statusCode == 200 {
                                    do {
                                      //  let courses = try JSONDecoder().decode([Course].self, from: data)

                                        if let data = response.data{
                                            let value = try JSONDecoder().decode(type.self, from: data)
                                            completionHandler(true,value)
                                        }
                                    }catch let error as NSError{
                                        print(error)
                                       self.AlertOnWindow(message: error.localizedDescription)
                                        
                                    }
                                }
                                else {
                                  //  self.AlertOnWindow(message: dicValue["message"] as? String ?? ErrorMessage.somethingWentWrong)
                                    
                                }
                        //    }
                  //      }
                    }
                }
                else {
//                    if let dicValue = response.value as? [String: Any] {
//                        self.AlertOnWindow(message: dicValue["message"] as? String ?? ErrorMessage.somethingWentWrong)
//
//                    }else{
//                        self.AlertOnWindow(message: ErrorMessage.somethingWentWrong)
//
//                    }
                    
                    // New Code
                    if let dicValue = response.value as? [String: Any] {
                        if let error = dicValue["error"] {
                            self.AlertOnWindow(message: error as? String ?? ErrorMessage.somethingWentWrong)
                        }
                        else if let errors = dicValue["errors"] as? [String: Any]  {
                            if let error = errors["error"] as? [String: Any] {
                                self.AlertOnWindow(message: errors["message"] as? String ?? ErrorMessage.somethingWentWrong)
                            } else{
                                self.AlertOnWindow(message: (errors["error"] as? String ?? dicValue["message"] as? String) ?? ErrorMessage.somethingWentWrong)
                            }
                        }
                        else {
                            self.AlertOnWindow(message: dicValue["message"] as? String ?? ErrorMessage.somethingWentWrong)
                        }
                    }else{
                        self.AlertOnWindow(message: ErrorMessage.somethingWentWrong)
                        
                    }
                    //..
                }
                break
            case .failure(let error):
                completionHandler(false,nil)
                self.AlertOnWindow(message: error.localizedDescription)
                
            }
        }
    }
    
    func AlertOnWindow(message: String) {
        let alert = UIAlertController(title: "Alert!!", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        if let topvc = UIApplication.topMostViewController{
            topvc.present(alert, animated: true, completion: nil)
        }
    }
}


