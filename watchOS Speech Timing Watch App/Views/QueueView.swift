//
//  TestView.swift
//  watchOS Speech Timing Watch App
//
//  Created by Andrew Culbertson on 8/29/24.
//


/*
 This view is used to display all of the components of a list of queues. 
 Additionally, this contains the button to run that set of queues.
 */
import SwiftUI

struct QueueView: View {
    
    @ObservedObject private var viewQueues: TimeQueueViewModel = TimeQueueViewModel()
    public var selectedFile: URL
    
    var body: some View {
        NavigationLink(destination: RunQueues(queues: viewQueues)) {
            Text("Run")
        }        
            List(viewQueues.timeQueues) { queue in
            VStack {
                Text(queue.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                Text(getMinuteFormat(time: queue.time))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 4)
        }
        .onAppear {            
            viewQueues.loadFromFile(path: selectedFile)
        }
    }

}

/*#Preview {
    TestView()
}*/
