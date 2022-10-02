//
//  CCRequester.swift
//  Currency
//
//  Created by Joanna Sara on 2/10/22.
//

import Foundation

public class CCRequester {
    
    private init() { }
    
    static func requestExchangeRates(baseCurrency: String, baseCurrencyValue: Double, completion: @escaping (NSDictionary, Date, Bool) -> Void) {
        let requestTime = Date()
        
        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/bd1f6d7d7449a1688a1cec16/latest/" + baseCurrency) else {
            completion(NSDictionary(), requestTime, false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler:  { (data, response, error) in
                        
            if (error != nil) {
                completion(NSDictionary(), requestTime, false)
                return
            }
            
            guard let data = data else {
                completion(NSDictionary(), requestTime, false)
                return
            }
            
            do {
                let dataJson = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? NSDictionary
                
                guard let conversionRates = dataJson?["conversion_rates"] as? NSDictionary else {
                    completion(NSDictionary(), requestTime, false)
                    return
                }
                completion(conversionRates, requestTime, true)
            } catch {
                completion(NSDictionary(), requestTime, false)
            }
        })
        
        task.resume()
    }
}
