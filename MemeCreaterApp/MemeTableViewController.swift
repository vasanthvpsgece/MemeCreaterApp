//
//  MemeTableViewController.swift
//  MemeCreaterApp
//
//  Created by Vasantha kumar Vijaya kumar on 9/7/17.
//  Copyright © 2017 Vasantha kumar. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var savedMemeTableView: UITableView!
    var sharedMeme = [Meme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savedMemeTableView.delegate = self
        savedMemeTableView.dataSource = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MemeTableViewController.createMeme))
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
        self.savedMemeTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sharedMeme.count
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sharedMeme")!
        let sharedMemeImg = self.sharedMeme[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = sharedMemeImg.topText
        cell.imageView?.image = sharedMemeImg.memedImage
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "savedMemeImg") as! ShowMemeCollectionViewController
        (UIApplication.shared.delegate as! AppDelegate).index = indexPath
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
}
