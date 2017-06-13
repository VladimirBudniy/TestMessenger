//
//  ConversationViewCell.swift
//  TestMessenger
//
//  Created by Vladimir Budniy on 6/12/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class ConversationViewCell: UITableViewCell {

    @IBOutlet var avatar: UIImageView?
    @IBOutlet var textView: UIView?
    @IBOutlet var messageLabel: UILabel?
    @IBOutlet var dateLabel: UILabel?
    
    override func prepareForReuse() {
        self.messageLabel?.frame.size.height = 20
        self.textView?.frame.size.height = 36
        self.frame.size.height = 55
    }
    
    // MARK: - Public
    
    func fillWith(sender: User?, message: Message?) {
        guard let message = message else { return }
        if let sender = sender {
            self.avatar?.sd_setImage(with: URL(string: (sender.photo)!))
            self.messageLabel?.text = message.text
            self.dateLabel?.text = message.createDate
        }
        
        self.settingCellView()
    }
    
    // MARK: - Private
    
    private func settingCellView() {
        let messageLabel = self.messageLabel
        let defaultHeight = messageLabel?.frame.height
        messageLabel?.numberOfLines = 0
        messageLabel?.sizeToFit()
        let ratio = (messageLabel?.frame.height)! / defaultHeight!
    
        if ratio > 1 {
            self.frame.size.height = self.frame.size.height * ratio
        }
        
        self.avatar?.layer.masksToBounds = true
        self.avatar?.layer.cornerRadius = 22
        self.textView?.layer.cornerRadius = 10
    }
}
