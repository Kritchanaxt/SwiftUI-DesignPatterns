//
//  MVVM.swift
//  SwiftUI-DesignPatterns
//
//  Created by Kritchanaxt_. on 30/4/2567 BE.
//

import SwiftUI

// MARK: Model
struct PersonMVVM: Hashable {
    let firstName: String
    let lastName: String
    let gender: String
    let age: Int
    let height: Double
}


// MARK: ViewModel
class CellViewModel: ObservableObject {
    @Published var firstName: String
    @Published var lastName: String
    
    init(person: PersonMVVM) {
        self.firstName = person.firstName
        self.lastName = person.lastName
    }
}

// MARK: View
struct CustomView: View {
    @ObservedObject var viewModel: CellViewModel
    
    var body: some View {
        Text("\(viewModel.firstName) \(viewModel.lastName)")
    }
}

struct MVVM: View {
    let data = [
        PersonMVVM(firstName: "Dan", lastName: "Smith", gender: "male", age: 25, height: 156),
        PersonMVVM(firstName: "Betty", lastName: "Smith", gender: "male", age: 25, height: 162),
        PersonMVVM(firstName: "John", lastName: "Smith", gender: "male", age: 25, height: 170)
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(data, id: \.self) { person in
                    CustomView(viewModel: CellViewModel(person: person))
                }
            }
            .navigationTitle("People")
        }
    }
}


#Preview {
    MVVM()
}
