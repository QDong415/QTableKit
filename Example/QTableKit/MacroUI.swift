//
//  Common+UI.swift
//  QSwift
//
//  Created by QDong on 2021/7/4.
//

import UIKit
import Foundation

// 屏幕宽度
let SCREEN_WIDTH = UIScreen.main.bounds.size.width;
// 屏幕高度
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height;

// 状态栏高度
let STATUSBAR_HIGH = UIApplication.shared.statusBarFrame.size.height  //非X是20 X是44
let kTopNavHeight = 44 + STATUSBAR_HIGH //非X是64 X是98 ，44是导航栏的高度

let COLOR_BACKGROUND_RGB = UIColor(red: (248)/255.0, green: (248)/255.0, blue: (246)/255.0, alpha: 1)
let COLOR_WHITE_RGB = UIColor(red: (248)/255.0, green: (248)/255.0, blue: (248)/255.0, alpha: 1)
let COLOR_DIVIDER_RGB
    = UIColor(red: (220)/255.0, green: (220)/255.0, blue: (220)/255.0, alpha: 1)

let COLOR_BLACK_RGB = UIColor(red: (91)/255.0, green: (91)/255.0, blue: (91)/255.0, alpha: 1)
let COLOR_GRAY_DARK_RGB = UIColor(red: (104)/255.0, green: (104)/255.0, blue: (104)/255.0, alpha: 1)
let COLOR_GRAY_RGB = UIColor(red: (145)/255.0, green: (145)/255.0, blue: (145)/255.0, alpha: 1)


// 计算text的高度
func measureHeight(text: String?, maxWidth: CGFloat, font: UIFont?, lineSpacing: CGFloat) -> CGFloat {
    
    guard let text = text else {
        return 0
    }
    
    let calSize = CGSize(width: maxWidth, height: CGFloat(MAXFLOAT))

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineBreakMode = .byWordWrapping
    paragraphStyle.lineSpacing = lineSpacing

    let attributes = [
        NSAttributedString.Key.font: font,
        NSAttributedString.Key.paragraphStyle: paragraphStyle
    ]
    
    let rect = text.boundingRect(
        with: calSize,
        options: [.usesLineFragmentOrigin, .usesFontLeading],
        attributes: attributes as [NSAttributedString.Key : Any],
        context: nil)
    
    return rect.height
}
