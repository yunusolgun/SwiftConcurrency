//
//  MVVMBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by yunus olgun on 6.01.2024.
//

import SwiftUI

final class MyManagerClass {
    
    
    func getData() async throws -> String {
        return "Some Data!"
    }
}

actor MyManagerActor {
    
    func getData() async throws -> String {
        return "Some Data!"
    }
}

final class MVVMBootcampViewModel: ObservableObject {
    
    let managerClass = MyManagerClass()
    let managerActor = MyManagerActor()
    
    private var tasks: [Task<Void, Never>] = []
    
    @Published private(set) var myData: String = "Starting text"
    
    func cancelTasks() {
        tasks.forEach({ $0.cancel() })
        tasks = []
    }
    
    func onCallToActionButtonPressed() {
        let task = Task {
            do {
                myData = try await managerClass.getData()
            } catch {
                
            }
            
        }
        tasks.append(task)
    }
    
}

struct MVVMBootcamp: View {
    
    @StateObject private var viewModel = MVVMBootcampViewModel()
    
    var body: some View {
        Text("Hello, World!")
        Button("Click me") {
            viewModel.onCallToActionButtonPressed()
        }
        .onDisappear(perform: {
            viewModel.cancelTasks()
        })
    }
}

#Preview {
    MVVMBootcamp()
}
