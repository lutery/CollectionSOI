//
//  FabricViewController.swift
//  DWorld
//
//  Created by lutery on 2017/3/16.
//  Copyright © 2017年 lutery. All rights reserved.
//

import UIKit
import Material

class FabricViewController: BaseViewController {
    
    private var mFabricModule:FabricModule? = nil;
    var FABRICModule:FabricModule{
        get{
            if mFabricModule == nil {
                mFabricModule = FabricModule();
            }
            
            return mFabricModule!;
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.prepareBar();
        self.prepareFABButton();
        self.prepareFabricVariety();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FabricViewController{
    fileprivate func prepareBar(){
        self.title = "请选择面料";
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(FabricViewController.backToBegin))
    }
    
    fileprivate func prepareFABButton(){
        var button = FABButton(title: "上", titleColor: .white);
        button.pulseColor = .white
        button.backgroundColor = Material.Color.blue.base
        
        self.view.layout(button)
            .width(ButtonLayout.Fab.diameter)
            .height(ButtonLayout.Fab.diameter)
            .bottom(10)
            .left(10)
        
        button.addTarget(self, action: #selector(FabricViewController.backToPre), for: .touchUpInside)
        
        button = FABButton(title: "下", titleColor: .white);
        button.pulseColor = .white
        button.backgroundColor = Color.green.base
        
        self.view.layout(button)
            .width(ButtonLayout.Fab.diameter)
            .height(ButtonLayout.Fab.diameter)
            .bottom(10)
            .right(10)
        
        button.addTarget(self, action: #selector(FabricViewController.goToNext), for: .touchUpInside)
    }
    
    fileprivate func prepareFabricVariety(){
        let layout = LineLayout();
        let collection = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout);
        
        collection.dataSource = FABRICModule;
        collection.delegate = FABRICModule;
        
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: FabricModule.CELLID);
        self.view.addSubview(collection);
        
        collection.translatesAutoresizingMaskIntoConstraints = false;
        collection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true;
        collection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true;
        collection.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true;
        collection.heightAnchor.constraint(equalToConstant: 64).isActive = true;
        collection.backgroundColor = UIColor.clear;

    }
}

extension FabricViewController{
    @objc fileprivate func goToNext(_ sender:AnyObject){
        print("go to next");
    }
}
