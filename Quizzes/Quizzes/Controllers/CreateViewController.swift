//
//  CreateViewController.swift
//  Quizzes
//
//  Created by Leandro Wauters on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    @IBOutlet weak var quizTitle: UITextField!
    
    @IBOutlet weak var quizFact1TextView: UITextView!
    
    @IBOutlet weak var quizFact2TextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
