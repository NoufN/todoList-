

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: false)],animation:.default)
    private var myTodo : FetchedResults<Todo>
    
    @State var title : String = ""
    @State var info : String = ""
    @State var timestamp = Date()
    @State var isFavorite : Bool = false
   
   
    var body: some View {
        NavigationView{
            VStack{
          
                TextField("Title", text: $title)
                    .padding(.horizontal)
                TextField("Description" , text: $info)
                    .padding(.horizontal)

                Button {
                    do{
                        let todo = Todo(context : viewContext)
                        todo.title = title
                        todo.info = info
                        todo.isFavorite = isFavorite
                        todo.timestamp = Date()
                        try viewContext.save()
                    }catch{
                        
                    }
                } label: {
                    Text("Save")
                }
               Divider()
              
                
                List{
               
                    ForEach(myTodo) { todo in
                        
                        NavigationLink(destination: {
                            UpdateTaskyView(todo: todo)
                        }, label: {
                      
                            HStack {
                                
                                VStack {
                                    Text(todo.title ?? "" )
                                        .font(.title2)
                                        .bold()
                                    
                                    Text(todo.info ?? "" )
                                        .font(.title2)
                                }
                                Spacer()
                                Button {
                                    todo.isFavorite = !todo.isFavorite
                                    do{
                                        try viewContext.save()
                                    } catch {
                                        
                                    }
                                } label: {
                                    Image(systemName: todo.isFavorite ? "heart.fill" : "heart")
                                        .foregroundColor(.red)
                                }.buttonStyle(.borderless)
                                
                            }
                            
                        })
                            .swipeActions(edge:.leading) {
                                Button {
                                    viewContext.delete(todo)
                                    do{
                                        try viewContext.save()
                                    } catch{
                                        
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                } .tint(.red)
                                
                            }
                        
                    }
                    
                }
            }
            .navigationTitle("Todo List ")
            .navigationBarTitleDisplayMode(.large)
        }
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistentContainer = CoreDataManager.shared.persistentContainer
        ContentView()
            .environment(\.managedObjectContext, persistentContainer.viewContext)
    }
}
