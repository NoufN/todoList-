

import Foundation
import CoreData



class CoreDataManager {
    
    let persistentContainer : NSPersistentContainer
    static let shared : CoreDataManager = CoreDataManager() //sigleton
    
    init(){
        persistentContainer = NSPersistentContainer(name: "TodoDataB")
        persistentContainer.loadPersistentStores { discription , error in
            if let error = error {
                fatalError("Unble to data\(error.localizedDescription)")
            }
        }
    }
    
}
