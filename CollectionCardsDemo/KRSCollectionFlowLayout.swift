//
//  KRSCollectionFlowLayout.swift
//  CollectionCardsDemo
//
//  Created by Karam on 29/03/19.
//  Copyright © 2019 Karam. All rights reserved.
//

import UIKit
class KRSCollectionFlowLayout: UICollectionViewFlowLayout {
    
    let activeDistance: CGFloat = 200
    let translation: CGFloat = -20
    
    override init() {
        super.init()
        
        scrollDirection = .horizontal
        minimumLineSpacing = 40
        itemSize = CGSize(width: 150, height: 150)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        scrollDirection = .horizontal
        
    }
    
    
    override func prepare() {
        guard let collectionView = collectionView else { fatalError() }
        let verticalInsets = (collectionView.frame.height - collectionView.adjustedContentInset.top - collectionView.adjustedContentInset.bottom - itemSize.height) / 2
        let horizontalInsets = (collectionView.frame.width - collectionView.adjustedContentInset.right - collectionView.adjustedContentInset.left - itemSize.width) / 2
        sectionInset = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)
        
        super.prepare()
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        let rectAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }



        let visibleRect = CGRect(origin: collectionView.contentOffset, size: CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height - 40))

        for attributes in rectAttributes where attributes.frame.intersects(visibleRect) {

            let width = collectionView.frame.width
            let centerX = width / 2
            let offset = collectionView.contentOffset.x
            let itemX = attributes.center.x - offset
            
             let position = (itemX - centerX) / width
            
            
            if abs(position) >= 1 {
                attributes.transform = .identity
            } else {
                 let translationY = -min(0 - abs(position * 20), 20)
              //  print("Position Value :\(scale) and position:\(position)" )
                attributes.transform = CGAffineTransform(translationX: 0, y: translationY)
            }
        }
        return rectAttributes
    }
   
    
    

   
    
    
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return .zero }
        
        
        
        
        // Add some snapping behaviour so that the zoomed cell is always centered
        let targetRect = CGRect(x: proposedContentOffset.x, y:20, width: collectionView.frame.width, height: collectionView.frame.height)
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }
        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2
        
        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    
    
    
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }
    
}



