//
//  MemeImagePickerDelegate.swift
//  MemeCreaterApp
//
//  Created by Vasantha kumar Vijaya kumar on 8/12/17.
//  Copyright © 2017 Vasantha kumar. All rights reserved.
//

import Foundation
import UIKit

extension MemeViewController: UIImagePickerControllerDelegate {
    
    func chooseImg(_ srcType: UIImagePickerControllerSourceType) {
        let imgController = UIImagePickerController()
        imgController.delegate = self
        imgController.sourceType = srcType
        self.present(imgController, animated: true, completion: nil)
    }
    
    // Delegate functions for UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageViewer.image = image
            shareButton.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
