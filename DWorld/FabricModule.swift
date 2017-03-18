//
//  FabricModule.swift
//  DWorld
//
//  Created by lutery on 2017/3/17.
//  Copyright © 2017年 lutery. All rights reserved.
//

import UIKit

class FabricModule: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    public static let CELLID = "FabricCell";
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FabricModule.CELLID, for: indexPath);
        cell.backgroundColor = UIColor.clear;
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 80));
        label.text = "格子";
        cell.contentView.addSubview(label);
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor).isActive = true;
        label.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor).isActive = true;
        label.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor).isActive = true;
        label.topAnchor.constraint(equalTo: cell.contentView.topAnchor).isActive = true;
        
        return cell;
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }

}
