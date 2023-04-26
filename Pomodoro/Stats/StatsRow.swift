import SwiftUI
import FirebaseAnalytics

struct StatsRow: View {
    
    @State var sessions: [Session] = []
    @State private var mergedSessions: [String : [Session]] = [:]
    var coreDataStore = CoreDataStore()
    private var hoursFormatter: DateFormatter {
        let hoursFormatter = DateFormatter()
        hoursFormatter.dateFormat = "HH:mm"
        return hoursFormatter
    }
    
    
    func groupSessionsByTitle(sessions: [Session]) -> [String: [Session]] {
        let groupedSessions = sessions.reduce(into: [String: [Session]]()) { (result, session) in
            let title = session.title
            if result[title] == nil {
                result[title] = [session]
            } else {
                result[title]?.append(session)
            }
        }
        return groupedSessions
    }
    
    var body: some View {
        List {
            ForEach(Array(mergedSessions.keys), id: \.self) { key in
                Section(header: Text(key)) {
                    ForEach(mergedSessions[key]!, id: \.self) { session in
                        HStack {
                            Text("\(hoursFormatter.string(from: session.day))")
                            Spacer()
                            Text("-")
                            Spacer()
                            Text("\(session.workTime / 60) minutes")
                        }
                    }
                }
            }
            .onDelete(perform: deleteSession)
        }
        .onAppear() {
            sessions = coreDataStore.getSessions()
            mergedSessions = groupSessionsByTitle(sessions: sessions)
        }
    }
    
    func deleteSession(at offsets: IndexSet) {
        for index in offsets {
            let session = mergedSessions.flatMap({ $0.value })[index]
            coreDataStore.deleteSession(session)
        }
        mergedSessions = groupSessionsByTitle(sessions: sessions)
    }
}
struct StatsRow_Previews: PreviewProvider {
    static var previews: some View {
        StatsRow(sessions: [Session(day: Date(), workTime: 1500, title: "P12"),
                            Session(day: Date(), workTime: 1500, title: "P09"),
                            Session(day: Date(), workTime: 1500, title: "P11"),
                            Session(day: Date(), workTime: 1500, title: "P12"),
                            Session(day: Date(), workTime: 1500, title: "P10"),
                            Session(day: Date(), workTime: 1500, title: "P11"),
                            Session(day: Date(), workTime: 1500, title: "P12")])
        .padding()
    }
}


