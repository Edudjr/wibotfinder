//
//  ChatBotViewController.swift
//  WiFinder
//
//  Created by Eduardo Domene Junior on 16/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import UIKit

enum MessageOwner {
    case me, other
}

struct MessageEntity {
    let owner: MessageOwner
    let message: String
}

class ChatBotViewController: UIViewController {
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    //Dependencies
    var chatBotModel = ChatBotModel()
    
    var messages = [MessageEntity]()
    var selectedCategory: MediaType?
    var selectedQuery: String?
    
    override func viewDidLoad() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

        chatBotModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        messages.removeAll()
        let welcomeMessage = chatBotModel.getWelcomeMessage()
        messages.append(MessageEntity(owner: .other, message: welcomeMessage))
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewController {
            vc.selectedMediaType = selectedCategory
            vc.enteredQuery = selectedQuery
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        if let text = inputText.text, !text.isEmpty {
            let message = MessageEntity(owner: .me, message: text)
            messages.append(message)
            inputText.text = ""
            
            let response = chatBotModel.getResponseFor(message: text)
            let responseMessage = MessageEntity(owner: .other, message: response)
            messages.append(responseMessage)
            
            tableView.reloadData()
            
            let indexPath = IndexPath(row: messages.count-1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}

extension ChatBotViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        switch message.owner {
        case .me:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MineCell", for: indexPath) as! ChatBotMineCell
            cell.messageLabel.text = message.message
            return cell
        case .other:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TheirsCell", for: indexPath) as! ChatBotTheirsCell
            cell.messageLabel.text = message.message
            return cell
        }
    }
}

extension ChatBotViewController: ChatBotModelDelegate {
    func shouldSearchFor(category: MediaType, query: String) {
        selectedCategory = category
        selectedQuery = query
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.performSegue(withIdentifier: "botCatalogSegue", sender: nil)
        }
    }
}
