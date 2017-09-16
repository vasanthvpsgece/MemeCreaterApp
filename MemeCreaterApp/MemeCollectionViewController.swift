//
//  MemeCollectionViewController.swift
//  MemeCreaterApp
//
//  Created by Vasantha kumar Vijaya kumar on 9/9/17.
//  Copyright © 2017 Vasantha kumar. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {

    @IBOutlet var savedMemeCollectionView: UICollectionView!
    var sharedMeme = [Meme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savedMemeCollectionView.delegate = self
        savedMemeCollectionView.dataSource = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MemeCollectionViewController.createMeme))
        
    }

    func createMeme() {
        if let navigationController = self.navigationController {
            let detailController = self.storyboard!.instantiateViewController(withIdentifier: "memeCreater")
            navigationController.pushViewController(detailController, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sharedMeme = (UIApplication.shared.delegate as! AppDelegate).memes
        self.savedMemeCollectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sharedMeme.count
    }
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as! MemeCollectionViewCell
        let sharedMemeImg = self.sharedMeme[(indexPath as NSIndexPath).row]
        
        cell.cellImageView.image = sharedMemeImg.memedImage
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "savedMemeImg") as! ShowMemeCollectionViewController
        (UIApplication.shared.delegate as! AppDelegate).index = indexPath
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
