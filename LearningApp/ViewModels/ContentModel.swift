//
//  ContentModel.swift
//  LearningApp
//
//  Created by Jeffrey Sweeney on 10/26/21.
//

import Foundation

class ContentModel: ObservableObject {
    @Published var modules = [Module]()
    
    // MARK: properties to keep track of
    // Current Module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    // Current Lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    // Current code test to display
    @Published var codeText = NSAttributedString()
    var styleData: Data?
    
    // Current question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    // Current selected content and test
    @Published var currentContentSelected: Int?
    @Published var currentTestSelected: Int?
    
    init() {
        // Set modules with local and remote data
        self.decodeLocalJson()
        self.decodeRemoteJson()
        
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
        codeText = addStyling(currentLesson!.explanation)
    }
    
    func advanceLesson() {
        // Advance lesson index
        currentLessonIndex += 1
        
        // Still in range?
        if currentLessonIndex < currentModule!.content.lessons.count {
            // Update
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = addStyling(currentLesson!.explanation)
        } else {
            // Out of lessons. Reset.
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func hasNextLesson() -> Bool {
        guard currentModule != nil else {
            return false
        }
        
        return (currentLessonIndex + 1) < currentModule!.content.lessons.count
    }
    
    // MARK: - Test Nav Methods
    func beginTest(_ moduleId: Int) {
        // Set the current module
        beginModule(moduleId)
        
        // If there are questions, set at first question
        currentQuestionIndex = 0
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }
    }
    
    func advanceQuestion() {
        // Advance the question index
        currentQuestionIndex += 1
        
        // Check that in range
        if currentQuestionIndex < currentModule!.test.questions.count {
            // Advance the question
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        } else {
            // Set back to front
            currentQuestionIndex = 0
            currentQuestion = nil
        }
    }
    
    func hasNextQuestion() -> Bool {
        return (currentQuestionIndex + 1) < currentModule!.content.lessons.count
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
    
    // MARK: - Local and remote JSON decoding
    func decodeLocalJson() {
        // Get URL
        if let url = Bundle.main.url(forResource: "data", withExtension: "json") {
            // Get data at url
            do {
                let data = try Data(contentsOf: url)
                
                // Decode the data
                do {
                    let jsonDecoder = JSONDecoder()
                    let localModules = try jsonDecoder.decode([Module].self, from: data)
                    
                    // Published fields MUST be updated by the main thread
                    DispatchQueue.main.async {
                        self.modules += localModules
                    }
                } catch {
                    // Could not decode the data
                    print(error)
                }
            } catch {
                // Could not get data object from url
                print(error)
            }
        }
    }
    
    private func decodeRemoteJson() {
        // Get URL
        let url = URL(string: Constants.HostedJsonContent)
        
        // Guard against nil url
        guard url != nil else {
            return
        }
        
        // Generate URL request
        let request = URLRequest(url: url!)
        
        // Get the session and define data task
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, _, error) in
            // Guard against task error
            guard error == nil else {
                return
            }
            
            // No error - decode the data
            do {
                let decoder = JSONDecoder()
                let remoteModules = try decoder.decode([Module].self, from: data!)
                
                // Published fields MUST be updated by the main thread
                DispatchQueue.main.async {
                    self.modules += remoteModules
                }
            } catch {
                // Couldn't decode json
                print(error)
            }
        }
        
        // Kick off task
        task.resume()
    }
}
