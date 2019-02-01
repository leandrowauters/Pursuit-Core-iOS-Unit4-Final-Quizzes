//
//  DataPersistenceModel.swift
//  Quizzes
//
//  Created by Leandro Wauters on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation


struct DataPersistenceModel {
    
    private static var users = [User]()
    private static var userName = "UserName.plist"
    
    static func saveUser(){
        let path = DataPersistenceManager.filepathToDocumentsDiretory(filename: userName)
        do {
            let data = try PropertyListEncoder().encode(users)
            try data.write(to: path, options: .atomic)
        } catch {
            print("Property list encoding error \(error)")
        }
    }
    static func saveUser(userName: User){
        users.append(userName)
        saveUser()
    }
    static func getUsers() -> [User]{
        let path = DataPersistenceManager.filepathToDocumentsDiretory(filename: userName).path
        if FileManager.default.fileExists(atPath: path){
            if let data = FileManager.default.contents(atPath: path){
                do {
                    users = try PropertyListDecoder().decode([User].self, from: data)
                }catch{
                    print("Property list decoding error: \(error)")
                }
            } else {
                print("getPhotoJournal data is nil")
            }
        } else {
            print("\(userName) does not exist")
        }
        return users
    }
    
}
