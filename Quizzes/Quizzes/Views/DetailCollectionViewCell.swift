//
//  DetailCollectionViewCell.swift
//  Quizzes
//
//  Created by Leandro Wauters on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    lazy var quizLabel: UILabel = {
        var label = UILabel()
        label.text = "Label"
        label.textColor = .black
        label.numberOfLines = 5
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
    
    func setupViews(){
        addSubview(quizLabel)
        quizLabel.translatesAutoresizingMaskIntoConstraints = false
        quizLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        quizLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        quizLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        quizLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
}
