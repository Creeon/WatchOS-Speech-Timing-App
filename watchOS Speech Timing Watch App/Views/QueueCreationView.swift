//
//  QueueCreationView.swift
//  watchOS Speech Timing Watch App
//
//  Created by Andrew Culbertson on 9/1/24.
//

/*
 This (will) be the view used to create more queue sets.
 */

import SwiftUI

struct QueueCreationView: View {
    @State private var name: String = ""
    @State private var test: Date = Date()
    @ObservedObject private var viewQueuesModel: TimeQueueViewModel = TimeQueueViewModel()
    var body: some View {
        VStack{
            List{
                TextField("Name", text: $name)
                ForEach($viewQueuesModel.timeQueues){ queue in
                    HStack{
                        //TextField("Queue Name", text: queue.name)
                        DatePicker("Select Time", selection: $test, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                                .onChange(of: test){
                                    print(test)
                                }
                    }
                }
            }
            .padding()
            Button("Add"){
                viewQueuesModel.timeQueues.append(TimeQueue(name: "e", time: 1))
            }
            
        }
    }
}

#Preview {
    QueueCreationView()
}
