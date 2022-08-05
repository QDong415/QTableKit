//
//  静态的TableKitCell.swift
//
//  Created by QDong on 2021/2/25.
//  Copyright © 2021 285275534@qq.com All rights reserved.

import UIKit
import QTableKit

//左label
class LabelFrameCell: UITableViewCell, TableKitCellDataSource {
    
    //声明该cell对应的model数据类型；你可以不用写这句，选择直接把下文中的T换成Model；也能运行但是那样不规范
    typealias T = TableKitLabelXibAutoModel

    //cell上的控件
    private var titleLabel: UILabel!
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLabel = UILabel()
        titleLabel.frame = CGRect(x: CGFloat(15), y: 13, width: CGFloat(SCREEN_WIDTH - 30), height: 18)
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textColor = UIColor.black
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
    }
    
    //如果override了父类的构造方法，系统会要求我们重写initCoder方法
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: TableKitCellDataSource - 默认高度
    //这里的默认高度是第2优先级，如果在heightBy方法里设置本Cell高度属于第1优先级
    static var defaultHeight: CGFloat? {
        //返回0表示Cell高度为0，不写该方法表示Cell高度为automaticDimension
        return 54
    }
    
    //MARK: TableKitCellDataSource - 绑定model
    //这个回调方法是由系统的cellForRowAtIndexPath触发的，所以要写的内容就跟cellForRowAtIndexPath一样
    func configureData(with tkModel: T ,customRowAction : RowActionable) {
        
        //通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        //将行间距设置为3
        paraph.lineSpacing = 3
        //样式属性集合
        let attributes = [NSAttributedString.Key.font:titleLabel.font,
                          NSAttributedString.Key.paragraphStyle: paraph]
        titleLabel.attributedText = NSAttributedString(string: tkModel.title ?? "", attributes: attributes as [NSAttributedString.Key : Any])

        //重新设置label高度
        let labelHeight = measureHeight(text: tkModel.title, maxWidth: titleLabel.frame.size.width, font: titleLabel.font, lineSpacing: 3)
        
        var labelFrame = titleLabel.frame
        labelFrame.size.height = labelHeight
        titleLabel.frame = labelFrame
    }
    
    deinit {
        print("LabelFrameCell deinitialized")
    }
}
