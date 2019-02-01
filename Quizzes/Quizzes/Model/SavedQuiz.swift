//
//  SavedQuiz.swift
//  Quizzes
//
//  Created by Leandro Wauters on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct SavedQuiz: Codable {
    let quizTitle: String
    let facts: [String]
    let savedAt: String
    
    public var date: Date {
        let date = savedAt.date()
        return date
    }
}
