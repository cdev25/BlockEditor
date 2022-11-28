//
//  ViewController.swift
//  BlockEditor
//
//  Created by Mini on 11/26/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        let vc = BlockEditor.spawn()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }

}

