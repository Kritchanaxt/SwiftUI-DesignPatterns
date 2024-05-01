//
//  MVP.swift
//  SwiftUI-DesignPatterns
//
//  Created by Kritchanaxt_. on 30/4/2567 BE.
//

// https://jsonplaceholder.typicode.com/users

import SwiftUI
import Combine

// MARK: - Model
struct UserMVP: Codable, Identifiable {
    let id = UUID()
    let name: String
    let email: String
    let username: String
}

// MARK: - View
struct UsersViewMVP: View {
    @StateObject var presenter = UserPresenterMVP()
    @State private var showAlert = false
    @State private var selectedUser: UserMVP?

    var body: some View {
        NavigationView {
            List(presenter.users) { user in
                UserRowMVP(user: user)
                    .onTapGesture {
                        selectedUser = user
                        showAlert = true
                    }
            }
            .navigationTitle("Users")
            .onAppear {
                presenter.getUsers()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(selectedUser?.name ?? ""),
                    message: Text("\(selectedUser?.name ?? "") has an email of \(selectedUser?.email ?? "") & a username of \(selectedUser?.username ?? "")"),
                    dismissButton: .cancel()
                )
            }
        }
    }
}

struct UserRowMVP: View {
    let user: UserMVP
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(user.name)
            Text(user.email)
                .font(.caption)
        }
    }
}

// MARK: - Presenter
class UserPresenterMVP: ObservableObject {
    @Published var users = [UserMVP]()
    
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let users = try JSONDecoder().decode([UserMVP].self, from: data)
                DispatchQueue.main.async {
                    self?.users = users
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
}

#Preview {
    UsersViewMVP()
}
