//
//  SearchCellCollectionViewCell.swift
//  Quizzes
//
//  Created by Leandro Wauters on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class SearchCellCollectionViewCell: UICollectionViewCell {
    
    lazy var addButton: UIButton = {
        var button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Futura", size: 50)
        
        return button
    }()
    
    lazy var quizLabel: UILabel = {
        var label = UILabel()
        label.text = "Label"
        label.font = UIFont(name: "Futura", size: 30)
        label.textColor = .white
        label.numberOfLines = 10
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        setUpButton()
        setUpLabel()
    }
    func setUpButton(){
        addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func setUpLabel(){
        addSubview(quizLabel)
        quizLabel.translatesAutoresizingMaskIntoConstraints = false
        quizLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        quizLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        quizLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        quizLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
}
