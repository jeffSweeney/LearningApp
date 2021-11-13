//
//  Services.swift
//  LearningApp
//
//  Created by Jeffrey Sweeney on 10/26/21.
//

import Foundation
import SwiftUI

class Services {
    
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
