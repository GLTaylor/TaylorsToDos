//
//  LoadingViewController.swift
//  TaylorsToDos
//
//  Created by Taylor Lindsay on 3/11/19.
//  Copyright © 2019 Taylor Lindsay at Babbel. All rights reserved.
//

import Foundation
import UIKit

class LoadingToDos: UIViewController, UIApplicationDelegate {
    var toDosDataBase: ToDosDataBaseProtocol? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        return delegate?.allToDosDataBase
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllTheToDos()
    }

    @IBAction func loadAllTheToDos() {
        toDosDataBase?.readAll(completionHandler: { [weak self] (array, error) in
            DispatchQueue.main.async {
                guard let array = array else {
                    print("WE HAVE GONE WRONG")
                    return
                }
                self?.seeToDos()
                print(array)
            }
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ToDosViewController") as? ToDosViewController else { return }
        let viewModelToSegue = ToDosViewModel(database: ((UIApplication.shared.delegate as? AppDelegate)?.allToDosDataBase)!)
        vc.viewModel = viewModelToSegue
    }

    @IBAction func seeToDos() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ToDosViewController") as? ToDosViewController else { return }
        let viewModelToSegue = ToDosViewModel(database: ((UIApplication.shared.delegate as? AppDelegate)?.allToDosDataBase)!)
        vc.viewModel = viewModelToSegue
        vc.viewModel.delegate = vc

        performSegue(withIdentifier: "Loaded", sender: nil)
    }

}

