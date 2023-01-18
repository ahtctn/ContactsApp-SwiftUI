//
//  ContactsProvider.swift
//  ContactsApp
//
//  Created by Ahmet Ali ÇETİN on 2.01.2023.
//

import Foundation
import CoreData
import SwiftUI

final class ContactsProvider {
    
    static let shared = ContactsProvider()
    private let persistantContainter: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        persistantContainter.viewContext
    }
    
    var newContext: NSManagedObjectContext {
        persistantContainter.newBackgroundContext() 
    }
    
    private init(){
        persistantContainter = NSPersistentContainer(name: "ContactsDataModel")
        
        if EnvironmentValues.isPreview {
            persistantContainter.persistentStoreDescriptions.first?.url = .init(fileURLWithPath: "/dev/null" )
        }
        
        persistantContainter.viewContext.automaticallyMergesChangesFromParent = true
        persistantContainter.loadPersistentStores { _, error in
            if let error {
                fatalError("Unable to load store with error: \(error)")
            }
            
        }
    }
}

extension EnvironmentValues {
    static var isPreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
