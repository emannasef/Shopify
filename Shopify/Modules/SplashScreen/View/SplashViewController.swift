//
//  SplashViewController.swift
//  Shopify
//
//  Created by Moaz Khaled on 25/06/2023.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

        private var animationView: LottieAnimationView?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
             animationView = .init(name: "shopifySplash")
             animationView!.frame = view.bounds
             animationView!.contentMode = .scaleAspectFit
             animationView!.loopMode = .loop
             animationView!.animationSpeed = 0.8
             view.addSubview(animationView!)
             animationView!.play()


            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4){
                self.performSegue(withIdentifier: "OpenAuth", sender: nil)
            }
            
        
    }
    

    

}
