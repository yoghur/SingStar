//
//  ViewController.swift
//  视唱达人
//
//  Created by Sincere on 2019/5/11.
//  Copyright © 2019 Sincere. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var myImageView: UIImageView!
    //初始化UI的代码要放在此函数内
    override func viewDidLoad() {
        super.viewDidLoad()
        myImageView.image = UIImage(named: "song1.png")
        myImageView.contentMode = .scaleAspectFit
        //print("image is \(String(describing: myImageView.image?.size.width))")
        //print("frame is \(myImageView.frame.size.width)")
        let cgView = CGView(frame: myImageView.frame)
        cgView.shapeWidth = Float(myImageView.frame.size.width) / Float((myImageView.image?.size.width)!)
        cgView.shapeHeight = Float(myImageView.frame.size.height) / Float((myImageView.image?.size.height)!)
        self.view.addSubview(cgView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //这里有个潜在bug 关于输入的规范
    public func getJsonData(path jsonPath:String, info:String, numOfInfo:Int, detail:String)-> Float{
        let url = URL(fileURLWithPath: jsonPath)
        var jsonArr:NSDictionary
        do {
            let data = try Data(contentsOf: url)
            let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            jsonArr = jsonData as! NSDictionary
        } catch let error as Error? {
            //一定要返回一个NSDictionary 我也很绝望啊 随便初始化一个吧
            let dictionaryExample : [String:AnyObject] = ["user":"UserName" as AnyObject]
            let dataExample : NSData = NSKeyedArchiver.archivedData(withRootObject: dictionaryExample) as NSData
            jsonArr = NSKeyedUnarchiver.unarchiveObject(with: dataExample as Data)! as! NSDictionary
            print("读取本地数据出现错误!",error ?? 0)
        }
        let data = jsonArr
        if let jsonInfo = data[info] as? NSArray {
            let node = jsonInfo[numOfInfo] as! NSDictionary
            return node[detail] as! Float
            }
        return 0.0
    }
    
    public func getJsonData(path jsonPath:String, info:String, numOfInfo:Int, detail:String, numOfNodelist:Int, detailOfNodelist:String)-> Float{
        let url = URL(fileURLWithPath: jsonPath)
        var jsonArr:NSDictionary
        do {
            let data = try Data(contentsOf: url)
            let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            jsonArr = jsonData as! NSDictionary
        } catch let error as Error? {
            //一定要返回一个NSDictionary 我也很绝望啊 随便初始化一个吧
            let dictionaryExample : [String:AnyObject] = ["user":"UserName" as AnyObject]
            let dataExample : NSData = NSKeyedArchiver.archivedData(withRootObject: dictionaryExample) as NSData
            jsonArr = NSKeyedUnarchiver.unarchiveObject(with: dataExample as Data)! as! NSDictionary
            print("读取本地数据出现错误!",error ?? 0)
        }
        let data = jsonArr
        if let jsonInfo = data[info] as? NSArray {
            let node = jsonInfo[numOfInfo] as! NSDictionary
            let noteList = node[detail] as! NSArray
            let singleNode = noteList[numOfNodelist] as! NSDictionary
            return singleNode[detailOfNodelist] as! Float
        }
        return 0.0
    }
}

