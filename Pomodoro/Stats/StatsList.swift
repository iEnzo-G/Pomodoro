import SwiftUI
import FirebaseAnalytics

struct StatsList: View {
    
    @State var sessions: [Session] = []
    @State private var mergedSessions: [[Session]] = []
    var coreDataStore = CoreDataStore()
    private var hoursFormatter: DateFormatter {
        let hoursFormatter = DateFormatter()
        hoursFormatter.dateFormat = "HH:mm"
        return hoursFormatter
    }
    
    private func groupSessionsByTitle(sessions: [Session]) -> [[Session]] {
        let groupedSessions = sessions.reduce(into: [[Session]]()) { (result, session) in
            let title = session.title
            if let index = result.firstIndex(where: { $0.first?.title == title }) {
                result[index].append(session)
            } else {
                result.append([session])
            }
        }
        return groupedSessions
    }
    
    var body: some View {
        List {
            ForEach(Array(mergedSessions.enumerated()), id: \.element) { index, sessions in
                Section(header: Text(getSectionTitle(for: sessions))) {
                    ForEach(sessions, id: \.self) { session in
                        HStack {
                            Text("\(hoursFormatter.string(from: session.day))")
                            Spacer()
                            Text("-")
                            Spacer()
                            Text("\(session.workTime / 60) minutes")
                        }
                    }
                    .onDelete(perform: { indexSet in
                                        deleteSession(at: indexSet, sectionIndex: index)
                                    })
                }
            }
        }
        .onAppear() {
            sessions = coreDataStore.getSessions()
            mergedSessions = groupSessionsByTitle(sessions: sessions)
        }
    }
    
    private func deleteSession(at offsets: IndexSet, sectionIndex: Int) {
        for offset in offsets {
            let sessionToDelete = mergedSessions[sectionIndex][offset]
            mergedSessions[sectionIndex].remove(at: offset)
            coreDataStore.deleteSession(sessionToDelete)
            sessions = coreDataStore.getSessions()
            Analytics.logEvent("delete_session", parameters: nil)
        }
    }
    
    private func getSectionTitle(for sessions: [Session]) -> String {
        guard let title = sessions.first?.title else { return ""}
        return title
    }
}

struct StatsRow_Previews: PreviewProvider {
    static var previews: some View {
        StatsList(sessions: [Session(day: Date(), workTime: 1500, title: "P12"),
                            Session(day: Date(), workTime: 1500, title: "P09"),
                            Session(day: Date(), workTime: 1500, title: "P11"),
                            Session(day: Date(), workTime: 1500, title: "P12"),
                            Session(day: Date(), workTime: 1500, title: "P10"),
                            Session(day: Date(), workTime: 1500, title: "P11"),
                            Session(day: Date(), workTime: 1500, title: "P12")])
        .padding()
    }
}


