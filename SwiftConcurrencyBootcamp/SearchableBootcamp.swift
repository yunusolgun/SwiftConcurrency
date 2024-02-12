//
//  SearchableBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by yunus olgun on 6.01.2024.
//

import SwiftUI

struct Restaurant: Identifiable, Hashable {
    let id: String
    let title: String
    let cuisine: CousineOption
}

enum CousineOption {
    case american, italian, japanese
}

final class RestaurantManager {
    
    func getAllRestaurants() async throws -> [Restaurant] {
        [
            Restaurant(id: "1", title: "Burger Shack", cuisine: .american),
            Restaurant(id: "2", title: "Paste Place", cuisine: .italian),
            Restaurant(id: "3", title: "Sushi Heavem", cuisine: .japanese),
            Restaurant(id: "4", title: "Local Market", cuisine: .american)
        ]
        
    }
}


@MainActor
final class SearchableViewModel: ObservableObject {
    
    @Published private(set) var allRestaurants: [Restaurant] = []
        let manager = RestaurantManager()
    
}

struct SearchableBootcamp: View {
    
    @StateObject private var viewModel = SearchableViewModel()
    
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    SearchableBootcamp()
}
