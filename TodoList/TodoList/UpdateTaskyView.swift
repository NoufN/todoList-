

import SwiftUI

struct UpdateTaskyView: View {
    var todo : Todo?
    @State  var title : String = ""
    @State  var info : String = ""
    @State  var isFavorite : Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    init (todo : Todo? = nil){
        self.todo = todo
        _title = State(initialValue:  todo?.title ?? "")
        _info = State(initialValue: todo?.info ?? "")
        _isFavorite = State(initialValue:  todo?.isFavorite ?? false)
    }
    var body: some View {
        NavigationView{
            VStack{
                TextField("Title", text: $title)
                    .padding(.horizontal)
                TextField("Description" , text: $info)
                    .padding(.horizontal)
      
                Button {
                    do{
                        if let todo = todo {
                            todo.title = title
                            todo.info = info
                            todo.isFavorite = isFavorite
                            try viewContext.save()
                        }
                        
                    } catch {
                        
                    }
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Save")
                }
            }
            
        }
    }
}
struct UpdateTaskyView_Previews: PreviewProvider {
    static var previews: some View {
        let persistentContainer = CoreDataManager.shared.persistentContainer
        UpdateTaskyView()
            .environment(\.managedObjectContext, persistentContainer.viewContext)
    }
}
