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
    var arrayToUse: [ToDo] = []
    
    var mainToDosDatabase: ToDosDataBase? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        return delegate?.allToDosDataBase
    }
    
    var viewModel: ToDosViewModel!

    @IBOutlet var toDosTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDosTable.delegate = self
        toDosTable.dataSource = self
        viewModel = ToDosViewModel(database: mainToDosDatabase!)
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.start()
        toDosTable.reloadData()
        print(arrayToUse)
    }
    
    func dataIsReady() {
      print("The array to use is: \(self.arrayToUse)")
      toDosTable.reloadData()
    }    
}

extension ToDosViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayToUse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellData", for: indexPath)
        let toDoForTable = arrayToUse[indexPath.row]
        cell.textLabel?.text = toDoForTable.title
        return cell
    }
}
