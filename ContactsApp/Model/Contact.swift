//
//  Contact.swift
//  ContactsApp
//
//  Created by Ahmet Ali ÇETİN on 2.01.2023.
//

import Foundation
import CoreData

final class Contact: NSManagedObject, Identifiable {
    @NSManaged var dob: Date
    @NSManaged var email: String
    @NSManaged var isFavorite: Bool
    @NSManaged var name: String
    @NSManaged var notes: String
    @NSManaged var phoneNumber: String
    
    var isBirthday: Bool {
        Calendar.current.isDateInToday(dob)
    }
    
    var formattedName: String {
        "\(isBirthday ? "🎈" : "") \(name)"
    }
    
    //when our contact model loads we actually give default values
    override func awakeFromInsert() {
        super.awakeFromInsert()
        setPrimitiveValue(Date.now, forKey: "dob")
        setPrimitiveValue(false, forKey: "isFavorite")
    }
}

extension Contact {
    private static var contactsFetchRequest: NSFetchRequest<Contact> {
        NSFetchRequest(entityName: "Contact")
    }
    
    static func all() -> NSFetchRequest<Contact>{
        let request: NSFetchRequest<Contact> = contactsFetchRequest
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Contact.name, ascending: true)
            
        ]
        return request
    }
}

extension Contact{
    
    @discardableResult
    static func makePreview(count: Int, in context: NSManagedObjectContext) -> [Contact]{
        var contacts = [Contact]()
        
        for i in 0..<count {
            let contact = Contact(context: context)
            contact.name = "name\(i)"
            contact.email = "email\(i)"
            contact.isFavorite = Bool.random()
            contact.phoneNumber = "\(i) 555-555-555"
            contact.dob = Calendar.current.date(byAdding: .day, value: -i, to: .now) ?? .now
            contact.notes = "This is a preview for item \(i)"
            
            contacts.append(contact)
        }
        return contacts
    }

    static func preview(context: NSManagedObjectContext = ContactsProvider.shared.viewContext) -> Contact{
        return makePreview(count: 1, in: context)[0]
    }
    
    static func empty(context: NSManagedObjectContext = ContactsProvider.shared.viewContext) -> Contact{
        return Contact(context: context)
    }
}
