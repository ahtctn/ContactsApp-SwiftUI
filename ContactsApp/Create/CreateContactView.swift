//
//  CreateContactView.swift
//  ContactsApp
//
//  Created by Ahmet Ali ÇETİN on 2.01.2023.
//

import SwiftUI

struct CreateContactView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var vm: EditContactViewModel
    
    var body: some View {
        List {
            Section("General") {
                TextField("Name", text: $vm.contact.name)
                    .keyboardType(.namePhonePad)
                
                TextField("Email", text: $vm.contact.email)
                    .keyboardType(.emailAddress)
                TextField("Phone Number", text: $vm.contact.phoneNumber)
                    .keyboardType(.phonePad)
                DatePicker("Birthday", selection: $vm.contact.dob, displayedComponents: [.date])
                    .datePickerStyle(.compact)
                Toggle("Favorite", isOn: $vm.contact.isFavorite)
            }
            
            Section("Notes") {
                TextField("", text: $vm.contact.notes, axis: .vertical)
            }
        }
        .navigationTitle(vm.isNew ? "New Contact" : "Update Contact")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    do {
                        try vm.save()
                        dismiss()
                    } catch {
                        print(error)
                    }
                }
                
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}

struct CreateContactView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            let preview = ContactsProvider.shared
            CreateContactView(vm: .init(provider: preview))
                .environment(\.managedObjectContext, preview.viewContext)
            
            
        }
    }
}
