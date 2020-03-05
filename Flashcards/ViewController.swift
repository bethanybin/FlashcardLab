//
//  ViewController.swift
//  Flashcards
//
//  Created by Bethany Bin on 2/5/20.
//  Copyright © 2020 Bethany Bin. All rights reserved.
//

import UIKit

struct Flashcard {
    var question : String
    var answer : String
    var extraAnswerOne : String
    var extraAnswerTwo : String
}

class ViewController: UIViewController {
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    @IBOutlet weak var firstOption: UIButton!
    
    @IBOutlet weak var secondOption: UIButton!
    @IBOutlet weak var thirdOption: UIButton!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
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
        readSavedFlashcards()
        if flashcards.count == 0 {
            updateFlashcard(question: "What is the capital of Brazil?", answer: "Brasilia", extraAnswerOne: "Rio de Janerio", extraAnswerTwo: "Sao Paulo", isExisting: false)
        }
        else{
            updateNextPrevButton()
            updateLabels()
        }
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
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLabels()
        updateNextPrevButton()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        updateLabels()
        updateNextPrevButton()
    }
    @IBAction func didTapOnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        present(alert, animated: true)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {
            action in self.deleteFlashcard()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
    }
    
    func deleteFlashcard(){
        flashcards.remove(at: currentIndex)
        if currentIndex > flashcards.count - 1{
            currentIndex = flashcards.count - 1
        }
        updateNextPrevButton()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String, extraAnswerTwo: String, isExisting: Bool) {
        let flashcard = Flashcard(question: question, answer: answer, extraAnswerOne: extraAnswerOne, extraAnswerTwo: extraAnswerTwo)
        self.frontLabel.text = flashcard.question
        self.backLabel.text = flashcard.answer
        self.firstOption.setTitle(flashcard.extraAnswerOne, for: .normal)
        self.secondOption.setTitle(flashcard.answer, for: .normal)
        self.thirdOption.setTitle(flashcard.extraAnswerTwo, for: .normal)
        if isExisting{
            flashcards[currentIndex] = flashcard
        }
        else {
            flashcards.append(flashcard)
            currentIndex = flashcards.count - 1
        }
        updateNextPrevButton()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
    func updateNextPrevButton(){
        if currentIndex == flashcards.count - 1{
            nextButton.isEnabled = false
        }
        else {
            nextButton.isEnabled = true
        }
        if currentIndex == 0{
            prevButton.isEnabled = false
        }
        else{
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        self.firstOption.setTitle(currentFlashcard.extraAnswerOne, for: .normal)
        self.secondOption.setTitle(currentFlashcard.answer, for: .normal)
        self.thirdOption.setTitle(currentFlashcard.extraAnswerTwo, for: .normal)
    }
    
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map{ (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer, "extraAnswerOne": card.extraAnswerOne, "extraAnswerTwo": card.extraAnswerTwo]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
    }
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            let savedCards = dictionaryArray.map{ dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extraAnswerOne: dictionary["extraAnswerOne"]!, extraAnswerTwo: dictionary["extraAnswerTwo"]!)
            }
            flashcards.append(contentsOf: savedCards)
        }
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

