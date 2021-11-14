//
//  HomeView.swift
//  LearningApp
//
//  Created by Jeffrey Sweeney on 10/26/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var contentModel: ContentModel
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                Text("What would you like to do today?")
                    .padding(.leading, 20)
                
                ScrollView {
                    LazyVStack {
                        ForEach(contentModel.modules) { module in
                            VStack (spacing: 20) {
                                // MARK: Content Card
                                NavigationLink(
                                    destination: ContentView().onAppear(perform: {
                                        contentModel.beginModule(module.id)
                                    }),
                                    tag: module.id,
                                    selection: $contentModel.currentContentSelected) {
                                        HomeViewCard(userActionType: module.content, category: module.category)
                                }
                                
                                // MARK: Test Card
                                NavigationLink(
                                    destination: TestView().onAppear(perform: {
                                        contentModel.beginTest(module.id)
                                    }),
                                    tag: module.id,
                                    selection: $contentModel.currentTestSelected) {
                                        HomeViewCard(userActionType: module.test, category: module.category)
                                    }
                            }
                        }
                        .padding(.bottom, 15)
                    }
                    .accentColor(.black)
                    .padding()
                }
            }
            .navigationTitle("Get Started")
            // Navigating between modules can result in index out of range errors. When we
            // "drill back up" from a module, we know contentModel.currentContentSelected is
            // set to nil. We can detect when we've drilled back up by listening to when this
            // field changes back to nil. When it does, we know we must set the currentModule
            // back to nil.
            .onChange(of: contentModel.currentContentSelected, perform: { changedValue in
                if changedValue == nil {
                    contentModel.currentModule = nil
                }
            })
            // Same logic for test
            .onChange(of: contentModel.currentTestSelected, perform: { changedValue in
                if changedValue == nil {
                    contentModel.currentModule = nil
                }
            })
            
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
