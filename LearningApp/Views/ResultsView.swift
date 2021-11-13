//
//  ResultsView.swift
//  LearningApp
//
//  Created by Jeffrey Sweeney on 11/12/21.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var contentModel: ContentModel
    let numCorrect: Int
    
    var body: some View {
        let outOf = contentModel.currentModule?.test.questions.count ?? 0
        
        VStack {
            Spacer()
            
            Text(determineHeader(outOf))
                .font(.title)
            
            Spacer()
            
            Text("\(numCorrect) out of \(outOf) correct")
            
            Spacer()
            
            ButtonView(theAction: {
                contentModel.currentTestSelected = nil
            }, buttonText: "Complete")
                .padding()
            
            Spacer()
        }
    }
    
    private func determineHeader(_ totalQuestions: Int) -> String {
        var result: String!
        
        // Gaurd against divide by 0 on optional unwrap
        if totalQuestions > 0 {
            let percentage: Double = Double(numCorrect) / Double(totalQuestions)
            
            switch percentage {
                case 0.9 ... 1.0:
                    result = "Excellent!"
                case 0.7 ..< 0.9:
                    result = "Good work!"
                default:
                    result = "Please consider watching this module again"
            }
        } else {
            result = "Results"
        }
        
        return result
    }
}
