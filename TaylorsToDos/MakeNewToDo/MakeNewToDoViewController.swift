//
//  MakeNewToDoViewController.swift
//  TaylorsToDos
//
//  Created by Taylor Lindsay on 2/25/19.
//  Copyright © 2019 Taylor Lindsay at Babbel. All rights reserved.
//

import Foundation
import UIKit

class MakeNewToDoViewController: UIViewController {
    
    @IBOutlet var toDoTextField: UITextField!
    @IBOutlet var completedSwitch: UISwitch!
    var viewModel: MakeNewToDoViewModel!
    var mainToDosDatabase: ToDosDataBase? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        return delegate?.allToDosDataBase
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
         viewModel = MakeNewToDoViewModel(database: mainToDosDatabase ?? ToDosDataBase())
    }
    
    @IBAction func addThisToDo(_sender: UIButton) {
        let text = toDoTextField.text
        let completed = completedSwitch.isOn
        viewModel.addNewToDo(textOfToDo: text ?? "New To Do", completedState: completed)
    }
    
}
