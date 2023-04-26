import XCTest
@testable import Pomodoro


final class CoreDataStoreTests: XCTestCase {
    
    func test_GivenSession_WhenTimerIsFinish_ThenSaveSessionInCoreData() {
        let fakeCoreDataStack = FakeCoreData()
        let sut = CoreDataStore(coreDataStack: fakeCoreDataStack)
        let session = Session(day: Date(), workTime: 3500, title: "OCPizza_PV")
        
        sut.saveSession(session)
        
        var sessionsStore: [Session] = []
        sessionsStore = sut.getSessions()
        XCTAssertEqual(sessionsStore.count, 1)
    }
    
        func test_GivenSession_WhenDeleteButtonIsTapped_ThenDeleteSessionInCoreData() {
            let fakeCoreDataStack = FakeCoreData()
            let sut = CoreDataStore(coreDataStack: fakeCoreDataStack)
            let session = Session(day: Date(), workTime: 3500, title: "OCPizza_PV")
            sut.saveSession(session)
            var sessionsStore: [Session] = []
            sessionsStore = sut.getSessions()
            XCTAssertEqual(sessionsStore.count, 1)
            
            sut.deleteSession(session)
            sessionsStore = sut.getSessions()
    
            XCTAssertEqual(sessionsStore.count, 0)
        }
    
    func test_GivenSession_WhenAskCoreData_ThenGetSession() {
        let fakeCoreDataStack = FakeCoreData()
        let sut = CoreDataStore(coreDataStack: fakeCoreDataStack)
        let session = Session(day: Date(), workTime: 3500, title: "OCPizza_PV")
        sut.saveSession(session)
        
        var sessionsStore: [Session] = []
        sessionsStore = sut.getSessions()
        
        XCTAssertEqual(sessionsStore[0].title, "OCPizza_PV")
    }
}
