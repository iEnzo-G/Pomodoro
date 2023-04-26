import XCTest
import CoreData
@testable import Pomodoro

class FakeCoreData: CoreDataStack {
    
    override init() {
        super.init()
        storeContainer = NSPersistentContainer(name: "Pomodoro")
        let description = storeContainer.persistentStoreDescriptions.first
        description?.type = NSInMemoryStoreType
        
        storeContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("\(error!)")
            }
        }
        
        mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.automaticallyMergesChangesFromParent = true
        mainContext.persistentStoreCoordinator = storeContainer.persistentStoreCoordinator
    }
}
