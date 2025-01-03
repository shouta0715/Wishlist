//
//  WishlistApp.swift
//  Wishlist
//
//  Created by k21047kk on 2025/01/03.
//

import SwiftUI
import SwiftData

@main
struct WishlistApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            .modelContainer(for: Wish.self)
        }
    }
}
