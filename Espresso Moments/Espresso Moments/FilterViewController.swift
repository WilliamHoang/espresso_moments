//
//  FilterViewController.swift
//  Espresso Moments
//
//  Created by WiLL on 8/3/15.
//  Copyright (c) 2015 Harvard. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    var thisFeedItem: FeedItem!
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        //size of cell(s)
        layout.itemSize = CGSize(width: 150.0, height: 150.0)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = UIColor.whiteColor()
        
        //setup reuse identifier
        collectionView.registerClass(FilterCell.self, forCellWithReuseIdentifier: "MyCell")
        
        self.view.addSubview(collectionView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UICollectionViewDataSource - required functions to implement for protocol
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: FilterCell = collectionView.dequeueReusableCellWithReuseIdentifier("MyCell", forIndexPath: indexPath) as! FilterCell
        
        cell.imageView.image = UIImage(named: "Placeholder")
        
        return cell
    }
    
    //CIFilter - helper functions
    func photoFilters() -> [CIFilter] {
        //Create CIFilter instances
        
        let blur = CIFilter(name:  "CIGaussianBlur")
        let instant = CIFilter(name:  "CIPhotoEffectInstant")
        let noir = CIFilter(name:  "CIPhotoEffectNoir")
        let tone = CIFilter(name:  "CIToneCurve")
        let transfer = CIFilter(name: "CIPhotoEffectTransfer")
        let unsharpen = CIFilter(name: "CIUnsharpMask")
        let monochrome = CIFilter(name: "CIColorMonochrome")
        
        return []
    }

}
