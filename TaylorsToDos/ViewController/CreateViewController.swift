//
//  CreateViewController.swift
//  TaylorsToDos
//
//  Created by Taylor Lindsay on 2/21/19.
//  Copyright © 2019 Taylor Lindsay at Babbel. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var importantSwitch: UISwitch!
    var viewModel: CreateViewModel = CreateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addTapped(_ sender: UIButton) {
        let newTitle = titleTextField.text
        let newImportance = importantSwitch.isOn
        viewModel.createToDo(name: newTitle ?? "New", markAsImportant: newImportance)
    }

    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
