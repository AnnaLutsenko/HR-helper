//
//  UserModel.swift
//  HR-helperApp
//
//  Created by Anna on 8/2/18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

struct UserModel {
    private (set) var uuid = UUID().uuidString
    
    var fullName: String
    var appointment: String
    var birthdate: String
    
    var photo: UIImage?
    
    
    init(fullName: String, appointment: String, birthdate: String, photo: UIImage? = nil) {
        self.fullName = fullName
        self.appointment = appointment
        self.birthdate = birthdate
        self.photo = photo
    }
}

extension UserModel {
    static let defaultUsers: [UserModel] = [
        UserModel(fullName: "Dmitriy Kitz", appointment: "Web developer", birthdate: "11.01.1989", photo: #imageLiteral(resourceName: "userImg3")),
        UserModel(fullName: "Angela", appointment: "Admin", birthdate: "11.01.1989", photo: #imageLiteral(resourceName: "userImg2")),
        UserModel(fullName: "Andriy Pont", appointment: "Backend developer", birthdate: "09.01.1994"),
        UserModel(fullName: "Kate Girl", appointment: "QA ingener", birthdate: "11.01.1989", photo: #imageLiteral(resourceName: "userImg1")),
        UserModel(fullName: "Leonid Folet", appointment: "iOS developer", birthdate: "08.12.1991"),
        UserModel(fullName: "Georgiy Lion", appointment: "Full stack developer", birthdate: "21.09.1983"),
        UserModel(fullName: "Volodymir Intor", appointment: "Android developer", birthdate: "04.07.1973"),
        UserModel(fullName: "Oleg Razin", appointment: "C# developer", birthdate: "31.01.1967"),
        UserModel(fullName: "Innocentiy Boriz", appointment: "C++ developer", birthdate: "11.01.1989")
    ]
}
