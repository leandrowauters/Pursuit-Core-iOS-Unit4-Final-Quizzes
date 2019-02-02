//
//  APIClient.swift
//  Quizzes
//
//  Created by Leandro Wauters on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct APIClient {
   static func getQuizzes(completionHandler: @escaping(AppError?, [Quiz]?) -> Void) {
        let stringURL = "https://quizzes-9ff59.firebaseio.com/.json"
        NetworkHelper.shared.performDataTask(endpointURLString: stringURL, httpMethod: "GET", httpBody: nil) { (appError, data) in
            if appError != nil {
                print(AppError.badURL("Bad URL"))
            }
            if let data = data {
                do{
                    let quizzesData = try JSONDecoder().decode([Quiz].self, from: data)
                    completionHandler(appError, quizzesData)
                }catch{
                    completionHandler(appError, nil)
                }
            }
        }
    }
}
