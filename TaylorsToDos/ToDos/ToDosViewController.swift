//
//  ToDosViewController.swift
//  TaylorsToDos
//
//  Created by Taylor Lindsay on 2/22/19.
//  Copyright © 2019 Taylor Lindsay at Babbel. All rights reserved.
//

import Foundation
import UIKit

class ToDosViewController: UIViewController, ToDosViewModelDelegate {
       
    var viewModel: ToDosViewModel!

    @IBOutlet var toDosTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        toDosTable.delegate = self
        toDosTable.dataSource = self
        viewModel = ToDosViewModel(database: ((UIApplication.shared.delegate as? AppDelegate)?.allToDosDataBase)!)
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.start()
        toDosTable.reloadData()
    }
    // MARK: - ToDosViewModelDelegate
    
    internal var arrayToUse: [ToDo] = []
    
    func dataIsReady() {
      print("The array to use is: \(self.arrayToUse)")
        DispatchQueue.main.async {
            self.toDosTable.reloadData()
        }
    }
}

    // MARK: - TableViewExtension

extension ToDosViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayToUse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)

        let toDoForTable = arrayToUse[indexPath.row]
        if toDoForTable.completed == true {
            cell.textLabel?.text = " ✔︎ \(toDoForTable.title)"
        } else {
            cell.textLabel?.text = toDoForTable.title
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.arrayToUse.remove(at: indexPath.row)
            self.viewModel.deleteToDo(toDoToDeleteIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
