//
//  StructCodingViewController.swift
//  Swift-Lean
//
//  Created by SNQU on 2017/5/18.
//  Copyright © 2017年 qin. All rights reserved.
//  http://swift.gg/2015/08/27/nscoding_and_swift_structs/

import UIKit

// Person already exit so add Coding prefix
fileprivate struct CodingPerson {
    let firstName: String
    let lastName: String
    
    static func encode(person: CodingPerson){
        let personClassObject = HelperClass(codingPerson: person)
        NSKeyedArchiver.archiveRootObject(personClassObject, toFile: HelperClass.path())
    }
    
    
    static func decode() -> CodingPerson? {
        let personClassObject = NSKeyedUnarchiver.unarchiveObject(withFile: HelperClass.path()) as? HelperClass
        return personClassObject?.codingPerson
    }
}


extension CodingPerson {
    class HelperClass: NSObject, NSCoding {
        var codingPerson: CodingPerson?
        
        init(codingPerson: CodingPerson){
            self.codingPerson = codingPerson
            super.init()
        }
        
        class func path() -> String {
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let path = documentsPath?.appending("/Person")
            return path!
        }
        
        required init?(coder aDecoder: NSCoder) {
            guard let firstName = aDecoder.decodeObject(forKey: "firstName") as? String else {
                codingPerson = nil
                super.init()
                return nil
            }
            
            guard let lastName = aDecoder.decodeObject(forKey: "lastName") as? String else {
                codingPerson = nil
                super.init()
                return nil
            }
            
            codingPerson = CodingPerson(firstName: firstName, lastName: lastName)
            super.init()
        }
        
        
        func encode(with aCoder: NSCoder) {
            aCoder.encode(codingPerson?.firstName, forKey: "firstName")
            aCoder.encode(codingPerson?.lastName, forKey: "lastName")
        }
    }
}

class StructCodingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let me = CodingPerson(firstName: "Dominik", lastName: "Hauser")
        CodingPerson.encode(person: me)
        
        let myClone = CodingPerson.decode()
        print("myClone.firstName = \(String(describing: myClone?.firstName))  myClone.lastName = \(String(describing: myClone?.lastName))")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
