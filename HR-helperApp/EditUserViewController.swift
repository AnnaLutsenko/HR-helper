//
//  EditUserViewController.swift
//  HR-helperApp
//
//  Created by Anna on 8/2/18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

class EditUserViewController: UIViewController, StoryboardInstance {

    /// UI Elements
    @IBOutlet weak var photoImgView: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var appointmentTF: UITextField!
    @IBOutlet weak var birthdateLbl: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let imagePicker = UIImagePickerController()
    
    /// Protocols
    weak var editDelegate: EditUserProtocol?
    weak var addDelegate: AddUserProtocol?
    
    /// Models
    var user: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initController()
    }
    
    func initController() {
        setUserInfo()
        setDateForDatePicker()
        //
        imagePicker.delegate = self
        //
        // added gesture recognizer to photo image view
        photoImgView.layer.cornerRadius = photoImgView.frame.size.height/2
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addImageBtnClicked(_:)))
        photoImgView.addGestureRecognizer(tapGestureRecognizer)
        //
    }
    
    func setDateForDatePicker() {
        /// Set min yaer for date picker
        let gregorian = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.year = -90
        datePicker.minimumDate = gregorian.date(byAdding: components, to: Date())
        
        //
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        //
        if let date = user?.birthdate {
            guard let selectedDate = dateFormatter.date(from: date) else { return }
            datePicker.setDate(selectedDate, animated: false)
        } else {
            let selectedDate: String = dateFormatter.string(from: datePicker.date)
            birthdateLbl.text = selectedDate
        }
    }
    
    func setUserInfo() {
        nameTF.text = user?.fullName
        appointmentTF.text = user?.appointment
        birthdateLbl.text = user?.birthdate
        photoImgView.image = user?.photo ?? #imageLiteral(resourceName: "defaultImg")
    }

    // MARK: - Image Picker
    func chooseFromGallery() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        //
        present(imagePicker, animated: true, completion: nil)
    }
    
    func takePhoto() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        //
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Actions
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

    @IBAction func dateChanged(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: sender.date)
        birthdateLbl.text = selectedDate
    }
    
    @IBAction func dismissVC(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func saveEditing(_ sender: UIButton) {
        guard let name = nameTF.text,
            let position = appointmentTF.text,
            let birthdate = birthdateLbl.text else { return }
        
        if name.isEmpty || position.isEmpty {
            UIAlertController.presentAlert(on: self, title: Constant.Alert.title, message: Constant.Alert.emptyField)
        } else {
            //
            var user = UserModel(fullName: name, appointment: position, birthdate: birthdate)
            user.photo = photoImgView.image
            //
            editDelegate?.editingUser(user)
            addDelegate?.addUser(user)
            //
            dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - UITextFieldDelegate
extension EditUserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

// MARK: - UIPickerViewDelegate
extension EditUserViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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

