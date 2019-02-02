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
    
    self.tabBarController?.delegate = UIApplication.shared.delegate as? UITabBarControllerDelegate
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
    override func viewDidAppear(_ animated: Bool) {
        if let userName = UserDefaults.standard.object(forKey: UserdefaultsHelper.usernameKey) as? String {
        quizzes = DataPersistenceModel.getQuizzes(userName: userName)
        }
    }
    @objc func deleteWasPressed(sender: UIButton){
        if let userName = UserDefaults.standard.object(forKey: UserdefaultsHelper.usernameKey) as? String {
            let index = sender.tag
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { alert in
                DataPersistenceModel.deleteQuiz(userName: userName, index: index)
            self.quizzes = DataPersistenceModel.getQuizzes(userName: userName)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuizCell", for: indexPath) as? QuizCollectionViewCell else {print("Cell is nil")
            return UICollectionViewCell()
        }
        let quizToSet = quizzes[indexPath.row]
        cell.quizLabel.text = quizToSet.quizTitle
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 2
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteWasPressed(sender:)), for: .touchUpInside)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:200, height:300)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let selectedQuiz = quizzes[indexPath.row]
        let detailVC = DetailViewController.init(quizFacts: selectedQuiz.facts, quizTitle: selectedQuiz.quizTitle)
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}

