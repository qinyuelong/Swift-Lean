//
//  ViewController.swift
//  Swift-Lean
//
//  Created by snqu-qin on 2017/5/2.
//  Copyright © 2017年 qin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let introductionDic = ["GuardViewController" : "为什么 guard 比 if 好",
                           "FlatMapViewController" : "Swift 2.0: 理解 flatMap",
                           "StructCodingViewController" : "Swift 中的结构体与 NSCoding"]
    
    
    
    var teachDic: [String : Dictionary<String, String>]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
        
        teachDic = ["swift 入门" : introductionDic]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Array(teachDic.keys).count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keys = Array(teachDic!.keys)
        let itemDic = teachDic[keys[section]]
        return Array(itemDic!.keys).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell?.accessoryType = .disclosureIndicator
        }
        let keys = Array(teachDic!.keys)
        let itemDic = teachDic[keys[indexPath.section]]
        cell?.textLabel?.text = Array(itemDic!.values)[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 320, height: 30))
        label.backgroundColor = UIColor.gray
        let keys = Array(teachDic!.keys)
        label.text = keys[section]
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let keys = Array(teachDic!.keys)
        let itemDic = teachDic[keys[indexPath.section]]
        let viewControllerString = parseSection(indexPath.section, viewControllerName: Array(itemDic!.values)[indexPath.row])
        if let classType = NSClassFromString(viewControllerString!) as? UIViewController.Type {
            let viewController = classType.init()
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func parseSection(_ section: Int , viewControllerName title: String) -> String? {
        let keys = Array(teachDic!.keys)
        let itemDic = teachDic[keys[section]]
        for key in Array(itemDic!.keys) {
            let v = itemDic?[key]
            if v == title {
                return ("Swift_Lean.\(key)")
            }
        }
        return nil
    }
    
}
