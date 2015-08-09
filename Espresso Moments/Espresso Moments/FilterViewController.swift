//
//  FilterViewController.swift
//  Espresso Moments
//
//  Created by WiLL on 8/3/15.
//  Copyright (c) 2015 Harvard. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    var thisFeedItem: FeedItem?
    var collectionView: UICollectionView!
    
    let kIntensity = 0.7
    var context: CIContext = CIContext(options: nil)
    var filters: [CIFilter] = []
    let placeHolderImage = UIImage(named: "Placeholder")
    
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
        
        filters = photoFilters()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UICollectionViewDataSource - required functions to implement for protocol
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: FilterCell = collectionView.dequeueReusableCellWithReuseIdentifier("MyCell", forIndexPath: indexPath) as! FilterCell
        
        if cell.imageView.image == nil {  //create the placeholder only if it does not exist
            
            //cell.imageView.image = UIImage(named: "Placeholder")
            cell.imageView.image = placeHolderImage
            
            //create queue
            //cell.imageView.image = filteredImageFromImage(thisFeedItem.image, filter: filters[indexPath.row])
            let filterQueue: dispatch_queue_t = dispatch_queue_create("filter queue", nil)
            
            
            //tell queue what code to run
            dispatch_async(filterQueue, { () -> Void in
                //if self.thisFeedItem != nil {
                    let filterImage = self.filteredImageFromImage(self.thisFeedItem!.thumbNail, filter: self.filters[indexPath.row])
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        cell.imageView.image = filterImage
                    })
                //}
                
            })
            
        }
        /*
        //issue below
        cell.imageView.image = filteredImageFromImage(thisFeedItem.image, filter: filters[indexPath.row]) as? UIImage
        */
        
        return cell
    }
    
    //CIFilter - helper functions
    func photoFilters() -> [CIFilter] {
        //Create CIFilter instances
        
        /*
        
        let blur = CIFilter(name:  "CIGaussianBlur")
        let instant = CIFilter(name:  "CIPhotoEffectInstant")
        let noir = CIFilter(name:  "CIPhotoEffectNoir")
        //let tone = CIFilter(name:  "CIToneCurve")
        let transfer = CIFilter(name: "CIPhotoEffectTransfer")
        //let unsharpen = CIFilter(name: "CIUnsharpMask")
        let monochrome = CIFilter(name: "CIColorMonochrome")
        
        //advance filters - adjust attributes
        let colorControls = CIFilter(name: "CIColorControls")
        colorControls.setValue(0.5, forKey: kCIInputSaturationKey)
        
        let sepia = CIFilter(name: "CISepiaTone")
        sepia.setValue(kIntensity, forKey: kCIInputIntensityKey)
        
        let colorClamp = CIFilter(name: "CIColorClamp")
        colorClamp.setValue(CIVector(x: 0.9, y:0.9, z:0.9, w:0.9), forKey: "inputMaxComponents")
        colorClamp.setValue(CIVector(x: 0.2, y:0.2, z:0.2, w:0.2), forKey: "inputMinComponents")
        
        //combo filters - outputImage from filter
        let composite = CIFilter(name: "CIHardLightBlendMode")
        composite.setValue(sepia.outputImage, forKey: kCIInputImageKey)
        
        let vignette = CIFilter(name: "CIVignette")
        vignette.setValue(composite.outputImage, forKey: kCIInputImageKey)
        
        //set additional properties
        vignette.setValue(kIntensity*2, forKey: kCIInputIntensityKey)
        vignette.setValue(kIntensity*30, forKey: kCIInputRadiusKey)
    
        //Add each filter element to array
        return [blur,instant,noir,transfer, monochrome,colorControls, sepia, colorClamp,composite,vignette]
        */
        
        let blur = CIFilter(name: "CIGaussianBlur")
        
        let instant = CIFilter(name: "CIPhotoEffectInstant")
        
        let noire = CIFilter(name: "CIPhotoEffectNoir")
        
        let transfer = CIFilter(name: "CIPhotoEffectTransfer")
        
        let unsharpen = CIFilter(name: "CIUnsharpMask")
        
        let monochrome = CIFilter(name: "CIColorMonochrome")
        
        let colorControls = CIFilter(name: "CIColorControls")
        
        colorControls.setValue(0.5, forKey: kCIInputSaturationKey)
        
        let sepia = CIFilter(name: "CISepiaTone")
        sepia.setValue(kIntensity, forKey: kCIInputIntensityKey)
        
        let colorClamp = CIFilter(name: "CIColorClamp")
        colorClamp.setValue(CIVector(x: 0.9, y: 0.9, z: 0.9, w: 0.9), forKey: "inputMaxComponents") //max we can have for RGBa
        //these things are being typedef here therefore use 'forKey' with input string
        colorClamp.setValue(CIVector(x: 0.2, y: 0.2, z: 0.2, w: 0.2), forKey: "inputMinComponents")
        
        //real nice way to use a constant as there will be less errors from above
        
        //composite filter
        let composite = CIFilter(name: "CIHardLightBlendMode")
        composite.setValue(sepia.outputImage, forKey: kCIInputImageKey) //get output image from 'sepia' filter here
        //as it will do conversion based on image.  The kCIInputImageKey allows us to import the 'outputImage' from previous filter.  Now this filter will be the composition of both the 'CIHardLightBlendMode' with the 'sepia'
        
        //composite + vignette
        let vignette = CIFilter(name: "CIVignette")
        vignette.setValue(composite.outputImage, forKey: kCIInputImageKey)
        
        //can make additional changes to vignette
        vignette.setValue(kIntensity * 2, forKey: kCIInputIntensityKey)
        vignette.setValue(kIntensity * 30, forKey: kCIInputRadiusKey) //distance from center where change will occur
        
        //each one of the CI Filters tell you which attributes you can change
        //add each one of our elements into our array here
        
        let availableFilters: [CIFilter] = [blur, instant, noire, transfer, unsharpen, monochrome, colorControls, sepia, colorClamp, composite, vignette]
        
        return availableFilters
        //[blur, instant, noire, transfer, unsharpen, monochrome, colorControls, sepia, colorClamp, composite, vignette] //need a helper function to use the returned array
    }
    
    func filteredImageFromImage (imageData: NSData, filter: CIFilter) -> UIImage {
        let unfilteredImage = CIImage(data: imageData)
        filter.setValue(unfilteredImage, forKey: kCIInputImageKey)
        
        //Create new image with filter
        let filteredImage:CIImage = filter.outputImage
        
        //create optimized UIImage
        let extent = filteredImage.extent()
        
        let cgImage: CGImageRef = context.createCGImage(filteredImage, fromRect: extent)
        
        let finalImage = UIImage(CGImage: cgImage, scale: 1.0, orientation: UIImageOrientation.Up)!
        //let finalImage = UIImage(CIImage: filteredImage)!
        
        return finalImage
    }

}
