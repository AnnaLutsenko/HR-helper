//
//  UserDetailViewController.swift
//  HR-helperApp
//
//  Created by Anna on 8/2/18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController, StoryboardInstance, EditUserProtocol {
    
    /// UI Elements
    @IBOutlet weak var photoImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var appointmentLbl: UILabel!
    @IBOutlet weak var birthdateLbl: UILabel!
    
    let imagePicker = UIImagePickerController()
    
    /// Protocols
    weak var delegate: EditUserProtocol?
    
    /// Models
    var user: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let user = user else { return }
        delegate?.editingUser(user)
    }

    func initController() {
        initEditRightBarBtn()
        navigationItem.title = user?.fullName
        imagePicker.delegate = self
        //
        photoImgView.layer.cornerRadius = photoImgView.frame.size.height/2
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addImageBtnClicked(_:)))
        photoImgView.addGestureRecognizer(tapGestureRecognizer)
        //
        setUserInfo()
    }
    
    func setUserInfo() {
        nameLbl.text = user?.fullName
        appointmentLbl.text = user?.appointment
        birthdateLbl.text = user?.birthdate
        photoImgView.image = user?.photo ?? #imageLiteral(resourceName: "defaultImg")
    }
    
    func initEditRightBarBtn() {
        let editBarBtn = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editUser))
        self.navigationItem.rightBarButtonItem = editBarBtn
    }
    
    func editingUser(_ user: UserModel) {
        self.user = user
        setUserInfo()
    }
    
    @objc func editUser() {
        guard let vc = EditUserViewController.storyboardInstance(storyboardName: "Main") else { return }
        vc.user = user
        vc.editDelegate = self
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: - Image Picker
    func chooseFromGallery() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func takePhoto() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    /// MARK: - Actions
    
    @IBAction func addImageBtnClicked(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        //
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        //
        let cameraAction = UIAlertAction(title: "Камера", style: .default) { action in
            self.takePhoto()
        }
        alertController.addAction(cameraAction)
        //
        let galleryAction = UIAlertAction(title: "Выбрать из галереи", style: .default) { action in
            self.chooseFromGallery()
        }
        alertController.addAction(galleryAction)
        //
        present(alertController, animated: true, completion: nil)
    }

}

// MARK: - UIPickerViewDelegate
extension UserDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            user?.photo = pickedImage
            photoImgView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

