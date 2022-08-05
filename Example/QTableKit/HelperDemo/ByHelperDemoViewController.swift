//
//  MeTabViewController.swift
//
//  Created by QDong on 2021/2/25.
//  Copyright © 285275534@qq.com. All rights reserved.
//


import UIKit
import QTableKit

class ByHelperDemoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    private(set) var tableView: UITableView!
    
    private var tableKitHelper: TableKitHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "使用Helper简化代码"
        
        tableView = UITableView.init(frame: view.bounds, style: .plain)
        
        //为了适配ios11的黑夜模式
        if #available(iOS 11, *) {
            tableView.backgroundColor = UIColor.init(named: "background");
            tableView.separatorColor = UIColor.init(named: "separator");
        } else {
            tableView.backgroundColor = UIColor(red: (248)/255.0, green: (248)/255.0, blue: (246)/255.0, alpha: 1)
        }
        
        view.addSubview(tableView)
        
        tableKitHelper = TableKitHelper(tableView: self.tableView, alterTableViewDelegate: self, alterTableViewDataSource: self)
        
        createSection1()
        
        
        perform(#selector(changeLabelHeight2), with: nil, afterDelay: 1.0)
    }
    
    func createSection1(){
        /// start ------------------- 第一栏section ---------------- start
        let section = TableKitSection()//创建一个Section
        
        section.headerTitle = "TableKitDirector里设置header"
        
        //创建Model
        let labelCellModel = TableKitLabelXibAutoModel()
        labelCellModel.title = "高度走Auto，我这个UILabel是用xib里拉的约束，"
        let labelXibAutoRow = TableKitRow<TableKitLabelXibAutoCell>(item: labelCellModel)//创建cell，并绑定cell的数据+点击事件
        section.append(row: labelXibAutoRow) //section添加cell
        
        
        //创建Model
        let labelCellChangeModel = TableKitLabelXibAutoModel()
        labelCellChangeModel.title = "加载中..."
        let labelXibChangeRow = TableKitRow<TableKitLabelXibAutoCell>(item: labelCellChangeModel)//创建cell，并绑定cell的数据+点击事件
        section.append(row: labelXibChangeRow) //section添加cell
        /// end ---------------- 第一栏section ---------------- end
        
        tableKitHelper.append(section: section) //把section添加到[section]
    }
    
    @objc func changeLabelHeight2() {
        let currentSection: TableKitSection = tableKitHelper.tableKitSections[0]
        let currentRow: TableKitRow<TableKitLabelXibAutoCell> = currentSection.rows[1] as! TableKitRow<TableKitLabelXibAutoCell>
        currentRow.dataModel.title = "我现在通过全局变量sections找到第1个section的第0个row\n然后修改他的model的String文本\n然后再用代码重新设置label的frame和重新设置cell的高度\n主要为了展示怎么通过代码修改cell高度的"
        tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "VC里设置titleForHeader"
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("VC里scrollViewDidScroll")
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView){
        print("VC里 scrollViewWillBeginDragging %@",scrollView)
    }
   
    //代码不会走这个方法，因为TableKitHelper里是第一优先的Delegate。我们这里写只是为了xcode不报错
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    //代码不会走这个方法，因为TableKitHelper里是第一优先的Delegate。我们这里写只是为了xcode不报错
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    deinit {
        NSLog("DirectorDemoTableKitViewController deinit")
    }
    
    
    
}
