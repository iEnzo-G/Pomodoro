import SwiftUI
import FirebaseAnalytics

struct TimerView: View {
    
    // MARK: - Properties
    
    @ObservedObject var timer: TimerModel
    @State var showSaveSessionView = false
    
    init() {
        self.timer = TimerModel(isWorkTimer: true,
                                workTime: 1,
                                timer: Timer.publish(every: 1, on: .main, in: .common).autoconnect().eraseToAnyPublisher())
    }
    
    var body: some View {
        VStack() {
            Text(timer.textTimer)
                .font(.custom("Avenir Next", size: 35))
                .foregroundColor(.white)
            Text("\(timer.workTime / 60) : \(timer.workTime % 60, specifier: "%02d")")
                .font(.custom("Avenir Next", size: 70))
                .bold()
                .foregroundColor(.white)
                .shadow(radius: 3)
            Text(timer.focusText)
                .font(.custom("Avenir Next", size: 20))
                .bold()
                .foregroundColor(.white)
            
            HStack() {
                if timer.timerInProgress == true {
                    if timer.isWorkTimer == true {
                        ButtonShape(buttonText: "PAUSE", buttonColor: .red) {
                            timer.stopTimer()
                        }
                    }
                } else {
                    ButtonShape(buttonText: "START", buttonColor: .green) {
                        Analytics.logEvent("start_timer", parameters: nil)
                        timer.startTimer()
                    }
                    .padding(.trailing, 10)
                }
                if timer.isWorkTimer == true {
                    ButtonShape(buttonText: "RESTART", buttonColor: .blue) {
                        timer.restartTimer()
                    }
                } else {
                    if timer.timerInProgress == false {
                        ButtonShape(buttonText: "SAUVEGARDER", buttonColor: .red) {
                            Analytics.logEvent("save_session", parameters: nil)
                            showSaveSessionView = true
                            timer.startTimer()
                        }
                    }
                }
                if timer.isWorkTimer == false, timer.timerInProgress == true {
                    ButtonShape(buttonText: "PASSER", buttonColor: .red) {
                        Analytics.logEvent("skip_restTime", parameters: nil)
                        timer.stopTimer()
                        timer.workTime = 0
                        timer.changeTimer()
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showSaveSessionView) {
            SaveSessionView()
        }
    }
}
    
struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}	
