//
//  UserdefaultsHelper.swift
//  Quizzes
//
//  Created by Leandro Wauters on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

struct UserdefaultsHelper {
    static var usernameKey = "UserName" 
    static var userImageKey = "UserImage"
    
    static func retiveImage() -> UIImage {
        var imageToReturn = UIImage()
        if let userName = UserDefaults.standard.object(forKey: UserdefaultsHelper.usernameKey) as? String {
            if let imageData = UserDefaults.standard.object(forKey: UserdefaultsHelper.userImageKey + userName) as? Data{
                if let image = UIImage(data: imageData){
                    imageToReturn = image
                }
            }
            
        } else {
            imageToReturn = UIImage(named: "placeholder-image")!
        }
        return imageToReturn
    }
}
