//
//  MemeTableViewController.swift
//  MemeCreaterApp
//
//  Created by Vasantha kumar Vijaya kumar on 9/7/17.
//  Copyright © 2017 Vasantha kumar. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let sharedMeme = (UIApplication.shared.delegate as! AppDelegate).memes
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sharedMeme.count
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sharedMeme")
        let sharedMemeImg = self.sharedMeme[(indexPath as NSIndexPath).row]
        
        cell?.textLabel?.text = sharedMemeImg.topText
        cell?.imageView?.image = sharedMemeImg.memedImage
     
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "SavedMemeImg") as! ShowMemeViewController
        detailController.savedMeme = self.sharedMeme[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
