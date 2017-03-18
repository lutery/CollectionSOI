//
//  HorizontalLayout.swift
//  DWorld
//
//  Created by lutery on 2017/3/17.
//  Copyright © 2017年 lutery. All rights reserved.
//

import UIKit

class LineLayout: UICollectionViewFlowLayout {
    
    internal let ACTIVE_DISTANCE = 64;
    internal let ZOOM_FACTOR = 0.5;
    internal var mItemCount = 0;
    internal let TEST = "Hello world";
    var mScale = 0.85;

    override func prepare() {
        super.prepare();
        
        mItemCount = (self.collectionView?.numberOfItems(inSection: 0))!;
        self.scrollDirection = .horizontal;
        self.sectionInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0);
        self.minimumLineSpacing = 16.0;
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attris = super.layoutAttributesForElements(in: rect);
        
        let visibleRect = CGRect(x: (self.collectionView?.contentOffset.x)!, y: 0, width: (self.collectionView?.bounds.width)!, height: (self.collectionView?.bounds.height)!);
        let centerX = (self.collectionView?.contentOffset.x)! + UIScreen.main.bounds.size.width / 2;
        
        for attri in attris! {
            attri.center.x = (attri.center.x) + (self.collectionView?.frame.size.width)! / 2 - self.itemSize.width / 2;
            
            if visibleRect.intersects(attri.frame) {
                let distance = visibleRect.midX - attri.center.x;
                
                let normalizedDistance = CGFloat(distance) / CGFloat(ACTIVE_DISTANCE);
                
                if abs(distance) < CGFloat(ACTIVE_DISTANCE) {
                    let zoom = 1 + CGFloat(ZOOM_FACTOR) * (1 - abs(normalizedDistance));
                    attri.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
                    attri.zIndex = 1;
                }
            }
        }
        
        return attris;
    }
    
//    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        let attri = super.layoutAttributesForItem(at: indexPath);
//        
//        
//        
//        return attri;
//    }
    
//    override var collectionViewContentSize: CGSize{
//        get{
//            return CGSize(width: 0, height: 0);
//        }
//    }
    
    override var collectionViewContentSize: CGSize{
        get{
//            let contentTemp = self.minimumInteritemSpacing * CGFloat(self.mItemCount - 1);
//            let contentTemp1 = CGFloat(self.mItemCount) * self.itemSize.width;
//            let contentWidth = contentTemp + self.sectionInset.left + self.sectionInset.right + contentTemp1 + (self.collectionView?.frame.width)!;
            
            return CGSize(width: super.collectionViewContentSize.width + (self.collectionView?.frame.width)! - self.itemSize.width, height: super.collectionViewContentSize.height);
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true;
    }
}
