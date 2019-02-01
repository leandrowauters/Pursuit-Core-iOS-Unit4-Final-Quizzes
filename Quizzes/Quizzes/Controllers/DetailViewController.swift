//
//  DetaileViewController.swift
//  Quizzes
//
//  Created by Leandro Wauters on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    var quizFacts = [String]()
    var quizTitle: String!
    let detailView = DetailView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailView)
        detailView.quizDetailCollectionView.dataSource = self
        detailView.quizDetailCollectionView.delegate = self
    }
    
    init(quizFacts: [String], quizTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.quizFacts = quizFacts
        self.quizTitle = quizTitle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizFacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as? DetailCollectionViewCell else {print("Cell is nil")
            return UICollectionViewCell()
        }
        cell.quizLabel.text = quizTitle
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let cell = self.favoritesView.favoritesCollectionView.cellForItem(at: indexPath) as? FavoriteCell else {return}
        guard let cell = self.detailView.quizDetailCollectionView.cellForItem(at: indexPath) as? DetailCollectionViewCell else { print("Wrong Cell")
            return}
        if cell.quizLabel.text == quizTitle{
            UIView.transition(with: cell, duration: 1, options: .transitionFlipFromRight, animations: {
                cell.quizLabel.text = self.quizFacts[indexPath.row]
            })
        } else {
            UIView.transition(with: cell, duration: 1, options: .transitionFlipFromRight, animations: {
                cell.quizLabel.text = self.quizTitle
            })
        }
    }
    
}
