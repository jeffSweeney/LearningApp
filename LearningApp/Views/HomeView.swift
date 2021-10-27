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
                                HomeViewCard(userActionType: module.content, category: module.category)
                                HomeViewCard(userActionType: module.test, category: module.category)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Get Started")
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
