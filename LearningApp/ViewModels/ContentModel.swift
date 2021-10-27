//
//  ContentModel.swift
//  LearningApp
//
//  Created by Jeffrey Sweeney on 10/26/21.
//

import Foundation

class ContentModel: ObservableObject {
    @Published var modules: [Module]
    var style: Data?
    
    init() {
        modules = Services.decodeLocalJson(filename: "data")
        style = Services.parseStyleHtml(filename: "style")
    }
}
