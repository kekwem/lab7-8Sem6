//
//  ContentView.swift
//  7-8
//
//  Created by DA on 24/04/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Person.name, ascending: true)],
        animation: .default)
    private var persons: FetchedResults<Person>

    var body: some View {
        NavigationView {
            List {
                ForEach(persons) { person in
                    NavigationLink {
                        Text("This person is \(person.name!) \(person.surname!)")
                        NavigationLink(destination: AddView(operation: "edit", personObject:  person)) {
                            Text("Edit")
                        }
                    } label: {
                        Image(systemName: "person")
                        Text(person.name!)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    NavigationLink(destination: AddView(operation: "add", personObject: nil)) {
                        Text("Add person")
                    }
                }
            }
            Text("Select an person")
        }
    }

//    private func addItem() {
//        withAnimation {
//            let newPerson = Person(context: viewContext)
//            newPerson.name = "imie"
//            newPerson.surname = "nazwisko"
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { persons[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
