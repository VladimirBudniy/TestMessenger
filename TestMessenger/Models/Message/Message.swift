//
//  Message.swift
//  TestMessenger
//
//  Created by Vladimir Budniy on 11.06.17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation

struct Message {
    var createDate: String?
    var text: String?
    var isRead: Bool?
    var sender: User?

    static func create(_ createDate: String?,
                _ text: String?,
                _ isRead: Bool?,
                _ sender: User?) -> Message?  {
        return Message(createDate: createDate, text: text, isRead: isRead, sender: sender)
    }
    
    static func create(with json: [String: Any]?) -> Message? {
        let createDate = json?[ "create_date"] as? String
        let text = json?["text"] as? String
        let isRead = json?["is_read"] as? Bool
        let sender =  User.create(with: json?["sender"] as? [String: Any])
        
        return Message(createDate: createDate, text: text, isRead: isRead, sender: sender)
    }
}
