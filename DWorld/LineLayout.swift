//
//  HorizontalLayout.swift
//  DWorld
//
//  Created by lutery on 2017/3/17.
//  Copyright © 2017年 lutery. All rights reserved.
//

import UIKit


/// 水平布局
class LineLayout: UICollectionViewFlowLayout {
    
    internal let ACTIVE_DISTANCE = 64;
    internal let ZOOM_FACTOR = 0.5;
    internal var mItemCount = 0;
    internal let TEST = "Hello world";
    var mScale = 0.85;

    override func prepare() {
        super.prepare();
        
        mItemCount = (self.collectionView?.numberOfItems(inSection: 0))!;
        // 设置滚动的方向
        self.scrollDirection = .horizontal;
        // 设置内容区域距离父区域的边距
        self.sectionInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0);
        // 设置横向最小间距
        self.minimumLineSpacing = 16.0;
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        /// 获取默认的每个元素的属性
        let attris = super.layoutAttributesForElements(in: rect);
        
        // 获取当前可视区域的面积
        let visibleRect = CGRect(x: (self.collectionView?.contentOffset.x)!, y: 0, width: (self.collectionView?.bounds.width)!, height: (self.collectionView?.bounds.height)!);
        
//        let centerX = (self.collectionView?.contentOffset.x)! + UIScreen.main.bounds.size.width / 2;
        
        // 遍历每一个属性，设置相关的属性值
        for attri in attris! {
            // 默认选择第一个cell，那么每个cell直接默认偏移（collectionview的宽度的一半再减去cell的一半）
            attri.center.x = (attri.center.x) + (self.collectionView?.frame.size.width)! / 2 - self.itemSize.width / 2;
            
            // 如果当前的cell处于可视区域
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
