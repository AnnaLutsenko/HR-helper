//
//  AddUserProtocol.swift
//  HR-helperApp
//
//  Created by Anna on 8/2/18.
//  Copyright © 2018 Anna. All rights reserved.
//

import Foundation

//MARK: Edit User Protocol here.
protocol EditUserProtocol: class {
    func editingUser(_ user: UserModel)
}

//MARK: Add User Protocol here.
protocol AddUserProtocol: class {
    func addUser(_ user: UserModel)
}
