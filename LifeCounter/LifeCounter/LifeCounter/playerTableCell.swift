//
//  Player.swift
//  LifeCounter
//
//  Created by Kate Muret on 4/23/24.
//

import UIKit

struct Player {
    var lives = 20
    var playerNumber: Int
}

protocol PlayerTableCellDelegate: AnyObject {
    func playerDidReachZeroLife(playerNumber: Int)
}

class playerTableCell: UITableViewCell {
    weak var delegate: PlayerTableCellDelegate?
    static let identifier = "playerTableCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "playerTableCell", bundle: nil)
    }
    
    var player: Player? {
          didSet {
              updateLifeTotals()
          }
    }
 
    @IBOutlet weak var bigChange: UITextField!
    @IBOutlet weak var playerLabel: UILabel!
    
    @IBAction func minus(_ sender: UIButton) {
        guard let player = player else {
            return
        }
        var updatedPlayer = player
        updatedPlayer.lives -= 1
        self.player = updatedPlayer
        updateLifeTotals()
    }
    
    @IBAction func plus(_ sender: UIButton) {
        guard var player = player else { return }
            player.lives += 1
            self.player = player
            updateLifeTotals()
    }
    
    @IBAction func bigChangeButtonMinusPressed(_ sender: UIButton) {
        guard var player = player, let changeText = bigChange.text, let changeAmount = Int(changeText) else {
            return
        }
        player.lives -= changeAmount
        self.player = player
        updateLifeTotals()
        bigChange.text = "0"
    }
    
    @IBAction func bigChangeButtonPlusPressed(_ sender: UIButton) {
        guard var player = player, let changeText = bigChange.text, let changeAmount = Int(changeText) else {
            return
        }
        player.lives += changeAmount
        self.player = player
        updateLifeTotals()
        bigChange.text = "0"
    }

    func updateLifeTotals() {
        DispatchQueue.main.async { [self] in
            guard let player = player else { return }
            playerLabel.text = "Player \(player.playerNumber): \(player.lives)"
            checkForGameOver()
        }
    }
    
    private func checkForGameOver() {
        guard let player = player else { return }
        if player.lives <= 0 {
            delegate?.playerDidReachZeroLife(playerNumber: player.playerNumber)
        }
    }
    private func disableButtons() {
        
    }

    
    
}
