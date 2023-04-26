import SwiftUI

struct SaveSessionView: View {
    @State private var text: String = ""
    @Environment(\.presentationMode) var presentationMode
    let coreDataSore = CoreDataStore()
    let date = Date()
    
    var body: some View {
        ZStack {
            Color(CGColor(red: 0.3, green: 0.45, blue: 0.65, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Spacer()
                    Text("Ajouter la session ?")
                        .font(.custom("Avenir Next", size: 25))
                        .bold()
                        .foregroundColor(.white)
                        .shadow(radius: 3)
                    Spacer()
                    ButtonShape(buttonText: "X", buttonColor: .red) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                HStack {
                    TextField("Quel activité avez vous réaliser ?", text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Spacer()
                    if text != "" {
                        ButtonShape(buttonText: "OK", buttonColor: .blue) {
                            coreDataSore.saveSession(Session(day: date, workTime: 1500, title: text.uppercased()))
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
            .padding()
        }
        
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SaveSessionView()
    }
}
