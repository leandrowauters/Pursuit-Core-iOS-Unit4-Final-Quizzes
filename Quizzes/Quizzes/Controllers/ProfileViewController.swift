//
//  ProfileViewController.swift
//  Quizzes
//
//  Created by Leandro Wauters on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

enum ProfileState {
    case loggedIn
    case notLoggedIn
}


class ProfileViewController: UIViewController {
    
//    var profileState: ProfileState = .notLoggedIn
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userName = UserDefaults.standard.object(forKey: "UserName") as? String {
            profileButton.setTitle(userName, for: .normal)
        } else {
            showAlert()
        }
//        if profileState == .notLoggedIn{
//            showAlert()
//        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func profileButtonWasPressed(_ sender: UIButton) {
        
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
//                self.profileState = .loggedIn
                UserDefaults.standard.set(text, forKey: "UserName")
                
            }
        }
        alert.addAction(okay)
        present(alert, animated: true, completion: nil)
    }


}
