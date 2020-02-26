//
//  ViewController.swift
//  Flashcards
//
//  Created by Bethany Bin on 2/5/20.
//  Copyright © 2020 Bethany Bin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstOption: UIButton!
    
    @IBOutlet weak var secondOption: UIButton!
    @IBOutlet weak var thirdOption: UIButton!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        backLabel.isHidden = true
        frontLabel.isHidden = false
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        backLabel.layer.cornerRadius = 20.0
        frontLabel.layer.cornerRadius = 20.0
        backLabel.clipsToBounds = true
        frontLabel.clipsToBounds = true
        
        firstOption.layer.borderWidth = 3.0
        firstOption.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        firstOption.layer.cornerRadius = 20.0
        firstOption.clipsToBounds = true
        secondOption.layer.borderWidth = 3.0
        secondOption.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        secondOption.layer.cornerRadius = 20.0
        secondOption.clipsToBounds = true
        thirdOption.layer.borderWidth = 3.0
        thirdOption.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        thirdOption.layer.cornerRadius = 20.0
        thirdOption.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapFirstOption(_ sender: Any) {
        firstOption.isHidden = true
    }
    
    @IBAction func didTapSecondOption(_ sender: Any) {
        backLabel.isHidden = false
        frontLabel.isHidden = true
    }
    
    @IBAction func didTapThirdOption(_ sender: Any) {
        thirdOption.isHidden = true
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
    
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String?, extraAnswerTwo: String?) {
        self.frontLabel.text = question
        self.backLabel.text = answer
        
        self.firstOption.setTitle(extraAnswerOne, for: .normal)
        self.secondOption.setTitle(answer, for: .normal)
        self.thirdOption.setTitle(extraAnswerTwo, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
        }
    }
    
}

