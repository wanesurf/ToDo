//
//  ContentView.swift
//  ToDo
//
//  Created by Helwan Mandé on 2020-08-23.
//  Copyright © 2020 Helwan Mandé. All rights reserved.
//

import SwiftUI
var rowHeight: CGFloat = 50
struct ContentView: View {
    @State var newTaskTitle = ""
    var sampleTasks = ["Task One","Task Two","Task Three"]
    var body: some View {
   
            List{
                ForEach(sampleTasks, id: \.self) { item in
                HStack {
                Text(item)
                Spacer()
                    Button(action: {print("Task Done")}){
                Image(systemName: "circle")
                        .imageScale(.large)
                        .foregroundColor(.gray)
                        
                    }
                }
                    //dynamics
                    
                    
                }
                .frame(height: rowHeight)
                //statics
                HStack {
                    TextField("Add task .. ", text: $newTaskTitle, onCommit: {print("New task added")})
                    
                    Button(action: {print("New Task entered")}) {
                        
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
                .frame(height: rowHeight)
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
