//
//  CCInteractor.swift
//  Currency
//
//  Created by Joanna Sara on 1/10/22.
//

import Foundation

class CCInteractor {

    func requestSupportedCurrencies(completion : @escaping ([String], Date, Bool)->Void) {
        var result : [String] = []
        let updateTime = Date()
        
        let url = URL(string: "https://v6.exchangerate-api.com/v6/bd1f6d7d7449a1688a1cec16/codes")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            
            if (error != nil) {
                print("Unable to get supported currencies")
                completion(result, updateTime, false)
                return
            }
            
            if let data = data {
                do {
                    let dataJson = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? NSDictionary
                    
                    guard let supportedCodes = dataJson?["supported_codes"] as? NSArray else {
                        completion(result, updateTime, false)
                        return
                    }
                    
                    for supportedCode in supportedCodes {
                        let code = supportedCode as? NSArray
                        result.append(code![0] as! String)
                    }
                    completion(result, updateTime, true)
                } catch {
                    print("Failed to parse supported currencies")
                    completion(result, updateTime, false)
                }
            }
        })
        
        task.resume()
    }
    
    func requestExchangeRates(baseCurrency: String, baseCurrencyValue: Double, completion : @escaping ([String:Double], Date, Bool)->Void) {
        var result : [String:Double] = [:]
        let updateTime = Date()
        
        let url = URL(string: "https://v6.exchangerate-api.com/v6/bd1f6d7d7449a1688a1cec16/latest/" + baseCurrency)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            
            if (error != nil) {
                print("Unable to get supported currencies")
                completion(result, updateTime, false)
                return
            }
            
            if let data = data {
                do {
                    let dataJson = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? NSDictionary
                    
                    guard let conversionRates = dataJson?["conversion_rates"] as? NSDictionary else {
                        completion(result, updateTime, false)
                        return
                    }
                    
                    for (key,value) in conversionRates {
                        result[key as! String] = value as! Double * baseCurrencyValue
                    }
                    completion(result, updateTime, true)
                } catch {
                    print("Failed to parse supported currencies")
                    completion(result, updateTime, false)
                }
            }
        })
        
        task.resume()
    }
}
