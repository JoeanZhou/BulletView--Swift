//
//  BulletView.swift
//  dangmu
//
//  Created by ZhouXu on 16/10/20.
//  Copyright © 2016年 ZhouXu. All rights reserved.
//

import UIKit

enum MoveState: Int{
    case begin = 0  //  开始进去屏幕
    case enter = 1  //  进入屏幕
    case end = 2  //  飞出屏幕
}

typealias BulletViewMoveStateBlock = (_ bulletView: BulletView, _ state: MoveState) -> Void

class BulletView: UIView, CAAnimationDelegate {
    
    //  bulletView的飞入状态
    public var bulletViewMoveStateBlock : BulletViewMoveStateBlock?
    public var trajectory : Int?  //  弹道
    
    private let lableHeight : CGFloat = 20
    private let magin : CGFloat = 10
    private let defaultTime : CGFloat = 5.0
    private let animationKey : String = "BulletViewAnimation"
    public let ScreenMagin: CGFloat = 40
    
    lazy var displayLabel : UILabel = {
        let lable = UILabel()
        lable.textColor = UIColor.white
        lable.font = UIFont.systemFont(ofSize: 14.0)
        return lable
    }()
    
    init(frame: CGRect, compment: NSString) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        let commpoentRect : CGRect = compment.boundingRect(with: CGSize(width: 1000000, height: lableHeight), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14.0)], context: nil)
        self.displayLabel.text = compment as String
        displayLabel.frame = CGRect(x: 5, y: 5 ,width: commpoentRect.size.width, height:lableHeight)
        addSubview(displayLabel)
        self.frame.size = CGSize(width: commpoentRect.size.width + magin, height:lableHeight + magin)
    }
    
    public func startAnimaion(){
        
        let speed : CGFloat = CGFloat((frame.width + UIScreen.main.bounds.size.width) / defaultTime)
        let enterDur : CGFloat = (frame.width + ScreenMagin) / speed  //  完全进去屏幕时的时间
        if (bulletViewMoveStateBlock != nil) {
            bulletViewMoveStateBlock!(self, .begin)
        }
        perform(#selector(BulletView.didEnterScreen), with: nil, afterDelay: TimeInterval(enterDur))
        
        var tempFrame : CGRect = self.frame;
        weak var weakSelf = self
        UIView.animate(withDuration: TimeInterval(defaultTime), animations: {
            tempFrame.origin.x = -(weakSelf?.frame.size.width)!
             weakSelf?.frame = tempFrame
            }) { (YES) in
                if (weakSelf?.bulletViewMoveStateBlock != nil) {
                    weakSelf?.bulletViewMoveStateBlock!(weakSelf!, .end)
                }
                weakSelf?.layer.removeAllAnimations()
                weakSelf?.removeFromSuperview()
        }
//        let baseAnimation : CABasicAnimation = CABasicAnimation()
//        baseAnimation.delegate = self
//        baseAnimation.keyPath = "position.x"
//        baseAnimation.fromValue = UIScreen.main.bounds.size.width
//        baseAnimation.toValue = -frame.size.width
//        baseAnimation.duration = CFTimeInterval(defaultTime)
//        baseAnimation.autoreverses = false
//        layer.add(baseAnimation, forKey: animationKey)
    }
    
    internal func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {  //  利用layer执行动画
        if (bulletViewMoveStateBlock != nil) {
            bulletViewMoveStateBlock!(self, .end)
        }
        layer.removeAnimation(forKey: animationKey)
        removeFromSuperview()
    }
    
    @objc private func didEnterScreen(){
        if (bulletViewMoveStateBlock != nil) {
            bulletViewMoveStateBlock!(self, .enter)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
