import SwiftUI

struct ShopListView: View {
    @State private var searchText = ""
    @State private var isModalSheet = false
    var hotPepperModel = HotPepperModel()

    var body: some View {
        GeometryReader { proxy in
            NavigationStack {
                VStack {
                    HeaderView(proxy: proxy)
                    VStack(alignment: .leading) {
                        ScrollView {
//                            HStack {
                                ScrollView(.horizontal) {
                                    HStack {
                                        ForEach(GenreCategory.allCases, id: \.self) { _ in
                                            RoundedRectangle(cornerRadius: 4)
                                                .frame(width: proxy.size.width * 0.3, height: 50)
                                        }
                                    }
//                                    .background(.red)
                                }
//                            }
                            .frame(width: proxy.size.width * 0.9, height: 100)
                            .background(.yellow)

                            LazyVStack {
                                ForEach(0 ..< hotPepperModel.shops.count, id: \.self) { index in
                                    ShopListCell(proxy: proxy, index: index)
                                }
                                .frame(width: proxy.size.width * 0.9, height: 300)
                                .background(.white)
                                .clipShape(.rect(cornerRadius: 12))
                                .shadow(radius: 20)
                                .padding(.bottom)
                            }
                        }
                        .refreshable {
                            hotPepperModel.fetchGourmet()
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white)
                .sheet(isPresented: $isModalSheet) {
                    PickerView(isModalSheet: $isModalSheet, proxy: proxy.size)
                        .presentationDetents([.fraction(0.28)])
                }
            }
            .onAppear {
                hotPepperModel.fetchGourmet()
            }
        }
    }

    @ViewBuilder
    func HeaderView(proxy: GeometryProxy) -> some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
                TextField("Search ...", text: $searchText)
                    .onSubmit {
                        hotPepperModel.searchWord = searchText
                        hotPepperModel.fetchGourmet()
                    }
                if !searchText.isEmpty {
                    Button {
                        self.searchText.removeAll()
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal, 15)
            .frame(width: proxy.size.width * 0.8, height: 35)
            .background(Color(.systemGray6))
            .clipShape(.rect(cornerRadius: 12))
            Button {
                isModalSheet = true
            } label: {
                Image(systemName: "slider.horizontal.3")
                    .foregroundStyle(.black)
                    .font(.title)
                    .frame(width: proxy.size.width * 0.1, height: 35)
            }
        }
        .frame(width: proxy.size.width, height: 35, alignment: .center)
    }

    @ViewBuilder
    private func ShopListCell(proxy: GeometryProxy, index: Int) -> some View {
        NavigationLink {
            ShopDetailView(model: hotPepperModel, section: index)
        } label: {
            VStack(spacing: 0) {
                VStack {
                    if let imageUrl = URL(string: hotPepperModel.shops[index].photo?.pc.large ?? "na") {
                        AsyncImage(url: imageUrl) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: proxy.size.width * 0.9, height: 150)
                                .clipped()
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                .frame(width: proxy.size.width * 0.9, height: 150)
                VStack(alignment: .leading, spacing: 5) {
                    Text(hotPepperModel.shops[index].name)
                        .foregroundStyle(.black)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                    HStack {
                        Image(systemName: "fork.knife")
                        Text(hotPepperModel.shops[index].genre.name)
                        Image(systemName: "yensign")
                        Text(hotPepperModel.shops[index].budget.name)
                    }
                    .font(.system(size: 13))
                    .foregroundStyle(.gray)
                    HStack {
                        Image(systemName: "mappin")
                        Text(hotPepperModel.shops[index].mobileAccess)
                    }
                    .font(.system(size: 13))
                    .foregroundStyle(.gray)
                }
//                .frame(maxWidth: .infinity)
                .frame(height: 100, alignment: .leading)
                .padding(.leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
}

#Preview {
    ShopListView(hotPepperModel: HotPepperModel())
}
