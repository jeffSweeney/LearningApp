//
//  ContentViewCard.swift
//  LearningApp
//
//  Created by Jeffrey Sweeney on 10/29/21.
//

import SwiftUI

struct ContentViewCard: View {
    @EnvironmentObject var contentModel: ContentModel
    var index: Int
    
    var body: some View {
        ZStack {
            // Should always be set when this is called, but to be sure
            // let's check
            if let lesson = contentModel.currentModule?.content.lessons[index] {
                Rectangle()
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .aspectRatio(CGSize(width: 200, height: 50), contentMode: .fit)
                
                HStack (alignment: .center, spacing: 20) {
                    Text(String(index + 1))
                        .bold()
                        .font(.title2)
                    
                    VStack (alignment: .leading, spacing: 5) {
                        Text(lesson.title)
                            .bold()
                            .font(.title2)
                        
                        Text(lesson.duration)
                            .font(.callout)
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}
