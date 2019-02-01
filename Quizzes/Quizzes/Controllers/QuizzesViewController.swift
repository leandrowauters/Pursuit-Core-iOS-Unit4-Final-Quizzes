//
//  ViewController.swift
//  Quizzes
//
//  Created by Alex Paul on 1/31/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class QuizzesViewController: UIViewController,
UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    
    @IBOutlet weak var quizzesCollectionView: UICollectionView!
    var quizzes = [SavedQuiz]() {
        didSet{
            DispatchQueue.main.async {
                self.quizzesCollectionView.reloadData()
            }
        }
    }
  override func viewDidLoad() {
    super.viewDidLoad()
    quizzesCollectionView.delegate = self
    quizzesCollectionView.dataSource = self
    quizzesCollectionView.register(QuizCollectionViewCell.self, forCellWithReuseIdentifier: "QuizCell")
    if let userName = UserDefaults.standard.object(forKey: UserdefaultsHelper.usernameKey) as? String{
        quizzes = DataPersistenceModel.getQuizzes(userName: userName)
    }
    
    // Do any additional setup after loading the view, typically from a nib.
  }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuizCell", for: indexPath) as? QuizCollectionViewCell else {print("Cell is nil")
            return UICollectionViewCell()
        }
        let quizToSet = quizzes[indexPath.row]
        cell.quizLabel.text = quizToSet.quizTitle
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:200, height:100)
    }
}

