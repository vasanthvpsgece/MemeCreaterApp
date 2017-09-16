//
//  ShowMemeCollectionViewController.swift
//  MemeCreaterApp
//
//  Created by Vasantha kumar Vijaya kumar on 9/14/17.
//  Copyright © 2017 Vasantha kumar. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ShowMemeCollectionViewController: UICollectionViewController {
    
    
    @IBOutlet var showMemeCollectionView: UICollectionView!
    var sharedMeme = [Meme]()
    var layout: UICollectionViewFlowLayout! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        layout = showMemeCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sharedMeme = (UIApplication.shared.delegate as! AppDelegate).memes
        let index = (UIApplication.shared.delegate as! AppDelegate).index
        
        orientationDidChange(.init(name: .UIDeviceOrientationDidChange, object: nil, userInfo: nil))
        
        self.showMemeCollectionView.reloadData()
        showMemeCollectionView.selectItem(at: index, animated: true, scrollPosition: .centeredHorizontally)
        
        subscribeToChangeOrientation()


    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromChangeOrientation()

    }

    func orientationDidChange(_ notification: Notification) {
        layout.itemSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
        showMemeCollectionView!.collectionViewLayout.invalidateLayout()
    }
    
    func subscribeToChangeOrientation() {
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange(_:)), name: .UIDeviceOrientationDidChange, object: nil)
    }
    
    func unsubscribeFromChangeOrientation() {
        
        NotificationCenter.default.removeObserver(self, name: .UIDeviceOrientationDidChange, object: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sharedMeme.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as! ShowMemeCollectionViewCell
        let sharedMemeImg = self.sharedMeme[(indexPath as NSIndexPath).row]
        
        cell.showMemeImg.image = sharedMemeImg.memedImage
        
        return cell
    }
}
