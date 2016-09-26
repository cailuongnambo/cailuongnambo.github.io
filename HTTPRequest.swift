//
//  HTTPRequest.swift
//  voz4rum ios
//
//  Created by BAULOC on 7/15/16.
//  Copyright © 2016 BAU LOC. All rights reserved.
//

import UIKit
import Alamofire

typealias CompletionBlock = String? -> Void
typealias onCompleteBlock = (result: AnyObject , httpCode: Int, errorCode: Int) -> ()

var alamoFireManager = Alamofire.Manager.sharedInstance

var internet_type = "WIFI"

class HTTPRequest: NSObject {
    
    class func startMonitorNetwork() {
        
        //        var alamoFireManager = Alamofire.Manager.sharedInstance
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest     = 20 // seconds
        configuration.timeoutIntervalForResource    = 20
        
        alamoFireManager = Alamofire.Manager(configuration: configuration)
        
        let manager = NetworkReachabilityManager(host: "www.apple.com")
        
        manager?.listener = { status in
            //print("Network Status Changed: \(status)")
            
            switch status {
            case .NotReachable:
                internet_type = "NO-INTERNET"
                break
            case .Reachable(NetworkReachabilityManager.ConnectionType.WWAN):
                internet_type = "WIFI"
                break
            case .Reachable(NetworkReachabilityManager.ConnectionType.EthernetOrWiFi):
                internet_type = "WIFI"
                break
            default:
                // 3G
                internet_type = "3G"
                
                break
            }
        }
        manager?.startListening()
    }
    
    class func GET_JSON(input: String, params: [String:AnyObject]?, headers: [String:String]?, completion: (result: AnyObject?, httpCode: Int, error: NSError!) -> Void) {
        
        let url = input.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        alamoFireManager.request( .GET, url!, parameters: params, headers: headers )
            .responseJSON(completionHandler: {response in
                
                //print(response.request)
                
                llog("")
                llog(response.request)
                
                switch(response.result) {
                case .Success(let JSON):
                    //                    print("JSON: \(JSON) ")
                    completion(result: JSON, httpCode:(response.response?.statusCode)!, error: nil)
                    break
                    
                case .Failure(let error):
                    print(error.localizedDescription)
                    completion(result: nil, httpCode:0, error: error)
                    break
                }
            })
    }
    
    class func POST_STRING(input: String, params: [String:AnyObject]?, headers: [String:String]?, completion: (result: AnyObject?, httpCode: Int, error: NSError!) -> Void) {
        
        let url = input.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        alamoFireManager.request( .POST, url!, parameters: params, encoding: .JSON, headers: headers )
            .responseString { response in
                if response.response != nil  {
                    completion(result: response.result.value, httpCode: (response.response?.statusCode)!, error: nil )
                } else {
                    completion(result: "", httpCode: -1, error: response.result.error)
                }
        }
    }
    
    class func POST(input: String, params: [String:AnyObject]?, headers: [String:String]?, completion: (result: AnyObject?, httpCode: Int, error: NSError!) -> Void) {
        
        let url = input.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        alamoFireManager.request( .POST, url!, parameters: params, encoding: .JSON, headers: headers )
            
            .responseJSON(completionHandler: {response in
                //print("json json")
                
                llog("")
                llog(response.request)
                
                //print(response.request)
                
                switch(response.result) {
                case .Success(let JSON):
                    //                    print("JSON: \(JSON) ")
                    completion(result: JSON, httpCode:(response.response?.statusCode)!, error: nil)
                    break
                    
                case .Failure(let error):
                    print(error.localizedDescription)
                    completion(result: nil, httpCode:error.code , error: error)
                    break
                }
            })
    }
    
    class func DELETE(input: String, params: [String:AnyObject]?, headers: [String:String]?, completion: (result: AnyObject?, httpCode: Int, error: NSError!) -> Void) {
        
        let url = input.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        
        alamoFireManager.request( .DELETE, url!, parameters: params, encoding: .JSON, headers: headers )
            .responseJSON(completionHandler: {response in
                
                llog(response.request)
                llog("")
                
                //print(response.request)
                
                switch(response.result) {
                case .Success(let JSON):
                    //                    print("JSON: \(JSON) ")
                    completion(result: JSON, httpCode:(response.response?.statusCode)!, error: nil)
                    break
                    
                case .Failure(let error):
                    print(error.localizedDescription)
                    completion(result: nil, httpCode:0, error: error)
                    break
                }
            })
    }
    
    class func GET_STRING(input: String, completion: (result: String?, httpCode: Int, error: NSError!) -> Void) {
        
        alamoFireManager.request(.GET, input)
            
            .responseString { response in
//                print("Success: \(response.result.isSuccess)")
//                print("Response String: \(response.result.value)")
                
                completion(result: response.result.value , httpCode: (response.response?.statusCode)!, error: nil)
            }
            
//            .responseData { response in
//                print(response.request)
//                print(response.response)
//                print(response.result)
//            }
//            
//            .response { request, response, data, error in
//                print(request)
//                print(response)
//                print(error)
//                print(data)
//                print(response.)
                
//                if response != nil  {
//                    
//                    completion(result: data, httpCode: (response.response?.statusCode)!, error: nil )
//                } else {
//                    completion(result: "", httpCode: -1, error: response.result.error)
//                }
                
//            }
            
//            .responseString { response in
//                
//                //print(response.request) // print api url request
//                llog(response.request)
//                llog("")
//                
//                
//                if response.response != nil  {
//                    
//                    completion(result: response.result.value, httpCode: (response.response?.statusCode)!, error: nil )
//                } else {
//                    completion(result: "", httpCode: -1, error: response.result.error)
//                }
        
        //}
    }
}