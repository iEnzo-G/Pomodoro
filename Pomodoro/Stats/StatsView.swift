import SwiftUI

struct StatsView: View {
    
    var body: some View {
        ZStack {
            Color(CGColor(red: 0.3, green: 0.45, blue: 0.65, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("STATISTIQUES")
                    .foregroundColor(.white)
                    .font(.custom("Avenir Next", size: 20))
                    .bold()
                StatsList()
            }
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
