//
//  ViewController.swift
//  Carplay Test
//
//  Created by Claudio Barbera on 18/08/22.
//

import UIKit
import Intercom

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func login() {
        Intercom.loginUnidentifiedUser { result in
            print(result)
        }
    }
}

