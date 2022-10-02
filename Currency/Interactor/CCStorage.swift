//
//  Storage.swift
//  Currency
//
//  Created by Joanna Sara on 2/10/22.
//

import Foundation

public class CCStorage {
    
    fileprivate init() { }

    static fileprivate func getURL() -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Failed to create URL")
        }
    }

    static func saveModel(_ model: CCModel) {
        let url = getURL().appendingPathComponent("model", isDirectory: false)
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(model)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    static func getModel() -> CCModel {
        let url = getURL().appendingPathComponent("model", isDirectory: false)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            print("Model does not exist! Creating new...")
            return CCModel()
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(CCModel.self, from: data)
                return model
            } catch {
                print(error.localizedDescription)
                return CCModel()
            }
        } else {
            print("No data at \(url.path)!")
            return CCModel()
        }
    }
}
