//
//  AnnulusLayout.swift
//  DWorld
//
//  Created by 程辉 on 2017/3/14.
//  Copyright © 2017年 lutery. All rights reserved.
//

import UIKit

/// UICollectionView环形布局
class AnnulusLayout: UICollectionViewLayout {
    
    public static var sContentWidth = 0;
    public static var sItemWidth = 100;
    private var mCurItemIndex = 0;
    
    /// 布局初始化回调函数，可以用于修改布局的一些属性,每次无效重绘布局时将会调用这个函数
    override func prepare() {
        super.prepare()
        
//        self.scrollDirection = .horizontal;
    }
    
    /// 返回布局每个item的属性，可以精确的设置每个item的属性值
    ///
    /// - Parameter rect: 当前的可见区域
    /// - Returns: 返回当前可见区域内item的属性
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        return super.layoutAttributesForElements(in: rect)
        var attributes = [UICollectionViewLayoutAttributes]();
        
        for i in 0..<(self.collectionView?.numberOfItems(inSection: 0))!{
            attributes.append(self.layoutAttributesForItem(at: IndexPath.init(row: i, section: 0))!)
        }
        
        return attributes;
    }
    
    
    /// 设置具体的item的属性
    ///
    /// - Parameter indexPath: 当前的item索引
    /// - Returns: 返回设置item的属性
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        return super.layoutAttributesForItem(at: indexPath)
        //初始化创建一个item布局属性类
        let atti = UICollectionViewLayoutAttributes(forCellWith: indexPath);
        //由于环形布局默认只有一个section，所以这里只需要获取第1个section的item数目
        let itemCounts:Int = (self.collectionView?.numberOfItems(inSection: 0))!;
        //默认最后段偏移量为向上130
        let constY = -130;
        //设置每个item的大小为260*100
//        atti.size = CGSize(260, 100);
        atti.size = CGSize(width: 100, height: 260)
        /*
         后边介绍的代码添加在这里
         */
        // 保证collection中心处于屏幕的中间
//        print((self.collectionView?.contentOffset.y)!);
        atti.center = CGPoint(x: (self.collectionView?.frame.size.width)! / 2  + (self.collectionView?.contentOffset.x)!, y: ((self.collectionView?.frame.size.height)!) / 2);
        
//        let offset = self.collectionView?.contentOffset.y;
//        print(offset);
        // 当前的水平偏移量
        let offset = self.collectionView?.contentOffset.x;
//        
//        let angleOffset = offset! / (self.collectionView?.frame.size.height)!;
        
        // 初始化一个单位矩阵
        var trans3D = CATransform3DIdentity;
        // 这个值设置的是透视度，影响视觉离投影平面的距离
        trans3D.m34 = -1 / 900.0;
        
//        let radius = 50 / tanf(Float(M_PI / Double(itemCounts)));
//        let angle = Double(CGFloat(indexPath.row) + angleOffset) / Double(itemCounts) * M_PI * 2;
//        // 旋转后z轴改变，所以沿着z轴向前拉辉产生滚筒效果
//        trans3D = CATransform3DRotate(trans3D, CGFloat(angle), 1.0, 0, 0);
//        trans3D = CATransform3DTranslate(trans3D, 0, 0, CGFloat(radius));
        // 当前可见区域的宽度
        let collectWidth = self.collectionView?.frame.size.width;
        // 当前可见区域的高度
        let collectionHeight = self.collectionView?.frame.size.height;
        // 每个item与第一个item之间的夹角（以所有item围成的圆为圆心）
        let circleAngle = CGFloat(2 * M_PI) / CGFloat(itemCounts);
        // 圆的半径
        let radius = collectWidth! / 2;
        
        // 根据collectionViewContentSize设定的内容区域尺寸
        // item向x方向偏移collectWidth，那么每个item所走的圆心角就必须是circleAngle
        // 根据这个关系，计算出斜率为k，得到函数offsetX（偏移量） = k * radian（弧度）
        let k = -1 * collectWidth! / circleAngle;
        let offsetAngle = Float(offset! / k);
        
        // 根据环形布局，那么所有item从上往下看围城一个环，环心为原点，水平方向为x轴，竖直方向为y轴设定坐标系
        // 这样每个item的x轴偏移量为offsetX = sin(与y轴负方向形成的夹角) * radius
        // 而为了使圆环能够旋转，需要在（与y轴负方向形成的夹角）加上根据水平偏移量计算出来的弧度偏移量
        // 因为这个偏移量是在不考虑旋转的情况下进行的，如果需要旋转，需要加上弧度偏移
        let offsetX = sinf(Float(CGFloat(indexPath.row) * circleAngle) + offsetAngle) * Float(radius);
        // 计算每个item的纵向偏移量，采用余弦函数，那么范围从1->-1->1，那么最大范围为2，使用如下公式：
        // (1 - cos(item与y轴负方向的夹角)) / 2 * constY，根据比例得到最近端偏移为0，最远端偏移为constY
        // 为了使圆环能够旋转，需要在（与y轴负方向形成的夹角）加上根据水平偏移量计算出来的弧度偏移量
        let offsetY = (Float(1) - cosf(Float(CGFloat(indexPath.row) * CGFloat(circleAngle)) + offsetAngle)) / Float(2) * Float(constY);
        trans3D = CATransform3DTranslate(trans3D, CGFloat(offsetX), CGFloat(offsetY), 0);
        
        // 计算相应位置的item缩放量，最远端缩小至0.25，最近端缩小至1
        // 根据余弦函数的范围从1->-1->1，可知最远端为-1，最近端为1，而最远端的缩放为0.25，最近端为1
        // 那么这个关系计算得出k = （1-（-1）） ／ （1 - 0.25） = 8 ／ 3；
        // 根据斜率得到相关的函数关系式（夹角的余弦） + 1 = 8 / 3 (（当前夹角对应的缩放值） - 0.25)
        // 根据这个公式就可以计算出各个夹角位置的缩放量
        let scaleXY = 3 * (cosf(Float(CGFloat(indexPath.row) * circleAngle) + offsetAngle) + 1) / 8 + 0.25;
        
        trans3D = CATransform3DScale(trans3D, CGFloat(scaleXY), CGFloat(scaleXY), 1.0);
        
        atti.transform3D = trans3D;
        
        // 设置每个item的index，根据近端能够遮住远端的规则，而zindex规则时越大的遮住越小的
        // 根据余弦函数的特性，1～-1～1，可以实现近端的余弦值比远端的余弦值大，实现相应的zindex排序
        atti.zIndex = Int(cosf(Float(CGFloat(indexPath.row) * circleAngle) + offsetAngle) + Float(1));
        
        return atti;
    }
    
    /// 设置collectionview内容的区域大小
    override var collectionViewContentSize: CGSize{
        get{
//            return CGSize(width: Int((self.collectionView?.frame.size.width)!), height: Int((self.collectionView?.frame.height)!) * (self.collectionView?.numberOfItems(inSection: 0))!);
            AnnulusLayout.sContentWidth = Int((self.collectionView?.frame.size.width)!);
            return CGSize(width: Int(Int((self.collectionView?.frame.size.width)!) * ((self.collectionView?.numberOfItems(inSection: 0))! + 2)), height: 0);
        }
    }
    
    /// 一有偏移就调用是否刷新
    ///
    /// - Parameter newBounds: 新的区域
    /// - Returns: 返回true表示刷新，返回false表示不刷新
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true;
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        let itemIndex = Int((self.collectionView?.contentOffset.x)! / (self.collectionView?.frame.size.width)!);
        let leftOffset = CGFloat(itemIndex) * (self.collectionView?.frame.size.width)!;
        let rightOffset = CGFloat(itemIndex + 1) * (self.collectionView?.frame.size.width)!;
        print("leftOffset is \(leftOffset), rightOffset is \(rightOffset)");
        
        if fabsf(Float(proposedContentOffset.x) - Float(leftOffset)) > fabsf(Float(rightOffset) - Float(proposedContentOffset.x)) {
            mCurItemIndex = itemIndex + 1;
            return CGPoint(x: rightOffset, y: proposedContentOffset.y);
        }
        
        mCurItemIndex = itemIndex;
        return CGPoint(x: leftOffset, y: proposedContentOffset.y);
    }
}
