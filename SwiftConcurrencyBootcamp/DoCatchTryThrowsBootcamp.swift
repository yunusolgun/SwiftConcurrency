//
//  DoCatchTryThrowsBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by yunus olgun on 8.10.2023.
//

import SwiftUI

//do-catch
//try
//throws

class DoCatchTryThrowsBootcampDataManager {
    
    let isActive: Bool = true
    
    func getTitle() -> (title: String?, error: Error?) {
        if isActive {
            return ("NEW TEXT", nil)
        } else {
            return (nil, URLError(URLError.badURL))
        }
        
    }
    
    func getTitle2() -> Result<String, Error> {
        if isActive {
            return .success("NEW TEXT")
        } else {
            return .failure(URLError(URLError.appTransportSecurityRequiresSecureConnection))
        }
    }
    
    func getTitle3() throws -> String {
        throw URLError(URLError.badServerResponse)
//        if isActive {
//            return "NEW VALUE"
//        } else {
//            throw URLError(URLError.badServerResponse)
//        }
    }
    
    func getTitle4() throws -> String {
        if isActive {
            return "FINAL TEXT"
        } else {
            throw URLError(URLError.badServerResponse)
        }
    }
}


class DoCatchTryThrowsBootcampViewModel: ObservableObject {
    
    @Published var text: String = "Starting text"
    let manager = DoCatchTryThrowsBootcampDataManager()
    
    func fetchTitle(){
        
        /*
        let returnedValue = manager.getTitle()
        if let newTitle = returnedValue.title {
            self.text = newTitle
        } else if let error = returnedValue.error {
            self.text = error.localizedDescription
        }
         */
        
        /*
        let result = manager.getTitle2()
        switch result {
        case .success(let newTitle):
            self.text = newTitle
        case .failure(let error):
            self.text = error.localizedDescription
        }
         */
        
        
        do {
            let newTitle = try manager.getTitle3()
            self.text = newTitle
            
            let finalTitle = try manager.getTitle4()
            self.text = finalTitle
        } catch {
            self.text = error.localizedDescription
        }
    }
}

struct DoCatchTryThrowsBootcamp: View {
    
    @StateObject private var viewModel = DoCatchTryThrowsBootcampViewModel()
    
    var body: some View {
        Text(viewModel.text)
            .frame(width: 300, height: 300)
            .background(Color.blue)
            .onTapGesture {
                viewModel.fetchTitle()
            }
    }
}

#Preview {
    DoCatchTryThrowsBootcamp()
}
