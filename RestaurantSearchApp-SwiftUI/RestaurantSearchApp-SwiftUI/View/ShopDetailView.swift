import SwiftUI

struct ShopDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State private var likeButton = false
    let basicInformation = [
        BasicInformation(id: 0, image: "mappin", title: "住所"),
        BasicInformation(id: 1, image: "tram.fill", title: "アクセス"),
        BasicInformation(id: 2, image: "yensign", title: "予算"),
        BasicInformation(id: 3, image: "clock", title: "営業時間"),
        BasicInformation(id: 4, image: "clock", title: "定休日"),
        BasicInformation(id: 5, image: "creditcard", title: "クレジットカード"),
        BasicInformation(id: 6, image: "chair.lounge", title: "個室"),
        BasicInformation(id: 7, image: "smoking", title: "禁煙"),
        BasicInformation(id: 8, image: "parkingsign", title: "駐車")
    ]
    var model: HotPepperModel
    var section: Int

    var body: some View {
        VStack {
            ScrollView {
                if model.shops.count > 5 {
                    VStack(spacing: -30) {
                        ShopImageView()
                        ShopDetailView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                } else {
                    ProgressView()
                        .background(.blue)
                }
            }
            HStack {
                Button {
                    likeButton.toggle()
                    Haptics.lightImpact()
                } label: {
                    Image(systemName: likeButton ? "heart.fill" : "heart")
                        .foregroundStyle(likeButton ? .red : .black)
                }
                .frame(width: 40, height: 40)
                .background(.white)
                .clipShape(.rect(cornerRadius: 8))
                .padding(.trailing, 25)
                Button {
                    
                } label: {
                    Text("予約する")
                        .frame(width: 250, height: 40)
                        .foregroundStyle(.white)
                        .background(.red)
                        .clipShape(.rect(cornerRadius: 8))
                }
            }
            .padding(.top)
            .frame(width: UIScreen.main.bounds.width, height: 55)
            .background(.clear)
            .offset(y: -20)
            .shadow(radius: 10)
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar(.hidden)
        .onAppear {
            model.fetchGourmet()
        }
    }

    @ViewBuilder
    func ShopImageView() -> some View {
        GeometryReader { geometry in
            let minY = geometry.frame(in: .named("SCROLL")).minY
            let size = geometry.size
            let height = size.height + minY
            if let imageUrl = URL(string: model.shops[section].photo?.pc.large ?? "na") {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: height, alignment: .top)
                        .clipped()
                        .overlay(content: {
                            ZStack(alignment: .top) {
                                LinearGradient(colors: [.clear, .black.opacity(0.7)], startPoint: .top, endPoint: .bottom)
                                
                                VStack(alignment: .leading) {
                                    Button {
                                        dismiss()
                                    } label: {
                                        Image(systemName: "chevron.backward")
                                            .frame(width: 20, height: 20)
                                            .foregroundStyle(.white)
                                            .fontWeight(.bold)
                                            .padding(10)
                                            .background(.ultraThinMaterial)
                                            .clipShape(Circle())
                                    }
                                }
                                .padding(10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.top, size.height * 0.13)
                        })
                        .offset(y: -minY)
                } placeholder: {
                    ProgressView()
                }
            }
        }
        .frame(height: 300)
    }

    @ViewBuilder
    func ShopDetailView() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(model.shops[section].name)
                .foregroundStyle(.black)
                .font(.system(size: 28))
                .fontWeight(.medium)
                .padding(.vertical)
            HStack {
                Image(systemName: "fork.knife")
                Text(model.shops[section].genre.name)
                Image(systemName: "yensign")
                Text(model.shops[section].budget.name)
            }
            .font(.system(size: 15))
            .foregroundStyle(.gray)
            HStack {
                Image(systemName: "mappin")
                Text(model.shops[section].mobileAccess)
            }
            .font(.system(size: 15))
            .foregroundStyle(.gray)
            Text("基本情報")
                .font(.system(size: 20))
                .padding(.vertical)
            LazyVStack(alignment: .leading, spacing: 5) {
                ForEach(0 ..< basicInformation.count, id: \.self) { index in
                    HStack {
                        Image(basicInformation[index].image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                        Text(basicInformation[index].title)
                            .font(.system(size: 13))
                    }
                    VStack {
                        switch basicInformation[index].id {
                        case 0:
                            Text(model.shops[section].address)
                        case 1:
                            Text(model.shops[section].mobileAccess)
                        case 2:
                            Text(model.shops[section].budget.name)
                        case 3:
                            Text(model.shops[section].open)
                        case 4:
                            Text(model.shops[section].close)
                        case 5:
                            Text(model.shops[section].card)
                        case 6:
                            Text(model.shops[section].privateRoom)
                        case 7:
                            Text(model.shops[section].nonSmoking)
                        case 8:
                            Text(model.shops[section].parking)
                        default:
                            Text("情報がありません。")
                        }
                    }
                    .font(.system(size: 13))
                    .padding(.horizontal, 27)
                    .padding(.bottom)
                }
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width, alignment: .top)
        .foregroundStyle(.black)
        .background(.white)
        .clipShape(.rect(cornerRadius: 30))
    }
}

#Preview {
    ShopDetailView(model: HotPepperModel(), section: 9)
}

struct BasicInformation {
    var id: Int
    var image: String
    var title: String
}
