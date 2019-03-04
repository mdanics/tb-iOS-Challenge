//
//  EditingView.swift
//  TouchBistroChallenge
//
//  Created by Matthew Danics on 2019-03-02.
//  Copyright © 2019 Matthew Danics. All rights reserved.
//

import UIKit

class EditingScreen: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var imagePreview: UIImageView!
    
    @IBOutlet weak var priceTextLabel: UILabel!
    @IBOutlet weak var priceTextField: UITextField!
    
    
    var imagePicker = UIImagePickerController()

    var referrer: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        
        // depending on which view triggered this editing view, conditionally display the price field
        if (referrer == "group") {
            priceTextField.isHidden = true
            priceTextLabel.isHidden = true
        } else if (referrer == "items"){
            priceTextField.isHidden = false
            priceTextLabel.isHidden = false
        }
    }


    @IBAction func pickImageButton(_ sender: Any) {
        pickImage()
    
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
       
        // ensure that an image has been selected
        if (imagePreview.image == nil) {
            
            let alert = UIAlertController(title: "Make sure an image is selected!", message: "", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default)
            alert.addAction(ok)
            
            self.present(alert, animated: true)
            
        } else {
            // image has been selected
            if (referrer == "group"){
                self.performSegue(withIdentifier: "unwindToMenuGroup", sender: self)
            } else if (referrer == "items"){
                print("tapped addBtn")
                self.performSegue(withIdentifier: "unwindToMenuItems", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // callback to the appropriate referring view with the user submitted data
        if (referrer == "group"){
            let destViewCtrl = segue.destination as! MenuGroupList
            
            destViewCtrl.addMenuGroup(title: titleTextField.text as String!, image: imagePreview.image as UIImage!)
        } else if (referrer == "items"){
            let destViewCtrl = segue.destination as! MenuItemsList
            
            destViewCtrl.addMenuItem(title: titleTextField.text as String!, image: imagePreview.image as UIImage!, price: priceTextField.text as String!)
        }
    
    }
    
    func pickImage() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true)
        
    }
    
}


extension EditingScreen: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        imagePreview.image = info[.editedImage] as? UIImage
        imagePicker.dismiss(animated: true)
    }
}

