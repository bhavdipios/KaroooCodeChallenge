//
//  UserList_VC.swift
//  Karoooo Test
//
//  Created by Sevenbits on 27/08/22.
//

import UIKit

class UserList_VC: UIViewController {
   
    @IBOutlet var tableView: UITableView!
    var arrUserDetails = [UsersViewModel]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Check the internet connectivity
        if InternetConnectionManager.isConnectedToNetwork(){
            self.getData()
        }else{
            let alert = UIAlertController(title: "Alert", message: "Internet connection is unavailable", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    //MARK: Service API for fethc userlist.
    func getData(){
        
        APIService.shareInstance.getAllUsersData { (movies, error) in
            if(error==nil){
                self.arrUserDetails = movies?.map({ return UsersViewModel(user: $0) }) ?? []
                DispatchQueue.main.async { [self] in
                    print(self.arrUserDetails)
                    self.tableView.reloadData()
                }
            }
        }

    }
    
   

}

//MARK: TableviewDelegate
extension UserList_VC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUserDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = arrUserDetails[indexPath.row]
        cell.textLabel?.text = user.name ?? ""
        cell.detailTextLabel?.text = user.email ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objUserdetailsVC = self.storyboard!.instantiateViewController(withIdentifier: "UserDetails_VC") as! UserDetails_VC
        let user = arrUserDetails[indexPath.row]
        objUserdetailsVC.strName = user.name
        objUserdetailsVC.strEmail = user.email
        objUserdetailsVC.strAddress = "\(user.address?.suite ?? "") \(user.address?.city ?? "")"
        objUserdetailsVC.strphone = user.phone
        objUserdetailsVC.strWebsite = user.website
        objUserdetailsVC.strCompany = user.company?.name ?? ""
        objUserdetailsVC.lat = user.address?.geo?.lat ?? "0.00"
        objUserdetailsVC.lng = user.address?.geo?.lng ?? "0.00"
        self.navigationController?.pushViewController(objUserdetailsVC, animated: true)
      
    }
    
}
