//
//  DetaileViewController.swift
//  Quizzes
//
//  Created by Leandro Wauters on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var quiz: SavedQuiz!
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    init(quiz: SavedQuiz) {
        super.init(nibName: nil, bundle: nil)
        self.quiz = quiz
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
