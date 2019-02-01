//
//  SearchViewController.swift
//  Quizzes
//
//  Created by Leandro Wauters on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var quizzes = [Quiz]() {
        didSet {
            DispatchQueue.main.async {
                self.searchView.quizzesCollectionView.reloadData()
            }
        }
    }
    var searchView = SearchView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchView)
        searchView.quizzesCollectionView.delegate = self
        searchView.quizzesCollectionView.dataSource = self
        APIClient.getQuizzes { (appError, quizzes) in
            if let appError = appError {
                print(AppError.errorMessage(appError))
            }
            if let quizzes = quizzes {
                self.quizzes = quizzes
            }
        }
        // Do any additional setup after loading the view.
    }
    @objc func addWasPressed(sender: UIButton) {
        if let userName = UserDefaults.standard.object(forKey: UserdefaultsHelper.usernameKey) as? String {
        let index = sender.tag
        let quizToSave = quizzes[index]
        let alreadySave = DataPersistenceModel.getQuizzes(userName: userName)
            for savedQuiz in alreadySave{
                if savedQuiz.id == quizToSave.id {
                    print("Already Saved")
                } else {
                    let saveAt = Date.getISOTimestamp()
                    let savedQuiz = SavedQuiz.init(id: quizToSave.id, quizTitle: quizToSave.quizTitle, facts: quizToSave.facts, savedAt: saveAt)
                    
                    DataPersistenceModel.saveQuizz(userName: userName, quiz: savedQuiz)
                }
            }
        let saveAt = Date.getISOTimestamp()
        let savedQuiz = SavedQuiz.init(id: quizToSave.id, quizTitle: quizToSave.quizTitle, facts: quizToSave.facts, savedAt: saveAt)
            
        DataPersistenceModel.saveQuizz(userName: userName, quiz: savedQuiz)

        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchCellCollectionViewCell else {print("Cell Not Found")
            return UICollectionViewCell()}
        let quizToShow = quizzes[indexPath.row]
        cell.quizLabel.text = quizToShow.quizTitle
        cell.addButton.tag = indexPath.row
        cell.addButton.addTarget(self, action: #selector(addWasPressed(sender:)), for: .touchUpInside)
        return cell
    }
    
}
