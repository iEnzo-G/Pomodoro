import XCTest
import Combine
@testable import Pomodoro


final class TimerServiceTests: XCTestCase {
    
    func test_GivenTimer_WhenTimerIsNotRunning_ThenTimerStarts() {
        let time = 10
        let publisherStub = TimerPublisherStub()
        let sut = TimerModel(isWorkTimer: true, workTime: time, timer: publisherStub.valuePublisher)
        
        sut.startTimer()
        (1 ... time).forEach { _ in publisherStub.sendValue() }
        
        XCTAssertEqual(sut.textTimer, "Temps de repos")
        XCTAssertEqual(sut.isWorkTimer, false)
    }
    
    func test_GivenTimer_WhenTimerIsNotRunning_ThenAfterStarts() {
        let time = 10
        let publisherStub = TimerPublisherStub()
        let sut = TimerModel(isWorkTimer: true, workTime: time, timer: publisherStub.valuePublisher)
        
        (1 ... time).forEach { _ in publisherStub.sendValue() }
        XCTAssertEqual(sut.workTime, time)
        sut.startTimer()
    }
    
    func test_GivenTimer_WhenTimerIsRunning_ThenTimerStops() {
        let time = 10
        let publisherStub = TimerPublisherStub()
        let sut = TimerModel(isWorkTimer: true, workTime: time, timer: publisherStub.valuePublisher)
        
        sut.startTimer()
        sut.stopTimer()
        (1 ... time).forEach { _ in publisherStub.sendValue() }
        
        XCTAssertEqual(sut.workTime, time - 1)
    }
    
    func test_GivenTimer_WhenTimerIsStop_ThenTimerStartsAgain() {
        let time = 10
        let publisherStub = TimerPublisherStub()
        let sut = TimerModel(isWorkTimer: true, workTime: time, timer: publisherStub.valuePublisher)
        
        sut.startTimer()
        sut.stopTimer()
        (1 ... time).forEach { _ in publisherStub.sendValue() }
        sut.startTimer()
        
        XCTAssertEqual(sut.workTime, time - 2)
        
    }
    
    func test_GivenTimer_WhenTimerIsRunning_ThenTimerStopsAndReloads() {
        let time = 10
        let publisherStub = TimerPublisherStub()
        let sut = TimerModel(isWorkTimer: true, workTime: time, timer: publisherStub.valuePublisher)
        
        sut.startTimer()
        (1 ... 3).forEach { _ in publisherStub.sendValue() }
        XCTAssertTrue(sut.timerInProgress)
        XCTAssertEqual(sut.workTime, 6)
        sut.restartTimer()
        
        XCTAssertFalse(sut.timerInProgress)
        XCTAssertEqual(sut.workTime, 1500)
    }
    
    func test_GivenTimer_WhenIsWorkTimer_ThenChangeToRestTimer() {
        let time = 10
        let publisherStub = TimerPublisherStub()
        let sut = TimerModel(isWorkTimer: true, workTime: time, timer: publisherStub.valuePublisher)
        
        sut.startTimer()
        XCTAssertEqual(sut.isWorkTimer, true)
        XCTAssertEqual(sut.textTimer, "Temps de travail")
        XCTAssertEqual(sut.focusText, "Restez concentrée 👊")
        (1 ... time).forEach { _ in publisherStub.sendValue() }
        
        XCTAssertEqual(sut.isWorkTimer, false)
        XCTAssertEqual(sut.textTimer, "Temps de repos")
        XCTAssertEqual(sut.focusText, "Profitez-en pour vous hydrater 🥤")
    }
    
    private class TimerPublisherStub {
        private let valueSubject = CurrentValueSubject<Date, Never>(.now)
        
        var valuePublisher: AnyPublisher<Date, Never> {
            valueSubject.eraseToAnyPublisher()
        }
        
        func sendValue() {
            valueSubject.send(.now)
        }
    }
}
