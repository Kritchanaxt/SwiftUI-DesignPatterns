//
//  MVVM-API.swift
//  SwiftUI-DesignPatterns
//
//  Created by Kritchanaxt_. on 30/4/2567 BE.
//

// https://jsonplaceholder.typicode.com/users

import SwiftUI
import Combine

// MARK: Model
struct User2: Codable {
    let name: String
    let email: String
    let username: String
}

// MARK: ViewModel
class PeopleViewModel: ObservableObject {
    
    // ทำการเผยแพร่การอัปเดตไปยัง View ที่สัมพันธ์.
    @Published var users = [User2]()
    
    init() {
        getUsers()
    }
    
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            // แปลงผลลัพธ์จากแพร่งานให้อยู่ในรูปแบบของ Data เพื่อให้ง่ายต่อการถอดรหัส JSON ต่อไป.
            .map(\.data)
        
            // ถอดรหัส JSON ที่ได้จากข้อมูล Data เป็นอ็อบเจกต์ของ User โดยใช้ JSONDecoder().
            .decode(type: [User2].self, decoder: JSONDecoder())
            
            // กำหนดค่า default ในกรณีเกิดข้อผิดพลาดในการถอดรหัส JSON เพื่อไม่ให้ส่งข้อผิดพลาดออกมาและให้ผลลัพธ์เป็นอาร์เรย์ว่าง.
            .replaceError(with: [])
        
            //กำหนดให้การรับข้อมูลทำงานใน main queue เพื่อให้สามารถอัปเดตส่วนของ UI ได้โดยตรง.
            .receive(on: DispatchQueue.main)
            
            //เชื่อมโยงผลลัพธ์จาก Publisher กับ property users ใน ViewModel ในลักษณะการเชื่อมโยง Two-Way Binding เพื่อให้ ViewModel สามารถเผยแพร่การอัปเดตข้อมูลไปยัง View ที่เกี่ยวข้องได้โดยอัตโนมัติ.
            .assign(to: &$users)
    }
}

// MARK: View
struct ContentView2: View {
    @ObservedObject var viewModel = PeopleViewModel()
    @State private var isShowingAlert = false
    @State private var selectedUser: User2?
    
    var body: some View {
        NavigationView {
            List(viewModel.users, id: \.username) { user in
                Button(action: {
                    selectedUser = user
                    isShowingAlert = true
                }) {
                    Text(user.name)
                }
            }
            .navigationBarTitle("Users")
            .alert(isPresented: $isShowingAlert) {
                
                // ถูกกำหนดโดยใช้ชื่อของผู้ใช้ที่ถูกเลือก (selectedUser?.name) หรือถ้าไม่มีผู้ใช้ถูกเลือกก็จะกำหนดให้เป็นข้อความว่าง.
                let title = selectedUser?.name ?? ""
                
                //ถูกกำหนดโดยใช้ข้อมูลของผู้ใช้ที่ถูกเลือก (email, username) หรือถ้าไม่มีผู้ใช้ถูกเลือกก็จะกำหนดให้เป็นข้อความว่าง.
                let message = "\(selectedUser?.name ?? "") has an email of \(selectedUser?.email ?? "") & a username of \(selectedUser?.username ?? "")"
                
                return Alert(
                    
                    // ส่วนของข้อความหัวเรื่องของ Alert
                    title: Text(title),
                    
                    // ส่วนของข้อความข้อความในเนื้อหาของ Alert
                    message: Text(message),
                    
                    // ถูกกำหนดเป็นปุ่ม cancel ซึ่งเมื่อถูกกดจะปิดหน้าต่าง Alert ลง.
                    dismissButton: .cancel())
            }
        }
    }
}


#Preview {
    ContentView2()
}


