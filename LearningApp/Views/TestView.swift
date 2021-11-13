//
//  TestView.swift
//  LearningApp
//
//  Created by Jeffrey Sweeney on 11/6/21.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var contentModel: ContentModel
    @State var selectedAnswerIndex: Int?
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
        if let question = contentModel.currentQuestion {
            VStack (alignment: .leading) {
                // Question number
                Text("Question \(question.id+1) of \(contentModel.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                
                // Question
                CodeTextView()
                    .padding(.horizontal, 20)
                
                // Answers
                ScrollView {
                    VStack {
                        ForEach(0 ..< question.answers.count, id: \.self) { index in
                            
                            let cardColor = determineCardColor(index, correctIndex: question.correctIndex)
                            
                            ButtonView(
                                theAction: {
                                    selectedAnswerIndex = index
                                },
                                buttonText: question.answers[index],
                                cardColor: cardColor,
                                textColor: Color.black
                            )
                                .padding(.vertical, 5)
                                .disabled(submitted)
                        }
                    }
                    .padding()
                }
                
                // Submit Button
                if submitted {
                    let buttonText = contentModel.hasNextQuestion() ? "Next Question" : "Finished"
                    ButtonView(theAction: {
                        submitted = false
                        selectedAnswerIndex = nil
                        contentModel.advanceQuestion()
                    }, buttonText: buttonText)
                        .padding()
                } else {
                    ButtonView(theAction: {
                        submitted = true
                        
                        // Check answer and keep track
                        if selectedAnswerIndex == question.correctIndex {
                            numCorrect += 1
                        }
                    }, buttonText: "Submit")
                        .padding()
                        .disabled(selectedAnswerIndex == nil)
                }
            }
            .navigationBarTitle("\(contentModel.currentModule?.category ?? "") Test")
            .accentColor(.black)
        } else {
            // Gives moment for currentQuestion to be set
            ProgressView()
        }
    }
    
    private func determineCardColor(_ index: Int, correctIndex: Int) -> Color {
        var result = Color.white
        
        if submitted {
            // Correct answer should always be green - no matter if selected or not
            if index == correctIndex {
                result = Color.green
            } else if index == selectedAnswerIndex {
                // If reached, this choice isn't correct. If it was the selected choice,
                // it needs to be red
                result = Color.red
            }
        } else if selectedAnswerIndex == index {
            result = Color.gray
        }
        
        return result
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
