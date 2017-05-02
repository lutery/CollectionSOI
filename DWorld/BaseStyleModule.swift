//
//  BaseStyleModule.swift
//  DWorld
//
//  Created by lutery on 2017/3/14.
//  Copyright © 2017年 lutery. All rights reserved.
//

import UIKit

class BaseStyleModule: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    public static let CELLID = "BaseStyleCell";
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseStyleModule.CELLID, for: indexPath);
        cell.backgroundColor = UIColor.init(red: CGFloat(Double(arc4random()%255)/255.0), green: CGFloat(Double(arc4random()%255)/255.0), blue: CGFloat(Double(arc4random()%255)/255.0), alpha: CGFloat(1));
        let label = UILabel(frame: CGRect.init(x: 0, y: 0, width: 250, height: 80))
        label.text = NSString(format: "我是第%ld行", indexPath.row) as String;
        cell.contentView.addSubview(label);
        return cell;
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        //小于半屏 则放到最后一屏多半屏
//        if (scrollView.contentOffset.y<200) {
//            scrollView.contentOffset = CGPoint(x: 0, y: scrollView.contentOffset.y + 10 * 400);
//            //大于最后一屏多一屏 放回第一屏
//        }else if(scrollView.contentOffset.y>11*400){
//            scrollView.contentOffset = CGPoint(x: 0, y: scrollView.contentOffset.y - 10 * 400);
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row);
        //实现当点击指定cell的时候，滚动到指定的cell
        collectionView.setContentOffset(CGPoint(x: CGFloat(indexPath.row * AnnulusLayout.sContentWidth), y: collectionView.contentOffset.y), animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset.x);
//        print(scrollView.contentOffset.y);
        
        //小于半屏 则放到最后一屏多半屏
        if (scrollView.contentOffset.x < CGFloat(0)) {
            scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x + CGFloat(6 * AnnulusLayout.sContentWidth), y: scrollView.contentOffset.y);
            //大于最后一屏多一屏 放回第一屏
        }else if(scrollView.contentOffset.x > CGFloat(6 * AnnulusLayout.sContentWidth)){
            scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x - CGFloat(6 * AnnulusLayout.sContentWidth), y: scrollView.contentOffset.y);
        }
    }
}
