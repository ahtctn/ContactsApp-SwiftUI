//
//  ContactsAppApp.swift
//  ContactsApp
//
//  Created by Ahmet Ali ÇETİN on 2.01.2023.
//

import SwiftUI

@main
struct ContactsAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, ContactsProvider.shared.viewContext)
        }
    }
}
