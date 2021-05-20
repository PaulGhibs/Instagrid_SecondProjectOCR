//
//  Blur.swift
//  P4_01_Xcode
//
//  Created by Paul Ghibeaux on 20/05/2021.
//

import UIKit

class BlurView: UIView {
    
    func blurView(view: UIView) {
        blur(view: view)
        unBlur(view: view)
    }
    
    private let blurOverlay = UIVisualEffectView()
    
    private func blur(view: UIView) {
        self.blurOverlay.frame = view.bounds
        view.addSubview(self.blurOverlay)
        UIView.animate(withDuration: 0.3) {
        self.blurOverlay.effect = UIBlurEffect(style: .dark)
        }
    }
    
    private func unBlur(view: UIView) {
        UIView.animate(withDuration: 0.5, animations: {
            self.blurOverlay.effect = UIBlurEffect()
        }) { (finished: Bool) in
            self.blurOverlay.removeFromSuperview()
        }
    }
    
}
