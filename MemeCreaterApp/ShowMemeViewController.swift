//
//  ShowMemeViewController.swift
//  MemeCreaterApp
//
//  Created by Vasantha kumar Vijaya kumar on 9/7/17.
//  Copyright © 2017 Vasantha kumar. All rights reserved.
//

import UIKit

class ShowMemeViewController: UIViewController {

    var savedMeme: Meme! = nil
    @IBOutlet weak var showMemeImg: UIImageView!
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showMemeImg.image = UIImage(named: savedMeme.topText)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

}
