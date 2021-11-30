//
//  ViewController.swift
//  constraints_exercise_3
//
//  Created by Sofia Carena on 19/11/2021.
//

import UIKit

class MessengerViewController: UIViewController {

    @IBOutlet weak var messengerTableView: UITableView!
    
    var messages: [Message]? = [] {
            didSet {
                self.messengerTableView.reloadData()
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MessagesManager().retrieve() {
            [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let messages):
                    self?.messages = messages
                case .failure(_):
                    self?.messages = []
                    print("An error has ocurred")
                }
            }
        }
    }
    
}

extension MessengerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "MessageCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
        }
        cell?.textLabel?.text = messages![indexPath.row].username
        cell?.detailTextLabel?.text = messages![indexPath.row].message
        
        return cell ?? UITableViewCell()
    }
    
}

