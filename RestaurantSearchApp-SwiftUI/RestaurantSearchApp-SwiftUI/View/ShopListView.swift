import SwiftUI

struct ShopListView: View {
    @State private var searchText = ""
    var hotPepperViewModel = HotPepperViewModel()

    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                VStack {
                    SearchView(proxy: geometry)
                    VStack(alignment: .leading) {
                        ScrollView {
                            HStack {
                                ScrollView(.horizontal) {
                                    LazyHStack {
                                        ForEach(0 ..< 5) { _ in
                                            Circle()
                                                .padding()
                                        }
                                    }
                                }
                            }
                            .frame(width: geometry.size.width * 0.9, height: 100)
                            .background(.yellow)
//                            Text("おすすめ")
                            LazyVStack {
                                ForEach(0..<hotPepperViewModel.shops.count, id: \.self) { index in
                                    NavigationLink {
                                        ShopDetailView(model: hotPepperViewModel, section: index)
                                    } label: {
                                        VStack(spacing: 0) {
                                            VStack {
                                                if let imageUrl = URL(string: hotPepperViewModel.shops[index].photo?.pc.large ?? "na") {
                                                    AsyncImage(url: imageUrl) { image in
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: geometry.size.width * 0.9, height: 200)
                                                            .clipped()
                                                    } placeholder: {
                                                        ProgressView()
                                                    }
                                                }
                                            }
                                            .frame(width: geometry.size.width * 0.9, height: 200)
                                            VStack(alignment: .leading, spacing: 5) {
                                                Text(hotPepperViewModel.shops[index].name)
                                                    .foregroundStyle(.black)
                                                    .font(.system(size: 18))
                                                    .fontWeight(.medium)
                                                HStack {
                                                    Image(systemName: "fork.knife")
                                                    Text(hotPepperViewModel.shops[index].genre.name)
                                                    Image(systemName: "yensign")
                                                    Text(hotPepperViewModel.shops[index].budget.name)
                                                }
                                                .font(.system(size: 13))
                                                .foregroundStyle(.gray)
                                                HStack {
                                                    Image(systemName: "mappin")
                                                    Text(hotPepperViewModel.shops[index].mobileAccess)
                                                }
                                                .font(.system(size: 13))
                                                .foregroundStyle(.gray)
                                            }
                                            .frame(width: geometry.size.width * 0.9, height: 100, alignment: .leading)
                                            .padding(.leading)
                                        }
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    }
                                }
                                .frame(width: geometry.size.width * 0.9, height: 300)
                                .background(.white)
                                .clipShape(.rect(cornerRadius: 12))
                                .shadow(radius: 20)
                                .padding(.bottom)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white)
            }
            .onAppear {
                hotPepperViewModel.fetchGourmet()
            }
        }
    }

    @ViewBuilder
    func SearchView(proxy: GeometryProxy) -> some View {
        HStack {
           Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)
           TextField("Search ...", text: $searchText)
                .onSubmit {
                    hotPepperViewModel.searchWord = searchText
                    hotPepperViewModel.fetchGourmet()
                }
            if !searchText.isEmpty {
               Button(action: {
                   self.searchText.removeAll()
               }){
                   Image(systemName: "multiply.circle.fill")
                       .foregroundColor(.gray)
               }
           }
        }
        .padding(.horizontal, 15)
       .frame(width: proxy.size.width * 0.9, height: 35)
       .background(Color(.systemGray6))
       .clipShape(.rect(cornerRadius: 8))
       .padding(.bottom)
    }
}

#Preview {
    ShopListView(hotPepperViewModel: HotPepperViewModel())
}
