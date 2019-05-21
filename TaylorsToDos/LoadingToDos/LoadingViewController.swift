//
//  LoadingViewController.swift
//  TaylorsToDos
//
//  Created by Taylor Lindsay on 3/11/19.
//  Copyright © 2019 Taylor Lindsay at Babbel. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

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
                self?.performSegue(withIdentifier: "SkipNav", sender: nil)
                print(array)
            }
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SkipNav" {
            let vc = segue.destination as! UINavigationController
            let viewModelToSegue = ToDosViewModel(database: ((UIApplication.shared.delegate as? AppDelegate)?.allToDosDataBase)!)
            let usableVc = vc.topViewController as! ToDosViewController
            usableVc.viewModel = viewModelToSegue
            usableVc.viewModel.delegate = usableVc
        }

}


//    @IBAction func seeToDos() {
//        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ToDosViewController") as? ToDosViewController else { return }
//        let viewModelToSegue = ToDosViewModel(database: ((UIApplication.shared.delegate as? AppDelegate)?.allToDosDataBase)!)
//        vc.viewModel = viewModelToSegue
//        vc.viewModel.delegate = vc
//        self.present(navigationController?, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
//        navigationController?.present(vc, animated: true, completion: nil)
////        self.present(vc, animated: true, completion: nil)
//    }

}

