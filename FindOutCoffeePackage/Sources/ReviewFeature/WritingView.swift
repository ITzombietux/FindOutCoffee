//
//  WritingView.swift
//  
//
//  Created by 김혜지 on 2023/08/14.
//

import SwiftUI
import PhotosUI

extension ReviewContentView {
    struct WritingView: View {
        @State private var selectedItem: PhotosPickerItem? = nil
        @State private var selectedItemData: Data? = nil
        
        @Binding var text: String
        
        var body: some View {
            VStack(spacing: 20) {
                PhotosPicker(selection: $selectedItem, matching: .images, preferredItemEncoding: .automatic, photoLibrary: .shared()) {
                    if let selectedItemData,
                       let uiImage = UIImage(data: selectedItemData)
                    {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width - 40, height: (UIScreen.main.bounds.width - 40) * 3 / 4)
                    } else {
                        ZStack {
                            Color.gray
                            
                            Text("사진을 첨부해주세요!")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .frame(width: UIScreen.main.bounds.width - 40, height: (UIScreen.main.bounds.width - 40) * 3 / 4)
                    }
                }
                .onChange(of: selectedItem) { newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            self.selectedItemData = data
                        }
                    }
                }
                
                TextEditor(text: $text)
                    .foregroundColor(.secondary)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke()
                            .foregroundColor(.gray)
                    )
                    .padding(.horizontal, 20)
                
                Spacer()
            }
        }
    }
}

struct WritingView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.WritingView(text: .constant("TextEditor is testing"))
    }
}
