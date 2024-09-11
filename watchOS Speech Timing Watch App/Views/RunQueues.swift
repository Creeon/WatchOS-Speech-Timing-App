//
//  RunQueues.swift
//  watchOS Speech Timing Watch App
//
//  Created by Andrew Culbertson on 9/4/24.
//

/*
 This is the view that is used while a set of queues is running.
 */

import SwiftUI

struct RunQueues: View {
    @ObservedObject var timer: ProjectTimer = ProjectTimer()
    @State private var passedValues: [TimeQueue] = []
    @State private var nextQueue: TimeQueue? = nil
    @State private var hideEndButton: Bool = true

    @Environment(\.presentationMode) var presentation
    var queues: TimeQueueViewModel = TimeQueueViewModel()
    
    var body: some View {
        VStack{
            Text("Time: ")
                .font(.subheadline)
            /*Text(timer.getFormattedTime())
                .monospaced()*/
            Text(getMinuteFormat(time: timer.getTime()))
                .font(.system(size: 24))
                .monospaced()
            Spacer()
            if hideEndButton{
                    /*Text(nextQueue?.name ?? "None")
                        .font(.headline)*/
                    //Text(String(nextQueue?.time ?? TimeInterval(0.00)) + " seconds")
                    Text(getFullMessage())
                        .font(.headline)
                        .foregroundColor(.primary)
                
            }
            if !hideEndButton{
                Button("End"){
                    self.presentation.wrappedValue.dismiss()
                }
            }
            
        }
        .onChange(of: timer.getTime()){
            for queue in queues.timeQueues{//Could be more efficient, a good thing to come back to and improve
                if(timer.hasPassed(time: queue.time)){
                    passedValues.append(queue)
                    WKInterfaceDevice.current().play(.success)//Untested since simulation does not show haptic feedback.
                    if passedValues.count == queues.timeQueues.count{
                        nextQueue = nil
                        hideEndButton = false
                    }
                    else{
                        nextQueue = queues.timeQueues[passedValues.count]
                    }
                }
            }
        }
        .onAppear(){
            timer.resetTimer()
            timer.startTimer()
            nextQueue = queues.timeQueues[0]
            hideEndButton = true
        }
        
    }
    func getTimeRemaining() -> TimeInterval{
        return TimeInterval(Double(nextQueue?.time ?? TimeInterval(0.00)) - Double(self.timer.getTime())+1)
        
    }
    func getFullMessage() -> String {
        return (nextQueue?.name ?? "None") + " in " + getMinuteFormat(time: getTimeRemaining())
    }

}



func getMinuteFormat(time: TimeInterval) -> String{
    let formatter = NumberFormatter()
    formatter.minimumIntegerDigits = 2
    let seconds = Int(time.truncatingRemainder(dividingBy: 60))
    let minutes = Int(time/60)
    return String(minutes) + ":" + formatter.string(from: seconds as NSNumber)!
}

/*#Preview {
    RunQueues()
}*/
