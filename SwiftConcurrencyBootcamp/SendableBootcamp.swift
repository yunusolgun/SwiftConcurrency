//
//  SendableBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by yunus olgun on 6.01.2024.
//

import SwiftUI

actor CurrentUserManager {
    
    
    func updateDatabase(userInfo: MyClassUserInfo) {
        
    }
}


struct MyUserInfo: Sendable {
    let name: String
}

final class MyClassUserInfo: @unchecked Sendable{
    let name: String
    init(name: String) {
        self.name = name
    }
}

class SendableBootcampViewModel: ObservableObject {
    
    let manager = CurrentUserManager()
    
    func updateCurrentUserInfo() async {
        let info = MyClassUserInfo(name: "info")
        await manager.updateDatabase(userInfo: info)
    }
    
}

struct SendableBootcamp: View {
    
    @StateObject private var viewModel = SendableBootcampViewModel()
    
    var body: some View {
        Text("Hello, World!")
            .task {
                
            }
    }
}

#Preview {
    SendableBootcamp()
}
