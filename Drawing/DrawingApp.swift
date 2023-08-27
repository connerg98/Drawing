//
//  DrawingApp.swift
//  Drawing
//
//  Created by Conner Glasgow on 4/6/22.
//

import SwiftUI
import CoreData


@main
struct DrawingApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            FlowerListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
