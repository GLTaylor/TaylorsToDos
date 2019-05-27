//
//  ToDosViewController.swift
//  TaylorsToDos
//
//  Created by Taylor Lindsay on 2/22/19.
//  Copyright © 2019 Taylor Lindsay at Babbel. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class ToDosViewController: UIViewController, ToDosViewModelDelegate {
       
    var viewModel: ToDosViewModel! {
        didSet {
           viewModel.delegate = self
        }
    }

    @IBOutlet var toDosTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
//        bindOutputs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.start()
        toDosTable.reloadData()
    }

    internal var arrayToUse: [ToDo] = []
    
    func dataIsReady() {
        DispatchQueue.main.async {
            self.toDosTable.reloadData()
        }
    }


//    func bindOutputs() {
//
//    }

    func setUpTableView() {
        toDosTable.delegate = self
        toDosTable.dataSource = self
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
