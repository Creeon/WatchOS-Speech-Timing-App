//
//  TimeQueue.swift
//  watchOS Speech Timing Watch App
//
//  Created by Andrew Culbertson on 8/29/24.
//

/*
 Contains classes and structs used for queues and queue sets.
 */

import Foundation

/**
    This is a queue, used within a queue set. This contains the name of the queue and a TimeInterval of when the queue should go off.
 */
struct TimeQueue: Identifiable{
    let id =  UUID()
    var name: String
    var time: TimeInterval
}

/**
    This is a file that contains a queue set. The struct contains the file name and the url of the file.
 */
struct TimeQueueFile: Identifiable{
    let id = UUID()
    var fileName: String
    var url: URL
}

/**
    This class is used to interface with a queue set.
 */
class TimeQueueViewModel: ObservableObject{
    @Published var timeQueues: [TimeQueue] = []
    
    /**
         Loads a queue set from the given URL.
         - Parameters:
          - path: The URL of the file to load the queue set from.
     */
    func loadFromFile(path: URL){
        self.timeQueues = organizeTimeQueues(queues: getTimeQueueArray(path: path))
    }
}

/**
    This class is used to interface with a folder containing all queue set files.
    It sources all of it's files from the "Files" folder, located using Bundle.main.url.
    All files within this folder are assumed to be queue set files, and are stored in an array of type TimeQueueFile
 */
class TimeQueueFolderViewModel: ObservableObject{
    @Published var timeQueueFiles: [TimeQueueFile] = []
    public var folderPath: URL
    init(){
        folderPath = Bundle.main.url(forResource: "Files", withExtension: nil)!
        let manager = FileManager()
        do{
            for file in try manager.contentsOfDirectory(atPath: folderPath.path){
                let t: TimeQueueFile = TimeQueueFile(fileName: file, url: folderPath.appendingPathComponent(file))
                timeQueueFiles.append(t)
            }
        }
        catch{
            print("Error trying to load files in " + folderPath.path)
        }
    }
}

/**
    Organizes a queue set in order of least to greatest times.
*/
func organizeTimeQueues(queues: [TimeQueue]) -> [TimeQueue]{
    //Not efficient sort alg at all, should come back and make better
    var queues2 = queues
    var returnModel: [TimeQueue] = []
    while queues2.count > 0 {
        var smallest = queues2[0]
        var smallestIndex = 0
        var index = 0
        for queue in queues2{
            if queue.time < smallest.time{
                smallest = queue
                smallestIndex = index
            }
            index+=1
        }
        returnModel.append(smallest)
        queues2.remove(at: smallestIndex)
    }
    return returnModel
}

/**
    Converts a string of format "name:time" into a timeQueue object. Assumes the input is in the correct format.
 */
func convertStringToTimeQueue(string: String) -> TimeQueue{
    let arr = string.split(separator: ":")
    let timeQueue = TimeQueue(
        name: String(arr[0]),
        time: TimeInterval(arr[1]) ?? 0
    )
    return timeQueue
}

/**
     Returns an array of timeQueue objects from the given URL
 */
func getTimeQueueArray(path: URL) -> [TimeQueue]{
    var output: [TimeQueue] = []
    do{
        
        /*let manager = FileManager()
        //let lines = manager.fileExists(atPath: path)
        
        
        let ppath = Bundle.main.url(forResource: "Files", withExtension: nil)!
        var path2 = path
        for file in try manager.contentsOfDirectory(atPath: ppath.path){
            path2 = ppath.appendingPathComponent(file)
        }*/
        
        
        let lines = try String(contentsOf: path, encoding: .utf8).split(separator: "\n")
        for line in lines{
            if line.split(separator: ":").count == 2{
                output.append(convertStringToTimeQueue(string: String(line)))
            }
        }
    }
    catch{
        print("Error reading file: \(error.localizedDescription)")
    }
    return output
}
