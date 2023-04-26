import Foundation
import CoreData

class CoreDataStack {
    
    // MARK: - Properties
    
    var storeContainer: NSPersistentContainer
    var mainContext: NSManagedObjectContext
    
    init() {
        storeContainer = {
            let container = NSPersistentContainer(name: "Pomodoro")
            container.loadPersistentStores { (storeDescription, error) in
                if let error = error as NSError? {
                    print("Unresolved error \(error), \(error.userInfo)")
                }
            }
            return container
        }()
        
        mainContext =  storeContainer.newBackgroundContext()
    }
}
