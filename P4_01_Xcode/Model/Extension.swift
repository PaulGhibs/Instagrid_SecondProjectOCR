//
//  Extension.swift
//  P4_01_Xcode
//
//  Created by Paul Ghibeaux on 31/05/2021.
//

import Foundation
import UIKit

// MARK: - Property

var picture: UIButton!
var swipeUp: UISwipeGestureRecognizer?

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    /// Importing and rendering the picture from gallery
    @objc func orientation() {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            swipeUp?.direction = .left
        } else {
            swipeUp?.direction = .up
        }
    }
    // func to import pict from galery
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        picture.setImage(photo, for: .normal)
        picture.imageView?.contentMode = .scaleAspectFill
        picker.dismiss(animated: true, completion: nil)
    }
    // Function to transform the UIView into an UIImage, in order to share the UIImage
    private func imageView (view: UIView) -> UIImage {
        let image = UIGraphicsImageRenderer( size: grids.bounds.size )
        return image.image { _ in grids.drawHierarchy(in: grids.bounds, afterScreenUpdates: true) }
    }
    /// Share View Controller
    // share function with transform of swip stack wiew
    @objc func shareSwipe() {
        let transform: CGAffineTransform
        if swipeUp?.direction == .up { transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height)
        } else {
            transform = CGAffineTransform(translationX: -UIScreen.main.bounds.height, y: -UIScreen.main.bounds.height)
        }
        UIView.animate(withDuration: 1, animations: {[self] in
            grids.transform = transform
        }, completion: {_ in
            self.showActivityControl()
        })
    }
    // show activity controller to share the grid
     func showActivityControl() {
        let gridToShare = [imageView(view: grids)]
        let activityController = UIActivityViewController(activityItems: gridToShare, applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = view
        present(activityController, animated: true)
        activityController.completionWithItemsHandler = { _, _, _, _ in
            UIView.animate(withDuration: 0.5) {self.grids.transform = .identity}
        }
    }
}
