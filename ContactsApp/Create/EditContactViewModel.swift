//
//  EditContactViewModel.swift
//  ContactsApp
//
//  Created by Ahmet Ali ÇETİN on 2.01.2023.
//

import Foundation
import CoreData

final class EditContactViewModel: ObservableObject {
    @Published var contact: Contact
    let isNew: Bool
    private let context: NSManagedObjectContext
    init(provider: ContactsProvider, contact: Contact? = nil) {
        self.context = provider.newContext

        if let contact, let existingContactCopy = try? context.existingObject(with: contact.objectID) as? Contact{
            self.contact = existingContactCopy
            self.isNew = false
        } else {
            self.contact = Contact(context: self.context)
            self.isNew = true
        }
    }
    
    func save() throws {
        if context.hasChanges == true {
            try context.save()
        }
    }
    
}
