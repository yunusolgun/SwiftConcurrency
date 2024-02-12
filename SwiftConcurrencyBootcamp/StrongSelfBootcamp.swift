//
//  StrongSelfBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by yunus olgun on 6.01.2024.
//

import SwiftUI


final class StrongSelfDataService {
    
    func getData() async -> String {
        "Updated data!"
    }
}

final class StrongSelfBootcampViewModel: ObservableObject {
    
    @Published var data: String = "Some title!"
    let dataService = StrongSelfDataService()
    
    private var someTask: Task<Void,Never>? = nil
    
    func cancelTasks() {
        someTask?.cancel()
        someTask = nil
    }
    
    //This implies a strong reference...
    func updateData() {
        Task {
            data = await dataService.getData()
        }
    }
    
    //This is a strong reference...
    func updateData2() {
        Task {
            self.data = await self.dataService.getData()
        }
    }
    
    //This is a strong reference...
    func updateData3() {
        Task { [self] in
            self.data = await self.dataService.getData()
        }
    }
    
    
    //This is a weak reference...
    func updateData4() {
        Task { [weak self] in
            if let data = await self?.dataService.getData() {
                self?.data = data
            }
        }
    }
    
    
    //We dont need to manage weak/strong. We can manage the Task!
    func updateData5() {
        someTask =  Task { [self] in
            self.data = await self.dataService.getData()
        }
    }
    
}

struct StrongSelfBootcamp: View {
    
    @StateObject private var viewModel = StrongSelfBootcampViewModel()
    
    var body: some View {
        Text(viewModel.data)
            .onAppear(perform: {
                viewModel.updateData()
            })
            .onDisappear(perform: {
                viewModel.cancelTasks()
            })
    }
}

#Preview {
    StrongSelfBootcamp()
}
