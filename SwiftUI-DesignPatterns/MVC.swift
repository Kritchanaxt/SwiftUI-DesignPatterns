//
//  MVC.swift
//  SwiftUI-DesignPatterns
//
//  Created by Kritchanaxt_. on 30/4/2567 BE.
//

import SwiftUI

// MARK: Model
struct PersonMVC {
    let firstName: String
    let lastName: String
    let gender: String
    let age: Int
    let weight: Double
    let height: Double
}

// MARK: Controller or View
struct ViewController: View {
    let person: PersonMVC
    
    var body: some View {
        ExampleView(person: person)
            .frame(width: 250, height: 250)
    }
}

// MARK: View
struct ExampleView: UIViewRepresentable {
    let person: PersonMVC
    
    func makeUIView(context: Context) -> UIView {
        let myView = UIView()
        myView.backgroundColor = .red
        
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .black
        label.textColor = .white
        label.text = "\(person.firstName) \(person.lastName)"
        label.frame = CGRect(x: 10, y: 10, width: 230, height: 230)
        myView.addSubview(label)
        
        return myView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        guard let label = uiView.subviews.first as? UILabel else { return }
        label.text = "\(person.firstName) \(person.lastName)"
    }
}

#Preview {
    ViewController(person: PersonMVC(firstName: "John", lastName: "Smith", gender: "male", age: 25, weight: 72.0, height: 1752.0))
}
