//
//  SelectViewQueueFile.swift
//  watchOS Speech Timing Watch App
//
//  Created by Andrew Culbertson on 9/1/24.
//

/*
 This view's purpose is to display all available queue sets. 
 This also (will) contain the option to create more queue sets.
 */
import SwiftUI

struct SelectViewQueueFile: View {
    @State var selectedFile: URL? = nil
    @ObservedObject var folderViewModel: TimeQueueFolderViewModel = TimeQueueFolderViewModel()
    
    var body: some View {
        List{
            ForEach(folderViewModel.timeQueueFiles){ file in
                 NavigationLink(destination: QueueView(selectedFile: file.url)) {
                    Text(file.fileName.split(separator: ".")[0])
                }
            }
            //NavigationLink(destination: QueueCreationView()){//NOT FULLY COMPLETE !!!!!!
            NavigationLink(destination: MessageView()){
                Image(systemName: "plus")
                    .font(.system(size: 24))
                    .bold()
                    .foregroundColor(.green)
                    .padding()
                    .background(Color.gray)
                    .clipShape(Circle())
            }
        }
    }
}

#Preview {
    SelectViewQueueFile()
}
