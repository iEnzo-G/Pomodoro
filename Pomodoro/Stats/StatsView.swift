import SwiftUI

struct StatsView: View {
    let coreDataStore = CoreDataStore()
    @State var sessions: [Session] = []
    
    var body: some View {
        ZStack {
            Color(CGColor(red: 0.3, green: 0.45, blue: 0.65, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("STATISTIQUES")
                    .foregroundColor(.white)
                    .font(.custom("Avenir Next", size: 20))
                    .bold()
                List() {
                    ForEach(0..<sessions.count, id: \.self) { index in
                        StatsRow(sessions: [Session(day: sessions[index].day, workTime: sessions[index].workTime , title: sessions[index].title)])
                    }
                }
                .listStyle(PlainListStyle())
                .background(Color(CGColor(red: 0.3, green: 0.45, blue: 0.65, alpha: 1)))
            }
        }
        .onAppear() {
            sessions = coreDataStore.getSessions()
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(sessions: [Session(day: Date(), workTime: 1500, title: "Tt"),Session(day: Date(), workTime: 1500, title: "Tot")])
    }
}
