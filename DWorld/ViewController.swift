//
//  ViewController.swift
//  DWorld
//
//  Created by lutery on 2017/3/14.
//  Copyright © 2017年 lutery. All rights reserved.
//

import UIKit
import Material

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.prepareRaisedButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController{
    
    fileprivate func prepareRaisedButton(){
        let button = RaisedButton(title: "Start", titleColor: UIColor.white);
        button.pulseColor = UIColor.white;
        button.backgroundColor = Color.blue.base;
        
        self.view.layout(button)
                 .width(ButtonLayout.Raised.width)
                 .height(ButtonLayout.Raised.height)
                 .center(offsetX: 0, offsetY: ButtonLayout.Raised.offsetY)
        
        button.addTarget(self, action: #selector(ViewController.startDemo), for: .touchUpInside)
    }
}

extension ViewController{
    @objc fileprivate func startDemo(_ sender:AnyObject){
        print("startDemo")
        self.presentTo("navidemo");
    }
}

