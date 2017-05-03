//
//  FlatMapViewController.swift
//  Swift-Lean
//
//  Created by snqu-qin on 2017/5/3.
//  Copyright © 2017年 qin. All rights reserved.
//  http://swift.gg/2015/08/06/swift-2-flatmap/

import UIKit

class FlatMapViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let nestedArray = [ [1,2,3], [4,5,6] ]
        let flattenedArray = nestedArray.flatMap{$0}
        print("flattenedArray = \(flattenedArray)")
        
        let multipliedFlattenedArray = nestedArray.flatMap{$0.map{$0 * 2}}
        print("multipliedFlattenedArray = \(multipliedFlattenedArray)")
        
        let multipliedFlattenedArray2 = nestedArray.flatMap{ array in
            array.map { element in
                element * 3
            }
        }
        
        print("multipliedFlattenedArray2 = \(multipliedFlattenedArray2)")
        
        // flatMap + 可选类型
        let optionalInts: [Int?] = [1, 2, nil, 4, nil, 5]
        let ints = optionalInts.flatMap{$0}
        print("ints = \(ints)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
