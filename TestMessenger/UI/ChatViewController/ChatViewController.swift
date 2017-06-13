//
//  ChatViewController.swift
//  TestMessenger
//
//  Created by Vladimir Budniy on 06.06.17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, ViewControllerRootView, UITableViewDataSource, UITableViewDelegate, LoadChannelProtocol  {

    typealias RootViewType = ChatView
    let identifier = String(describing: ChatViewCell.self)
    var unreadChannels = [Channel]()
    var readedChannels = [Channel]()
    let provider = Provider()
    
    var tableView: UITableView? {
        return self.rootView.tableView
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.provider.channelDelegate = self
        self.registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.channelsLoad()
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
    
    // MARK: LoadChannelProtocol method
    
    func channelsLoaded(model: [[Channel]]) {
        self.unreadChannels = model[0]
        self.readedChannels = model[1]
        self.tableView?.reloadData()
        self.removeNetworkActivityIndicator()
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 0 else {
            return self.readedChannels.count
        }
        
        return self.unreadChannels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier) as! ChatViewCell
        
        guard section == 0 else {
            cell.fillWith(channel: self.readedChannels[indexPath.row])
            return cell
        }
        
        cell.fillWith(channel: self.unreadChannels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.rootView.frame.size.width, height: CGFloat(9)))
        headerView.backgroundColor = UIColor.lightText
        headerView.alpha = 1.0
        
        return headerView
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        var channel: Channel?

        if section == 0 {
            channel = self.unreadChannels[indexPath.row]
        } else {
            channel = self.readedChannels[indexPath.row]
        }

        self.navigationController?.pushViewController(ConversationViewController(channel!), animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }

}
