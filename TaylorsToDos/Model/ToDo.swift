//
//  ToDo.swift
//  TaylorsToDos
//
//  Created by Taylor Lindsay on 2/21/19.
//  Copyright © 2019 Taylor Lindsay at Babbel. All rights reserved.
//

import Foundation


class ToDo {
    var title: String
    var important: Bool? = false
    
    init(title: String, important: Bool?) {
        self.title = title
        self.important = important
    }
}
