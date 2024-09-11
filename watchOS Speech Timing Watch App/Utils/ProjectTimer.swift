//
//  ProjectTimer.swift
//  watchOS Speech Timing Watch App
//
//  Created by Andrew Culbertson on 8/29/24.
//



import Foundation
/**
    This is a class used to simplify the Timer class.
 */
class ProjectTimer: ObservableObject{
    @Published var timeElapsed: TimeInterval = 0
    private var lastTime: TimeInterval = 0
    private var timer: Timer? = nil
    private var startTime: Date = Date()
    private var isCounting: Bool = false
    private var defaultTimeInterval: TimeInterval = TimeInterval(0.01)
    private var formatter = NumberFormatter()

    /**
        Init function. Calls the initTimer function, sets the correct formatter values, and stops the newly created timer.
     */
    init(){
        initTimer(timeInterval: TimeInterval(defaultTimeInterval))
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        self.timer?.invalidate()
    }
    /**
        The function used to restart the timer.
        - Parameters
            - timeInterval: A TimeInterval object that is equal to the interval in which the timer being created will update.
     */
    func initTimer(timeInterval: TimeInterval){
        self.startTime = Date()
        self.timer = Timer.scheduledTimer(withTimeInterval:timeInterval, repeats: true){ _ in
            self.lastTime = self.timeElapsed
            self.timeElapsed += Date().timeIntervalSince(self.startTime)
            self.startTime = Date()
        }
    }
    
    /**
        A function used to return the current time elapsed in the form of a string, formatted to 2 decimal places.
     - Returns:A string representing the time elapsed
     */
    func getFormattedTime() -> String{
        return formatter.string(from: getTime() as NSNumber) ?? "NDEF"
    }
    
    /**
        Starts the timer with the initTimer function
     */
    func startTimer(){
        self.isCounting = true
        initTimer(timeInterval: TimeInterval(defaultTimeInterval))
    }
    /**
        Stops the timer
     */
    func stopTimer(){
        self.isCounting = false
        self.timer?.invalidate()
    }
    
    /**
        Sets the state of the timer to the opposite value. A running timer will stop while a stopped timer will start.
     */
    func toggleTimer(){
        if self.isCounting{
            stopTimer()
        }
        else{
            startTimer()
        }
        
    }
    
    /**
        Stops the timer and sets the timeElapsed value to 0.
     */
    func resetTimer(){
        self.isCounting = false
        self.timer?.invalidate()
        self.timeElapsed = TimeInterval(0)
        self.lastTime = TimeInterval(0)
    }
    
    /**
        Used to determine whether or not a certain value was passed in the last update to timeElapsed.
         - Parameters:
            - time: a TimeInterval object representing the value to check.
         - Returns: A Bool representing whether or not the TimeInterval object "time" was passed in the last update to timeElapsed
     */
    func hasPassed(time: TimeInterval) -> Bool{
        return time > lastTime && time < timeElapsed
    }
    
    /**
         - Returns: A TimeInterval object equal to the current timeElapsed
     */
    func getTime() -> TimeInterval{
        return timeElapsed
    }
    
    /**
         - Returns: A Bool equal to whether or not the timer is currently running.
     */
    func getTimerState() -> Bool{
        return self.isCounting
    }
    
    /**
         Used to set the interval in which the timer updates. Requires the clock to be reset before taking affect.
         - Parameters:
           - interval: A TimeInterval object that will be set to the clock's update interval.
     */
    func setTimeInterval(interval: TimeInterval){
        defaultTimeInterval = interval
    }
}
