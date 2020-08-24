//
//  TaskDone.swift
//  ToDo
//
//  Created by Helwan Mandé on 2020-08-23.
//  Copyright © 2020 Helwan Mandé. All rights reserved.
//

import Foundation
import SwiftUI

struct TaskDone: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: ToDoItems.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \ToDoItems.createdAt, ascending: false)], predicate: NSPredicate(format: "taskDone = %d", true))
    
    var fetchedItems: FetchedResults<ToDoItems>
    
    var body: some View {
        
        List{
              ForEach(fetchedItems, id: \.self) { item in
                          HStack {
                              Text(item.taskTitle ?? "Empty")
                          Spacer()
                              Button(action: {
                                
                                print("yo")
                                  
                              }){
                          Image(systemName: "checkmark.circle.fill")
                                  .imageScale(.large)
                                  .foregroundColor(.blue)
                                  
                              }
                          }
                              //dynamics
                              
                          }
        .onDelete(perform: removeItems)
        }
    .navigationBarTitle(Text("Tasks Done"))
            //delete multiple items
            .navigationBarItems(leading: EditButton())
    .listStyle(GroupedListStyle())

    }
    
    func removeItems(at offset: IndexSet){
        for index in offset{
            let item = fetchedItems[index]
            managedObjectContext.delete(item)
        }
        do{
            try managedObjectContext.save()
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
}


struct TaskDone_Previews: PreviewProvider {
    static var previews: some View {
        TaskDone()
    }
}
