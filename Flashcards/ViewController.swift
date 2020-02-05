//
//  ViewController.swift
//  Flashcards
//
//  Created by Bethany Bin on 2/5/20.
//  Copyright © 2020 Bethany Bin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        backLabel.isHidden = true
        frontLabel.isHidden = false
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if(frontLabel.isHidden){
            frontLabel.isHidden = false
            backLabel.isHidden = true
        }
        else{
            backLabel.isHidden = false
            frontLabel.isHidden = true
        }
    }
    
}

