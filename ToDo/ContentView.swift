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
    @Environment(\.managedObjectContext) var managedContextObject
    
    @FetchRequest(entity: ToDoItems.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \ToDoItems.createdAt, ascending: false)], predicate: NSPredicate(format: "taskDone = %d", false))
    //important: pass the fetched data to another variable for holding the to-do items.
    var fetchedItems: FetchedResults<ToDoItems>
    
    @State var newTaskTitle = ""

    //var sampleTasks = ["Task One","Task Two","Task Three"]
    
    var body: some View {
        NavigationView{
            List{
                ForEach(fetchedItems, id: \.self) { item in
                HStack {
                    Text(item.taskTitle ?? "Empty")
                Spacer()
                    Button(action: {
                        self.markTaskAsDone(at:
                        self.fetchedItems.firstIndex(of: item)!)
                        
                    }){
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
                    TextField("Add task .. ", text: $newTaskTitle, onCommit:{self.saveTask()})
                    //save also by clicking the return button
                    
                Button(action: {self.saveTask()}) {
                        
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
                .frame(height: rowHeight)
                
                HStack{
                    NavigationLink(destination: TaskDone()){
                           Text("Completed Tasks")
                    }
                       }
            }
        .navigationBarTitle(Text("To-Do"))
        .listStyle(GroupedListStyle())
    }
   
        }
    func saveTask(){
        //unwrap those input values with guard first.
        guard self.newTaskTitle != "" else {
            return
        }
        let newToDoItem = ToDoItems(context: self.managedContextObject)
        newToDoItem.taskTitle = self.newTaskTitle
        newToDoItem.createdAt = Date()
        newToDoItem.taskDone = false
        
        do {
            try self.managedContextObject.save()
        }catch {print(error.localizedDescription)
        }
        self.newTaskTitle = ""
    }
    func markTaskAsDone(at index: Int){
        let item = fetchedItems[index]
        item.taskDone = true
        
        do {
            try self.managedContextObject.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        return  ContentView().environment(\.managedObjectContext, context)
       
    }
}
