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
                    
                    Button(action: {contentModel.advanceLesson()}) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.green)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .frame(height: 48)
                            
                            Text("Next Lesson: \(nextLesson)")
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
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
