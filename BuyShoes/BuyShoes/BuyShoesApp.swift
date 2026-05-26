//
//  BuyShoesApp.swift
//  BuyShoes
//
//  Created by Nawruzbek Ibragimow on 27.05.2026.
//

import SwiftUI
import CoreData

@main
struct BuyShoesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
