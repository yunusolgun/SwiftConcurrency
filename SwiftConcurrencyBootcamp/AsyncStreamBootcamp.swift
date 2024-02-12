//
//  AsyncStreamBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by yunus olgun on 8.01.2024.
//

import SwiftUI

class AsyncStreamDataManager {
    
    func getFakeData(completion: @escaping (_ value: Int) -> Void) {
        let items: [Int] = [1,2,3,4,5,6,7,8,9,10]
        
        for item in items {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(item)) {
                completion(item)
            }
        }
    }
}

@MainActor
final class AsyncStreamViewModel: ObservableObject {
    
    let manager = AsyncStreamDataManager()
    @Published private(set) var currentNumber: Int = 0
    
    func onViewAppear() {
        manager.getFakeData { [weak self] value in
            self?.currentNumber = value
        }
    }
    
}

struct AsyncStreamBootcamp: View {
    
    @StateObject private var viewModel = AsyncStreamViewModel()
    
    var body: some View {
        Text("\(viewModel.currentNumber)")
            .onAppear(perform: {
                viewModel.onViewAppear()
            })
    }
}

#Preview {
    AsyncStreamBootcamp()
}
