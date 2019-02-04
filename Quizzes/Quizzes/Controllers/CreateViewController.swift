//
//  CreateViewController.swift
//  Quizzes
//
//  Created by Leandro Wauters on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var quizTitle: UITextField!
    
    @IBOutlet weak var quizFact1TextView: UITextView!
    
    @IBOutlet weak var quizFact2TextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        quizTitle.delegate = self
        quizFact1TextView.delegate = self
        quizFact2TextView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if LoginHelper.loginStatus == .notLoggedIn {
            showAlert()
        }
        
    }
    @IBAction func createWasPressed(_ sender: UIBarButtonItem) {
        if quizTitle.text != ""  && (quizFact1TextView.text != "" && quizFact1TextView.text != "Fact 1") && (quizFact2TextView.text != "" && quizFact2TextView.text != "Fact 2"){
            let facts = [quizFact1TextView.text!, quizFact2TextView.text!]
            let timeStamp = Date.getISOTimestamp()
            let quizTitle = self.quizTitle.text!
            let id = UUID().uuidString
            let createdQuiz = SavedQuiz.init(id: id, quizTitle: quizTitle, facts: facts, savedAt: timeStamp)
            if let userName = UserDefaults.standard.object(forKey: UserdefaultsHelper.usernameKey) as? String{
                
                DataPersistenceModel.saveQuizz(userName: userName, quiz: createdQuiz)
                let alert = UIAlertController(title: "Quiz Saved To My Quizzes", message: nil, preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
                    self.dismiss(animated: true, completion: nil)
                }
                alert.addAction(ok)
                present(alert, animated: true, completion: nil)
            }
            
        } else {
            let alert = UIAlertController(title: "Quiz requires 2 facts", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func cancelWasPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupUI(){
        quizTitle.layer.borderColor = UIColor.white.cgColor
        quizTitle.layer.borderWidth = 3
        quizTitle.layer.cornerRadius = 10
        quizTitle.layer.masksToBounds = true
        quizFact1TextView.layer.borderColor = UIColor.white.cgColor
        quizFact1TextView.layer.borderWidth = 3
        quizFact1TextView.layer.cornerRadius = 10
        quizFact1TextView.layer.masksToBounds = true
        quizFact2TextView.layer.borderColor = UIColor.white.cgColor
        quizFact2TextView.layer.borderWidth = 3
        quizFact2TextView.layer.cornerRadius = 10
        quizFact2TextView.layer.masksToBounds = true
    }
    func showAlert() {
        let alert = UIAlertController(title: "User Not Logged In", message: "Please login to create quizzes", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okay)
        present(alert, animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
