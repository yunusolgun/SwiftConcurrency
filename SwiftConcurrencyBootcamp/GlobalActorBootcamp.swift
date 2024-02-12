//
//  GlobalActorBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by yunus olgun on 6.01.2024.
//

import SwiftUI

actor MyNewDataManager {
    
    func getDataFromDatabase() -> [String] {
        return ["One", "Two", "Three"]
    }
    
}

class GlobalActorBootcampViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    let manager = MyNewDataManager()
    
    func getData() async {
        let data = await manager.getDataFromDatabase()
        self.dataArray = data
    }
    
}

struct GlobalActorBootcamp: View {
    
    @StateObject private var viewModel = GlobalActorBootcampViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.dataArray, id: \.self) {
                    Text($0)
                        .font(.headline)
                }
            }
        }
        .task {
            await viewModel.getData()
        }
    }
}

#Preview {
    GlobalActorBootcamp()
}
