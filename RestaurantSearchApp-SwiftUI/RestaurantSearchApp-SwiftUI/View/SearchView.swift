import SwiftUI

struct PickerView: View {
    @State private var range = ["300m", "500m", "1000m", "2000m", "3000m"]
    @Binding var isModalSheet: Bool
    let proxy: CGSize

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                isModalSheet = false
            }) {
                Text("完了")
            }
        }
        .foregroundColor(.primary)
        .padding(.horizontal)
        .frame(width: proxy.width * 0.95, height: proxy.height * 0.05)
        .padding()
        Picker("", selection: $range) {
            ForEach(range, id: \.self) { type in
                Text("\(type)")
                    .tag(type)
            }
        }
        .pickerStyle(.wheel)
    }
}

#Preview {
    PickerView(isModalSheet: .constant(false), proxy: UIScreen.main.bounds.size)
}
