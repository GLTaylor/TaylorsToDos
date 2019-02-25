//
//  MakeNewToDoViewModel.swift
//  TaylorsToDos
//
//  Created by Taylor Lindsay on 2/25/19.
//  Copyright © 2019 Taylor Lindsay at Babbel. All rights reserved.
//

import Foundation

class MakeNewToDoViewModel {
    
    private let db: ToDosDataBase
    
    init(database: ToDosDataBase) {
        self.db = database
    }
    
    func addNewToDo(textOfToDo: String, completedState: Bool) {
        let newToDo = ToDo(title: textOfToDo, completed: completedState)
        db.addToDoToData(newToDo: newToDo)
    }
}
