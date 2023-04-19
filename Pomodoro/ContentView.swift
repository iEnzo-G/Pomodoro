import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ZStack {
                Color(CGColor(red: 0.3, green: 0.45, blue: 0.65, alpha: 1))
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    TimerView()
                }
            }.tabItem {
                Label("Pomm'doro", systemImage: "stopwatch")
            }
            ZStack {
                Color(CGColor(red: 0.3, green: 0.45, blue: 0.65, alpha: 1))
                    .edgesIgnoringSafeArea(.all)
                StatsView()
            }.tabItem {
                Label("Statistiques", systemImage: "chart.line.uptrend.xyaxis")
            }
        }
        .accentColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 14 Pro", "iPhone SE (3rd generation)"], id: \.self) { deviceName in
            ContentView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
        }
    }
}
