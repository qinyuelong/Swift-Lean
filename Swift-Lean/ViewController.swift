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
    
    let itemDic = ["GuardViewController" : "为什么 guard 比 if 好"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemDic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell?.accessoryType = .disclosureIndicator
        }
        cell?.textLabel?.text = Array(itemDic.values)[indexPath.row]
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewControllerString = parseViewControllerName(Array(itemDic.values)[indexPath.row])
        if let classType = NSClassFromString(viewControllerString!) as? UIViewController.Type {
            let viewController = classType.init()
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func parseViewControllerName(_ title: String) -> String? {
        for key in Array(itemDic.keys) {
            let v = itemDic[key]
            if v == title {
                return ("Swift_Lean.\(key)")
            }
        }
        return nil
    }
    
}
