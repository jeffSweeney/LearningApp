//
//  TestView.swift
//  LearningApp
//
//  Created by Jeffrey Sweeney on 11/6/21.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var contentModel: ContentModel
    
    var body: some View {
        if let question = contentModel.currentQuestion {
            VStack {
                // Question number
                // - known that cu
                Text("Question \(question.id+1) of \(contentModel.currentModule?.test.questions.count ?? 0)")
                
                // Question
                CodeTextView()
                
                // Answers
                
                // Button
            }
            .padding()
            .navigationBarTitle("\(contentModel.currentModule?.category ?? "") Test")
            .accentColor(.black)
        } else {
            // Gives moment for currentQuestion to be set
            ProgressView()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
