//
//  UserCell.swift
//  HR-helperApp
//
//  Created by Anna on 8/2/18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    static let reuseID = String(describing: UserCell.self)
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var appointmentLbl: UILabel!
    @IBOutlet weak var photoImgView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        photoImgView.layer.cornerRadius = photoImgView.frame.height/2
    }
    
}
