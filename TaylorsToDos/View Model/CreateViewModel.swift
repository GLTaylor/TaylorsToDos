//
//  CreateViewModel.swift
//  TaylorsToDos
//
//  Created by Taylor Lindsay on 2/21/19.
//  Copyright © 2019 Taylor Lindsay at Babbel. All rights reserved.
//

import Foundation


class CreateViewModel {
    
    func createToDo(name: String, markAsImportant: Bool) -> ToDo {
            let newToDo = ToDo(title: name, important: markAsImportant)
            return newToDo
        // append to other View Model's array? or combine view models
        
        }
}
