//
//  ToDosDataBase.swift
//  TaylorsToDos
//
//  Created by Taylor Lindsay on 2/22/19.
//  Copyright © 2019 Taylor Lindsay at Babbel. All rights reserved.
//

import Foundation


class ToDosDataBase: ToDosDataBaseProtocol {
    internal var dataToDos: [ToDo] = [ToDo(title: "Learn RxSwift", completed: false), ToDo(title: "Cook Dinner", completed: true), ToDo(title: "Stay Alive", completed: false)]
    
    func readAll(completionHandler: @escaping ([ToDo]?, Error?) -> Void) {
        completionHandler(dataToDos, nil)
    }
    
    func addToDoToData(newToDo: ToDo) {
        dataToDos.append(newToDo)
        print("A new To do was added!")
    }
    
    func removeToDoData(byeToDoIndex: Int) {
        dataToDos.remove(at: byeToDoIndex)
        print("A To Do was removed")
    }
    
}

protocol ToDosDataBaseProtocol {
    var dataToDos: [ToDo] {get set}
    
    func readAll(completionHandler: @escaping ([ToDo]?, Error?) -> Void)
    func addToDoToData(newToDo: ToDo)
    func removeToDoData(byeToDoIndex: Int)
    
}
