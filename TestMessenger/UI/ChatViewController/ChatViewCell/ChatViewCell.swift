//
//  ChatViewCell.swift
//  TestMessenger
//
//  Created by Vladimir Budniy on 06.06.17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit
import SDWebImage

class ChatViewCell: UITableViewCell {
    
    @IBOutlet var avatar: UIImageView?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var messegeLabel: UILabel?
    @IBOutlet var newMessegeCount: UILabel?
    @IBOutlet var dateLabel: UILabel?
    @IBOutlet var detailChatButton: UIButton?
    @IBOutlet var separatorView: UIView?
    @IBOutlet var countView: UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.settingCellView()
    }

    func fillWith(channel: Channel?) {
        guard let channel = channel else { return }

        if let sender = channel.sender {
            self.avatar?.sd_setImage(with: URL(string: (sender.photo)!))
            self.nameLabel?.text = sender.firstName! + " " + sender.lastName!
            self.messegeLabel?.text = channel.message?.text
            self.dateLabel?.text = channel.message?.createDate
        }
        
        let count: Int = channel.unreadMessagesCount!
        guard count > 0 else { return self.countView!.alpha = 0 }
        self.countView!.alpha = 1
        self.newMessegeCount?.text = String(count)
    }
    
    private func settingCellView() {
        self.avatar?.layer.masksToBounds = true
        self.avatar?.layer.cornerRadius = 25
        self.countView?.layer.cornerRadius = 11
    }

}
