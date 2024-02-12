//
//  ActorsBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by yunus olgun on 6.01.2024.
//

import SwiftUI

class MyDataManager {
    
    static let instance = MyDataManager()
    private init() { }
    
    var data: [String] = []
    
    func getRandamData() -> String? {
        self.data.append(UUID().uuidString)
        print(Thread.current)
        return data.randomElement()
    }
    
}

actor MyActorDataManager {
    
    static let instance = MyActorDataManager()
    private init() { }
    
    var data: [String] = []
    
    func getRandamData() -> String? {
        self.data.append(UUID().uuidString)
        print(Thread.current)
        return data.randomElement()
    }
    
}

struct HomeView: View {
    
    let manager = MyActorDataManager.instance
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onReceive(timer, perform: { _ in
            Task {
                if let data = await manager.getRandamData() {
                    await MainActor.run {
                        self.text = data
                    }
                }
            }
            
//            DispatchQueue.global(qos: .background).async {
//                if let data = manager.getRandamData() {
//                    DispatchQueue.main.async {
//                        self.text = data
//                    }
//                }
//            }
            
        })
    }
}

struct BrowseView: View {
    
    let manager = MyActorDataManager.instance
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }.onReceive(timer, perform: { _ in
            Task {
                if let data = await manager.getRandamData() {
                    await MainActor.run {
                        self.text = data
                    }
                }
            }
//            DispatchQueue.global(qos: .default).async {
//                if let data = manager.getRandamData() {
//                    DispatchQueue.main.async {
//                        self.text = data
//                    }
//                }
//            }
        })
    }
}

struct ActorsBootcamp: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "magnifyingglass")
                }
        }
    }
}

#Preview {
    ActorsBootcamp()
}
