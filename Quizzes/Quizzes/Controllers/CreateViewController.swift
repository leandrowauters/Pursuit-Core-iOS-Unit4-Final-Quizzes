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
        quizTitle.delegate = self
        quizFact1TextView.delegate = self
        quizFact2TextView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createWasPressed(_ sender: UIBarButtonItem) {
        if quizTitle.text != "" && quizFact1TextView.text != "" && quizFact2TextView.text != ""{
            let facts = [quizFact1TextView.text!, quizFact2TextView.text!]
            let timeStamp = Date.getISOTimestamp()
            let quizTitle = self.quizTitle.text!
            
            let createdQuiz = SavedQuiz.init(id: "0", quizTitle: quizTitle, facts: facts, savedAt: timeStamp)
            if let userName = UserDefaults.standard.object(forKey: UserdefaultsHelper.usernameKey) as? String{
                DataPersistenceModel.saveQuizz(userName: userName, quiz: createdQuiz)
            }
            
        } else {
            let alert = UIAlertController(title: "Quiz requires 2 facts", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func cancelWasPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
