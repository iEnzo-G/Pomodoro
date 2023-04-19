import Foundation
import Combine

class TimerModel : ObservableObject {
    
    // MARK: - Properties
    
    @Published var isWorkTimer: Bool
    @Published var workTime: Int
    @Published var timerInProgress = false
    var focusText = "Restez concentrée 👊"
    var textTimer = "Temps de travail"
    private var timerCancellable: Cancellable?
    private var timer: AnyPublisher<Date, Never>
    
    
    init(isWorkTimer: Bool, workTime: Int, timer: AnyPublisher<Date, Never>) {
        self.workTime = workTime
        self.isWorkTimer = isWorkTimer
        self.timer = timer
    }
    
    // MARK: - Functions
    
    func stopTimer() {
        timerInProgress = false
        timerCancellable?.cancel()
    }
    
    func startTimer() {
        guard workTime > 0 else { return }
        timerInProgress = true
        timerCancellable = timer
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else { return }
                if self.workTime > 0 {
                    self.workTime -= 1
                } else {
                    self.stopTimer()
                    self.changeTimer()
                }
            })
    }
    
    func restartTimer() {
        timerCancellable?.cancel()
        timerInProgress = false
        workTime = isWorkTimer == true ? 1500 : 300
    }
    
    func changeTimer() {
        guard workTime == 0 else { return }
        isWorkTimer = isWorkTimer == true ? false : true
        workTime = isWorkTimer == true ? 1500 : 300
        textTimer = isWorkTimer == true ? "Temps de travail" : "Temps de repos"
        focusText = isWorkTimer == true ? "Restez concentrée 👊" : "Profitez-en pour vous hydrater 🥤"
    }
}
