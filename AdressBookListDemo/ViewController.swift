//
//  ViewController.swift
//  AdressBookListDemo
//
//  Created by 明孔 on 2019/11/5.
//  Copyright © 2019 明孔. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self .present(AddressbookController.init(), animated: true, completion: nil)
    }
}

