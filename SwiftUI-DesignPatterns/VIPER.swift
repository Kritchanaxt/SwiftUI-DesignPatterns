//
//  VIPER.swift
//  SwiftUI-DesignPatterns
//
//  Created by Kritchanaxt_. on 30/4/2567 BE.
//

// https://jsonplaceholder.typicode.com/users


import SwiftUI

// MARK: - View Protocol
protocol AnyView {
    associatedtype PresenterType: ObservableObject
    
    var presenter: PresenterType { get }
}

// MARK: - UserView
struct UserView: View, AnyView {
    @StateObject var presenter: UserPresenter
    
    var body: some View {
        VStack {
            if presenter.users.isEmpty {
                Text("Loading...")
            } else {
                List(presenter.users, id: \.id) { user in
                    Text(user.name)
                }
            }
        }
        .onAppear {
            presenter.getUsers()
        }
    }
}

// MARK: - Interactor Protocol
enum FetchError: Error {
    case failed
}

// MARK: - Interactor Protocol
protocol AnyInteractor {
    var presenter: (any AnyPresenter)? { get set }
    
    func getUsers(presenter: any AnyPresenter)
}

// MARK: - Interactor
class UserInteractor: AnyInteractor {
    var presenter: (any AnyPresenter)?
    
    func getUsers(presenter: any AnyPresenter) {
        print("Start fetching")
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                presenter.interactorDidFetchUser(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                presenter.interactorDidFetchUser(with: .success(entities))
            } catch {
                presenter.interactorDidFetchUser(with: .failure(error))
            }
        }
        task.resume()
    }
}

// MARK: - Presenter Protocol
protocol AnyPresenter: ObservableObject {
    var users: [User] { get }
    
    func getUsers()
    func interactorDidFetchUser(with result: Result<[User], Error>)
}

// MARK: - UserPresenter
class UserPresenter: AnyPresenter {
    @Published var users: [User] = []
    
    func getUsers() {
        // Call Interactor to fetch users
        UserInteractor().getUsers(presenter: self)
    }
    
    func interactorDidFetchUser(with result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            self.users = users
        case .failure(let error):
            print(error)
        }
    }
}

// MARK: - Model or Entity
struct User: Codable, Identifiable {
    let id: String = UUID().uuidString
    let name: String
}


// MARK: - Router Protocol
protocol AnyRouter {
    associatedtype ViewType: AnyView
    
    static func start() -> ViewType
}

// MARK: - UserRouter
class UserRouter: AnyRouter {
    typealias ViewType = UserView
    
    static func start() -> UserView {
        let presenter = UserPresenter()
        return UserView(presenter: presenter)
    }
}

#Preview {
    UserRouter.start()
}
