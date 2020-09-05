//
//  NetworkCallManager.swift
//  Last Search
//
//  Created by Ramcharan Reddy Gaddam on 05/09/20.
//  Copyright © 2020 Ramcharan. All rights reserved.
//

import Foundation
import Alamofire

/*
 The network manager decouple the network layer framework we used. We can also use our own URLSession utility.
 */

class NetworkCallManager {
    
    static let shared = NetworkCallManager()
    
    private init() {
        
    }
    
    func getCall(withURL url: String, urlParams: [String:String] = [:], completion: @escaping (_ data: Data) -> Void) {
        var urlCom = URLComponents(string: url)
        var tempQueryItems = [URLQueryItem]()
        for (key,val) in urlParams {
            tempQueryItems.append(URLQueryItem(name: key, value: val))
        }
        urlCom?.queryItems = tempQueryItems
        AF.request((urlCom?.url!)!).response { (response) in
            if let error = response.error {
                debugPrint(error.localizedDescription)
            } else {
                guard let data = response.data else {
                    return
                }
                debugPrint(response)
                completion(data)
            }
        }
    }
    
    // TODO: - to be implemented if it is required in future
    func postCall() {
        
    }
    
}
