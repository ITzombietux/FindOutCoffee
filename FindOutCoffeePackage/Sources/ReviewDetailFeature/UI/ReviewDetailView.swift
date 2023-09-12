//
//  ReviewDetailView.swift
//  
//
//  Created by Joy on 2023/09/08.
//

import SwiftUI

import ComposableArchitecture

public struct ReviewDetailView: View {
    private let store: StoreOf<ReviewDetail>
    
    public init(review: ReviewDetail.Review) {
        self.store = Store(initialState: ReviewDetail.State(review: review), reducer: { ReviewDetail() })
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: \.review, send: { .view($0) }) { viewStore in
            VStack(spacing: 10) {
                navigationBar(coffeeName: viewStore.coffeeName)
                
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 20) {
                        imageSection(urls: viewStore.imageURLs, category: viewStore.category, isRecommend: viewStore.isRecommend)
                        
                        tagSection(tags: viewStore.tags)
                        
                        textSection(text: viewStore.text, writer: viewStore.writer, date: viewStore.date)
                        
                        Spacer()
                    }
                }
                
                Button {
                    viewStore.send(.likeButtonTapped)
                } label: {
                    ZStack {
                        Capsule()
                            .foregroundColor(.blue)
                        
                        Text("찾았다, 인생커피!")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                    }
                }
                .frame(height: 30)
                .padding(.horizontal, 20)
            }
        }
    }
    
    private func navigationBar(coffeeName: String) -> some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                HStack(spacing: 0) {
                    Spacer()
                    
                    Text(coffeeName)
                        .font(.system(size: 20, weight: .bold))
                    
                    Spacer()
                }
                
                HStack(spacing: 0) {
                    Button {
                        viewStore.send(.view(.dismissButtonTapped))
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    .foregroundColor(.black)
                    
                    Spacer()
                }
            }
            .frame(height: 44)
            .padding(.horizontal, 20)
        }
    }
    
    private func imageCell(url: String) -> some View {
        AsyncImage(url: URL(string: "")) { image in
            image.resizable()
        } placeholder: {
            Color.blue
        }
    }
    
    private func imageSection(urls: [String], category: String, isRecommend: Bool) -> some View {
        ZStack(alignment: .bottomTrailing) {
            TabView() {
                ForEach(urls, id: \.self) { url in
                    imageCell(url: url)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            imageTagList(category: category, isRecommend: isRecommend)
                .padding(10)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 2 / 3)
    }
    
    private func tagCell(title: String) -> some View {
        Text(title)
            .font(.system(size: 15, weight: .medium))
            .padding(5)
            .background(
                Capsule()
                    .stroke()
                    .foregroundColor(.gray)
            )
    }
    
    private func tagSection(tags: [String]) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("이 음료는 ____ 해요.")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.gray)
                
                HStack(spacing: 10) {
                    ForEach(tags, id: \.self) { tag in
                        tagCell(title: tag)
                    }
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    private func imageTagCell(imageName: String, title: String) -> some View {
        VStack(spacing: 5) {
            Image(imageName)
                .frame(width: 20, height: 40)
            
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(5)
        .frame(width: 60, height: 60)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke()
                .foregroundColor(.white)
        )
    }
    
    private func imageTagList(category: String, isRecommend: Bool) -> some View {
        HStack(spacing: 10) {
            imageTagCell(imageName: "category", title: category)
            
            imageTagCell(imageName: "recommend", title: isRecommend ? "추천" : "비추천")
        }
    }
    
    private func textSection(text: String, writer: String, date: String) -> some View {
        VStack(spacing: 20) {
            Text(text)
                .font(.system(size: 15, weight: .medium))
            
            HStack {
                Text("작성자: \(writer)")
                    .font(.system(size: 12, weight: .medium))
                
                Spacer()
                
                Text(date)
                    .font(.system(size: 12, weight: .medium))
            }
            .foregroundColor(.gray)
        }
        .padding(.horizontal, 20)
    }
}

struct ReviewDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewDetailView(review: .mock)
    }
}

public extension Notification.Name {
    static let dismissReviewDetailView = Notification.Name("dismissReviewDetailView")
}
