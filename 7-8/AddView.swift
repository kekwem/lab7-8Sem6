//
//  AddView.swift
//  7-8
//
//  Created by DA on 24/04/2023.
//

import SwiftUI
 
struct AddView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State var name: String = ""
    @State var surname: String = ""
    
    var buttonLabel: String = ""
    var localPerson: Person?

    init(operation: String, personObject: Person?) {
        if operation == "add"{
            buttonLabel = "Add"
        }
        else if operation == "edit"{
            buttonLabel = "Edit"
            self._name = State(initialValue: personObject!.name!)
            self._surname = State(initialValue: personObject!.surname!)
            self.localPerson = personObject!
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Enter name...", text: $name)
            TextField("Enter surname...", text: $surname)
        }.padding()
        Button(action: selectingFunction()!) {
            Text(buttonLabel)
        }
    }
    
    func addPerson() -> Void{
        let newPerson = Person(context: viewContext)
        newPerson.name = name
        newPerson.surname = surname
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        dismiss()
    }
    
    func editPerson() -> Void{
        localPerson!.name = name
        localPerson!.surname = surname
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        dismiss()
    }
    
    func selectingFunction() -> (() -> Void)?{
        if buttonLabel == "Add"{
            return addPerson
        }
        else if buttonLabel == "Edit"{
            return editPerson
        }
        return nil
    }
}


struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(operation: "add", personObject: nil)
    }
}
