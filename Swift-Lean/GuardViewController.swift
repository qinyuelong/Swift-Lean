//
//  GuardViewController.swift
//  Swift-Lean
//
//  Created by snqu-qin on 2017/5/2.
//  Copyright © 2017年 qin. All rights reserved.
//  http://swift.gg/2015/08/06/swift-guard-better-than-if/

import UIKit

class GuardViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let personViewModel = PersonViewModel(name: "xiaoming", age: "20")
        
        do {
            let  person = try personViewModel.createPerson()
            print("person.name = \(person.name), age = \(person.age)")
        } catch PersonViewModel.InputError.InputMissing {
            print("Input missing! ")
        }catch PersonViewModel.InputError.AgeIncorrect {
            print("Age Incorrect ")
        } catch {
            print("Something went wrong, please try again!")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

struct Person{
    let name: String
    var age: Int
}

struct PersonViewModel{
    var name: String?
    var age: String?
    
    
    enum InputError: Error {
        case InputMissing
        case AgeIncorrect
    }
    
    
    // guard
    func createPerson() throws -> Person {
        guard let age = age, let name = name, name.characters.count > 0 && age.characters.count > 0 else {
            throw InputError.InputMissing
        }
        
        guard let ageFormatted = Int(age) else {
            throw InputError.AgeIncorrect
        }
        
        return Person(name: name, age: ageFormatted)
    }
    
    
    // no guard
    func createPersonNoGuard() -> Person? {
        if let age = age, let name = name, name.characters.count > 0  && age.characters.count > 0 {
            if let ageFormatted = Int(age) {
                return Person(name: name, age: ageFormatted)
            }else{
                return nil
            }
        }else{
            return nil
        }
    }
    
}
