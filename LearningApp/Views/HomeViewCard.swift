//
//  HomeViewCard.swift
//  LearningApp
//
//  Created by Jeffrey Sweeney on 10/27/21.
//

import SwiftUI

struct HomeViewCard<T: UserActionModel>: View {
    
    var userActionType: T
    var category: String
    
    var body: some View {
        ZStack {
            // MARK: Rectangle Background
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
            
            HStack {
                // MARK: Image
                Image(userActionType.image)
                    .resizable()
                    .frame(width: 115, height: 115)
                    .clipShape(Circle())
                
                Spacer()
                
                VStack (alignment: .leading, spacing: 10) {
                    // MARK: Category
                    Text(userActionType.userAction(category))
                        .font(.headline)
                    
                    // MARK: Description
                    Text(userActionType.description)
                        .font(.footnote)
                        .padding(.bottom, 20)
                    
                    HStack {
                        // MARK: Lesson/Test Count
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(userActionType.userWorkload())
                            .font(.caption)
                        
                        Spacer()
                        
                        // MARK: Timing
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(userActionType.time)
                            .font(.caption)
                    }
                    .padding(.trailing, 25)
                }
                .padding(.leading, 20)
            }
            .padding()
        }
    }
}

struct HomeCardView_Previews: PreviewProvider {
    static var previews: some View {
        let module = ContentModel().modules[0]
        HomeViewCard(userActionType: module.content, category: "Swift")
    }
}
