//
//  ViewController.swift
//  MemeCreaterApp
//
//  Created by Vasantha kumar Vijaya kumar on 8/6/17.
//  Copyright © 2017 Vasantha kumar. All rights reserved.
//

import UIKit

// Defining structure object


class MemeViewController: UIViewController, UINavigationControllerDelegate {

    // Outlets for all storyboard elements
    @IBOutlet weak var imageViewer: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setting up default value for top and bottom text field. Also setting up delegate for top and bottom text field
        configureTextField(topTextField, "TOP")
        configureTextField(bottomTextField, "BOTTOM")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Disabling the Share activity button if there is no image loaded to edit
        if imageViewer.image == nil {
            shareButton.isEnabled = false
        }
        
        // Disabling the camera button if the target device does not have in-built camera source
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }


    // Image picker controller for photo library
    
    func configureTextField(_ textField: UITextField, _ withText: String) {
        
        let memeTextAttributes: [String:Any] = [
            NSStrokeColorAttributeName: UIColor.black,
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -3]
        
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.borderStyle = .none
        textField.text = withText
    
    }
    
    @IBAction func imagePicker(_ sender: Any) {
        chooseImg(.photoLibrary)
    }
    
    // Image picker controller for camera
    
    @IBAction func imageCamera(_ sender: Any) {
        chooseImg(.camera)
    }
        
    // Subscribe to keyboard notification to change the height of the view if keyboard appears and disappears
    
    func subscribeToKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        
        if self.bottomTextField.isEditing == true {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    // Function to get keyboard height
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    // Action to be performed if the share button is clicked
    
    @IBAction func shareButtonClicked(_ sender: Any) {
        
        let image = saveMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { activityType, completed, returnedItems, activityError in
        if completed {
            self.save(image)
            self.dismiss(animated: true, completion: nil)
        }
    }
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    func saveMemedImage () -> UIImage {
        
        navBarToolBarHide(true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        navBarToolBarHide(false)
        
        return memedImage
    }
    
    // Hiding the Navigation bar and Tool bar temporarily to capture the memed image
    
    func navBarToolBarHide(_ hidden: Bool) {
        self.navigationController?.setToolbarHidden(hidden, animated: true)
        self.navigationController?.setNavigationBarHidden(hidden, animated: false)
    }
    
    // Clicling cancel button will clear the image and entered text in top and bottom text field and disable the share button since the image is cleared
    
    @IBAction func cancelMeme(_ sender: Any) {
        imageViewer.image = nil
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        shareButton.isEnabled = false
    }
    
    func save(_ memedImg: UIImage) {
        
        if topTextField.text != nil && bottomTextField.text != nil && imageViewer.image != nil {
            let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageViewer.image!, memedImage: memedImg)
            
            (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
        }
    }
}

