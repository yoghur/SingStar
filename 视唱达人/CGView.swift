//
//  CGView.swift
//  视唱达人
//
//  Created by Sincere on 2019/5/31.
//  Copyright © 2019 Sincere. All rights reserved.
//

import Foundation
import UIKit

class CGView:UIView {
    
    override init(frame: CGRect) {
        self.shapeWidth = 1.0
        self.shapeHeight = 1.0
        self.sizeOfRadius = 2
        super.init(frame: frame)
        //设置背景色为透明，否则是黑色背景
        self.backgroundColor = UIColor.clear
    }
    var shapeWidth:Float
    var shapeHeight:Float
    var sizeOfRadius:Int
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let jsonPath = Bundle.main.path(forResource: "data.json", ofType: nil) else {return}
        let vc = ViewController()
        //vc.viewDidLoad()
        //print("target 1 is \(vc.getJsonData(path: jsonPath, info: "noteInfo", numOfInfo: 0, detail: "noteList", numOfNodelist: 0, detailOfNodelist: "x"))")
        //print("target 2 is \(vc.getJsonData(path: jsonPath, info: "noteInfo", numOfInfo: 0, detail: "noteList", numOfNodelist: 1, detailOfNodelist: "x"))")
        var currentWidth = vc.getJsonData(path: jsonPath, info: "noteInfo", numOfInfo: 0, detail: "noteList", numOfNodelist: 0, detailOfNodelist: "x") * shapeWidth
        var currentHeight = vc.getJsonData(path: jsonPath, info: "noteInfo", numOfInfo: 0, detail: "noteList", numOfNodelist: 0, detailOfNodelist: "y") * shapeHeight
        //print("\(shapeWidth)")
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //let scaleWidth : CGFloat = (vc.myImageView.image?.size.width)! / vc.myImageView.frame.size.width
        //let scaleHeight:CGFloat = (vc.myImageView.image?.size.height)! / vc.myImageView.frame.size.height
        //print("\(vc.myImageView.image!.size.width)")
        //print("\(vc.myImageView.frame.size.width)")
        //currentX = currentX / Float(scaleWidth)
        for node in 0...6
        {
             currentWidth = vc.getJsonData(path: jsonPath, info: "noteInfo", numOfInfo: 0, detail: "noteList", numOfNodelist: node, detailOfNodelist: "x") * shapeWidth
             currentHeight = vc.getJsonData(path: jsonPath, info: "noteInfo", numOfInfo: 0, detail: "noteList", numOfNodelist: node, detailOfNodelist: "y") * shapeHeight
            PutNote(target: context, Px: Int(currentWidth), Py: Int(currentHeight)+5, Pr: sizeOfRadius)
        }
    }
    
    func PutNote(target context: CGContext,Px x: Int,Py y: Int,Pr r: Int)  {
        let path = CGMutablePath()
        let radius = r
        let center = CGPoint(x:(x), y:(y))
        
        path.addArc(center: center, radius: CGFloat(radius), startAngle: 0,
                    endAngle: CGFloat.pi * 2, clockwise: false)
        context.addPath(path)
        context.setStrokeColor(UIColor.green.cgColor)
        context.setLineWidth(6)
        context.strokePath()
    }
}
