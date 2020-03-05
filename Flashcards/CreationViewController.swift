//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Bethany Bin on 2/25/20.
//  Copyright © 2020 Bethany Bin. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    var flashcardsController : ViewController!
    
    @IBOutlet weak var optionOne: UITextField!
    @IBOutlet weak var optionTwo: UITextField!
    var initialQuestion: String?
    var initialAnswer: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        let optionOneText = optionOne.text
        let optionTwoText = optionTwo.text
        if questionText == nil || answerText == nil || optionOneText == nil || optionTwoText == nil {
            let alert = UIAlertController(title: "Missing Text", message: "You need to enter both a question and an answer.", preferredStyle: .alert)
            present(alert, animated: true)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
        }
        var isExisting = false
        if initialQuestion != nil{
            isExisting = true
        }
        flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraAnswerOne: optionOneText!, extraAnswerTwo: optionTwoText!, isExisting: isExisting)
        dismiss(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
