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
                                NavigationLink(destination: ContentView().onAppear(perform: {
                                    contentModel.beginModule(module.id)
                                })) {
                                    // MARK: Content Card
                                    HomeViewCard(userActionType: module.content, category: module.category)
                                }
                                
                                // MARK: Test Card
                                HomeViewCard(userActionType: module.test, category: module.category)
                            }
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
            }
            .navigationTitle("Get Started")
            
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
