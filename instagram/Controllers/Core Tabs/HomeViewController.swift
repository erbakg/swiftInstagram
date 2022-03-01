//
//  ViewController.swift
//  instagram
//
//  Created by Erbol on 24.02.2022.
//

import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        handleNotAuthenticated()
    }
    
    private func handleNotAuthenticated () {
            //check auth status
            if Auth.auth().currentUser == nil {
                //show login view
                let loginVC = LoginViewController()
                loginVC.modalPresentationStyle = .fullScreen
                present(loginVC, animated: false)
            }
    }


}

