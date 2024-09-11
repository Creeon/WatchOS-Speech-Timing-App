//
//  SecondView.swift
//  watchOS Speech Timing Watch App
//
//  Created by Andrew Culbertson on 8/29/24.
//

/*
 This view is used solely for testing purposes.
 */

import SwiftUI
struct TestingView: View {
    @ObservedObject private var timer: ProjectTimer = ProjectTimer()
    var body: some View {
        VStack{
            Text("Timer: \(timer.getFormattedTime())")
                .font(.title2)
                .padding()
            Button(action: {
                timer.toggleTimer()
            }){
                Text("Toggle timer")
            }
            .padding()
            Button(action: {
                timer.resetTimer()
            }){
                Text("Reset timer")
            }
        }
        //.navigationTitle("Second Screen")
    }
}

#Preview {
    TestingView()
}

