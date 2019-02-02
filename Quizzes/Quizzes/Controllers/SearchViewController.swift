//
//  SearchViewController.swift
//  Quizzes
//
//  Created by Leandro Wauters on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    var alreadySave = [String]()
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
        searchView.quizsearchBar.delegate = self
        getQuizzes()
        // Do any additional setup after loading the view.
    }
    @objc func addWasPressed(sender: UIButton) {
        if let userName = UserDefaults.standard.object(forKey: UserdefaultsHelper.usernameKey) as? String {
            let index = sender.tag
            let quizToSave = quizzes[index]
            var ids = [String]()
            let quizzesSaved = DataPersistenceModel.getQuizzes(userName: userName)
            for quiz in quizzesSaved {
                ids.append(quiz.id)
            }
            if ids.contains(quizToSave.id){
                let alert = UIAlertController(title: "Quiz already saved", message: "Please choose another one", preferredStyle: .alert)
                let okay = UIAlertAction(title: "Okay", style: .default) { (UIAlertAction) in
                    self.dismiss(animated: true, completion: nil)

                }
                alert.addAction(okay)
                present(alert, animated: true, completion: nil)
                    } else {
                        let timeStamp = Date.getISOTimestamp()
                        let saveQuiz = SavedQuiz.init(id: quizToSave.id ,quizTitle: quizToSave.quizTitle, facts: quizToSave.facts, savedAt: timeStamp)
                        DataPersistenceModel.saveQuizz(userName: userName, quiz: saveQuiz)
                        let alert = UIAlertController(title: "Quiz Saved To Quizzes", message: nil, preferredStyle: .alert)
                        let okay = UIAlertAction(title: "Okay", style: .default) { (UIAlertAction) in
                            self.dismiss(animated: true, completion: nil)
                }
                    alert.addAction(okay)
                    present(alert, animated: true, completion: nil)
            }
        }
    }
    func getQuizzes(){
        APIClient.getQuizzes { (appError, quizzes) in
            if let appError = appError {
                print(AppError.errorMessage(appError))
            }
            if let quizzes = quizzes {
                self.quizzes = quizzes
            }
        }
    }
    func searchForQuiz(keyword: String) {
        APIClient.getQuizzes { (appError, quizzes) in
            if let appError = appError {
                print(AppError.errorMessage(appError))
            }
            if let quizzes = quizzes {
                self.quizzes = quizzes.filter{$0.quizTitle.lowercased().contains(keyword.lowercased())}
            }
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
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchForQuiz(keyword: searchText)
        if searchText.isEmpty{
            getQuizzes()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
