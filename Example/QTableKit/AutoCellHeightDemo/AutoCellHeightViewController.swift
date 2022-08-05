//
//  MeTabViewController.swift
//
//  Created by QDong on 2021/2/25.
//  Copyright © 285275534@qq.com. All rights reserved.
//


import UIKit
import QTableKit

class AutoCellHeightViewController: BaseTableKitViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "TabelKitCell自动高度"
        
        createSection1()
        
        createSection2()
        
        perform(#selector(changeLabelHeight), with: nil, afterDelay: 1.0)
        
        perform(#selector(changeLabelHeight2), with: nil, afterDelay: 1.8)
    }
    
    func createSection1(){
        /// start ------------------- 第一栏section ---------------- start
        let section = TableKitSection()//创建一个Section
        
        section.footerHeight = 30
        
        //创建Model
        let labelCellModel = TableKitLabelXibAutoModel()
        labelCellModel.title = "高度走Auto"
        let labelXibAutoRow = TableKitRow<TableKitLabelXibAutoCell>(item: labelCellModel)//创建cell，并绑定cell的数据+点击事件
        section.append(row: labelXibAutoRow) //section添加cell
        
        
        //创建Model
        let labelCellChangeModel = TableKitLabelXibAutoModel()
        labelCellChangeModel.title = "加载中..."
        let labelXibChangeRow = TableKitRow<TableKitLabelXibAutoCell>(item: labelCellChangeModel)//创建cell，并绑定cell的数据+点击事件
        section.append(row: labelXibChangeRow) //section添加cell
        /// end ---------------- 第一栏section ---------------- end
        
        self.tableKitSections.append(section) //把section添加到[section]
    }
    
    func createSection2(){
        /// start ------------------- 第一栏section ---------------- start
        let section = TableKitSection()//创建一个Section
        
        //创建Model
        let labelCellModel = TableKitLabelXibAutoModel()
        labelCellModel.title = "高度走代码手动设置"
        
        //创建这个Cell的点击事件
        let cellClickAction = TableRowAction<LabelFrameCell>(.click) { (options :TableRowActionCallback<LabelFrameCell>) in
            print("点击事件")
        }
        
        //创建这个Cell的高度计算逻辑
        let heightAction = TableRowAction<LabelFrameCell>(.height) { (options :TableRowActionCallback<LabelFrameCell>) in
            
            //说明是heightForRowAtIndexPath触发到这里的。
            //因为计算Cell高度的代码一般都是用AutoLayout（只有通过frame的方式才需要算高度）所以这种方式设置高度也太常见
            
            //返回本cell的高度值
            measureHeight(text: options.dataModel.title, maxWidth: SCREEN_WIDTH - 15 - 15, font: UIFont.systemFont(ofSize: 17), lineSpacing: 3) + 13 + 13
        }
        
        let labelXibAutoRow = TableKitRow<LabelFrameCell>(item: labelCellModel, actions: [cellClickAction, heightAction])//创建cell，并绑定cell的数据+点击事件
        section.append(row: labelXibAutoRow) //section添加cell
        
        self.tableKitSections.append(section) //把section添加到[section]
    }
    
    
    @objc func changeLabelHeight() {
        let currentSection: TableKitSection = tableKitSections[0]
        let currentRow: TableKitRow<TableKitLabelXibAutoCell> = currentSection.rows[1] as! TableKitRow<TableKitLabelXibAutoCell>
        currentRow.dataModel.title = "我现在通过全局变量sections找到第0个section的第1个row\n然后修改他的model的String文本\nxib你拉好约束的话，系统会自动计算高度"
        tableView.reloadData()
    }
    
    @objc func changeLabelHeight2() {
        let currentSection: TableKitSection = tableKitSections[1]
        let currentRow: TableKitRow<LabelFrameCell> = currentSection.rows[0] as! TableKitRow<LabelFrameCell>
        currentRow.dataModel.title = "我现在通过全局变量sections找到第1个section的第0个row\n然后修改他的model的String文本\n然后再用代码重新设置label的frame和重新设置cell的高度\n主要为了展示怎么通过代码修改cell高度的"
        tableView.reloadData()
    }
    
    deinit {
        NSLog("AutoCellHeightViewController deinit")
    }
}
