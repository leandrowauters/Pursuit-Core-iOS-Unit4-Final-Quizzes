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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchCellCollectionViewCell else {print("Cell Not Found")
            return UICollectionViewCell()}
        let quizToShow = quizzes[indexPath.row]
        cell.quizLabel.text = quizToShow.quizTitle
        return cell
    }
    
}
