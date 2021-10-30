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
                        NavigationLink {
                            ContentViewDetail()
                                .onAppear(perform: {
                                    contentModel.beginLesson(index)
                                })
                        } label: {
                            ContentViewCard(index: index)
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Learn \(contentModel.currentModule?.category ?? "")")
            .accentColor(.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
