//
//  APIService.swift
//  Karoooo Test
//
//  Created by Sevenbits on 28/08/22.
//

import UIKit

class APIService: NSObject {
    
  
    static let shareInstance = APIService()
 
    
    func getAllUsersData(completion: @escaping([UsersListModel]?, Error?) -> ()){
        let urlString = "https://jsonplaceholder.typicode.com/users"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error{
                completion(nil,err)
                print("Loading data error: \(err.localizedDescription)")
            }else{
                guard let data = data else { return }
                do{
                    var arrUserData = [UsersListModel]()
                    let results = try JSONDecoder().decode([UsersListModel].self, from: data)
                    for users in results{
                        arrUserData.append(UsersListModel(id: users.id, name: users.name, username: users.username, email: users.email, address: users.address, phone: users.phone, website: users.website, company: users.company))
                    }
                    completion(arrUserData, nil)
                }catch let jsonErr{
                    print("json error : \(jsonErr.localizedDescription)")
                }
            }
        }.resume()
    }
}
