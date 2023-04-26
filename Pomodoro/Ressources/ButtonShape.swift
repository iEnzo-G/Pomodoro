import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct ButtonShape: View {
    var buttonText: String
    var buttonColor: Color
    var action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(buttonText)
                .font(.custom("Avenir Next", size: 20))
                .bold()
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(buttonColor)
                .clipShape(RoundedCorner(radius: 14))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(.white, lineWidth: 4)
                )
                .shadow(radius: 3)
        }
    }
}

struct ButtonShape_Previews: PreviewProvider {
    static var previews: some View {
        ButtonShape(buttonText: "START", buttonColor: .purple) {
        }
    }
}
