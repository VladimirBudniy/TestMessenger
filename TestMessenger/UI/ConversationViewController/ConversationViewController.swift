//
//  ConversationViewController.swift
//  TestMessenger
//
//  Created by Vladimir Budniy on 6/12/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, ViewControllerRootView, UITableViewDataSource, UITableViewDelegate, LoadMessageProtocol  {

    typealias RootViewType = ConversationView
    let identifier = String(describing: ConversationViewCell.self)
    let provider = Provider()
    var messages = [Message]()
    var channel: Channel?
    
    var tableView: UITableView? {
        return self.rootView.tableView
    }
    
    // MARK: - Initializations and Deallocations
    
    init(_ channel: Channel) {
        self.channel = channel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("DEINIT " + String(describing: type(of: self)))
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.provider.messageDelegate = self
        self.settingNavigationBar()
        self.registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.messagesLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.rootView.subscribeNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.rootView.unsubscribeNotifications()
    }

    // MARK: - Private
    
    private func registerCell() {
        self.tableView?.register(UINib(nibName: self.identifier, bundle: nil),
                                 forCellReuseIdentifier: self.identifier)
    }
    
    private func channelsLoad() {
        self.showNetworkActivityIndicator()
        self.provider.channelsLoad()
    }
    
    private func messagesLoad() {
        self.showNetworkActivityIndicator()
        self.provider.messagesLoad(for: self.channel!)
    }
    
    private func settingNavigationBar() {
        let navigationItem = self.navigationItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"),
                                                           style: UIBarButtonItemStyle.done,
                                                           target: self,
                                                           action: #selector(back))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Block",
                                                            style: UIBarButtonItemStyle.done,
                                                            target: self,
                                                            action: nil)
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        guard let sender = self.channel?.sender else { return }
        navigationItem.title = sender.firstName! + " " + sender.lastName!
    }
    
    @objc private func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: LoadMessageProtocol method
    
    func messagesLoaded(model: [Message]) {
        self.messages = model
        self.tableView?.reloadData()
        self.removeNetworkActivityIndicator()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier) as! ConversationViewCell
        cell.fillWith(sender: self.channel?.sender ,message: self.messages[indexPath.row])
        self.tableView?.rowHeight = cell.frame.size.height
        
        return cell
    }
}
