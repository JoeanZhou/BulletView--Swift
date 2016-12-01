//
//  ViewController.swift
//  dangmu
//
//  Created by ZhouXu on 16/10/19.
//  Copyright © 2016年 ZhouXu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 实例化
    let tool = PlayDanmuTool()
    let moveView : UIView = UIView()
    let button:UIButton = UIButton(type:.custom)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.white
        
        let lable = UILabel()
        lable.textColor = UIColor.blue
        lable.text = "Swift 弹幕"
        lable.font = UIFont.systemFont(ofSize: 16.0)
        lable.sizeToFit()
        var lableRect: CGRect = lable.frame
        lableRect.origin.x = CGFloat((view.frame.width - lable.bounds.width) / 2)
        lableRect.origin.y = 20
        lable.frame = lableRect
        view.addSubview(lable)
        
        button.frame = CGRect(x:10, y:150, width:100, height:30)
        button.center = view.center
        button.setTitle("开始弹幕", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(ViewController.beginDanmu(button:)), for: .touchUpInside)
        view.addSubview(button)
        
        var tempButtonF:CGRect = CGRect.zero
        let cancelButton:UIButton = UIButton(type: .custom)
        cancelButton.frame = button.frame
        tempButtonF = cancelButton.frame
        tempButtonF.origin.y = button.frame.maxY + 20
        cancelButton.frame = tempButtonF
        cancelButton.setTitle("结束弹幕", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.addTarget(self, action: #selector(ViewController.endDanmu(buttonClose:)), for: .touchUpInside)
        view.addSubview(cancelButton)
        
        
        moveView.frame = CGRect(x: 25, y: 64, width: UIScreen.main.bounds.width - 50, height: 200)
        moveView.backgroundColor = UIColor.black
        view.addSubview(moveView)
    }
    
    @objc private func beginDanmu(button : UIButton) {
        tool.trajectory = 4
        tool.excuceBullet(displayView: moveView, datasource: ["按房间按对法的奶粉呢~~~~",
                                                          "考察那都是看你吃~~~~~~~~",
                                                          "弹幕3~~~~~~~~",
                                                          "弹幕4爱上的尺寸~~",
                                                          "弹幕5~~俺的错技能呢~~~~~",
                                                          "弹幕6~~阿萨德才阿萨德才~~~~~",
                                                          "弹幕~~~",
                                                          "弹幕8~~~~~~~~弹幕2~~~~~~~~",
                                                          "弹幕9~但是是~~~~",
                                                          "按房间按对法的奶粉呢~~~~",
                                                          "考察那都是看你吃~~~~~~~~",
                                                          "弹幕3~~~~~~~~",
                                                          "弹幕4爱上的尺寸~~",
                                                          "弹幕5~~俺的错技能呢~~~~~",
                                                          "弹幕6~~阿萨德才阿萨德才~~~~~",
                                                          "弹幕~~~",
                                                          "弹幕8~~~~~~~~弹幕2~~~~~~~~",
                                                          "弹幕9~但是是~~~~",
                                                          "按房间按对法的奶粉呢~~~~",
                                                          "考察那都是看你吃~~~~~~~~",
                                                          "弹幕3~~~~~~~~",
                                                          "弹幕4爱上的尺寸~~",
                                                          "弹幕5~~俺的错技能呢~~~~~",
                                                          "弹幕6~~阿萨德才阿萨德才~~~~~",
                                                          "弹幕~~~",
                                                          "弹幕8~~~~~~~~弹幕2~~~~~~~~",
                                                          "弹幕9~但是是~~~~",
                                                          ])
        button.isEnabled = false  //  不设置这个会导致数据重复
    }
    
    @objc private func endDanmu(buttonClose : UIButton) {
        tool.stopBullet(displayView: view)
        button.isEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

