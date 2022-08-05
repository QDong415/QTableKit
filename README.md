# QTableKit

[![CI Status](https://img.shields.io/travis/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/QTableKit.svg?style=flat)](https://travis-ci.org/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/QTableKit)
[![Version](https://img.shields.io/cocoapods/v/QTableKit.svg?style=flat)](https://cocoapods.org/pods/QTableKit)
[![License](https://img.shields.io/cocoapods/l/QTableKit.svg?style=flat)](https://cocoapods.org/pods/QTableKit)
[![Platform](https://img.shields.io/cocoapods/p/QTableKit.svg?style=flat)](https://cocoapods.org/pods/QTableKit)

## IOS 封装tableViewCell样式不一致的UITableView，告别复杂的DataSource和Delegate

## 解决痛点：
![QQ20220806-1.jpg](https://upload-images.jianshu.io/upload_images/26002059-52b40b667c873c6b.jpg)

类似登录注册界面的TableView、上面的商品详情的TableView、设置界面的TableView等。
他们的每条Cell的样式都不一致，且都可能hidden。如果用传统的方式处理，会在UITableViewDataSource里写一堆 if else判断本Cell是否应该显示，以让Cell找到对应的indexPath

## 本库效果图（其实效果图不重要，重要的是代码逻辑）：
![点击按钮可以获取TextField里的值.gif](https://upload-images.jianshu.io/upload_images/26002059-f6ebca5717a7e914.gif?imageMogr2/auto-orient/strip)

![Cell的高度可以很方便的控制.gif](https://upload-images.jianshu.io/upload_images/26002059-88ea22fabf1e5336.gif?imageMogr2/auto-orient/strip)


本库是基于 [TableKit](https://github.com/maxsokolov/TableKit) 改造优化

## 本库使用流程：
先写Cell对应的Model:
```Swift
//这个TableKitTextFieldCell对应的Model，只能用class，不要用struct；因为struct会在TableKitRow里产生一个无用的深copy
class TableKitTextFieldModel {
       
    var title: String? //左边的Label内容文字
    var value: String? //TextField的输入内容
    //TextField的属性
    var secureTextEntry: Bool = false
    var placeHolder: String?
    var keyboardType: UIKeyboardType = UIKeyboardType.default
    var textAlignment: NSTextAlignment = NSTextAlignment.right
}

```
---
再写Cell的代码
```

//触发cell内部控件的事件的key；用来区分是哪个内部事件
let TKTextFieldEditingChangedKey = "TKTextFieldEditingChangedKey"

//左label，右textField
class TableKitTextFieldCell: UITableViewCell, TableKitCellDataSource {
    
    //声明该cell对应的model数据类型；你可以不用写这句，选择直接把下文中的T换成Model；也能运行但是那样不规范
    typealias T = TableKitTextFieldModel
    
    //主model是在TableKitRow里强引用的，这里只是个副本
    private weak var weakModel: T!
    
    //当用户手动触发cell上的UI控件的各种事件
    //底层原理：把事件通过这个RowActionable回调给TableKitRow；然后TableKitRow收到回调后，再回调给vc的TableRowAction
    private var customRowAction: RowActionable?
    
    //cell上的控件
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    //MARK: TableKitCellDataSource - 默认高度
    //这里的默认高度是第2优先级，如果在ViewController里设置本Cell高度属于第1优先级
    static var defaultHeight: CGFloat? {
        //返回0表示Cell高度为0，不写该方法表示Cell高度为automaticDimension
        return 54
    }
    
    //MARK: TableKitCellDataSource - 绑定model 和 临时存储customRowAction
    //这个回调方法是由系统的cellForRowAtIndexPath触发的，所以要写的内容就跟cellForRowAtIndexPath一样
    func configureData(with tkModel: T ,customRowAction : RowActionable) {
        
        self.weakModel = tkModel
        self.customRowAction = customRowAction
        
        titleLabel.text = tkModel.title
        textField.text = tkModel.value
        textField.placeholder = tkModel.placeHolder
        textField.isSecureTextEntry = tkModel.secureTextEntry
        textField.textAlignment = tkModel.textAlignment
        textField.keyboardType = tkModel.keyboardType
        
        textField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
    }
    
    //cell内部控件触发的事件，通过本cell的全局变量customRowAction传给TableKitRow，TableKitRow会再传回给vc
    @objc fileprivate func editingChanged(_ textField:UITextField) {
        // 控件输入监听，监听cell上的UI控件的output值的改变，然后把新值设置回weakModel
        weakModel.value = textField.text;
        customRowAction?.onCustomerAction(customActionKey: TKTextFieldEditingChangedKey, cell: self, path: nil, userInfo: nil)
    }

}

```
---
最后是ViewController：
```Swift
//添加"账号" UITableViewCell
    override func viewDidLoad() {
        let nameTkModel = TableKitTextFieldModel()
        nameTkModel.title = "账号"
        nameTkModel.placeHolder = "请输入账号"
        
        //Cell点击事件
        let cellClickAction = TableRowAction<TableKitTextFieldCell>(.click) { (options :TableRowActionCallback<TableKitTextFieldCell>) in
            options.cell?.textField.becomeFirstResponder()
        }
        
        //cell里的TextField的文本编辑事件
        let textFieldEditAction = TableRowAction<TableKitTextFieldCell>(.custom(TKTextFieldEditingChangedKey)) { (options :TableRowActionCallback<TableKitTextFieldCell>) in
            //options.dataModel 就是 nameTkModel
            print("vc收到账号输入框变化1 = ",options.dataModel.value!)
        }
        
        let section = TableKitSection(headerTitle: "TextFieldCell的HeaderTitle", footerTitle: nil)
        self.nameTableKitRow = TableKitRow<TableKitTextFieldCell>(item: nameTkModel, actions: [cellClickAction, textFieldEditAction])
        section.append(row: self.nameTableKitRow)
        self.tableKitSections.append(section)
    }
```

## 安装

先在终端里搜索 `pod search QTableKit` 

如果搜索不到1.0版本，需要更新你电脑的pod仓库，以下是更新步骤：
- 先 `pod repo update —verbose`  更新你本地电脑的pod仓库。然后再搜索一次试试看
- 如果还是搜索不到，执行 `rm ~/Library/Caches/CocoaPods/search_index.json` 。再搜索就OK了

## 导入方式
```ruby
pod 'QTableKit'
```


## Author：DQ  
我的其他开源库，给个Star鼓励我写更多好库：

[IOS 1:1完美仿微信聊天表情键盘](https://github.com/QDong415/QKeyboardEmotionView)

[IOS 自定义UIAlertController，支持弹出约束XibView、弹出ViewController](https://github.com/QDong415/QUIAlertController)

[IOS 封装tableViewCell样式不一致的UITableView，告别复杂的UITableViewDataSource](https://github.com/QDong415/QTableKit)

[IOS 仿快手直播界面加载中，顶部的滚动条状LoadingView](https://github.com/QDong415/QStripeAnimationLayer)

[IOS 基于个推+华为push的一整套完善的 IM聊天系统](https://github.com/QDong415/iTopicOCChat)

[Android 朋友圈列表Feed流的最优化方案，让你的RecyclerView从49帧 -> 57帧](https://github.com/QDong415/QFeed)

[Android 仿大众点评、仿小红书 下拉拖拽关闭Activity](https://github.com/QDong415/QDragClose)

[Android 仿快手直播间手画礼物，手绘礼物](https://github.com/QDong415/QDrawGift)

[Android 直播间聊天消息列表RecyclerView。一秒内收到几百条消息依然不卡顿](https://github.com/QDong415/QLiveMessageHelper)

[Android 仿快手直播界面加载中，顶部的滚动条状LoadingView](https://github.com/QDong415/QStripeView)

[Android Kotlin MVVM框架，全世界最优化的分页加载接口、最接地气的封装](https://github.com/QDong415/QKotlin)

[Android 基于个推+华为push的一整套完善的android IM聊天系统](https://github.com/QDong415/iTopicChat)
