//
//  __8App.swift
//  7-8
//
//  Created by DA on 24/04/2023.
//

import SwiftUI

@main
struct __8App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
