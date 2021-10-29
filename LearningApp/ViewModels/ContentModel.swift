//
//  ContentModel.swift
//  LearningApp
//
//  Created by Jeffrey Sweeney on 10/26/21.
//

import Foundation

class ContentModel: ObservableObject {
    @Published var modules: [Module]
    
    // MARK: properties to keep track of
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    var style: Data?
    
    init() {
        modules = Services.decodeLocalJson(filename: "data")
        style = Services.parseStyleHtml(filename: "style")
    }
    
    // MARK: - Module Nav Methods
    func beginModule(_ moduleId: Int) {
        // Find index for this moduleId
        for index in 0 ..< modules.count {
            if modules[index].id == moduleId {
                currentModuleIndex = index
                break
            }
        }
        
        // Set the current module
        currentModule = modules[currentModuleIndex]
    }
}
