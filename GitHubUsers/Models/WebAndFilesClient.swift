//
//  WebClient.swift
//  SANDBX CARS
//
//  Created by Yevgenii Pasko on 3/26/18.
//  Copyright © 2018 Yevgenii Pasko. All rights reserved.
//

import UIKit

struct WebAndFilesClient {
    
    func getRequestUsersList(urlString: String, completion: @escaping ([String:Any]?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            print("Error unwrapping URL"); return }
        guard let cachePolicy = URLRequest.CachePolicy(rawValue: 5) else {
            print("Error unwrapping cache"); return }
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: 20)
        request.httpMethod = "GET"
        performUrlRequest(request: request, completion: completion)
    }
    
    func postRequest(urlString:String, parameters: [String:Any], completion: @escaping ([String:Any]?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            print("Error unwrapping URL"); return }
        guard let cachePolicy = URLRequest.CachePolicy(rawValue: 5) else {
            print("Error unwrapping cache"); return }
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: 40)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = data
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        performUrlRequest(request: request, completion: completion)
    }
    
    private func performUrlRequest(request: URLRequest, completion: @escaping ([String:Any]?) -> Void) {
    
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            //5 - unwrap our returned data
            guard let unwrappedData = data else { print("Error getting data"); return }
            do {
                //6 - create an object for our JSON data and cast it as a NSDictionary
                // .allowFragments specifies that the json parser should allow top-level objects that aren't NSArrays or NSDictionaries.
                if let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? NSDictionary {
                    
                    //7 - create an array of dictionaries from
                    if let result = responseJSON as? [String:Any] {
                        
                        //8 - set the completion handler with our apps array of dictionaries
                        completion(result)
                    }
                }
            } catch {
                //9 - if we have an error, set our completion with nil
                completion(nil)
                print("Error getting API data: \(error.localizedDescription)")
            }
        }
        //10 -
        dataTask.resume()
    }
}
