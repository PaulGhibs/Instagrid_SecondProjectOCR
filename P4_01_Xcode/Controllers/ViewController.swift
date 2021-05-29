//
//  ViewController.swift
//  P4_01_Xcode
//
//  Created by Paul Ghibeaux on 13/05/2021.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    
    
    /// MARK: - Property
    
    var picture: UIButton!
    var swipeUp: UISwipeGestureRecognizer?
    
    /// MARK: - Outlets

    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var grids: UIView!
    
    @IBOutlet var addPhoto: [UIButton]!
    @IBOutlet var layoutChoice: [UIButton]!
 
    @IBOutlet weak var selectFirstlayout: UIImageView!
    @IBOutlet weak var selectSecondLayout: UIImageView!
    @IBOutlet weak var selectThirdLayout: UIImageView!
    
    
    /// MARK: - Actions
    
     
    @IBAction func addPhotoAction(_ sender: UIButton) {
    }
    
    @IBAction func layoutAction(_ sender: UIButton) {
    }
    
    /// MARK: - Functions
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(shareSwipe))
        
        
    }
    
    
    
    // func for showing the grids available
    private func makeTheGrid(withLayoutChoice: UIButton) {
        switch withLayoutChoice {
        case layoutChoice[0]:
            addPhoto[1].isHidden = false
            addPhoto[3].isHidden = false
        case layoutChoice[1]:
            addPhoto[1].isHidden = false
            addPhoto[3].isHidden = true
        case layoutChoice[2]:
            addPhoto[1].isHidden = true
            addPhoto[1].isHidden = false
        default: break
            
        }
    }
  
    // Function to display or not the selected button above the layout button
    private func selectedButton(withLayoutChoice : UIButton) {
        switch withLayoutChoice {
        case layoutChoice[0] :
            selectFirstlayout.isHidden = false
            selectSecondLayout.isHidden = true
            selectThirdLayout.isHidden = true
        case layoutChoice[1] :
            selectSecondLayout.isHidden = true
            selectFirstlayout.isHidden = true
            selectThirdLayout.isHidden = false
        case layoutChoice[2] :
            selectThirdLayout.isHidden = true
            selectFirstlayout.isHidden = false
            selectSecondLayout.isHidden = true
        default: break
        }
    }
    
    
    
    // share
    
    @objc func shareSwipe() {
        let transform : CGAffineTransform
        if swipeUp?.direction == .up {
            transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height)
        } else {
            transform = CGAffineTransform(translationX: -UIScreen.main.bounds.height, y: -UIScreen.main.bounds.height)
        }
        
        UIView.animate(withDuration: 1, animations: {[self] in
            grids.transform = transform
            
        }, completion: {_ in
            self.imageRender()
            
        })
    }

    
    func imageRender(){
        
        
    }
    
    // Function to transform the UIView into an UIImage, in order to share the UIImage
    private func imageView (view: UIView) -> UIImage {
        let image = UIGraphicsImageRenderer ( size: grids.bounds.size )
        return image.image { _ in grids.drawHierarchy(in: grids.bounds, afterScreenUpdates: true) }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let photo = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        picture.setImage(photo, for: .normal)
        picture.imageView?.contentMode = .scaleAspectFill
        picker.dismiss(animated: true, completion: nil)
    }
    
    

}


    
    
    
