//
//  Models.swift
//  LearningApp
//
//  Created by Jeffrey Sweeney on 10/26/21.
//

import Foundation

// MARK: Top Level Models - Module

struct Module: Decodable, Identifiable {
    var id: Int
    var category: String
    var content: Content
    var test: Test
}

// MARK: Middle Level Models - Content and Test

// Makes constructing the generic reusable views easier
protocol UserActionModel: Decodable, Identifiable {
    var id: Int { get }
    var image: String { get }
    var time: String { get }
    var description: String { get }
    
    func userAction(_ category: String) -> String
    func userWorkload() -> String
}

struct Content: UserActionModel {
    var id: Int
    var image: String
    var time: String
    var description: String
    var lessons: [Lesson]
    
    func userAction(_ category: String) -> String {
        return "Learn \(category)"
    }
    
    func userWorkload() -> String {
        return "\(lessons.count) Lessons"
    }
}

struct Test: UserActionModel {
    var id: Int
    var image: String
    var time: String
    var description: String
    var questions: [Question]
    
    func userAction(_ category: String) -> String {
        return "\(category) Test"
    }
    
    func userWorkload() -> String {
        return "\(questions.count) Questions"
    }
}

// MARK: Bottom Level Models - Lesson and Question

struct Lesson: Decodable, Identifiable {
    var id: Int
    var title: String
    var video: String
    var duration: String
    var explanation: String
}

struct Question: Decodable, Identifiable {
    var id: Int
    var content: String
    var correctIndex: Int
    var answers: [String]
}
