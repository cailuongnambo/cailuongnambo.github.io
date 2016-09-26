//
//  ForumClient.swift
//  voz4rum ios
//
//  Created by BAULOC on 7/15/16.
//  Copyright © 2016 BAU LOC. All rights reserved.
//

import UIKit


class ForumClient: NSObject {
    
    class func getTopicPage( url:String, completion: (result: AnyObject?, httpCode: Int, error: NSError!) -> Void) {
        
        HTTPRequest.GET_STRING( url ) { (result, httpCode, error) in
            
            if result != nil && httpCode == 200 {
                
                let record = ParseAllRecord.parseTopicRecord(result!)
                
                print(record)
                
                completion(result: record, httpCode: httpCode, error: nil)
                
            } else {
                completion(result: nil, httpCode: httpCode, error: error)
            }
        }
    }
    
    class func getSubIndexPage( url:String, completion: (result: AnyObject?, httpCode: Int, error: NSError!) -> Void) {
        
        HTTPRequest.GET_STRING( url ) { (result, httpCode, error) in
            
            if result != nil && httpCode == 200 {
                
                let record = ParseAllRecord.parseSubIndexRecord(result!)
                
                print(record)
                
                completion(result: record, httpCode: httpCode, error: nil)
                
            } else {
                completion(result: nil, httpCode: httpCode, error: error)
            }
        }
    }

    class func getIndexPage( completion: (result: AnyObject?, httpCode: Int, error: NSError!) -> Void) {
                
        let url = FORUM_URL + URI_INDEX
        
        HTTPRequest.GET_STRING(url) { (result, httpCode, error) in
            
            if result != nil && httpCode == 200 {
                
                let record = ParseAllRecord.parseIndexRecord(result!)
                
                print(record)
                
                completion(result: record, httpCode: httpCode, error: nil)
                
            } else {
                completion(result: nil, httpCode: httpCode, error: error)
            }
        }        
    }
    
}
