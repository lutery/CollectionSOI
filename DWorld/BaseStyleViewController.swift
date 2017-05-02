//
//  BaseStyleViewController.swift
//  DWorld
//
//  Created by lutery on 2017/3/14.
//  Copyright © 2017年 lutery. All rights reserved.
//

import UIKit
import Material

class BaseStyleViewController: BaseViewController {
    
    private var mBSModule:BaseStyleModule? = nil;
    var BSModule:BaseStyleModule{
        get{
            if mBSModule == nil {
                mBSModule = BaseStyleModule();
            }
            
            return mBSModule!;
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.prepareBar()
        self.prepareCollectionView()
        self.prepareFABButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension BaseStyleViewController{
    fileprivate func prepareBar(){
        self.title = "请选择基础样式"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(BaseStyleViewController.backToBegin))
    }
    
    fileprivate func prepareFABButton(){
        var button = FABButton(title: "上", titleColor: .gray);
        button.pulseColor = .white
        button.backgroundColor = Color.gray
        
        self.view.layout(button)
                 .width(ButtonLayout.Fab.diameter)
                 .height(ButtonLayout.Fab.diameter)
                 .bottom(10)
                 .left(10)
        
        button = FABButton(title: "下", titleColor: .white);
        button.pulseColor = .white
        button.backgroundColor = Color.green.base
        
        self.view.layout(button)
            .width(ButtonLayout.Fab.diameter)
            .height(ButtonLayout.Fab.diameter)
            .bottom(10)
            .right(10)
        
        button.addTarget(self, action: #selector(BaseStyleViewController.goToNext), for: .touchUpInside)
    }
    
    fileprivate func prepareCollectionView(){
        let layout = AnnulusLayout();
        let collection = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout);
        collection.delegate = BSModule;
        collection.dataSource = BSModule;
        
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: BaseStyleModule.CELLID);
        self.view.addSubview(collection);
        
        collection.translatesAutoresizingMaskIntoConstraints = false;
        collection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true;
        collection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true;
        collection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        collection.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true;
        collection.backgroundColor = UIColor.clear;
    }
}

extension BaseStyleViewController{
    @objc fileprivate func goToNext(_ sender:AnyObject){
        print("go to next");
        self.navigationTo("fabricvc");
    }
}
