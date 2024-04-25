//
//  ViewController.swift
//  LifeCounter
//
//  Created by Kate Muret on 4/18/24.
//

import UIKit

class ViewController: UIViewController, PlayerTableCellDelegate {
    
    
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var addPlayerButton: UIButton!
    @IBOutlet weak var deletePlayerButton: UIButton!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    var players: [Player] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(playerTableCell.nib(), forCellReuseIdentifier: playerTableCell.identifier)
        setupInitialPlayers()
    }
    
    func setupInitialPlayers() {
        players = [
                Player(lives: 20, playerNumber: 1),
                Player(lives: 20, playerNumber: 2),
                Player(lives: 20, playerNumber: 3),
                Player(lives: 20, playerNumber: 4)
            ]
        tableView.reloadData()
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        setupInitialPlayers()
        addPlayerButton.isEnabled = true
        deletePlayerButton.isEnabled = true
    }
    
    @IBAction func addPlayerButtonPressed(_ sender: UIButton) {
        if players.count < 8 {
            let newPlayer = Player(lives: 20, playerNumber: players.count + 1)
            players.append(newPlayer)
            tableView.reloadData()
        }
    }
    
    
    @IBAction func deletePlayerButtonPressed(_ sender: UIButton) {
        if players.count > 2 {
            players.removeLast()
            for (index, player) in players.enumerated() {
                    players[index].playerNumber = index + 1
            }
            tableView.reloadData()
        }
    }
    
    
    @IBAction func startGamePressed(_ sender: UIButton) {
        addPlayerButton.isEnabled = false
        deletePlayerButton.isEnabled = false
    }
    
    func playerDidReachZeroLife(playerNumber: Int) {
        let alert = UIAlertController(title: "Game Over!", message: "Player \(playerNumber) lost!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.setupInitialPlayers()
                self?.addPlayerButton.isEnabled = true
                self?.deletePlayerButton.isEnabled = true
            }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: playerTableCell.identifier, for: indexPath) as! playerTableCell
        let player = players[indexPath.row]
        cell.player = player
        cell.delegate = self
        return cell
    }
    
    func endGame() {
        let alert = UIAlertController(title: "Game Over!", message: "Resetting...", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.setupInitialPlayers()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    
}


