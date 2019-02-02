//
//  LoginHelper.swift
//  Quizzes
//
//  Created by Leandro Wauters on 2/2/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

enum ProfileState {
    case loggedIn
    case notLoggedIn
}

class LoginHelper {
    static var loginStatus: ProfileState = .notLoggedIn
}
