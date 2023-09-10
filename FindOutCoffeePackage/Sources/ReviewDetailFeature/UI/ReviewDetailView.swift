//
//  ReviewDetailView.swift
//  
//
//  Created by Joy on 2023/09/08.
//

import SwiftUI

import ComposableArchitecture

public struct ReviewDetailView: View {
    
    
    public init() {
        
    }
    
    public var body: some View {
        VStack(spacing: 10) {
            navigationBar()
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 20) {
                    imageSection()
                    
                    tagSection()
                    
                    textSection()
                    
                    Spacer()
                }
            }
            
            likeButton()
        }
    }
    
    private func navigationBar() -> some View {
        ZStack {
            HStack(spacing: 0) {
                Spacer()
                
                Text("음료 이름")
                    .font(.system(size: 20, weight: .bold))
                
                Spacer()
            }
            
            HStack(spacing: 0) {
                Button {
                    
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
    
    private func imageCell(url: String) -> some View {
        AsyncImage(url: URL(string: "")) { image in
            image.resizable()
        } placeholder: {
            Color.blue
        }
    }
    
    private func imageSection() -> some View {
        ZStack(alignment: .bottomTrailing) {
            TabView() {
                ForEach(0..<3) { _ in
                    imageCell(url: "")
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            imageTagList()
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
    
    private func tagSection() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("이 음료는 ____ 해요.")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.gray)
                
                HStack(spacing: 10) {
                    ForEach(0..<2) { index in
                        tagCell(title: "🔖 태그\(index)")
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
    
    private func imageTagList() -> some View {
        HStack(spacing: 10) {
            imageTagCell(imageName: "category", title: "카테고리")
            
            imageTagCell(imageName: "recommend", title: "추천")
        }
    }
    
    private func textSection() -> some View {
        Text("직접 작성한 리뷰입니다. 직접 작성한 리뷰입니다. 직접 작성한 리뷰입니다. 직접 작성한 리뷰입니다. 직접 작성한 리뷰입니다. 직접 작성한 리뷰입니다.")
            .font(.system(size: 15, weight: .medium))
            .padding(.horizontal, 20)
    }
    
    private func likeButton() -> some View {
        Button {
            
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

struct ReviewDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewDetailView()
    }
}
