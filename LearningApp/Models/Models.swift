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

struct Content: Decodable, Identifiable {
    var id: Int
    var image: String
    var time: String
    var description: String
    var lessons: [Lesson]
}

struct Test: Decodable, Identifiable {
    var id: Int
    var image: String
    var time: String
    var description: String
    var questions: [Question]
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
