//
//  LoadAnimationView.swift
//  11-8加载动画
//
//  Created by littleKid on 2016/11/8.
//  Copyright © 2016年 littleKid. All rights reserved.
//


import UIKit

class LoadAnimationView: UIView {
    private var round1Color = UIColor.init(red: 248/255.0, green: 201/255.0, blue: 53/255.0, alpha: 1)
    private var round2Color = UIColor.init(red: 232/255.0, green:41/255.0, blue: 26/255.0, alpha: 0.6)
    private var round3Color = UIColor.init(red: 206/255.0, green: 7/255.0, blue: 85/255.0, alpha: 0.3)
    
    private let animaTime = 1.5
    private let animRepeatTime: Float = Float(INTMAX_MAX)
    
    private var round1 : UIView!
    private var round2 : UIView!
    private var round3 : UIView!
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
        
        
    }
    
    
    //创建
   public class func showWithCurrentWindow() -> LoadAnimationView{
        //获取当前window
        let lastWindow = UIApplication.shared.windows.last
        
        let loadingView = LoadAnimationView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        lastWindow?.addSubview(loadingView)
        
        
        return loadingView
        
    }
    
    public class func showWithView(view: UIView) -> LoadAnimationView{
        let loadingView = LoadAnimationView.init(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        
        view.addSubview(loadingView)
        return loadingView
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    public func startAnimation() -> () {
        
        let otherRoundCenter1 = CGPoint.init(x: round1.center.x+10, y: round2.center.y)
        
        let otherRoundCenter2 = CGPoint.init(x: round2.center.x+10, y: round2.center.y)
        
        
        //第一个圆的运行轨迹
        let path1 = UIBezierPath.init()
        //指定圆形的圆心和开始的结束的角度 clockwise:是否顺时针
        path1.addArc(withCenter: otherRoundCenter1, radius: 10, startAngle: -CGFloat(M_PI), endAngle: 0, clockwise: true)
        
        let path1_1 = UIBezierPath.init()
        path1_1.addArc(withCenter: otherRoundCenter2, radius: 10, startAngle: -CGFloat(M_PI), endAngle: 0, clockwise: false)
        path1.append(path1_1)
        viewPathMoveAnimation(view: round1, path: path1, time: animaTime)
        viewColorAnimation(view: round1, fromColor: round1Color, toColor: round3Color, time: animaTime)
        
        
        //第二个圆的运行轨迹
        let path2 = UIBezierPath.init()
        path2.addArc(withCenter: otherRoundCenter1, radius: 10, startAngle: 0, endAngle: CGFloat(M_PI), clockwise: true)
        viewPathMoveAnimation(view: round2, path: path2, time: animaTime)
        viewColorAnimation(view: round2, fromColor: round2Color, toColor: round1Color, time: animaTime)
        
        //第三个球的轨迹
        let path3 = UIBezierPath.init()
        path3.addArc(withCenter: otherRoundCenter2, radius: 10, startAngle: 0, endAngle: CGFloat(M_PI), clockwise: false)
        viewPathMoveAnimation(view: round3, path: path3, time: animaTime)
        viewColorAnimation(view: round3, fromColor: round3Color, toColor: round2Color, time: animaTime)
        
        
    }
    
    //MARK:  配置界面
    private func configUI() -> () {
       //创建第一个圆
        let round1 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        round1.layer.cornerRadius = round1.bounds.height/2
        round1.backgroundColor = round1Color
        self.round1 = round1
        
        //第二个圆
        let round2 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        round2.layer.cornerRadius = round2.bounds.height/2
        round2.backgroundColor = round2Color
        self.round2 = round2
        
        //第三个圆
        let round3 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        round3.layer.cornerRadius = round3.bounds.height/2
        round3.backgroundColor = round3Color
        self.round3 = round3
        
        //位于中间
        let center = self.center
        round1.center = CGPoint(x: center.x-20, y: center.y)
        round2.center = center
        round3.center = CGPoint(x: center.x + 20, y: center.y)
        
        
        self.addSubview(round1)
        self.addSubview(round2)
        self.addSubview(round3)
        
        startAnimation()
        
        
    }
    
    //MARK: 动画
    private func viewPathMoveAnimation(view: UIView, path : UIBezierPath, time: Double) -> () {
        //使用帧动画
        //需要改变的是坐标
        let anim = CAKeyframeAnimation.init(keyPath: "position")
        //转换成cgpath
        anim.path = path.cgPath
        //完成后不移除
        anim.isRemovedOnCompletion = false
        //设置结束状态
        anim.fillMode = kCAFillModeForwards
        //让动画变得均匀
        anim.calculationMode = kCAAnimationCubic
        //不回放
        anim.autoreverses = false
        
        //重复的次数
        anim.repeatCount = animRepeatTime
        //持续时间
        anim.duration = animaTime
        //        anim.delegate = self
        
        //动画快慢
        anim.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
        //添加到圆上
        view.layer.add(anim, forKey: "animation")
        
    }
    
    //设置颜色渐变动画
    private func viewColorAnimation(view:UIView, fromColor: UIColor, toColor: UIColor, time:Double) -> () {
        let colorAnim = CABasicAnimation.init(keyPath: "backgroundColor")
        colorAnim.toValue = toColor.cgColor
        colorAnim.fromValue = fromColor.cgColor
        colorAnim.duration = time
        colorAnim.autoreverses = false
        colorAnim.fillMode = kCAFillModeForwards
        colorAnim.isRemovedOnCompletion = false
        colorAnim.repeatCount = animRepeatTime
        
        view.layer.add(colorAnim, forKey: "backgroundColor")
    }
    
    //MARK:移除动画
    public func hideLoadAnimationView() -> () {
        round1?.layer.removeAllAnimations()
        round2?.layer.removeAllAnimations()
        round3?.layer.removeAllAnimations()
        
        self.removeFromSuperview()
    }
    
    
    //MARK: layout
    override func layoutSubviews() {
        super.layoutSubviews()
        //位于中间
        let center = self.center
        self.round1?.center = CGPoint(x: self.center.x-20, y: self.center.y)
        self.round2?.center = center
        self.round3?.center = CGPoint(x: self.center.x + 20, y: self.center.y)
        
    }
    
    deinit {
        print("销毁了")
    }
    
}
