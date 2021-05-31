//
//  ViewController.swift
//  P4_01_Xcode
//
//  Created by Paul Ghibeaux on 13/05/2021.
//

import UIKit

class ViewController: UIViewController {
        
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
}


    
    
    
