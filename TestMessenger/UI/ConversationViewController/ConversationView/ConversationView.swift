//
//  ConversationView.swift
//  TestMessenger
//
//  Created by Vladimir Budniy on 6/12/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class ConversationView: UIView {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var toolBarView: UIView?
    @IBOutlet var textField: UITextField?
    
    var defaultActionViewPoint: CGFloat?
    var currentActionViewPoint: CGFloat?
    
    override func awakeFromNib() {
        self.textField?.becomeFirstResponder()
    }
    
    // MARK: - Public methods
    
    func subscribeNotifications() {
        NotificationCenter
            .default
            .addObserver(self, selector: #selector(viewMoveUp), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter
            .default
            .addObserver(self, selector: #selector(viewMoveDone), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeNotifications() {
        NotificationCenter
            .default
            .removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter
            .default
            .removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // MARK: - Private methods
    
    func viewMoveUp(notification:NSNotification) {
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        self.toolBarView?.layer.masksToBounds = true
        self.defaultActionViewPoint = self.toolBarView?.frame.origin.y
        self.toolBarView?.frame.origin.y = (self.toolBarView?.frame.origin.y)! - keyboardRectangle.height + 50
        self.currentActionViewPoint = self.toolBarView?.frame.origin.y
        UIView.animate(withDuration: 0.05) { self.toolBarView?.alpha = 1.0 }
    }
    
    func viewMoveDone(notification:NSNotification) {
        self.toolBarView?.layer.masksToBounds = true
        self.toolBarView?.frame.origin.y = self.defaultActionViewPoint!
        UIView.animate(withDuration: 0.05) { self.toolBarView?.alpha = 0.0 }
    }
}
