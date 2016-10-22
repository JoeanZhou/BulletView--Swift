//
//  PlayDanmuTool.swift
//  dangmu
//
//  Created by ZhouXu on 16/10/19.
//  Copyright © 2016年 ZhouXu. All rights reserved.
//

import UIKit

class PlayDanmuTool: NSObject {
    
    //  创建弹道轨迹
    public var trajectory : Int?{
        set{
            for i in 0 ..< Int(newValue!) {
                trajectoryArray.append(i)
                tempTrajectoryArray.append(i)
            }
            _trajectory = newValue
        }
        get{
            return _trajectory
        }
    }

    
    private var trajectoryArray : [Int] = [Int]()
    private var tempTrajectoryArray : [Int] = [Int]()
    private var _trajectory: Int?
    private var tempDataSourceArray: [String] = [String]()
    private var buttleViewArray: [BulletView] = [BulletView]()
    private var displayTempView: UIView = UIView()
    private var tempDataSource: [String] = [String]()

    override init() {
        super.init()
    }
    
    //  执行弹幕 displayView  需要展示的View  datasource  数据源
    public func excuceBullet(displayView : UIView, datasource : [String]) {
        tempDataSourceArray.removeAll()
        tempDataSource.removeAll()
        buttleViewArray.removeAll()
        
        tempDataSourceArray += datasource
        displayTempView = displayView
        tempDataSource += datasource
        
        for _ in 0 ..< trajectoryArray.count {
            var commpoment = tempDataSourceArray.first! as String
            if commpoment.characters.count > 0 {
                tempDataSourceArray.remove(at: 0)
                if randomInRange(range: 0..<trajectoryArray.count) < trajectoryArray.count {
                    let trajectory : Int = trajectoryArray[randomInRange(range: 0..<trajectoryArray.count)]
                    if trajectory < trajectoryArray.count {
                        trajectoryArray.remove(at: trajectory)
                    }
                    creatBulletView(displayView: displayView, compoment: commpoment as NSString, trajectry: MoveState(rawValue: trajectory)!)
                }
            }
        }
    }
    
    //  结束弹幕
    public func stopBullet(displayView : UIView) {
        for item in buttleViewArray {
            item.removeFromSuperview()
        }
        trajectoryArray.removeAll()
        tempDataSourceArray.removeAll()
        buttleViewArray.removeAll()
        tempDataSource.removeAll()
    }

    
    private func creatBulletView(displayView: UIView,compoment: NSString, trajectry: MoveState){
        let bulletView: BulletView = BulletView(frame: CGRect(x: Int(UIScreen.main.bounds.width) + 40, y: 100 + Int(trajectry.rawValue * (30 + 10)), width: 0, height: 0), compment: compoment)
        bulletView.trajectory = trajectry
        weak var weakSelf = self
        bulletView.bulletViewMoveStateBlock = {
            (bulletViewBlock, MoveState) in
            switch MoveState {
            case .begin:  //  开始进入
                weakSelf?.buttleViewArray.append(bulletViewBlock)
            case .enter:  //  进去屏幕
                let compose = weakSelf?.nextCompoent()
                if compose != nil {
                    weakSelf?.creatBulletView(displayView: displayView, compoment: compose! as NSString, trajectry: bulletViewBlock.trajectory!)
                }
            case .end:  //离开屏幕
                if (weakSelf?.buttleViewArray.contains(bulletViewBlock))! {
                    weakSelf?.buttleViewArray.remove(at: (weakSelf?.buttleViewArray.index(of: bulletViewBlock)!)!)
                }
                if weakSelf?.buttleViewArray.count == 0 {
                    weakSelf?.trajectoryArray += self.tempTrajectoryArray
                    weakSelf?.excuceBullet(displayView: (weakSelf?.displayTempView)!, datasource: (weakSelf?.tempDataSource)!)
                }
            }
        }
        displayView.addSubview(bulletView)
        bulletView.startAnimaion()
    }
    
    private func nextCompoent() -> NSString?{
       let compoment = tempDataSourceArray.first
        if compoment != nil {
            tempDataSourceArray.remove(at: 0)
            return compoment! as NSString
        }else{
            return nil
        }
    }
    
    private func randomInRange(range: Range<Int>) -> Int {
        let count = UInt32(range.upperBound - range.lowerBound)
        return  Int(arc4random_uniform(count)) + range.lowerBound
    }
}
