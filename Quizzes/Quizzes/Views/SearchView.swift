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
    lazy var quizsearchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.placeholder = "Search For Quiz"
        return searchBar
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
        setupSearchBar()
        setupCollectionView()
    }
    private func setupCollectionView(){
        addSubview(quizzesCollectionView)
        quizzesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        quizzesCollectionView.topAnchor.constraint(equalTo: quizsearchBar.bottomAnchor).isActive = true
        quizzesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        quizzesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        quizzesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        quizzesCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        quizzesCollectionView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        quizzesCollectionView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
//        quizzesCollectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    private func setupSearchBar(){
        addSubview(quizsearchBar)
        quizsearchBar.translatesAutoresizingMaskIntoConstraints = false
        quizsearchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        quizsearchBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        quizsearchBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
}

