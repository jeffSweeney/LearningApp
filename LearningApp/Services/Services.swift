//
//  Services.swift
//  LearningApp
//
//  Created by Jeffrey Sweeney on 10/26/21.
//

import Foundation

class Services {
    
    // Using generics for possible reuse later in the app
    static func decodeLocalJson<T: Decodable>(filename: String) -> [T] {
        var result = [T]()
        
        // Get URL
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            // Get data at url
            do {
                let data = try Data(contentsOf: url)
                
                // Decode the data
                do {
                    let jsonDecoder = JSONDecoder()
                    result = try jsonDecoder.decode([T].self, from: data)
                } catch {
                    // Could not decode the data
                    print(error)
                }
            } catch {
                // Could not get data object from url
                print(error)
            }
        }
        
        return result
    }
    
    static func parseStyleHtml(filename: String) -> Data? {
        var result: Data?
        
        if let styleUrl = Bundle.main.url(forResource: filename, withExtension: "html") {
            do {
                result = try Data(contentsOf: styleUrl)
            } catch {
                // Could not parse style to Data object
                print(error)
            }
        }
        
        return result
    }
}
