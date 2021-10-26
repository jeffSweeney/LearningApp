//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Jeffrey Sweeney on 10/26/21.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                // Set the ViewModel instance for the app here on entry
                .environmentObject(ContentModel())
        }
    }
}
