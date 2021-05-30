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
    @IBOutlet weak var swipeView: UIStackView!
    @IBOutlet weak var grids: UIView!
    @IBOutlet var addPhoto: [UIButton]!
    @IBOutlet var layoutChoice: [UIButton]!
    @IBOutlet weak var selectFirstlayout: UIImageView!
    @IBOutlet weak var selectSecondLayout: UIImageView!
    @IBOutlet weak var selectThirdLayout: UIImageView!
    
    /// MARK: - Actions
    @IBAction func addPhotoAction(_ sender: UIButton) {
        picture = sender
        let picker = UIImagePickerController()
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }

    @IBAction func layoutAction(_ sender: UIButton) {
        makeTheGrid(withLayoutChoice: sender)
        selectedLayout(withLayoutChoice: sender)
    }
    
    /// MARK: - Functions
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(shareSwipe))
        grids.addGestureRecognizer(swipeUp!)
        NotificationCenter.default.addObserver(self, selector: #selector(orientation), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
  
    @objc func orientation() {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            swipeUp?.direction = .left
        } else {
            swipeUp?.direction = .up
        }
    }

    /// functions for binding  layouts and grids
    // func for showing the grids available
    private func makeTheGrid(withLayoutChoice: UIButton) {
        switch withLayoutChoice {
        case layoutChoice[0]:
            addPhoto[1].isHidden = false
            addPhoto[3].isHidden = true
        case layoutChoice[1]:
            addPhoto[1].isHidden = true
            addPhoto[3].isHidden = false
        case layoutChoice[2]:
            addPhoto[1].isHidden = false
            addPhoto[3].isHidden = false
        default: break
            
        }
    }
    // func to display or not the selected button above the layout button
    private func selectedLayout(withLayoutChoice : UIButton) {
        switch withLayoutChoice {
        case layoutChoice[0] :
            selectThirdLayout.isHidden = false
            selectFirstlayout.isHidden = true
            selectSecondLayout.isHidden = true
            
        case layoutChoice[1] :
            selectSecondLayout.isHidden = false
            selectFirstlayout.isHidden = true
            selectThirdLayout.isHidden = true
            
        case layoutChoice[2] :
            selectFirstlayout.isHidden = false
            selectSecondLayout.isHidden = true
            selectThirdLayout.isHidden = true
        default: break
        }
    }
    
    
    /// Importing and rendering the picture from gallery
    
    // func to import pict from galery
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let photo = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        picture.setImage(photo, for: .normal)
        picture.imageView?.contentMode = .scaleAspectFill
        picker.dismiss(animated: true, completion: nil)
    }
    // Function to transform the UIView into an UIImage, in order to share the UIImage
    private func imageView (view: UIView) -> UIImage {
        let image = UIGraphicsImageRenderer ( size: grids.bounds.size )
        return image.image { _ in grids.drawHierarchy(in: grids.bounds, afterScreenUpdates: true) }
    }
    
    /// Share View Controller
    // share function with transform of swip stack wiew
    
    @objc func shareSwipe() {
        let transform : CGAffineTransform
        if swipeUp?.direction == .up { transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height) } else { transform = CGAffineTransform(translationX: -UIScreen.main.bounds.height, y: -UIScreen.main.bounds.height) }
        UIView.animate(withDuration: 1, animations: {[self] in
            grids.transform = transform
        }, completion: {_ in
            self.shareSwipe()
        })
    }
    // show activity controller to share the grid
    func showActivityControl() {
        let gridToShare = [imageView(view: grids)]
        let activityController = UIActivityViewController(activityItems: gridToShare, applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = view
        present(activityController, animated: true, completion: nil)
        activityController.completionWithItemsHandler = { _, _, _, _ in
            UIView.animate(withDuration: 0.5) {self.grids.transform = .identity}
        }
    }

}


    
    
    
