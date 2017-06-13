//
//  ChatView.swift
//  TestMessenger
//
//  Created by Vladimir Budniy on 06.06.17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class ChatView: UIView {    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmentView: UIView!
    @IBOutlet var firstSegment: UIView!
    @IBOutlet var countView: UIView!
    @IBOutlet var newChatCount: UILabel!

    override func awakeFromNib() {
        self.segmentView.layer.cornerRadius = 17
        self.firstSegment.layer.cornerRadius = 17
        self.countView.layer.cornerRadius = 7
    }
}
