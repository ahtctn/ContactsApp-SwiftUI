//
//  ContentView.swift
//  ContactsApp
//
//  Created by Ahmet Ali ÇETİN on 2.01.2023.
//

import SwiftUI

struct ContentView: View {
    
    @FetchRequest(fetchRequest: Contact.all()) private var contacts
    @State private var contactToEdit: Contact?
    
    var provider = ContactsProvider.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                if contacts.isEmpty{
                    NoContactsView()
                } else {
                    List {
                        ForEach(contacts) { contact in
                            ZStack(alignment: .leading) {
                                NavigationLink(destination: ContactDetailView(contact: contact)) {
                                    EmptyView()
                                }
                                .opacity(0.0)
                                ContactRowView(contact: contact)
                                    .swipeActions(allowsFullSwipe: true) {
                                        Button(role: .destructive) {
                                            do{
                                                 try delete(contact)
                                            }catch {
                                                print("There is an error: \(error)")
                                            }
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                        .tint(.red)
                                        
                                        Button{
                                            contactToEdit = contact
                                        } label: {
                                            Label("Edit", systemImage: "pencil")
                                        }
                                        .tint(.orange)
                                        
                                        
                                    }
                            }
                        }
                    }
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        contactToEdit = .empty(context: provider.newContext)
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
            }
            .sheet(item: $contactToEdit,
                   onDismiss: {
                contactToEdit = nil
            },
                   content: { contact in
                NavigationStack {
                    CreateContactView(vm: .init(provider: provider,
                                                contact: contact))
                }
            })
            
            .navigationTitle("Contacts")
        }
        
    }
}

private extension ContentView {
    func delete(_ contact: Contact) throws {
        let context = provider.viewContext
        let existingContact = try context.existingObject(with: contact.objectID)
        context.delete(existingContact)
        Task(priority:.background) {
            try await context.perform{
                try context.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let preview = ContactsProvider.shared
        ContentView(provider: preview)
            .environment(\.managedObjectContext, preview.viewContext)
            .previewDisplayName("Contacts With Data")
            .onAppear{ Contact.makePreview(count: 10, in: preview.viewContext)}
        
        let emptyPreview = ContactsProvider.shared
        ContentView(provider: emptyPreview)
            .environment(\.managedObjectContext, emptyPreview.viewContext)
            .previewDisplayName("Contacts With No Data")
    }
}
