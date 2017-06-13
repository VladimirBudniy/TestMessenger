//
//  Provider.swift
//  TestMessenger
//
//  Created by Vladimir Budniy on 11.06.17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import Alamofire

class Provider {

    var channelDelegate: LoadChannelProtocol?
    var messageDelegate: LoadMessageProtocol?
    
    func channelsLoad() {
        let url = URL(string:channelsUrl)
        Alamofire.request(url!,
                          method: .get,
                          encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    var channelsArray = [Channel]()
                    if let channels = json["channels"] as? [[String: Any]] {
                        for channel in channels {
                            channelsArray.append(Channel.create(with: channel)!)
                        }
                    }
                    
                    self.channelDelegate?.channelsLoaded(model: self.sortChannels(channelsArray))
                }
        }
    }
    
    func messagesLoad(for channel: Channel) {
        let url = URL(string:String(format: messagesUrl, channel.id!))
        Alamofire.request(url!,
                          method: .get,
                          encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    var messagesArray = [Message]()
                    if let messages = json["messages"] as? [[String: Any]] {
                        for message in messages {
                            messagesArray.append(Message.create(with: message)!)
                        }
                    }
                    
                    self.messageDelegate?.messagesLoaded(model: messagesArray)
                }
        }
    }
    
    
    fileprivate func sortChannels(_ channels: [Channel]) -> [[Channel]] {
        var sortedFeed = Array(repeating: [Channel](), count: 2)
        for channel in channels {
            if channel.unreadMessagesCount! > 0 {
                sortedFeed[0].append(channel)
            } else {
                sortedFeed[1].append(channel)
            }
        }
        
        return sortedFeed
    }
    
}

