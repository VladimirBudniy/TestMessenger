//
//  LoadMessageProtocol.swift
//  TestMessenger
//
//  Created by Vladimir Budniy on 6/12/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation

protocol LoadMessageProtocol: class {
    func messagesLoaded(model: [Message])
}
