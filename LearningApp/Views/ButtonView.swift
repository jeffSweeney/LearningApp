//
//  ButtonView.swift
//  LearningApp
//
//  Created by Jeffrey Sweeney on 11/5/21.
//

import SwiftUI

struct ButtonView: View {
    var theAction: () -> Void
    var buttonText: String
    var cardColor: Color = Color.green
    var textColor: Color = Color.white
    
    var body: some View {
        Button(action: theAction) {
            ZStack {
                Rectangle()
                    .foregroundColor(cardColor)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .frame(height: 48)
                
                Text(buttonText)
                    .bold()
                    .foregroundColor(textColor)
            }
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(theAction: {}, buttonText: "Testing")
    }
}
