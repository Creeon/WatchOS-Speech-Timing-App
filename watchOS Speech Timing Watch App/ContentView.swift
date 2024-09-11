//
//  ContentView.swift
//  watchOS Speech Timing Watch App
//
//  Created by Andrew Culbertson on 8/28/24.
//

import SwiftUI
struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SelectViewQueueFile()) {
                    Text("View Files")
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                /*NavigationLink(destination: QueueCreationView()) {
                    Text("Go to Timer")
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }*/
                }
        }
    }
}

/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}*/
