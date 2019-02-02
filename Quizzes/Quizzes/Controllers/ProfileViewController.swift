//
//  ProfileViewController.swift
//  Quizzes
//
//  Created by Leandro Wauters on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit




class ProfileViewController: UIViewController {
    
//    var profileState: ProfileState = .notLoggedIn

    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    
    private var imagePickerViewController: UIImagePickerController!
    
    var logingStatus = LoginHelper.loginStatus {
        didSet{
            showLoginAlert()
            profileImageButton.setImage(UserdefaultsHelper.retiveImage(), for: .normal)
        }
    }
    var userName = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImagePickerViewController()
        if let userName = UserDefaults.standard.object(forKey: UserdefaultsHelper.usernameKey) as? String {
            profileButton.setTitle(userName, for: .normal)
            profileImageButton.setImage(UserdefaultsHelper.retiveImage(), for: .normal)

        } else {
            showAlert()
        }
//        if profileState == .notLoggedIn{
//            showAlert()
//        }
        // Do any additional setup after loading the view.
    }
    private func setupImagePickerViewController(){
        imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
//        if !UIImagePickerController.isSourceTypeAvailable(.camera){
//            cameraButton.isEnabled = false
//        }
    }
    private func showImagePickerController() {
        present(imagePickerViewController,animated: true,completion:  nil)
    }
    
    @IBAction func imageButtonPressed(_ sender: UIButton) {
        showImagePickerController()
        imagePickerViewController.sourceType = .photoLibrary
    }
    @IBAction func profileButtonWasPressed(_ sender: UIButton) {
        showAlert()
    }
    func showLoginAlert(){
        let alert = UIAlertController(title: "\(userName) Welcome!", message: nil, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default) { (UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
            }
        alert.addAction(okay)
        present(alert, animated: true, completion: nil)
    }
    func showAlert(){
        let alert = UIAlertController(title: "Enter User Name", message: "No spaces allowed or special characters", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "enter username"
            textField.textAlignment = .center
        }
        let okay = UIAlertAction(title: "Okay", style: .default) { (UIAlertAction) in
            if var text = alert.textFields?.first?.text{
                text.insert("@", at: text.startIndex)
                self.profileButton.setTitle(text, for: .normal)
                self.userName = text
                UserDefaults.standard.set(text, forKey: "UserName")
                self.logingStatus = .loggedIn
                
            }
        }
        alert.addAction(okay)
        present(alert, animated: true, completion: nil)
    }


}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
           profileImageButton.setImage(image, for: .normal)
           let imageToSave = image.jpegData(compressionQuality: 0.5)
            if let userName = UserDefaults.standard.object(forKey: UserdefaultsHelper.usernameKey) as? String{
            UserDefaults.standard.set(imageToSave, forKey: "UserImage" + userName)
            }
        } else {
            print("Image Nil")
        }
    dismiss(animated: true, completion: nil)
    }
}
