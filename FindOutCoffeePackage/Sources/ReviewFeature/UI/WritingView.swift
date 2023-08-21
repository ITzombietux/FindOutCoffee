//
//  WritingView.swift
//
//
//  Created by 김혜지 on 2023/08/14.
//

import SwiftUI
import PhotosUI

public typealias PhotoItem = PhotosPickerItem

extension ReviewContentView {
    struct WritingView: View {
        private let columns: [GridItem] = Array(repeating: GridItem(), count: 2)
        
        @State private var items: [PhotosPickerItem] = []
        @Binding var photo: [Data]?
        @Binding var text: String
        
        init(photo: Binding<[Data]?>, text: Binding<String>) {
            self._photo = photo
            self._text = text
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 10) {
                    photosPicker()
                    
                    ForEach(self.photo ?? [], id: \.self) { data in
                        photoView(data: data)
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
                    .toolbar {
                        ToolbarItem(placement: .keyboard) {
                            Button("완료") {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                        }
                    }
                
                Spacer()
            }
            .onChange(of: items) { newItema in
                Task {
                    var itemsData: [Data] = []
                    for item in self.items {
                        guard let data = try? await item.loadTransferable(type: Data.self) else { continue }
                        itemsData.append(data)
                    }
                    self.photo = itemsData
                }
            }
            .onTapGesture {
                print("TAP!")
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        
        @ViewBuilder
        private func photoView(data: Data) -> some View {
            if let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: (UIScreen.main.bounds.width - (10 * 3) - (20 * 2)) / 4, height: (UIScreen.main.bounds.width - (10 * 3) - (20 * 2)) / 4)
            }
        }
        
        private func photosPicker() -> some View {
            PhotosPicker(selection: $items,
                         maxSelectionCount: 3,
                         matching: .images,
                         preferredItemEncoding: .automatic,
                         photoLibrary: .shared())
            {
                ZStack {
                    Rectangle()
                        .stroke()
                        .foregroundColor(.gray)
                    
                    VStack {
                        Image(systemName: "camera.fill")
                            .foregroundColor(.gray)
                        
                        Text("\(self.photo?.count ?? 0)/3")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.gray)
                    }
                }
                .frame(width: (UIScreen.main.bounds.width - (10 * 3) - (20 * 2)) / 4, height: (UIScreen.main.bounds.width - (10 * 3) - (20 * 2)) / 4)
            }
        }
    }
}

struct WritingView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.WritingView(photo: .constant([]), text: .constant(""))
    }
}
