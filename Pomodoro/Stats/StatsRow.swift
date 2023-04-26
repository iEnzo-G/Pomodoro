import SwiftUI
import FirebaseAnalytics

struct StatsRow: View {
    
    var sessions: [Session] = []
    var coreDataStore = CoreDataStore()
    @State var isTapped = false
    @State var mergedSessions: [String : [Session]] = [:]
    
    var body: some View {
        VStack {
            ForEach(mergedSessions.keys.sorted(), id: \.self) { day in
                Text(day)
                    .font(.custom("Avenir Next", size: 20))
                    .onTapGesture {
                        isTapped.toggle()
                    }
            }
                if isTapped {
                    HStack {
                        var hoursFormatter: String {
                            let formatter = DateFormatter()
                            formatter.dateFormat = "hh:mm"
                            return formatter.string(from: sessions[0].day)
                        }
                        Text(hoursFormatter)
                            .font(.custom("Avenir Next", size: 20))
                        Text("(\(sessions[0].title))")
                            .font(.custom("Avenir Next", size: 20))
                        Spacer()
                        Text("-")
                            .font(.custom("Avenir Next", size: 20))
                        Spacer()
                        Text("\(sessions[0].workTime / 60) min")
                            .font(.custom("Avenir Next", size: 20))
                        Button("X") {
//                            Analytics.logEvent("delete_session", parameters: nil)
                            coreDataStore.deleteSession(sessions[0])
                        }
                        .foregroundColor(.red)
                        .buttonStyle(.borderless)
                        .shadow(radius: 1)
                    }
                }
            }
        .onAppear() {
            mergedSessions = groupSessionsByDay(sessions: sessions)
        }
    }
    
    func groupSessionsByDay(sessions: [Session]) -> [String : [Session]] {
        let groupedSessions = sessions.reduce(into: [String: [Session]]()) { (result, session) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM yyyy"
            dateFormatter.locale = Locale(identifier: "fr")
            let day = dateFormatter.string(from: session.day)
            if result[day] == nil {
                result[day] = [session]
            } else {
                result[day]?.append(session)
            }
        }
        return groupedSessions
    }
}
    struct StatsRow_Previews: PreviewProvider {
        static var previews: some View {
            StatsRow(sessions: [Session(day: Date(), workTime: 1500, title: "P12"), Session(day: Date(), workTime: 1500, title: "P11")])
                .padding()
        }
    }
