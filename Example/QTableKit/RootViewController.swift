//
//  ViewController.swift
//  QTableKit
//
//  Created by mac on 2022/7/28.
//

import UIKit

class RootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    private(set) var tableView: UITableView!
    
    private let reuseIdentifier = "UITableViewCell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView.init(frame: view.bounds, style: .grouped)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:reuseIdentifier)
        
        //移除底部多余的separator
        if(tableView.style == UITableView.Style.plain){
            let footerView: UIView = UIView();
            tableView.tableFooterView = footerView;
        }
        
        //为了适配ios11的黑夜模式
        tableView.backgroundColor = UIColor(red: (248)/255.0, green: (248)/255.0, blue: (246)/255.0, alpha: 1)
        
        tableView.delegate = self;
        tableView.dataSource = self;
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(LoginDemoController(), animated: true)
        case 1:
            self.navigationController?.pushViewController(ByHelperDemoViewController(), animated: true)
        default:
            self.navigationController?.pushViewController(AutoCellHeightViewController(), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "登录界面 Demo"
        case 1:
            cell.textLabel?.text = "用Helper简化 Demo"
        default:
            cell.textLabel?.text = "Cell高度改变 Demo"
        }
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
        
        return cell;
    }



}

