//
//  CheckContinuationBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by yunus olgun on 1.01.2024.
//

import SwiftUI

class CheckContinuationBootcampNetworkManager {
    
    func getData(url: URL) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch  {
            throw error
        }
    }
    
    
    func getData2(url: URL) async throws -> Data {
        
        return try await withCheckedContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    continuation.resume(returning: data)
                } else if let error = error {
                    continuation.resume(throwing: error as! Never)
                }
            }.resume()
        }
        
        
    }
    
    
    func getHeartImageFromDatabase(completionHandler: @escaping(_ image: UIImage) -> () ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            completionHandler(UIImage(systemName: "heart.fill")!)
        }
    }
    
}

class CheckContinuationBootcampViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let networkManager = CheckContinuationBootcampNetworkManager()
 
    func getImage() async {
        guard let url = URL(string: "https://picsum.photos/300" ) else { return }
        
        do {
            let data = try await networkManager.getData2(url: url)
            if let image = UIImage(data: data) {
                await MainActor.run {
                    self.image = image
                }
            }
        } catch  {
            print(error)
        }
    }
    
    
    func getHeartImage()  {
        networkManager.getHeartImageFromDatabase { [weak self ] image in
            self?.image = image
        }
    }
    
    func getHeartImageFromDatabase() {
        
    }
    
    
}

struct CheckContinuationBootcamp: View {
    
    @StateObject private var viewModel = CheckContinuationBootcampViewModel()
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            //await viewModel.getImage()
            await viewModel.getHeartImage()
        }
    }
}

#Preview {
    CheckContinuationBootcamp()
}
