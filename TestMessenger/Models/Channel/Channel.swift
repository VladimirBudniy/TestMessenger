//
//  Channel.swift
//  TestMessenger
//
//  Created by Vladimir Budniy on 11.06.17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation

struct Channel {
    var id: Int?
    var sender: User?
    var receiver: User?
    var message: Message?
    var unreadMessagesCount: Int?
    
    static func create(_ id: Int?,
                       _ sender: User?,
                       _ receiver: User?,
                       _ message: Message?,
                       _ unreadMessagesCount: Int?) -> Channel?  {
        return Channel(id: id,
                       sender: sender,
                       receiver: receiver,
                       message: message,
                       unreadMessagesCount: unreadMessagesCount)
    }
    
    static func create(with json: [String: Any]?) -> Channel? {
        let id = json?[ "id"] as? Int
        let messageJson = json?["last_message"] as? [String: Any]
        let message = Message.create(with: messageJson)
        let unreadMessagesCount = json?[ "unread_messages_count"] as? Int
        
        var sender: User?
        var receiver: User?
        
        if let usersJson = json?["users"] as? [[String: Any]] {
            sender = User.create(with: usersJson[0])
            receiver = User.create(with: usersJson[1])
        }

        return Channel(id: id,
                       sender: sender,
                       receiver: receiver,
                       message: message,
                       unreadMessagesCount: unreadMessagesCount)
    }
    
}
