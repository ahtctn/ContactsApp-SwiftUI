//
//  NoContactView.swift
//  ContactsApp
//
//  Created by Ahmet Ali ÃETÄ°N on 4.01.2023.
//

import SwiftUI

 struct NoContactsView: View {
    var body: some View {
        VStack {
            Text("ð No Contacts")
                .font(.largeTitle.bold())
            Text("It seems empty, so lets create some contacts.ðð»")
                .font(.callout)
        }
    }
}

struct NoContactsView_Previews: PreviewProvider {
    static var previews: some View {
        NoContactsView()
    }
}
