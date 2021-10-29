//
//  ContentView.swift
//  LearningApp
//
//  Created by Jeffrey Sweeney on 10/29/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var contentModel: ContentModel
    
    var body: some View {
        ScrollView {
            LazyVStack (spacing: 25) {
                // Should always be set when this is called, but to be sure
                // let's check
                if let module = contentModel.currentModule {
                    ForEach(0 ..< module.content.lessons.count) { index in
                        let lesson = module.content.lessons[index]
                        
                        ZStack {
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
            .padding()
            .navigationTitle("Learn \(contentModel.currentModule?.category ?? "")")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
