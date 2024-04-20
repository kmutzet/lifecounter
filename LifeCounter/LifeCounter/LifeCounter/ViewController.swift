//
//  ViewController.swift
//  LifeCounter
//
//  Created by Kate Muret on 4/18/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playerOneInfo: UILabel!
    @IBOutlet weak var playerTwoInfo: UILabel!
    @IBOutlet weak var gameStatusLabel: UILabel!
    
    var playerOneLife = 20
    var playerTwoLife = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLifeTotals()
    }


    
    @IBAction func playerOneButtonPressed(_ sender: UIButton) {
        playerOneLife = handleLifeChange(currentLife: playerOneLife, sender: sender)
    }
    
    @IBAction func playerTwoButtonPressed(_ sender: UIButton) {
        playerTwoLife = handleLifeChange(currentLife: playerTwoLife, sender: sender)
    }
    
    func handleLifeChange(currentLife: Int, sender: UIButton) -> Int {
        var newLife = currentLife
        switch sender.titleLabel?.text {
        case "+":
            newLife += 1
        case "-":
            newLife -= 1
        case "+5":
            newLife += 5
        case "-5":
            newLife -= 5
        default:
            break
        }
        updateLifeTotals()
        return newLife
    }
    
    func updateLifeTotals() {
        DispatchQueue.main.async {
            [self] in
            playerOneInfo.text = "Player 1: \(self.playerOneLife)"
            playerTwoInfo.text = "Player 2: \(self.playerTwoLife)"
            checkForGameOver()
        }
    }
    
    func checkForGameOver() {
        if playerOneLife <= 0 {
            gameStatusLabel.text = "Player 1 LOSES!"
            disableButtons()
        } else if playerTwoLife <= 0 {
            gameStatusLabel.text = "Player 2 LOSES!"
            disableButtons()
        } else {
            gameStatusLabel.text = ""
        }
    }
    private func disableButtons() {
        
    }
}

