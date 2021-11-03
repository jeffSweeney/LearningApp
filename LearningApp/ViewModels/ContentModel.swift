//
//  ContentModel.swift
//  LearningApp
//
//  Created by Jeffrey Sweeney on 10/26/21.
//

import Foundation

class ContentModel: ObservableObject {
    @Published var modules: [Module]
    
    // Current lesson explanation
    @Published var lessonDescription = NSAttributedString()
    var styleData: Data?
    
    // MARK: properties to keep track of
    // Current Module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    // Current Lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    init() {
        modules = Services.decodeLocalJson(filename: "data")
        styleData = Services.parseStyleHtml(filename: "style")
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
    
    // MARK: - Lesson Nav Methods
    func beginLesson(_ lessonIndex: Int) {
        let lessons = currentModule!.content.lessons
        
        currentLessonIndex = lessonIndex < lessons.count ? lessonIndex : 0
        currentLesson = lessons[currentLessonIndex]
        lessonDescription = addStyling(currentLesson!.explanation)
    }
    
    func advanceLesson() {
        // Advance lesson index
        currentLessonIndex += 1
        
        // Still in range?
        if currentLessonIndex < currentModule!.content.lessons.count {
            // Update
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            lessonDescription = addStyling(currentLesson!.explanation)
        } else {
            // Out of lessons. Reset.
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func hasNextLesson() -> Bool {
        return (currentLessonIndex + 1) < currentModule!.content.lessons.count
    }
    
    // MARK: - Code Styling
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        var result = NSAttributedString()
        var data = Data()
        
        // Styling Data
        if let style = styleData {
            data.append(style)
        }
        
        // HTML Data
        data.append(Data(htmlString.utf8))
        
        // Convert
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil){
            result = attributedString
        }
        
        return result
    }
}
