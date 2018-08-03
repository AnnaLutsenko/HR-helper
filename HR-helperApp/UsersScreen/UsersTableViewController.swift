//
//  UsersTableViewController.swift
//  HR-helperApp
//
//  Created by Anna on 8/2/18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController, EditUserProtocol, AddUserProtocol {

    /// UI Elements
    @IBOutlet weak var searchBar: UISearchBar!
    
    /// Models
    var allUsers: [UserModel] = UserModel.defaultUsers
    var users: [UserModel] = []
    
    var editIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initController()
    }
    
    func initController() {
        customizeSearchBar()
        //
        users = allUsers
        //
        tableView.register(UINib(nibName: UserCell.reuseID, bundle: nil), forCellReuseIdentifier: UserCell.reuseID)
        //
    }
    
    func customizeSearchBar() {
        searchBar.barTintColor = .white
        searchBar.backgroundImage = UIImage()
        searchBar.layer.borderColor = UIColor.white.cgColor
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor.customBackgroundTFInSeachBar
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.Seque.addUser,
            let vc = segue.destination as? EditUserViewController {
            vc.addDelegate = self
        }
    }
    
    // MARK: - protocol metods
    func editingUser(_ user: UserModel) {
        allUsers = allUsers.filter({$0.uuid != user.uuid})
        allUsers.insert(user, at: 0)
        //
        users[editIndex] = user
        tableView.reloadData()
    }
    
    func addUser(_ user: UserModel) {
        allUsers.insert(user, at: 0)
        users.insert(user, at: 0)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseID) as? UserCell else {
            return UITableViewCell()
        }
        
        let user = users[indexPath.row]
        //
        cell.nameLbl.text = user.fullName
        cell.appointmentLbl.text = user.appointment
        cell.photoImgView.image = user.photo ?? #imageLiteral(resourceName: "defaultImg")
        //
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        //
        guard let vc = UserDetailViewController.storyboardInstance(storyboardName: "Main") else { return }
        vc.user = users[indexPath.row]
        vc.delegate = self
        //
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            allUsers = allUsers.filter({$0.uuid != users[indexPath.row].uuid})
            users.remove(at: indexPath.row)
            //
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}

// MARK: - UISearchBarDelegate
extension UsersTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        users = allUsers.filter {
            ($0.fullName)
                .lowercased()
                .contains(searchText.lowercased())
        }
        if searchText.isEmpty {
            users = allUsers
        }
        tableView.reloadData()
    }
}

