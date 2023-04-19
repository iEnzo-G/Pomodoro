import Foundation
import CoreData

final class CoreDataStore {
    
    
    let mainContext: NSManagedObjectContext
    init(coreDataStack: CoreDataStack = CoreDataStack()) {
        self.mainContext = coreDataStack.mainContext
    }
    
    func saveSession(_ session: Session) {
        let newPomodoroEntity = PomodoroEntity(context: mainContext)
        
        newPomodoroEntity.title = session.title
        newPomodoroEntity.workTime = Int64(session.workTime)
        newPomodoroEntity.day = session.day
        
        try? mainContext.save()
    }
    
    func getSessions() -> [Session] {
        let fetchRequest = NSFetchRequest<PomodoroEntity>(entityName: "PomodoroEntity")
        guard let pomodoroEntities = try? mainContext.fetch(fetchRequest) else { return [] }
        let sessions = pomodoroEntities.map { entity in
            Session(day: entity.day!,
                    workTime: Int(entity.workTime),
                    title: entity.title!)
        }
        return sessions
    }
    
        func deleteSession(_ session: Session) {
            let fetchRequest = NSFetchRequest<PomodoroEntity>(entityName: "PomodoroEntity")
            fetchRequest.predicate = NSPredicate(format: "title == %@", session.title)
            guard let pomodoroEntity = try? mainContext.fetch(fetchRequest).first else { return }
            mainContext.delete(pomodoroEntity)
    
            try? mainContext.save()
        }
}
