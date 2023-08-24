//
//  WritingView.swift
//
//
//  Created by 김혜지 on 2023/08/14.
//

import SwiftUI
import PhotosUI
import DesignSystem

public typealias PhotoItem = PhotosPickerItem

extension ReviewContentView {
    struct WritingView: View {
        private let columns: [GridItem] = Array(repeating: GridItem(), count: 2)
        private let placeholder: String = "직접 후기를 입력해주세요!"
        
        @FocusState var isFocused: Bool
        @State private var items: [PhotosPickerItem] = []
        @Binding var photo: [Data]?
        @Binding var text: String?
        
        init(photo: Binding<[Data]?>, text: Binding<String?>) {
            self._photo = photo
            self._text = text
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text("직접 후기를 작성해주세요!\n여기는 선택사항이에요☺️")
                    .font(.system(size: 25, weight: .bold))
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        HStack(spacing: 10) {
                            photosPicker()
                            
                            ForEach(0..<3) { index in
                                if let data = self.photo?[index] {
                                    photoCell(data: data) {
                                        self.items.remove(at: index)
                                    }
                                } else {
                                    emptyCell()
                                }
                            }
                        }
                        
                        textView()
                        
                        Spacer()
                    }
                }
            }
            .onChange(of: items) { _ in
                Task {
                    var itemsData: [Data] = []
                    for item in self.items {
                        guard let data = try? await item.loadTransferable(type: Data.self) else { continue }
                        itemsData.append(data)
                    }
                    self.photo = itemsData
                }
            }
        }
        
        @ViewBuilder
        private func photoCell(data: Data, completion: @escaping () -> Void) -> some View {
            if let uiImage = UIImage(data: data) {
                ZStack(alignment: .topTrailing) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Rectangle())
                        .frame(width: (UIScreen.main.bounds.width - (10 * 3) - (20 * 2)) / 4, height: (UIScreen.main.bounds.width - (10 * 3) - (20 * 2)) / 4)
                    
                    Button {
                        completion()
                    } label: {
                        Image(systemName: "multiply")
                            .foregroundColor(.white)
                            .frame(width: (UIScreen.main.bounds.width - (10 * 3) - (20 * 2)) / 4 / 9, height: (UIScreen.main.bounds.width - (10 * 3) - (20 * 2)) / 4 / 9)
                            .background(
                                Circle()
                                    .foregroundColor(.gray.opacity(0.7))
                            )
                    }
                }
            }
        }
        
        private func emptyCell() -> some View {
            Rectangle()
                .foregroundColor(.imagePlaceholderColor)
                .frame(width: (UIScreen.main.bounds.width - (10 * 3) - (20 * 2)) / 4, height: (UIScreen.main.bounds.width - (10 * 3) - (20 * 2)) / 4)
                .cornerRadius(12)
        }
        
        private func photosPicker() -> some View {
            PhotosPicker(selection: $items,
                         maxSelectionCount: 3,
                         matching: .images,
                         preferredItemEncoding: .automatic,
                         photoLibrary: .shared())
            {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke()
                        .foregroundColor(.imagePlckerBorderColor)
                    
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
        
        private func textView() -> some View {
            ZStack(alignment: .topLeading) {
                TextField("후기를 적어주세요", text:
                            Binding(
                                get: { return text ?? "" },
                                set: { self.text = $0 }
                            ), axis: .vertical
                )
                .textFieldStyle(.roundedBorder)
                .lineLimit(10, reservesSpace: true)
                .font(.system(size: 15))
                .focused($isFocused)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button("완료") {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                    }
                }
            }
            .frame(maxHeight: (UIScreen.main.bounds.width - 40) * 3 / 6)
        }
    }
}

struct WritingView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewContentView.WritingView(photo: .constant([]), text: .constant(nil))
    }
}
