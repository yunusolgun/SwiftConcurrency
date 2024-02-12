//
//  PhotoPickerBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by yunus olgun on 8.01.2024.
//

import SwiftUI
import PhotosUI

@MainActor
final class PhotoPickerViewModel: ObservableObject {
    
    @Published private(set) var selectedImage: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                    return
                }
            }
        }
        
    }
    
}

struct PhotoPickerBootcamp: View {
    
    @StateObject private var viewModel = PhotoPickerViewModel()
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Hello, World!")
            
            if let image = viewModel.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .cornerRadius(10)
                
            }
            
            PhotosPicker(selection: $viewModel.imageSelection) {
                Text("Open the photo picker!")
                    .foregroundColor(.red)
            }
            
            
            
        }
    }
}

#Preview {
    PhotoPickerBootcamp()
}
