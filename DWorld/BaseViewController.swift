//
//  BaseViewController.swift
//  DWorld
//
//  Created by lutery on 2017/3/16.
//  Copyright © 2017年 lutery. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    internal func navigationTo(_ storyId:String){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: storyId);
        
        self.navigationController?.pushViewController(viewController, animated: true);
    }
    
    internal func presentTo(_ storyId:String){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: storyId);
        
        self.present(viewController, animated: true, completion: nil);
    }
    
    @objc internal func backToBegin(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc internal func backToPre(){
        self.navigationController?.popViewController(animated: true);
    }
}
