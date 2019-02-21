//
//  ToDoViewModel.swift
//  TaylorsToDos
//
//  Created by Taylor Lindsay on 2/21/19.
//  Copyright © 2019 Taylor Lindsay at Babbel. All rights reserved.
//

import Foundation

class ToDoViewModel {
    var toDos: [ToDo]
    var initialToDos: [ToDo]
    
    init() {
        toDos = []
        initialToDos = [ToDo(title: "Welcome! Start adding ToDos", important: true)]
        toDos.append(initialToDos[0])
    }
}
