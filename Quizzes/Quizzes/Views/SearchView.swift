//
//  SearchView.swift
//  Quizzes
//
//  Created by Leandro Wauters on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class SearchView: UIView {

    lazy var quizzesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: 300, height: 350)
        layout.sectionInset = UIEdgeInsets.init(top: 20, left: 10, bottom: 20, right: 10)
        layout.scrollDirection = .vertical
        //        layout.scrollDirection = .horizontal
        var collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func commonInit(){
        setupViews()
        self.quizzesCollectionView.register(SearchCellCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCell")
 
    }
    private func setupViews() {
        setupCollectionView()
    }
    private func setupCollectionView(){
        addSubview(quizzesCollectionView)
        quizzesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        quizzesCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        quizzesCollectionView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        quizzesCollectionView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        quizzesCollectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
}

