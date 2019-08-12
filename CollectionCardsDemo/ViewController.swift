//
//  ViewController.swift
//  CollectionCardsDemo
//
//  Created by Karam on 29/03/19.
//  Copyright © 2019 Karam. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
   
    
    
    
    
   
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionViewFlowLayout: KRSCollectionFlowLayout!
   
    let cellPercentWidth: CGFloat = 0.7

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewFlowLayout = (collectionView.collectionViewLayout as! KRSCollectionFlowLayout)
        
        // Modify the collectionView's decelerationRate (REQURED)
       // collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        
        
        // Configure the required item size (REQURED)
        collectionViewFlowLayout.itemSize = CGSize(
            width: collectionView.bounds.size.width - 80,
            height: collectionView.bounds.size.width - 40
        )
        
        // Configure the optional inter item spacing (OPTIONAL)
        collectionViewFlowLayout.minimumLineSpacing = 20
        collectionViewFlowLayout.minimumInteritemSpacing = 20
        
        
        
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath)
        return cell
    }

 
    

}

