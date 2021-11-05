//
//  ContentViewDetail.swift
//  LearningApp
//
//  Created by Jeffrey Sweeney on 10/29/21.
//

import SwiftUI
import AVKit

struct ContentViewDetail: View {
    @EnvironmentObject var contentModel: ContentModel
    
    var body: some View {
        VStack {
            // MARK: Video if available
            if let lesson = contentModel.currentLesson {
                if let url = URL(string: "\(Constants.hostedVideoUrl)\(lesson.video)") {
                    VideoPlayer(player: AVPlayer(url: url))
                        .cornerRadius(10)
                } else {
                    Text("Unable to load video for \(lesson.title) - BAD URL")
                }
                
                // MARK: Description
                CodeTextView()
                
                // MARK: Next Lesson
                if contentModel.hasNextLesson() {
                    let nextLessonIndex = contentModel.currentLessonIndex+1
                    let nextLesson = contentModel.currentModule!.content.lessons[nextLessonIndex].title
                    
                    ButtonView(
                        theAction: {contentModel.advanceLesson()},
                        buttonText: "Next Lesson: \(nextLesson)")
                } else {
                    // Show complete button and unwind back
                    ButtonView(
                        theAction: {contentModel.currentContentSelected = nil},
                        buttonText: "Complete")
                }
                
            } else {
                Text("ERROR - UNABLE TO LOAD LESSON")
            }
        }
        .padding()
        .navigationBarTitle(contentModel.currentLesson?.title ?? "")
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewDetail()
    }
}
